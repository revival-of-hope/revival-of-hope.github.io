---
title: "技术文章阅读笔记-3"
date: 2026-06-13T20:26:43+08:00
description: 
image: 72389353_p0-C95の頒布に関して - 副本.webp
math: true
---

# 计算机视觉: 算法与应用(第一版)
- 跟我想象中的不太一样,基本全是数学,真心看不下去
# 事务处理: 概念与技术
- 图灵奖得主的书,年代很久远,也比较冷门,匆匆一览下来,发现这么冷门是有理由的,首先内容太老了,其次是比较学究气,不太推荐阅读
# Spring实战 && Spring Boot实战
- 不推荐,到底哪里有正常一点的框架书啊😢
# 程序设计语言原理(第12版)
这本书应该放在所有程序员的必读书单中,原因就在于它的第二章详细描述了整个编程语言的发展历史,至于其他部分说实话都讲的不太行.
## 编程语言历史
- 非常的详实,非常的有趣,可以说这才是这整本书的精华,所有对编程语言历史感兴趣的人都应该看看这一章.

![族谱图](PixPin_2026-06-17_14-21-32.webp)
# Java核心技术·卷 I&&Ⅱ
- 实际观感不太行,第一部只不过涉及了一些常见的Java基础知识,而第二部涉及的各种框架和库也没什么必要去特地了解
# 深入理解计算机系统(第三版)
- 在读了各个层面的专业书籍后再回来看这本汇总书确实是一种享受,有一种把所有东西都串联起来的感觉.
## 概览
一场酣畅淋漓的概览,从处理器架构向上谈起,穿过操作系统,最终实现程序的I/O交互.
## 信息处理
我一直都很好奇各种入门书籍为何都如此看重诸如补码,反码,浮点数之类的知识,这本书也没能逃过这个俗套.

事实上来说,它们一点都不重要,在软件领域,我们根本没有机会用到这个知识,只要知道某个数据类型支持的最大范围和最大精度就可以了,即便是在相当冷门的硬件领域,只有在处理器和操作系统接口这一小小的范围内,你才需要考虑这些问题,然而这起码要在计算机领域钻研了好几年才有实力去接触,这不就是脱裤子放屁的事情吗.

### 大小端问题
不同处理器/操作系统中的有效字节顺序不同.最低有效字节在低地址的方式称为小端法(little endian),最高有效字节在低地址的方式称为大端法(big endian).

>这两种字节顺序在如今看来并没有什么高下之分,但也正是因为没有高下之分,也就无法达成一致的共识.
## 程序的机器级表示
这部分讲的是x86架构下的C语言汇编代码,说实话,讲的比较一般,通篇都是汇编代码的分析,入门程序员我想需要翻来覆去看很多遍才能看明白.
## 处理器体系结构
- 前半部分可以去看The Elements of Computing Systems,讲的比这可清楚多了;后半部分可以看计算机组成与设计
## 优化程序性能&&存储器层次结构
- 这两个部分对应了计算机体系结构那本书

## 链接
- 这一章的缺点是压缩了重要的链接具体过程,而拓展了一些不是很有用的知识.

为了从目标文件中构造可执行文件,链接器需要完成两个任务:
1. 符号解析: 将符号在各个文件中的引用与它在某个文件中的定义关联起来
2. 重定位: 将每个符号定义与一个内存位置关联起来,修改对这个符号的所有引用,使它们都指向这个内存位置.

这本书把目标文件分成三种:
* **可重定位目标文件**。包含二进制代码和数据，其形式可以在编译时与其他可重定位目标文件合并起来，创建一个可执行目标文件。
* **可执行目标文件**。包含二进制代码和数据，其形式可以被直接复制到内存并执行。
* **共享目标文件**。一种特殊类型的可重定位目标文件，可以在加载或者运行时被动态地加载进内存并链接。

ELF格式的可重定位目标文件格式如下:
![图示](PixPin_2026-06-20_21-30-10.webp)

- ELF头记录了该文件的类型和节头部表的位置(偏移)
- 节头部表描述了不同节的位置和大小.
- text: 程序代码的机器语言表示
- rodata: 只读数据,比如printf语句中的格式串
- data: 已初始化的全局和静态C变量.至于局部C变量,它们只在运行时出现在栈中
- bss: 未初始化的全局和静态C变量,以及所有被初始化为0的全局或静态变量.这个段不占据实际的空间,仅仅是一个占位符,直到运行时才实际地分配这些变量的初始值为0.
- **symtab: 符号表,存放在程序中定义和引用的函数和全局变量的信息**,这是由汇编器构造的
- rel.text: 当链接器将该目标文件和其他文件组合时,需要修改这个段,用于重定位
- rel.data: 被模块引用或定义的所有全局变量的重定位信息
- debug: 用于调试的段,只有用-g选项调用gcc时才会生成
- line: 原始C源程序中的行号与.text中机器代码之间的映射,只有用-g选项调用gcc时才会生成
- strlab: 内容包括symtab和debug中的符号表

>bss的全名为Block Storage Start,始于IBM 704的汇编语言,这确实不知所云,一个简单方法是记成Better Save Space.

### 符号解析
链接器的输入是一组可重定位目标模块。每个模块定义一组符号，有些是局部的（只对定义该符号的模块可见），有些是全局的（对其他模块可见）。如果多个模块定义同名的全局符号，会发生什么呢？下面是 Linux 编译系统采用的方法。

在编译时，编译器向汇编器输出每个全局符号，或者是强（strong）或者是弱（weak），而汇编器把这个信息隐含地编码在可重定位目标文件的符号表里。函数和已初始化的全局变量是强符号，未初始化的全局变量是弱符号。

根据强弱符号的定义，Linux 链接器使用下面的规则来处理多重定义的符号名：

* **规则 1**：不允许有多个同名的强符号。
* **规则 2**：如果有一个强符号和多个弱符号同名，那么选择强符号。
* **规则 3**：如果有多个弱符号同名，那么从这些弱符号中任意选择一个。

### 重定位
重定位可以细分为两步:
1. 重定位节和符号定义: 将相同类型的节合并成一个新的节,并将符号定义对应特定的内存地址
2. 重定位符号引用: 修改代码节和数据节中的符号引用,指向第一步中的内存地址


## 异常控制&&虚拟内存
这两个部分完全就是操作系统导论的劣化版了.

## 程序部分
这一部分真想看的话可以翻一下Unix环境高级编程,不过想看的人一定很少吧.


## 总结
尽管写一本底层的汇总书并命名为"深入理解计算机系统"非常有魄力,但奈何这本书所说的深入都不是那么的深入,很多地方都拘泥于不太重要的层面.如果没有读过各个角度的专业书籍的话,是很容易被这本书迷惑的,从而花费大量时间去揣摩文中经过压缩和扭曲的知识点,这些时间完全可以用来去读专门的书籍,来获得更好一些的理解.

- 整体来说的话,只有链接一章值得一看,因为这方面的专业书籍实在太少了.
# Crafting Interpreters
## 概览
### 自举
- 自举: 使用语言C编写语言C的编译器.最开始,我们需要用其他语言实现的编译器来编写语言C的编译器,再用这个编译器来编译得到全部使用语言C编写的编译器,然后就可以把以前那个编译器扔掉了.

>至于最开始的编译器是怎么实现的?那自然是用汇编语言写的了,而将符号汇编语言转成二进制机器码也需要一个编译器,这个编译器自然就是用二进制机器码写的了,至于是如何实现的,我简直不敢想象
### 完整的编译器实现
程序编译分成多步:
1. 扫描/语法分析: 扫描器将高级语言的代码分割成不同的词法单元
2. 解析: 根据词法单元序列构建出语法树(abstract syntax tree,AST)
3. 静态分析: 分析语法树中各个变量的关系,如数据类型和是否为全局变量
   
上述三步称为编译器的前端.

4. 中间表示: intermediate representation(IR),将代码以一种中间语言存储,只需要针对中间语言来开发不同处理器架构的后端即可,而不需要改动前端.尽管很方便,但很多语言并不会在这一步生成中间代码,而是留待代码生成阶段再生成类似的形式
5. 优化: 使用各种编译处理来优化代码的运行速度,如循环展开和变量提取.

这两步称为编译器的中端.

6. 代码生成: 将中间代码/抽象语法树根据不同的处理器架构生成对应的汇编代码,或者,**为一个虚拟机生成虚拟的指令集代码**,如今称为字节码(bytecode),这是因为这类代码通常用单个字节构建而成
7. 虚拟机: 如果编译器生成了字节码,就可以用C语言编写一个虚拟机,那么任何支持C编译器的平台都可以运行该虚拟机,执行该语言的字节码,这也是为什么Java能够"一次编译,处处运行".
8. 运行时(runtime): 如果之前已经编译成机器码,那么我们只需要用操作系统加载可执行文件即可,如果编译成了字节码,那么就启动虚拟机并装载程序.程序执行过程中,我们需要能够支持垃圾回收,对象追踪等功能,这些被统称为运行时.

上述过程就是编译器的后端.
### 其他类型的编译器
- single-pass compiler: **不生成语法树或者中间代码**,需要源代码提供足够的信息,用于压缩编译占用的内存,如Pascal和C语言的编译器,这也解释了为何Pascal的语法规定类型声明必须位于代码块的开头；以及为何在C语言中，除非使用显式的前向声明告知编译器生成后续函数调用所需的信息，否则无法在函数定义代码上方调用该函数。
- tree-walk interpreter: 生成语法树后就立刻开始执行,也是这本书要制作的第一个解释器
- transpiler: 转译器,例如Typescript转译成Javascript,Javascript XML转译成Javascript.
- Just-in-time compilation(即时编译): 对于使用虚拟机和字节码的语言例如Java和C#来说,执行字节码还是太慢了,即时编译会将字节码编译成所在平台的汇编代码,从而加速代码的执行,如Java的HotSpot虚拟机.

### 编译器与解释器

- 编译器: 将源代码转换成另一种形式,但不会执行该代码,用户需要自己额外用命令运行它
- 解释器: 接收源代码并立即执行

例如CPython,它在内部将python代码转换成字节码,并用虚拟机立即执行它,因此它既是解释器也包含了编译器.

![图示](PixPin_2026-06-18_12-01-07.webp)

