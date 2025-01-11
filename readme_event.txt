miyoo a30 rotate 90

    //rotate 270 degree
    SDL_Rect rect_ = {0};
    rect_.x = (480 - 640) / 2; //-80;
    rect_.y = (640 - 480) / 2; //80;
    rect_.w = 640 * 1;
    rect_.h = 480 * 1;
    SDL_Point p = {0};
    p.x = 640 / 2;//320;
    p.y = 480 / 2;//240;
    SDL_RenderCopyEx(renderer, texture, NULL, &rect_, 270, &p, SDL_FLIP_NONE);

https://github.com/weimingtom/onscripter-jh-miyoo-a30/blob/829b17548cbf7401566c158f1174c3440a1fa1f3/ONScripter.cpp#L761

==

SDL_RenderCopy

                    SDL_Rect destrect;
                    destrect.x = this->LastSentDrawDeviceDestRect.left;
                    destrect.y = this->LastSentDrawDeviceDestRect.top;
                    destrect.w = this->LastSentDrawDeviceDestRect.get_width();
                    destrect.h = this->LastSentDrawDeviceDestRect.get_height();
                    SDL_Rect srcrect;
                    srcrect.x = 0;
                    srcrect.y = 0;
                    srcrect.w = this->GetInnerWidth();
                    srcrect.h = this->GetInnerHeight();
                    SDL_RenderCopy(this->renderer, this->texture, &srcrect, &destrect);
#elif defined(KRKRSDL2_RENDERER_FULL_UPDATES)
                    SDL_RenderCopy(this->renderer, this->texture, nullptr, nullptr);
#else
                    SDL_RenderCopy(this->renderer, this->texture, &rect, &rect);
#endif
                }

https://github.com/krkrsdl2/krkrsdl2/blob/b65d877a5d4dfe91649bc0c9b698e97ae8fed54e/src/core/sdl2/SDLApplication.cpp#L1736
==

#ifdef TVP_TEXT_READ_ANSI_MBCS
static ttstr DefaultReadEncoding = TJS_W("Shift_JIS");
#else
static ttstr DefaultReadEncoding = TJS_W("UTF-8");
#endif



                                                                        if( encoding == TJS_W("UTF-8") ) {
                                                                                    BufferLen = TVPUtf8ToWideCharString((const char*)nbuf, NULL);
                                                                                    if(BufferLen == (size_t)-1) TVPThrowExceptionMessage(TJSNarrowToWideConversionError);
                                                                                    Buffer = new tjs_char [ BufferLen +1];
                                                                                    TVPUtf8ToWideCharString((const char*)nbuf, Buffer);
                                                                        } else if( encoding == TJS_W("Shift_JIS") ) {
                                                                                    BufferLen = TJS_narrowtowidelen((tjs_nchar*)nbuf);
                                                                                    if(BufferLen == (size_t)-1) TVPThrowExceptionMessage(TJSNarrowToWideConversionError);
                                                                                    Buffer = new tjs_char [ BufferLen +1];
                                                                                    TJS_narrowtowide(Buffer, (tjs_nchar*)nbuf, BufferLen);
                                                                        } else {
                                                                                    TVPThrowExceptionMessage(TVPUnsupportedEncoding, encoding);
                                                                        }

==

krkrsdl2研究，脱字问题解决，猜测可能因为字体文件ttf不支持某个字，就会脱字了，把默认字体文件换成另一个字体文件即可（我是复制kirikiroid2里面最大的那个ttf），不用krkrsdl2提供的那个字体文件（system_polyfill/font.ttf），就可以解决。具体如果加断点的话是在FreeType.cpp里面的GetGlyphFromCharcode和LoadGlyphSlotFromCharcode，大概相当于SDL_ttf的作用（krkrz没有用SDL_ttf而是直接通过FreeType库画像素）。至此可能还差声音和键位问题未解决

