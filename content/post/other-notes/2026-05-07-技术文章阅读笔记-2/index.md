---
title: "技术文章阅读笔记-2"
date: 2026-05-07T18:21:52+08:00
description: 
image: 63754669_p0-夏。.webp
math: true

---

- (5/7): 本来想着把笔记全部写一起的,但太多了翻起来确实不方便,就先再开一栏,日后如果有好方法解决再说

# HTTP权威指南
不推荐阅读.

- 这本书于2002年出版,所以大多数概念可以直接跳过

本书分成以下五个部分:
- 第一部分 HTTP：Web 的基础
- 第二部分 HTTP 结构
- 第三部分 识别、认证与安全
- 第四部分 实体、编码和国际化
- 第五部分 内容发布与分发

## ch2: URL
一个URL由以下部分组成,其中方案(如`http:`,`ftp:`),主机(域名或者ip地址)和路径是必须的,其他的是可选项:

| 组件 | 描述                                                                                                                                                                          | 默认值         |
| ---- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| 方案 | 访问服务器以获取资源时要使用哪种协议                                                                                                                                          | 无             |
| 用户 | 某些方案访问资源时需要的用户名                                                                                                                                                | 匿名           |
| 密码 | 用户名后面可能包含的密码，中间由冒号 (:) 分隔                                                                                                                                 | <E-mail 地址 > |
| 主机 | 资源宿主服务器的主机名或点分 IP 地址                                                                                                                                          | 无             |
| 端口 | 资源宿主服务器正在监听的端口号。很多方案都有默认端口号（HTTP 的默认端口号为 80）                                                                                              | 每个方案特有   |
| 路径 | 服务器上资源的本地名，由一个斜杠 (/) 将其与前面的 URL 组件分隔开来。路径组件的语法是与服务器和方案有关的（本章稍后会讲到 URL 路径可以分为若干段，每段都可以有其特有的组件。） | 无             |
| 参数 | 某些方案会用这个组件来指定输入参数。参数为名 / 值对。URL 中可以包含多个参数字段，它们相互之间以及与路径的其余部分之间用分号 (;) 分隔                                          | 无             |
| 查询 | 某些方案会用这个组件传递参数以激活应用程序（比如数据库、公告板、搜索引擎以及其他因特网网关）。查询组件的内容没有通用格式。用字符 “?” 将其与 URL 的其余部分分隔开来            | 无             |
| 片段 | 一小片或一部分资源的名字。引用对象时，不会将 frag 字段传送给服务器；这个字段是在客户端内部使用的。通过字符 “#” 将其与 URL 的其余部分分隔开来                                  | 无             |

### 端口
我们平常使用http和https时都省略了端口,比如说`https://github.com/`实际上是`https://github.com/:443`,但浏览器会自动帮我们处理,如图所示:
![示意图](PixPin_2026-05-08_21-26-18.webp)

- 事实上访问`https://github.com/:443`也可以实现一样的效果,如果这么考量的话,我们看到`localhost:3000`等URL的时候就不会太迷糊
### 查询字符串
诸如下方这样的以`?`打头的查询参数非常常见,一般来说会用于搜索窗口上.
```text
http://www.joes-hardware.com/inventory-check.cgi?item=12731
```
### 片段
有时候我们会遇到以`#`打头的字符串,它表示该文档或者资源的一个片段,可以理解成某一章节或者某个特定图片:
```text
http://www.joes-hardware.com/tools.html#drills
```
## ch6: 代理
### 代理与网关的对比
代理连接的是多个使用相同协议的应用程序,而网关连接多个使用不同协议的断点,更像是协议转换器.
![示意图](PixPin_2026-05-11_10-23-03.webp)

## ch8: 网关
网关进行协议间的转换,如"ftp转http","https转http"