## 总结
具体实现的内容真的不太有耐心看下去呢,因为太过割裂了,以后有机会我或许会再来阅读一次吧.
# 白帽子讲Web安全
- [作者介绍](https://zhuanlan.zhihu.com/p/20436467)
  - 非常有传奇色彩的hacker,可惜了解他的人不多
## 浏览器安全
1. 同源策略: 禁止不同源的网站访问该网站的内容,否则恶意网站就可以监控你的交易信息.
2. Sandbox: 浏览器引擎由Sandbox隔离起来,从而防止网页中的恶意代码注入和执行
3. 恶意网址拦截: 浏览器内置了一份关于恶意网站的黑名单,当用户遇到这些网站时提出警告

## 跨站脚本攻击(XSS)
>跨站脚本攻击，英文全称是 Cross Site Script，本来缩写是 CSS，但是为了和层叠样式表（Cascading Style Sheet，CSS）有所区别，所以在安全领域叫做“XSS”

文章中讲的XSS攻击方案在如今的现代前端框架下已经不太可能出现了,所以我们现在没有听过像零几年Samy Worm那样的大规模攻击事件了.
## 跨站点请求伪造（CSRF）
CSRF的全名为Cross Site Request Forgery,通过恶意网站向正常网站发送带有Cookie或者Token的请求,从而引发破坏性的影响,现在这种攻击基本绝迹了.
## 点击劫持（ClickJacking）
这种方法将恶意的透明图片或者按钮覆盖在原网页上方,当用户浏览网页时,会不经意地被导向另外一个伪装的恶意网站,这种攻击现在也绝迹了.

## 注入攻击
通过ORM和数据库的内置防御,SQL等注入攻击现在也绝迹了

## 应用层拒绝服务攻击
分布式拒绝服务(Distributed Denial of Service,DDOS)通过大量的合理请求造成资源过载,服务器不得不停止运行,拒绝新的请求.

## 总结
尽管文章谈到的Web安全原理很多,但可惜的是在当今这个时代下都不太适用了,唯独DDOS还有着些微的活跃度.

纵览全文,可以发现的是,大多数Web安全方案都是被各种网络攻击逼出来的,如果没有这些网络攻击,或许人们永远不会意识到存在这些漏洞.

或许,网络安全这个行业将会逐渐式微下去吧,毕竟在现代的前后端框架下,传统的网络攻击方案都不太管作用了,cracker想要发起攻击只有两条道路,从内部突破,例如诱导下载恶意软件或者U盘攻击,或者付出高昂的代价从外部侵入,例如DDOS或者攻击防火墙.也就是说,SRE这类岗位做的才是传统的网络安全的活儿,而我如今看到的网络安全行业,更多的是去挖漏洞和找病毒,也就是和网络本身关系并不大了,叫做软件安全反而更为恰当
# Spring Start Here
## 前言
>The reality is that **despite being so popular**, it's pretty **hard to find quality introductory material**. The reference documentation is thousands of pages long, describing all the subtleties and details that could be helpful in very specific scenarios, so it's not an option for a newcomer. While online videos and tutorials typically fail to engage the student, **very few books capture the essence of Spring framework**, often spending long pages debating topics that prove to be **irrelevant to the problems faced in modern application development**. With this book, however, it's very hard to find anything to remove; all the concepts covered are recurring topics in the development of any Spring application.

>This book is for developers who understand basic object-oriented programming and Java concepts and want to learn Spring or refresh their Spring fundamentals knowledge.

>如果对 Spring 完全没有（或仅有极少）了解，最佳读法是从第一章开始，按顺序通读全书。

- (6/23): 希望这本书能够如前言所说的那样好.
## 介绍
Spring框架由以下部分组成:
1. Spring Core: 包含Spring context,The Spring Expression Language等核心功能.
2. Spring model-view-controller (MVC): 用于开发Web应用程序
3. Spring Data Access: 用于连接数据库
4. Spring testing: 用于测试

Spring Boot引入了`convention over configuration`这一概念,也就是说,开发者无需自行完成框架的全套配置，Spring Boot会提供一套默认配置方案，用户可根据需求进行个性化调整.

- 暂时弃坑
# 设计数据密集型应用(第二版)(待补充)
- 第一版于2017年出版,第二版于2026年出版,中间间隔了十年,所以章节内容上有了大幅度的改动.

前两章没什么太实际的内容,故可以直接跳过
## ch3

这一章主要介绍了主流的数据库类型,但都不是很深入,要专门学习还是得去看对应的书籍
## ch4
主要讲了LSM树和B+树,以及各种各样的索引类型

## 暂缓
明明很多人都推荐这本书,但我就是读不下去呢.一般的分布式服务问题用框架就可以解决了,如果问题严重到需要自己造轮子,那也不是我这个菜鸟能搞定的事情了.
# 第一行代码(待补充)
- 谁能想到我连Android Studio的模拟器都打不开呢,直接就折戟沉沙了,过会时候再来吧.
# The Garbage Collection Handbook(第一版)(待补充)
## 前置概念
- 堆: 一段或连续几段连续内存组成的空间集合,内存颗粒(granule)是堆内存分配的最小单位,通常是一个字(word)或者双字.内存单元(cell)是由数个连续的颗粒组成的内存块.
- 对象(object): 为应用程序分配的内存单元
- 赋值器: 分配新的对象,并修改对象之间的引用关系,从而改变对象图.
  - 赋值器有三种操作: New,从堆分配器获得一个新的堆对象;Read,访问某个对象;Write,修改某个对象
- 回收器(collector): 执行垃圾回收代码,找到不可达对象并将其回收
- 分配器(allocator): 分配或者释放存储空间

标记-清扫（mark-sweep）、标记-复制（mark-copy）、标记-整理（mark-compact）、引用计数（reference counting）是4种最基本的垃圾回收策略。大多数回收器会以不同的组合方式来应用这些策略.

## 标记-清扫算法
- 这是一种间接回收算法,并非直接检测垃圾本身,而是先确定所有的存活对象,再反过来判定其他对象都是垃圾.
# On Java 8(待补充)
- [中文翻译版链接](https://zyb0408.github.io/gitbooks/onjava8/)

讲的还算详细和有体系,但由于我已经了解过其中的大多数内容了,所以就只摘抄一些比较难懂和重要的部分,很多我这辈子都未必能用到的零碎知识点就直接跳过了.
## Java的垃圾回收
### 文章摘录
如果你以前用过的语言，在堆上分配对象的代价十分高昂，你可能自然会觉得 Java 中所有对象（基本类型除外）在堆上分配的方式也十分高昂。然而，垃圾回收器能很明显地提高对象的创建速度。这听起来很奇怪——存储空间的释放影响了存储空间的分配，但这确实是某些 Java 虚拟机的工作方式。这也意味着，Java 从堆空间分配的速度可以和其他语言在栈上分配空间的速度相媲美。

例如，你可以把 C++ 里的堆想象成一个院子，里面每个对象都负责管理自己的地盘。一段时间后，对象可能被销毁，但地盘必须复用。在某些 Java 虚拟机中，堆的实现截然不同：它更像一个传送带，每分配一个新对象，它就向前移动一格。这意味着对象存储空间的分配速度特别快。Java 的"堆指针"只是简单地移动到尚未分配的区域，所以它的效率与 C++ 在栈上分配空间的效率相当。当然实际过程中，在簿记工作方面还有少量额外开销，但是这部分开销比不上查找可用空间开销大。

你可能意识到了，Java 中的堆并非完全像传送带那样工作。要是那样的话，势必会导致频繁的内存页面调度——将其移进移出硬盘，因此会显得需要拥有比实际需要更多的内存。页面调度会显著影响性能。最终，在创建了足够多的对象后，内存资源被耗尽。其中的秘密在于垃圾回收器的介入。当它工作时，一边回收内存，一边使堆中的对象紧凑排列，这样"堆指针"就可以很容易地移动到更靠近传送带的开始处，也就尽量避免了页面错误。垃圾回收器通过重新排列对象，实现了一种高速的、有无限空间可分配的堆模型。

要想理解 Java 中的垃圾回收，先了解其他系统中的垃圾回收机制将会很有帮助。一种简单但速度很慢的垃圾回收机制叫做引用计数。每个对象中含有一个引用计数器，每当有引用指向该对象时，引用计数加 1。当引用离开作用域或被置为 null 时，引用计数减 1。因此，管理引用计数是一个开销不大但是在程序的整个生命周期频繁发生的负担。垃圾回收器会遍历含有全部对象的列表，当发现某个对象的引用计数为 0 时，就释放其占用的空间（但是，引用计数模式经常会在计数为 0 时立即释放对象）。这个机制存在一个缺点：如果对象之间存在循环引用，那么它们的引用计数都不为 0，就会出现应该被回收但无法被回收的情况。对垃圾回收器而言，定位这样的循环引用所需的工作量极大。引用计数常用来说明垃圾回收的工作方式，但似乎从未被应用于任何一种 Java 虚拟机实现中。

- Python一直采用的垃圾回收机制就是引用计数

在更快的策略中，垃圾回收器并非基于引用计数。它们依据的是：对于任意"活"的对象，一定能最终追溯到其存活在栈或静态存储区中的引用。这个引用链条可能会穿过数个对象层次，由此，如果从栈或静态存储区出发，遍历所有的引用，你将会发现所有"活"的对象。对于发现的每个引用，必须追踪它所引用的对象，然后是该对象包含的所有引用，如此反复进行，直到访问完"根源于栈或静态存储区的引用"所形成的整个网络。你所访问过的对象一定是"活"的。注意，这解决了对象间循环引用的问题，这些对象不会被发现，因此也就被自动回收了。

在这种方式下，Java 虚拟机采用了一种自适应的垃圾回收技术。至于如何处理找到的存活对象，取决于不同的 Java 虚拟机实现。其中有一种做法叫做停止-复制（stop-and-copy）。顾名思义，这需要先暂停程序的运行（不属于后台回收模式），然后将所有存活的对象从当前堆复制到另一个堆，没有复制的就是需要被垃圾回收的。另外，当对象被复制到新堆时，它们是一个挨着一个紧凑排列，然后就可以按照前面描述的那样简单、直接地分配新空间了。

当对象从一处复制到另一处，所有指向它的引用都必须修正。位于栈或静态存储区的引用可以直接被修正，但可能还有其他指向这些对象的引用，它们在遍历的过程中才能被找到（可以想象成一个表格，将旧地址映射到新地址）。

这种所谓的"复制回收器"效率低下主要因为两个原因。其一：得有两个堆，然后在这两个分离的堆之间来回折腾，得维护比实际需要多一倍的空间。某些 Java 虚拟机对此问题的处理方式是，按需从堆中分配几块较大的内存，复制动作发生在这些大块内存之间。

其二在于复制本身。一旦程序进入稳定状态之后，可能只会产生少量垃圾，甚至没有垃圾。尽管如此，复制回收器仍然会将所有内存从一处复制到另一处，这很浪费。为了避免这种状况，一些 Java 虚拟机会进行检查：要是没有新垃圾产生，就会转换到另一种模式（即"自适应"）。这种模式称为标记-清扫（mark-and-sweep），Sun 公司早期版本的 Java 虚拟机一直使用这种技术。对一般用途而言，"标记-清扫"方式速度相当慢，但是当你知道程序只会产生少量垃圾甚至不产生垃圾时，它的速度就很快了。

"标记-清扫"所依据的思路仍然是从栈和静态存储区出发，遍历所有的引用，找出所有存活的对象。但是，每当找到一个存活对象，就给对象设一个标记，并不回收它。只有当标记过程完成后，清理动作才开始。在清理过程中，没有标记的对象将被释放，不会发生任何复制动作。"标记-清扫"后剩下的堆空间是不连续的，垃圾回收器要是希望得到连续空间的话，就需要重新整理剩下的对象。

"停止-复制"指的是这种垃圾回收动作不是在后台进行的；相反，垃圾回收动作发生的同时，程序将会暂停。在 Oracle 公司的文档中会发现，许多参考文献将垃圾回收视为低优先级的后台进程，但是早期版本的 Java 虚拟机并不是这么实现垃圾回收器的。当可用内存较低时，垃圾回收器会暂停程序。同样，"标记-清扫"工作也必须在程序暂停的情况下才能进行。

如前文所述，这里讨论的 Java 虚拟机中，内存分配以较大的"块"为单位。如果对象较大，它会占用单独的块。严格来说，"停止-复制"要求在释放旧对象之前，必须先将所有存活对象从旧堆复制到新堆，这导致了大量的内存复制行为。有了块，垃圾回收器就可以把对象复制到废弃的块。每个块都有年代数来记录自己是否存活。通常，如果块在某处被引用，其年代数加 1，垃圾回收器会对上次回收动作之后新分配的块进行整理。这对处理大量短命的临时对象很有帮助。垃圾回收器会定期进行完整的清理动作——大型对象仍然不会复制（只是年代数会增加），含有小型对象的那些块则被复制并整理。Java 虚拟机会监视，如果所有对象都很稳定，垃圾回收的效率降低的话，就切换到"标记-清扫"方式。同样，Java 虚拟机会跟踪"标记-清扫"的效果，如果堆空间出现很多碎片，就会切换回"停止-复制"方式。这就是"自适应"的由来，你可以给它个啰嗦的称呼："自适应的、分代的、停止-复制、标记-清扫"式的垃圾回收器。

Java 虚拟机中有许多附加技术用来提升速度。尤其是与加载器操作有关的，被称为"即时"（Just-In-Time, JIT）编译器的技术。这种技术可以把程序全部或部分翻译成本地机器码，所以不需要 JVM 来进行翻译，因此运行得更快。当需要装载某个类（通常是创建该类的第一个对象）时，编译器会先找到其 .class 文件，然后将该类的字节码装入内存。你可以让即时编译器编译所有代码，但这种做法有两个缺点：一是这种加载动作贯穿整个程序生命周期内，累加起来需要花更多时间；二是会增加可执行代码的长度（字节码要比即时编译器展开后的本地机器码小很多），这会导致页面调度，从而一定降低程序速度。另一种做法称为惰性评估，意味着即时编译器只有在必要的时候才编译代码。这样，从未被执行的代码也许就压根不会被 JIT 编译。新版 JDK 中的 Java HotSpot 技术就采用了类似的做法，代码每被执行一次就优化一些，所以执行的次数越多，它的速度就越快。
### 总结
首先我们需要知道的是**Java将对象通通放在堆上**,当有新的对象要被分配时,Java 的"堆指针"只是简单地移动到尚未分配的区域，所以它的效率与 C++ 在栈上分配空间的效率相当。

但是,当对象数量一多,内存容量极小的缓存(cache)就有可能没有保留我们所需的对象,需要从主存(main memory)甚至是硬盘中读取,俗称(缓存不命中,cache miss),这大大延长了扫描对象的时间,从而影响程序运行的速度,所以我们需要通过**垃圾回收**机制处理**未被实际引用**的对象.

早期的JVM采用两种垃圾回收机制,分别对应程序启动和程序稳定运行的情况:
1. **停止-复制（stop-and-copy）**: 暂停程序运行,将所有对象复制到一个新的堆
2. **标记-清扫（mark-and-sweep）**: 当程序产生的垃圾很少时,再用停止-复制机制的开销就太大了,所以我们可以通过遍历栈和静态存储区的方式,**标记**那些被实际引用的对象,并在遍历结束后**清扫**未被标记的对象.

这两种垃圾回收都必须在程序暂停时才可以进行,所以还是不够理想,至于更深入的讨论,需要去阅读其他书籍来理解

## 函数式编程
>大多数面向对象语言都或多或少的学习和吸收了函数式语言的特点,JAva也不例外,在Java 8中引入了Lambda表达式和函数式编程.

### 新旧对比
下面是传统方式和Java 8的方式对比:
```java
// functional/Strategize.java

interface Strategy {
  String approach(String msg);
}

class Soft implements Strategy {
  public String approach(String msg) {
    return msg.toLowerCase() + "?";
  }
}

class Unrelated {
  static String twice(String msg) {
    return msg + " " + msg;
  }
}

public class Strategize {
  Strategy strategy;
  String msg;
  Strategize(String msg) {
    strategy = new Soft(); // [1]
    this.msg = msg;
  }

  void communicate() {
    System.out.println(strategy.approach(msg));
  }

  void changeStrategy(Strategy strategy) {
    this.strategy = strategy;
  }

  public static void main(String[] args) {
    Strategy[] strategies = {
      new Strategy() { // [2]
        public String approach(String msg) {
          return msg.toUpperCase() + "!";
        }
      },
      msg -> msg.substring(0, 5), // [3]
      Unrelated::twice // [4]
    };
    Strategize s = new Strategize("Hello there");
    s.communicate();
    for(Strategy newStrategy : strategies) {
      s.changeStrategy(newStrategy); // [5]
      s.communicate(); // [6]
    }
  }
}
```

**输出结果**
```java
hello there?
HELLO THERE!
Hello
Hello there Hello there
```

对应序号的说明:

- [1] 在 Strategize 中，Soft 作为默认策略，在构造函数中赋值。
- [2] 一种略显简短且更自发的方法是创建一个匿名内部类。即使这样，仍有相当数量的冗余代码。你总是要仔细观察：“哦，原来这样，这里使用了匿名内部类。”
- [3] Java 8 的 Lambda 表达式。由箭头 -> 分隔开参数和函数体，箭头左边是参数，箭头右侧是从 Lambda 返回的表达式，即函数体。这实现了与定义类、匿名内部类相同的效果，但代码少得多。
- [4] Java 8 的方法引用，由 :: 区分。在 :: 的左边是类或对象的名称，在 :: 的右边是方法的名称，但没有参数列表。
- [5] 在使用默认的 Soft strategy 之后，我们逐步遍历数组中的所有 Strategy，并使用 changeStrategy() 方法将每个 Strategy 放入 变量 s 中。
- [6] 现在，每次调用 communicate() 都会产生不同的行为，具体取决于此刻正在使用的策略代码对象。我们传递的是行为，而非仅数据

>在 Java 8 之前，我们能够通过 [1] 和 [2] 的方式传递功能。然而，这种语法的读写非常笨拙，并且我们别无选择。方法引用和 Lambda 表达式的出现让我们可以在需要时传递功能，而不是仅在必要才这么做。

上述的代码对于新手来说非常难以理解,所以接下来要好好探析一下.
### Lambda表达式
Lambda 表达式是使用最小可能语法编写的函数定义：

1. Lambda 表达式产生函数，而不是类。 在 JVM（Java Virtual Machine，Java 虚拟机）上，一切都是一个类，因此在幕后执行各种操作使 Lambda 看起来像函数 —— 但作为程序员，你可以高兴地假装它们“只是函数”。
2. Lambda 语法尽可能少，这正是为了使 Lambda 易于编写和使用。
# MongoDB权威指南(第三版)
## 简介
MongoDB 不是关系数据库，而是面向文档（document-oriented）的数据库

随着所需存储数据量的增长，开发人员面临一个艰难的决定：应该如何扩展数据库？这可以归结为两种选择：纵向扩展（提高配置）和横向扩展（将数据分布到更多机器上）。纵向扩展通常是阻力最小的途径，但它也有缺点：大型机器一般非常昂贵，而且在最终达到物理极限时，就无法再升级到更高的配置了。另一种方式是横向扩展：如果想增加存储空间或增加读写操作的吞吐量，那么可以购买额外的服务器，并将它们添加到集群中。这既便宜又便于扩展，但管理 1000 台机器比管理 1 台机器困难得多。

>MongoDB 的设计采用了横向扩展。面向文档的数据模型使跨多台服务器拆分数据更加容易。MongoDB 会自动平衡跨集群的数据和负载，自动重新分配文档，并将读写操作路由到正确的机器上

![图示](PixPin_2026-07-02_09-51-12.webp)
### 文档
文档是 MongoDB 的核心概念：它是一组有序键值的集合。文档的表示形式因编程语言而异，但大多数语言具有自然匹配的数据结构，比如映射、哈希表或字典.


MongoDB 会区分类型和大小写。例如，下面这两个文档是不同的：
```json
{"count" : 5}
{"count" : "5"}
```

### 集合
>集合就是一组文档。如果将文档比作关系数据库中的行，那么一个集合就相当于一张表。

任何文档都可以放入集合中,但为了管理方便,通常都会进行一定的分类.

### 数据库
MongoDB 使用集合对文档进行分组，使用数据库对集合进行分组。一个 MongoDB 实例可以承载多个数据库

有一些数据库名称是保留的。这些数据库可以被访问，但它们具有特殊的语义:
- admin: admin 数据库会在身份验证和授权时被使用。
- local: 特定于单个服务器的数据会存储在此数据库中。
- conﬁg: MongoDB 的分片集群会使用 conﬁg 数据库存储关于每个分片的信息

通过将数据库名称与该库中的集合名称连接起来，可以获得一个完全限定的集合名称，称为命名空间。如果你要使用 cms 数据库中的 blog.posts 集合，则该集合的命名空间为 cms.blog.posts。

### 补充: 安装和启动MongoDB
[官网](https://www.mongodb.com/try/download/community)下载对应平台的社区版server,勾选下载图形化界面的MongoDB Compass,就可以以可视化的界面方便的管理MongoDB了.

MongoDB Compass中自带了一个mongosh终端,它是一个JavaScript解释器,可以执行任意的JS程序,这也很合理,毕竟MongoDB操作的就是json.

![示意图](PixPin_2026-07-03_10-29-31.webp)
### MongoDB数据类型
MongoDB 在保留了 JSON 基本键 – 值对特性的基础上，增加了对许多额外数据类型的支持:
- null: null 类型用于表示空值或不存在的字段。
- bool: 布尔类型的值可以为 true 或者 false。
- 数值: shell 默认使用 64 位的浮点数来表示数值类型,如`{"x" : 3.14}`
  - 如果要强调该数值为整数,可以用NumberInt 或 NumberLong 类，它们分别表示 4 字节和 8 字节的有符号整数,如`{"x" : NumberInt("3")}`
- 字符串: `{"x" : "foobar"}`
- 日期: MongoDB 会将日期存储为 64 位整数，表示自 Unix 纪元（1970 年 1 月 1 日）以来的毫秒数.
- 数组类型,内嵌json等组合类型,如`{"x" : {"foo" : "bar"}}`
- Object ID:  一个 12 字节的 ID，是文档的唯一标识。

MongoDB中存储的每个文档都必须有一个"_id" 键,在单个集合中每个文档的id值都是唯一的.可以用`{"x" : ObjectId()}`显式设置,如果没写则会自动生成.

ObjectId 的 12 字节是按照如下方式生成的：

![示意图](PixPin_2026-07-03_13-28-59.webp)

>因为时间戳在前，所以 ObjectId 将大致按照插入的顺序进行排列。这并不是一个很强的保证，但是确实在某些方面很有用，比如可以使 ObjectId 的索引效率更高
## 总结
后面都是一些终端操作和不痛不痒的通用数据库常识了,不过我们肯定是用Python或者Java来操作MongoDB,所以也没必要去学这些终端操作了
# 操作系统: 设计与实现(第三版)
- MINIX配套教材,也是一切开始的地方.
- 一开始我在想这本书的中文版为什么要分成上下两册,后来发现下册只有300多页,里面是接近3w行的MINIX源码,说实话真没必要😅
## 引言
![示意图](PixPin_2026-07-03_12-21-48.webp)
大多数操作系统书也确实是这样的,这也是这本书与众不同的地方,从头设计了一个全新的操作系统.
### 操作系统的发展历史
- 这一部分很值得看.

### 与Linux的关系
> 有些读者可能对 MINIX 和 Linux 之间的关系比较感兴趣。在 MINIX 发布后不久，便出现了一个相应的 USENET 新闻组 *comp.os.minix*，在数周内便有多达 40 000 个用户订阅。其中多数人都想往 MINIX 中加入一些新的特性以使它更大、更好（嗯，至少是更大吧）。每天都有数百人提出自己的建议、想法甚至是代码。而 MINIX 的作者在几年内始终坚持不采纳这些建议，目的是使 MINIX 保持足够的简洁，以便于学生理解；同时保持规模的小巧，使它能运行在一些低档的、学生可以买得起的计算机上。事实上，对于一些看不上 MS-DOS 的人来说，MINIX 系统及其源代码的存在，甚至是促使他们去购买一台 PC 机的动因。
> 在这些提建议的人中，有一个芬兰学生 Linus Torvalds。Torvalds 在他的 PC 机上安装了 MINIX 系统，并且认真钻研了它的源代码。后来，Torvalds 想在他自己的 PC 机上阅读 USENET 新闻组（如 *comp.os.minix* ），免得每次都得跑到学校去。但是他需要的一些特性在 MINIX 中没有，于是他就写了一个程序来完成这些功能。但不久他又需要一个不同的终端驱动程序，于是他又写了一个相应的程序。接下来，他想要下载和保存新闻组中的文章，于是又写了一个磁盘驱动程序和一个文件系统。到 1991 年 8 月，他已经完成了一个基本的内核。在 1991 年 8 月 25 日，他把这个消息公布在 *comp.os.minix* 上。这个公告吸引了其他人来帮助他，在 1994 年 3 月 13 日，Linux 1.0 正式发布了，这标志着 Linux 的诞生。

## 总结
由于我看这本书是想学MINIX,奈何大部分内容都是在抛开MINIX谈论操作系统的共性,尽管讲的不错,但这些内容我都还比较熟悉,等待以后要背八股时或许会再来看一遍吧.
# Test-Driven React
- 明明是24年的书,用的库却是JTest呢,那就不看了吧
# 推荐系统实践
## 推荐系统概述
>在这个时代，无论是信息消费者还是信息生产者都遇到了很大的挑战：作为信息消费者，如何从大量信息中找到自己感兴趣的信息是一件非常困难的事情；作为信息生产者，如何让自己生产的信息脱颖而出，受到广大用户的关注，也是一件非常困难的事情
>
>推荐系统就是解决这一矛盾的重要工具。推荐系统的任务就是联系用户和信息，一方面帮助用户发现对自己有价值的信息，另一方面让信息能够展现在对它感兴趣的用户面前，从而实现信息消费者和信息生产者的双赢

## 总结
还算值得一看,看完之后基本了解了两件事:
1. 早期的推荐算法背后的数学原理是相当简单的,不太需要费脑子去设计,市面上有相当多的成熟算法可以选用;而现在的推荐算法都是基于机器学习实现的,需要相当大的计算量,而效果我看并没有多好,不如老老实实地用以前的方法为好.
2. 推荐算法最重要的地方反而是数据集,无论是给新用户推荐,还是给老用户推荐,都需要事先有一个相当大规模的测试集,才能够大致划出一个恰当的范围,不会轻易让用户流失.
# 图数据库(第二版)
## 介绍
>在数据集增大的时候,图数据库的性能保持不变,因为查询总是只与图的一部分有关,只需要遍历符合查询条件的那部分图即可.

![示意图](PixPin_2026-06-29_10-04-40.webp)
## 建模
- Cypher是图数据库的标准查询语言,而不少图数据库还支持RDF的查询语言SPARQL.

很遗憾的是,书中对Cypher的介绍非常浅显,所以需要专门找其他的书来看了.至于剩下的内容就都是扯淡了,这也看得出来图数据库本身还没有那么成熟.
# ASP.NET Core in Action(第三版)
- 之前看了老版本的,直接被劝退了,现在这个版本是2023年出版的.
## 入门
ASP.NET Core是一个C#框架,用于构建Web应用程序,可实现的应用程序如下:
1. 后端API
2. MVC控制器
3. Blazor WebAssembly用来做前端

总的来说,就是一个后端的网页框架而已.

ASP.NET Core的默认Web服务器是Kestrel,其地位基本等于python中的uvicorn,在接受请求时会传给应用程序一个HttpContext对象,它是一个用来存储单个请求的容器,这等价于fastapi中的`app=Fastapi()`.

### 补充: 使用VSCode创建项目
书中使用Visual Studio 中的 ASP.NET Core Empty 项目模板来初始化项目,这等价于在VSCode终端输入`dotnet new web`.

运行`dotnet run`即可在给定端口看到欢迎界面:

![端口](PixPin_2026-07-03_14-41-45.webp)

### 项目介绍
![示意图](PixPin_2026-07-03_14-43-19.webp)

1. 文件夹Properties中存放了launchSettings.json文件,只用于本地开发和调试,在部署时不生效.
2. 核心的配置文件是`appsettings.json`和`appsettings.Development.json`,用来在运行时调控应用.
3. `.csproj`后缀的文件是.NET应用程序的项目文件,定义了.NET的版本和项目用到的依赖,为xml风格,内容如下:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">

  <PropertyGroup>
    <TargetFramework>net9.0</TargetFramework>
    <Nullable>enable</Nullable>
    <ImplicitUsings>enable</ImplicitUsings>
  </PropertyGroup>

</Project>
```

要导入新的包可以使用`dotnet add package <包名>`命令,这会同步更新`.csproj`文件,反过来也可以,导入其他项目的`.csproj`文件就可以实现一键导入.


4. `Program.cs`: .NET项目的默认入口文件,可以不叫这个名字,但容易引起混淆,而且根目录下一般只有这一个cs文件

从.NET 6开始,`Program.cs`文件不需要再显式写`static void Main`以标明主函数,如:

```cs
using System;
namespace MyApp
{
public class Program
  {
    public static void Main(string[] args)
      {
      Console.WriteLine("Hello World!");
      }
    }
}
```
而现在可以直接这么写:
```cs
Console.WriteLine("Hello World!");
```
>看起来确实清晰多了,建议Java也学习一下.

然后我们的初始`Program.cs`文件是这样的:
```cs
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => "Hello World!");

app.Run();
```
>这已经可以比得上fastapi的简洁语法了,开发效率这不就一下子上来了.

`builder`会按顺序加载 appsettings.json、appsettings.Development.json、系统环境变量,并注入builder中,然后再通过`app`来锁定这个配置并创建Web服务器.


MapGet函数用来定义如何处理一个使用GET方法的请求。还有其他`Map*`函数用于其他HTTP方法，例如MapPost。

- 说真的,那就没必要加上Map这个前缀啊,估计是有命名冲突吧.

### 进阶项目
```cs
using Microsoft.AspNetCore.HttpLogging;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

builder.Services.AddHttpLogging(opts => 
    opts.LoggingFields = HttpLoggingFields.RequestProperties);

builder.Logging.AddFilter(
    "Microsoft.AspNetCore.HttpLogging", LogLevel.Information);

WebApplication app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseHttpLogging();
}

app.MapGet("/", () => "Hello World!");
app.MapGet("/person", () => new Person("Andrew", "Lock"));
// 自动转换成json格式

app.Run();

public record Person(string FirstName, string LastName);
```

上述代码中往builder内额外注册了两个配置,用于在生产环境下向控制台输出日志.
## 中间件
![示意图](PixPin_2026-07-04_14-31-54.webp)
中间件以`Use`开头的方法来调用.

这些中间件与通常意义上能够均衡负载,处理路由的middleware不同,只是用来调试和作为模板页面而已,很难想象有必要把这种东西加入到核心库中而不是作为扩展包.
## 状态码
```cs
using System.Collections.Concurrent;

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);
WebApplication app = builder.Build();