==
FileManager
CrossMix-OS-1.2.1_min.7z
需要这个app去启动krkrsdl2
==

https://krkrz.github.io/krkr2doc/kag3doc/contents/MouseKeyboard.html
「左クリック」または「ホイールを手前に回転」または「リターンキー」または「スペースキー」
読みすすみ または 選択肢の決定、ボタンを押す、チェックボックスをチェックするなどの動作
「右クリック」または「ESC キー」
メッセージ履歴の表示 または 右クリックサブルーチンの呼び出し
「↑」「↓」 または 「←」「→」 または 「TAB」「SHIFT+TAB」
選択肢、ボタン、単一行エディット、チェックボックス間の移動
「ホイールを奥に回転」または「R キー」または「SHIFT＋↑」
メッセージ履歴の表示
「F キー」
次の選択肢/未読まで進む
「A キー」
自動的に読み進む
「B キー」
前に戻る
「S キー」
(フリーセーブモードにおいて) 栞を挟む
「L キー」
(フリーセーブモードにおいて) 栞をたどる

Return，Space: 下一步，选择肢确定；yesno 对话框按钮点击确定；关闭消息历史
ESC：消息历史，右键历程 ；关闭消息历史

方向键，TAB，SHIFT+TAB：选择肢，按钮，编辑框，复讯框之间移动
方向键：yes no对话框的按钮切换；消息历史滚动
R，SHIFT＋↑：消息履历

F：跨进到下一个选择项/快进到未读
A：自动
B：后退
S：保存
L：加载

没有：退出程序

==

A=回车确定=kag3.Return
B=空格确定=kag3.Space
X=快进=kag3.F
Y=菜单=kag3.ESC=消息历史

Select=选择
Start=自动=kag3.A
Menu=退出=???kage3.退出

L1=左=?kag3.B=后退
R1=右

?=kage3.S=保存
?=kage3.L=加载

krkrsdl2移植到Linux掌机研究。关于按键和摇杆映射，我大概整理一下，可能只有Save/Load功能（可能还有自动快进）不好映射键位，其他应该都可以和onscripter的部分键位对应上，大概是：A和B是回车和空格确定；X是快进（到未读或下分支）；Y是消息记录（原本应该是上下文菜单但这里似乎没有这功能）；Start自动；Menu退出；Select是关闭自动（可能合并到Start）；L1是后退。当然这个只是初步想法，可能实际要慢慢调整试验

==

https://steward-fu.github.io/website/handheld/miyoo_a30_cpp_joystick.htm

https://github.com/weimingtom/onscripter-jh-miyoo-a30/blob/master/ONScripter_event.cpp
miyoo a30
#if defined(MIYOO)
//miyoo a30 key translate:
//A=44=SPACE
//B=224/0x400000E0=LCTRL
//Y=226/0x400000E2=LALT
//X=225/0x400000E1=LSHIFT
//Left/0x40000050=80
//Right/0x4000004F=79
//Up/0x40000052=82
//Down/0x40000051=81
//L1=43=TAB
//L2=8=E
//R1=42=BACKSPACE
//R2=23=T
//Vol-=129/0x40000081=VOLUMEDOWN
//Vol+=128/0x40000080=VOLUMEUP
//Menu=27/(41?)/0x0000001B=ESCAPE
//Select=228/0x400000E4=RCTRL
//Start=40=RETURN
//Power=102/0x40000066=POWER


