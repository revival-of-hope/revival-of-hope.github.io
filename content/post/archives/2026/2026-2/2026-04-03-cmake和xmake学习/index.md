---
title:  cpp工程构建-自底向上方法
tags:
  - cpp
date: 2026-04-03 08:00:00
image: 76422957_p0-無題.webp
---
# 前置知识: cpp编译原理(4/8)

## 编译器种类
市面上有三大主流编译器

1. 微软开发的**MSVC**(Microsoft Visual C++),集成在VS中,另外一个在Windows系统常用的**MinGW**编译器则是GCC的物理移植版
2. 开源的**GCC**(GNU Compiler Collection),主要在Linux中使用
3. 基于GCC和LLVM(开源编译器后端)的**Clang**,由苹果公司赞助,是macOS唯一官方支持的编译器,集成在Xcode中.

当然现在的电脑性能这么好,用哪个编译器都可以.

## 编译的全过程
当我们使用GCC编译Hello World程序时,只需要这样写:
```bash
gcc hello.c -o ./a.out
# './a.out'是文件名和路径,后缀名可以随便起,写成tho没有后缀或者a.xyz也可以
```
上述过程可以分解为4个步骤:
1. 预处理(Preprocessing)
2. 编译(Compilation)
3. 汇编(Assembly)
4. 链接(Linking)

**流水线解释**
- 预处理: 转换宏定义,删除注释
- 编译(狭义): 将cpp源码翻译成汇编代码(人类可读)
- 汇编:
  - 将汇编代码翻译成**机器指令**(二进制码)
  - 根据机器指令,地址位置等信息构造**目标文件**
- 链接: 将目标文件与系统库,用户库关联起来,得到可执行文件
- 编译(广义): 由于大多数人对cpp的装载过程没有一个清晰的认识,故通常使用编译代指从`.cpp`到`.exe`的全过程,也就是说我们一般都用广义的编译概念,很少特指"真正的编译"

但是,我们所用的编译器如gcc,clang等都是广义上的编译器,也就是说不仅仅做的是编译,而是包揽了从`.cpp`到`.exe`的全构建过程.
如果用前端和后端的概念来划分的话,是这样的:
#### 前端（Frontend）
**范畴：** 仅包含“编译”这一步的前半部分。
* **输入：** 预处理后的源码。
* **任务：** 词法分析（Lexical Analysis）、语法分析（Syntax Analysis）、语义分析（Semantic Analysis）、生成**中间表示（IR, Intermediate Representation）**。
* **特性：** 与具体的硬件架构（如 x86、ARM）无关，只与语言本身的规则有关。



#### 后端（Backend）
**范畴：** 包含“编译”这一步的后半部分，以及“汇编”的全部。
* **任务：** * **中端优化（Optimizer）**：对 IR 进行架构无关的优化。
    * **代码生成（Code Generator）**：将 IR 转换为特定硬件的**汇编代码**。
    * **汇编器（Assembler）**：将汇编代码转换为机器指令，产出目标文件。
* **特性：** 强依赖于硬件架构。

#### 其他项
* **预处理（Preprocessing）**：通常被视为编译前的“文本清洁工作”，不属于狭义编译器（Compiler Core）的前后端逻辑。
* **链接（Linking）**：属于编译链条的下游，是一个独立的二进制处理过程，不属于编译器（Compiler）的范畴。