var _fruit = new ConcurrentDictionary<string, Fruit>();

// #A
app.MapGet("/fruit", () => _fruit);

// #B
app.MapGet("/fruit/{id}", (string id) =>
    _fruit.TryGetValue(id, out var fruit)
        // #C
        ? TypedResults.Ok(fruit)
        // #D
        : Results.NotFound());

// #D
app.MapPost("/fruit/{id}", (string id, Fruit fruit) =>
    _fruit.TryAdd(id, fruit)
        // #E
        ? TypedResults.Created($"/fruit/{id}", fruit)
        // #F
        : Results.BadRequest(new // #G
        { 
            id = "A fruit with this id already exists" 
        })); // #G

// #H
app.MapPut("/fruit/{id}", (string id, Fruit fruit) =>
{
    _fruit[id] = fruit;
    return Results.NoContent();
});

// #H
app.MapDelete("/fruit/{id}", (string id) =>
{
    _fruit.TryRemove(id, out _); // #I
    return Results.NoContent(); // #I
});

app.Run();

record Fruit(string Name, int stock);
```
- ConcurrentDictionary是一个线程安全的字典,支持`TryAdd`,`TryGetValue`等方法
- Results和TypedResults用起来没有区别,但在生成OpenAPI文档时TypedResults可以提供更好的具体类型说明,所以推荐无脑使用TypedResults

## 两种路由
>在 ASP.NET Core 中，路由写法主要分为 Minimal APIs（极简 API / 终结点路由） 和 Controllers（控制器路由 / 传统 MVC）。

**Minimal API 路由写法**
| 写法           | 示例                                                    | 匹配 URL                   | 含义                               |
| -------------- | ------------------------------------------------------- | -------------------------- | ---------------------------------- |
| 根路径         | `app.MapGet("/", () => "Hello");`                       | `/`                        | 访问网站根地址                     |
| 固定路径       | `app.MapGet("/fruit", () => ...);`                      | `/fruit`                   | 路径必须完全匹配 `/fruit`          |
| 路径参数       | `app.MapGet("/fruit/{id}", (string id) => ...);`        | `/fruit/apple`             | `{id}` 会绑定为 `"apple"`          |
| 多个路径参数   | `app.MapGet("/users/{userId}/orders/{orderId}", ...)`   | `/users/1/orders/99`       | 同时接收多个参数                   |
| 指定参数类型   | `app.MapGet("/fruit/{id:int}", (int id) => ...);`       | `/fruit/123`               | 只匹配整数 id                      |
| 可选参数       | `app.MapGet("/fruit/{id?}", (string? id) => ...);`      | `/fruit` 或 `/fruit/apple` | `id` 可以没有                      |
| 默认值参数     | `app.MapGet("/page/{num=1}", (int num) => ...);`        | `/page`                    | 没传时 `num = 1`                   |
| catch-all 路由 | `app.MapGet("/files/{*path}", (string path) => ...);`   | `/files/a/b/c.txt`         | 捕获 `/files/` 后面的剩余路径      |
| 双星 catch-all | `app.MapGet("/files/{**path}", (string path) => ...);`  | `/files/a/b/c.txt`         | 和 `*` 类似，但生成 URL 时保留 `/` |
| 正则约束       | `app.MapGet("/posts/{slug:regex(^[a-z0-9_-]+$)}", ...)` | `/posts/hello-1`           | 只匹配符合正则的 slug              |
| 路由分组       | `app.MapGroup("/api").MapGet("/fruit", ...)`            | `/api/fruit`               | 给一组接口统一加前缀               |

**Controller 路由写法**
| 类型                | 写法                          | 示例 URL           | 说明                            |
| ------------------- | ----------------------------- | ------------------ | ------------------------------- |
| Controller 统一前缀 | `[Route("api/[controller]")]` | `/api/fruit`       | `[controller]` 会替换成控制器名 |
| GET Action          | `[HttpGet]`                   | `/api/fruit`       | 匹配 GET `/api/fruit`           |
| GET 带参数          | `[HttpGet("{id}")]`           | `/api/fruit/apple` | 匹配 GET `/api/fruit/{id}`      |
| POST                | `[HttpPost]`                  | `/api/fruit`       | 新增资源                        |
| PUT                 | `[HttpPut("{id}")]`           | `/api/fruit/apple` | 更新资源                        |
| DELETE              | `[HttpDelete("{id}")]`        | `/api/fruit/apple` | 删除资源                        |
| 指定完整路由        | `[HttpGet("/health")]`        | `/health`          | 以 `/` 开头时通常表示绝对路径   |

由于Controller路由比较古老,写法也比较复杂,所以现在都推荐使用Minimal API写法了.
## 使用EF Core
```cs
public class Recipe
{
  public int RecipeId { get; set; }
  public required string Name { get; set; }
  public TimeSpan TimeToCook { get; set; }
  public bool IsDeleted { get; set; }
  public required string Method { get; set; }
  public required ICollection<Ingredient> Ingredients { get;
  set; } #A
}
public class Ingredient
{
  public int IngredientId { get; set; }
  public int RecipeId { get; set; }
  public required string Name { get; set; }
  public decimal Quantity { get; set; }
  public required string Unit { get; set; }
}
```
>这些类遵循EF Core用来构建其所映射数据库视图的某些默认约定。例如，Recipe类具有RecipeId属性，而Ingredient类包含IngredientId属性。EF Core将这种Id后缀模式识别为表的主键指示符。

- 表的主键是一个能够在该表的所有行中唯一标识某行的值。它通常为int或Guid。

```cs
public class AppDbContext : DbContext
{
  public AppDbContext(DbContextOptions<AppDbContext> options)
  #A
  : base(options) { }
  #A
  public DbSet<Recipe> Recipes { get; set; }
  #B
}
```
创建数据库连接要继承DbContext类,并使用`DbSet`方法逐个创建表格.之后要访问这些表格也只要新建一个AppDbContext示例就可以了.

```cs
class TodoDb : DbContext
{
    public TodoDb(DbContextOptions<TodoDb> options)
        : base(options) { }