//key &= 0xFFFF;
//SDL_Log("<<key = %d\n", key);
    switch(key){
       case 27: case 41: // Shutdown=Esc=miyoo.Menu
//endCommand();
        SDL_Event event;
        event.type = SDL_QUIT;
        SDL_PushEvent(&event);
        key = SDLK_UNKNOWN;
    break;

case 225: case 0x400000E1:
//SDL_Log("%s\n", "case 225,41");
key = SDLK_ESCAPE; break; // Menu=PSP.TRIANGLE=miyoo.X.rightup
      case 44: key = SDLK_RETURN; break; // Play/Pause=PSP.CIRCLE=miyoo.A.rightright
      case 224: case 0x400000E0: key = SDLK_SPACE; break; // Action/Play(same as CIRCLE)=PSP.CROSS=miyoo.B.rightdown
      case 226: case 0x400000E2: key = SDLK_RCTRL; break; // Fast forward=PSP.SQUARE=miyoo.Y.rightleft
      case 81: case 0x40000051: key = SDLK_DOWN;break;   /* DOWN     */
      case 80: case 0x40000050: key = SDLK_LEFT;break;   /* LEFT     */
      case 82: case 0x40000052: key = SDLK_UP;break;     /* UP       */
      case 79: case 0x4000004F: key = SDLK_RIGHT;break;  /* RIGHT    */
      case 43: key = SDLK_o;break;      /* LTRIGGER */
      case 42: key = SDLK_s;break;      /* RTRIGGER */
      case 228: case 0x400000E4: key = SDLK_0;break;      /* SELECT   */
      case 40: key = SDLK_a;break;      /* START    */
      default: break;
    }
#endif

ONScriper_event.cpp, KEYDOWN, KEYUP

all joystick:
no output
A:
INFO: Key pressed :  scancode 44 = Space, keycode 0x00000020 = Space  modifiers: (none)
INFO: Key released:  scancode 44 = Space, keycode 0x00000020 = Space  modifiers: (none)
B:
INFO: Key pressed :  scancode 224 = Left Ctrl, keycode 0x400000E0 = Left Ctrl  modifiers: LCTRL
INFO: Key released:  scancode 224 = Left Ctrl, keycode 0x400000E0 = Left Ctrl  modifiers: (none)
Y:
INFO: Key pressed :  scancode 226 = Left Alt, keycode 0x400000E2 = Left Alt  modifiers: LALT
INFO: Key released:  scancode 226 = Left Alt, keycode 0x400000E2 = Left Alt  modifiers: (none)
X:
INFO: Key pressed :  scancode 225 = Left Shift, keycode 0x400000E1 = Left Shift  modifiers: LSHIFT
INFO: Key released:  scancode 225 = Left Shift, keycode 0x400000E1 = Left Shift  modifiers: (none)
Left:
INFO: Key pressed :  scancode 80 = Left, keycode 0x40000050 = Left  modifiers: (none)
INFO: Key released:  scancode 80 = Left, keycode 0x40000050 = Left  modifiers: (none)
Right:
INFO: Key pressed :  scancode 79 = Right, keycode 0x4000004F = Right  modifiers: (none)
INFO: Key released:  scancode 79 = Right, keycode 0x4000004F = Right  modifiers: (none)
Up:
INFO: Key pressed :  scancode 82 = Up, keycode 0x40000052 = Up  modifiers: (none)
INFO: Key released:  scancode 82 = Up, keycode 0x40000052 = Up  modifiers: (none)
Down:
INFO: Key pressed :  scancode 81 = Down, keycode 0x40000051 = Down  modifiers: (none)
INFO: Key released:  scancode 81 = Down, keycode 0x40000051 = Down  modifiers: (none)
L1:
INFO: Key pressed :  scancode 43 = Tab, keycode 0x00000009 = Tab  modifiers: (none)
INFO: Key released:  scancode 43 = Tab, keycode 0x00000009 = Tab  modifiers: (none)
L2:
INFO: Key pressed :  scancode 8 = E, keycode 0x00000065 = E  modifiers: (none)
INFO: Key released:  scancode 8 = E, keycode 0x00000065 = E  modifiers: (none)
R1:
INFO: Key pressed :  scancode 42 = Backspace, keycode 0x00000008 = Backspace  modifiers: (none)
INFO: Key released:  scancode 42 = Backspace, keycode 0x00000008 = Backspace  modifiers: (none)
R2:
INFO: Key pressed :  scancode 23 = T, keycode 0x00000074 = T  modifiers: (none)
INFO: Key released:  scancode 23 = T, keycode 0x00000074 = T  modifiers: (none)
Vol-:
INFO: Key pressed :  scancode 129 = VolumeDown, keycode 0x40000081 = VolumeDown  modifiers: (none)
INFO: Key released:  scancode 129 = VolumeDown, keycode 0x40000081 = VolumeDown  modifiers: (none)
Vol+:
INFO: Key pressed :  scancode 128 = VolumeUp, keycode 0x40000080 = VolumeUp  modifiers: (none)
INFO: Key released:  scancode 128 = VolumeUp, keycode 0x40000080 = VolumeUp  modifiers: (none)
Menu:
INFO: Key pressed :  scancode 41 = Escape, keycode 0x0000001B = Escape  modifiers: (none)
INFO: Key released:  scancode 41 = Escape, keycode 0x0000001B = Escape  modifiers: (none)
Select:
INFO: Key pressed :  scancode 228 = Right Ctrl, keycode 0x400000E4 = Right Ctrl  modifiers: RCTRL
INFO: Key released:  scancode 228 = Right Ctrl, keycode 0x400000E4 = Right Ctrl  modifiers: (none)
Start:
INFO: Key pressed :  scancode 40 = Return, keycode 0x0000000D = Return  modifiers: (none)
INFO: Key released:  scancode 40 = Return, keycode 0x0000000D = Return  modifiers: (none)
Power:
INFO: Key pressed :  scancode 102 = Power, keycode 0x40000066 = Power  modifiers: (none)
INFO: Key released:  scancode 102 = Power, keycode 0x40000066 = Power  modifiers: (none)