![示意图](PixPin_2026-05-11_17-30-35.webp)
## 总结
由于内容太老,讲的也不深入,所以收获很少.
# 微服务设计
不推荐阅读
## 微服务
### 补充: 什么是微服务
- 这本书说了很多,但还是没说清楚
- [wiki](https://en.wikipedia.org/wiki/Microservices)

>In software engineering, a **microservice** architecture is an architectural pattern that organizes an application into a collection of loosely coupled, fine-grained services that communicate through lightweight protocols.

在具有不同功能的代码之间划清界限,将代码库分割到一个足够小的程度(有多小则看个人的考量),通过API和网络通信相互连接,每一部分都可以独立地运行,这就是**微服务**,每一部分的独立代码被称为**服务**(service).

- 也就是说微服务相当于是对**良好架构设计**的一个狂霸酷炫拽的称呼.
### 微服务的好处
1. 可以轻松的**升级/替换**某一个服务而不影响其他的服务
2. 可以轻松的扩展服务,而不需要重构整个项目
3. 由于各个服务的部署是独立的,在出问题时可以专精于出错的特定服务,容易定位和筛查

## 演化式架构师
架构师并不是建筑师,互联网行业也不是建筑行业,鉴于软件开发的多变性,我们需要灵活调整软件的架构.

>架构师应该专注在大方向上,在有限的情况下才会参与到具体的细节实现上.

## 部署
- 持续集成(Continuous Integration): 将新提交的代码与原代码进行集成,从而让所有人保持同步
- 持续交付(Continuous Delivery): 检查每次提交是否达到了部署到生产环境的要求

## 总结
前几章看看就可以了,收获并不大,不如直接看维基百科还来的快一些.
# Understanding The Linux Kernel(深入理解Linux内核)
不推荐阅读

![示意图](PixPin_2026-05-17_09-22-15.webp)
- 总结的太到位了,这本书确实写的很烂.
## 绪论
本书描述的是Linux2.6.11版的内核,而现在的Linux内核版本号都到7.1了,甚至还有不少代码是由rust写的:

![示意图](PixPin_2026-05-11_23-19-18.webp)
### 操作系统基本概念
任何计算机系统都包含一个名为**操作系统**的基本程序集合,在这个集合里,最重要的程序称为**内核**(kernel).当操作系统启动时,内核被映射到内存中运行,是其他程序运行的基底


操作系统需要完成两个目标:
1. 与硬件部分交互
2. 为用户程序提供执行环境

某些系统如MS-DOS允许用户程序与硬件部分交互,但类Unix操作系统如Linux,MaCOS等将硬件部分隐藏起来,需要程序向操作系统发出请求才能通过内核与硬件部分交互.
### 用户与组
在多用户系统(支持多个用户使用)的系统中,每个用户在机器上都有自己专用的私有空间,所有用户由一个唯一的数字来标识,叫做用户标识符(User ID,UID),用户通过ID和口令来登录自己的账号.

类Unix操作系统都有一个特殊的用户,叫做**root**,即超级用户(superuser),他可以访问系统中的所有文件并干涉所有的用户程序.

### Unix文件系统
Unix文件被组织在一个树结构的命名空间中:
![示意图](image.png)

- 与树根对应的目录被称为根目录(root directory),名字是"/".

Unix的每个进程都有一个当前的工作目录,我们通过相对路径或者绝对路径来标识目录文件的位置.

- `.`和`..`分别标识当前工作目录和父目录.

## 内存寻址
### 地址
80x86微处理器架构下,存在以下三种地址:
1. 逻辑地址(logical address): 由一个段和偏移量组成,指定一个操作数或者一条指令的地址.
2. 虚拟地址(也称线性地址): 将指令映射到虚拟空间时的地址,在32位Linux系统中可寻址的空间为4GB
3. 物理地址: 虚拟地址实际映射的内存地址

#### 逻辑地址
具体来说,一个逻辑地址实际上是由16位长的段选择符和32位长的偏移量组成的.

处理器中提供了6个段寄存器用来存放**段选择符**:
1. cs: 代码段寄存器
   - 含有一个两位的字段,用于指明CPU的当前级别,0级为最高优先级,3级为最低优先级,Linux只用0和3级,称为内核态与用户态.
2. ss: 栈段寄存器
3. ds: 数据段寄存器
4. es,fs,gs: 通用型寄存器,可以指向任意的数据段.

### Cache
由于从内存(DRAM)中读取指令还是太慢了,我们设计了cache(高速缓存),它基于局部性原理设计: 最近最常用的相邻地址在将来又被用到的可能性极大.

80x86体系引入了一个叫做行(**line**)的单位,它由几十个连续的字节组成.cache就由多个行组成.

>Cache 单元位于分页单元与主内存之间。它由硬件 Cache 存储器（Hardware Cache Memory）和 Cache 控制器（Cache Controller）组成。Cache 存储器负责存放内存数据行。Cache 控制器则维护一个入口数组,每个入口对应的是Cache 存储器中的一行.

>Each entry includes a tag and
a few flags that describe the status of the cache line. The tag consists of some bits
that allow the cache controller to recognize the memory location currently mapped
by the line. The bits of the **memory’s physical address** are usually split into **three groups**: the most significant ones correspond to the tag, the middle ones to the cache controller subset index, and the least significant ones to the offset within the line.

>When accessing a RAM memory cell, the CPU extracts the subset index from the
physical address and compares the tags of all lines in the subset with the high-order
bits of the physical address. If a line with the same tag as the high-order bits of the
address is found, the CPU has a **cache hit**; otherwise, it has a **cache miss**.

- 也就是说缓存是否命中只需比对缓存控制器中的标签是否与RAM中的高位物理地址对应即可,还是很快的.

## 进程
- **进程**: 程序执行时的一个实例,进程之间有共享的程序代码,但每个进程都有独立的数据存储空间
- **线程**: 一个进程可以由一个或者多个线程组成
- **轻量级进程**: 轻量级进程间可以共享资源,一个轻量级进程对应一个线程.

### 进程描述符
进程描述符(process descriptor)存放了一个进程所有信息的结构体,它的主要结构如下:
![示意图](image-1.png)

#### 进程的状态
进程可能处于以下状态中,状态之间是互斥的:
1. 可运行状态: 进程要么正在执行,要么准备执行
2. 中断状态: 进程被挂起,等待所需的信号或者资源,由进程主动执行.
3. 不可中断的等待状态: 进程被挂起,无法被信号唤醒,直到某个必要进程执行完毕
   - 例如Windows突然死机,用户无法执行任何操作
4. 暂停状态: 进程接收到信号后被强制暂停运行,进程是被动暂停的,这也是与2的不同点所在.
5. 跟踪状态: 当一个进程被另一个进程（通常是调试器如 GDB）监控时，它会进入 TASK_TRACED 状态。此时，被跟踪进程的执行权被完全移交给跟踪者。
6. 僵尸状态: 进程执行完毕后,父进程尚未开始处理关于该子进程的终止信息
7. 复活状态: 父进程开始处理子进程的终止信息

#### 进程的标识
类Unix操作系统中都有一个叫做进程标识符(**process ID**,PID)的数来标识进程,它同样位于进程描述符中.

- 同一个进程的多个线程使用相同的PID

#### 进程的组织
Linux使用双向链表来存储进程队列,并根据PID的不同将不同类型的PID分成了4个hash表:
![示意图](PixPin_2026-05-14_09-32-43.webp)

当需要分配新进程时,会根据进程的PID字段进行hash映射到对应的空间中.

运行和等待状态的进程是最重要的,Linux内核为这两种进程设定了专门的队列用于调度进程.
- 运行队列: 将可运行状态的进程用链表组织在一起
- 等待队列: 将等待状态的进程用链表组织在一起

### 创建进程
传统的Unix操作系统使用唯一一种方式创建所有的进程: 子进程复制父进程所有的资源,这种方法的效率相当低下,现代Unix内核使用以下三种机制来优化进程创建:
1. 写时复制: 允许父进程和子进程读取相同的存储空间
2. 轻量级进程: 通过`clone()函数`创建,父子进程间共享各类数据
3. vfork()系统调用: 使用vfork()函数创建的进程可以与父进程共享相同的内存地址空间.

>看着迷糊吗,但这并非翻译的锅,原文同样也很迷糊,很好奇这本书为什么这么有名
## 中断和异常
- 中断: 由I/O设备,硬件设备发出
- 异常: 由CPU发出,有三种类型的异常
  - 故障(fault): 通常可以被纠正,之后会重新执行引起故障的指令
  - 陷阱(trap): 一般用于调试,之后不再执行故障指令,而是执行下一条指令
  - 中止(abort): 发生了严重错误,需要专门处理

## 总结
及时止损,看不下去了,显然作者沉浸在自己的代码分析世界里了,完全没能从一个更高的维度来对Linux的运作机制做一个概括
# GAME ENGINE ARCHITECTURE
- 内容太老了,而且很多概念都是宽泛的讲一下就结束了,没有深入.不推荐阅读.
## 导论
### 典型游戏团队的结构
- **工程师**: 设计引擎,制作游戏
- **艺术家**: 有很多分类
  - 概念艺术家: 制作整个游戏的蓝图
  - 三维建模师: 制作物体,角色,地形,建筑物
  - 灯光师: 布置光源,调整场景的美感
  - 动画师: 为角色,物体设计动作
  - 音效设计师
  - 作曲家
  - 配音演员
- **游戏设计师**: 有的在宏观上设定故事主线,整体的章节安排,有的在具体关卡中设定角色/道具的位置,设计游戏谜题和战斗场景
- **制作人**: 管理开发进度,联系其他公司.
- **发行商**: 负责游戏的市场策划,制造和分销.有些游戏工作室隶属于某些发行商,但也有很多独立工作室,他们会将游戏委托给条件最好的发行商.有时候还需要给跨越国际的游戏设置代理商.
### 游戏类型概览
#### 第一人称射击游戏(FPS)
该类游戏的开发难度很高,需要能够实现以下功能:
* 高效地渲染大型三维虚拟世界。
* 快速反应的摄像机控制及瞄准机制。
* 玩家的虚拟手臂和武器的逼真动画。
* 各式各样的手持武器。
* 宽容的玩家角色运动及碰撞模型，通常使游戏有种“漂浮”的感觉。
* 非玩家角色（NPC，如玩家的敌人及同盟）有逼真的动画及智能。
* 小规模在线多人游戏的能力（通常支持多至同时 64 位玩家在线），以及无处不在的死亡竞赛（death match）游戏模式。
#### 第三人称游戏
第三人称游戏的种类比较多,比如森林冰火人这种平台游戏,比如生化危机这种第三人称动作游戏,一般需要以下技术:
* 移动平台、梯子、绳子、棚架及其他有趣的运动模式。
* 用来解谜的环境元素。
* 第三人称的“跟踪摄像机”会一直注视玩家角色，也通常会让玩家用手柄右摇杆（在游戏主机上）或鼠标（在 PC 上）旋转摄像机（虽然在 PC 上有很多流行的第三人称射击游戏，但平台游戏类型几乎是游戏主机上独有的）。
* 复杂的摄像机碰撞系统，以保证视点不会穿过背景几何物体或动态的前景物体。

#### 其他类型
- 格斗游戏: 拳皇
- 竞速游戏: 卡丁车
- 实时策略游戏(real-time strategy,RTS): 魔兽称霸,星际争霸
- 大型多人在线游戏(massively multiplayer online game,MMO): 魔兽世界
- 体育游戏: 足球经理
- 角色扮演游戏(role playing game,RPG)

![示意图](PixPin_2026-05-15_11-27-50.webp)
### 游戏开发全貌
![示意图](image-6.png)
## 游戏支持系统
### 子系统的启动和终止
>游戏引擎由多个互相合作的子系统结合组成,当引擎启动/终止时,需要按照一定的顺序启动/终止子系统.

如果使用C++原生的构造函数和析构函数,尽管同一文件中的构造/析构顺序是一定的,但不同文件中的构造/析构顺序是未知的,那么这就会导致子系统的构造/析构顺序发生紊乱,导致程序崩溃.

书中提出的解决方法是:不使用原生的构造函数和析构函数,改成自定义的启动管理器函数和终止管理器函数,在调用某个子系统时,直接调用其启动函数,并在终止子系统时,调用终止函数.如此一来,就可以避免原生语法带来的混乱.
### 内存管理
由于new/malloc操作符需要操作系统从用户模式切换至内核模式来进行堆分配,存在一个**上下文切换**的时间开销,一旦这类动态内存分配多了,就会极大的影响游戏的运行速度.c++类游戏引擎为了解决这个问题,通常会定制分配器来是实现内存分配

## 总结
不推荐阅读...
# Multiplayer Game Programming
- 不推荐阅读
## OVERVIEW OF NETWORKED GAMES
- 简单讲了讲联网游戏的历史,可以直接略过不看.

## BERKELEY SOCKETS
### Sockets概览
>Originally released as part of BSD 4.2, the **Berkeley Sockets API** provides a standardized way
for processes to interface with various levels of the TCP/IP stack. Since its release, the API has
been ported to **every major operating system and most popular programming languages**, so it
is the veritable standard in network programming.

- 换句话说socket其实是Berkey研究组对网络协议和硬件交互的封装API,并在之后普及到了所有的主流操作系统和编程语言中.

创建一个socket对象可以这么写:
```cpp
SOCKET socket(int af,int type,int protocol);
```
1. af: address family,表示socket底层使用的是什么网络层协议,最常用的两个值是`AF_INET`:IPV4和`AF_INET6`:IPV6.
2. type: 表示通过socket传输的包的类型,最常用的有`SOCK_STREAM`,表示 `Packets represent segments of an ordered, reliable stream of data`,对应的传输层协议为TCP;另一个常用的是`SOCK_DGRAM`,表示`Packets represent discrete datagrams`,对应的传输层协议为UDP
3. protocol: 表示使用的具体传输层协议,常用值如下:

| Macro              | Required Type | Meaning                                     |
| ------------------ | ------------- | ------------------------------------------- |
| `IPPROTO_UDP`      | `SOCK_DGRAM`  | Packets wrap UDP datagrams                  |
| `IPPROTO_TCP`      | `SOCK_STREAM` | Packets wrap TCP segments                   |
| `IPPROTO_IP` / `0` | Any           | Use the default protocol for the given type |

- 如果protocl填0就表示选择type字段对应的传输层协议

4. To close a socket, regardless of type, use the closesocket function:
```cpp
int closesocket( SOCKET sock );
```
5. To cease transmitting or receiving before closing, use the shutdown function:
```cpp
int shutdown(SOCKET sock, int how)
```
## ch4&&ch5&&ch6
- 这几章书上讲的很烂,沉浸在自己的代码里了,但这部分的内容却是这本书的核心,我只好重新自己梳理一下

我们需要考虑一个问题,游戏联机与普通的网站开发不同,网站开发可以在前后端内传递json文件,将数据有组织的接收和传送,并存放在数据库中;

但是游戏联机要求我们玩家能够与服务器间进行低延迟通信,而且需要实际地更改玩家的游戏数据,有一个非常严重的问题就是,尽管玩家的账户数据是可以用数据库存储的,但游戏中的实时数据(比如玩家的位置,剩余血量等)是不能存放在数据库中的,这些实时数据彼此之间以指针相互引用,很有可能在不同玩家的主机上使用不同的内存地址:
![表格](PixPin_2026-05-23_13-35-02.webp)

因此,我们不能简单的把在玩家的本地数据映射到服务器数据上,实际的解决方法有两种:
- 状态同步 (State Synchronization)： 服务端计算所有游戏逻辑、碰撞和数值，将结果（如怪物坐标、玩家血量）广播给客户端。客户端只负责渲染。防作弊能力强，适合 MMORPG。
- 帧同步 (Lockstep / Frame Sync)： 服务端只负责收集转发玩家的操作输入（如：按了向左键），不计算逻辑。各个客户端在相同的帧执行相同的输入，计算出相同的结果。对网络延迟要求极高，流量小，适合 MOBA、格斗、局域网联机。

但谁来作为服务器呢?我们有两种解决方案:
1. Client-Server (C/S)：必须有一个中心节点（服务器）。所有客户端都只和服务器连，客户端之间不直接通信。
2. Peer-to-Peer (P2P)：没有固定的中心服务器，或者服务器只负责牵线。每个客户端（玩家）同时也是服务器，客户端之间直接互发数据。

### 不同的通信方案

#### 帧同步 ＋ P2P（早期经典）

* **代表作**：《魔兽争霸 3》、《星际争霸》、早期的局域网格斗游戏。
* **机制**：玩家 A 按了下技能，直接通过网络把“A 释放技能”的指令发给玩家 B，玩家 B 也把自己的操作发给 A。没有中央服务器算逻辑，大家各算各的。

#### 帧同步 ＋ C/S（现代主流）

* **代表作**：《王者荣耀》、《乱斗西游》。
* **机制**：玩家 A 按了向左走，这个输入先发给**中央服务器**。服务器收集齐这一帧所有玩家的输入后，打包成一个“帧包”，统一广播给所有玩家。客户端收到服务器的统一帧包后才开始执行。这样操作是为了解决 P2P 架构下某一个玩家断线导致全员卡死（Lockstep 严格同步）的问题。

#### 状态同步 ＋ C/S（绝对统治）

* **代表作**：《魔兽世界》、《反恐精英 (CS)》、《PUBG》。
* **机制**：这是最标准的组合。服务器在云端运行完整的游戏世界，算好一切，再把状态压进网络包发给客户端。客户端如果作弊改了本地坐标，服务器下一次状态刷新会直接强制把你拉回原位。

#### 状态同步 ＋ P2P（极少见/主机常用）

* **代表作**：<< 幻兽帕鲁 >> 。
* **机制**：为了省服务器成本，不架设中央高性能服务器。由系统自动选出一个玩家的电脑作为“主机（Host）”，它承担状态同步中“服务器”的角色，负责计算逻辑并广播给其他 P2P 连接的玩家。缺点是一旦该玩家退出，游戏就必须中断并“迁移主机”。

## 总结
不推荐阅读,前面两三章还可以,后面完全变成毫无意义的代码分析了.

## OBJECT REPLICATION

# 深度学习论文学习
## 前置概念
- 论文大致按照年份排序,有一个先后关系
- 学习前提: 阅读过<< Deep Learning From Scratch>>即可,然后就可以大致跟着时间线走,如果忽略前人的研究成果直接跳到最新模型的话,那绝对是看不懂的.

首先,深度学习领域的主要框架类型有如下几个:
1. CNN(卷积神经网络): 通过卷积层来实现高维的图像/3D输入,适用于处理图像.
   1. 代表框架有LeNet,ResNet等.
   2. [wiki](https://en.wikipedia.org/wiki/Convolutional_neural_network)
2. RNN(循环神经网络): 适用于处理具有时间先后顺序的数据,例如音频
   1. 代表框架有LSTM,GRU等
   2. [wiki](https://en.wikipedia.org/wiki/Recurrent_neural_network)
3. Transformer: 适用于处理文本,代码,多模态信号
   1. 代表框架有GPT,Llama,BERT等
4. GNN(图神经网络): 适用于处理社交网络等网络数据
   1. 代表框架有GCN,GAT等


然后,我们需要大致明白一条主要的时间线:
1. 1986年<< Learning representations by back-propagating errors >>将反向传播算法引入了神经网络
2. 1989年<< Backpropagation applied to handwritten zip code recognition >>是第一篇真正将反向传播算法实际应用到学习过程中的论文,也是CNN的原型论文
3. 1990年<< Finding Structure in Time >>是RNN的原型论文.
4. 1997年<< Long Short-Term Memory >>提出了LSTM框架
5. 2015年<< Deep Residual Learning for Image Recognition >>提出了深度残差网络
6. 2017年<< Attention Is All You Need >>提出了Transformer框架.
7. 2018年<< Improving Language Understanding
by Generative Pre-Training >>提出了基于Transformer的GPT框架
1. 2023年<< LLaMA: Open and Efficient Foundation Language Models >>提出了基于Transformer的LLaMA框架.


- 这些主要论文中间穿插着许多奠基者的研究成果,我也会适当地学习这些论文.
- 由于我只是一个业余爱好者,只想准确的了解现代大模型背后的原理,所以只会挑选最经典或者最优秀的论文来大致学习一下.
- (5/22): 早期论文大多会深入底层的原理,讲的特别深入和透彻,能够洋洋洒洒写三四十页;而越是新的论文,就越是含混不清,潦草的介绍了公式和框架就结束了,总共十几页中能有四五页真东西就不错了.这固然有版面限制的原因在,但我想还是因为风气出了问题.

### 卷积神经网络是如何实现反向传播计算的
一般神经网络的反向传播计算很好理解,我们只需要对某一位置的参数求偏导就行了,但卷积神经网络多了一个卷积层和池化层,这显然没有那么好处理.

- [一个比较好的说明](https://zhuanlan.zhihu.com/p/61898234)
  - 由于讲的挺好的,我就不讲了...

## Learning representations by back-propagating errors(1986)

![介绍](PixPin_2026-05-14_17-04-17.webp)

如标题所说,这篇论文将反向传播算法引入了多层神经网络的学习,堪称深度学习领域的祖师爷,不过由于内容很简单,就没有深入看的必要了,真的就只讲了一个反向传播算法而已.

## Serial Order: A Parallel Distributed Processing Approach(1986)
>该论文是<< Finding Structure in Time >>这篇论文的灵感来源,很有必要阅读.

![首页](PixPin_2026-05-21_22-28-23.webp)
![目录](PixPin_2026-05-21_22-29-23.webp)
- 还是有点长的...
### 总结
>总体来看,这篇论文花了大量的篇幅介绍前人的研究成果和技术的底层原理,但整体的架构是非常简单的,一张图就可以表示:
![示意图](PixPin_2026-05-22_12-12-57.webp)

---
AI总结

传统的并行分布式处理（PDP，即早期的神经网络）擅长处理静态的空间模式输入输出，但无法解决**序列行为（Serial Order）**。人类在说话、打字、走路时，动作是有先后顺序的，且当前的动作高度依赖于之前的状态。Jordan 探讨的是：一个没有内部时钟的并行网络，如何按顺序产出一系列有特定先后关系、有时间跨度的动作。

Jordan 提出了一种通过外部反馈（External Feedback）引入时间维度的方法。

```
 [计划层 Plan Layer] (保持不变，代表当前任务目标)
        │
        ▼
 [隐藏层 Hidden Layer] ◄───┐
        │                 │
        ▼                 │
 [输出层 Output Layer] ───┐ │ (即时反馈：100% 当前输出)
        │                 │ │
        ▼                 │ │
 [状态层 State Layer] ────┼─┘ 
   (循环自反馈：μ * 上一次状态 + 当前输出)

```

网络由四层结构组成：

1. **计划层 (Plan Layer)**：输入端。在整个序列输出期间，计划层的激活状态保持**恒定**。它代表整体意图（例如“单词 X”或“动作序列 A”）。
2. **隐藏层 (Hidden Layer)**：进行非线性特征组合。
3. **输出层 (Output Layer)**：产生当前时间步的实际动作或特征。
4. **状态层 (State Layer / Context Layer)**：这是该架构的核心创新。
* 状态层接收两个来源的输入：一个是**输出层当前的直接反馈**，另一个是**状态层自身的自连接循环反馈**。
* 数学物理机制：状态层单元具有持续性，其更新公式为：

$$x_{state}(t+1) = \mu \cdot x_{state}(t) + x_{output}(t)$$


其中 $\mu$ 介于 0 到 1 之间（衰减因子）。这意味着状态层对过去所有输出进行了加权指数衰减式的累积，形成了对“过去行为轨迹”的记忆。


## Backpropagation Applied to Handwritten Zip Code Recognition(1989)
- [一个很不错的复现仓库](https://github.com/karpathy/lecun1989-repro)

![介绍](PixPin_2026-05-20_19-49-10.webp)
### 概览与总结
>这篇论文将反向传播算法用来训练一个可以识别从邮件中获取的手写数字的卷积神经网络,是第一次将反向传播用在实际工程中的论文,也证明了神经网络相比其他算法的优越性.

![预处理](PixPin_2026-05-20_20-03-08.webp)

首先,研究者将40到60像素的手写数字图片通过线性映射处理成16x16像素的图片,尽可能的保留了原图像的灰度特征:
![映射处理](PixPin_2026-05-20_20-10-20.webp)

然后通过卷积神经网络和反向传播计算,我们会得到10个数字的概率输出:
![示意图](PixPin_2026-05-20_20-12-52.webp)

- 如果你阅读过<< Deep Learning From Scratch>>的话,就会发现这正是这本书前几章所用的例子,换句话说,作者把这篇论文用简单的语言和代码又翻译了一遍而已.

大概的训练方法:
1. 所有的连接权重（Weights）和偏置（Biases）全部使用均匀分布（Uniform Distribution）进行随机初始化,随机范围严格控制在 $[-\frac{2.4}{F_i}, \frac{2.4}{F_i}]$ 之间
2. 使用MSE(均方误差)来计算误差
3. 使用小批量的SGD算法进行反向传播计算
4. 总训练次数为23轮

>全文的内容大致就是这样,在今天看来是平平无奇的,在当时来看的话那可真的是天纵英才的设计啊.

## Finding Structure in Time(1990)

![首页](PixPin_2026-05-21_22-07-03.webp)
### 引言
具有时间顺序的数据(后简称时序数据)在实际生产中很常见,但以往的模型最常用的方法是,将不同时间的数据拆分到一个序列中输入,也就是以空间换时间,但作者提出,我们不应该把时间看作一个额外的输入维度,而应该在加工数据时就把时间考虑进去.

该论文接下来分为几个部分:
1. 介绍用空间换时间带来的问题(略过不看,因为全是作者的主观论述,没有一点点实际数据的支撑,这在顶刊论文中还是很少见的)
2. 研究方法
3. 实验结果

### 研究方法
作者提出,要能够处理时序数据,最好的解决方法是让模型具有记忆能力.在Jordan(1986)论文的基础上,他设计了这样一个模型:

![模型图](PixPin_2026-05-22_12-15-04.webp)

- 如果看过Jordan论文的话就会知道,Elman只是把状态层改成与隐藏层绑定,而非和输出层绑定,这就是唯一的区别,但这样一来,我们就可以让训练参数与输出结果解耦,实现更好的训练效果.

在之后就没有什么内容了,基本都是实验和不痛不痒的论述,重点在于说明这种架构为什么可以适配时序数据,因为相邻的输入确实比距离遥远的输入权重关系更近:

![示意图](PixPin_2026-05-22_12-53-03.webp)


## LONG SHORT-TERM MEMORY(1997)
- 机器学习领域划时代的论文不多,但这篇论文可以算上.
![示意图](PixPin_2026-05-20_18-40-08.webp)

### 总结
尽管这篇论文很经典,但论述实在太专业了,而且理论公式让人看着头疼:
![示意图](PixPin_2026-05-20_18-48-31.webp)


简单来说就是,LSTM将RNN中的隐藏层单元替换成了LSTM单元(Cell);
![示意图](PixPin_2026-05-20_18-58-17.webp)

这个单元可以进行循环计算,能够将不同时刻的数据联系起来:
![示意图](PixPin_2026-05-20_19-30-50.webp)

这种架构能够大大加速训练过程,并减少时间间隔过长引发的信息丢失.

>在Transformer诞生之前,LSTM是主流的NLP框架,尽管它能够处理更长的时间步长,但在面对大量的数据时仍然无能无力,所以现在的大模型都不会使用它了.
## A Neural Probabilistic Language Model(2003)
- 这篇论文引入了embedding的概念,是后续NLP模型的必要组成部分.

![首页](PixPin_2026-05-23_16-18-30.webp)
### 引入
>NLP的一大难点在于输入的词向量可能有各种各样的维度,与训练数据完全不同,该论文提出,可以通过训练让模型学会比训练数据多上指数级别的语义相近的实际数据.具体来说就是模型同时学习离散的单词和完整的句子,当出现与训练数据结构类似的句子时也可以很好的做出应对.

- 我已经尽力翻译了,但原文确实太难看懂了,不像是摘要,还是接着看具体实现吧.





## Learning Phrase Representations using RNN Encoder–Decoder for Statistical Machine Translation(2014)

![首页](PixPin_2026-05-22_12-55-39.webp)
- 尽管这篇论文比2017年那篇早,但它也不是首先提出编码器-解码器架构的,而是参考了前人的研究成果,但继续追根溯源也没必要.
### 引入
>该论文提出了用两个循环神经网络(RNN)组成的编码器-解码器架构,编码器将输入数据处理成固定长度的向量,解码器将向量处理成输出数据.

![架构解释图](PixPin_2026-05-23_15-56-53.webp)
### 架构解释
该模型的RNN中的隐藏层单元是一个LSTM单元的简化版本:
![结构图](PixPin_2026-05-23_16-01-37.webp)


完整的流程如下:
1. 编码器不断读取输入,将其处理成固定长度的向量
2. 解码器根据向量逐个输出预测值,最大化下一个词的条件概率,每个预测值都与之前的所有输入相关:

$$P(y_t \mid y_1, ..., y_{t-1}, c)$$



## Sequence to Sequence Learning with Neural Networks(2014)

## ADAM: A METHOD FOR STOCHASTIC OPTIMIZATION(2015)
![示意图](PixPin_2026-05-08_17-07-53.webp)
- 这篇2015年的论文提出了一种新的神经网络学习方法:ADAM,是两年后推出的Transformer模型的核心算法,还是很有必要了解的
- (2026/4): 第一次读论文,也不知道怎么读,总不至于全部复制过来再逐个翻译吧,想了想还是读完全文后做一点要点总结算了.

### 引入
>在机器学习中,常见的优化算法都属于一阶方法**first-order methods**,即只使用目标函数(例如损失函数)的一阶导数(例如梯度)来更新参数.其中,随机梯度下降法**stochastic gradient descent (SGD)**是最著名也是非常有效的学习方法.

本文提出的Adam算法同样也是一个随机最优化(**stochastic optimization**)的一阶算法,它的名字来源于`adaptive moment estimation`.

该算法借鉴了两个优秀算法的长处:
1. AdaGrad,于2011年提出,可以很好地处理稀疏梯度(即梯度向量中绝大多数元素为0的情况)
2. RMSProp,于2012年提出,能够很好地处理小批量训练?(on-line)和非平稳环境(not-stationary).
### 算法实现
### 伪代码
$$\begin{array}{l}
\hline \mathbf{Algorithm\ 1:} \text{ Adam, our proposed algorithm for stochastic optimization. See section 2 for details,} \\
\text{and for a slightly more efficient (but less clear) order of computation. } g_{t}^{2} \text{ indicates the elementwise} \\
\text{square } g_{t} \odot g_{t} \text{. Good default settings for the tested machine learning problems are } \alpha=0.001, \\
\beta_{1}=0.9, \beta_{2}=0.999 \text{ and } \epsilon=10^{-8} \text{. All operations on vectors are element-wise. With } \beta_{1}^{t} \text{ and } \beta_{2}^{t} \\
\text{we denote } \beta_{1} \text{ and } \beta_{2} \text{ to the power } t . \\
\hline \mathbf{Require:} \alpha: \text{Stepsize} \\
\mathbf{Require:} \beta_{1}, \beta_{2} \in[0,1): \text{Exponential decay rates for the moment estimates} \\
\mathbf{Require:} f(\theta): \text{Stochastic objective function with parameters } \theta \\
\mathbf{Require:} \theta_{0}: \text{Initial parameter vector} \\
\quad m_{0} \leftarrow 0 \text{ (Initialize } 1^{\text {st }} \text{ moment vector)} \\
\quad v_{0} \leftarrow 0 \text{ (Initialize } 2^{\text {nd }} \text{ moment vector)} \\
\quad t \leftarrow 0 \text{ (Initialize timestep)} \\
\quad \mathbf{while} \ \theta_{t} \text{ not converged } \mathbf{do} \\
\quad\quad t \leftarrow t+1 \\
\quad\quad g_{t} \leftarrow \nabla_{\theta} f_{t}\left(\theta_{t-1}\right) \text{ (Get gradients w.r.t. stochastic objective at timestep } t) \\
\quad\quad m_{t} \leftarrow \beta_{1} \cdot m_{t-1}+\left(1-\beta_{1}\right) \cdot g_{t} \text{ (Update biased first moment estimate)} \\
\quad\quad v_{t} \leftarrow \beta_{2} \cdot v_{t-1}+\left(1-\beta_{2}\right) \cdot g_{t}^{2} \text{ (Update biased second raw moment estimate)} \\
\quad\quad \widehat{m}_{t} \leftarrow m_{t} /\left(1-\beta_{1}^{t}\right) \text{ (Compute bias-corrected first moment estimate)} \\
\quad\quad \widehat{v}_{t} \leftarrow v_{t} /\left(1-\beta_{2}^{t}\right) \text{ (Compute bias-corrected second raw moment estimate)} \\
\quad\quad \theta_{t} \leftarrow \theta_{t-1}-\alpha \cdot \widehat{m}_{t} /\left(\sqrt{\widehat{v}_{t}}+\epsilon\right) \text{ (Update parameters)} \\
\quad \mathbf{end\ while} \\
\quad \mathbf{return} \ \theta_{t} \text{ (Resulting parameters)} \\
\hline
\end{array}$$

有几个专业名词不太好懂:
1. first moment: 一阶矩,即梯度的期望(均值)
2. second raw moment: 二阶原始矩,不对数据减去均值直接求平方期望,若减去均值在求平方期望,则称为中心矩(即方差)
3. `exponential decay rates`: 指数衰减率,衰减率越大参数更新越慢,之所以叫指数是因为某一时刻的值是先前所有历史值的加权和:
   - $$V_t = (1-\beta)(g_t + \beta g_{t-1} + \beta^2 g_{t-2} + \beta^3 g_{t-3} + \dots)$$


- 大概这种论文都有一个伪代码来简单的解释自己算法的整个流程吧,乍一看有点懵,实际上确实比看文字更好懂一点
### 具体原理
>The stochasticity might come from the evaluation at random subsamples (minibatches)
of datapoints, or arise from inherent function noise.

- 之所以说这个算法是随机的,是因为它的数据可能是一个随机的小批量抽取,或者说数据本身存在噪音

> However, these moving averages are
initialized as (vectors of) 0’s, leading to moment estimates that are biased towards zero, especially
during the initial timesteps, and especially when the decay rates are small (i.e. the βs are close to 1).

- 由于m和v的初始值被置为0,所以在函数刚起步的时候,特别是当衰减率也很低(β接近1)时,会导致矩估计(均值)偏向0,导致学习失败.

>因此,我们需要用一点技巧来克服这个问题,这会在下一章被解决.

- 看了一个小时,明天再来,看论文确实很累
### 误差修正
![示意图](PixPin_2026-05-10_20-09-14.webp)
通过一个简单的等比数列求和,我们发现某一时刻的梯度被缩小到了真实值的$(1 - \beta_2^t)$ 倍,所以在伪代码中我们会在计算出两个参数后对其进行误差修正.

### 4个实验
选取的实验都是非常经典的模型,而不是像某些垃圾论文一样用一些奇怪的数据集在奇怪的模型上训练.

- training cost: 指的就是损失函数值
#### LOGISTICR EGRESSION
![示意图](PixPin_2026-05-10_20-19-56.webp)
#### MULTI-LAYER NEURAL NETWORKS

![示意图](PixPin_2026-05-10_20-22-13.webp)
#### CONVOLUTIONAL NEURAL NETWORKS
![示意图](PixPin_2026-05-10_20-25-26.webp)
#### BIAS-CORRECTION TERM
![示意图](PixPin_2026-05-10_20-25-51.webp)

基本都是全方位打压以前的反向传播算法
### 结论
- 有个扩展的AdaMax算法被我忽略掉了
- 附录也被我省略了,数学不好的人是看不得这种东西的
  - ![示意图](PixPin_2026-05-10_20-28-55.webp)

>The method combines the advantages of
two recently popular optimization methods: the ability of AdaGrad to deal with sparse gradients,
and the ability of RMSProp to deal with non-stationary objectives. 
>
>The method is straightforward
to implement and requires little memory. 

>The experiments confirm the analysis on the rate of convergence in **convex problems**.
>
>Overall, we found Adam to be **robust and well-suited to a wide range of non-convex optimization problems** in the field machine learning.

第一篇论文看下来的感受还是挺好的,既没有什么宏大叙事,也没有多少弯弯绕绕,很清楚的把一个算法的前前后后都讲清楚了,非常推荐阅读.
## Deep Residual Learning for Image Recognition(2015)
## Identity Mappings in Deep Residual Networks(2016)
## Attention Is All You Need(2017)(待补充)
![示意图](PixPin_2026-05-10_20-31-11.webp)
- 划时代的论文,划时代的杰作,划时代的人才
- transformer是基于大量前人的研究工作实现的,需要预先懂得很多知识后再来看比较好.
### 引言和背景介绍
- 相比ADMA论文,这一篇的摘要不够清晰,引入也很啰嗦...

>To the best of our knowledge, however, the Transformer is the first transduction model relying
entirely on self-attention to compute representations of its input and output without using sequence-
aligned RNNs or convolution. 

原来编码器-解码器模型在几年前的论文中就提出来了,注意力机制也不是这篇论文的原创,但是Transformer将先前的论文成果结合在一起,提出**完全依靠自注意力机制来计算输入输出结果,而不使用循环神经网络或者卷积**,从而解决了长距离信息丢失的问题.
### 模型架构
> At each step the model is auto-regressive
[10], consuming the previously generated symbols as additional input when generating the next.

![示意图](PixPin_2026-05-11_13-07-49.webp)

#### 编码器和解码器架构
**编码器(Encoder)**由6个完全相同的层并行组成,每个层都有两个子层:
1. 多头子注意力层,后面会详细解释
2. **position-wise fully connected feed-forward network**(前馈全连接层)

在每个子层后,都有一个正规化层
### 
## Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks(2021)
- 在Agent构建中被广泛应用的RAG概念就是这篇2021年的论文提出的
![示意图](PixPin_2026-05-13_17-49-29.webp)

### 摘要
>由于预训练的模型针对特定的语料时的表现较差,研究人员引入了**retrieval-augmented generation**模型,它使用了预训练的seq2seq模型(于2014年提出的编码器-解码器模型)和未被模型学习过的Wikipedia语料,这种模型比单独的预训练模型和专门针对Wikipedia语料训练的模型效果还要好.

### 引入
>由于预训练好的模型不能轻易的扩展或者修改参数,所以有研究者提出了将预训练模型和外部语料结合在一起的混合模型架构,如REALM和ORQA模型,而RAG架构就是在这些研究的基础上提出来的.

>We build RAG models where the parametric memory is a pre-trained seq2seq transformer, and the
non-parametric memory is a dense vector index of Wikipedia, accessed with a pre-trained neural retriever.

### 原理
- RAG的具体原理确实比较复杂,怪不得这么缺这方面的人才.
- 这部分的原文不太像人话,就算是论文也请你写的正常一点吧...
- 更别提整篇论文只有一张说明图,和一两张实验图表,你好意思去上顶刊,去评优秀论文吗😀
```md

## RAG 核心模型架构

RAG（Retrieval-Augmented Generation）模型结合了**参数化记忆**（Generator）与**非参数化记忆**（Retriever）。其核心逻辑是利用输入序列 $x$ 检索文档 $z$，并将 $z$ 作为生成目标序列 $y$ 的额外上下文。

模型包含两个组件：

1. **检索器 $p_\eta(z|x)$**：给定查询 $x$，返回文本段落的分布（通常取 Top-K）。
2. **生成器 $p_\theta(y_i|x, z, y_{1:i-1})$**：基于原始输入 $x$、检索到的文档 $z$ 以及已生成的 $i-1$ 个token，生成当前token $y_i$。


## 处理潜在变量 $z$ 的两种方式

为了实现端到端训练，文档 $z$ 被视为**潜在变量（Latent Variable）**。根据对 $z$ 边缘化（Marginalize）方式的不同，分为两种模型：

### 1. RAG-Sequence 模型

该模型假设生成整个序列时使用的是**同一篇文档**。它将 $z$ 视为单个潜在变量，通过对 Top-K 文档的概率进行求和来计算 $p(y|x)$：

$$p_{\text{RAG-Sequence}}(y|x) \approx \sum_{z \in \text{top-k}(p(\cdot|x))} p_\eta(z|x) p_\theta(y|x, z) = \sum_{z \in \text{top-k}(p(\cdot|x))} p_\eta(z|x) \prod_i^N p_\theta(y_i|x, z, y_{1:i-1})$$

### 2. RAG-Token 模型

该模型允许在生成每个token时**切换文档**。生成器可以从多个文档中挑选内容来组织答案：

$$p_{\text{RAG-Token}}(y|x) \approx \prod_i^N \sum_{z \in \text{top-k}(p(\cdot|x))} p_\eta(z|x) p_\theta(y_i|x, z, y_{1:i-1})$$


## 关键组件实现

### 检索器：DPR (Dense Passage Retriever)

检索概率基于双编码器（Bi-encoder）架构：


$$p_\eta(z|x) \propto \exp(d(z)^\top q(x))$$

* $d(z) = \text{BERT}_d(z)$：文档编码。
* $q(x) = \text{BERT}_q(x)$：查询编码。
检索过程通过 **MIPS（最大内积搜索）** 在线性时间内完成。

### 生成器：BART

使用预训练的 **BART-large**（seq2seq Transformer）。处理时直接将输入 $x$ 与检索内容 $z$ 进行拼接。

## 训练与解码

### 训练 (Training)

* **目标函数**：最小化负边际对数似然 $\sum_j -\log p(y_j|x_j)$。
* **更新策略**：为了降低计算成本，不更新文档编码器 $\text{BERT}_d$ 和索引，仅微调查询编码器 $\text{BERT}_q$ 和生成器 $\theta$。

### 解码 (Decoding)

* **RAG-Token**：可以视为标准的自回归模型，直接使用标准**束搜索（Beam Search）**。
* 转移概率：$p'_\theta(y_i|x, y_{1:i-1}) = \sum_{z \in \text{top-k}(p(\cdot|x))} p_\eta(z|x) p_\theta(y_i|x, z, y_{1:i-1})$。


* **RAG-Sequence**：由于似然函数无法分解为单token概率，需针对每个文档 $z$ 分别运行束搜索，得到候选集 $Y$。
* **Thorough Decoding**：对不在某些文档束中的候选序列进行额外的正向传播计算，补全概率后求和。
* **Fast Decoding**：假设未在某文档束中出现的序列概率为 0，直接在现有候选集中求和，提高效率。
```

![示意图](PixPin_2026-05-13_18-42-20.webp)
- 这种东西没人看了不迷糊吧,真搞算法的话还是很难的

大致意思是,我们可以用两种方法实现RAG,一个是一口气生成完整答案的,一个是逐token参考文档生成答案的,第二种方案中,预训练模型在每生成一个token时会参考前文和多个文档语料,选择最优的文档语料来生成.

具体的原理如下:

我们将本地文档切分成短片段,存储在向量数据库中,当用户提问时,我们把用户输入向量和文档向量组合拼接起来,再喂给模型让它输出.

问题来了,我们输入的本地文档可能非常庞大,超过了模型的上下文限制,不可能也直接输入进去.我们需要**通过检索器进行快速的筛选**,找到与用户提问最符合的几个文档向量后再进行拼接.

检索器的实现原理还比较简单:

$p_{\eta}(z|x) \propto \exp(d(z)^\top q(x))$
$d(z) = \text{BERT}_d(z)$
$q(x) = \text{BERT}_q(x)$

**1. 向量化（Bi-Encoder 架构）**
检索器使用了两个独立的 BERT 模型：

* **查询编码器 $q(x)$**：把你的提问（Query）转换成一串数字（特征向量）。
* **文档编码器 $d(z)$**：把海量的背景资料（Documents）也转换成相同维度的数字串。


**2. 相似度计算（内积运算）**
公式中的 $d(z)^\top q(x)$ 代表两个向量的**点积**。通俗来说：

* 如果提问和某个文档在语义上越接近，它们生成的数字串在空间中的方向就越一致。
* 方向越一致，点积的数值（得分）就越高。
* $\exp$ 函数的作用是拉大分值差距，让得分高的文档脱颖而出。

**3. 极速筛选（MIPS 问题）**
面对数以亿计的文档，逐一计算点积太慢。该模型将问题转化为**最大内积搜索（MIPS）**, 通过建立特殊的“索引”结构，就能在接近线性的时间内锁定最匹配的前 $k$ 个文档。

至于MIPS怎么实现的?不好意思原文没怎么提😅

### 总结
尽管RAG通俗的解释还是很好理解的,但这篇论文对于具体原理的实现总有一点不情愿解释的感觉,就好像自己也实现不了的样子,而且根据论文中的实验结果来说,很多任务RAG并不是最优解:
![示意图](PixPin_2026-05-14_16-45-54.webp)

真正做Agent的话,RAG的能力还是很有限的,它有以下弊端:
1. 企业要想真正使用RAG,就需要把开源的模型或者自己开发的模型部署好后,在每次针对特定语料库训练时进行参数上的微调,这是很麻烦的,如果不微调的话表现会更差.
   1. 况且这篇论文没怎么讲如何实现参数微调,我有理由怀疑只是把语料喂进去重新训练了而已,而非是在输出端口进行微调.
2. 鉴于大多数企业不具备自主开发优秀大模型的能力,就需要调用第三方的API,调用API的话就不能对模型做手脚,而是要对自己本地的语料进行处理,储存一个向量数据库,并在输出时进行拼接.至于怎么实现,我看也不是很成熟,不然为什么这么缺这方面的人才.






## LLaMA: Open and Efficient Foundation Language Models(2023)
![示意图](PixPin_2026-05-10_20-30-42.webp)


# 计算机组成与设计: 硬件/软件接口
## 教材介绍和错误澄清
- 这本书的作者是John L. Hennessy 与 David A. Patterson,都是硬件领域中极其杰出的人物

![作者介绍](PixPin_2026-05-19_09-23-26.webp)

>这本书有三个指令集版本: RISC-V 版、MIPS 版和 ARM 版。当然推荐看新兴的RISC-V版本,如果出于国内应试的考量,就只能看MIPS版本了.

>"There are two textbooks for the course: Computer Organization and Design by Patterson and Hennessy... The expectation is that the same text will also be useful to you in a later architecture course (CS 152). Do not get 'Computer Architecture, a Quantitative Approach' by mistake; it's a similar-looking graduate text by the same authors."
>
>千万不要错买成《计算机体系结构：量化研究方法》(CAQA)，那是一本看起来很像、但由同作者撰写的研究生阶段教材

![前言里的声明](PixPin_2026-05-19_09-29-40.webp)

- 没错,我就是那个不小心先看了CAQA的人,在没有前置基础的情况下确实看的有点难受.
## 引言
**计算机体系结构的7个伟大设计思想:**
1. 使用抽象来隐藏底层实现细节,简化设计
2. 加速大概率事件,这比优化小概率事件更能提高性能
3. 通过并行来提高性能
4. 通过流水线提高性能
5. 通过预测来提高性能
6. 设计分层的存储器
7. 通过冗余提高系统的可靠性

## 指令
### 前置概念
- MIPS的寄存器有32个,大小均为32位,由于对32位数据进行整体操作的情况经常出现,所以将32位的数据称为字(**word**).
  - 也有64位的MIPS,但没必要了解.
- MIPS约定书写指令时用一个`$`后面跟两个字符来表示寄存器,比如说用`$s0`,`$s1`表示常规寄存器,用`$t0`表示临时寄存器.

>由于MIPS是按字节编址的,但指令都是32位的,所以加上偏移量比如说8时,实际上是加上了4x8个字节,这样才能正确读到A[8]处存储的指令,而不会错读到A[8/4].

| 硬件概念        | 数学表示 (十六进制) | 物理对应关系                                                   |
| --------------- | ------------------- | -------------------------------------------------------------- |
| **PC = 0x0000** | 基准地址            | 指向物理内存中的 **第 0 个字节**（里面包含 8 个 bit）          |
| **PC = 0x0001** | 地址加 1            | 指向物理内存中的 **第 1 个字节**（里面包含另外 8 个 bit）      |
| **PC = 0x0004** | 地址加 4            | 指向物理内存中的 **第 4 个字节**（跨过了 1 个 32 位的字/指令） |


### 基本操作数

1. add(加法)/sub(减法)指令后一般跟三个寄存器,第一个寄存器存储计算结果,后两个为要参与运算的寄存器
2. load指令用来装载从存储器复制到寄存器的数据,使用`lw`和`lb`符号,表示`load word`和`load byte`
3. store指令用来将数据从寄存器复制到寄存器中,使用`sw`和`sb`符号,表示`store word`和`store byte`.
4. MIPS中经常会用到常数运算,因此专门设计了立即数的加减法,记为`addi`,即`add immediate`,如`addi $s3,$s3,4`.

>MIPS还支持对半字和无符号半字的存取

![例题](PixPin_2026-05-21_14-00-52.webp)
### 基本指令格式
MIPS为了保证所有的指令长度均为32位,针对不同的需求,将不同类型的指令拆分成了不同的指令格式,最常用的格式为R型和I型.

R型,用于普通的寄存器运算指令:
![示意图](PixPin_2026-05-21_14-14-31.webp)

I型,用于立即数和数据传送指令:
![示意图](PixPin_2026-05-21_14-16-10.webp)

- op: 操作码(opcode)
- rs: 第一个寄存器
- rt: 第二个寄存器
- rd: 存放操作结果的寄存器
- shamt: 移位量(shift amount),若用不到则置为0
- funct: 功能码,用于操作码的扩展.

![例题](PixPin_2026-05-21_14-20-24.webp)

>可以看到,例题中的写法是把rd放在最前面了,但操作码格式中rd是放在最后面的,这个真心搞不太懂.
### 进阶操作数
**逻辑指令:**
1. 移位(shift): 分为左移(shift left logical,sll)和右移(srl)
2. 按位操作:按位与(AND)和按位或(OR),会逐个比较位数得出结果.
3. 或非指令(NOT OR,NOR): 为了保持三操作数的格式,MIPS用NOR来代替普通的NOT指令,只需要将一个辅助寄存器的值设定为0,结果就等价于NOT.

**决策指令**:
1. 分支指令: beq(branch if equal)和bne(branch if not equal),例子如下:

```bash
beq r1,r2,l1
```
如果r1与r2中的数值相等,则跳转到标签l1

```bash
bne r1,r2,l1
```
如果r1与r2中的数值不相等,则跳转到标签l1

2. 无条件分支指令: 即跳转指令`jr`,表示jump register,如`jr r1`
3. 跳转并链接指令: jump-and-link,jal,会在跳转地址的同时,将下一条指令的地址保存在特定的返回地址寄存器中.
## 算术运算
### 加法和减法
在加法和减法运算中,可能发生溢出,MIPS使用两种类型的算术指令来解决溢出:
1. add,addi,sub在溢出时抛出异常
2. addu,addiu,subu,在溢出时不产生异常

>由于C语言忽略溢出,所以MIPS C编译器只是用第二种算术指令.
### 乘法
![运算图](PixPin_2026-05-23_10-38-58.webp)

如果我们将乘数的32位全部拆开,每一位分别用到一个加法器的话,就可以大幅度加速运算:
![示意图](PixPin_2026-05-23_10-48-44.webp)

上面讨论的是正数乘法,如果是有符号乘法的话,符号位不参与运算即可.

MIPS提供了两条乘法指令: 乘法(mult)和无符号乘法(multu)
### 除法
![运算图](PixPin_2026-05-23_10-50-27.webp)

![运算流程](PixPin_2026-05-23_10-53-32.webp)

解释一下流程:
1. 之所以除数寄存器和余数寄存器是商寄存器的双倍长度,是因为要保证除数能从最高位慢慢向右移动,才知道够不够除被除数
2. 一开始余数寄存器初始化为被除数,发现余数比除数大时,将商寄存器左移,最低位记为1,否则记为0
3. 除数寄存器右移1位,继续相除,如果余数比除数小,则说明计算完成,可以退出循环,余数寄存器中的值则为最终的余数

>这个设计还是很精妙的,不是那么容易看懂的.

MIPS中提供了两条除法指令: 除法(div)和无符号除法(divu)

### 浮点运算
浮点数的基本运算法则与整数计算没有区别,只是要考虑一下指数的转换.

![浮点加法](PixPin_2026-05-24_10-08-22.webp)

![浮点乘法](PixPin_2026-05-24_10-08-56.webp)

MIPS中有以下浮点计算指令:
- 浮点单精度加 (add.s) 和双精度加 (add.d) 。
- 浮点单精度减 (sub.s) 和双精度减 (sub.d) 。
- 浮点单精度乘 (mul.s) 和双精度乘 (mul.d) 。
- 浮点单精度除 (div.s) 和双精度除 (div.d) 。
## 附录B: 逻辑设计基础(过)
- 书上讲的太烂了,只好另外找书恶补基础了

现代计算机的内部电路为数字电路,只工作在两个电压: 高电压和低电压,与二进制的0和1相匹配.

数字电路按照是否包含存储器件(电容,电感)可以分成两种逻辑电路:
1. 组合逻辑(combinational logic): 当前的输出只取决于当前的输入
2. 时序逻辑(sequential logic): 当前的输出不仅于当前的输入相关,还和存储器件中存储的值有关.

### 组合逻辑
仅仅使用**与门**,**或门**,**非门**,我们可以得到所有的逻辑器件,常用的组合逻辑器件如下:

- 译码器: 有n个输入和2^n个输出,对于每一种输入组合,都只有一个输出信号为1

![译码器图](PixPin_2026-05-25_10-40-36.webp)

- 多路选择器: 输出由控制信号从多个输入中选择一个产生

![选择器图](PixPin_2026-05-25_10-42-46.webp)

- 只读存储器(Read-Only Memory,ROM): 包含一组地址输入线和一组输出

- 算术逻辑单元(Arithmetic Logic Unit,ALU): 执行算术运算和逻辑运算

![ALU图](PixPin_2026-05-26_09-31-07.webp)
### 时序逻辑
#### 时钟
在时序电路中,时钟非常重要,决定了包含状态的存储元件何时更新,它只有两种状态: 高电平和低电平.

MIPS中采用`边沿触发时钟(edge-triggered clocking)`,所有的状态改变都发生在时钟边沿(即高低电平切换的时间点)

## 处理器
### 流水线
- 跳过了一大堆可怕的逻辑设计电路分析

![流水线示意图](PixPin_2026-05-26_10-26-19.webp)

流水线可以最大限度的利用硬件,对于特定的硬件来说,每个周期都可以执行新指令的该阶段操作.

- 流水线的级数:指令中涉及的总操作个数,例如某个指令涉及了6个操作,它的级数就是6

对于MIPS来说,


# Linux内核设计与实现
## 进程管理
### 前置概念
- 进程: 处于执行期的程序
- 线程: 进程中活动的对象,在Linux中,线程是一种特殊的进程.
- 进程创建: Linux调用`fork`复制一个现有进程(父进程),创建一个新进程(子进程),执行完毕后,父进程恢复执行,子进程开始执行.
- 进程执行: Linjx调用`exec`创建新进程的地址空间,并通过`exit`终结进程.

进程有以下五种状态:
1. TASK_RUNNING: 进程是可执行的,要么正在执行,要么在运行队列中等待执行
2. TASK_INTERRUPTIBLE: 进程正在睡眠,等待某些条件被满足,一旦满足这些条件,进程就会进入TASK_RUNNING状态
3. TASK_UNINTERRUPTIBLE: 进程正在睡眠,但外界信号不会影响它,由进程主动进入其他状态
4. TASK_TRACED: 被其他进程跟踪的进程
5. TASK_STOPPRD: 进程没有运行也无法运行
### 进程描述符与任务结构
>Linux内核用一个叫做任务队列的双向循环链表来保存进程,链表中的每一项都是类型为`task_struct`,称为进程描述符(process descriptor)的结构,**包含一个具体进程的所有信息.**

内核通过一个唯一的进程标识值(process identification,PID)来标识每个进程.

Linux中所有的进程都是PID为1的init进程的后代.

### 进程创建
其他的操作提供都提供了产生(spawn)进程的机制: 在新的地址空间里创建进程,并读入可执行文件后开始执行;而Unix类操作系统将上述的两个步骤分解为两个函数: `fork和exec`.

首先,fork通过拷贝当前进程创建一个子进程,子进程的大部分数据与父进程相同,除了PID和PPID(父进程的进程号).

然后,exec负责读取可执行文件并将其载入地址空间开始运行.

#### 写时拷贝
由于整个复制父进程的数据非常浪费空间,如果在进程创建后马上运行一个可执行文件,在运行时与父进程共享同一份数据,那么就可以大大减小开销,这被称为**写时拷贝**.


### 线程
>在其他操作系统中,线程被称为"轻量级进程",可以消耗更少的资源迅速执行任务;而在Linux中,线程就像是一个普通的进程,只是会与其他的进程共享某些资源

## 进程调度
>当运行状态的进程数量多于处理器个数时,就必须要调度程序来决定哪些进程优先执行,哪些进程稍后执行.
### 补充: Linux调度程序的历史
- 由于这本书太老了,所以让AI介绍一下完整的调度程序历史

从 Linux 2.5 至今，调度器经历了四次重大的架构级跃迁：

#### 1. O(1) 调度器 (Linux 2.5 - 2.6.22)

**引入背景**：早期的 `O(N)` 调度器在每次挑选进程时，都要遍历链表中的所有进程，耗时与进程总数 $N$ 成正比。在多核、多进程环境下，CPU 时间全部浪费在了遍历链表上。

##### 核心特性与机制

* **常数级时间复杂度**：引入了 `runqueue`（运行队列）结构，每个 CPU 拥有独立的队列，挑选进程的时间复杂度变成了 $O(1)$，与系统内运行的进程数量无关。
* **双阵营设计（Active/Expired）**：每个队列包含两个位图（Bitmap）加链表的组合：
* **Active 阵营**：存放还有时间片的进程。
* **Expired 阵营**：存放时间片耗尽的进程。
* **切换方式**：CPU 总是通过汇编指令（如 `bsfl` 寻找位图第一个非 0 位）在 Active 阵营中极速查找优先级最高的进程。当 Active 清空，直接交换 Active 和 Expired 指针，周而复始。


* **启发式交互评估**：为了给桌面交互进程（如鼠标、键盘响应）提供低延迟，内核通过一套复杂的“启发式算法”，根据进程的睡眠时间来**猜测**它是不是交互进程。如果是，就给它更高的优先级，甚至在其时间片用完后继续留在 Active 阵营。

##### 淘汰原因

这套“猜测”算法很快成为了灾难。随着应用变复杂，内核无法通过简单的公式准确区分哪些是真正的交互进程。这导致大名鼎鼎的 3D 射击游戏《Doom 3》在当时的 Linux 上运行时，由于被误判为非交互进程，掉帧极其严重，引起了社区的强烈不满。

---

#### 2. RSDL 与 CFS (Linux 2.6.23 - 6.5)

**引入背景**：为了彻底废除 O(1) 调度器中恶心的“启发式猜测”，澳大利亚医生兼内核天才 Con Kolivas 提出了 RSDL（反转台阶截止日期调度器），证明了无需猜测、仅靠纯粹的公平数学模型就能完美搞定交互体验。受此启发，Ingo Molnar 在 2007 年的 Linux 2.6.23 中引入了 **CFS（Completely Fair Scheduler，完全公平调度器）**。

##### 核心特性与机制

* **红黑树取代链表**：CFS 废除了时间片的概念，改用红黑树（Red-Black Tree）来管理进程。
* **虚拟运行时间 ($vruntime$)**：这是 CFS 的灵魂。每个进程都有一个 $vruntime$，代表它在 CPU 上实际运行的“虚拟时间”。
* 优先级低（Nice 值大）的进程，其 $vruntime$ 增加得快；
* 优先级高（Nice 值小）的进程，其 $vruntime$ 增加得慢。


* **绝对公平调度**：CFS 的逻辑非常纯粹：**永远选择红黑树最左侧（即 $vruntime$ 最小值）的节点运行**。

$$vruntime_{new} = vruntime_{old} + \Delta exec\_time \times \frac{NICE\_0\_LOAD}{weight}$$

##### 淘汰原因

CFS 运行了 16 年，但它有一个致命的结构性缺陷：**它把“公平（Fairness）”和“延迟（Latency）”这两个维度绑定在了同一个 Nice 值（权重）上**。
当一个高优先级的音频进程长期睡眠后突然醒来，它的 $vruntime$ 虽然落后，但由于红黑树的机制，它必须按照既定的步长去追赶，CFS 无法在“不破坏全局公平性”的前提下，强制让它**立即**抢占 CPU，这在高吞吐量的服务器或混合负载下会导致无法忍受的毛刺延迟。

---

#### 3. EEVDF 调度器 (Linux 6.6 - 至今)

**引入背景**：为了彻底解决 CFS 的延迟毛刺，Linux 核心调度器维护者 Peter Zijlstra 在 2023 年（Linux 6.6）移除了 CFS，换上了基于 1995 年学术理论实现的 **EEVDF（Earliest Eligible Virtual Deadline First）**。

##### 核心特性与机制

* **解耦“公平”与“延迟”**：EEVDF 引入了两个全新维度来衡量进程：
1. **Eligible（可行性）**：通过计算 $Lag$（进程“应得的 CPU 时间”与“实际得到的 CPU 时间”之差）。如果 $Lag \ge 0$，说明进程被亏欠了，属于 Eligible 状态；如果 $Lag < 0$，说明它透支了，不合格。
2. **Virtual Deadline（虚拟截止日期）**：进程被允许运行的最终期限。对延迟极其敏感的任务，其 Deadline 会被设得非常近。


* **双阶筛选算法**：
* **第一步**：剔除所有透支的（非 Eligible）进程，只在合格 of 进程里挑。
* **第二步**：在合格进程中，**直接挑选 Virtual Deadline 最早的那一个运行**。



通过这种设计，一个短时间醒来的音频或 UI 进程，不仅合格，而且其截止日期极短，可以在不破坏长线公平的前提下，瞬间切入 CPU 执行，完美解决了延迟毛刺。

### 前置概念
#### 多任务
多任务操作系统支持并发执行多个进程,在单处理器计算机中,这会产生多个进程在同时运行的幻觉,而在多处理器计算机上,多个进程会在不同的处理器上真正地同时运行.

多任务系统有两种:
1. 非抢占式多任务: 除非进程主动停止运行,否则将会一直运行下去,现在的操作系统都不再采用这种方案
2. 抢占式多任务: 由系统调度程序来决定什么时候停止一个进程运行,以供其他进程在处理器上运行,这被称为**抢占**.这是绝大部分操作系统采用的方案.
#### 进程类型
进程大致可分为两种类型:
1. I/O消耗型: 大部分时间用来提交I/O请求或者等待I/O请求,经常处于可运行状态,但实际的运行时间很短
2. 处理器消耗型: 大部分时间用来执行,代表性的例子有那些大量执行数学计算的程序如MATLAB

Linux为了优化交互体验和提升性能,更倾向于优先调度I/O消耗型的进程.
#### 时间片
- 时间片: 进程被抢占前能持续运行的时间,默认情况下很短,比如10ms,从而保证系统与用户交互的延迟较低.
#### 进程优先级
进程调度的一个简单想法是: 优先级高的进程优先运行,相同优先级的进程轮流运行.

Linux采用两种不同的优先级算法:
1. 使用nice值: 它的范围从-20到+19,默认值为0,nice值越大优先级越低(你对系统中的其他进程太好了,让它们比你先运行).在Linux中,nice值越低,进程占用的时间片比例越高.
   1. 对应调度管理器算法
2. 使用实时优先级: 它的范围从0到99,数值越高进程优先级越高,可以手动配置,使用该类优先级算法的进程比默认使用nice值的进程优先级都高.
   1. 对应实时的调度策略,不受调度管理器管辖

### Linux调度算法
如果直接按照nice值映射到进程占用的时间片大小,会产生以下问题:
- nice值越高的进程占用的时间片越短,需要经过频繁的上下文切换,但这种进程往往是不应该被打断的计算密集型的后台进程,导致运行效率显著下降

Linux2.6版本引入了CFS(完全公平调度)机制:
1. 将nice值作为进程获得的处理器运行比的权重,而不是分得的时间片大小
2. 设定一个目标延迟值(如20ms),每个进程严格按照延迟值来运行,如果有4个进程,每个进程只能运行5ms;如果有20个进程,则只能运行1ms;
3. 设定一个最小时间片大小(如1ms),每个进程获得的时间片大小不得小于该长度
4. CFS通过红黑树来调度进程.

>显然,如果进程数量过多,必须让一些进程终止运行,否则进程的运行时间会小于最小时间片大小.

## 系统调用
- 系统调用: 用户进程与内核进行交互的一组接口,可以让应用程序在一定的限制下访问硬件设备

## 中断
# C和指针

# Hello算法
- [官网](https://www.hello-algo.com/chapter_computational_complexity/time_complexity/#5-olog-n)
## 前言
说来也好笑,尽管我一开始学算法时觉得这本书写的不太好,转而去看其他的算法书了,但现在回头重学算法的时候却发现,这本书的目录编排恰恰是我想要学习的内容:
![目录](PixPin_2026-05-21_22-47-54.webp)

缘分就是这么妙不可言.
## 数据结构
### 基本数据结构
链表
```cpp
struct ListNode{
  int val;
  ListNode* next;
  ListNode(int x): val(x),next(nullptr){}
};
```
列表
```cpp
vector<int> nums;
nums.clear();
nums.push_back(1);
nums.insert(nums.begin()+1,6);
nums.erase(nums.begin()+1);
sort(nums.begin(),nums.end());
```
- 之所以不叫push是因为vector还可以从前端插入,但实际上并没有`push_front`方法,因为开销太大了

栈
```cpp
stack<int> stack;
stack.push(1);
stack.push(2);

int top = stack.top();

stack.pop();

int size =stack.size();

bool empty =stack.empty();
```

队列
```cpp
queue<int> queue;
queue.push(1);
queue.push(2);

int front = queue.front();

queue.pop();

int size =queue.size();

bool empty =queue.empty();
```

双向队列(double-ended queue)
```cpp
deque<int> deque;
deque.push_back(1);
deque.push_front(2);

int front =deque.front();
int back =deque.back();

deque.pop_front();
deque.pop_back();

int size = deque.size();

bool empty =deque.empty();
```
哈希表
```cpp
unordered_map<int,string>map;

map[12345]="hello";
string name = map[12345];

map.erase(12345);

/* 遍历哈希表 */
// 遍历键值对 key->value
for (auto kv: map) {
    cout << kv.first << " -> " << kv.second << endl;
}
// 使用迭代器遍历 key->value
for (auto iter = map.begin(); iter != map.end(); iter++) {
    cout << iter->first << "->" << iter->second << endl;
}
```


### 进阶数据结构
#### 二叉树
```cpp
/* 二叉树节点结构体 */
struct TreeNode {
    int val;          // 节点值
    TreeNode *left;   // 左子节点指针
    TreeNode *right;  // 右子节点指针
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

/* 初始化二叉树 */
// 初始化节点
TreeNode* n1 = new TreeNode(1);
TreeNode* n2 = new TreeNode(2);
TreeNode* n3 = new TreeNode(3);
TreeNode* n4 = new TreeNode(4);
TreeNode* n5 = new TreeNode(5);
// 构建节点之间的引用（指针）
n1->left = n2;
n1->right = n3;
n2->left = n4;
n2->right = n5;
```
层序遍历,本质上是广度优先遍历
```cpp
/* 层序遍历 */
vector<int> levelOrder(TreeNode *root) {
    // 初始化队列，加入根节点
    queue<TreeNode *> queue;
    queue.push(root);
    // 初始化一个列表，用于保存遍历序列
    vector<int> vec;
    while (!queue.empty()) {
        TreeNode *node = queue.front();
        queue.pop();              // 队列出队
        vec.push_back(node->val); // 保存节点值
        if (node->left != nullptr)
            queue.push(node->left); // 左子节点入队
        if (node->right != nullptr)
            queue.push(node->right); // 右子节点入队
    }
    return vec;
}
```
三种深度优先遍历:
```cpp
/* 前序遍历 */
void preOrder(TreeNode *root) {
    if (root == nullptr)
        return;
    // 访问优先级：根节点 -> 左子树 -> 右子树
    vec.push_back(root->val);
    preOrder(root->left);
    preOrder(root->right);
}

/* 中序遍历 */
void inOrder(TreeNode *root) {
    if (root == nullptr)
        return;
    // 访问优先级：左子树 -> 根节点 -> 右子树
    inOrder(root->left);
    vec.push_back(root->val);
    inOrder(root->right);
}

/* 后序遍历 */
void postOrder(TreeNode *root) {
    if (root == nullptr)
        return;
    // 访问优先级：左子树 -> 右子树 -> 根节点
    postOrder(root->left);
    postOrder(root->right);
    vec.push_back(root->val);
}
```
尽管上述代码很简单,但在简单算法题中的用法确实就有这么简单.
#### 二叉搜索树
查找
```cpp
/* 查找节点 */
TreeNode *search(int num) {
    TreeNode *cur = root;
    // 循环查找，越过叶节点后跳出
    while (cur != nullptr) {
        // 目标节点在 cur 的右子树中
        if (cur->val < num)
            cur = cur->right;
        // 目标节点在 cur 的左子树中
        else if (cur->val > num)
            cur = cur->left;
        // 找到目标节点，跳出循环
        else
            break;
    }
    // 返回目标节点
    return cur;
}
```

插入
```cpp
/* 插入节点 */
void insert(int num) {
    // 若树为空，则初始化根节点
    if (root == nullptr) {
        root = new TreeNode(num);
        return;
    }
    TreeNode *cur = root, *pre = nullptr;
    // 循环查找，越过叶节点后跳出
    while (cur != nullptr) {
        // 找到重复节点，直接返回
        if (cur->val == num)
            return;
        pre = cur;
        // 插入位置在 cur 的右子树中
        if (cur->val < num)
            cur = cur->right;
        // 插入位置在 cur 的左子树中
        else
            cur = cur->left;
    }
    // 插入节点
    TreeNode *node = new TreeNode(num);
    if (pre->val < num)
        pre->right = node;
    else
        pre->left = node;
}
```

删除
```cpp
/* 删除节点 */
void remove(int num) {
    // 若树为空，直接提前返回
    if (root == nullptr)
        return;
    TreeNode *cur = root, *pre = nullptr;
    // 循环查找，越过叶节点后跳出
    while (cur != nullptr) {
        // 找到待删除节点，跳出循环
        if (cur->val == num)
            break;
        pre = cur;
        // 待删除节点在 cur 的右子树中
        if (cur->val < num)
            cur = cur->right;
        // 待删除节点在 cur 的左子树中
        else
            cur = cur->left;
    }
    // 若无待删除节点，则直接返回
    if (cur == nullptr)
        return;
    // 子节点数量 = 0 or 1
    if (cur->left == nullptr || cur->right == nullptr) {
        // 当子节点数量 = 0 / 1 时， child = nullptr / 该子节点
        TreeNode *child = cur->left != nullptr ? cur->left : cur->right;
        // 删除节点 cur
        if (cur != root) {
            if (pre->left == cur)
                pre->left = child;
            else
                pre->right = child;
        } else {
            // 若删除节点为根节点，则重新指定根节点
            root = child;
        }
        // 释放内存
        delete cur;
    }
    // 子节点数量 = 2
    else {
        // 获取中序遍历中 cur 的下一个节点
        TreeNode *tmp = cur->right;
        while (tmp->left != nullptr) {
            tmp = tmp->left;
        }
        int tmpVal = tmp->val;
        // 递归删除节点 tmp
        remove(tmp->val);
        // 用 tmp 覆盖 cur
        cur->val = tmpVal;
    }
}
```
#### 堆
- 堆是一种完全二叉树,可以使用优先队列实现.分为根节点最大的大顶堆和根节点最小的小顶堆

```cpp
#include <queue>
#include <vector>
#include <functional>

std::priority_queue<T, Container, Compare> pq;
```

cpp的优先队列默认的底层容器是vector,默认采用大顶堆:
```cpp
// 默认写法为大顶堆
std::priority_queue<int> pq;

// 小顶堆,由于第三个参数依赖第二个参数,所以要全部写出来
std::priority_queue<int, std::vector<int>, std::greater<int>> pq;

pq.push(3);
pq.push(1);
pq.push(5);

std::cout << pq.top(); // 1
```


```cpp
/* 初始化堆 */
// 初始化小顶堆
priority_queue<int, vector<int>, greater<int>> minHeap;
// 初始化大顶堆
priority_queue<int, vector<int>, less<int>> maxHeap;

/* 元素入堆 */
maxHeap.push(1);
maxHeap.push(3);
maxHeap.push(2);
maxHeap.push(5);
maxHeap.push(4);

/* 获取堆顶元素 */
int peek = maxHeap.top(); // 5

/* 堆顶元素出堆 */
// 出堆元素会形成一个从大到小的序列
maxHeap.pop(); // 5
maxHeap.pop(); // 4
maxHeap.pop(); // 3
maxHeap.pop(); // 2
maxHeap.pop(); // 1

/* 获取堆大小 */
int size = maxHeap.size();

/* 判断堆是否为空 */
bool isEmpty = maxHeap.empty();

/* 输入列表并建堆 */
vector<int> input{1, 3, 2, 5, 4};
priority_queue<int, vector<int>, greater<int>> minHeap(input.begin(), input.end());
```

#### 图
实际的图有两种表示方法:
1. 邻接矩阵: 有n个节点就要用nxn大小的矩阵来表示
2. 邻接表: 存储实际存在的边,空间复杂度更小,但时间复杂度更高.
## 算法
### 搜索
#### 二分查找


# 网络游戏核心技术与实战
## 前置概念
![层次体系图](PixPin_2026-05-25_16-13-27.webp)

## 网络游戏的历史
# 深度探索C++对象模型
## 关于对象
# x86汇编语言：从实模式到保护模式(待补充)
# Building Generative AI Services with FastAPI(待补充)
# 计算机体系结构: 量化研究方法(待补充)
- 如上一本书所说明的,这本书属于进阶版本的教材,但因为是相同的作者写的,所以编排风格十分相似.

## 量化设计与分析基础
### 前置概念
应用程序中主要有两种并行:
1. 数据级并行(DLP): 同时操作多个数据项
2. 任务级并行(TLP): 同时执行多个工作任务

计算机硬件为了实现上述的两种架构,有以下四种并行方法:
1. 指令级并行: 利用流水线实现数据级并行
2. 使用向量处理机和GPU: 将单条指令并行应用于一个数据集,实现数据级并行
3. 线程级并行: 在并行线程间进行交互,实现数据级/任务级并行
4. 请求级并行

我们还可以根据指令流与数据流的关系将计算机架构分成4类:
1. 单指令流,单数据流(SISD): 使用单处理器,顺序执行指令,但可以实现指令级并行
2. 单指令流,多数据流(SIMD): 使用多处理器,不同的处理器可以装载不同的数据流,但只能由一个处理器来装载指令,是现代GPU的主要架构
3. 多指令流,单数据流(MISD): 不太有开发的必要,指令容易冲突,还不能并行处理多个数据.
4. 多指令流,多数据流(MIMD): 每个处理器都使用自己的指令操控自己的数据,是现代CPU的主要架构.

### 指令集体系结构(ISA)
几乎所有的ISA都属于通用寄存器体系结构,80x86有16个通用寄存器和16个存储浮点数据的寄存器;MIPS有32个通用寄存器和32个浮点寄存器.

所有的计算机都使用**字节寻址**来访问存储器操作数,MIPS有三种寻址方式: 寄存器寻址,立即数寻址,位移量寻址.

MIPS的操作指令比较简单,大致可分为以下几种:
1. 数据传输指令
2. 算术逻辑指令
3. 控制指令
4. 浮点指令

| 指令类型/操作码                       | 指令含义                                                                                                         |
| ------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| **数据传输**                          | 在寄存器和存储器之间，或者在整数和FP或特殊寄存器之间移动数据；唯一的存储器寻址模式是16位位移量加上GPR的内容      |
| LB, LBU, SB                           | 载入字节、载入无符号字节、存储字节（至/自整数寄存器）                                                            |
| LH, LHU, SH                           | 载入半字、载入无符号半字、存储半字（至/自整数寄存器）                                                            |
| LW, LWU, SW                           | 载入字、载入无符号字、存储字（至/自整数寄存器）                                                                  |
| LD, SD                                | 载入双字、存储双字（至/自整数寄存器）                                                                            |
| L.S, L.D, S.S, S.D                    | 载入SP浮点、载入DP浮点、存储SP浮点、存储DP浮点                                                                   |
| MFC0, MTC0                            | 在GPR与特殊寄存器之间复制数据                                                                                    |
| MOV.S, MOV.D                          | 将一个SP或DP FP寄存器复制到另一个FP寄存器                                                                        |
| MFC1, MTC1                            | 在FP寄存器与整数寄存器之间复制32位                                                                               |
| **算术/逻辑**                         | 对GPR中的整数或逻辑数据进行操作；带有符号算术运算溢出时进行陷阱捕获                                              |
| DADD, DADDI, DADDU, DADDIU            | 加，加立即数（所有立即数为16位），有符号和无符号                                                                 |
| DSUB, DSUBU                           | 减，有符号和无符号                                                                                               |
| DMUL, DMULU, DDIV, DDIVU, MADD        | 乘和除，有符号和无符号，乘-加；所有运算的操作数和结果都是64位数值                                                |
| AND, ANDI                             | 与，和立即数相与                                                                                                 |
| OR, ORI, XOR, XORI                    | 或，和立即数求或，异或，和立即数求异或                                                                           |
| LUI                                   | 载入高位立即数；将立即数载入到寄存器的32~47位，然后进行符号扩展                                                  |
| DSLL, DSRL, DSRA, DSLLV, DSRLV, DSRAV | 移位：立即数形式（DS__）和变量形式（DS__V），移位为左逻辑移位、右逻辑移位、右算术移位                            |
| SLT, SLTI, SLTU, SLTIU                | 若小于操作数则置位、若小于立即数则置位、有符号和无符号                                                           |
| **控制**                              | 控制分支和跳转，相对于PC寄存器或通过寄存器控制                                                                   |
| BEQZ, BNEZ                            | GPR等于/不等于0时转移，相对于PC+4偏移16位偏移量                                                                  |
| BEQ, BNE                              | GPR相等/不等时转移、相对于PC+4偏移16位偏移量                                                                     |
| BC1T, BC1F                            | 测试FP状态寄存器中的对比位，并转移；相对于PC+4偏移16位偏移量                                                     |
| MOVN, MOVZ                            | 如果第三个GPR为负数/零，则将第一个GPR复制到第二个GPR                                                             |
| J, JR                                 | 跳转至与PC+4偏移26位偏移量的位置（J）、跳转至寄存器中的目标位置（JR）                                            |
| JAL, JALR                             | 跳转和链接：将PC+4保存在R31中，目标为相对于PC（JAL）或寄存器（JALR）                                             |
| TRAP                                  | 转移到操作系统的一个向量地址                                                                                     |
| ERET                                  | 从异常中返回用户代码，恢复用户模式                                                                               |
| **浮点**                              | 对DP和SP格式执行FP操作                                                                                           |
| ADD.D, ADD.S, ADD.PS                  | DP、SP相加，一对SP数相加                                                                                         |
| SUB.D, SUB.S, SUB.PS                  | DP、SP相减，一对SP数相减                                                                                         |
| MUL.D, MUL.S, MUL.PS                  | DP、SP浮点数相乘，一对SP数相乘                                                                                   |
| MADD.D, MADD.S, MADD.PS               | DP、SP浮点数相乘加，一对SP数相乘加                                                                               |
| DIV.D, DIV.S, DIV.PS                  | DP、SP浮点数相除，一对SP数相除                                                                                   |
| CVT.*.*                               | 转换指令：CVT.x.y从类型x转换为类型y，其中x和y为L（64位整数）、W（32位整数）、D（DP）或S（SP）。两个操作数都是FRP |
| C.*.D, C.*.S                          | DP和SP对比：“_”=LT, GT, LE, GE, EQ, NE；在FP状态寄存器中置位                                                     |

MIPS中所有指令的长度都是32位,从而简化了指令译码:
![示意图](image-2.png)

### Amdahl定律: 计算加速比
Amdahl定律用于计算升级某个部件/功能时获得的**加速比**,即采用升级前所用的时间与升级后所用时间的比值,从而衡量出某个部件/功能的贡献大小:

$$S_{\text{latency}} = \frac{1}{(1 - p) + \frac{p}{s}}$$

* $S_{\text{latency}}$：整个任务执行速度的理论加速比。
* $p$：任务中受益于资源改进的部分所占的时间比例（$0 \le p \le 1$）。
* $s$：受改进部分原本的性能提升倍数。

![示意图](PixPin_2026-05-16_10-25-13.webp)

### CPI: 衡量处理器的性能
所有计算机都有一个时钟周期,那么CPU执行某个任务的时间就等于**经过的周期数乘以一个时钟周期的时间**.

我们使用**每条指令的周期数**(Cycle Per Instruction,CPI)来衡量某条指令所花的时间长度:

$$\text{CPI} = \frac{\text{程序的CPU时钟周期数}}{\text{指令数}}$$

那么处理器的性能就取决于三个变量: 时钟周期,CPI,指令数.

## 存储器层次结构设计
鉴于快速存储器非常昂贵,现代计算机都使用分层的存储器结构,从而实现以下效果:
- **每字节的成本几乎与最便宜的存储器级别相同,速度几乎与最快速的级别相同**


![示意图](image-3.png)

- 下一级存储器通常会保留上一级存储器的所有信息,才能保证信息不会丢失
### 优化缓存性能
1. 使用小而简单的第一级缓存,缩短命中时间
2. 采用**路预测**,缩短命中时间
   1. 缓存中留出一部分空间用于预测下一次要访问的数据
3. 缓存访问流水化(Cache Access Pipelining),即将缓存访问拆成多个步骤,提高缓存带宽:

```md
时钟周期：   |  Cycle 1  |  Cycle 2  |  Cycle 3  |  Cycle 4  |
指令 A:     [ 地址解码 ] [ 阵列驱动 ] [ 数据读出 ]
指令 B:                 [ 地址解码 ] [ 阵列驱动 ] [ 数据读出 ]
指令 C:                             [ 地址解码 ] [ 阵列驱动 ] [ 数据读出 ]
````
4. 采用无阻塞缓存,提高缓存带宽
   1. 出现缓存不命中(miss)时,不中断缓存访问,这是通过在缓存内部引入了一组特殊的硬件寄存器实现的,它被称为**未命中状态保持寄存器**（MSHR，Miss Status Holding Registers）.

![示意图](PixPin_2026-05-17_09-46-34.webp)

5. 采用多种缓存,提高缓存带宽.
   1. 将缓存划分成多个相互独立的,支持同时访问的缓存组
6. 关键字优先和提前重启动,降低缓存不命中的代价
   1. 缓存与主存交换数据的最小单位是块(Block),一个块包含多个字(word),当CPU只需要某一块其中的一个字时,缓存控制器直接跳转到对应的地址获取那个缺失的字,让CPU恢复执行后再发送该块的剩余部分
   2. 另一种实现方法,缓存保持顺序读取,实时检查当前块中是否出现了CPU需要的字,一旦出现就直接发送给CPU,再接着发送剩余部分.

7. 合并写缓冲区,降低缓存不命中的代价
   1. 为了不让CPU每次执行缓存的写入操作时都等待新数据从缓存慢慢传回内存,我们会设计一个写缓冲区,CPU将数据写入该缓冲区后继续执行,缓冲区负责将数据异步写入下级存储.
   2. 如果新写入的数据与缓冲区中某个数据属于一个块(这是非常常见的情况,因为代码和数据通常都保存在一块连续内存上),则直接将这两部分数据合并,节省写缓冲区空间

![示意图](image-4.png)

8. 采用编译器优化,降低缓存不命中的概率
   1. 编译器会对代码进行优化处理,帮助处理器以更高的效率执行代码

上面的这些做法都在现代计算机体系结构中得到了广泛的应用.
### 存储器种类
- Static Random Access Memory(SRAM): 通常用作缓存,集成在处理器的芯片上,响应速度远超DRAM
- Dynamic Random Access Memory(DRAM): 用作内存条,在每次读取信息后会破坏该信息,所以要进行**刷新**后写回数据,速度比较慢,适合放在硬盘和缓存中间作为缓冲存储器.
- SDRAM: 同步DRAM,DRAM的优化版本,现代的内存条都是SDRAM.
- NAND flash(闪存): 最常见的闪存就是SSD(固态硬盘),通常为最后一级存储器,速度很慢,但比起HDD(机械硬盘)又快得多.
## 附录A: 指令集基本原理
### 指令集体系结构的种类
1. 栈结构: 早期计算机
2. 累加器结构: 早期计算机
3. 寄存器-存储器结构: x86架构等CISC
4. 寄存器-寄存器结构(载入-存储结构): RISC-V,MIPS等RISC

如果计算C=A+B的话,这四种结构的操作过程如下:
| 栈 (Stack) | 累加器 (Accumulator) | 寄存器（寄存器-存储器） (Register-Memory) | 寄存器（载入-存储） (Load-Store / Register-Register) |
| ---------- | -------------------- | ----------------------------------------- | ---------------------------------------------------- |
| Push A     | Load A               | Load R1, A                                | Load R1, A                                           |
| Push B     | Add B                | Add R3, R1, B                             | Load R2, B                                           |
| Add        | Store C              | Store R3, C                               | Add R3, R1, R2                                       |
| Pop C      |                      |                                           | Store R3, C                                          |

### 存储器寻址
MIPS指令集是字节寻址的,提供对字节(8位),半字(16位)和字(32位)的访问方式.

MIPS支持多种寻址方式,常见的几种如下:
| 寻址方式       | 指令举例         | 含义                                           | 使用时机                                      |
| -------------- | ---------------- | ---------------------------------------------- | --------------------------------------------- |
| 寄存器寻址     | Add R4,R3        | Regs[R4] ← Regs[R4] + Regs[R3]                 | 当一个值在寄存器中                            |
| 立即数寻址     | Add R4,#3        | Regs[R4] ← Regs[R4] + 3                        | 对于常量                                      |
| 位移量寻址     | Add R4,100(R1)   | Regs[R4] ← Regs[R4] + Mem[100 + Regs[R1]]      | 访问本地变量（+模拟寄存器间接、直接寻址方式） |
| 寄存器间接寻址 | Add R4,(R1)      | Regs[R4] ← Regs[R4] + Mem[Regs[R1]]            | 使用指针或计算得出的地址寻址                  |
| 索引寻址       | Add R3,(R1 + R2) | Regs[R3] ← Regs[R3] + Mem[Regs[R1] + Regs[R2]] | 有时用于数组寻址：R1为数组的基址，R2为索引值  |


## 附录B: 存储器层次结构
## 附录C: 流水线
## 指令级并行

# Go语言圣经(待补充)
- [中文版网站](https://golang-china.github.io/gopl-zh/preface-zh.html)
- (5/7): 看多了Java总觉得有些烦躁,就想着先学习一下Go来看看它的神奇之处

## 前言
>就事后诸葛的角度来看，Go语言的这些地方都做的还不错：拥有**自动垃圾回收**、一个**包系统**、**函数作为一等公民**、词法作用域、系统调用接口、只读的UTF8字符串等。但是Go语言本身只有很少的特性，也不太可能添加太多的特性。例如，它没有隐式的数值转换，没有构造函数和析构函数，没有运算符重载，没有默认参数，也没有继承，没有泛型，没有异常，没有宏，没有函数修饰，更没有线程局部存储。但是，**语言本身是成熟和稳定的，而且承诺保证向后兼容**：用之前的Go语言编写程序可以用新版本的Go语言编译器和标准库直接构建而不需要修改代码。

- 尽管Go现在支持泛型了,但是没有异常,也没有继承,重载,宏,隐式数值转换等一切让cpp变得面目可憎的东西.还是很不错的.

>Go语言有足够的类型系统以避免动态语言中那些粗心的类型错误，但是，**Go语言的类型系统相比传统的强类型语言又要简洁很多**。虽然，有时候这会导致一个“无类型”的抽象类型概念，但是Go语言程序员并不需要像C++或Haskell程序员那样纠结于具体类型的安全属性。在实践中，Go语言简洁的类型系统给程序员带来了更多的安全性和更好的运行时性能

## 入门
### 入门代码
```go
package main

import "fmt"

func main() {
    fmt.Println("Hello, 世界")
}
```
- fmt: format,格式化输入与输出

>Go 语言**不需要在语句或者声明的末尾添加分号**，除非一行上有多条语句。实际上，编译器会主动把特定符号后的换行符转换为分号，因此换行符添加的位置会影响 Go 代码的正确解析
### 循环语句
Go 语言**只有 for 循环这一种循环语句**。for 循环有多种形式，其中一种如下所示：
```go
for initialization; condition; post {
    // zero or more statements
}
```
>for 循环三个部分不需括号包围。大括号强制要求，左大括号必须和 post 语句在同一行。

- 格式很严格,但也很符合一般的编程习惯

```go
// Echo1 prints its command-line arguments.
package main

import (
    "fmt"
    "os"
)

func main() {
    var s, sep string
    for i := 1; i < len(os.Args); i++ {
        s += sep + os.Args[i]
        sep = " "
    }
    fmt.Println(s)
```

for的另一种写法类似python中的enumerate遍历:
```go
// Echo2 prints its command-line arguments.
package main

import (
    "fmt"
    "os"
)

func main() {
    s, sep := "", ""
    for _, arg := range os.Args[1:] {
        s += sep + arg
        sep = " "
    }
    fmt.Println(s)
}
```
- 与python一样,用不到的变量可以直接用下划线`_`代替.事实上Go中只能这么写,因为Go不允许使用**无用的局部变量**.

该`for ... range ...`循环用于遍历某一种数据结构,每次迭代都会返回一对值,第一个是索引,第二个是索引处的元素值.
### 总结
看到这就可以了,后面只是对Go的基础功能的一些展示.
## 程序结构
### 变量
#### 变量声明
基本语法如下:
```go
var 变量名字 类型 = 表达式
```

>其中“类型”或“= 表达式”两个部分可以省略其中的一个。如果省略的是类型信息，那么将根据初始化表达式来推导变量的类型信息。如果初始化表达式被省略，那么将用零值初始化该变量。 数值类型变量对应的零值是0，布尔类型变量对应的零值是false，字符串类型对应的零值是空字符串，接口或引用类型（包括slice、指针、map、chan和函数）变量对应的零值是nil。数组或结构体等聚合类型对应的零值是每个元素或字段都是对应该类型的零值。

- 还是很方便的,不像cpp一样总要手动指定初始值.
```go
var s string
fmt.Println(s) // ""
```

也可以用两种方法同时声明多个变量:
```go
var i, j, k int                 // int, int, int
var b, f, s = true, 2.3, "four" // bool, float64, string
```

Go还有一种非常简短的方式来声明和初始化**局部变量**,这被称为**简短变量声明**:
```go
anim := gif.GIF{LoopCount: nframes}
freq := rand.Float64() * 3.0
t := 0.0
```
- 我们不需要写前置的var关键字,也不需要写后置的变量类型,而是由编译器自动推导

我们同样可以一次声明一组变量:
```go
i, j := 0, 1
```
需要注意的是,`:=`必须要至少声明一个新的变量,否则会报错:
```go
f, err := os.Open(infile)
// ...
f, err := os.Create(outfile) // compile error: no new variables
```
### 指针
由于Go的底层不是如Java,Python一样的引用传值,而是和Cpp,Rust一样的值拷贝,所以有必要引入指针,**来避免大规模的复制拷贝**.

- 任何类型指针的零值都是**nil**,对应于cpp中的nullptr.

```go
var p = f()

func f() *int {
    v := 1
    return &v
}
```


# 深入理解Java虚拟机(待补充)
如果要理解Java为什么能够"一次编写,处处运行",就需要来看这本书
## ch1: 走进Java
- 这一章很值得看,深入探讨了JDK的历史
## ch2: Java内存区域与内存溢出异常



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


## 异常
## 泛型
## 并发编程
# [设计数据密集型应用](https://ddia.vonng.com/v1/)(待补充)
## 数据系统
数据系统有以下几个作用:
- 存储数据，以便自己或其他应用程序之后能再次找到 （数据库，即 databases）
- 记住开销昂贵操作的结果，加快读取速度（缓存，即 caches）
- 允许用户按关键字搜索数据，或以各种方式对数据进行过滤（搜索索引，即 search indexes）
- 向其他进程发送消息，进行异步处理（流处理，即 stream processing）
- 定期处理累积的大批量数据（批处理，即 batch processing）
因此,常规的数据库,消息队列等信息处理系统都可以被归类为数据系统.

我们可以从三个维度来评价一个数据系统写的怎么样:
1. 可靠性: 出了故障仍然可以正常运行
2. 可伸缩性: 能够应付系统的扩大和其他变化
3. 可维护性: 架构清晰,职责分明,方便维护
### 可靠性
#### 处理硬件故障
>当想到系统失效的原因时，硬件故障（hardware faults） 总会第一个进入脑海。硬盘崩溃、内存出错、机房断电、有人拔错网线…… 任何与大型数据中心打过交道的人都会告诉你：一旦你拥有很多机器，这些事情总会发生！

我们可以通过**硬件冗余**(redundancy of hardware)来解决这个问题,即提供后备组件来及时接替故障硬件,防止系统崩溃.

#### 软件故障
软件故障有以下几个例子:
- 接受特定的错误输入，便导致所有应用服务器实例崩溃的 BUG。例如 2012 年 6 月 30 日的闰秒，由于 Linux 内核中的一个错误，许多应用同时挂掉了。
- 级联故障，一个组件中的小故障触发另一个组件中的故障，进而触发更多的故障


#### 管理员的失误导致的故障
>一项关于大型互联网服务的研究发现，运维配置错误是导致服务中断的首要原因，而硬件故障（服务器或网络）仅导致了 10-25% 的服务中断

### 可伸缩性
>系统今天能可靠运行，并不意味未来也能可靠运行。服务 降级（degradation） 的一个常见原因是负载增加，例如：系统负载已经从一万个并发用户增长到十万个并发用户，或者从一百万增长到一千万。也许现在处理的数据量级要比过去大得多

#### 负载: 以推特为例
以推特在 2012 年 11 月发布的数据为例,推特的两个主要业务是：
- 发布推文
  - 用户可以向其粉丝发布新消息（平均 4.6k 请求 / 秒，峰值超过 12k 请求 / 秒）。
- 主页时间线
  - 用户可以查阅他们关注的人发布的推文（300k 请求 / 秒）。

大体上讲，这一对操作有两种实现方式。

1. 发布推文时，只需将新推文插入全局推文集合即可。当一个用户请求自己的主页时间线时，首先查找他关注的所有人，查询这些被关注用户发布的推文并按时间顺序合并。在如 图 1-2 所示的关系型数据库中，可以编写这样的查询：
```sql
SELECT tweets.*, users.*
  FROM tweets
  JOIN users   ON tweets.sender_id = users.id
  JOIN follows ON follows.followee_id = users.id
  WHERE follows.follower_id = current_user
```
2. 为每个用户的主页时间线维护一个缓存，就像每个用户的推文收件箱。当一个用户发布推文时，查找所有关注该用户的人，并将新的推文插入到每个主页时间线缓存中。因此读取主页时间线的请求开销很小，因为结果已经提前计算好了。

>推特的第一个版本使用了方法 1，但系统很难跟上主页时间线查询的负载。所以公司转向了方法 2，方法 2 的效果更好，因为发推频率比查询主页时间线的频率几乎低了两个数量级，所以在这种情况下，最好在写入时做更多的工作，而在读取时做更少的工作。
>
>然而方法 2 的缺点是，发推现在需要大量的额外工作。平均来说，一条推文会发往约 75 个关注者，所以每秒 4.6k 的发推写入，变成了对主页时间线缓存每秒 345k 的写入。但这个平均值隐藏了用户粉丝数差异巨大这一现实，一些用户有超过 3000 万的粉丝，这意味着一条推文就可能会导致主页时间线缓存的 3000 万次写入！及时完成这种操作是一个巨大的挑战 —— 推特尝试在 5 秒内向粉丝发送推文。

>推特轶事的最终转折：现在已经稳健地实现了方法 2，推特逐步转向了两种方法的混合。大多数用户发的推文会写入其粉丝主页时间线缓存中。但是少数拥有海量粉丝的用户（即名流）会被排除在外。当用户读取主页时间线时，分别地获取出该用户所关注的每位名流的推文，再与用户的主页时间线缓存合并

##### 如何处理负载
>适应某个级别负载的架构不太可能应付 10 倍于此的负载。如果你正在开发一个快速增长的服务，那么每次负载发生数量级的增长时，你可能都需要重新考虑架构 —— 或者更频繁。

>大规模的系统架构通常是应用特定的 —— 没有一招鲜吃遍天的通用可伸缩架构（不正式的叫法：万金油（magic scaling sauce） ）。应用的问题可能是读取量、写入量、要存储的数据量、数据的复杂度、响应时间要求、访问模式或者所有问题的大杂烩。
>
>举个例子，用于处理每秒十万个请求（每个大小为 1 kB）的系统与用于处理每分钟 3 个请求（每个大小为 2GB）的系统看上去会非常不一样，尽管两个系统有同样的数据吞吐量。

### 可维护性
众所周知，软件的大部分开销并不在最初的开发阶段，而是在持续的维护阶段，包括修复漏洞、保持系统正常运行、调查失效、适配新的平台、为新的场景进行修改、偿还技术债和添加新的功能。

## 数据模型
多数应用使用层层叠加的数据模型构建。对于每层数据模型的关键问题是：它是如何用低一层数据模型来 表示 的？例如：
1. 作为一名应用开发人员，你观察现实世界（里面有人员、组织、货物、行为、资金流向、传感器等），并采用对象或数据结构，以及操控那些数据结构的 API 来进行建模。那些结构通常是特定于应用程序的。
2. 当要存储那些数据结构时，你可以利用通用数据模型来表示它们，如 JSON 或 XML 文档、关系数据库中的表或图模型。
3. 数据库软件的工程师选定如何以内存、磁盘或网络上的字节来表示 JSON / XML/ 关系 / 图数据。这类表示形式使数据有可能以各种方式来查询，搜索，操纵和处理。
4. 在更低的层次上，硬件工程师已经想出了使用电流、光脉冲、磁场或者其他东西来表示字节的方法。

>握一个数据模型需要花费很多精力（想想关系数据建模有多少本书）。即便只使用一个数据模型，不用操心其内部工作机制，构建软件也是非常困难的。然而，因为数据模型对上层软件的功能（能做什么，不能做什么）有着至深的影响，所以选择一个适合的数据模型是非常重要的。

### 关系模型VS文档模型
>关系模型曾是一个理论性的提议，当时很多人都怀疑是否能够有效实现它。然而到了 20 世纪 80 年代中期，关系数据库管理系统（RDBMSes）和 SQL 已成为大多数人们存储和查询某些常规结构的数据的首选工具。关系数据库已经持续称霸了大约 25~30 年 —— 这对计算机史来说是极其漫长的时间。
>
>关系数据库起源于商业数据处理，在 20 世纪 60 年代和 70 年代用大型计算机来执行。从今天的角度来看，那些用例显得很平常：典型的 事务处理（将销售或银行交易，航空公司预订，库存管理信息记录在库）和 批处理（客户发票，工资单，报告）。

#### NoSQL 
采用 NoSQL 数据库的背后有几个驱动因素，其中包括：
1. 需要比关系数据库更好的可伸缩性，包括非常大的数据集或非常高的写入吞吐量
2. 相比商业数据库产品，免费和开源软件更受偏爱
3. 关系模型不能很好地支持一些特殊的查询操作


常见的NoSQL数据库有以下几个:
1. Redis: 基于内存的存储,核心逻辑是哈希表
2. MongoDB: 存储格式为JSON
#### 文档和关系数据库的融合
>随着时间的推移，关系数据库和文档数据库似乎变得越来越相似，这是一件好事：数据模型相互补充，如果一个数据库能够处理类似文档的数据，并能够对其执行关系查询，那么应用程序就可以使用最符合其需求的功能组合。

- (26/4/7): 我发现这本书我现在看太早了,很难有切实的收获,还是等几年再来探索吧

# The Garbage Collection Handbook