    public DbSet<Todo> Todos => Set<Todo>();
}
```
而这个构造函数是用来继承父类的构造函数的,接受数据库配置的依赖注入.



```cs
public class BloggingContext : DbContext
{
    public DbSet<Blog> Blogs { get; set; }
    public DbSet<Post> Posts { get; set; }

    public string DbPath { get; }

    public BloggingContext()
    {
        var folder = Environment.SpecialFolder.LocalApplicationData;
        var path = Environment.GetFolderPath(folder);
        DbPath = System.IO.Path.Join(path, "blogging.db");
    }
    protected override void OnConfiguring(DbContextOptionsBuilder options)
    => options.UseSqlite($"Data Source={DbPath}");
}
```
例如,上面这个普通的DbContext类,可以改写成功能区分的两个文件:
```cs
using Microsoft.EntityFrameworkCore;

public class BloggingContext : DbContext
{
    public DbSet<Blog> Blogs { get; set; }
    public DbSet<Post> Posts { get; set; }

    public BloggingContext(DbContextOptions<BloggingContext> options)
        : base(options)
    {
    }
}
```

```cs
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

var folder = Environment.SpecialFolder.LocalApplicationData;
var path = Environment.GetFolderPath(folder);
var dbPath = Path.Join(path, "blogging.db");