#if defined(MIYOO)
//code originally from SDL2-2.24.0.tar.gz/test/checkkeys.c

static void
print_string(char **text, size_t *maxlen, const char *fmt, ...)
{
    int len;
    va_list ap;

    va_start(ap, fmt);
    len = SDL_vsnprintf(*text, *maxlen, fmt, ap);
    if (len > 0) {
        *text += len;
        if ( ((size_t) len) < *maxlen ) {
            *maxlen -= (size_t) len;
        } else {
            *maxlen = 0;
        }
    }
    va_end(ap);
}

static void
print_modifiers(char **text, size_t *maxlen)
{
    int mod;
    print_string(text, maxlen, " modifiers:");
    mod = SDL_GetModState();
    if (!mod) {
        print_string(text, maxlen, " (none)");
        return;
    }
    if (mod & KMOD_LSHIFT)
        print_string(text, maxlen, " LSHIFT");
    if (mod & KMOD_RSHIFT)
        print_string(text, maxlen, " RSHIFT");
    if (mod & KMOD_LCTRL)
        print_string(text, maxlen, " LCTRL");
    if (mod & KMOD_RCTRL)
        print_string(text, maxlen, " RCTRL");
    if (mod & KMOD_LALT)
        print_string(text, maxlen, " LALT");
    if (mod & KMOD_RALT)
        print_string(text, maxlen, " RALT");
    if (mod & KMOD_LGUI)
        print_string(text, maxlen, " LGUI");
    if (mod & KMOD_RGUI)
        print_string(text, maxlen, " RGUI");
    if (mod & KMOD_NUM)
        print_string(text, maxlen, " NUM");
    if (mod & KMOD_CAPS)
        print_string(text, maxlen, " CAPS");
    if (mod & KMOD_MODE)
        print_string(text, maxlen, " MODE");
//    if (mod & KMOD_SCROLL)
//        print_string(text, maxlen, " SCROLL");
}

