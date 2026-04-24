---
title: 2026-04-02 GNU介绍
tags:
  - 开源
date: 2026-04-02 08:00:00
image: 85603687_p0-天依.webp
---

- [GNU官网](https://www.gnu.org/)

我一直在使用GNU提供的各种软件,却从来没有好好的去深入理解这个组织,所以写了这篇文章来介绍一下.
## 历史
>[wiki](https://en.wikipedia.org/wiki/GNU)
GNU is a recursive acronym for "GNU's Not Unix!", chosen because GNU's design is Unix-like, but differs from Unix by being free software and containing no Unix code.
- [软件列表](https://www.gnu.org/software/software.html)
GNU组织名下的几百个软件本身就足够用来组成一个Linux操作系统了,尽管GNU名下的操作系统都不是很出名就是了...
但是,GNU组织名下还有几个著名的软件: Bash,gcc,gdb,make,Emacs.每一个都有着举足轻重的地位

## Bash
- [官方](https://www.gnu.org/software/bash/manual/bash.html#Bash-POSIX-Mode-1)
- [wiki](https://zh.wikipedia.org/wiki/Bash)
>Bash是Bourne shell的后继兼容版本与开放源代码版本，它的名称来自Bourne shell（sh）的一个双关语（Bourne again / born again）：Bourne-Again SHell。
>
>Bash is an interactive command interpreter and command language developed for **Unix-like operating systems**.

- 大多数Linux系统都默认使用Bash作为脚本执行工具
## gcc
- [官网](https://www.gnu.org/software/gcc/)
- gcc全名为**GNU Compiler Collection**
>The GNU Compiler Collection includes front ends for **C, C++**, Objective-C, Objective-C++, Fortran, Ada, **Go**, D, Modula-2, COBOL, **Rust**, and Algol 68 as well as libraries for these languages (libstdc++,...). GCC was originally written as the compiler for the GNU operating system. The GNU system was developed to be 100% free software, free in the sense that it respects the user's freedom.

我们需要知道的是,gcc通过不同的前端部分处理不同的编程语言,在经过中间处理后,使用相同的后端部分翻译成可执行文件,这种构造使得语言开发者不用太多的考虑中间文件到机器语言的转换.
## gdb
- [官网](https://www.sourceware.org/gdb/)

>GDB, the **GNU Project debugger**, allows you to see what is going on `inside' another program while it executes -- or what another program was doing at the moment it crashed.
- GDB can run on most popular UNIX and Microsoft Windows variants, as well as on macOS.

在vscode里对cpp程序进行断点调试靠的就是gdb

## make
- [官网](https://www.gnu.org/software/make/manual/make.html)
cpp的底层构建工具,不必多谈
## Emacs
- [官网](https://www.gnu.org/software/emacs/tour/index.html)
Emacs是一个"重量级"文本编辑器(当然比vscode还是要轻量的多),支持的基础功能就有很多,如下方表格所示:
| 功能模块       | 基础版内置支持说明                                           |
| :------------- | :----------------------------------------------------------- |
| **文本编辑**   | 缓冲区（Buffer）管理、无限撤销（Undo）、矩形编辑、宏录制     |
| **文件系统**   | Dired（目录浏览器）、远程文件编辑（TRAMP）、多文件全局搜索   |
| **编程辅助**   | 语法高亮（Font Lock）、自动缩进、S-expression 导航、基础补全 |
| **多任务管理** | 窗口（Window）任意切分、框架（Frame/多端显示）管理           |
| **自省系统**   | 实时查看函数定义（Describe Function）、变量文档及快捷键绑定  |
| **内置终端**   | Eshell（纯 Elisp 实现的 Shell）、Term、Ansi-term             |
| **版本控制**   | VC 模式（支持 Git, SVN, Mercurial 的基础操作）               |
| **文本处理**   | 正则表达式搜索替换、文本对齐、各种字符编码转换               |
| **组织与日程** | Org-mode（基础笔记、任务追踪、导出 HTML/LaTeX）              |
| **网络工具**   | EWW 浏览器、邮件客户端（Gnus/Rmail）、FTP 支持               |
可以看的出来它比vim要复杂繁重的多,集成了很多不是非常有必要的功能,这也就导致Emacs的快捷键比vim要多,甚至有不少的多级快捷键操作,所以使用vi/vim的人比Emacs要多很多.
Emacs的拥护者与vi(著名的vim为vi的改版)的拥护者曾经[闹得不可开交](https://en.wikipedia.org/wiki/Editor_war),但在vscode成为了主流以后就没有争吵的必要了😆.

