---
title: c/cpp笔记
date: 2026-04-23 08:00:00
image: 45243652_p0-楽園の素敵な巫女.webp
draft: true
---

# 目录

- [目录](#目录)
- [cpp概览](#cpp概览)
  - [cpp的历史](#cpp的历史)
- [语法](#语法)
  - [C++98](#c98)
    - [OOP](#oop)
  - [C++11](#c11)
- [cpp的编译](#cpp的编译)
  - [为什么需要cpp工程构建](#为什么需要cpp工程构建)
    - [多文件管理](#多文件管理)
      - [一个标准.h文件的例子](#一个标准h文件的例子)
      - [头文件的由来](#头文件的由来)
    - [复杂项目的处理](#复杂项目的处理)
  - [构建工具](#构建工具)
    - [make](#make)
    - [是什么,怎么用](#是什么怎么用)
    - [make处理makefile的原理](#make处理makefile的原理)
    - [ninja](#ninja)
    - [是什么,怎么用](#是什么怎么用-1)
    - [高级构建工具: CMake](#高级构建工具-cmake)
      - [命令行使用](#命令行使用)
      - [编写CMakelist](#编写cmakelist)
        - [CMakelists.txt的前置内容](#cmakeliststxt的前置内容)
        - [CMake的基础特性](#cmake的基础特性)
      - [实战](#实战)
- [早期版本存档](#早期版本存档)
  - [cpp历史](#cpp历史)
    - [1. 诞生背景与“带类的 C”（1979 - 1982）](#1-诞生背景与带类的-c1979---1982)
    - [2. C++ 奠基时代（1983 - 1991）](#2-c-奠基时代1983---1991)
    - [3. 标准化与工业成熟期（1998 - 2003）](#3-标准化与工业成熟期1998---2003)
    - [4. 现代 C++ 复兴（2011 - 2020）](#4-现代-c-复兴2011---2020)
  - [基础语法](#基础语法)
    - [关键字](#关键字)
      - [const与volatile](#const与volatile)
      - [static](#static)
      - [static\_cast与其他的类型转换](#static_cast与其他的类型转换)
      - [constexpr](#constexpr)
      - [decltype](#decltype)
    - [指针与引用](#指针与引用)
      - [指针实质](#指针实质)
      - [void\*,NULL与nullptr](#voidnull与nullptr)
      - [数组中的指针](#数组中的指针)
      - [const指针](#const指针)
      - [引用实质](#引用实质)
    - [new/delete操作符](#newdelete操作符)
    - [struct和enum](#struct和enum)
      - [struct](#struct)
      - [enum](#enum)
    - [OOP](#oop-1)
      - [this指针](#this指针)
        - [-\>运算符](#-运算符)
      - [一个完整的类的示例](#一个完整的类的示例)
    - [宏替换与别名](#宏替换与别名)
    - [io](#io)
      - [读入多行](#读入多行)
      - [scanf和printf](#scanf和printf)
  - [进阶特性](#进阶特性)
    - [左值引用和右值引用](#左值引用和右值引用)
    - [智能指针](#智能指针)
    - [为什么类和结构体定义时结尾要加一个分号](#为什么类和结构体定义时结尾要加一个分号)
  - [STL(Standard Template Library )](#stlstandard-template-library-)
    - [通用](#通用)
      - [iterator(迭代器)详解](#iterator迭代器详解)
      - [memset()详解](#memset详解)
      - [sort()详解](#sort详解)

# cpp概览
## cpp的历史

# 语法

## C++98
- 第一个正式的C++标准,统一了cpp的各种语法,引入了STL,并在C++03中进行了大量的修正



### OOP
## C++11
- 现代C++的起点,引入了auto,智能指针等现在被广泛应用的新特性




# cpp的编译
## 为什么需要cpp工程构建
- [参考1](https://docs.eesast.com/docs/languages/C&C++/multi-file_programming)
- [参考2](https://learn.microsoft.com/zh-cn/cpp/cpp/header-files-cpp?view=msvc-170)

### 多文件管理
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

#### 一个标准.h文件的例子
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

#### 头文件的由来
我们需要明确一个事实:cpp标准从没有规定cpp文件和头文件名字的扩展名要求!
事实上如果你将main函数放入x.txt文件中,照样可以正常编译:
```bash
# g++根据扩展名推断语言,所以这里需要用-x c++强制指令语言为cpp,而且我们产生的exe文件使用了txt后缀也没报错
g++ -x c++ x.txt -o result.txt
```
换句话说,`.cpp`,`.h`这些后缀只不过是人为约定的而已,你在里面写的内容与文件名可以毫无关系,也就是说,就算你在头文件里实现了函数的定义也没关系,只要你没有导入进两个或更多文件里,就不会导致函数的重定义进而引发编译器的报错.
### 复杂项目的处理
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

## 构建工具
- [GNU make](https://www.gnu.org/software/make/manual/make.html)
- [ninja作者自述](https://aosabook.org/en/posa/ninja.html)
- [ninja官网](https://ninja-build.org/)
为了解决上述的问题,先后诞生了两种主流的cpp构建工具: make和ninja,它们可以指挥gcc或者其他编译器进行所需的构建.
### make
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

### ninja
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
### 高级构建工具: CMake
现在来到了我们的重头戏:CMake,先来看一下[wiki介绍](https://zh.wikipedia.org/wiki/CMake)
>CMake是个一个开源的跨平台自动化建构系统，用来管理软件建置的程序，并不依赖于某特定编译器，并可支持多层目录、多个应用程序与多个函数库.
>CMake的配置文件取名为**CMakeLists.txt**,它并不直接建构出最终的软件，而是产生标准的构建文件（如Unix的Makefile）
>
>CMake”这个名字是**Cross platform Make**的缩写。虽然名字中含有“make”，但是CMake和Unix上常见的make系统是分开的，而且更为高阶

- 既然CMake是用来指挥ninja,make等构建文件的,自然它就是高级构建工具了.

#### 命令行使用
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
# ...省略一大堆支持的平台
```

#### 编写CMakelist
当我们运行的是别人的项目时,知道如何用CMake构建就足够了,但很多时候我们都要自己写CMake来构建项目,这就需要我们去深入了解CMakelists的写法了.
- [官方教程](https://cmake.org/cmake/help/latest/guide/tutorial/index.html)
##### CMakelists.txt的前置内容
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

##### CMake的基础特性
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


#### 实战
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


# 早期版本存档
- 26年3月的系列文字,写的不清不楚,也不够深入,很多都没写完,之所以没删掉,是认为那个时候的我尽管很菜,但确实有一些思维上的闪光点值得日后回顾.

## cpp历史
- [wiki](https://en.wikipedia.org/wiki/C%2B%2B)

### 1. 诞生背景与“带类的 C”（1979 - 1982）
Bjarne Stroustrup 在贝尔实验室工作期间，因分析 UNIX 内核需要，试图结合 **Simula** 的抽象能力与 **C** 的高效性能。
* **1979年**：开始研发 **“C with Classes”**（C++ 的前身）。
* **核心特性**：引入类（Classes）、继承（Derived Classes）、强类型检查、内联函数（Inlining）和默认参数。

### 2. C++ 奠基时代（1983 - 1991）
* **1983年**：正式更名为 **C++**（利用 C 语言的自增运算符 `++`，寓意 C 的进化）。
* **1984年**：实现首个 **流输入/输出库（Stream I/O）**。
* **1985年**：
    * 发布经典著作 **《The C++ Programming Language》** 第一版。
    * 首个商业化 C++ 编译器正式面世。
* **1989年 (C++ 2.0)**：引入多重继承、抽象类、静态成员函数、`const` 成员函数以及 `protected` 访问权限。
* **1990年**：发布《The Annotated C++ Reference Manual》，为后续标准化工作奠定逻辑框架。

### 3. 标准化与工业成熟期（1998 - 2003）
* **1998年 (C++98)**：第一个国际标准 ISO/IEC 14882:1998 发布。
    * **里程碑特性**：**模板（Templates）**、异常处理、命名空间（Namespaces）、布尔类型、STL（标准模板库）正式入标。
* **2003年 (C++03)**：一个主要针对 C++98 的技术修正版本，修复了大量编译器实现层面的细节问题，稳定性提升。

### 4. 现代 C++ 复兴（2011 - 2020）
在经历了长达 8 年的停滞后，C++ 进入了高频迭代周期：
* **2011年 (C++11)**：**具有划时代意义的“新 C++”**。
    * **核心特性**：自动类型推导（`auto`）、Lambda 表达式、右值引用（Rvalue references）与移动语义、智能指针、基于范围的 `for` 循环。
* **2014年 (C++14)**：对 C++11 的微调与完善，增强了泛型 Lambda 和 `constexpr` 的能力。
* **2017年 (C++17)**：引入结构化绑定、`std::optional`、`std::variant`、文件系统库（Filesystem API）以及对并行的原生支持。
* **2020年 (C++20)**：被称为继 C++11 后最大的变革。
    * **四大支柱**：**概念（Concepts）**、**范围（Ranges）**、**协程（Coroutines）**、**模块（Modules）**。



## 基础语法
- [官方文档](https://cppreference.com/cpp/language/type)
  - 非常难啃,很书面化,不太推荐

### 关键字
#### const与volatile
- [参考](https://eel.is/c++draft/dcl.type.cv)
使用const修饰`int x`的时候,与单纯的写`int x`在内存区域上的表现没有什么不同,也就是说,const是一个编译时关键字,保证在运行时没有任何指令可以修改这块内存区域.

>Any attempt to modify a const object during its lifetime results in undefined behavior.

而**volatile**强制编译器取消对这个变量的运行期优化,要求每次对这个变量的操作都实际发生在内存,但现在基本很难看见这个关键字了.
#### static
- [来源](https://www.runoob.com/w3cnote/cpp-static-usage.html)

>我们知道在函数内部定义的变量，当程序执行到它的定义处时，编译器为它在栈上分配空间，函数在栈上分配的空间在此函数执行结束时会释放掉，这样就产生了一个问题: 如果想将函数中此变量的值保存至下一次调用时，如何实现？ 最容易想到的方法是定义为全局的变量，但定义一个全局变量有许多缺点，最明显的缺点是破坏了此变量的访问范围（使得在此函数中定义的变量，不仅仅只受此函数控制）。static 关键字则可以很好的解决这个问题。
>
>另外，在 C++ 中，需要一个数据对象为整个类而非某个对象服务,同时又力求不破坏类的封装性,即要求此成员隐藏在类的内部，对外不可见时，可将其定义为静态数据。

**TL;DR**:

（1）在修饰变量的时候，static 修饰的静态局部变量只执行初始化一次，而且延长了局部变量的生命周期，直到程序运行结束以后才释放。
（2）static 修饰全局变量的时候，这个全局变量只能在本文件中访问，不能在其它文件中访问，即便是 extern 外部声明也不可以。
（3）static 修饰一个函数，则这个函数的只能在本文件中调用，不能被其他文件调用。static 修饰的变量存放在全局数据区的静态变量区，包括全局静态变量和局部静态变量，都在全局数据区分配内存。初始化的时候自动初始化为 0。


#### static_cast与其他的类型转换
- [参考](https://www.cnblogs.com/wanghongyang/p/15054880.html)
- [StackOverflow上的解答](https://stackoverflow.com/questions/332030/when-should-static-cast-dynamic-cast-const-cast-and-reinterpret-cast-be-used)

当我们需要强制更改变量类型的时候,应该考虑到一点:
- 如果直接在内存对应地址增加或者减小它的占用空间大小,显然会导致各种各样的内存问题.
因此,类型转换一般是不更改内存的,而是在编译时告诉编译器这个变量的类型改变了,请你按照改变后的类型来处理这个变量.

>隐式类型转换是安全的，显式类型转换是有风险的，C语言之所以增加强制类型转换的语法，就是为了强调风险，让程序员意识到自己在做什么。
>
>但是，这种强调风险的方式还是比较粗放，粒度比较大，它并没有表明存在什么风险，风险程度如何。
>
>为了使潜在风险更加细化，使问题追溯更加方便，使书写格式更加规范，C++ 对类型转换进行了分类，并新增了四个关键字来予以支持，它们分别是：
| 关键字                 | 说明                                                                                                                          |
| :--------------------- | :---------------------------------------------------------------------------------------------------------------------------- |
| **`static_cast`**      | 用于良性转换，一般不会导致意外发生，风险很低。                                                                                |
| **`const_cast`**       | 用于 `const` 与非 `const`、`volatile` 与非 `volatile` 之间的转换。                                                            |
| **`reinterpret_cast`** | 高度危险的转换，这种转换仅仅是对二进制位的重新解释，不会借助已有的转换规则对数据进行调整，但是可以实现最灵活的 C++ 类型转换。 |
| **`dynamic_cast`**     | 用于多态和向下转型                                                                                                            |


#### constexpr

#### decltype



### 指针与引用
#### 指针实质
事实上,接触了差不多一年cpp,我还是没有彻底搞懂指针,教材上,网上讲的基本都是怎么用指针,简单的告诉你指针就是取地址,调用的时候就是解引用取得引用对象,但并没有告诉我,为什么这么写就能行.
试着阅读<< C++ Programming Language >>的第七章,里面是这么讲的:
>对于类型T来说,T*是`指向T的指针`的类型,换句话说,T*类型的变量能够存放T类型对象的地址.
>
>对指针的一个基本操作是解引用(dereferencing),即引用指针所指的对象,也被称为间接取值(indirection),解引用运算符为`*`.
比如:
```cpp
char c = 'a';
char* p = &c;
char c2 = *p;
```
但书上到这里就戛然而止了,相当于啥都没讲,并没有触及底层的设计理念.不过话说回来,指针是从c传下来的,不关cpp设计的事.🙂

那么,为什么要这样写呢,也就是说,为什么不能直接写`char p = &c;`来存储地址,然后再把这个解引用运算符用来根据地址p来找到原来的c变量呢?

思考一下,`char p = &c`只是定义了一个char变量而已,也就是规定死了为1字节长,这里由于没用unsigned char,故只能取到0-127的地址值,因为地址的绝对值显然不会为负值.

显然,与其用char,我们不如用`long long int`类型来存储高达8字节的地址值,从而保证能存取足够多的地址,也就是这样写:
```cpp
char c = 'a';
long long p =&c;
```

那么,取到地址之后我们又要怎么根据这个地址取到应该取的值呢?

>要知道,变量值是分布在一块连续内存上的,你并不知道这个地址的前后是什么,可能是程序的核心部分,也可能是上次运行后尚未清除的缓存垃圾.当然,我们可以根据p所引用的变量c的类型来判断要读取的连续字节数,比如在我们的例子中p对应的是`char c`,也就是说我们只需要在这个地址往后取一个字节,就可以找回这个变量c存储的值了.

可是,上述的论述中有一个问题,那就是p只是存储了c的地址而已,**它并不知道c的类型**!那么,显然我们需要一种标识来取代单纯的**long long p**声明,这个标识还需要能够表明我所引用地址对应变量的类型.
比如,为了满足上述的要求,它可以写成类似`long long char **mark**`的形式,但显然这太长了,也太丑了...

但我们又可以想到,既然指针需要使用long long类型来保证取到尽可能多的地址,那么`long long`这个部分就可以省略了,上述例子从而简化成了`char **mark**`,让编译器根据这个**mark**来了解这是一个需要用long long来存储的指针变量.

那么,问题就简化到了这个**mark**用什么符号来表示比较好.

非常可惜的是,c语言的设计者们并没有想过将解引用符号`*`和取指针符号**mark**分开来表示,而是直接把**mark**定为了`*`,从而导致了学习c语言的无穷痛苦...

所以,回到这一句:
```cpp
char* p = &c;
```
我们现在可以很清楚的知道, 这个p是一个long long大小的变量,存储了char类型变量c的地址,尽管美中不足的是,这个标记`*`偏偏和解引用的`*`是同一个符号!

#### void*,NULL与nullptr
`void*`是一个指向void类型的指针,由于不存在有一个void类型的变量,故这个指针自然没有任何指向对象,也就无法进行解引用去取对象,无法进行算术运算.在使用时必须显式地转换成某一特定类型的指针.
- 在实际生产中很少被用在上层设计中,多用于底层的资源调度

现在我们根据**__stddef_null.h**来看一看NULL
```cpp
#ifdef __cplusplus
#if !defined(__MINGW32__) && !defined(_MSC_VER)
#define NULL __null
#else
#define NULL 0
#endif
#else
#define NULL ((void*)0)
#endif
```
可以清楚的发现NULL事实上是一个宏,有时候是0,有时候是一个...,`(void*)0`,这是什么东西?
还是从一个简单代码起步好了,我们知道,有时候需要将一个高位类型比如int,塞入一个低位类型比如char中,由于直接塞进去的话编译器会警告可能会丢失值,所以我们可以这样写:
- 注意: static_cast我会在后面涉及,而且在C语言中我们只能这样强制转换.
```cpp
int s = 999999999;
char c = (char)s;
```
我们可以更进一步,加入指针试试:
```cpp
int* p = (int*)100;   // 把数字 100 强制转换成 int* 类型
// 现在 p 指向的“地址”是 100
// 这是一个非常危险的操作，实际程序几乎永远不应该这么写
```
你可能会很好奇,这怎么就取到地址100了呢,真正取地址100,应该写成以下形式:
```cpp
int* p = &100;
```
但事实上这段代码会报错,因为&无法作用于100这样一个纯右值(可以理解为临时值).

当然你会说: 就算这样,我也不能接受`(int*)100`怎么就直接简单的变成地址100了!

我们可以这样理解,`(int*)100`必须得指向一个东西,因为如果不指向某个东西的话,说明它是一个类似于`int* p`这样没有赋值的野指针,但是`(int*)100`并不是这样,它是一个指向int类型的"右值100",那么我不能随便让它指向某块区域,否则就会导致内存混乱,最好指向一个与它的内容"100"有关系的区域,那么在设计者的角度来看,自然是指向地址100比较好了,实际应用中的编译器也是这么处理的.(当然我的这段分析可能是错误的,甚至整个都错了,但是我们需要牢牢记住: `(int*)100`就是地址100!)


经过上面的一大段分析,那么`(void*)0`就比较好理解了:将int类型的0强制转换成指向void类型的地址0,而地址0由于受到保护,故不能被解引用和运算,从而将NULL变成一个受保护的空指针.

很显然,void*和NULL并不够直观和好用,所以c++11引入了nullptr这个关键字用来表示空指针,这里我没有给源码,是因为这个nullptr与int,double这些类型一样,是一个编译器硬编码的运行期对象,不存在用一个库来定义nullptr.

既然nullptr叫做空指针,那么自然无法给int,double这些普通类型变量赋值,而是只能给指针变量赋值:
```cpp
struct Node {
    int data;
    Node* left;
    Node* right;

    Node(int val)
        : data(val)
        , left(nullptr)
        , right(nullptr)
    {}
};
```
如果不赋与nullptr这个初始值,就会产生野指针,从而导致各种各样的内存问题.


#### 数组中的指针
当我们需要处理一个分组的数据比如{1,2,3,4,5}时,我们可以这样写:
```cpp
//{1,2,3,4,5}
int s =12345; //将s作为存储变量
int s1=s/10000;
int s2=s/1000%10;
int s3=s/100%10;
int s4=s/10%10;
int s5=s%10;
```
自然,当数据量过大时这么写就有点过分了,显然不应该用某一个普通的int型或者long long型变量来存数据,而是应该转换思路,用一块连续内存来存数据,从而保证能够容纳足够大的数据量.

因此可以引入一个新的符号,姑且称为x,我们希望这个x可以实现以下几个要求:
1. 初始值为这个存储变量s的首地址,对应的是存储对象列表的第一个元素
2. 根据存储对象的类型(这里是int)得到相邻元素之间的内存距离
3. 可以经过简单的数学运算获取任意一个元素的位置,这被称为**随机存取**

你有可能会想,怎么能有这么好的事可以一下子解决三个问题呢?

但根据前面的讨论,我们知道:指针可以用来映射到一块特定的内存上,也就是说我们可以将指针对准这个存储变量的首地址,并且可以简单的对指针进行加减操作,从而取到下一个元素的地址甚至是任意一个元素的地址!所以,问题解决了.

于是,我们应该可以这么写:
```cpp
int *s =mark(1,2,3,4,5);
```
很显然,这个mark应该能够做到以下事情:
1. 告诉编译器这是一个数据列表,而不是别的什么
2. 为*s提供这个数据列表的首地址

尽管我们可以设计成类似`$(1,2,3,4,5)`或者`#(1,2,3,4,5)`这种比较正常的标记方式,但遗憾的是设计者想起来还有`{}`这个大括号没用过,于是将`mark()`变成了`{}`.(另一个好处是,在早期一个字符的开销也很重要的时候,可以减少表达式所用的字符).

于是,我们或许可以这样写:
```cpp
int *s={1,2,3,4,5};

int s1 = *s;
int s2 = *(s+1);
int s3 = *(s+2);
int s4 = *(s+3);
int s5 = *(s+4);
```
但如果你试着去运行的话,这串代码一定会报错!因为设计者并没有让这个mark成功做到上述的两个事情,上述的一系列设想都是我们的**一厢情愿**.

相反,`{}`只是一个构造器,没有任何返回值,必须需要等号左边部分的配合才可以填入值,而不能单独存在.

如果你好奇为什么的话,我们可以这样想,当你写 {1,2,3,4,5} 时，这五个整数总得找个地方落脚:
- 如果存放在栈（Stack）上，那么当函数执行完毕，这块内存就会被回收。此时你的指针 s 将变成一个恐怖的野指针。
- 如果存放在静态区（Data Segment），那么这块内存就是只读的，你无法在运行时修改它。
- 如果存放在**堆（Heap）**上，谁来负责 delete 它？C++ 的设计哲学是“不为不使用的东西付费”，这种隐式的内存分配违背了确定性。

因此,在将指针指向这个数据列表之前,我们需要先为这个数据列表分配一个合适的地址.
换句话说,我们还需要引入一个新类型变量来存储这个数据列表的地址,因为现有的变量类型是无法存入列表的.

同时,我们应该让这个新类型能够规范数据列表内部的类型为单一的一种,因为如果这个列表内又有int,又有long long,在用指针访问元素时必然出现混乱.

我们不妨写成这样:
```cpp
int mark(t) = {1,2,3,4,5};
int *s = t;
```
这个mark()出色的完成了以下两个任务:
1. 通知编译器划出该数据列表的空间
2. 为*s提供这个数据列表的首地址

更加遗憾的是,设计者又想起来还有`[]`这个中括号没用过...于是整个代码变成了我们熟悉的样子:
```cpp
int t[] = {1,2,3,4,5};
int *s = t;

int s1 = *s;
int s2 = *(s+1);
int s3 = *(s+2);
int s4 = *(s+3);
int s5 = *(s+4);
```
当然,本着物尽其用的原则,`[]`空在那里显然不太好看,于是设计者动了点巧思,让它在初次定义的时候可以规定划定的空间大小,并且在定义之后,能作为解引用符号来访问特定元素:
```cpp
int t[5] = {1,2,3,4,5};

int s1 = t[0]; //t[0] 等价于 *(t+0)
int s2 = t[1];
int s3 = t[2];
int s4 = t[3];
int s5 = t[4];
```
尽管这个设计很精妙,但我的意见是,与其让一个符号承担多个责任,不如清楚的用不同符号区分责任,(我的意见自然是不重要的).

值得一提的是**数组退化**问题:
```cpp
// 虽然形参写成 int arr[]，但在编译器眼里它就是 int* arr
void process(int arr[]) {
    // 这里的 sizeof(arr) 返回的是指针的大小（通常是 8 字节），而不是数组的总大小
    std::cout << "函数内部 sizeof(arr): " << sizeof(arr) << " bytes" << std::endl;

    // 通过指针偏移修改内存，会直接影响原数组
    arr[0] = 99; 
}

int main() {
    int my_array[5] = {1, 2, 3, 4, 5};
    
    std::cout << "函数外部 sizeof(my_array): " << sizeof(my_array) << " bytes" << std::endl;
    
    // 传递数组名，触发退化：int[5] -> int*
    process(my_array);

    std::cout << "修改后的首元素: " << my_array[0] << std::endl;
    return 0;
}
```
当经过上述一系列讨论后,这个问题的答案就显然易见了,process()函数传入的是数组的首地址,那么就应该用指针`int *arr`来处理了,至于为什么形参可以写成`int arr[]`或者`int arr[5]`,那可以理解为设计者还想让这个`[]`继续发光发热,既可以在形参中表示这是一个数组的首地址,还可以填入这个数组的预想空间大小-尽管实际运行时是不起作用的.


>综上所述,本来我们可以通过各种各样的标识来区分`[]`一个符号干的不同活儿,但遗憾的是cpp已经被设计成了这个样子了,那么只好随它去了.

#### const指针
```cpp
void f(char* p){
    char s[]="Gorm";

    const char* pc = s; //指向常量的指针
    pc[3] = 'g'; //错误,pc指向常量
    pc = p; //OK

    char* const cp = s; //指向char的常量指针
    cp[3] = 'a'; //OK
    cp = p; //错误,cp是一个常量

    const char* const cpc = s; //指向常量的常量指针
    cpc[3] = 'a' //错误,cpc指向常量
    cpc = p; //错误,cpc是一个常量
}
```
我们可以根据这段代码得出以下结论:
1. 当指针指向的变量使用const修饰时,无论指向的变量是否是常量,通过指针访问这个变量时都不允许做任何修改;但是,指针可以更改它指向的变量,也就是更改存储的地址内容
2. 当指针被设定为常量时,其存储的地址内容不允许再被修改,也就是固定与初始化的变量绑定,但是可以通过指针修改绑定变量的内容
3. 当常量指针指向常量时,既不能修改绑定变量,又不可以修改被绑定的变量的内容,怎么用都很安全


#### 引用实质
由于指针过于复杂和难懂,我们希望找到另外一种简单的方式,解决跨越函数和文件更改变量值的问题,因此,我们引入了引用(`&`)这个概念.
当我们写出以下代码时:
```cpp
int a = 123;
int &b = a;
```
应该有一个疑问: 变量b是什么?

由于这里没有取地址符号,故b不是指针;它也不是一个新变量,因为当我们改变b的值的时候,a的值也会同步改变.

那么,我们可以这样想:既然这个变量既不是一个指针,也不是一个变量,那么他就只能是一个临时值,换句话说,b是一个只存在于编译期的变量,作为绑定变量的别名,不会被存入内存中.
- 尽管从底层来看的话,引用还是一个指针,因为你终归是要将这个别名指向原变量的

### new/delete操作符
### struct和enum
#### struct
- struct是一个可以存放不同类型变量,甚至可以存放函数的数组,在内存中按照变量的声明顺序依次存储,按字节对齐

当结构体尚未完成声明时,我们可以直接使用这个结构体的指针,因为指针的内存空间是已知的,固定为8字节;但是你不能声明结构体本身,因为结构体的内存还是未知的.
```cpp
struct Link{
    Link* previous;
    Link* successor;
};

// 下面这个结构体会编译失败
struct Failed_Link{
    Failed_Link s;
};

```
#### enum
### OOP
#### this指针
- [菜鸟教程](https://www.runoob.com/cplusplus/cpp-this-pointer.html)
- [官方文档](https://en.cppreference.com/w/cpp/language/this.html)

this指针是class/结构体中的**隐藏指针**,指向当前实例,可以被直接调用:
```cpp
#include <iostream>
 
class MyClass {
private:
    int value;
 
public:
    void setValue(int value) {
        this->value = value;
    }
 
    void printValue() {
        std::cout << "Value: " << this->value << std::endl;
    }
};
 
int main() {
    MyClass obj;
    obj.setValue(42);
    obj.printValue();
 
    return 0;
}
```
##### ->运算符
上述代码中出现了`->`,它的本质是对指针对象进行解引用后再使用成员运算符`.`访问属性,用代码表示是这样的:
```cpp
void printValue() {
        std::cout << "Value: " << this->value << std::endl;
        // 等价于
        *this.value << std::endl;

    }
```

#### 一个完整的类的示例
```cpp
// class.cpp
// compile with: /EHsc
// Example of the class keyword
// Exhibits polymorphism/virtual functions.

#include <iostream>
#include <string>
using namespace std;

class dog
{
public:
   dog()
   {
      _legs = 4;
      _bark = true;
   }

   void setDogSize(string dogSize)
   {
      _dogSize = dogSize;
   }
   virtual void setEars(string type)      // virtual function
   {
      _earType = type;
   }

private:
   string _dogSize, _earType;
   int _legs;
   bool _bark;

};

class breed : public dog
{
public:
   breed( string color, string size)
   {
      _color = color;
      setDogSize(size);
   }

   string getColor()
   {
      return _color;
   }

   // virtual function redefined
   void setEars(string length, string type)
   {
      _earLength = length;
      _earType = type;
   }

protected:
   string _color, _earLength, _earType;
};

int main()
{
   dog mongrel;
   breed labrador("yellow", "large");
   mongrel.setEars("pointy");
   labrador.setEars("long", "floppy");
   cout << "Cody is a " << labrador.getColor() << " labrador" << endl;
}
```

### 宏替换与别名
```cpp
//别名,只用于类型替换
using NewType = OldType;
//示例
using ll =long long;
using vec = std::vector<int>;

//文本替换
#define NAME replacement

//示例

#define PI 3.1415926
#define MAX 100

/*
但也可以带入参数
*/
#define SQR(x) ((x)*(x))
#define LOOP(i,n) for(int i=0;i<n;i++)

//typedef -using的下位替代,基本没用
typedef OldType NewType;
//示例
typedef long long ll;
```
### io
#### 读入多行
`cin>>`遇到空格或换行符会停止输入,想要读取一整行需要使用`getline(cin,s1) 这样的格式
#### scanf和printf
```c
int age;
char name[20];

// 1. 缓冲区残留坑：读取字符/字符串前，若上方有残余换行符，需手动处理
printf("Enter age: ");
if (scanf("%d", &age) != 1) return 1; // 2. 返回值坑：必须检查返回值以确认物理输入成功

printf("Enter name: ");
// 3. 溢出与空格坑：使用 %s 无法读取空格且易越界。限制长度并注意数组名本身是地址
scanf("%19s", name); 

// 4. 格式化输出：printf 严格对应类型，%d 对应整型，%s 对应字符串
printf("Data: Name=%s, Age=%d\n", name, age);
```

## 进阶特性

### 左值引用和右值引用
- [参考1](https://blog.csdn.net/m0_59938453/article/details/125858335)
- [参考2](https://nettee.github.io/posts/2018/Understanding-lvalues-and-rvalues-in-C-and-C/)




### 智能指针

### 为什么类和结构体定义时结尾要加一个分号
- [问题讨论](https://www.zhihu.com/question/441151329)

一种看法是将结构体的定义看作是类似与`int a = 1;`这样的变量声明,自然要加分号,而class源自struct,自然也保留了分号.
- 不过java成功的去掉了这个烦人的分号,加一分.

## STL(Standard Template Library )
在vscode里右键对应的头文件或方法,选择查找定义,则可以找到对应的stl源代码.
### 通用
- .size()方法是STL里通用的求容器长度的方法
- `memset(a, 0, sizeof(a));`or`memset(a, -1, sizeof(a));`是好用的重置大法

#### iterator(迭代器)详解

#### memset()详解
```h
void* __cdecl memset(
    _Out_writes_bytes_all_(_Size) void*  _Dst,
    _In_                          int    _Val,
    _In_                          size_t _Size
    );
```
- `__cdecl,_Out_writes_bytes_all_(_Size), _In_`: 这三个都是Microsoft专用的修饰用宏,由于太过底层所以不用去关注
- `void*  _Dst`: 空指针,指向对象内存区
- `int    _Val`: 填充内容,实际上函数底层会将int强制转换为unsigned char,故只有低8位有效.而且,由于memset的内部机制是逐字节将这低8位填入目标内存区域,如果传入1,则会导致填入内容为(0x01010101),无法做到将填入对象置为1的效果,故只能传入(-1和0),从而一致归0或者一致归1.
- `size_t _Size`: 传入单位为字节,而非直觉上以为的元素个数,这也是为什么不能直接写`memset(a,-1,n)`的原因.
  - 正确的写法为`memset(a,-1,sizeof(a))`,sizeof是一个编译时运算符,用于获取对象占用的字节空间,并非是一个库函数.




#### sort()详解
```cpp

template <class _RanIt, class _Pr>
_CONSTEXPR20 void _Sort_unchecked(_RanIt _First, _RanIt _Last, _Iter_diff_t<_RanIt> _Ideal, _Pr _Pred) {
    // order [_First, _Last)
    for (;;) {
        if (_Last - _First <= _ISORT_MAX) { // small
            _STD _Insertion_sort_unchecked(_First, _Last, _Pred);
            return;
        }

        if (_Ideal <= 0) { // heap sort if too many divisions
            _STD _Make_heap_unchecked(_First, _Last, _Pred);
            _STD _Sort_heap_unchecked(_First, _Last, _Pred);
            return;
        }

        // divide and conquer by quicksort
        auto _Mid = _STD _Partition_by_median_guess_unchecked(_First, _Last, _Pred);

        _Ideal = (_Ideal >> 1) + (_Ideal >> 2); // allow 1.5 log2(N) divisions

        if (_Mid.first - _First < _Last - _Mid.second) { // loop on second half
            _STD _Sort_unchecked(_First, _Mid.first, _Ideal, _Pred);
            _First = _Mid.second;
        } else { // loop on first half
            _STD _Sort_unchecked(_Mid.second, _Last, _Ideal, _Pred);
            _Last = _Mid.first;
        }
    }
}

_EXPORT_STD template <class _RanIt, class _Pr>
_CONSTEXPR20 void sort(const _RanIt _First, const _RanIt _Last, _Pr _Pred) { // order [_First, _Last)
    _STD _Adl_verify_range(_First, _Last);
    const auto _UFirst = _STD _Get_unwrapped(_First);
    const auto _ULast  = _STD _Get_unwrapped(_Last);
    _STD _Sort_unchecked(_UFirst, _ULast, _ULast - _UFirst, _STD _Pass_fn(_Pred));
}

_EXPORT_STD template <class _RanIt>
_CONSTEXPR20 void sort(const _RanIt _First, const _RanIt _Last) { // order [_First, _Last)
    _STD sort(_First, _Last, less<>{});
}
```
先解释一下难看懂的地方:
1. _RanIt: Random Access Iterator,可用[]进行定向访问的迭代器
2. _Iter_diff_t<_RanIt>:迭代器之间的差,可以用来体现容器长度
3. `constexpr int _ISORT_MAX = 32`
4. _Pred: cmp函数,排序规则,根据最下方函数可知默认使用`less<>{}`,即从小到大排
5. `for (;;) `: 编译速度与`while(1)`没有任何区别,只是个人习惯或者历史遗留问题而已

可以看到sort函数内部对于不同的容器有三种处理方式:
1. 当容器大小不大于32时,使用插入排序;
2. 当递归深度太大时,转而使用堆排序
3. 默认使用快速排序

现在,仔细看一下快速排序的代码:
```cpp
// divide and conquer by quicksort
        auto _Mid = _STD _Partition_by_median_guess_unchecked(_First, _Last, _Pred);

        _Ideal = (_Ideal >> 1) + (_Ideal >> 2); // allow 1.5 log2(N) divisions

        if (_Mid.first - _First < _Last - _Mid.second) { // loop on second half
            _STD _Sort_unchecked(_First, _Mid.first, _Ideal, _Pred);
            _First = _Mid.second;
        } else { // loop on first half
            _STD _Sort_unchecked(_Mid.second, _Last, _Ideal, _Pred);
            _Last = _Mid.first;
        }
```
大致结构与平常io写的快排没有任何区别,只是专业化了一点而已







