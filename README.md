# krkrsdl2-miyoo-a30
[WIP] krkrsdl2 MIYOO A30, TRIMUI SMART PRO, TRIMUI BRICK port for code hacking and kirikiri2 gbk non-commercial unencrypted games without xp3filter.tjs and patch.tjs support

## Original Code, most codes are from others, not mine  
* https://github.com/krkrsdl2/krkrsdl2  
krkrsdl2_20240518_v2.tar.gz, see version 638f820    
https://github.com/krkrsdl2/krkrsdl2/tree/638f8203c202163971ae1c483a2316ffcb9ef0ba  
* https://github.com/krkrsdl2/krkrsdl2-kag3-demo
* https://github.com/krkrz/krkrz
* The data.xp3 for 'make test' is from Spring Days, using kirikiri2 engine  
https://code.google.com/archive/p/godxq1986/downloads   

## Status  
* Save and load functions not work.    
* Key mapping bad, especially MIYOO A30 not fixed. TRIMUI will be better.  
* MIYOO A30 works slowly, because of screen rotation of 90 degrees (or 270 degrees), NOT machine's reason.     

## ARM GCC Toolchains, need to modify Makefile by manual    
* (for miyoo a30) https://github.com/XK9274/a30-sdk-miyoo/releases/tag/16042024   
* (for Trimui Smart Pro and Trimui Brick, aarch64) https://github.com/trimui/toolchain_sdk_smartpro/releases/tag/20231018    
* (for Xubuntu 20.04 64bit) sudo apt install gcc g++ gdb libsdl2-dev  

## Usage and Debugging (after copy resource files)     
* For TRIMUI SMART PRO, after adb shell 'killall -KILL runtrimui.sh MainUI'  
```
make MIYOO=2 clean
make MIYOO=2 -j8
make MIYOO=2 -j8 && make install && make run  
```
* For PC Xubuntu 20.04, by VirtualBox  
```
make MIYOO=0 clean
make MIYOO=0 -j8
make MIYOO=0 -j8 && make test
make MIYOO=0 -j8 && make debug    
```
* For TRIMUI BRICK, after adb shell 'killall -KILL runtrimui.sh MainUI'  
```
make MIYOO=3 clean
make MIYOO=3 -j8
make MIYOO=3 -j8 && make install && make run  
```
* For MIYOO A30  
```
make MIYOO=1 clean
make MIYOO=1 -j8
make MIYOO=1 -j8 && make install && make run  
```

## Original Readme

# 吉里吉里SDL2 / Kirikiri SDL2

