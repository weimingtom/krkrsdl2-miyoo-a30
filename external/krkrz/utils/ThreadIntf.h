//---------------------------------------------------------------------------
/*
	TVP2 ( T Visual Presenter 2 )  A script authoring tool
	Copyright (C) 2000 W.Dee <dee@kikyou.info> and contributors

	See details of license at "license.txt"
*/
//---------------------------------------------------------------------------
// Thread base class
//---------------------------------------------------------------------------
#ifndef ThreadIntfH
#define ThreadIntfH
#include "tjsNative.h"

#ifdef KRKRZ_USE_SDL_THREADS
#include <SDL.h>
#else
#if (!defined(__EMSCRIPTEN__)) || (defined(__EMSCRIPTEN__) && defined(__EMSCRIPTEN_PTHREADS__))
#include <thread>
#include <condition_variable>
#include <mutex>
#include <atomic>
#endif
#ifdef __MACH__
#include <mach/thread_policy.h>
#include <mach/thread_act.h>
#endif
#endif

//---------------------------------------------------------------------------
// tTVPThreadPriority
//---------------------------------------------------------------------------
enum tTVPThreadPriority
{
	ttpIdle, ttpLowest, ttpLower, ttpNormal, ttpHigher, ttpHighest, ttpTimeCritical
};
//---------------------------------------------------------------------------


//---------------------------------------------------------------------------
// tTVPThread
//---------------------------------------------------------------------------
class tTVPThread
{
protected:
#ifdef KRKRZ_USE_SDL_THREADS
	SDL_Thread* Thread;
	SDL_threadID ThreadId;
#else
#if (!defined(__EMSCRIPTEN__)) || (defined(__EMSCRIPTEN__) && defined(__EMSCRIPTEN_PTHREADS__))
	std::thread* Thread;
#else
	void* Thread;
#endif
#endif
private:
	bool Terminated;

#ifdef KRKRZ_USE_SDL_THREADS
	SDL_mutex *Mtx;
	SDL_cond *Cond;
#else
#if (!defined(__EMSCRIPTEN__)) || (defined(__EMSCRIPTEN__) && defined(__EMSCRIPTEN_PTHREADS__))
	std::mutex Mtx;
	std::condition_variable Cond;
#endif
#endif
	bool ThreadStarting;

#ifdef KRKRZ_USE_SDL_THREADS
	static int StartProc(void * arg);
#else
	void StartProc();
#endif

public:
	tTVPThread();
	virtual ~tTVPThread();

	bool GetTerminated() const { return Terminated; }
	void SetTerminated(bool s) { Terminated = s; }
	void Terminate() { Terminated = true; }

protected:
	virtual void Execute() {}

public:
	void StartTread();
#ifdef KRKRZ_USE_SDL_THREADS
	void WaitFor() { if (Thread) SDL_WaitThread(Thread, nullptr); Thread = nullptr; }
#else
#if defined(__EMSCRIPTEN__) && !defined(__EMSCRIPTEN_PTHREADS__)
	void WaitFor() {}
#else
	void WaitFor() { if (Thread && Thread->joinable()) { Thread->join(); } }
#endif
#endif

#ifdef KRKRZ_USE_SDL_THREADS
	SDL_ThreadPriority _Priority;
#endif
	tTVPThreadPriority GetPriority();
	void SetPriority(tTVPThreadPriority pri);

#ifdef KRKRZ_USE_SDL_THREADS
	SDL_Thread* GetHandle() const { return Thread; }
	SDL_threadID GetThreadId() const { if (ThreadId) return ThreadId; else return SDL_ThreadID(); }
#else
#if (!defined(__EMSCRIPTEN__)) || (defined(__EMSCRIPTEN__) && defined(__EMSCRIPTEN_PTHREADS__))
	std::thread::native_handle_type GetHandle() { if(Thread) return Thread->native_handle(); else return (std::thread::native_handle_type)NULL; }
	std::thread::id GetThreadId() { if(Thread) return Thread->get_id(); else return std::thread::id(); }
#endif
#endif
};
//---------------------------------------------------------------------------