static void
PrintKey(SDL_Keysym * sym, SDL_bool pressed, SDL_bool repeat)
{
    char message[512];
    char *spot;
    size_t left;

    spot = message;
    left = sizeof(message);

    /* Print the keycode, name and state */
    if (sym->sym) {
        print_string(&spot, &left,
                "Key %s:  scancode %d = %s, keycode 0x%08X = %s ",
                pressed ? "pressed " : "released",
                sym->scancode,
                SDL_GetScancodeName(sym->scancode),
                sym->sym, SDL_GetKeyName(sym->sym));
    } else {
        print_string(&spot, &left,
                "Unknown Key (scancode %d = %s) %s ",
                sym->scancode,
                SDL_GetScancodeName(sym->scancode),
                pressed ? "pressed " : "released");
    }
    print_modifiers(&spot, &left);
    if (repeat) {
        print_string(&spot, &left, " (repeat)");
    }
    SDL_Log("%s\n", message);
}
#endif














          case SDL_JOYBUTTONDOWN:
#if defined(MIYOO)
SDL_Log("%s\n", "SDL_JOYBUTTONDOWN");
#endif
            event.key.type = SDL_KEYDOWN;
            event.key.keysym.sym = transJoystickButton(event.jbutton.button);
            if(event.key.keysym.sym == SDLK_UNKNOWN)
                break;
            
          case SDL_KEYDOWN:
#if defined(MIYOO)
        PrintKey(&event.key.keysym, (event.key.state == SDL_PRESSED) ? SDL_TRUE : SDL_FALSE, (event.key.repeat) ? SDL_TRUE : SDL_FALSE);
#endif
            event.key.keysym.sym = transKey(event.key.keysym.sym);
            ret = keyDownEvent( &event.key );
            if ( btndown_flag )
                ret |= keyPressEvent( &event.key );
            if (ret) return;
            break;

          case SDL_JOYBUTTONUP:
#if defined(MIYOO)
SDL_Log("%s\n", "SDL_JOYBUTTONUP");
#endif
            event.key.type = SDL_KEYUP;
            event.key.keysym.sym = transJoystickButton(event.jbutton.button);
            if(event.key.keysym.sym == SDLK_UNKNOWN)
                break;
            
          case SDL_KEYUP:
#if defined(MIYOO)
        PrintKey(&event.key.keysym, (event.key.state == SDL_PRESSED) ? SDL_TRUE : SDL_FALSE, (event.key.repeat) ? SDL_TRUE : SDL_FALSE);
#endif
            event.key.keysym.sym = transKey(event.key.keysym.sym);
            keyUpEvent( &event.key );
            ret = keyPressEvent( &event.key );
            if (ret) return;
            break;

          case SDL_JOYAXISMOTION:
          {
#if defined(MIYOO)
SDL_Log("%s\n", "SDL_JOYAXISMOTION");
#endif
              SDL_KeyboardEvent ke = transJoystickAxis(event.jaxis);
              if (ke.keysym.sym != SDLK_UNKNOWN){
                  if (ke.type == SDL_KEYDOWN){
                      keyDownEvent( &ke );
                      if (btndown_flag)
                          keyPressEvent( &ke );
                  }
                  else if (ke.type == SDL_KEYUP){
                      keyUpEvent( &ke );
                      keyPressEvent( &ke );
                  }
              }
              break;
          }



==
https://github.com/weimingtom/onscripter-jh-rg28xx/blob/master/ONScripter_event.cpp
SDL_JOYBUTTONDOWN
SDL_JOYBUTTONUP
SDL_JOYAXISMOTION？？？


rg28xx