builder.Services.AddDbContext<BloggingContext>(options =>
    options.UseSqlite($"Data Source={dbPath}"));

var app = builder.Build();

app.Run();
```

## 总结
剩下的内容基本都是垃圾了,谁会用C#写前端啊...

总的来说这本书讲的不是很清晰,但也只有这本书能看了
# Entity Framework Core in Action Second Edition
## 概览
### EF core原理
![示意图](PixPin_2026-06-29_21-50-12.webp)

>该图展示了 EF Core 如何依据你映射的类构建数据库模型。首先它通过`DbSet<T>` 属性检查你定义的类，随后会扫描这些类所引用的其他类。借助这些类，EF Core 能够推导出数据库的默认模型。接着它会执行应用程序中 DbContext 的 `OnModelCreating` 方法，你可以重写该方法并添加具体指令，以按你的需求配置数据库。

## 总结
不推荐,又臭又长,讲的也不清楚.

# C# 12 in a Nutshell
- 2024年出版,还是非常新鲜的
## 高级C#
### Lambda Expressions
Lambda表达式具有以下形式：

```cs
(parameters) => expression-or-statement-block
```
### Anonymous Types
匿名类型是由编译器动态创建的一种简单类，用于存储一组值。要创建匿名类型，请使用new关键字，后跟对象初始化器，指定该类型将要包含的属性和值:
```cs
var dude = new { Name = "Bob", Age = 23 };
```

编译器将此（大致）转换为以下内容：
```cs
internal class AnonymousGeneratedTypeName
{
private string name; // Actual field name is irrelevant
private int
 age;
 // Actual field name is irrelevant
public AnonymousGeneratedTypeName (string name, int age)
{
this.name = name; this.age = age;
}
public string
 Name => name;
public int
 Age => age;
// The Equals and GetHashCode methods are overridden (see Chapter 6).
// The ToString method is also overridden.
}
...
var dude = new AnonymousGeneratedTypeName ("Bob", 23);
```

### record
By default, the underlying type of a record is a class:

```cs
record Point { }
 // Point is a class