//---------------------------------------------------------------------------
// tTVPThreadEvent
//---------------------------------------------------------------------------
class tTVPThreadEvent
{
#ifdef KRKRZ_USE_SDL_THREADS
	SDL_mutex *Mtx;
	SDL_cond *Cond;
#else
#if (!defined(__EMSCRIPTEN__)) || (defined(__EMSCRIPTEN__) && defined(__EMSCRIPTEN_PTHREADS__))
	std::mutex Mtx;
	std::condition_variable Cond;
#endif
#endif
	bool IsReady;

public:
	tTVPThreadEvent() : IsReady(false)
	{
#ifdef KRKRZ_USE_SDL_THREADS
		Mtx = SDL_CreateMutex();
		Cond = SDL_CreateCond();
#endif
	}
	virtual ~tTVPThreadEvent()
	{
#ifdef KRKRZ_USE_SDL_THREADS
		SDL_DestroyCond(Cond);
		SDL_DestroyMutex(Mtx);
#endif
	}

	void Set() {
#ifdef KRKRZ_USE_SDL_THREADS
		SDL_LockMutex(Mtx);
		IsReady = true;
		SDL_CondBroadcast(Cond);
		SDL_UnlockMutex(Mtx);
#else
#if (!defined(__EMSCRIPTEN__)) || (defined(__EMSCRIPTEN__) && defined(__EMSCRIPTEN_PTHREADS__))
		{
			std::lock_guard<std::mutex> lock(Mtx);
			IsReady = true;
		}
		Cond.notify_all();
#endif
#endif
	}
	/*
	void Reset() {
		std::lock_guard<std::mutex> lock(Mtx);
		IsReady = false;
	}
	*/
	bool WaitFor( tjs_uint timeout ) {
#ifdef KRKRZ_USE_SDL_THREADS
		SDL_LockMutex(Mtx);
		if( timeout == 0 ) {
			while (!IsReady) {
				SDL_CondWait(Cond, Mtx);
			}
			IsReady = false;
			SDL_UnlockMutex(Mtx);
			return true;
		} else {
			bool result = false;
			while (!IsReady) {
				int tmResult = SDL_CondWaitTimeout(Cond, Mtx, timeout);
				if (tmResult == SDL_MUTEX_TIMEDOUT) {
					result = IsReady;
					break;
				}
			}
			IsReady = false;
			SDL_UnlockMutex(Mtx);
			return result;
		}
#else
#if (!defined(__EMSCRIPTEN__)) || (defined(__EMSCRIPTEN__) && defined(__EMSCRIPTEN_PTHREADS__))
		std::unique_lock<std::mutex> lk( Mtx );
		if( timeout == 0 ) {
			Cond.wait( lk, [this]{ return IsReady;} );
			IsReady = false;
			return true;
		} else {
			//std::cv_status result = Cond.wait_for( lk, std::chrono::milliseconds( timeout ) );
			//return result == std::cv_status::no_timeout;
			bool result = Cond.wait_for( lk, std::chrono::milliseconds( timeout ), [this]{ return IsReady;} );
			IsReady = false;
			return result;
		}
#else
		return true;
#endif
#endif
	}
};
//---------------------------------------------------------------------------


/*[*/
const tjs_int TVPMaxThreadNum = 8;
typedef void (TJS_USERENTRY *TVP_THREAD_TASK_FUNC)(void *);
typedef void * TVP_THREAD_PARAM;
/*]*/

TJS_EXP_FUNC_DEF(tjs_int, TVPGetProcessorNum, ());
TJS_EXP_FUNC_DEF(tjs_int, TVPGetThreadNum, ());
TJS_EXP_FUNC_DEF(void, TVPBeginThreadTask, (tjs_int num));
TJS_EXP_FUNC_DEF(void, TVPExecThreadTask, (TVP_THREAD_TASK_FUNC func, TVP_THREAD_PARAM param));
TJS_EXP_FUNC_DEF(void, TVPEndThreadTask, ());

#endif