吉里吉里SDL2は、macOSやLinuxなど、[SDL2](https://www.libsdl.org/)をサポートするプラットフォームで実行できる[吉里吉里Z](https://krkrz.github.io/)の移植版です。  

詳細については、次の Web ページを参照してください: https://krkrsdl2.github.io/krkrsdl2/  

Kirikiri SDL2 is a port of [Kirikiri Z](https://krkrz.github.io/) that can be run on platforms supporting [SDL2](https://www.libsdl.org/), such as macOS and Linux.  

Please visit the following webpage for more information: https://krkrsdl2.github.io/krkrsdl2/en/  

## 商用ゲームの実行に関する注意 / A note on running commercial games

このプロジェクトを使用して変更されていない商用ゲームを実行することはサポートされていません。  
代わりに[Wine](https://www.winehq.org/)または[Kirikiroid2](https://play.google.com/store/apps/details?id=org.tvp.kirikiri2)を使用してください。    

Running unmodified commercial games using this project is not supported.  
Please use [Wine](https://www.winehq.org/) or [Kirikiroid2](https://play.google.com/store/apps/details?id=org.tvp.kirikiri2) instead.  

## ライセンス / License

吉里吉里SDL2ソース（`src`ディレクトリ内）のコードは、MITライセンスの下でライセンスされています。 詳細については、`LICENSE`をお読みください。  
このプロジェクトには、サードパーティのコンポーネントが含まれています (GPL に基づいてライセンスされていません)。詳細については、各コンポーネントのライセンスファイルを参照してください。  

The code of the Kirikiri SDL2 source (inside the `src` directory) is licensed under the MIT license. Please read `LICENSE` for more information.  
This project contains third-party components (not licensed under the GPL). Please view the license file in each component for more information.  

## New Readme  
* weibo record  
```
kirikiroid2研究。关于TVPInitDirectSound和
TVPCreateSoundBuffer的实现填充问题，
它本来应该是通过DirectSound实现（DirectX），
然后它kirikiroid2原版是通过SDL或者Oboe实现。
对我而言oboe和dsound应该不用考虑了，
比较可行应该是SDL或者通过SDL的底层
（例如waveOutWrite，winmm，或者安卓的AudioTrack）
去实现播放，当然我应该是先研究windows版的，
但SDL播放声音并不是很熟悉，所以可能要先琢磨较长时间。
至于krkrsdl2是怎么播放声音？它可能也是SDL2，
或者可能是通过openal和FAudio之类方法实现播放，
具体以后会深入研究，但我不会用太复杂的写法，
勉强能用就算了，可能只保留最简单的实现方法

我现在可以在xubuntu 20上用纯Makefile方式去编译
krkrsdl2的代码（非最新，但是比较新），
稍后我会尝试用其他工具链编译，看能不能交叉编译
到Linux掌机上运行，例如trimui smart pro和miyoo a30上，
可能需要对代码和编译文件列表进行修改 ​​​

我测试过，可以交叉编译krkrsdl2到trimui smart pro
上（不需要修改krkrsdl2源代码），可以adb运行，
但可能有这些问题需要修改：
（1）data文件需要去除非英语文件名
（2）没有全屏，显示在左下角
（3）手柄有部分未映射，但ABXY可用
（4）关闭对话框无法测试，而且可能
关闭对话框可能用到OpenGL，可能无法显示
（但不影响实用）（5）可能只支持utf-8字符集的脚本，
所以需要想办法兼容kirikiri2的sjis字符集

我测试过krkrsdl2可以运行在rg28xx和trimui smart pro
和trimui birck上，无法满屏，rg28xx会转90度；
无法运行在miyoo a30，原因不明（我看不到控制台输出内容）。
所以短时间内我不会开源我的移植代码——其实自己编译都可以，
因为我几乎没怎么改动它的代码——我打算大概把转屏90度
问题和无法全屏问题和utf-8字符集改成gbk（或sjis）
这些问题都解决了才会考虑开源，大概等好几个月吧，
当然我有可能搁置。目前我主要还是希望解决opentk的移植问题，
这个krkrsdl2不打算很优先去解决

krkrsdl2 linux掌机移植研究。Linux掌机上无法全屏的问题解决了，
简单来说就是原版就有这功能，只要修改就可以，
例如安卓端的窗口大小是不受脚本影响的，脚本只能影响视口的长宽比例，
所以我只要改成和安卓端类似的代码即可，原版是有一个宏。
不过我没有用原版的做法全屏，顺便也发现另一个问题，
其实关闭框是弹出新对话框的，但在安卓模式下是叠在
原来窗口内的上方，全部填满，如果是相同大小的话就会看到放大的效果

krkrsdl2移植linux掌机研究。关于旋转90度问题（270度），
可以用类似onscripter的方法SDL_RenderCopyEx转屏——这个方法不是我想的，
应该是gh上很早就有的做法。当然对于krkrsdl2来说还需要多设置
一下视口（SDL_RenderSetViewport）。目前键位有问题，
miyoo a30需要放在app内才能执行（不能通过文件管理器），
至于rg28xx和trimui smart pro和trimui brick都可以正常运行
（通过文件管理器），我计划只测试这四款Linux掌机

krkrsdl2移植linux掌机研究。魔改krkrsdl2的textstream，
把kirikiroid2的gbk字符集转码代码接进去（同时支持gbk和sjis和utf8），
然后在PC上跑起来，效果如下。有bug，脱字了，如果加载sjis不会脱字。
注意我其实并没有解决字符集问题，我是魔改krkrsdl2和krkrz的代码
并且魔改了游戏本身，如果不魔改游戏，就需要做兼容处理，
然而兼容kr2的工作量巨大，目前还做不到——至少目前
做不到kirikiroid2的兼容程度

krkrsdl2移植linux掌机之研究。我现在可以勉强解决
miyoo a30无法用文件管理器启动krkrsdl2的闪退问题——方法是照搬
commander的launch.sh写法——但问题是如果用这种写法虽然能在
文件管理器（commander）里面启动，但却又无法在主菜单的app中启动，
所以我是写了两个sh文件，能在文件管理器启动的sh文件改名成
别的如launch2.sh，而且这两种启动方式产生的存档文件位置
也不同——简单来说就是还是不清楚为什么会这样，
只能解释说很有可能是程序自己主动闪退而不是系统的问题

关于krkrsdl2和kirikiroid2的linux掌机移植，
我目前计划尽可能在过年前开源这两个的linux掌机移植代码，
至少也要完成开源krkrsdl2的linux掌机移植代码——当然我的
标准是能跑spring days这个游戏就算成功了，
不会考虑其他大部分kirikiri2游戏的兼容性——事实上也有可能做不到，
因为kirikiri2游戏一般都有防D版的措施

krkrsdl2研究，脱字问题解决，猜测可能因为字体文件ttf不支持某个字，
就会脱字了，把默认字体文件换成另一个字体文件即可
（我是复制kirikiroid2里面最大的那个ttf），
不用krkrsdl2提供的那个字体文件（system_polyfill/font.ttf），
就可以解决。具体如果加断点的话是在FreeType.cpp
里面的GetGlyphFromCharcode和LoadGlyphSlotFromCharcode，
大概相当于SDL_ttf的作用（krkrz没有用SDL_ttf而是
直接通过FreeType库画像素）。至此可能还差声音和键位问题未解决

kirikiroid2移植到Linux掌机研究。费了九牛二虎之力终于可以
在PC上Linux环境下编译和运行起来，但目前只能看到开头
（PC模拟非交叉编译），后面就跑不下去了（crash）。
基本上我是照着Android版移植去改，但比较麻烦，
比移植krkrsdl2要麻烦，主要因为代码太复杂，引用了更多的库，
容易产生更多的编译错误。保守估计要几个月时间才能跑起来
（当然如果心情不好的话可能很快就能跑通）。
另外虽然我之前已经移植过cocos2d-x，但这个可能还需要继续研究，
因为我可能遗漏了一些关于cocos2d-x的问题，这也需要更多时间

krkrsdl2移植到linux掌机研究，声音问题解决。krkrsdl2把关于
ogg vorbis解码器代码删除了，
可以想办法把这段代码VorbisWaveDecoder.cpp从kirikiroid2
里面复制过来，然后稍微修改一下WaveIntf.cpp即可
（参考opus的register方法代码，只有一两行）。
如果想下断点，可以通过gdb的catch throw下异常断点，
就能定位到播放声音失败抛异常的具体位置，
这方面比起安卓和Windows要容易很多（当然如果用VS的话也支持异常断点）。
值得一提的是，这段缺失的代码（见同作者的krkrv）
也是来源于kirikiroid2的，而kirikiroid2可能是
参考kirikiri3-legacy（可能也是出自kirikiri2的），
也有可能是出自krkrz/wuvorbis，原版的ogg播放插件，
不过kirikiri2的ogg插件用的库非常旧，我这里是自己
找了一个较新版本的vorbis代码放入krkrsdl2代码中编译

krkrsdl2移植linux掌机研究。目前krkrsdl2移植已经非常接近完成状态，
还差键位和kr2游戏兼容这两个大问题（俩都可忽略），
如果是kirikiroid2移植则还在只能编译成功的酝酿阶段。
其实键位问题可以不管，因为trimui两款机都是可以按到键位的，
而krkrsdl2源码也有类似onscripter的键位映射函数
（但krkrsdl2似乎不支持手柄），
如果其他掌机暂时解决不了的话就先不管了。
而kr2游戏兼容则需要手工修改游戏文件，
如果不修改就能兼容估计比较难，如果做不到也搁置不管了。
总体来说krkrsdl2本来就有linux支持，我只是想尽可能让它兼容
krkr2的游戏，甚至外面就有人问krkrsdl2的作者类似的兼容问题，
我想作者是故意和不愿意解决，或者作者希望通过打包转换器来解决
（例如ogg转换成opus，sjis转换成utf8），至于我，我可能也做不到完美，
但我可能在过年前就开源现阶段的移植成果，等时机成熟再作下一步的改进，
而不一定一步到位就做到最好的krkr2兼容能力收起

krkrsdl2移植到Linux掌机研究。关于键位问题，我猜测可能是这样，
miyoo a30是按键输入，rg28xx是摇杆输入（但目前还不知道怎么读方向键，
这台机没办法adb所以很难调试），trimui smart pro和trimui brick
键位可能类似rg28xx但不确定。这些我晚上测试一下。 

krkrsdl2移植到Linux掌机研究。关于按键和摇杆映射，我大概整理一下，
可能只有Save/Load功能（可能还有自动快进）不好映射键位，
其他应该都可以和onscripter的部分键位对应上，大概是：
A和B是回车和空格确定；X是快进（到未读或下分支）；Y是消息记录
（原本应该是上下文菜单但这里似乎没有这功能）；Start自动；
Menu退出；Select是关闭自动（可能合并到Start）；
L1是后退。当然这个只是初步想法，可能实际要慢慢调整试验

krkrsdl2移植linux掌机研究，正在调试键位问题，
试试在trimui smart pro上运行的效果，声音是正常的——不过这游戏不是我做的，
但可以勉强跑起来（游戏文件魔改过，后面可能有个线程锁问题会卡住，
但前面部分是正常的），对于这个krkrsdl2来说trimui smart pro
有一部分键位是正确的，不过也有一部分需要调整，
但相对会好一些，其他掌机就几乎对不上

krkrsdl2移植linux掌机研究。暂时还没改好键位，
不过目前看来trimui smart pro大部分键位
（除了电源键和两个音量键是键盘事件）
应该和rg28xx相似，都是控制器（手柄）的输入事件，
而又因为krkrsdl2其实已经做了手柄适配了（我看错了），
所以能对得上，我之前没发现是因为它是通过SDL_ControllerButtonEvent
事件输入而不是SDL_JoyButtonEvent，
但这两者接收事件的按钮序号并非所有情况都一样，
有时候甚至会不一样，对于krkrsdl2而言会忽略joybutton事件，
只会判断SDL_ControllerButton事件，
稍后我会尝试修改这段映射逻辑

krkrsdl2移植到linux掌机研究。第一次在linux上用adb，
感觉比windows版要好一些，好处有这些：可以tab补全输入；
可以Ctrl+C退出程序但不退出adb；adb push可以看到进度 

krkrsdl2移植linux掌机研究，改了很久，
目前关于键位问题还有这些（后续可能尽量改一下或者不管）：
（1）按ESC后无法再进入快进(F键)和消息记录(R键)
（2）手柄问题可能需要改两处或更多，例如A和B可能还
要修改读键盘状态判断是否按下手柄A和B（读状态
需要改成读键盘同时读手柄）
（3）显示退出框时会crash（SDL2同时显示两个框
在掌机上会不行）
（4）实际上原版的键位映射是基于KAG3，
或者说需要tjs脚本也考虑手柄按键，
可能并不是真的映射成键盘

krkrsdl2移植linux掌机研究，目前键位我是这样定的
（当然这是我说要定义成这样，并不一定是对的）：
AB（手柄右按钮的右和下）都是一样功能的回车和空格，
X（手柄右按钮的上）是消息记录，Y（手柄右按钮的左）
是菜单（选择Save/Load/History），L1是后退，
R1是快进，Start是自动Auto，Select无功能，Menu是退出

krkrsdl2移植linux掌机研究，感觉可能下周还不能发布和开源，
估计还能再拖几个星期，但我保证过年前（这个月底26日前）
能发布，因为其实现在都可以发布，只是我想再改良一下，
因为目前的bug还是很多——虽然原作者的原版已经非常完美了，
但毕竟原版不是专门用于kr2的，如果要改成加载kirikiri2
游戏是会有各种难解决的问题，这很难做得完美，
至少短时间内不行，我觉得要一两年时间才能打磨好，
类似的onscripter也是这样

kirikiroid2移植linux掌机研究，我试试用linux掌机trimui smart pro
跑了一下，可以勉强跑起来，大概效果是这样，
但看来还是有很多问题，总之目前还只是简单修改阶段，
大概距离可用还有很长的时间，应该是没办法在过年前整出来的，
预计起码要两三个月，但至少可以跑起来，
也算是很大的进度吧，但比移植krkrsdl2要困难许多，
毕竟krkrsdl2本来就有linux版的，kirikiroid2
实际上连linux版都没有我就想一下子就移植到linux掌机上，
应该是会更麻烦许多

krkrsdl2移植linux掌机研究，因为最近比较忙，所以进度会比较慢。
差不多尾声阶段了（虽然目前只是初步的开发），
可能再过一星期就里程碑了。目前在解决兼容问题，
我通过System.exePath的方法（我自己想出来的，可能不够正式）
用C++方式注入代码PolyfillInitialize.tjs到startup.tjs，
然后在PolyfillInitialize.tjs中通过System.exePath
把一些字体文件和兼容代码注入到相应的地方，这样就不需要
修改游戏文件data.xp3了——当然这只是对我的测试用例而言，
要做到完美几乎是不可能，例如kirikiroid2也有很多类似的
兼容问题，出现大量运行期错误对话框，我现在改的这个也
会出现类似情况

我测试过目前krkrsdl2我的修改版的PC版已经基本能跑通了，
通过注入代码的方式跑kirikiri2游戏《Spring Days》，
不需要手工修改data.xp3了。
这几天试试跑一下linux掌机版（我之前试过好像也没太大问题，
不过之前是要改data.xp3内容才行），如果有时间我会试试
能不能跑《实妹相伴的大泉君》这个日文版游戏，
当然如果不行也无所谓了，我只是想看看兼容能力如何，
估计目前兼容能力还是比较差，要时间打磨一下代码

krkrsdl2移植linux掌机研究。忘记改transition问题
（beginTransition方法的name参数），我简单起见改
成遇到未实现的渐变类型就替换成crossfade（如果不
这么改会很麻烦），目前在掌机上可以运行《Spring Days》
（虽然效果可能会不对）到打穿，声音也正常，
可能还有一些地方未测试，明天再研究 ​​​

krkrsdl2移植linux掌机研究。现在有些一言难尽的困难，
主要在PC上可以用的键位功能，到了trimui smart pro
掌机上就会不行，头大。例如，自动快进（F键）
在掌机上可以用，但手工快进（Ctrl键）就不行了。
另外现在最大的bug是存档会失败，不知道是不是报错了
还是键位要改成enter回车，可能要专门找时间研究一下，
所以我很可能下周周末再开源，目前还是bug无限多

krkrsdl2移植linux掌机研究。关于按键映射Ctrl
（手动快进）的问题，我暂时可以在PC上用手柄按R1快进
（不清楚掌机情况如何），我的做法是，
不是判断手柄R1的按下状态，
而是R1按下后把一个变量设置为1，然后读这个变量，
当读到第8次之后复位为0，根据这个变量来判断R1是否按下，
每次读取VK_CONTROL状态时返回这个状态

krkrsdl2移植linux掌机研究。
关于在掌机运行时存档读档失败的问题，
我已放弃，这意味着我搞的这么多其实还是不能用，
最大的bug就是无法save/load存档读档，
当然有很多原因，其中一个原因是我发现按掌机上的A
（回车或空格）它没办法进入存档格子，
正常是会弹出对话框；
第二个原因是Linux掌机目前还不能让SDL2弹出对话框
（SDL2支持子窗口，但Linux掌机可能不行，
因为Linux掌机没有x11环境）。
所以因为这两个原因，我决定这次开源不解决这个问题，
这个问题可能需要很长时间才能解决（例如我能解决子窗口问题）

krkrsdl2移植linux掌机研究。我尝试用我编译的程序运行
《实妹相伴的大泉君》，结果是——那当然是跑不了，原因嘛，
简单的说法就是如果data.xp3不能用garbro直接打开，
那肯定也无法用魔改版krkrsdl2打开；如果复杂的说法，
就是缺少xp3filter.tjs或者patch.tjs的功能支持，
虽然这俩的支持是kirikiroid2特有的，
至于能否补上去我还没研究，按道理是可以的。
如果我能做到，我会把这个功能做上去但默认会关闭。
其实这里有个梗，在tieba有一个梗图说明这个问题
《【教学】Kirikiroid2[吉里吉里模拟器] 下载&使用》，
我看过那张梗图觉得挺逗的

krkrsdl2移植linux掌机研究。准备晚上开源算了，
虽然还是有很多问题。效果如下。目前来说只移植了三个，
trimui smart pro和trimui brick的存档功能用不了，
而miyoo a30的键位还是不行和不能存档
（a30可以SDL2子窗口，但方向键不行），
总之就是调到吐了，就这样吧，以后有机会再改了，
今晚开源后可能会先搁置，研究别的
```