ONS_Key transJoystickButton(Uint8 button)
{
#if defined(PSP)  
    ONS_Key/*SDLKey*/ button_map[] = { SDLK_ESCAPE, /* TRIANGLE */
                            SDLK_RETURN, /* CIRCLE   */
                            SDLK_SPACE,  /* CROSS    */
                            SDLK_RCTRL,  /* SQUARE   */
                            SDLK_o,      /* LTRIGGER */
                            SDLK_s,      /* RTRIGGER */
                            SDLK_DOWN,   /* DOWN     */
                            SDLK_LEFT,   /* LEFT     */
                            SDLK_UP,     /* UP       */
                            SDLK_RIGHT,  /* RIGHT    */
                            SDLK_0,      /* SELECT   */
                            SDLK_a,      /* START    */
                            SDLK_UNKNOWN,/* HOME     */ /* kernel mode only */
                            SDLK_UNKNOWN,/* HOLD     */};
    return button_map[button];
#elif defined(MIYOO)
/*
RG28XX:
button=joystick=keycode=keyname

A=0=1B=Escape
B=1=0D=Return
X=3=400000E4=Right Ctrl
Y=2=20=Space

Up=N/A
Down=N/A
Left=N/A
Right=N/A

SE=6=40000051=Down
ST=7=40000050=Left
M=8/11=40000052/61=Up/A
Power=N/A=40000066=Power

L1(LL)=4=6F=O
L2(LR)=9=4000004F=Right
R1(RR)=5=73=S
R2(RL)=10=30=0

VolumnUp=14=0x40000080=VolumnUp
VolumnDown=13=0x40000081=VolumnDown
*/

    ONS_Key/*SDLKey*/ button_map[] = { SDLK_RETURN, /* 0=rg.A SDLK_ESCAPE*/
                            SDLK_SPACE, /* 1=rg.B   */
                            SDLK_ESCAPE/*menu*/,  /* 2=rg.Y    */
SDLK_s/*fast*/,
                            SDLK_RCTRL,  /* 3=rg.X=S/fast   */
                            SDLK_LEFT,      /* 4=rg.L1 */
                            SDLK_RIGHT,      /* 5=rg.R1 */
                            SDLK_o/*stop*/,   /* 6=rg.Select     */
                            SDLK_a/*auto*/,   /* 7=rg.Start     */
//SDLK_0/*stop*/
                            SDLK_UNKNOWN,     /* 8=rg.Menu       */
                            SDLK_UP,         /* 9=rg.L2    */
                            SDLK_DOWN,       /* 10=rg.R2   */
                            SDLK_UNKNOWN,/* 11=rg.Menu.repeat    */
                            SDLK_UNKNOWN,/* 12=N/A     */
                            SDLK_UNKNOWN,/* 13=VolumnDown     */
                SDLK_UNKNOWN,/* 14=VolumnUp     */};
if (button == 8/*rg.menu*/) {
    //endCommand();
        SDL_Event event;
        event.type = SDL_QUIT;
        SDL_PushEvent(&event);
//        key = SDLK_UNKNOWN;
}
    return button_map[button];


https://steward-fu.github.io/website/handheld/rg28xx_cpp_input.htm
上下左右可能和摇杆其他事件有关？
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <linux/input.h>
  
/*
UP     buf[10]=0x11, buf[12]=0xff
DOWN   buf[10]=0x11, buf[12]=0x01
LEFT   buf[10]=0x10, buf[12]=0xff
RIGHT  buf[10]=0x10, buf[12]=0x01
A      buf[10]=0x30, buf[12]=0x01
B      buf[10]=0x31, buf[12]=0x01
X      buf[10]=0x33, buf[12]=0x01
Y      buf[10]=0x32, buf[12]=0x01
L1     buf[10]=0x34, buf[12]=0x01
L2     buf[10]=0x3a, buf[12]=0x01
R1     buf[10]=0x35, buf[12]=0x01
R2     buf[10]=0x3b, buf[12]=0x01
MENU   buf[10]=0x38, buf[12]=0x01
MENU   buf[10]=0x62, buf[12]=0x01
SELECT buf[10]=0x36, buf[12]=0x01
START  buf[10]=0x37, buf[12]=0x01
VOL+   buf[10]=0x73, buf[12]=0x01
VOL-   buf[10]=0x72, buf[12]=0x01
*/
 
int main(int argc, char **argv)
{
    int fd = -1;
    char buf[16] = {0};
 
    fd = open("/dev/input/event1", O_RDONLY);
    if (fd > 0) {
        while (1) {
            if (read(fd, buf, 16)) {
                int s = !!buf[12];
 
                switch (buf[10]) {
                case 0x11:
                    if (s) {
                        printf("%s 1\n", buf[12] == 0xff ? "UP" : "DOWN");
                    }
                    else {
                        printf("UP/DOWN 0\n");
                    }
                    break;
                case 0x10:
                    if (s) {
                        printf("%s 1\n", buf[12] == 0xff ? "LEFT" : "RIGHT");
                    }
                    else {
                        printf("LEFT/RIGHT 0\n");
                    }
                    break;
                case 0x30: printf("A %d\n", s); break;
                case 0x31: printf("B %d\n", s); break;
                case 0x33: printf("X %d\n", s); break;
                case 0x32: printf("Y %d\n", s); break;
                case 0x34: printf("L1 %d\n", s); break;
                case 0x3a: printf("L2 %d\n", s); break;
                case 0x35: printf("R1 %d\n", s); break;
                case 0x3b: printf("R2 %d\n", s); break;
                case 0x38: printf("MENU %d\n", s); break;
                case 0x62: printf("MENU %d\n", s); break;
                case 0x36: printf("SELECT %d\n", s); break;
                case 0x37: printf("START %d\n", s); break;
                case 0x73: printf("VOL+ %d\n", s); break;
                case 0x72: printf("VOL- %d\n", s); break;
                }
            }
        }
    }
    return 0;
}
==

https://github.com/weimingtom/onscripter-jh-trimui-smart-pro/blob/master/ONScripter_event.cpp
#elif defined(MIYOO)
/*
RG28XX:
button=joystick=keycode=keyname

A=0=1B=Escape
B=1=0D=Return
X=3=400000E4=Right Ctrl
Y=2=20=Space

Up=N/A
Down=N/A
Left=N/A
Right=N/A

SE=6=40000051=Down
ST=7=40000050=Left
M=8/11=40000052/61=Up/A
Power=N/A=40000066=Power

L1(LL)=4=6F=O
L2(LR)=9=4000004F=Right
R1(RR)=5=73=S
R2(RL)=10=30=0

VolumnUp=14=0x40000080=VolumnUp
VolumnDown=13=0x40000081=VolumnDown
*/

    ONS_Key/*SDLKey*/ button_map[] = { SDLK_RETURN, /* 0=rg.A SDLK_ESCAPE*/
                            SDLK_SPACE, /* 1=rg.B   */
                            SDLK_ESCAPE/*menu*/,  /* 2=rg.Y    */
SDLK_s/*fast*/,
                            SDLK_RCTRL,  /* 3=rg.X=S/fast   */
                            SDLK_LEFT,      /* 4=rg.L1 */
                            SDLK_RIGHT,      /* 5=rg.R1 */
                            SDLK_o/*stop*/,   /* 6=rg.Select     */
                            SDLK_a/*auto*/,   /* 7=rg.Start     */
//SDLK_0/*stop*/
                            SDLK_UNKNOWN,     /* 8=rg.Menu       */
                            SDLK_UP,         /* 9=rg.L2    */
                            SDLK_DOWN,       /* 10=rg.R2   */
                            SDLK_UNKNOWN,/* 11=rg.Menu.repeat    */
                            SDLK_UNKNOWN,/* 12=N/A     */
                            SDLK_UNKNOWN,/* 13=VolumnDown     */
                SDLK_UNKNOWN,/* 14=VolumnUp     */};
if (button == 8/*rg.menu*/) {
    //endCommand();
        SDL_Event event;
        event.type = SDL_QUIT;
        SDL_PushEvent(&event);
//        key = SDLK_UNKNOWN;
}
    return button_map[button];



	