# 为什么需要cpp工程构建
- [参考1](https://docs.eesast.com/docs/languages/C&C++/multi-file_programming)
- [参考2](https://learn.microsoft.com/zh-cn/cpp/cpp/header-files-cpp?view=msvc-170)

## 多文件管理
在一个文件里导入其他文件中的变量有两种方法:
**1.使用extern关键字**
```cpp
// 文件 A (data.cpp) 
struct Counter {
    int value;
    void display() const {
        std::cout << value << std::endl;
    }
};

Counter g_tracker = {100};
int global_count = 100;

// 文件 B (main.cpp)
extern int global_count;
extern Counter g_tracker;

void print_count() {
    g_tracker.display();
    std::cout << global_count << std::endl;
}

int main() {
    print_count();
    return 0;
}
```
也就是说我们需要在用到这个变量的时候使用extern关键字来声明,才能让编译器明白这个变量是要到其他文件中去找的.

**2.使用头文件**
当需要共享的变量或函数过多时,再一个个写extern不太现实,所以**cpp使用者**设计了单独的文件类型用来存放共享变量(包括常量,外部变量)的声明,也就是.h文件.
```cpp
// vars.h
#ifndef VARS_H
#define VARS_H
// include guard,防止同一个头文件在同一个cpp文件中被多次导入
extern int shared_val; // 声明
#endif

// vars.cpp
#include "vars.h"
int shared_val = 42; // 定义
```

当然,更为常见的是用class来封装变量和函数再放入.h文件,并在对应的cpp文件里实现:
**cocos示例项目**
```cpp
//AppDelegate.h
#ifndef  _APP_DELEGATE_H_
#define  _APP_DELEGATE_H_

#include "cocos2d.h"

class  AppDelegate : private cocos2d::Application
{
public:
    AppDelegate();
    virtual ~AppDelegate();

    virtual void initGLContextAttrs();

};

#endif // _APP_DELEGATE_H_

//同名cpp文件,其实起什么名字都行,但为了标准化还是同名为好
#include "AppDelegate.h"
// 导入后进行实现
AppDelegate::AppDelegate()
{
}

AppDelegate::~AppDelegate() 
{
#if USE_AUDIO_ENGINE
    AudioEngine::end();
#elif USE_SIMPLE_AUDIO_ENGINE
    SimpleAudioEngine::end();
#endif
}

void AppDelegate::initGLContextAttrs()
{
    // set OpenGL context attributes: red,green,blue,alpha,depth,stencil,multisamplesCount
    GLContextAttrs glContextAttrs = {8, 8, 8, 8, 24, 8, 0};

    GLView::setGLContextAttrs(glContextAttrs);
}
// ...诸如此类的实现
```

### 一个标准.h文件的例子
- `#pragma once`: 'pragma' 源自希腊语 'pragma'（意为“行动”或“事项”）,代指编译指令,整体的意思是只编译一次,也就是第二次在同一个cpp文件里遇到这个头文件时跳过编译
  - 是msvc最早开始启用的预处理指令,之后GCC,Clang也开始支持这个指令,但至今都未纳入cpp标准中
  - 这个奇怪的名字显然是某个自以为很有修养的工程师提出来的,正常人是不会这么起名的

以下示例显示了头文件中允许的各种声明和定义：

```cpp
// sample.h
#pragma once

#include <vector> // #include directive
#include <string>

namespace N  // namespace declaration
{
    inline namespace P
    {
        //...
    }

    enum class colors : short { red, blue, purple, azure };

    const double PI = 3.14;  // const and constexpr definitions
    constexpr int MeaningOfLife{ 42 };
    constexpr int get_meaning()
    {
        static_assert(MeaningOfLife == 42, "unexpected!"); // static_assert
        return MeaningOfLife;
    }
    using vstr = std::vector<int>;  // type alias
    extern double d; // extern variable

#define LOG   // macro definition

#ifdef LOG   // conditional compilation directive
    void print_to_log();
#endif

    class my_class   // regular class definition,
    {                // but no non-inline function definitions

        friend class other_class;
    public:
        void do_something();   // definition in my_class.cpp
        inline void put_value(int i) { vals.push_back(i); } // inline OK

    private:
        vstr vals;
        int i;
    };

    struct RGB
    {
        short r{ 0 };  // member initialization
        short g{ 0 };
        short b{ 0 };
    };

    template <typename T>  // template definition
    class value_store
    {
    public:
        value_store<T>() = default;
        void write_value(T val)
        {
            //... function definition OK in template
        }
    private:
        std::vector<T> vals;
    };

    template <typename T>  // template declaration
    class value_widget;
}
```

- 你很有可能会问为什么头文件中函数,class,struct等高级数据类型的声明不需要用extern修饰,而单独的变量声明却必须要用extern修饰?
  - extern的原理是: 告诉编译器这个变量在别处已经定义;如果单纯写`int x;`,那么编译器就认为这是一个未进行初始化的新定义,会为x再次申请4字节的内存,从而引发重定义报错
  - 函数的声明默认是为extern的
  - 而类和结构体的声明不需要extern,因为它们本身不产生任何内存分配,只有实例化的对象才需要内存分配

### 头文件的由来
我们需要明确一个事实:cpp标准从没有规定cpp文件和头文件名字的扩展名要求!
事实上如果你将main函数放入x.txt文件中,照样可以正常编译:
```bash
# g++根据扩展名推断语言,所以这里需要用-x c++强制指令语言为cpp,而且我们产生的exe文件使用了txt后缀也没报错
g++ -x c++ x.txt -o result.txt
```
换句话说,`.cpp`,`.h`这些后缀只不过是人为约定的而已,你在里面写的内容与文件名可以毫无关系,也就是说,就算你在头文件里实现了函数的定义也没关系,只要你没有导入进两个或更多文件里,就不会导致函数的重定义进而引发编译器的报错.
## 复杂项目的处理
当然,如果只有一两个文件的话,我们只用g++进行编译也够了,比如有一个`main.cpp`和一个`tools.cpp`文件,那么我们只要写:
```bash
g++ main.cpp tools.cpp -o result.exe
```
但事实上,我们需要根据各种各样的需求加上各种各样的参数:

| 参数                   | 分类   | 作用说明                                                                          | 示例                           |
| :--------------------- | :----- | :-------------------------------------------------------------------------------- | :----------------------------- |
| **`-o <file>`**        | 基础   | **指定输出文件名**。如果不使用，Linux 默认生成 `a.out`，Windows 默认 `a.exe`。    | `g++ main.cpp -o app`          |
| **`-c`**               | 基础   | **只编译，不链接**。将 `.cpp` 转化为二进制目标文件 `.o`，用于大型项目的增量编译。 | `g++ -c tools.cpp`             |
| **`-I <dir>`**         | 基础   | **指定头文件搜索路径**。当 `#include` 的头文件不在当前目录或标准库时使用。        | `g++ main.cpp -I./include`     |
| **`-L <dir>`**         | 基础   | **指定库文件搜索路径**。告诉编译器去哪里找 `.so` 或 `.a` 静态/动态库文件。        | `g++ main.cpp -L./libs`        |
| **`-l<name>`**         | 基础   | **链接指定的库**。紧跟库名（自动去掉 `lib` 前缀和 `.so`/`.a` 后缀）。             | `g++ main.cpp -lpthread`       |
| **`-g`**               | 调试   | **生成调试信息**。在使用 `gdb` 调试器时，必须加此参数才能看到源码行号。           | `g++ -g main.cpp -o debug_app` |
| **`-Wall`**            | 警告   | **开启常规警告**。检测潜在的逻辑错误（如变量未初始化、类型不匹配）。              | `g++ -Wall main.cpp`           |
| **`-Wextra`**          | 警告   | **开启额外警告**。比 `-Wall` 更严格，能发现更多隐蔽的代码规范问题。               | `g++ -Wall -Wextra main.cpp`   |
| **`-Werror`**          | 警告   | **将警告视为错误**。只要有任何警告出现，编译就会立即终止。                        | `g++ -Werror main.cpp`         |
| **`-O0`**              | 优化   | **不进行优化（默认）**。编译最快，生成的代码与源码一一对应，适合开发阶段。        | `g++ -O0 main.cpp`             |
| **`-O2`**              | 优化   | **标准优化**。平衡编译时间和运行速度，是大多数生产环境项目的首选。                | `g++ -O2 main.cpp`             |
| **`-O3`**              | 优化   | **激进优化**。开启更多高级手段（如循环展开），提升性能但可能增大体积。            | `g++ -O3 main.cpp`             |
| **`-Os`**              | 优化   | **体积优化**。优先缩小生成的二进制文件大小，适合嵌入式或空间受限场景。            | `g++ -Os main.cpp`             |
| **`-std=c++11/17/20`** | 标准   | **指定 C++ 语言版本标准**。开启对应年份的新特性支持（如 `auto`, `concepts`）。    | `g++ -std=c++17 main.cpp`      |
| **`-D<macro>`**        | 预处理 | **定义宏**。相当于在代码顶端写 `#define`，常用于区分测试和生产逻辑。              | `g++ -DDEBUG main.cpp`         |
| **`-E`**               | 预处理 | **只执行预处理**。查看宏展开、头文件包含后的最终代码文本，输出到屏幕。            | `g++ -E main.cpp`              |
| **`-fPIC`**            | 进阶   | **生成位置无关代码**。在编译**动态链接库**（Shared Library）时必须使用。          | `g++ -fPIC -c lib.cpp`         |

显然当文件一多,要链接的库一多,要进行的预编译一多,用g++来写是不可接受的.

让我们先以下面这个cmakelist.txt为例来看看编译时要考虑多少东西:
**cocos示例项目的CMakelists.txt**
```toml
cmake_minimum_required(VERSION 3.6)

set(APP_NAME HelloCpp)

project(${APP_NAME})

set(COCOS2DX_ROOT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cocos2d)
set(CMAKE_MODULE_PATH ${COCOS2DX_ROOT_PATH}/cmake/Modules/)

include(CocosBuildSet)
add_subdirectory(${COCOS2DX_ROOT_PATH}/cocos ${ENGINE_BINARY_PATH}/cocos/core)

# record sources, headers, resources...
set(GAME_SOURCE)
set(GAME_HEADER)

set(GAME_RES_FOLDER
    "${CMAKE_CURRENT_SOURCE_DIR}/Resources"
    )
if(APPLE OR WINDOWS)
    cocos_mark_multi_resources(common_res_files RES_TO "Resources" FOLDERS ${GAME_RES_FOLDER})
endif()

# add cross-platforms source files and header files 
list(APPEND GAME_SOURCE
     Classes/AppDelegate.cpp
     Classes/HelloWorldScene.cpp
     )
list(APPEND GAME_HEADER
     Classes/AppDelegate.h
     Classes/HelloWorldScene.h
     )

if(ANDROID)
    # change APP_NAME to the share library name for Android, it's value depend on AndroidManifest.xml
    set(APP_NAME MyGame)
    list(APPEND GAME_SOURCE
         proj.android/app/jni/hellocpp/main.cpp
         )
elseif(LINUX)
    list(APPEND GAME_SOURCE
         proj.linux/main.cpp
         )
elseif(WINDOWS)
    list(APPEND GAME_HEADER
         proj.win32/main.h
         proj.win32/resource.h
         )
    list(APPEND GAME_SOURCE
         proj.win32/main.cpp
         proj.win32/game.rc
         ${common_res_files}
         )
elseif(APPLE)
    if(IOS)
        list(APPEND GAME_HEADER
             proj.ios_mac/ios/AppController.h
             proj.ios_mac/ios/RootViewController.h
             )
        set(APP_UI_RES
            proj.ios_mac/ios/LaunchScreen.storyboard
            proj.ios_mac/ios/LaunchScreenBackground.png
            proj.ios_mac/ios/Images.xcassets
            )
        list(APPEND GAME_SOURCE
             proj.ios_mac/ios/main.m
             proj.ios_mac/ios/AppController.mm
             proj.ios_mac/ios/RootViewController.mm
             proj.ios_mac/ios/Prefix.pch
             ${APP_UI_RES}
             )
    elseif(MACOSX)
        set(APP_UI_RES
            proj.ios_mac/mac/Icon.icns
            proj.ios_mac/mac/Info.plist
            )
        list(APPEND GAME_SOURCE
             proj.ios_mac/mac/main.cpp
             proj.ios_mac/mac/Prefix.pch
             ${APP_UI_RES}
             )
    endif()
    list(APPEND GAME_SOURCE ${common_res_files})
endif()

# 省略一大堆编译项

```
- 这显然超出了g++的能力了...

# 构建工具的出现
- [GNU make](https://www.gnu.org/software/make/manual/make.html)
- [ninja作者自述](https://aosabook.org/en/posa/ninja.html)
- [ninja官网](https://ninja-build.org/)
为了解决上述的问题,先后诞生了两种主流的cpp构建工具: make和ninja,它们可以指挥gcc或者其他编译器进行所需的构建.
## make
### 是什么,怎么用
>The **make** utility automatically determines which pieces of a large program need to be **recompiled**, and issues commands to recompile them.

为了执行make命令,我们需要将它写入makefile文档来执行.

makefile的大致格式如下:
```makefile
target … : prerequisites …
        recipe
        …
        …
```
- target: 生成的目标文件名,比如中间文件(.o)和可执行文件(.exe),当然我们不指明后缀名也行,还可以是要执行的指令名如'clean'等
- prerequisites: 需要用到的源文件
- recipe: make构建时的规则

以下是一个简单的makefile示例:
```makefile
edit : main.o kbd.o command.o display.o \
       insert.o search.o files.o utils.o
        cc -o edit main.o kbd.o command.o display.o \
                   insert.o search.o files.o utils.o
# 将所有中间文件编译成可执行文件                   
# 使用\将一行长句分为两行,也就是说不带\的话默认为单独一行,而makefile中一般一行写源文件名,一行写编译规则
main.o : main.c defs.h
        cc -c main.c
kbd.o : kbd.c defs.h command.h
        cc -c kbd.c
command.o : command.c defs.h command.h
        cc -c command.c
display.o : display.c defs.h buffer.h
        cc -c display.c
insert.o : insert.c defs.h buffer.h
        cc -c insert.c
search.o : search.c defs.h buffer.h
        cc -c search.c
files.o : files.c defs.h buffer.h command.h
        cc -c files.c
utils.o : utils.c defs.h
        cc -c utils.c
clean :
        rm edit main.o kbd.o command.o display.o \
           insert.o search.o files.o utils.o
```
- 很明显,这个makefile是面向Linux系统的,毕竟有`rm`和`cc`这样的终端命令.
在当前目录输入`make`即可生成edit可执行文件,输入`make clean`即可清除中间文件
### make处理makefile的原理
默认情况下,`make`命令会从makefile里的第一个target开始执行.

>make reads the makefile in the current directory and begins by processing the first rule. In the example, this rule is for relinking edit; but before make can fully process this rule, it must process the rules for the files that edit depends on, which in this case are the object files. Each of these files is processed according to its own rule. These rules say to update each ‘.o’ file by compiling its source file. The recompilation must be done if the source file, or any of the header files named as prerequisites, is more recent than the object file, or if the object file does not exist.
>
>The other rules are processed because their targets appear as prerequisites of the goal. If some other rule is not depended on by the goal (or anything it depends on, etc.), that rule is not processed, unless you tell make to do so (with a command such as make clean).
- 也就是说,make命令只执行第一个target并解决所有的对应依赖项,不会执行第二个命令,除非显示指明

>After recompiling whichever object files need it, make decides whether to relink edit. This must be done if the file edit does not exist, or if any of the object files are newer than it. If an object file was just recompiled, it is now newer than edit, so edit is relinked.
>
>Thus, if we change the file insert.c and run make, make will compile that file to update insert.o, and then link edit. If we change the file command.h and run make, make will recompile the object files kbd.o, command.o and files.o and then link the file edit.

- make会在target对应的源文件更新时自动重新编译target,而不触及其他未改动的部分

事实上了解到这里就差不多了,毕竟现在真的没必要手写makefile了,电脑系统再怎么古老CMake应该还是能用的吧...

## ninja
### 是什么,怎么用
>Ninja is yet another **build system**. It takes as input the interdependencies of files (typically source code and output executables) and orchestrates building them, **quickly**.
- ninja能够代替古老的make的原因就在于它很快,比make快了十倍以上

>Ninja contains the barest functionality necessary to describe arbitrary dependency graphs. Its lack of syntax makes it impossible to express complex decisions.
>
> Ninja has almost no features; **just** those necessary to get builds correct while punting most complexity to generation of the ninja input files. Ninja by itself is unlikely to be useful for most projects.
- 事实上,ninja的设计初衷就是追求快速,摒弃一切不必要的功能,从而大大提高了构建速度.
  - ninja官网的说明文档在加入了一大堆参数说明后仍然远远短于make官网的说明文档

**一个简短的示例**
```bash
cflags = -Wall

rule cc
  command = gcc $cflags -c $in -o $out
# rule类似于make中的target,但用法上灵活的多
# $为变量插入声明,也就是说,这里的$cflags相当于-Wall
# 当然,我们也可以写成${cflags},看个人喜好
build foo.o: cc foo.c
```
我们需要将这段代码放入**build.ninja**文件中,再在终端执行`ninja`命令即可进行构建,用法与make的命令也基本类似.

实际上我们了解到这个程度也就足够了,只需要知道ninja的原理与make类似,但写法上灵活的多,构建速度也快的多.
# 高级构建工具: CMake
现在来到了我们的重头戏:CMake,先来看一下[wiki介绍](https://zh.wikipedia.org/wiki/CMake)
>CMake是个一个开源的跨平台自动化建构系统，用来管理软件建置的程序，并不依赖于某特定编译器，并可支持多层目录、多个应用程序与多个函数库.
>CMake的配置文件取名为**CMakeLists.txt**,它并不直接建构出最终的软件，而是产生标准的构建文件（如Unix的Makefile）
>
>CMake”这个名字是**Cross platform Make**的缩写。虽然名字中含有“make”，但是CMake和Unix上常见的make系统是分开的，而且更为高阶

- 既然CMake是用来指挥ninja,make等构建文件的,自然它就是高级构建工具了.

## 怎么用
- [参考教程](https://modern-cmake-cn.github.io/Modern-CMake-zh_CN/chapters/intro/running.html)

>除非另行说明，你始终应该建立一个专用于构建的目录并在那里构建项目。从技术上来讲，你可以进行内部构建（即在源代码目录下执行 CMake 构建命令），但是必须注意不要覆盖文件或者把它们添加到 git，所以别这么做就好。


一个经典的CMake构建流程如下:
```bash
mkdir build
# 在当前目录创建build文件夹
# 尽管这是Linux命令,但Windows的Powershell现在也支持了
cd build
cmake ..
# 根据上级目录里的CMakelists进行CMake构建
# 并将构建出来的makefile放入build文件夹中
make
# 自然,我们未必会使用make进行构建,所以还可以写成以下形式:
cmake --build .
# 在build目录中使用cmake的默认构建工具进行构建
```

但是四行命令明显太多了,我们可以这样写:
```bash
cmake -S . -B build
# -S: source,指定CMakelists所在目录
# -B: build,指定CMake的输出(如makefile,ninja.build)目录
cmake --build build
# 在build目录中使用cmake的默认构建工具进行构建
```
- 也就是说,我们可以在根目录执行cmake命令,或者进入build文件夹后再执行cmake命令

自然,当我们的电脑上安装了多种构建工具时,我们希望在初次构建时选定自己所需的那种,只需要这么写:
```bash
cmake -S . -B build -G "Ninja"
# 指定ninja
# -G: generator,构建工具
```

运行`cmake --help`可以查看基础的cmake命令和该操作系统上可用的构建工具:
```bash
cmake --help

Usage

  cmake [options] <path-to-source>
  cmake [options] <path-to-existing-build>
  cmake [options] -S <path-to-source> -B <path-to-build>

Specify a source directory to (re-)generate a build system for it in the
current working directory.  Specify an existing build directory to
re-generate its build system.

Options
  -S <path-to-source>          = Explicitly specify a source directory.
  -B <path-to-build>           = Explicitly specify a build directory.
  -C <initial-cache>           = Pre-load a script to populate the cache.
  -G <generator-name>          = Specify a build system generator.
  -T <toolset-name>            = Specify toolset name if supported by
                                 generator.
  -A <platform-name>           = Specify platform name if supported by
                                 generator.
# ...省略一大堆参数

Generators

The following generators are available on this platform (* marks default):
  Visual Studio 18 2026        = Generates Visual Studio 2026 project files.
                                 Use -A option to specify architecture.
* Visual Studio 17 2022        = Generates Visual Studio 2022 project files.
                                 Use -A option to specify architecture.
  Visual Studio 16 2019        = Generates Visual Studio 2019 project files.
                                 Use -A option to specify architecture.
  Visual Studio 15 2017        = Generates Visual Studio 2017 project files.
                                 Use -A option to specify architecture.
  Visual Studio 14 2015        = Deprecated.  Generates Visual Studio 2015
                                 project files.  Use -A option to specify
                                 architecture.
  Borland Makefiles            = Generates Borland makefiles.
  NMake Makefiles              = Generates NMake makefiles.
  NMake Makefiles JOM          = Generates JOM makefiles.
  MSYS Makefiles               = Generates MSYS makefiles.
  MinGW Makefiles              = Generates a make file for use with
                                 mingw32-make.
  Green Hills MULTI            = Generates Green Hills MULTI files
                                 (experimental, work-in-progress).
  Unix Makefiles               = Generates standard UNIX makefiles.
  Ninja                        = Generates build.ninja files.
  Ninja Multi-Config           = Generates build-<Config>.ninja files.
# ...省略一大堆
```

## 基础语法
当我们运行的是别人的项目时,知道如何用CMake构建就足够了,但很多时候我们都要自己写CMake来构建项目,这就需要我们去深入了解CMakelists的写法了.
- [官方教程](https://cmake.org/cmake/help/latest/guide/tutorial/index.html)
### CMakelists.txt的前置内容
**最低版本要求**
这是每个`CMakeLists.txt`都必须包含的第一行:

```toml
cmake_minimum_required(VERSION 4.3)
# 该命令不区分大小写,但习惯上小写
# CMake3.12以后的版本支持版本的范围要求:
cmake_minimum_required(VERSION 3.12...3.21)
```
- 如果你用的cmake版本比声明上所写的更高,由于cmake向后兼容,因此会按照声明的版本来运行.
**项目设置**
声明该项目的名字,版本号,描述,使用的语言
```toml
project(MyProject VERSION 1.0
                  DESCRIPTION "Very nice project"
                  LANGUAGES CXX)
# 项目名字之外的参数没有顺序要求
```
>When CMake sees the project() command it performs **various checks** to ensure the environment is suitable for building software; such as checking for compilers and other build tooling, and discovering properties like the endianness of the host and target machines.


这两个部分最好放在顶部或者接近顶部,如:
```toml
# ...版权声明
cmake_minimum_required(VERSION 3.23)

project(MyProjectName)
# ...剩余部分
```

### CMake的一点基础特性
>The only fundamental types in CMakeLang are **strings and lists**. Every object in CMake is a **string**, and **lists** are themselves strings which contain **semicolons** as separators.
- 由于CMake的这个特性,故CMakelist看起来非常累,没有`:`,没有单引号,也没有`--`,只通过空格,空行和缩进来体现层次关系,注释则使用`#`.

**设置变量并插入字符串**
```toml
set(var "World!")
message("Hello ${var}")
```
- set用于设置变量
- message用于打印调试信息
- `${var}`用于插入变量

## 常用命令汇总(AI总结)

### 🔧 基础命令与项目配置

| 命令 / 语法                                                | 说明                                | 示例                                                    |
| :--------------------------------------------------------- | :---------------------------------- | :------------------------------------------------------ |
| `cmake_minimum_required(VERSION ...)`                      | 指定所需 CMake 最低版本             | `cmake_minimum_required(VERSION 3.15)`                  |
| `project(Name VERSION x.x LANGUAGES CXX)`                  | 定义项目名称、版本与语言            | `project(MyApp VERSION 1.0 LANGUAGES CXX)`              |
| `add_executable(target source...)`                         | 创建可执行文件目标                  | `add_executable(app main.cpp helper.cpp)`               |
| `add_library(target [STATIC\|SHARED] source...)`           | 创建库目标（静态/动态）             | `add_library(utils STATIC utils.cpp)`                   |
| `add_subdirectory(dir)`                                    | 添加子目录构建                      | `add_subdirectory(libs/foo)`                            |
| `include_directories(dir)`                                 | 添加全局头文件搜索路径（不推荐）    | `include_directories(${CMAKE_SOURCE_DIR}/include)`      |
| `target_include_directories(target [PRIVATE\|PUBLIC] dir)` | 为目标添加头文件路径（现代用法）    | `target_include_directories(app PRIVATE include/)`      |
| `target_link_libraries(target [PRIVATE\|PUBLIC] lib...)`   | 为目标链接库                        | `target_link_libraries(app PRIVATE utils)`              |
| `target_compile_options(target [PRIVATE\|PUBLIC] flags)`   | 为目标添加编译选项                  | `target_compile_options(app PRIVATE -Wall -Wextra)`     |
| `set_target_properties(target PROPERTIES prop value)`      | 设置目标属性（如输出名称、C++标准） | `set_target_properties(app PROPERTIES CXX_STANDARD 17)` |

---

### 📦 变量与常用预设变量

| 语法 / 变量名                       | 说明                               | 示例 / 默认值                                       |
| :---------------------------------- | :--------------------------------- | :-------------------------------------------------- |
| `set(VAR value)`                    | 设置普通变量                       | `set(SRC_FILES main.cpp utils.cpp)`                 |
| `set(VAR value CACHE TYPE "doc")`   | 设置缓存变量（可被命令行覆盖）     | `set(ENABLE_TESTS ON CACHE BOOL "Build tests")`     |
| `list(APPEND VAR value)`            | 向列表变量追加值                   | `list(APPEND SRC_FILES extra.cpp)`                  |
| `option(VAR "description" default)` | 定义布尔选项（缓存）               | `option(BUILD_SHARED_LIBS "Build shared libs" OFF)` |
| `${VAR}`                            | 引用变量                           | `message("Source files: ${SRC_FILES}")`             |
| `CMAKE_SOURCE_DIR`                  | 顶层 CMakeLists.txt 所在目录       | 自动由 CMake 设置                                   |
| `CMAKE_BINARY_DIR`                  | 顶层构建目录                       | 执行 `cmake` 的目录                                 |
| `CMAKE_CURRENT_SOURCE_DIR`          | 当前处理的 CMakeLists.txt 所在目录 | -                                                   |
| `CMAKE_CXX_STANDARD`                | 设置 C++ 标准（全局）              | `set(CMAKE_CXX_STANDARD 17)`                        |
| `PROJECT_NAME`                      | 当前项目名称                       | `message(${PROJECT_NAME})`                          |
| `PROJECT_SOURCE_DIR`                | 当前项目源码根目录                 | 同 `CMAKE_SOURCE_DIR`（若仅一个项目）               |
| `PROJECT_BINARY_DIR`                | 当前项目构建目录                   | 通常为 `${CMAKE_BINARY_DIR}` 子目录                 |

---

### 🔍 查找依赖与包管理

| 命令                                                | 说明                 | 示例                                                    |
| :-------------------------------------------------- | :------------------- | :------------------------------------------------------ |
| `find_package(Package [REQUIRED] [COMPONENTS ...])` | 查找并加载外部依赖包 | `find_package(OpenCV REQUIRED COMPONENTS core imgproc)` |
| `find_library(VAR name PATHS ...)`                  | 查找库文件路径       | `find_library(MATH_LIB m)`                              |
| `find_path(VAR name PATHS ...)`                     | 查找头文件所在目录   | `find_path(CURL_INCLUDE_DIR curl/curl.h)`               |


---

### 🔀 条件判断与循环

| 语法                                                | 说明                      | 示例                                                     |
| :-------------------------------------------------- | :------------------------ | :------------------------------------------------------- |
| `if(condition) ... elseif() ... else() ... endif()` | 条件分支                  | `if(WIN32) ... elseif(UNIX) ... endif()`                 |
| `foreach(var IN LISTS list) ... endforeach()`       | 列表循环                  | `foreach(src ${SRC_FILES}) message(${src}) endforeach()` |
| `while(condition) ... endwhile()`                   | while 循环                | `while(${counter} LESS 10) ... endwhile()`               |
| `break()` / `continue()`                            | 跳出循环 / 进入下一次迭代 | 在循环内使用                                             |
| `AND` / `OR` / `NOT`                                | 逻辑运算符                | `if(NOT DEFINED VAR)`                                    |
| `EXISTS path`                                       | 判断文件/目录是否存在     | `if(EXISTS ${CMAKE_SOURCE_DIR}/config.h)`                |
| `TARGET target`                                     | 判断目标是否已定义        | `if(TARGET mylib)`                                       |


---

### ⚙️ 函数与宏

| 语法                                         | 说明                             | 示例                                                     |
| :------------------------------------------- | :------------------------------- | :------------------------------------------------------- |
| `function(name arg1 arg2) ... endfunction()` | 定义函数（变量作用域独立）       | `function(print_msg msg) message(${msg}) endfunction()`  |
| `macro(name arg1 arg2) ... endmacro()`       | 定义宏（变量作用域与调用者相同） | `macro(add_sources) list(APPEND SRC ${ARGN}) endmacro()` |
| `return()`                                   | 从函数或文件中提前返回           | `if(NOT VALID) return() endif()`                         |
| `include(file)`                              | 载入并执行其他 CMake 脚本        | `include(cmake/Utilities.cmake)`                         |


---

### 📁 文件操作与安装

| 命令                                      | 说明                                         | 示例                                                     |
| :---------------------------------------- | :------------------------------------------- | :------------------------------------------------------- |
| `file(GLOB VAR pattern)`                  | 使用通配符获取文件列表（不推荐用于源码收集） | `file(GLOB HEADERS "include/*.h")`                       |
| `file(COPY src DESTINATION dst)`          | 复制文件/目录                                | `file(COPY config.yaml DESTINATION ${CMAKE_BINARY_DIR})` |
| `configure_file(input output @ONLY)`      | 替换模板变量生成配置文件                     | `configure_file(config.h.in config.h @ONLY)`             |
| `install(TARGETS target DESTINATION dir)` | 安装目标（可执行文件、库）                   | `install(TARGETS app DESTINATION bin)`                   |
| `install(FILES file DESTINATION dir)`     | 安装普通文件                                 | `install(FILES README.md DESTINATION share/doc)`         |
| `install(DIRECTORY dir DESTINATION dir)`  | 安装目录                                     | `install(DIRECTORY assets/ DESTINATION share/assets)`    |

---

\
### 🖨️ 消息输出与调试

| 命令                                             | 说明               | 示例                                            |
| :----------------------------------------------- | :----------------- | :---------------------------------------------- |
| `message([STATUS\|WARNING\|FATAL_ERROR] "text")` | 打印消息           | `message(STATUS "Configuring ${PROJECT_NAME}")` |
| `message(STATUS "var = ${var}")`                 | 打印变量值         | 常用于调试                                      |
| `message(FATAL_ERROR "missing dependency")`      | 致命错误，停止配置 | -                                               |

---

## 实战
```toml
cmake_minimum_required(VERSION 3.6)

set(APP_NAME cpp-empty-test)

project(${APP_NAME})

if(NOT DEFINED BUILD_ENGINE_DONE)
# DEFINED: 关键字,检查该变量是否用set关键字定义过
    set(COCOS2DX_ROOT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../..)
    # CMAKE_CURRENT_SOURCE_DIR: 内置变量,表示当前的txt文件所在目录
    # /..表示往上级查找,相当于找到上两级的根目录
    set(CMAKE_MODULE_PATH ${COCOS2DX_ROOT_PATH}/cmake/Modules/)
# CMAKE_MODULE_PATH: 内置变量,存放查找自定义脚本文件的搜索路径
    include(CocosBuildSet)
    # include: 关键字,执行对应的自定义CMake脚本文件
    add_subdirectory(${COCOS2DX_ROOT_PATH}/cocos ${ENGINE_BINARY_PATH}/cocos/core)
    #  add_subdirectory: 将该目录加入构建系统
endif()

# record sources, headers, resources...
set(GAME_SOURCE)
set(GAME_HEADER)
# 我们之前的set都会在名字后面加对应的变量名,如果不加默认为空字符串,如果先前已经定义则会重置该变量为空.

set(GAME_RES_FOLDER
    "${CMAKE_CURRENT_SOURCE_DIR}/Resources"
    )
if(APPLE OR VS)
    cocos_mark_multi_resources(cc_common_res RES_TO "Resources" FOLDERS ${GAME_RES_FOLDER})
endif()
# APPLE: cmake内置变量,根据当前平台判断是否为真
# VS: cocos自定义变量,判断是否使用VS进行编译

list(APPEND GAME_HEADER
     Classes/AppMacros.h
     Classes/HelloWorldScene.h
     Classes/AppDelegate.h
     )
list(APPEND GAME_SOURCE
     Classes/AppDelegate.cpp
     Classes/HelloWorldScene.cpp
     )
# 将对应的文件添加到先前定义的两个列表变量中
if(ANDROID)
    # change APP_NAME to the share library name for Android, it's value depend on AndroidManifest.xml
    set(APP_NAME cpp_empty_test)
    list(APPEND GAME_SOURCE
         proj.android/app/jni/main.cpp
         )
elseif(LINUX)
    list(APPEND GAME_SOURCE
         proj.linux/main.cpp
         )
elseif(WINDOWS)
    list(APPEND GAME_HEADER
         proj.win32/main.h
         )
    list(APPEND GAME_SOURCE
         proj.win32/main.cpp
         ${cc_common_res}
         )
elseif(APPLE)
    if(IOS)
        list(APPEND GAME_HEADER
             proj.ios/AppController.h
             proj.ios/RootViewController.h
             )
        set(APP_UI_RES
            proj.ios/LaunchScreen.storyboard
            proj.ios/LaunchScreenBackground.png
            proj.ios/Images.xcassets
            )
        list(APPEND GAME_SOURCE
             proj.ios/main.m
             proj.ios/AppController.mm
             proj.ios/RootViewController.mm
             ${APP_UI_RES}
             )
    elseif(MACOSX)
        set(APP_UI_RES
            proj.mac/Icon.icns
            proj.mac/Info.plist
            proj.mac/en.lproj/MainMenu.xib
            proj.mac/en.lproj/InfoPlist.strings
            )
        list(APPEND GAME_SOURCE
             proj.mac/main.cpp
             ${APP_UI_RES}
             )
    endif()
    list(APPEND GAME_SOURCE ${cc_common_res})
endif()

set(all_code_files
    ${GAME_HEADER}
    ${GAME_SOURCE}
    )
# 将两个列表变量打开后送入变量all_code_files中

# mark app complie info
if(NOT ANDROID)
    add_executable(${APP_NAME} ${all_code_files})
    # 使用所有文件编译成对应名字的可执行程序
else()
    add_library(${APP_NAME} SHARED ${all_code_files})
    add_subdirectory(${COCOS2DX_ROOT_PATH}/cocos/platform/android ${ENGINE_BINARY_PATH}/cocos/platform)
    target_link_libraries(${APP_NAME} -Wl,--whole-archive cpp_android_spec -Wl,--no-whole-archive)
endif()

target_link_libraries(${APP_NAME} cocos2d)
# target_link_libraries: 关键字,指定链接器将cocos2d库和游戏可执行文件绑定
target_include_directories(${APP_NAME} PRIVATE Classes)
# 当你在 .cpp 文件中写 #include "HelloWorldScene.h" 时，编译器需要知道去哪里找这个文件。默认情况下，编译器只在当前源文件所在目录和系统目录里找。

# 这行命令相当于告诉编译器：
# “编译 ${APP_NAME} 的源文件时，记得额外去 Classes 目录下搜索头文件。”
```
根据这个cmakelist,我们大致可以明白cmake的构建过程:
1. 配置编译时要用到的环境变量
2. 设置要进行编译的文件(如这里的GAME_HEADER和GAME_SOURCE)
3. 针对不同的平台设置不同的编译链
4. 加入静态和动态库链接


拓展阅读:
- [比官网写得更好的cmake教程](https://hsf-training.github.io/hsf-training-cmake-webpage/)