```

- record class 也是合法的，且与 record 具有相同含义。

## 总结
又臭又长,主要原因却不在这本书上面,而是C#的语法实在太多了,多的离谱,从每个主流语言中都扒拉了不少特性过来,导致整个语法体系臃肿的可怕.

如此看来,我是不看好C#的,只不过是有着微软的大力支持,它才勉强发展到现在的,而不会成为主流的开发语言,毕竟用C#开发确实很麻烦.
# x86汇编语言：从实模式到保护模式(第二版)
这本书的前半部分围绕8086处理器,后半部分围绕80386处理器.
## 基础知识

### ROM
>8086 有 20 根地址线，但并非全都用来访问 DRAM，也就是内存条。事实上，这些地址线经过分配，大部分用于访问 DRAM，剩余的部分给了只读存储器（Read Only Memory，ROM）和外围的板卡，如图所示。

![示意图](PixPin_2026-07-01_21-53-30.webp)

>与 DRAM 不同，ROM 不需要刷新，它的内容是预先写入的，即使掉电也不会消失，但也很难改变.

因此,我们可以在ROM中存入初始化指令,在电脑开机时载入最基本的硬件(如硬盘和内存),这块ROM芯片又被称为基本输入输出系统(（Base Input & Output System，BIOS）)ROM,即ROM-BIOS.

这是很显然的,因为操作系统都装在硬盘里呢,所以我们需要BIOS来激活操作系统.

### 硬盘
>谁能想到这本书对磁盘的讲解远远超过了我至今见过的所有底层技术书籍呢

硬盘由一个或者多个盘片组成,都串联在一个转轴上,由电动机带动着不断高速旋转,每个盘片都有两个磁头(Head),上面一个下面一个,磁头通过磁头臂固定在磁头支架上,由另一个电动机带动着在盘片的中心和边缘之间来回移动,速度略慢.

盘片高速旋转过程中会画出一个圆圈,由内而外半径主键变大,这就是磁道(Track),所有的磁头和垂直对应的磁道形成了一个虚拟的圆柱,称为柱面.

磁道和柱面也要编号,从0开始.磁道进一步可以划分成扇区(sector),是读写数据的最小单元,每个扇区也有编号,从1开始.


![一个非常清晰的示意图](PixPin_2026-07-01_22-11-11.webp)
### 主引导扇区
硬盘的第一个扇区是 0 面 0 道 1 扇区，或者说是 0 头 0 柱 1 扇区，这个扇区称为主引导扇区（Main Boot Sector，MBR）。如果计算机的设置是从硬盘启动的，那么，ROM-BIOS 将读取硬盘主引导扇区的内容，将它加载到内存地址 0x0000:0x7c00（也就是物理地址 0x07C00），然后用一个 jmp 指令跳到那里接着执行.

>为什么偏偏是 0x7c00 这个地方？还不太清楚。反正当初定下这个方案的家伙已经被人说了很多坏话，我也就不准备再多说什么了。

一般来说，主引导扇区是由操作系统负责的。正常情况下，一段精心编写的主引导扇区代码将检测用来启动计算机的操作系统，并计算出它所在的硬盘位置。然后，它把操作系统的自举代码加载到内存，也用 jmp 指令跳转到那里继续执行，直到操作系统完全启动

，我们知道，8086 可以访问 1MB 内存。其中，0x00000～9FFFF 属于常规内存，由内存条提供；0xF0000～0xFFFFF 由主板上的一个芯片提供，即 ROM-BIOS。

这样一来，中间还有一个 320KB 的空洞，即 0xA0000～0xEFFFF。传统上，这段地址空间由特定的外围设备来提供，其中就包括显卡。

![示意图](PixPin_2026-07-03_09-51-21.webp)



## 实模式
### 8086处理器架构
- 8086处理器是INTEL的第一款16位处理器,诞生于1978年

8086中有8个16位(两个字节)的通用寄存器,结构如下:

![示意图](PixPin_2026-06-29_17-48-33.webp)

由于x86中指令的长度不定,短的只有1字节,长的有15字节,所以需要将指令和数据分开存放在内存中.

内存的结构如下:

![结构图](PixPin_2026-06-29_18-06-29.webp)

内存的最小访问单元是1字节,每一位地址对应1个字节.

关于8086架构的一个详细示意图如下:

![示意图](PixPin_2026-06-30_20-01-58.webp)

8086 内部有 4 个段寄存器。其中，CS 是代码段寄存器，DS 是数据段寄存器，ES 是附加段（Extra Segment）寄存器,SS 是栈段（Stack Segment）寄存器

IP是指令指针（Instruction Pointer）寄存器,只和CS一起使用,当一段代码开始执行时,CS 保存代码段的段地址，IP 则指向段内偏移。这样，由 CS 和 IP 共同形成逻辑地址.
### 汇编语言
16进制的英文是Hexadecimal,比如125H后面的“H”用于表明这是一个十六进制数,但在很多高级语言中，如果要指示一个数是十六进制数，通常不采用在后面加“H”的做法，而是为它添加一个“0x”前缀，如:
```asm
mov ax,0x3f
```

>你可能想问一下，为什么会是这样，为什么会是“0x”？答案是不知道，不知道在什么时候，为什么就这样用了。这不得不让人怀疑，它肯定是一个非常随意的决定，并在以后形成了惯例

### 运算指令
- neg: 将寄存器/内存中的数据变成负数,如`neg al`
- ：cbw:（Convert Byte to Word）,将8位(Byte)的有符号数扩展为16位(Word),即补上全0或者全1.
- cwd: （Convert Word to Double-word）,把16位有符号数扩展到32位,这是借助了DX寄存器来实现的
- `inc ah`: 将ah中的数据加1
- `add ah, al`: 相加并将数据送入ah.
- `sub ah, al`: 相减并将数据送入ah
- `idiv/div bx`: 有符号/无符号除法

大多数时候,无符号数和有符号数是可以同等处理的,如下列指令:
```asm
mov ah, 0xf0
inc ah
```
>在这里，0xf0 的二进制形式是 11110000，它既可以解释为无符号数 240（十进制），也可以解释为有符号数-16，毕竟它的符号位是 1。无论如何，inc 是加一指令，这条指令执行后，寄存器 AH 中的内容是二进制数 11110001，既是无符号数 241，也是有符号数-15。

所以在设计的时候我们并不需要花心思去判别这到底是不是负数,而是让使用者自己决定.

为了给运算提供方便,x86中有一个专门的FLAGS标志寄存器,存储各种运算结果的标志:

![示意图](PixPin_2026-07-04_09-59-06.webp)

但对于除法和乘法,无符号数和有符号数是有区别的,所以需要单独增加几个扩展指令.
### 栈
8086中有一个栈段(Stack Segment),由段寄存器SS存储初始地址,并依靠栈指针SP指示当前的栈顶,由处理器自动维护,我们只要使用push/pop指令就可以方便的进行栈操作了.


- or/xor/and: 逐位进行或/异或/与运算,如`or al, 0xaa`
- push/pop: 将某个寄存器/内存单元的内容压入/推出栈顶,如`push ax`

### 寻址
有三种寻址方式:
1. 寄存器寻址: 要操作的数在寄存器中,如`mov ax, cx`
2. 立即数寻址: 要操作的数直接给出了,如`add bx, 0xf000`
3. 内存寻址: 访问内存来获取数据,分为4种;
   1. 直接寻址: `mov ax, [0x5c0f]`
   2. 基址寻址: 将要寻址的内存地址放在寄存器中,如`mov [bx], dx`
   3. 变址寻址: 使用变址寄存器来存储内存地址,如`mov [si + 0x100], al`
   4. 基址变址寻址: 如`mov ax, [bx + si]`
### 中断
Intel处理器使用两根信号线来处理中断:
- NMI: 对应电池耗尽,内存读取错误等严重事件,需要立即处理,称为不可屏蔽中断
- INTR: 对应键盘输入等不着急处理的中断信号,称为可屏蔽中断

我们使用中断号来区分不同类型的中断信号,对于不可屏蔽中断,我们使用固定的中断号2,然后再由特定的软件来进行分别的处理;对于可屏蔽中断,由于可能会同时发生多个,所以需要用多个中断号来区分,Intel处理器中用8259芯片来处理(或者说缓存)这些中断.

### 时钟
ICH(I/O Controller Hub)芯片用于处理所有的I/O,内置了实时时钟电路（Real Time Clock，RTC）和两
小块由互补金属氧化物（CMOS）材料组成的静态存储器（CMOS RAM）.

RTS的频率为1秒,用于显示电脑的时间,而日期和时间信息保存在 CMOS RAM 中,通常有 128 字节，而日期和时间信息只占了一小部分容量，其他空间则用于保存整机的配置信息，比如各种硬件的类型和工作参数、开机密码和辅助存储设备的启动顺序等


## 保护模式
### 32位x86处理器架构
32位处理器扩展了8086中8个通用寄存器的长度,用一个前缀`E`来表示,如`eax,ebx`等:
![示意图](PixPin_2026-07-06_10-09-06.webp)

低16位可以兼容16位处理器上的软件,而高16位则作为32位模式下的扩展.

- 其余的部件也都进行了从16位到32位的扩展

### 保护模式介绍
>一般来说，操作系统负责整个计算机软、硬件的管理，它做任何事情都是可以的。但是，用户程序却应当有所限制，只允许它访问属于自己的数据，即使是转移，也只允许在自己的各个代码段之间进行。

* **实模式：** Real Mode,用户程序可以绕过操作系统,随意访问内存并进行修改
* **保护模式：** Protected Mode,用户程序无法访问不属于自己的内存

#### 全局描述符表(GDT)
全局描述符表用于存储所有要用到的段的描述符,应用程序运行时,由操作系统在GDT中分配,任何试图访问其他不属于自己的段的行为都会被处理器阻止.

每个段描述符为8字节,对应64位:
![段描述符](PixPin_2026-07-08_11-48-03.webp)

>DPL 表示描述符的特权级（Descriptor Privilege Level，DPL）。共有 4 种处理器支持的特权
级别，分别是 0、1、2、3，其中 0 是最高特权级别，3 是最低特权级别。

>在这里，描述符的特权级用于指定要访问该段所必须具有的最低特权级。
如果这里的数值是 2，那么，只有特权级别为 0、1 和 2 的程序才能访问该段，
而特权级为 3 的程序访问该段时，处理器会予以阻止。

### x86指令集
x86 处理器的机器指令大体上可由五大部分组成:

![图示](PixPin_2026-07-08_12-09-36.webp)

### 分页机制
从80386处理器开始,引入了分页机制,用长度固定的页来代替长度不一的段,从而更好地管理内存空间

![图示](PixPin_2026-07-11_08-04-37.webp)

处理器处理的都是段,编译时分配的也都是段表,并没有页的概念,需要由操作系统建立从段到页的映射,再由处理器来执行转换和取页操作.

由于早期内存容量不足的问题,内存中没办法一下子装入所有的映射,80386采用了使用多个页表来进行映射:

![示意图](PixPin_2026-07-11_08-23-56.webp)

每个进程都有自己的页目录和页表,所以当进程切换时,页目录和页表也会进行切换,所以,这就是进程切换开销最大的地方吧.

## 总结
非常不错的书呢,不过实战的部分由于不太可能复刻,所以都直接跳过了,但收获是很大的,姑且能看懂一点汇编代码了吧.

# Python源码剖析
## 概览
Python的整体架构如下:

![示意图](PixPin_2026-07-02_13-24-52.webp)

分为三个部分:
1. 模块: 系统模块(如os)和用户自定义模块(如fastapi)
2. python运行时: python程序运行时的所有上下文,包括类型系统,内存分配器和运行时的状态信息.
3. python解释器/虚拟机: 将python代码转换成字节码,并执行该字节码.

这本书分析的python版本为06年发布的2.5,距今已经有整整二十年,而我们都知道python3对python2做了很多大规模的修改,看一下两者的架构图对比:

![示意图](PixPin_2026-07-02_13-35-02.webp)

**python2.5**
```bash
---------------------------------------------------------------------------------------
Language                             files          blank        comment           code
---------------------------------------------------------------------------------------
Python                                1757          63467          82162         314024
C                                      364          38904          26691         302471
TeX                                    379          24318           1857         104858
C/C++ Header                           210           5150           8076          50944
Bourne Shell                            40           3205           3238          29277
MSBuild script                          45              0              0          14596
Text                                    97           1969              0          10161
Assembly                                29           1146           1944           5809
Lisp                                     3            537            519           3678
Perl                                    11            599            852           3677
make                                    14            657            505           3202
HTML                                    21            488             11           2843
Windows Module Definition                9            170            187           2050
XML                                     11            160             32           1251
reStructuredText                         2            285             74           1005
Objective-C                              6            105             75            660
Visual Studio Solution                   4              0              1            526
SVG                                      1             88              0            521
m4                                       2             34              5            296
Windows Resource File                    4             45             56            207
CSS                                      1             32             44            167
DOS Batch                               11             23             45            144
vim script                               1             36              7            104
INI                                      1             42             27            102
JSON                                     3              0              0             70
Expect                                   1              0              0             60
NAnt script                              4              2              0             60
Snakemake                                1             15              6             27
VBScript                                 2              1              1             12
diff                                     1              5             19             12
IDL                                      1              4              0             11
sed                                      1              0              0              3
---------------------------------------------------------------------------------------
SUM:                                  3037         141487         126434         852828
---------------------------------------------------------------------------------------
```
- 852 828行代码

**python3.14**
```bash
github.com/AlDanial/cloc v 2.08  T=39.25 s (113.7 files/s, 65894.3 lines/s)
---------------------------------------------------------------------------------------
Language                             files          blank        comment           code
---------------------------------------------------------------------------------------
Python                                2069         155895         171967         711733
C                                      467          70795          70129         490277
C/C++ Header                           619          29165          16692         254550
reStructuredText                       534          93860         119054         112181
Text                                   140           2808              0         104884
JSON                                    28              3              0          53816
XML                                    212            382            178          46085
Bourne Shell                            38           5554           3358          33031
m4                                       2            806            345           7876
Markdown                                27           1275             25           4478
C++                                      7            834            355           3789
TOML                                    75            109            130           2724
HTML                                    13            137              0           2427
WiX source                              52            194             44           2017
DOS Batch                               32            368            120           1829
Visual Studio Solution                   2              1              2           1814
Objective-C                             10            138             98            793
MSBuild script                          30             44              3            687
SVG                                     11              1             37            672
Windows Module Definition                6             23             12            557
diff                                     6             15            264            504
Lisp                                     1            109             81            502
JavaScript                               6             51             32            436
make                                     4             72             45            364
PowerShell                               7             88            179            352
INI                                     11             69             27            250
Windows Resource File                    6             37             52            242
Gradle                                   3             38             19            235
BitBake                                  2              2              0            186
WiX string localization                 11             20              0            182
YAML                                     3             15             10            154
CSS                                      2             27              5            101
Kotlin                                   2             18             14             95
D                                        5              8              1             74
Assembly                                 2              2             46             57
PO File                                  2             12              4             54
Bourne Again Shell                       2              8              2             46
Fish Shell                               1             13             14             42
TypeScript                               2              5              0             32
PHP                                      1              8             20             30
IDL                                      1              0              0             24
XSLT                                     2              5             12             16
C Shell                                  1             10              5             12
CMake                                    1              3              1             10
Properties                               2              1             23             10
DTD                                      1              4              0              2
VBScript                                 1              0              1              0
---------------------------------------------------------------------------------------
SUM:                                  4462         363032         383406        1840232
---------------------------------------------------------------------------------------
```
- 1 840 232行代码

两倍多的增量注定了这本书太老了,不过话又说回来,也正是因为分析的python版本老,我们才能看得清楚python的核心架构,所以更有必要看这本书了.

Python2.5的核心文件夹如下:
* **Include**：包含了 Python 提供的所有头文件。用户若使用 C 或 C++ 编写自定义扩展模块，需调用此处的头文件。
* **Lib**：包含了 Python 自带的所有标准库，均使用 Python 语言编写。
* **Modules**：包含了用 C 语言编写的模块（如 random、cStringIO）。主要存放对执行速度要求极高的模块。
* **Parser**：包含了 Python 解释器中的 Scanner（词法分析）和 Parser（语法分析）部分，以及可根据语法自动生成词法/语法分析器的工具。
* **Objects**：包含了所有 Python 的内建对象（如整数、list、dict）以及运行时所需的内部对象的具体实现。
* **Python**：包含了 Python 解释器中的 Compiler（编译器）和执行引擎部分，是 Python 运行的核心。
* **PCBuild**：包含了 Visual Studio 2003 的工程文件，用于在 VS2003 环境下编译 Python 源码。
* **PCBuild8**：包含了 Visual Studio 2005 使用的工程文件。

## Python内部对象
### 概览
在Python中,一切都是对象,甚至类型(如int,string)也是一个对象.

Python的实现语言一直都是ANSI C(C的简单改版),它并不是一个面向对象的语言,那么Python是如何实现面向对象的呢?

在Python中,对象为C中的结构体在堆上申请的一块内存,我们都知道堆的申请每次都要指定内存大小(malloc),那么一个对象一旦被创建,它的内存大小就是不变的了.

这样一来,诸如列表,字典等可变长度的对象就需要维护一个指针了,随时指向一个新的内存区域以便扩展或者收缩容量.

### PyObject
PyObject是所有python对象的基本内容,不同的类型是在PyObject上进行扩展来实现的:
```c
[object.h]
typedef struct _object {
PyObject_HEAD
} PyObject;
```
为了存储变长的对象,python设计了一个PyVarObject,本质上也还是对PyObject的简单扩展:
```c
[object.h]
#define PyObject_VAR_HEAD \
PyObject_HEAD \
int ob_size; /* Number of items in variable part */
typedef struct {
PyObject_VAR_HEAD
} PyVarObject;
```


![图示](PixPin_2026-07-03_13-48-30.webp)

>在 Python 内部，每一个对象都拥有相同的对象头部。这就使得在 Python 中，对对象的引用变得非常的统一， 我们只需要用一个 PyObject* 指针就可以引用任意的一个对象。而不论该对象实际是一个什么对象。
### 引用计数
Python的垃圾回收使用的是引用计数,初始计数为1,被引用对象增加或删除时对应增减,当一个对象的引用计数减少到 0 之后,Python将调用该对象的析构函数(实际为C中的free)来释放该对象所占有的内存和系统资源

### 整数对象
Python中的整数对象PyIntObject会根据整数的大小来进行适配管理,小整数会被放入一个驻留在内存的对象池中,永远不会被销毁,无论创建多少次都会指向同一个内存地址;

![示意图](PixPin_2026-07-04_11-41-31.webp)

而大整数会放入一块共享的内存空间,通过一个单向链表来管理其中所有的空闲内存

### 字符串对象
PyStringObject是一个有着可变长度内存的对象,定义如下:
```c
typedef struct {
  PyObject_VAR_HEAD
  long ob_shash;
  int ob_sstate;
  char ob_sval[1];
} PyStringObject;
```

>同 C 中的字符串一样，PyStringObject 内部维护的字符串在末尾必须以’\0’结尾，

与对待小整数的方式一样,Python为一个字节的字符也设置了一个对象缓冲池.

由于PyStringObject是一个不可变对象,所以每次用`+`进行字符串拼接时都要创建一个新对象,这会极大地降低python运行效率,官方的做法是在需要在一个循环中进行多次拼接时,就统一获取后再进行唯一的一次拼接.这样就可以提高运行的效率.
### List对象
类似于cpp中的vector机制,不多赘述.
### Dict对象
PyDictObject对搜索的效率要求极其苛刻,这是因为 PyDictObject 对象在Python 本身的实现中被大量地采用。比如 Python 会通过 PyDictObject 来建立执行 Python字节码的运行环境，其中会存放变量名和变量值的元素对，通过查找变量名获得变量值。

因此，PyDictObject 没有如cpp STL中的 map 一样采用红黑树，而是采用了散列表（hash table），因为理论上，在最优情况下，散列表能提供 O（1）复杂度的搜索效率。

```c
typedef struct {
  Py_ssize_t me_hash;
  /* cached hash code of me_key */
  PyObject *me_key;
  PyObject *me_value;
} PyDictEntry;
```
而实际的字典PyDictObject就是管理PyDictEntry节点的结构体容器,通过数组来实现随机存取:
```c
#define PyDict_MINSIZE 8
typedef struct _dictobject PyDictObject;
struct _dictobject {
  PyObject_HEAD
  Py_ssize_t ma_fill; //元素个数： Active + Dummy
  Py_ssize_t ma_used; //元素个数： Active
  Py_ssize_t ma_mask;
  PyDictEntry *ma_table;
  PyDictEntry *(*ma_lookup)(PyDictObject *mp, PyObject *key, long hash);
  PyDictEntry ma_smalltable[PyDict_MINSIZE];
};
```
>当产生散列冲突时，Python 会通过一个二次探测函数 f ，计算下一个候选位置 addr，
如果位置 addr 可用，则可将待插入元素放到位置 addr；如果位置 addr 不可用，则 Python
会再次使用探测函数 f，获得下一个候选位置，如此不断探测，总会找到一个可用的位置。

这个f的递推公式如下:
```c
i = (i << 2) + i + perturb + 1;
```
## Python虚拟机
### Python编译
![图示](PixPin_2026-07-09_12-16-26.webp)

>虽然 Python 程序执行的机理与 Java 程序和 C# 程序的执行机理是一样的，但是 Python 的虚拟机与 Java 和 .NET 虚拟机还有不同之处。一个最大的不同是，Python 的虚拟机是一种更高级的虚拟机。这里的高级不是说 Python 的虚拟机的功能比 Java 和 .NET 虚拟机的功能更强大、更拽，而是说与 Java 或 .NET 相比，Python 的虚拟机距离真实机器更远。或者可以这么说，Python 虚拟机是一种抽象层次更高的虚拟机。

在程序运行期间，编译结果存在于内存的 PyCodeObject 对象中；而 Python 结束运行后，编译结果又被保存到了 pyc 文件中。当下一次运行相同的程序时，Python 会根据 pyc文件中记录的编译结果直接建立内存中的 PyCodeObject 对象，而不用再次对源文件进行编译了。

Python 编译器在对 Python 源代码进行编译的时候，对于代码中的一个 Code Block，会创建一个 `PyCodeObject` 对象与这段代码对应。那么如何确定多少代码算是一个 Code Block 呢？事实上，Python 有一个简单而清晰的规则：当进入一个新的名字空间，或者说作用域时，我们就算是进入了一个新的 Code Block 了。

也就是说,每个python文件,每个函数,每个类都会被分配一个PyCodeObject,


每一个 `PyCodeObject` 对象中都包含了每一个 Code Block 中所有 Python 源代码经过编译后得到的 byte code 序列。前面我们提到，Python 会将这些字节码序列和 `PyCodeObject` 对象一起存储在 pyc 文件中。但不幸的是，事实并不总是这样。试着在命令行下执行一下 `python demo.py`，你会发现 Python 并没有产生一个对应的 pyc 文件。为什么呢？真实的原因不得而知，不过我们可以做出一个合理的猜测：有一些 Python 程序只是临时完成一些琐碎的工作，比如统计某个特定文件中的词频信息，这样的程序可能仅仅运行一次，然后就再也没用了，所以也就没有保存其对应的 pyc 文件的必要，因此，对于直接用 `python demo.py` 这样的形式执行的程序，Python 就不会存储编译结果了。

但是假如说 `demo.py` 中实现的是一个需要被重用的类时，我们就希望能存储其对应的 `PyCodeObject` 对象，这样下次 Python 就不会再次进行编译了。当在另外一个程序，比如说在 `demo.py` 中对 `demo.py` 进行一个 `import demo` 的动态加载动作之后，你就会发现，Python 会为其产生 pyc 文件了。

也就是说,import机制才会触发pyc文件的生成,这也解释了为什么我们一般没见过`main.pyc`这个文件.

`PyCodeObject`中记录了各种各样的Code Block信息:

![示意图](PixPin_2026-07-09_12-35-24.webp)

```c
// [import.c]
static void write_compiled_module(PyCodeObject *co, char *cpathname, long mtime)
{
    FILE *fp;
    // 排他性地打开文件
    fp = open_exclusive(cpathname);
    // [1]: 写入 Python 的 magic number
    PyMarshal_WriteLongToFile(pyc_magic, fp, Py_MARSHAL_VERSION);
    // [2]: 写入时间信息
    PyMarshal_WriteLongToFile(mtime, fp, Py_MARSHAL_VERSION);
    // [3]: 写入 PyCodeObject 对象
    PyMarshal_WriteObjectToFile((PyObject *)co, fp, Py_MARSHAL_VERSION);

    fflush(fp);
    fclose(fp);
}
```
从 write_compiled_module 中可以发现，一个 pyc 文件中实际上包含了三部分独立的信息：Python 的 magic number、pyc 文件创建的时间信息，以及 PyCodeObject 对象。

不同版本的Python会定义不同的魔数,如果编译器发现某个文件的魔数对不上,则会因为不兼容而报错.

### Python虚拟机框架


# Pro git
- [官网](https://git-scm.com/book/zh/v2)

## 起步
>Git 和其它版本控制系统（包括 Subversion 和近似工具）的主要差别在于 Git 对待数据的方式。 从概念上来说，其它大部分系统以文件变更列表的方式存储信息，这类系统（CVS、Subversion、Perforce 等等） 将它们存储的信息看作是一组基本文件和每个文件随时间逐步累积的差异 （它们通常称作 基于差异（delta-based） 的版本控制）。

Git 不按照以上方式对待或保存数据。反之，Git 更像是把数据看作是对小型文件系统的一系列快照。 在 Git 中，每当你提交更新或保存项目状态时，它基本上就会对当时的全部文件创建一个快照并保存这个快照的索引。 为了效率，如果文件没有修改，Git 不再重新存储该文件，而是只保留一个链接指向之前存储的文件。 Git 对待数据更像是一个 快照流。

>在 Git 中的绝大多数操作都只需要访问本地文件和资源，一般不需要来自网络上其它计算机的信息。 如果你习惯于所有操作都有网络延时开销的集中式版本控制系统，Git 在这方面会让你感到速度之神赐给了 Git 超凡的能量。 因为你在本地磁盘上就有项目的完整历史，所以大部分操作看起来瞬间完成。

Git 中所有的数据在存储前都计算校验和，然后以校验和来引用。 这意味着不可能在 Git 不知情时更改任何文件内容或目录内容。 这个功能建构在 Git 底层，是构成 Git 哲学不可或缺的部分。 若你在传送过程中丢失信息或损坏文件，Git 就能发现。

你执行的 Git 操作，几乎只往 Git 数据库中 添加 数据。 你很难使用 Git 从数据库中删除数据，也就是说 Git 几乎不会执行任何可能导致文件不可恢复的操作。 同别的 VCS 一样，未提交更新时有可能丢失或弄乱修改的内容。但是一旦你提交快照到 Git 中， 就难以再丢失数据，特别是如果你定期的推送数据库到其它仓库的话。

现在请注意，如果你希望后面的学习更顺利，请记住下面这些关于 Git 的概念。 Git 有三种状态，你的文件可能处于其中之一： 已提交（committed）、已修改（modified） 和 已暂存（staged）。

- 已修改表示修改了文件，但还没保存到数据库中。
- 已暂存表示对一个已修改文件的当前版本做了标记，使之包含在下次提交的快照中。
- 已提交表示数据已经安全地保存在本地数据库中。

![示意图](PixPin_2026-07-06_14-41-02.webp)

也就是说,直接改系统目录下的`.gitconfig`文件也可以更新全局代理.

![示意图](PixPin_2026-07-06_14-51-43.webp)

## Git基础
- `git init`: 初始化git仓库
- `git add`: 追踪新文件
- `git commmit`: 提交新文件
- `git clone url`: 从远程的仓库拉取文件和git记录

文件 `.gitignore` 的格式规范如下：

* 所有空行或者以 `#` 开头的行都会被 Git 忽略。
* 可以使用标准的 glob 模式匹配，它会递归地应用在整个工作区中。
* 匹配模式可以以（`/`）开头防止递归。
* 匹配模式可以以（`/`）结尾指定目录。
* 要忽略指定模式以外的文件或目录，可以在模式前加上叹号（`!`）取反。

