//---------------------------------------------------------------------------
/*
	TVP2 ( T Visual Presenter 2 )  A script authoring tool
	Copyright (C) 2000 W.Dee <dee@kikyou.info> and contributors

	See details of license at "license.txt"
*/
//---------------------------------------------------------------------------
// Thread base class
//---------------------------------------------------------------------------
#define NOMINMAX
#include "tjsCommHead.h"

#include "ThreadIntf.h"
#include "MsgIntf.h"

#ifdef _WIN32
#include <process.h>
#endif
#include <algorithm>
#include <assert.h>
#if 1
#include <system_error>
#endif

#if 0
#ifdef ANDROID
#include <pthread.h>
#include <semaphore.h>
#endif
#endif


//---------------------------------------------------------------------------
// tTVPThread : a wrapper class for thread
//---------------------------------------------------------------------------
tTVPThread::tTVPThread()
 : Thread(nullptr), Terminated(false), ThreadStarting(false)
{
#ifdef KRKRZ_USE_SDL_THREADS
	Mtx = SDL_CreateMutex();
	Cond = SDL_CreateCond();
#endif
}
//---------------------------------------------------------------------------
tTVPThread::~tTVPThread()
{
#ifdef KRKRZ_USE_SDL_THREADS
	if( Thread != nullptr ) {
		SDL_WaitThread(Thread, NULL);
		Thread = nullptr;
	}
	SDL_DestroyCond(Cond);
	SDL_DestroyMutex(Mtx);
#else
	if( Thread != nullptr ) {
		if ( false ) {}
#if defined(__SWITCH__) || defined(__vita__)
		else if( Thread->joinable() ) Thread->join();
#elif (!defined(__EMSCRIPTEN__)) || (defined(__EMSCRIPTEN__) && defined(__EMSCRIPTEN_PTHREADS__))
		else if( Thread->joinable() ) Thread->detach();
#endif
		delete Thread;
	}
#endif
}
//---------------------------------------------------------------------------
#ifdef KRKRZ_USE_SDL_THREADS
int tTVPThread::StartProc(void * arg)
#else
void tTVPThread::StartProc()
#endif
{
#ifdef KRKRZ_USE_SDL_THREADS
	// スレッドが開始されたのでフラグON
	tTVPThread* _this = (tTVPThread*)arg;
	_this->ThreadId = SDL_ThreadID();
	SDL_LockMutex(_this->Mtx);
	_this->ThreadStarting = true;
	SDL_CondBroadcast(_this->Cond);
	SDL_UnlockMutex(_this->Mtx);
	(_this)->Execute();

	return 0;
#else
#if (!defined(__EMSCRIPTEN__)) || (defined(__EMSCRIPTEN__) && defined(__EMSCRIPTEN_PTHREADS__))
	{	// スレッドが開始されたのでフラグON
		std::lock_guard<std::mutex> lock( Mtx );
		ThreadStarting = true;
	}
	Cond.notify_all();
	Execute();
	// return 0;
#endif
#endif
}
//---------------------------------------------------------------------------
void tTVPThread::StartTread()
{
#ifdef KRKRZ_USE_SDL_THREADS
	if( Thread == nullptr ) {
		Thread = SDL_CreateThread(tTVPThread::StartProc, "tTVPThread", this);
		if (Thread == nullptr) {
			TVPThrowInternalError;
		}
		SDL_LockMutex(Mtx);
		while (!ThreadStarting) {
			SDL_CondWait(Cond, Mtx);
		}
		SDL_UnlockMutex(Mtx);
	}
#else
#if (!defined(__EMSCRIPTEN__)) || (defined(__EMSCRIPTEN__) && defined(__EMSCRIPTEN_PTHREADS__))
	if( Thread == nullptr ) {
		try {
			Thread = new std::thread( &tTVPThread::StartProc, this );

			// スレッドが開始されるのを待つ
			std::unique_lock<std::mutex> lock( Mtx );
			Cond.wait( lock, [this] { return ThreadStarting; } );
		} catch( std::system_error & ) {
			TVPThrowInternalError;
		}
	}
#endif
#endif
}
//---------------------------------------------------------------------------
tTVPThreadPriority tTVPThread::GetPriority()
{
#ifdef KRKRZ_USE_SDL_THREADS
	switch(_Priority)
	{
	case SDL_THREAD_PRIORITY_LOW:			return ttpIdle;
	case SDL_THREAD_PRIORITY_NORMAL:		return ttpNormal;
	case SDL_THREAD_PRIORITY_HIGH:			return ttpTimeCritical;
	}

	return ttpNormal;
#else
#ifdef _WIN32
	int n = ::GetThreadPriority( (HANDLE)GetHandle());
	switch(n)
	{
	case THREAD_PRIORITY_IDLE:			return ttpIdle;
	case THREAD_PRIORITY_LOWEST:		return ttpLowest;
	case THREAD_PRIORITY_BELOW_NORMAL:	return ttpLower;
	case THREAD_PRIORITY_NORMAL:		return ttpNormal;
	case THREAD_PRIORITY_ABOVE_NORMAL:	return ttpHigher;
	case THREAD_PRIORITY_HIGHEST:		return ttpHighest;
	case THREAD_PRIORITY_TIME_CRITICAL:	return ttpTimeCritical;
	}

	return ttpNormal;
#elif defined(__EMSCRIPTEN__) || defined(__SWITCH__)
	return ttpNormal;
#else
	if (!GetHandle())
	{
		return ttpNormal;
	}
	int policy;
	struct sched_param param;
	int err = pthread_getschedparam( GetHandle(), &policy, &param );
	int maxpri = sched_get_priority_max( policy );
	int minpri = sched_get_priority_min( policy );
	int range = (maxpri - minpri);
	int half = range / 2;
	int pri = param.sched_priority;
	if( pri == minpri ) {
		return ttpIdle;
	} else if( pri == maxpri ) {
		return ttpTimeCritical;
	} else {
		pri -= minpri;
		if( pri == half ) {
			return ttpNormal;
		}
		if( pri < half ) {
			if( pri <= (half/3) ) {
				return ttpLowest;
			} else {
				return ttpLower;
			}
		} else {
			pri -= half;
			if( pri <= (half/3) ) {
				return ttpHigher;
			} else {
				return ttpHighest;
			}
		}
	}
	return ttpNormal;
#endif
#endif
}
//---------------------------------------------------------------------------
void tTVPThread::SetPriority(tTVPThreadPriority pri)
{
#ifdef KRKRZ_USE_SDL_THREADS
	SDL_ThreadPriority npri = SDL_THREAD_PRIORITY_NORMAL;
	switch(pri)
	{
	case ttpIdle:			npri = SDL_THREAD_PRIORITY_LOW;			break;
	case ttpLowest:			npri = SDL_THREAD_PRIORITY_LOW;			break;
	case ttpLower:			npri = SDL_THREAD_PRIORITY_LOW;			break;
	case ttpNormal:			npri = SDL_THREAD_PRIORITY_NORMAL;		break;
	case ttpHigher:			npri = SDL_THREAD_PRIORITY_NORMAL;		break;
	case ttpHighest:		npri = SDL_THREAD_PRIORITY_NORMAL;		break;
	case ttpTimeCritical:	npri = SDL_THREAD_PRIORITY_HIGH;		break;
	}
	SDL_SetThreadPriority(npri);
	_Priority = npri;
#else
#ifdef _WIN32
	int npri = THREAD_PRIORITY_NORMAL;
	switch(pri)
	{
	case ttpIdle:			npri = THREAD_PRIORITY_IDLE;			break;
	case ttpLowest:			npri = THREAD_PRIORITY_LOWEST;			break;
	case ttpLower:			npri = THREAD_PRIORITY_BELOW_NORMAL;	break;
	case ttpNormal:			npri = THREAD_PRIORITY_NORMAL;			break;
	case ttpHigher:			npri = THREAD_PRIORITY_ABOVE_NORMAL;	break;
	case ttpHighest:		npri = THREAD_PRIORITY_HIGHEST;			break;
	case ttpTimeCritical:	npri = THREAD_PRIORITY_TIME_CRITICAL;	break;
	}

	::SetThreadPriority( (HANDLE)(GetHandle()), npri);
#elif defined(__EMSCRIPTEN__) || defined(__SWITCH__)
#else
	if (!GetHandle())
	{
		return;
	}
	int policy;
	struct sched_param param;
	int err = pthread_getschedparam( GetHandle(), &policy, &param );
	int maxpri = sched_get_priority_max( policy );
	int minpri = sched_get_priority_min( policy );
	int range = (maxpri - minpri);
	int half = range / 2;

	param.sched_priority = minpri + half;
	switch(pri)
	{
	case ttpIdle:			param.sched_priority = minpri;						break;
	case ttpLowest:			param.sched_priority = minpri + half/3;				break;
	case ttpLower:			param.sched_priority = minpri + (half*2)/3;			break;
	case ttpNormal:			param.sched_priority = minpri + half;				break;
	case ttpHigher:			param.sched_priority = minpri + half + half/3;		break;
	case ttpHighest:		param.sched_priority = minpri + half+ (half*2)/3;	break;
	case ttpTimeCritical:	param.sched_priority = maxpri;						break;
	}
	err = pthread_setschedparam( GetHandle(), policy, &param );
#endif
#endif
}
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
tjs_int TVPDrawThreadNum = 1;
//---------------------------------------------------------------------------
tjs_int TVPGetProcessorNum( void )
{
#ifdef KRKRZ_USE_SDL_THREADS
	return SDL_GetCPUCount();
#else
#if defined(__EMSCRIPTEN__) && !defined(__EMSCRIPTEN_PTHREADS__)
	return 1;
#else
	return std::thread::hardware_concurrency();
#endif
#endif
}
//---------------------------------------------------------------------------
tjs_int TVPGetThreadNum( void )
{
#ifdef KRKRZ_USE_SDL_THREADS
	tjs_int threadNum = TVPDrawThreadNum ? TVPDrawThreadNum : TVPGetProcessorNum();
	threadNum = std::min( threadNum, TVPMaxThreadNum );
	return threadNum;
#else
#if defined(__EMSCRIPTEN__) && !defined(__EMSCRIPTEN_PTHREADS__)
	return 1;
#else
	tjs_int threadNum = TVPDrawThreadNum ? TVPDrawThreadNum : std::thread::hardware_concurrency();
	threadNum = std::min( threadNum, TVPMaxThreadNum );
	return threadNum;
#endif
#endif
}
//---------------------------------------------------------------------------
static void TJS_USERENTRY DummyThreadTask( void * ) {}
//---------------------------------------------------------------------------
class DrawThreadPool;
class DrawThread : public tTVPThread {
#ifdef KRKRZ_USE_SDL_THREADS
	SDL_mutex *mtx;
	SDL_cond *cv;
#else
#if (!defined(__EMSCRIPTEN__)) || (defined(__EMSCRIPTEN__) && defined(__EMSCRIPTEN_PTHREADS__))
	std::mutex mtx;
	std::condition_variable cv;
#endif
#endif
	TVP_THREAD_TASK_FUNC  lpStartAddress;
	TVP_THREAD_PARAM lpParameter;
	DrawThreadPool* parent;
protected:
	virtual void Execute();

public:
	DrawThread( DrawThreadPool* p ) : parent( p ), lpStartAddress( nullptr ), lpParameter( nullptr )
	{
#ifdef KRKRZ_USE_SDL_THREADS
		mtx = SDL_CreateMutex();
		cv = SDL_CreateCond();
#endif
	}
#ifdef KRKRZ_USE_SDL_THREADS
	virtual ~DrawThread()
	{
		SDL_DestroyCond(cv);
		SDL_DestroyMutex(mtx);
	}
#endif
	void SetTask( TVP_THREAD_TASK_FUNC func, TVP_THREAD_PARAM param ) {
#ifdef KRKRZ_USE_SDL_THREADS
		SDL_LockMutex(mtx);
		lpStartAddress = func;
		lpParameter = param;
		SDL_CondSignal(cv);
		SDL_UnlockMutex(mtx);
#else
#if (!defined(__EMSCRIPTEN__)) || (defined(__EMSCRIPTEN__) && defined(__EMSCRIPTEN_PTHREADS__))
		std::lock_guard<std::mutex> lock( mtx );
#endif
		lpStartAddress = func;
		lpParameter = param;
#if (!defined(__EMSCRIPTEN__)) || (defined(__EMSCRIPTEN__) && defined(__EMSCRIPTEN_PTHREADS__))
		cv.notify_one();
#endif
#endif
	}
};
//---------------------------------------------------------------------------
class DrawThreadPool {
	std::vector<DrawThread*> workers;
#ifdef _WIN32
	std::vector<tjs_int> processor_ids;
#endif
#ifdef KRKRZ_USE_SDL_THREADS
	SDL_atomic_t running_thread_count;
#else
#if (!defined(__EMSCRIPTEN__)) || (defined(__EMSCRIPTEN__) && defined(__EMSCRIPTEN_PTHREADS__))
	std::atomic<int> running_thread_count;
#else
	int running_thread_count;
#endif
#endif
	tjs_int task_num;
	tjs_int task_count;
private:
	void PoolThread( tjs_int taskNum );

public:
	DrawThreadPool() : 
#ifdef KRKRZ_USE_SDL_THREADS
	running_thread_count( { 0 } ), 
#else
	running_thread_count( 0 ), 
#endif
	task_num( 0 ), task_count( 0 ) {}
	~DrawThreadPool() {
		for( auto i = workers.begin(); i != workers.end(); ++i ) {
			DrawThread *th = *i;
			th->Terminate();
			th->SetTask( DummyThreadTask, nullptr );
			th->WaitFor();
			delete th;
		}
	}
	inline void DecCount()
	{
#ifdef KRKRZ_USE_SDL_THREADS
		SDL_AtomicDecRef(&running_thread_count);
#else
		running_thread_count--;
#endif
	}
	void BeginTask( tjs_int taskNum ) {
		task_num = taskNum;
		task_count = 0;
#if (!defined(__EMSCRIPTEN__)) || (defined(__EMSCRIPTEN__) && defined(__EMSCRIPTEN_PTHREADS__))
		PoolThread( taskNum );
#endif
	}
	void ExecTask( TVP_THREAD_TASK_FUNC func, TVP_THREAD_PARAM param ) {
#if defined(__EMSCRIPTEN__) && !defined(__EMSCRIPTEN_PTHREADS__)
		func( param );
#else
		if( task_count >= task_num - 1 ) {
			func( param );
			return;
		}
#ifdef KRKRZ_USE_SDL_THREADS
		SDL_AtomicIncRef(&running_thread_count);
#else
		running_thread_count++;
#endif
		DrawThread* thread = workers[task_count];
		task_count++;
		thread->SetTask( func, param );
#ifdef KRKRZ_USE_SDL_THREADS
		SDL_Delay(0);
#else
		std::this_thread::yield();
#endif
#endif
	}
	void WaitForTask() {
#ifdef KRKRZ_USE_SDL_THREADS
		while (SDL_AtomicGet(&running_thread_count) != 0)
		{
			SDL_Delay(0);
		}
#else
#if (!defined(__EMSCRIPTEN__)) || (defined(__EMSCRIPTEN__) && defined(__EMSCRIPTEN_PTHREADS__))
		int expected = 0;
		while( false == std::atomic_compare_exchange_weak( &running_thread_count, &expected, 0 ) ) {
			expected = 0;
			std::this_thread::yield();	// スレッド切り替え(再スケジューリング)
		}
#endif
#endif
	}
};
//---------------------------------------------------------------------------
void DrawThread::Execute() {
#ifdef KRKRZ_USE_SDL_THREADS
	while( !GetTerminated() ) {
		SDL_LockMutex(mtx);
		while (lpStartAddress == nullptr)
		{
			SDL_CondWait(cv, mtx);
		}
		SDL_UnlockMutex(mtx);
		if( lpStartAddress != nullptr ) ( lpStartAddress )( lpParameter );
		lpStartAddress = nullptr;
		parent->DecCount();
	}
#else
#if (!defined(__EMSCRIPTEN__)) || (defined(__EMSCRIPTEN__) && defined(__EMSCRIPTEN_PTHREADS__))
	while( !GetTerminated() ) {
		{
			std::unique_lock<std::mutex> uniq_lk( mtx );
			cv.wait( uniq_lk, [this] { return lpStartAddress != nullptr; } );
		}
		if( lpStartAddress != nullptr ) ( lpStartAddress )( lpParameter );
		lpStartAddress = nullptr;
		parent->DecCount();
	}
#endif
#endif
}
//---------------------------------------------------------------------------
void DrawThreadPool::PoolThread( tjs_int taskNum ) {
	tjs_int extraThreadNum = TVPGetThreadNum() - 1;

#ifdef _WIN32
	if( processor_ids.empty() ) {
#ifndef TJS_64BIT_OS
		DWORD processAffinityMask, systemAffinityMask;
		::GetProcessAffinityMask( GetCurrentProcess(), &processAffinityMask, &systemAffinityMask );
		for( tjs_int i = 0; i < MAXIMUM_PROCESSORS; i++ ) {
			if( processAffinityMask & ( 1 << i ) )
				processor_ids.push_back( i );
		}
#else
		ULONGLONG processAffinityMask, systemAffinityMask;
		::GetProcessAffinityMask( GetCurrentProcess(), (PDWORD_PTR)&processAffinityMask, (PDWORD_PTR)&systemAffinityMask );
		for( tjs_int i = 0; i < MAXIMUM_PROCESSORS; i++ ) {
			if( processAffinityMask & ( 1ULL << i ) )
				processor_ids.push_back( i );
		}
#endif
		if( processor_ids.empty() )
			processor_ids.push_back( MAXIMUM_PROCESSORS );
	}
#endif

	// スレッド数がextraThreadNumに達していないので(suspend状態で)生成する
	while( (tjs_int)workers.size() < extraThreadNum ) {
		DrawThread* th = new DrawThread( this );
		th->StartTread();
#ifndef KRKRZ_USE_SDL_THREADS
#ifdef _WIN32
		::SetThreadIdealProcessor( (HANDLE)(th->GetHandle()), processor_ids[workers.size() % processor_ids.size()] );
#elif defined( __MACH__ )
		thread_affinity_policy_data_t policy = { static_cast<int>(workers.size()) };
		thread_policy_set( pthread_mach_thread_np( th->GetHandle() ), THREAD_AFFINITY_POLICY, (thread_policy_t)&policy, 1);
#elif defined( __EMSCRIPTEN__ ) || defined( __vita__ ) || defined( __SWITCH__ )
		// do nothing
#elif !defined( ANDROID )
		// for pthread(!android)
		cpu_set_t cpuset;
		CPU_ZERO( &cpuset );
		CPU_SET( workers.size(), &cpuset );
		int rc = pthread_setaffinity_np( th->GetHandle(), sizeof( cpu_set_t ), &cpuset );
#endif
#endif
		workers.push_back( th );
	}
	// スレッド数が多い場合終了させる
	while( (tjs_int)workers.size() > extraThreadNum ) {
		DrawThread *th = workers.back();
		th->Terminate();
#ifdef KRKRZ_USE_SDL_THREADS
		SDL_AtomicIncRef(&running_thread_count);
#else
		running_thread_count++;
#endif
		th->SetTask( DummyThreadTask, nullptr );
		th->WaitFor();
		workers.pop_back();
		delete th;
	}
}
//---------------------------------------------------------------------------
static DrawThreadPool TVPTheadPool;
//---------------------------------------------------------------------------
void TVPBeginThreadTask( tjs_int taskNum ) {
	TVPTheadPool.BeginTask( taskNum );
}
//---------------------------------------------------------------------------
void TVPExecThreadTask( TVP_THREAD_TASK_FUNC func, TVP_THREAD_PARAM param ) {
	TVPTheadPool.ExecTask( func, param );
}
//---------------------------------------------------------------------------
void TVPEndThreadTask( void ) {
	TVPTheadPool.WaitForTask();
}
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------