>尽管使用暂存区域的方式可以精心准备要提交的细节，但有时候这么做略显繁琐。 Git 提供了一个跳过使用暂存区域的方式， 只要在提交的时候，给 git commit 加上 -a 选项，Git 就会自动把所有已经跟踪过的文件暂存起来一并提交，从而跳过 git add 步骤：

```bash
$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

    modified:   CONTRIBUTING.md

no changes added to commit (use "git add" and/or "git commit -a")
$ git commit -a -m 'added new benchmarks'
[master 83e38c7] added new benchmarks
1 file changed, 5 insertions(+), 0 deletions(-)
```

```bash
git commit -a -m 'added new benchmarks'
```
- 这种写法确实不错,又能偷点懒了


例如，你提交后发现忘记了暂存某些需要的修改，可以像下面这样操作：
```bash
$ git commit -m 'initial commit'
$ git add forgotten_file
$ git commit --amend
```
最终你只会有一个提交——第二次提交将代替第一次提交的结果。

>修补提交最明显的价值是可以稍微改进你最后的提交，而不会让“啊，忘了添加一个文件”或者 “小修补，修正笔误”这种提交信息弄乱你的仓库历史。


git checkout 用于撤销之前所做的修改.

>请务必记得 `git checkout — <file>` 是一个危险的命令。 你对那个文件在本地的任何修改都会消失——Git 会用最近提交的版本覆盖掉它。 除非你确实清楚不想要对那个文件的本地修改了，否则请不要使用这个命令。

### 远程仓库
```bash
$ git clone https://github.com/schacon/ticgit
Cloning into 'ticgit'...
remote: Reusing existing pack: 1857, done.
remote: Total 1857 (delta 0), reused 0 (delta 0)
Receiving objects: 100% (1857/1857), 374.35 KiB | 268.00 KiB/s, done.
Resolving deltas: 100% (772/772), done.
Checking connectivity... done.
$ cd ticgit
$ git remote
origin
```
### git别名
Git 并不会在你输入部分命令时自动推断出你想要的命令。 如果不想每次都输入完整的 Git 命令，可以通过 git config 文件来轻松地为每一个命令设置一个别名。 这里有一些例子你可以试试：

```bash
$ git config --global alias.co checkout
$ git config --global alias.br branch
$ git config --global alias.ci commit
$ git config --global alias.st status
```
这意味着，当要输入 git commit 时，只需要输入 git ci

## Git分支
- `git baranch`用于确认有哪些分支,`git branch 分支名`用于创建分支,这只不过是创建了一个新的git指针,并不需要复制文件的内容.
- `git checkout`用于切换分支,这是通过git指针的移动实现的.

`git checkout -b 分支名`是两条命令的结合,可以快速创建一个新分支.

- `git merge 分支名`用于将某个分支合并到当前分支上, 如果顺着一个分支走下去能够到达另一个分支,那么合并时只需要简单地将旧分支的指针往前面移动就可以了,这被称为快进(fast-forward).

![图1](PixPin_2026-07-08_14-20-38.webp)

![图2](PixPin_2026-07-08_14-20-51.webp)

- `git branch -d 分支名`用于删除不需要的分支

```bash
$ git branch -d hotfix
Deleted branch hotfix (3a0874c).
```

>假设你已经修正了 #53 问题，并且打算将你的工作合并入 master 分支。 为此，你需要合并 iss53 分支到 master 分支，这和之前你合并 hotfix 分支所做的工作差不多。 你只需要检出到你想合并入的分支，然后运行 git merge 命令：

```bash
$ git checkout master
Switched to branch 'master'
$ git merge iss53
Merge made by the 'recursive' strategy.
index.html |    1 +
1 file changed, 1 insertion(+)
```

>这和你之前合并 hotfix 分支的时候看起来有一点不一样。 在这种情况下，你的开发历史从一个更早的地方开始分叉开来（diverged）。 因为，master 分支所在提交并不是 iss53 分支所在提交的直接祖先，Git 不得不做一些额外的工作。 出现这种情况的时候，Git 会使用**两个分支的末端**所指的快照（C4 和 C5）以及**这两个分支的公共祖先**（C2），做一个简单的**三方合并**。

![图1](PixPin_2026-07-08_14-26-42.webp)

![图2](PixPin_2026-07-08_14-26-53.webp)

如果你在两个不同的分支中，对同一个文件的同一个部分进行了不同的修改，Git 就没法干净的合并它们。 如果你对 #53 问题的修改和有关 hotfix 分支的修改都涉及到同一个文件的同一处，在合并它们的时候就会产生合并冲突：

```bash
$ git merge iss53
Auto-merging index.html
CONFLICT (content): Merge conflict in index.html
Automatic merge failed; fix conflicts and then commit the result.
```

```bash
$ git status
On branch master
You have unmerged paths.
  (fix conflicts and run "git commit")

Unmerged paths:
  (use "git add <file>..." to mark resolution)

    both modified:      index.html

no changes added to commit (use "git add" and/or "git commit -a")
```
## 服务器上的git(过)
Git 可以使用四种不同的协议来传输资料：本地协议（Local），HTTP 协议，SSH（Secure Shell）协议及 Git 协议。
## Github
>现在，你完全可以使用 https:// 协议，通过你刚刚创建的用户名和密码访问 Git 版本库。 但是，如果仅仅克隆公有项目，你甚至不需要注册——刚刚我们创建的账户是为了以后 fork 其它项目，以及推送我们自己的修改。

我现在才知道原来用http协议甚至不需要注册ssh公钥,那么这样来看那些教新手入门Git的教程全都在扯淡了,直接让新人用http协议clone不就可以了,也就没有那么劝退了.

>如果你想要参与某个项目，但是并没有推送权限，这时可以对这个项目进行“派生（Fork）”。 当你“派生”一个项目时，GitHub 会在你的空间中创建一个完全属于你的项目副本，且你对其具有推送权限。
## Git工具



# GitHub Actions in Action
## 补充: 官网文档阅读
- [官网](https://docs.github.com/zh/actions/get-started/quickstart)
### 基本概念
workflow由以下基本组件组成:
1. 一个或多个触发该工作流的事件,如push和pull
2. 一个或者多个Job,每个Job都独立地在一个Runner上执行
3. 每个Job由多个Step组成,这些一般都是脚本命令

不得不承认,官网的文档写的很烂...



## yaml基础
yaml的变量写法都是如同`key: value`的形式,即便是带空格的字符串也不需要单独用引号包裹,如果要写成多行字符串,则如下所示:
```yml
literal_block: |
    Text blocks use four spaces as indentation. The entire
    block is assigned to the key 'literal_block' and keeps
    line breaks and empty lines.
    The block continuous until the next YAML element with the same
    indentation as the literal block.

```

yaml中使用两种集合类型: map和list,map的写法就是用多级缩进:
```yaml
parent:
  key1: value1
  key2: value2
  child:
  key1: value1
```
list的写法则用`-`标明:
```yaml
sequence:
  - item1
  - item2
  - item3
```

## workflow语法
- 习惯上我们会在第一行给这个workflow命名:
```yml
name: My First Workflow
```
### 触发器
触发器(trigger)有三种:
1. Webhook triggers
2. Scheduled triggers
3. Manual triggers

>All triggers follow the key **on**: in the workflow file.

Webhook triggers 根据某个Github事件被触发,可以是对仓库的推送或者拉取:
```yaml
on: push
on: [push, pull_request]

# 第二种写法其实就是列表写法
on:
 - push
 - pull_request
```

有时候我们希望只在特定分支下的某个特定文件夹中触发workflow,就可以这么写:
```yml
on:
  push:
    branches:
    - 'main'
    - 'release/**'
    paths:
    - 'doc/**'
```
>有许多可用的Webhook触发器——例如，您可以在issues事件上运行工作流。支持的活动类型筛选器包括opened、edited、deleted、
transferred、pinned、unpinned、closed、reopened、assigned

Schedule triggers会在特定时间段执行,使用的语法包含五个字段，分别代表分钟（0 –59）、小时（0–23）、月份中的日期（1–31）、月份（1–12或JAN–DEC）以及星期几（0–6或SUN–SAT）.

可以使用`*`,`'`,`-`,`/`四种操作符,分别表示`任何值`,`分隔符`,`范围`,`step value(每多长时间执行一次)`.

```yaml
on:
  schedule:
    # Runs at every 15th minute
    - cron: '*/15 * * * *'
    # Runs every hour from 9am to 5pm
    - cron: '0 9-17 * * *'
    # Runs every Friday at midnight
    - cron: '0 0 * * FRI'
    # Runs every quarter (00:00 on day 1 every 3rd month)
    - cron: '0 0 1 */3 *'

```

manual triggers用于手动触发workflow,`workflow_dispatch`和`repository_dispatch`是其中的代表.
### jobs和steps
Jobs默认可以并行运行,但可以使用`needs`关键字让某些job在特定的任务完成后再运行.

```yaml
jobs:
  job_1:
    runs-on: ubuntu-latest
    steps:
      - run: "echo Job: ${{ github.job }}"

  job_2:
    runs-on: ubuntu-latest
    needs: job_1
    steps:
      - run: "echo Job: ${{ github.job }}"

  job_3:
    runs-on: ubuntu-latest
    needs: job_1
    steps:
      - run: "echo Job: ${{ github.job }}"

  job_4:
    runs-on: ubuntu-latest
    needs: [job_2, job_3]
    steps:
      - run: "echo Job: ${{ github.job }}"

```
![示意图](PixPin_2026-07-08_17-41-41.webp)

## 总结
剩下的内容就都是扯淡了,不过前面的内容讲的还算详细,配合第一章的实战来看就能基本搞懂Github Actions是什么了.



# Fundamentals of DevOps and Software Delivery
## Preface
>DevOps 诞生于 2000 年代末，最初是为了解决企业软件交付效率低下的问题。
传统上，大多数公司设有两个独立团队：开发团队（Dev）负责编写软件，运维团队（Ops）负责管理硬件。
许多公司的这两个团队目标相冲突，各自为政。
运维团队的核心目标通常是安全性和可靠性，因此只有他们有权访问生产系统，需负责部署和应对系统故障。
而开发团队的核心目标通常是交付新功能并尽可能加快交付速度。这种架构模式往往导致各种问题。

- The goal of DevOps is to make software delivery vastly more efficient.

>Nordstrom发现，应用DevOps实践后，其每月交付的功能数量增加了100%，缺陷减少了50%，交付周期缩短了60%，生产事故数量减少了60%到90%。
惠普LaserJet固件部门采用DevOps实践后，开发人员花在开发新功能上的时间从5%增加到了40%，并整体减少了40%的开发成本。
## ch1
>即使你是大型企业，也不应同时采纳所有DevOps实践。我职业生涯中最重要的教训之一就是，大多数大型软件项目都以失败告终。小型IT项目（低于100万美元）中约有四分之三能成功完成，而大型项目（超过1000万美元）中仅有十分之一能按时、按预算交付，甚至有超过三分之一的大型项目永远无法完工。
## ch5
>最重要的是理解这一点：当多个开发者同时在同一个代码库中工作时，合并冲突是不可避免的，所以问题不在于如何避免合并冲突，而是如何让这些合并冲突的处理尽可能轻松
### CI
CI的当前风范是让所有成员都在主分支上工作,每天进行多次合并以确保不会落后主分支太多.

使用Github Actions等工具确保每次提交都能通过测试,之后就可以进行pull request的合并,减少一点人工运行测试的麻烦.
### CD
CD主要的目标是在应用更新时不会导致网络震荡,应用停机等问题.

尽管话是这么说,安卓app不都是要退出应用再下载更新安装包的吗,至于网站的更新,崩溃的次数还少吗...
## 总结
该说是大道至简还是内有乾坤呢,DevOp的活儿看上去确实很简单,做好部署,监控,处理异常三件事就行了,但这需要对计算机领域的几乎所有知识都有一个比较全面的了解,这也是为什么SRE的地位相对较高的原因吧.

不过这本书讲的内容稀稀拉拉的,看头并不大.
# Kubernetes in Action, Second Edition
## 入门
### Introducing Kubernetes
>Kubernetes 一词源自希腊语，意为“领航员”或“舵手”,最初由Google开发.

Kubernetes 集群包含分为两个组的节点:
1. control plane nodes: 控制整个集群

![图示](PixPin_2026-07-09_17-26-06.webp)

2. worker nodes: 实际工作的节点.

![图示](PixPin_2026-07-09_17-27-13.webp)

### 容器介绍(过)
每个容器都有着独立的文件系统和进程ID,如果是有Shell的Linux镜像的话,还可以使用bash命令.

### 使用Kubernetes

# AI Agents in Action(待补充)

# Designing APIs with Swagger and OpenAPI
## Describing APIs
### Introducing APIs and OpenAPI
OpenAPI 是一种基于HTTP协议的API,采用Yaml或者Json形式来描述API的输入输出.

- Yaml是Json的完全超集,所以可以自由地在Yaml中使用Json的`{}`和`[]`语法,分别对应map和list的写法.

一开始我们使用Swagger UI来大致描述API的写法,后来越来越多的工具附着在Swagger UI上,最终被称为Swagger,由Linux基金会管理,更名为OpenAPI规范,而Swagger则用来称呼将OpenAPI文档转变成可视化网页的工具.
### 使用OpenAPI
**核心部件**
```yaml
/reviews:
  get:
    description: Gets a bunch of reviews.
    responses:
      200:
        description: A bunch of reviews
```
上述yaml包含了路由,请求方法和对请求方法的响应,一定的描述.

**加上请求参数**
```yaml
/reviews:
  get:
    description: Get a bunch of reviews.
    parameters:
      - name: maxRating
        description: Filter reviews by the maximum rating
        in: query # 参数的位置.
        schema:
          type: number
    responses:
      '200':
        description: A bunch of reviews
```

# Redis in action

# Powerful Python: Patterns and Strategies with Modern Python
# Architecting ASP.NET Core Applications&&# Mastering ASP.NET Core 10
- 两本书翻了好几章全都讲的很烂,确实不应该随便找别人没推荐过的书来看...

# Python3网络爬虫开发实战
## 爬虫基础
讲的还不错,基本涉及了爬虫所需的所有知识,尤其是关于session,cookie的地方讲的很好,帮我扫清了一点疑惑


## 数据的存储
## Ajax数据爬取
## 异步爬虫

