---
title: 面向面试学习
date: 2026-10-24T16:01:09+08:00
description: 
image: 82924488_p0-Happy 8th Anniversary.webp
tags: 
    - 工作
    - 调研
---
# 技术面试
>[!NOTE]
>技术题才是面试的重中之重,只要技术过关,其他的表现不是太拉跨就可以,如果面试官问的知识点你想都不想就能回答出来的话,那该你拿offer.这也是为什么技术题我要单开一版并放在最前面的原因.

>[!TIP]
>需要说明的是,基本所有的问题都是从各种面经中摘抄过来的,而且面经之间是很容易重复的,一个个放来源实在太麻烦了,所以在这里给原作者们道个歉,就不放来源了.

![词云](image.png)

- 如果上述的所有名词你都能说出一点门道出来的话,那这部分你也不用看了.

## 运维
- 容器,Linux命令,计算机网络这些都算在里面了,毕竟运维的职责范围太广了

### 常规八股
#### 计算机网络
1. 从家里的计算机通过浏览器打开一个网页的完整流程是什么？请详细说明每一层的协议工作过程
   1. 先梳理一下五层模型,物理层,链路层,网络层,传输层,应用层,那么当我们访问某个网站的时候,流程如下:
   2. 如果本地没有存储该域名对应的ip地址,就要通过DNS协议去查询,DNS协议是从根域名开始逐级查询的,直到定位到你要查询的完整域名,并返回服务器的IP地址
   3. 找到IP地址后,我们计算机就可以封装数据包了,首先是通过socket接口封装TCP包,然后附加上IP地址,如果电脑连的是网线,那么就通过以太网连接到交换机,并不断跳转最终找到目标服务器;如果电脑是用的4G/WIFI,都是通过无线链路来进行传输的,最终还是传到交换机
   4. 目标服务器接收到请求后,进行拆分,确认请求内容合法并返回网页,然后交付到用户主机
2. 讲一下TCP的可靠交付,即三次握手/四次分手
   1. 网络环境是不可靠的,而TCP通过滑动窗口机制确保了可以通过重传和断点续传避免丢包,而如何确定有包丢失和是否重传呢,就是通过连接双方发送ACK和SYN报文来实现的.
   2. ...待补充
3. HTTP的头部有哪些内容
   1. 分为Response header(响应头),由服务器返回的详细参数,和Request header(请求头),用户对服务器的要求.
   2. ...待补充
4. select、poll、epoll分别的优缺点
5. HTTP1,1.1,2,3各自的基本内容?
6. CDN是什么，为什么用，怎么评价CDN的效果和性能
7. Websocket和Http长链接的区别,二者对服务器性能有什么影响
8. JWT原理?和Cookie的区别?
9. 如果有中间人抓包截取了JWT，作为劫持攻击该怎么办?能不能主动让JWT失效呢?
#### 操作系统
1. 线程有哪些状态,什么是死锁,如何恢复和避免
   1. 不同参考书的模型不一样,但常见的说法是有Ready,Running,Waiting,Terminated,New五种状态
   2. 多个线程,彼此请求对方持有的资源,导致死循环无法正常运行,必要条件是四个: 互斥(同一个资源只能给一个线程用),Hold and wait(占有并等待),无法强行释放(系统不能干扰),循环等待.
   3. 恢复的话有几种方法,最常用的就是重启,因为这样不用费脑子和降低性能,要么就只能强行终止部分进程从而破坏死锁.
   4. 防止死锁只要破坏上述的四个必要条件之一即可,如固定加锁顺序,或者一次性申请所有所需的资源,如果有一个资源拿不到,那么就全部不拿.
2. 32位的物理机能申请多少内存呢？那64位呢？
   1. 实际问的是虚拟寻址空间的概念,32位的寻址空间自然就是2的32次方Byte,对应4GB的大小,64位物理机同理
   2. 为什么是Byte呢,因为操作系统是按字节寻址的,即每个地址对应的是一个8位的数组
3. inode是什么，存放什么内容;
4. 硬链接和软连接是什么区别，使用场景上有什么区别
5. 你在终端执行 python app.py，程序正在运行。如果此时按下 Ctrl+C 和 Ctrl+Z，分别会发生什么？
   1. Ctrl+C是发送 SIGINT，请求中断,Python 通常抛出 KeyboardInterrupt，未捕获时退出
   2. Ctrl+Z是发送 SIGTSTP，暂停进程,程序暂停，仍然存在，终端回到命令提示符
#### 容器
1. k8s多个pod，怎么发现这个新的pod

#### Linux命令
### CI/CD
1. 你对CI/CD的基本了解?
### 高级
1. 为什么 RPC 使用 Protobuf
## 数据库/架构
- 说到架构一定会有数据库,说到数据库一定会有架构


### 常规八股
1. 解决hash冲突的方式有哪些？
   1. 链地址法: 弄一个桶或者链表把相同键的值放在一起
   2. 开放寻址法: 写一个数学公式,定义每次冲突后寻找的下一个插入位置,如果冲突则继续找下一个
   3. 直接扩容
2. 什么是IO多路复用(multiplexing)?Redis中相关的应用有哪些?
   1. 一个线程同时监听多个I/O连接,谁处理好了就处理谁,事实上,这个复用翻译的很烂,对比计算机网络中的全双工半双工概念来理解就明白了,就是单纯一对多的关系
   2. 而Redis的应用就是文件事件了,一个Redis线程通过文件事件调度器来监听所有的Socket连接,一旦处理好了就读取所需的文件,在等待处理完毕的数据发来之前不阻塞线程.
3. 传统的搜索引擎是怎么实现搜索的？
   1. 以最典型的TF-IDF为例,就是根据该关键词在所有文档中出现概率的log倒数乘以该关键词在单个文档中出现的概率来排序就行了
   2. 这是靠倒排索引(Inverse Index)实现的,即不是计算单个文档中出现的所有词,而是计算某个词在哪几个文档中出现过
4. Redis 的基础数据类型以及底层实现原理了解吗？
5. B+ 树执行增、删、查、改的时间复杂度分别是多少？
   1. 插入/删除/查找/修改都需要定位到节点,所以复杂度完全相同,如果是m叉树,有N个节点,就是O(logN).
6. 为什么 MySQL / InnoDB 使用 B+ 树作为索引结构，而不是其他数据结构？
7. redis缓存和数据库,在更新/删除的时候,优先动哪个,具体是如何处理的
8. 假如我不想用代码的层面去同步缓存和数据库，有什么解决方案
9. 如何理解Redis中的Lua脚本的原子性
### 分布式算法
1. 介绍一下Raft和Paxos的异同,以及如今常用的分布式算法
2. 一致性哈希解决了哪些问题
3. CAP是什么?抖音刷视频，按照CAP理论，考虑应该满足哪几个特性?
   1. C-Consistency,A-Availability,P-Partition tolerance,俗称为不可能三角,任何分布式数据存储最多只能提供以上三个保证中的两个
   2. 对于短视频业务,我们必须保证Avalability,毕竟要给用户提供内容,而也需要保证分区容错性,因为机房和网络有可能会出现故障,而这会影响用户的即时访问,至于一致性则不太必要,用户也不在乎自己的点赞有没有迅速同步到主数据库,只要UI上有反应就可以了.

### 消息队列
1. 你认识哪些消息队列?分别的优缺点是什么?
### 设计思维
设计思维我认为是最容易被忽视,却是非常重要的考察点

1. 了解哪些设计思想,实践中用过吗?
   1. SOLID: 5跳面向对象软件设计原则的缩写,具体表格见下方.
   2. DDD: Domain-Driven Design,核心思想是围绕业务领域建模，而不是围绕数据库建模
   3. OOD: Object-Oriented Design,对象、封装、继承、多态,基本也只能在Java中广泛使用了
   4. SoC: Separation of Concerns,将不同职责分离
   5. TDD: Test-Driven Development,先写测试，再实现代码
   6. BDD: Behavior-Driven Development,从业务行为描述系统


| 字母 | 原则                            | 中文         | 核心问题                               |
| ---- | ------------------------------- | ------------ | -------------------------------------- |
| S    | Single Responsibility Principle | 单一职责原则 | 一个类为什么会变化？                   |
| O    | Open/Closed Principle           | 开闭原则     | 新功能能否通过扩展实现，而少改旧代码？ |
| L    | Liskov Substitution Principle   | 里氏替换原则 | 子类能否真正替代父类？                 |
| I    | Interface Segregation Principle | 接口隔离原则 | 是否强迫调用者依赖不需要的方法？       |
| D    | Dependency Inversion Principle  | 依赖倒置原则 | 业务代码是否依赖具体实现？             |


2. 设计模式你了解哪些?
3. 服务架构了解哪些?SOA和MSA的区别知道吗?EDA有真实用过吗?
4. MVC和MVVM在如今的优缺点?
### 架构设计
1. 假设让你设计一个 12306 购票系统，你会怎么设计它的整体架构？
   1. 非常开放,但最考验水平.首先假设或者问面试官从而确定用户规模和流量情况.不过抢票系统的规模肯定很大啦
   2. 抢票的重点在于高并发,大量用户争抢稀缺票源时如何保证一致性和有序性.
   3. 说是说架构,但实际上就是问数据库怎么设计,缓存用什么数据库?很明显要用Redis+限流器,不然根本扛不住.当用户请求路由时,如果接收过相同的请求且票源状态没有改变,则直接返回缓存.
   4. 重点在于,我们需要保证用户请求是按照时间顺序来处理的,所以就要加上一层消息队列.
   5. 用户规模这么大,自然还要加一个数据库分片,根据用户id来分就可以.
   6. 所以总的架构就是,后端连消息队列,消息队列连接Redis集群,Redis集群再连到具体的数据库如Oracle

不过这只是最基础的想法,考虑到查询量和交易量的不成比例,所以查询服务要单独处理:

```mermaid
flowchart TB
    subgraph ClientLayer[接入层]
        U[用户]
        CDN[CDN / DNS]
        GW[API Gateway]
        U --> CDN --> GW
    end

    subgraph ServiceLayer[业务服务层]
        Q[查询服务]
        US[用户服务]
        OS[订单服务]
    end

    subgraph QueryLayer[查询支撑]
        QR[Redis]
        QDB[查询数据库]
        Q --> QR --> QDB
    end

    subgraph OrderLayer[交易支撑]
        OR[Redis]
        MQ[消息队列 MQ]
        OS --> OR
        OS --> MQ
    end

    subgraph AsyncLayer[异步处理层]
        INV[库存服务]
        PAY[支付服务]
        NOTI[通知服务]
        MQ --> INV
        MQ --> PAY
        MQ --> NOTI
    end

    subgraph InventoryLayer[库存与座位层]
        IRDB[Redis + DB]
        SEAT[座位分配服务]
        INV --> IRDB --> SEAT
    end

    GW --> Q
    GW --> US
    GW --> OS
```

2. 在多节点的游戏服务器内如果需要为物品生成可以跨多节点识别的唯一 UUID，应该如何设计这个 UUID
   1. ...
3. Minecraft 这种游戏里可以把方块拼在一起，存储这些方块数据会带来很大的内存消耗，你可以用什么方法尽可能地减少（内存）消耗？
4. 如何设计一个扫码微信登录的系统？扫码之后，PC是怎么知道手机已经扫码的?如果多个同学同时打开微信客户端去扫码，又去各自用自己的手机扫，怎么知道具体哪个同学扫的是哪个码呢?
5. 假设系统中有数千万甚至上亿用户，每个用户都有一个不断变化的积分。现在需要实现一个实时排行榜，展示积分最高的前 100 名用户。请设计一个基于 Redis 的排行榜系统

### 手写SQL
1. 有一张表记录了玩家的所属省份和 PlayerID，请写一条 SQL 查询语句，统计每个省份的玩家数量
## 语言基础
### Golang
1. Golang 的默认参数传递方式以及哪些是引用传递？
   1. 最考验基础的一集,slice和map都是值传递的,没有引用传递,传递时是传递了一个复制的结构体数组,尽管指向数据存储区域的指针是一样的,但这只是单纯的复制传值而已.
   2. 所以在GO中,所有的参数都是值传递
### Python
1. Python多线程的几种实现方式?分别的适用场景是什么?
2. Python GC的基本原理
   1. 对于CPython来说,用到是引用计数,而循环引用则通过cyclic GC来追踪,通过可达性分析找到循环对象并回收

### C/CPP
1. C++的内存分区结构了解嘛,什么时候变量放在栈上,什么时候放在堆上?malloc 和 new 有什么区别？
   1. C++在运行时中,分为代码段(只读),数据段(全局和静态变量),堆(new分配)和栈(局部变量)
   2. 默认在栈上,除非用new和malloc分配.
   3. malloc返回的是void*,需要强制转换,没有构造函数,new返回具体类型的指针,并调用构造函数,内存安全.
2. 什么是虚函数?构造函数可以是虚函数吗?为什么多态时析构函数一般写成虚函数?
   1. 支持多态的成员函数,可以被子类覆盖
   2. 构造函数在对象创建时调用,而对象没创建时没有虚函数表,故不可能写成虚函数.
   3. 析构函数写成虚函数,那么就会先调用子类析构函数,再逐级调用基类析构函数,从而确保销毁所有资源.因为如果基类析构函数是 virtual，那么派生类析构函数会自动重写它。
## AI岗
### LLM相关
1. 请比较一下几种常见的 LLM 架构，例如 Encoder-Only, Decoder-Only, 和 Encoder-Decoder，并说明它们各自最擅长的任务类型。
2. 大模型的幻觉是怎么产生的？为什么会产生幻觉？
### Agent相关
1. 你做过知识库 / RAG，它的基本原理是什么？
2. 为什么用 RAG？现在上下文窗口这么大了，为什么不直接把原始文档全丢给 Agent 让它自己查？
3. 从原始文档到最终答案，切块、索引、存储、检索、排序，哪几步对效果影响最大？
4. 十篇以上文档，或者让它读一个很大的代码仓库，用 RAG 和让它自己 grep，不考虑 token 消耗的情况下，各有什么优劣？
5. 如果你的 Markdown 没有标题，怎么切？
6. 上下文超窗口，滑动窗口和动态摘要各自的坑。



# 面试要点
## 面试投递环节
### 简历编写
事实上,写简历是最能考验一个人的技术储备的环节,每当你摸不透自己的技术水平时,就去写个简历,立马就能对自己的无能而无地自容.

而写简历自然不可能用word去一个个敲,最好还是找个模板来直接复用就行了.
#### 简历模板

* [闻所未闻的动态简历](https://jirengu-inc.github.io/animating-resume/public/)

  * 这个模板让人耳目一新,但只适合前端工程师
* [可在线编辑的简历](https://visiky.github.io/resume/?template=template2&user=visiky)

  * 中规中矩,比较清晰,推荐使用
* [精美简历](https://github.com/salomonelli/best-resume-ever)

  * 需要专门去下载老版本的node才可以运行,根据issue和实测,至少大于18版本的node都不行
* [md格式简历](https://github.com/geekcompany/ResumeSample)

  * 没什么弯弯绕绕,也很好编辑
* [简历模板大集合](https://github.com/mmmlllnnn/ResumeCollection)

  * 如果都不满意,就来这里找适合自己的

写简历最难的地方就是找自己的优点了,我们需要通过一种实在的角度来夸自己,不过分包装,但要让自己显得很专业很厉害,需要一点语言上的基本功.

#### 简历之外

有时候,公司的简历提交网站上除了提交简历之外还要你填写其他的内容:
![示意图](PixPin_2026-05-06_18-25-29.webp)

所以我们需要将简历上没写的一些不是很重要的补充信息填上去,帮助面试官加深印象.

### 内推码

在有了简历之后,我们就可以去对应公司的官网投递了,由于内地公司盛行内推码(真不知道最早是哪个**小可爱**想出来的),所以你需要先去小红书/微信上搜索对应公司的内推码,一般直接搜就会有最新的内推码了,直接用就可以.

* 当然有认识的学长学姐更好,但正常来说不会这么凑巧吧...

## 准备面试

不管怎样,投递了简历之后就要开始准备面试了,面试中的问题大致有四种:

1. 算法题
2. 技术题
   1. 通常会拷打你简历上自己写的项目,所以不要吹过头了
3. 生活相关的提问
   1. 拖时长用的
4. 反问环节
   1. 拖时长用的
## 陷阱-面评
需要注意的是,每一轮面试结束后，面试官不是只点“通过/不通过”，还会在公司招聘系统（ATS）里留下结构化评分和文字评价.

>面试官在评价你的简历的时候是可以看得到你投递了别的岗位的，也可以看到别的面试官对你的简历评价的，你仔细想想，本来一个面试官想给你面试机会的，但一看下面有个面试官的评价“资历平平，简历毫无亮点”，多多少少还是会受到影响。正确的做法应该是：选择与自己适配度的两三个岗位，数量不宜多，把最适合自己的优先投递。 

## 算法题

刷题是面试的必备环节,尽管这些算法你以后再也不会在项目中用到,但还是需要你背得滚瓜烂熟.

至于为什么要考算法题,我之前看到有个人说的很好: **企业不敢招连算法题都不会的人**.

这本质上是一场服从性测试,如果你面试前连算法都不愿意去刷的话,你又怎么愿意为了这个公司付出更大的努力呢.

而由于面试的算法题跟竞赛题比起来简直是小儿科,因此基本只要**一个月每天刷个10道题**就可以秒杀所有的面试题了.如果你不满足于刷题的话,可以去看洛谷的**深入浅出系列**,并跟着题单来刷,保证可以快速入门算法.

## 反问环节

* 可参考GitHub仓库: reverse-interview-zh

**"你有什么想问的吗?"**,这个问题基本是面试的收尾必备环节,到了这一步你的表现其实已经不大重要了,毕竟该暴露的都已经暴露了...所以情商不要太低就行,随便问点问题水过去.

尽管如此,工程师一般都是心地淳朴(~~呆头呆脑~~)的人,所以有人特定总结了一点反问用的语句(根据上面的仓库总结):

### 职责

* 我的日常工作是什么？
* 有给我设定的特定目标吗？
* 团队里面初级和高级工程师的比例是多少？（有计划改变吗）
* 入职培训 (onboarding) 会是什么样的？

### 技术

* 公司常用的技术栈是什么？
* 你们怎么使用源码控制系统？
* 你们怎么测试代码？

### 团队

* 工作是怎么组织的？
* 团队内 / 团队间的交流通常是怎样的？
* 你们使用什么工具来做项目组织？你的实际体会是什么？
* 如果遇到不同的意见怎样处理？
* 不同的意见如何处理？
* 如果被退回了会怎样？（“这个在预计的时间内做不完”）
* 当团队有压力并且在超负荷工作的时候怎么处理？
* 如果有人注意到了在流程或者技术等其他方面又改进的地方，怎么办？

# 公司与岗位调研
## 岗位调研

### 岗位术语
**每家公司**都有自己独特的术语,相同岗位的名字可能大不相同,我们列举~~几个~~一堆常见的术语,从而能够在看到某一个岗位名字的时候能够快速定位:

- Software Engineer(SWE): **最通用**的称呼,无论什么技术岗位都可以叫做是软件工程师,因此必须要看招聘的具体要求才好判断到底是什么岗位.
- Software Dev Engineer(SDE): **软件开发工程师**,如名字所说是负责软件开发的,至于是负责哪一部分还是要看招聘情况的
- Operations(Ops): 简称**运维**,维护系统,负责产品部署和监控
- Infrastructure(Infra): 负责搭建底层工具链,需要精通底层语言和硬件原理
- Architect: 这就是我们俗称的**架构师**,一般来说架构师都是在其他岗位历练后转调过来的,不太可能让一个实习生去架构吧.
- Site Reliability Engineering(SRE): 最早由Google提出,主要责任是管理大规模集群网络,解决系统故障,相当于**高级运维**
- **[DevOps](https://en.wikipedia.org/wiki/DevOps)**: 这名字谁第一次看了不迷糊,不管怎样,该岗位的职责如名字所说是**开发 (Dev) + 运维 (Ops)**,需要能够一边开发软件一边负责部署上线,一看就是事最多的岗位.



### 什么技术需求大
我们用两个案例来分析,一个是需求庞大的字节招聘官网,一个是阮一峰的weekly谁在招人issue集.
#### 字节招聘
搜索python:
![示意图](PixPin_2026-04-25_22-03-51.webp)
搜索Java:
![示意图](PixPin_2026-04-25_22-04-16.webp)
搜索cpp:
![示意图](PixPin_2026-04-25_22-04-31.webp)
搜索Go:
![示意图](PixPin_2026-04-25_22-04-55.webp)
搜索rust:
![示意图](PixPin_2026-04-25_23-04-28.webp)
搜索前端:
![示意图](PixPin_2026-04-25_23-05-06.webp)
搜索Redis:
![示意图](PixPin_2026-04-25_22-05-42.webp)
搜索MySQL:
![示意图](PixPin_2026-04-25_22-05-58.webp)
搜索PostgreSQL:
![示意图](PixPin_2026-04-25_22-06-30.webp)


#### 谁在招人issue
- 我爬取了从2023-01-01至今天的issues
搜索python:
![示意图](PixPin_2026-04-25_22-21-53.webp)
搜索Java:
![示意图](PixPin_2026-04-25_22-50-22.webp)
搜索go:
![示意图](PixPin_2026-04-25_22-59-55.webp)
![示意图](PixPin_2026-04-25_23-00-06.webp)
搜索cpp:
![示意图](PixPin_2026-04-25_23-00-59.webp)
搜索rust:
![示意图](PixPin_2026-04-25_23-01-13.webp)
搜索前端:
![示意图](PixPin_2026-04-25_23-00-40.webp)
搜索kuber:
![示意图](PixPin_2026-04-25_23-05-24.webp)


#### 总结
1. 前端的缺口依然很大,需求很多.
2. 后端里cpp/Java/Go/python必须要精通一门




### 大杀器: AI面试(8/14)
在AI如此强大的当下,抛出自己要面试的岗位,AI就可以直接生成强相关的常见面试题,来拷打你的技术水平是否适合这个岗位,不得不说,效果很好!

![GPT测试](PixPin_2026-08-14_13-48-33.webp)


### 招聘要求
从几家公司的招聘要求中提取共性,从而得到稍微通用一点的招聘要求,话是这么说,每个面试官的个性都有所不同,就算考察范围相同,问的问题也可能完全不同,只能随机应变了.

#### Tencent校招
1. [Agent开发](https://join.qq.com/post_detail.html?postid=1282707395466077184)
   1. 熟练掌握至少一门主流编程语言（Python/TypeScript/Go 等）
   2. 深入理解Agent原理与架构，包括 Planning、Memory、Tool Use、Reflection等核心机制
   3. 熟悉主流Agent开发框架（如 LangGraph、AutoGen、CrewAI、MetaGPT 等），有实际搭建经验
   4. 了解大模型基本原理，熟悉Prompt Engineering技巧，能设计高质量的系统提示词与工具描述
   5. 对AI Agent技术有强烈兴趣，关注行业动态，具备独立调研与技术选型能力
   6. 具备良好的系统思维和问题解决能力，能在复杂场景中设计可靠的Agent方案
   7. 已经是非常基础的要求了
2. [Agent全栈工程师/实习](https://join.qq.com/post_detail.html?postid=1282707398326592512)
   1. 熟练掌握主流前后端技术栈，具备扎实的计算机基础知识和全栈工程能力，能够完成需求分析、方案设计、开发交付及迭代优化的完整流程
   2. 了解大模型基本原理与推理部署方式，熟悉RAG技术、Agent原理（包括 Tool Use、Planning、Memory 等），有相关实践经验
   3. 具备系统设计能力，了解分布式系统、微服务架构、消息队列、缓存等后端核心技术；
   4. 这许愿吧,光第一条就能筛掉百分之九十九点九的应届生了,再加上第三条,基本就是最顶尖的要求了,必然有ssp的,至于我自己再修炼一年也远远够不上吧
3. [后台开发/实习](https://join.qq.com/post_detail.html?postid=1282707383965295616)
   1. 扎实的编程能力，熟练掌握C/C++/Java/Go等其中一门开发语言；
   2. TCP/UDP网络协议及相关编程、进程间通讯编程；专业软件知识，包括算法、操作系统、软件工程、设计模式、数据结构、数据库系统、网络安全等。
   3. 有一定了解的：Python、Shell等脚本语言；MySQL及SQL语言、编程；NoSQL, Key-value存储原理。
   4. 第二个要求看上去简单实际上非常难,说了是专业软件知识,那么一定需要相当深入,至少Unix网络编程要滚瓜烂熟
4. [推荐算法实习](https://join.qq.com/post_detail.html?postid=1211674462290972672)
   1. 扎实的编程能力和算法功底，熟练掌握Python/C++/Java等至少一种编程语言
   2. 扎实的机器学习/深度学习理论基础，熟练掌握Tensorflow/Pytorch等至少一种主流深度学习框架，了解 Hadoop/Spark/Flink等大数据平台工具的使用；
   3. 大数据加深度学习框架,似乎不是很难
5. 
#### Tencent社招
1. 微信秒剪-大模型后端研发工程师
   1. 熟练掌握 C++、Go 等至少一种编程语言，具备扎实的数据结构、算法和系统设计基础；
   2. 了解 LLM、VLM、扩散模型或 Agent 等相关技术；至少具备一种模型的应用、推理部署或工程化落地经验；
   3. 具备后台服务开发经验，熟悉 MySQL、Redis、Pulsar/Kafka 等常用基础组件；
   4. 了解分布式系统、高并发服务、流式数据处理或模型服务架构，具备基本的性能分析和故障排查能力；
   5. 具备良好的工程素养，重视代码质量、自动化测试、可观测性和持续交付，能够熟练使用 AI Coding 工具提升研发效率；
   6. 不好意思,但我觉得要求甚至没有应届生高好不好
2. 微信小店-后台开发工程师-交易基础(商品方向)
   1. 熟悉C/C++编译类语言, 有2年或以上服务端开发经验；
   2. 有电商业务开发经验者优先；
   3. 有海量服务开发、网络通信优化、计算性能优化经验者优先；
   4. 有类OI/ACM-ICPC竞赛背景优先；
   5. 看得出来就业行情很不好了,最后一个是专门用来卡人的
3. 企业智能体(五年以上工作经验)
   - 计算机相关专业本科及以上学历，3 年以上全栈开发经验，主导过复杂系统的全生命周期研发；
   - 熟悉分布式系统设计，掌握微服务、容器化、CI/CD 等工程实践，有高并发、多租户或私有化交付场景的优化经验者优先；
   - 具备出色的技术方案规划能力，能输出符合 Clean Architecture / Domain-Driven Design 原则的设计文档；
   - 有 Agent 开发经验，熟悉 Agent 架构设计、Prompt 工程、RAG 应用、大模型推理服务化等 AI 工程化流程，具备智能体编排与工具链集成能力者优先；
   - 有 To B 产品、企业级 SaaS / PaaS /私有化部署交付相关经验者优先；
   - 有沙箱隔离与 Agent Runtime 相关架构经验，有容器沙箱、安全隔离执行环境、Runtime 生命周期管理等实践经验者优先；
   - 善用AI 提升生产力， 能高效驾驭AI Coding编程范式, 在 spec / context / harness 层面有方法论；
   - 用来看Agent岗的进化路径很合适呢
4. 微信支付-全栈开发工程师
   1. 本科及以上学历，计算机科学、软件工程、人工智能等相关专业，1年及以上互联网或金融科技行业研发经验；
   2. 熟练掌握Go、Python、Node.js等至少一门后台开发语言，并对相关框架原理有深入理解；
   3. 了解大模型相关技术生态，具备大模型应用落地（如Prompt Engineering、RAG、Agent开发）的实践经验或浓厚兴趣；
   4. 追求极致的系统稳定性和用户体验，具备良好的逻辑思维、风险意识和编码规范。善于沟通、主动思考，具备优秀的团队合作和抗压能力；
   5. 有AIOps、智能运维平台或大数据处理相关项目经验、熟悉业界主流的大模型推理优化及部署技术者优先。

实际来说,要求越少的岗位越不推荐,道理很明显啊,要求越少的话符合要求的人就越多,那你不就是一个可以被随时替代的存在吗.

#### 字节校招
1. 大语言模型算法工程师（交互智能方向） - Seed大模型人才校招
   1. 2027届获得本科及以上学历，计算机、数学、统计等相关专业；
   2. 对Human-AI Interaction的前沿趋势有深刻洞察，具有好奇心与快速学习能力；拥有扎实的数学功底和机器学习理论基础；
   3. 卓越的工程落地能力，代码功底扎实，具备系统级思考与架构级问题解决能力；
   4. 坦诚清晰的沟通表达，能高效推进跨团队、跨职能的技术协作；
   5. 具备超大规模LLM的训练、RL的硬核实战经验；
   6. 在Interactive RL, Multi-Agent Systems, 或模型对齐（Alignment）领域有深入研究（在NeurIPS, ICLR, ACL, CHI等顶会有相关一作论文者优先）；
   7. 在博弈论（Game Theory）或机制设计（Mechanism Design）领域有系统性的学术积累；
   8. 有交互智能或生成式智能体（Generative Agents）方向的成功落地项目经历。
   9. 说是本科生以上啦,但不是博士生不太可能有这么NB吧
2. 大语言模型Agent算法工程师-Seed大模型人才校招
   1. 2027届获得本科及以上学历，计算机、数学、统计等相关专业；
   2. 熟悉NLP或者RL相关的算法和技术，在相关领域有过良好研究记录者优先；优秀的代码能力、数据结构和基础算法功底，熟练使用PyTorch/TensorFlow/JAX等任一深度学习框架；拥有扎实的数学功底和机器学习理论基础；
   3. 在大模型领域，主导过有影响力的项目或论文者优先，尤其是Agent相关者优先；
   4. 结论很明显了,字节这是真心在招人,愿意下功夫去招大模型基座方面的人才,做点真东西出来.
3. AI全栈开发工程师 - 豆包
   1. 2027届获得本科及以上学历，计算机、软件工程、人工智能等相关专业优先；
   2. 熟悉浏览器或桌面客户端基本原理；熟悉Vite、Webpack、pnpm等现代工程化工具，具备良好的代码质量、测试、性能和安全意识；
   3. 有自己独立完成的AI项目实践，能够调用模型能力解决真实问题，而不局限于Demo开发；
   4. 对AI技术保持好奇，善于使用AI编程工具提升研发效率，具备较强的学习能力、责任心和协作意识。
   5. 要求实际上比腾讯要低很多,所以可以认为依然是搞一些Demo开发而已,不是重要岗位
4. AI开发工程师 - 抖音研发中台
   1. 2027届获得本科及以上学历，计算机、软件工程等相关专业优先；
   2. 对AI技术有热情，熟悉大语言模型（LLM）的底层原理，有Prompt调优、微调（SFT/LoRA）、RAG系统搭建或Agent框架开发经验优先；
   3. 具备扎实的算法与数据结构基础，至少精通一门主流编程语言（如Python/Go/Java/C++），具备良好的工程编码习惯；
   4. 基本来说,没什么要求
5. 全栈开发工程师（生活服务-治理平台） - TikTok研发
   1. 具备良好的沟通协作能力、自驱力和学习能力，能够使用AI Coding工具端到端推进需求迭代，覆盖从需求理解、方案设计、代码实现、测试验证、Code Review和线上排障的AI Native的开发方式；具备良好的主人翁意识，能够主动识别问题并推动解决；
   2. 具备AI全栈思维，愿意借助AI能力完成从页面到接口的全链路开发，相信AI能够帮助抹平技术栈差异；具备根据工作和业务需要设计Agent Workflow的能力；
   3. 具备良好的业务理解和抽象能力，能够在复杂、信息不完整的场景中主动构造上下文、拆解问题并推动端到端闭环；重视工程质量，对可维护性、性能、稳定性、可观测性、测试及上线风险有系统性认识；
   4. 具备扎实的计算机基础知识（数据结构、算法、计算机网络、操作系统等），至少掌握一门编程语言；具备前端（JS/TS/Vue/React等）、客户端（Flutter/iOS/Android任一）、服务端（Golang/Python/Java任一）任一领域的开发经验，有全栈开发经验者优先；具备良好的接口设计、数据建模和系统设计能力。
   5. 第二个要求有点招笑了,很明显这个岗位有可能来自一个不是很懂技术的Head带的组,想必会比较push吧
6. 后端开发工程师（架构方向） - TikTok内容安全平台
   1. 热爱计算机科学和技术，精通至少一门编程语言，包括但不仅限于：Java、C、C++、PHP、Python、Go；
   2. 掌握扎实的计算机基础知识，深入理解数据结构、算法和操作系统知识；
   3. 有优秀的逻辑分析能力，能够对业务逻辑进行合理的抽象和拆分；
   4. 你越不提要求我越心慌
7. Agent开发工程师（泛架构） - TikTok研发
   1. 熟悉Python/Go/Java/C++中至少一种编程语言，具备扎实的工程开发能力；
   2. 熟悉LLM应用开发，有RAG、Agent、Prompt Engineering、Function Calling、Workflow编排等实践经验者优先；
   3. 具备较强的数据处理和分析能力，熟悉SQL，能从复杂业务数据中抽象问题并形成解决方案；
   4. 具备良好的系统设计能力，能够设计稳定、可扩展、可观测的AI应用服务；对基础设施资源管理、云计算、GPU资源、容量规划、成本优化等方向有经验或兴趣；
   5. 具备较强的业务理解能力和沟通协作能力，能够在不确定场景下推动问题闭环；具备主动学习能力，能快速跟进AI Agent相关技术发展，并转化为实际业务价值。
   6. 越看越爱,简直是冲着我来的,但可惜我的实力远远不够


其实可以说,字节的很多校招岗位都是单纯的耗材而已,并不是冲着真心培养人来的,尽管这对大公司来说是很合理的做法,但还是很寒心呢.唯一的破局之法就是撞入核心事业群的核心开发岗,但难度也确实很高.

一个简单的判断条件就是招聘要求了,招聘要求越详细,工作内容(JD)越清晰,那么这个岗位在一定程度上就越重要.




#### 调研结果
事情其实很简单,AI的力量远没有我们以为的那么大,你自己的实力也远没有以为的那么好,所以不要轻易报全栈岗,根据招聘要求来看,大多数都只是玩具岗而已,之后应该会借机把你转到哪个角落去吧.

要提升自己,就老老实实选择单一的岗位

在了解了可以面试哪些岗位之后,就可以根据自己想去的岗位来投递自己的意向公司了,但是参加面试之前总得对自己要面试的公司有个了解吧,因此我在这里介绍了一些常见的大型互联网公司.

我们对于一家公司的调研主要分为以下五步:
1. 公司概况: 快速了解这家公司
2. 公司历史: 公司的发展历史
3. 主要产品: 该公司的优秀产品
4. 招聘情况: 内地应聘的条件和要求

其中1,2,3部分主要由AI从wiki总结生成,毕竟这种没太多乾坤的东西靠我自己来翻译还是太累了.
## 国际企业
该类企业有以下优缺点:
1. 工资较高,福利好,无996
2. 应试要求低,但一般都要求英语好
3. 晋升难
4. 难外调(relocate)
5. **招聘岗位少**,竞争激烈,大牛多

由于招聘岗位少,招聘情况部分就不贴具体岗位分析了,只写一点吐槽.
### Microsoft (微软)
- 多少人梦寐以求的头部外企啊
#### 公司概况
微软发迹于为早期的 Altair 8800 提供 BASIC 解释器，凭借 MS-DOS 和 Windows 确立了在个人电脑操作系统市场的垄断地位；其核心业务由 Windows 操作系统、Office 生产力套件、Azure 云平台以及 Xbox 游戏生态组成，通过收购 LinkedIn、Skype 和动视暴雪等企业实现多元化，目前是全球收入最高的软件公司。
- 操作系统市场的垄断地位是微软最可怕的地方

#### 公司历史

\- 1975—1980｜创业与编程语言：比尔·盖茨（Bill Gates）与保罗·艾伦（Paul Allen）于1975年创立 Microsoft，为 Altair 8800 开发 BASIC 解释器。公司早期依靠编程语言授权经营，并逐渐形成向硬件厂商销售软件的商业模式。

\- 1981—1999｜建立 PC 软件霸权：1981年为 IBM PC 提供 MS-DOS，1985年推出 Windows，1986年上市。随后通过 Windows 3.0、Windows 95 和 Office 建立操作系统与办公软件生态。1990年代中后期进入互联网市场，推出 Internet Explorer，并面临美国反垄断调查。

\- 2000—2013｜企业软件、游戏与云计算：史蒂夫·鲍尔默（Steve Ballmer）于2000年接任 CEO。微软扩展 Windows Server、SQL Server、Visual Studio 和 .NET，2001年通过 Xbox 进入游戏主机市场，随后推出 Bing、Windows Phone 和 Surface。2008年公布 Windows Azure，2010年正式商用，2011年推出 Office 365，逐渐向云服务与订阅业务转型。

\- 2014—2018｜云优先与开放生态：萨提亚·纳德拉（Satya Nadella）于2014年接任 CEO，推动 Azure、Microsoft 365、跨平台开发及开源技术发展。期间收购 Mojang（2014）、LinkedIn（2016）和 GitHub（2018），同时加强对 Linux、容器和开发者工具生态的支持。

\- 2019—2026｜人工智能与大型平台整合：2019年开始与 OpenAI 建立战略投资及技术合作关系；2022年收购语音识别企业 Nuance，2023年完成对 Activision Blizzard 的收购，并推出 Microsoft 365 Copilot。此后持续扩大 AI 模型服务、数据中心、算力基础设施及智能体产品布局。




#### 控股公司及子公司

集团主体：Microsoft Corporation（微软公司）

- 总部位于美国华盛顿州雷德蒙德，纳斯达克上市（MSFT）。
- 微软本身是集团顶层上市公司，没有另一家企业作为其控股母公司。
- 按2026财年年报，集团业务分为生产力与业务流程（Productivity and Business Processes）、智能云（Intelligent Cloud）、更多个人计算（More Personal Computing）三个报告分部。

主要子公司及收购业务：

- LinkedIn Corporation（领英）：2016年完成收购，经营职业社交、招聘、商业营销、LinkedIn Learning 等业务。
- GitHub：2018年完成收购，经营代码托管、开源协作、GitHub Actions、GitHub Copilot 等开发者服务。
- Mojang Studios：2014年被微软收购，以《Minecraft》（我的世界）及其衍生产品为核心。
- ZeniMax Media：2021年完成收购，旗下包括 Bethesda Softworks、Bethesda Game Studios、id Software 等游戏发行与开发业务，拥有《The Elder Scrolls》《Fallout》《DOOM》等系列。
- Activision Blizzard, Inc.（动视暴雪）：2023年完成收购，主要业务包括 Activision、Blizzard Entertainment、King，涉及《Call of Duty》《Warcraft》《Diablo》《Candy Crush》等系列。
- Nuance Communications：2022年完成收购，主营语音识别、医疗文档自动化和行业 AI，其医疗业务已整合进入微软健康及生命科学云服务体系。


#### 主要产品

- Windows 操作系统：Windows 11、Windows Server、Windows 365，覆盖个人电脑、服务器和云桌面。
- Microsoft 365 / Office 办公软件：Word、Excel、PowerPoint、Outlook、Teams、OneDrive、SharePoint。
- Azure 云计算平台：Azure Virtual Machines、Azure Kubernetes Service、Azure SQL、Azure AI Foundry，覆盖计算、存储、数据库、容器及 AI 开发。
- Copilot 人工智能系列：Microsoft Copilot、Microsoft 365 Copilot、Copilot Studio、GitHub Copilot。
- 开发者工具与平台：Visual Studio、Visual Studio Code、.NET、GitHub、GitHub Actions、NuGet。
- 企业管理与数据平台：Dynamics 365、SQL Server、Microsoft Fabric、Power BI、Power Apps、Power Automate。
- 网络安全与 IT 管理：Microsoft Defender、Microsoft Entra、Microsoft Intune、Microsoft Purview、Microsoft Sentinel。
- 互联网与搜索：Microsoft Edge、Bing、Microsoft News。
- Surface 硬件系列：Surface Pro、Surface Laptop 等个人及企业计算设备。
- Xbox 游戏与内容：Xbox 主机、Xbox Game Pass、Xbox Cloud Gaming，以及 Minecraft、Halo、Forza、Call of Duty、Warcraft、Diablo 等游戏系列。
- 职业服务与医疗 AI：LinkedIn、LinkedIn Learning、Microsoft Dragon Copilot 等。


#### 招聘情况
- [招聘官网](https://apply.careers.microsoft.com/)
- 公众号: 微软招聘
  
![示意图](PixPin_2026-04-25_11-25-18.webp)
官网的岗位很多对吧,但如果你把地点更改一下的话:
![示意图](PixPin_2026-04-25_11-24-29.webp)
行了,都知道你不想在中国招人了.

##### 面经1
[链接](https://stdrc.cc/post/2022/01/30/microsoft-interview/)
尽管是22年的实习面经,但问题确实很简单,看得出来微软是不喜欢刁难实习生的...
##### 面经2
[链接](https://ddadaal.me/articles/2019-spring-ms-intern-interview-experiences/cn)
19年的实习面经,面试题也都不难
### Google (谷歌)
#### 公司概况
Google 由拉里·佩奇和谢尔盖·布林于 1998 年创立，凭借核心产品 Google 搜索确立了全球信息索引的统治地位，并于 2015 年重组为 Alphabet Inc. 的最大子公司。其业务版图深度覆盖在线广告、云计算（Google Cloud）、操作系统（Android、ChromeOS）、视频共享（YouTube）及消费电子（Pixel、Nest），并在量子计算、自动驾驶（Waymo）和人工智能（Gemini）等前沿领域处于领先。作为全球访问量最大的网站拥有者，Google 在搜索引擎、移动生态和生产力工具市场占据绝对优势，同时也面临着关于垄断、隐私及税务问题的持续监管与争议。
##### Google与Alphabet
Alphabet 是 Google 的母公司，两者于 2015 年通过企业架构重组确立了控股关系：Alphabet 作为顶层控股实体，将盈利核心 Google（含搜索、YouTube、Android）与风险高、投入大的“登月计划”子公司（如 Waymo 自动驾驶、Calico 生物技术）剥离。这一变革的历史缘由在于，当时的 Google 已从单一搜索工具扩张至机器人、生命科学等极度分散的领域，创始人拉里·佩奇希望通过这种“瘦身”结构提高财务透明度，使各业务在拥有独立 CEO 和预算的同时，能更灵活地追求长远创新，而不受核心搜索业务财务波动的束缚。

#### 公司历史

\- 1996—2000｜创立与搜索引擎商业化：拉里·佩奇（Larry Page）与谢尔盖·布林（Sergey Brin）在斯坦福大学开发 BackRub 搜索引擎，利用 PageRank 算法根据网页之间的链接关系评估其重要性。1998年正式创立 Google，名称源自数学术语 Googol（10的100次方）。2000年推出 AdWords 搜索广告系统，逐渐形成以免费搜索服务吸引用户、通过互联网广告盈利的商业模式。

\- 2001—2007｜互联网服务生态扩张：埃里克·施密特（Eric Schmidt）于2001年担任 CEO，Google 陆续推出 Google News、Gmail（2004）、Google Maps（2005）、Google Earth（2005）等服务，2004年在纳斯达克上市。2005年收购 Android，2006年收购 YouTube，2007年宣布收购 DoubleClick，逐渐发展为覆盖搜索、广告、地图、视频和移动互联网的平台企业。

\- 2008—2014｜移动互联网与云计算：2008年推出 Chrome 浏览器、Android 商用平台及 Google App Engine，随后发展 Google Cloud Platform、Google Play、ChromeOS 等产品。2011年拉里·佩奇重新担任 CEO；2012年完成收购 Motorola Mobility，并于2014年出售其手机业务。同期收购 Waze（2013）、Nest Labs（2014）和 DeepMind（2014），开始向智能家居、人工智能及前沿科技拓展。

\- 2015—2019｜Alphabet 重组与 AI 优先战略：2015年成立 Alphabet Inc. 作为母公司，Google 成为其全资子公司，桑达尔·皮查伊（Sundar Pichai）接任 Google CEO。Alphabet 将自动驾驶、生命科学等实验性业务从 Google 核心业务中分离。2015年 Google 开源 TensorFlow，2016年 AlphaGo 击败李世石，同年推出 Pixel 手机、Google Assistant 和自研 TPU 加速芯片，推动 AI 优先战略。2019年皮查伊同时出任 Alphabet CEO。

\- 2020—2023｜云服务扩张与生成式 AI：2020年完成收购 Looker，2021年完成对 Fitbit 的收购，2022年收购 Mandiant，扩展 Google Cloud 的数据分析、安全和企业服务能力。2023年将 DeepMind 与 Google Brain 整合为 Google DeepMind，推出 Bard 聊天机器人和 Gemini 大模型，全面参与生成式人工智能竞争。

\- 2024—2026｜Gemini 生态与 AI 基础设施：2024年将 Bard 更名为 Gemini，将生成式 AI 融入搜索、Workspace、Android 和云服务，并推出 AI Overviews。2025年进一步发展 Gemini 模型、AI Mode、智能体和 AI 编程工具。2026年完成对云安全企业 Wiz 的收购，将工业机器人软件公司 Intrinsic 整合进入 Google，并持续投入 TPU、数据中心、Google Cloud 和 Gemini Enterprise。

#### 控股公司及子公司

集团主体：Alphabet Inc.（字母表公司）

- 总部位于美国加利福尼亚州山景城，纳斯达克上市（GOOGL、GOOG），于2015年通过公司重组成为 Google 的母公司。
- Alphabet 是集团顶层上市公司，Google LLC 是其全资子公司。联合创始人拉里·佩奇与谢尔盖·布林通过拥有较高表决权的 B 类股票保持对集团的控制性影响力。
- 集团主要分为 Google Services（谷歌服务）、Google Cloud（谷歌云）和 Other Bets（其他创新业务）三个报告分部。

Google 旗下主要子公司及收购业务：

- YouTube：2006年完成收购，经营视频分享、广告、流媒体订阅及内容创作者服务，主要产品包括 YouTube Premium、YouTube Music、YouTube TV。
- Android：2005年收购 Android Inc.，随后发展为全球主要的移动操作系统及应用生态之一，目前作为 Google 内部平台业务运营。
- Google DeepMind：2014年收购 DeepMind，2023年与 Google Brain 整合，负责 Gemini、AlphaFold 等人工智能模型及前沿研究。
- Waze：2013年完成收购，提供基于用户实时交通信息的导航服务。
- Nest Labs / Google Nest：2014年完成收购，主要经营智能家居设备及相关软件，现已整合进入 Google 硬件业务。
- Fitbit：2021年完成收购，主营运动健康追踪设备、可穿戴技术及健康管理服务。
- Looker：2020年完成收购，主要经营商业智能、数据分析和可视化平台，现属于 Google Cloud 产品体系。
- Mandiant：2022年完成收购，专业从事网络威胁情报、事件响应和企业网络安全服务，现属于 Google Cloud。
- Wiz：2026年完成收购，主营多云环境与 AI 安全管理平台，加入 Google Cloud。
- Intrinsic：2021年从 Alphabet 的 X 项目发展为独立业务，2026年整合进入 Google，主要开发工业机器人软件与智能自动化平台。

Alphabet 旗下其他主要控股业务：

- Waymo：2016年从 Google 自动驾驶汽车项目独立，专注自动驾驶技术与无人驾驶出租车服务，主要产品为 Waymo Driver、Waymo One。
- Wing：由 Google X 孵化，2018年成为 Alphabet 独立业务，主营无人机物流配送和自动化技术。
- Calico：2013年成立的生物技术公司，专注人类衰老机制、长寿科学及相关疾病治疗研究。
- Isomorphic Labs：2021年成立，利用深度学习、蛋白质结构预测和生成式 AI 开展药物研发。
- X（The Moonshot Factory）：Alphabet 旗下前沿技术研发机构，负责孵化高风险、长期性科技项目。
- GV（原 Google Ventures）：集团旗下风险投资机构，主要投资科技、生命科学及创业公司。
- CapitalG：Alphabet 旗下成长型投资机构，重点投资发展阶段较成熟的科技企业。

其他重要股权关系：

- Verily：原 Alphabet 生命科学子公司，专注精准医疗、生命科学数据及健康技术。2026年融资后，Alphabet 降为重要少数股东。
- GFiber（原 Google Fiber）：经营高速光纤宽带服务。2026年宣布与 Stonepeak 旗下 Astound Broadband 达成合并协议，完成后 Alphabet 预计持有49.99%股权。
- Google LLC、XXVI Holdings Inc.、Alphabet Capital US LLC：均属于 Alphabet 披露的重要法律实体，其中后两者主要承担集团控股及资本管理相关职能。

#### 主要产品

- Google Search 搜索服务：Google Search、AI Mode、AI Overviews、Google Lens、Google News、Google Scholar、Google Trends，提供通用搜索、智能搜索、学术检索和新闻聚合。
- Google Ads 广告与营销：Google Ads、Google AdSense、Google Ad Manager、Google AdMob、Google Analytics、Google Marketing Platform、Google Merchant Center。
- Android 移动操作系统：Android、Android Auto、Android TV、Wear OS、Google Play、Google Play Games、Google Play Protect。
- Chrome 与 ChromeOS：Google Chrome、Chromium、ChromeOS、Chrome Enterprise、Chromebook，覆盖网页浏览器、操作系统和企业终端管理。
- Google Workspace 办公协作：Gmail、Google Drive、Google Docs、Google Sheets、Google Slides、Google Forms、Google Calendar、Google Meet、Google Chat、Google Keep、Google Sites。
- Google Cloud 云计算平台：Compute Engine、Google Kubernetes Engine（GKE）、Cloud Run、Cloud Storage、Cloud SQL、BigQuery、Spanner、Vertex AI。
- Gemini 人工智能系列：Gemini、Gemini Live、Google AI Studio、Gemini API、Gemini Enterprise、Gemini for Google Workspace、Gemma 开放模型。
- Google DeepMind 模型与技术：Gemini、AlphaFold、Veo、Imagen、Lyria，以及相关 AI 研究和模型开发技术。
- Google Labs 创新工具：NotebookLM、Google Flow、Stitch 等 AI 研究、创作与设计工具。
- Google 开发者生态：Firebase、Flutter、TensorFlow、JAX、Google Colab、Kaggle、Google Maps Platform、Android Studio。
- Google Maps 地图与地理信息：Google Maps、Google Earth、Google Street View、Waze、Google Maps Platform、Google Flights。
- YouTube 视频与流媒体：YouTube、YouTube Premium、YouTube Music、YouTube TV、YouTube Kids、YouTube Studio、YouTube Shorts。
- Google Pixel 硬件系列：Pixel 手机、Pixel Pro 系列、Pixel Fold 折叠屏、Pixel Tablet、Pixel Watch、Pixel Buds。
- Google Nest 智能家居：Nest 智能音箱、Nest Hub、Nest Cam、Nest Doorbell、Nest Thermostat、Google Home。
- Google Photos 与消费服务：Google Photos、Google One、Google Wallet、Google Pay、Google Translate、Google Shopping、Google Family Link。
- Google 企业安全产品：Google Security Operations、Security Command Center、Google Threat Intelligence、Mandiant、Wiz。
- Alphabet 前沿科技产品：Waymo One（无人驾驶出行）、Waymo Driver（自动驾驶系统）、Wing（无人机配送）、Isomorphic Labs（AI 药物研发）、Intrinsic（工业机器人软件，2026年并入 Google）。
#### 招聘情况
- [招聘官网](https://www.google.com/about/careers/applications/)
- 公众号: 谷歌招聘包打听

之所以内地很少看见有人应聘谷歌是因为它在内地的岗位确实少,而且产品人员招的比技术人员多...
![示意图](PixPin_2026-04-25_11-41-45.webp)
![示意图](PixPin_2026-04-25_11-42-11.webp)

##### 面经1
[大牛的上岸分享](https://zhuanlan.zhihu.com/p/362736343)
### Apple (苹果)
#### 公司概况
Apple Inc. 由史蒂夫·乔布斯、斯蒂夫·沃兹尼亚克和罗纳德·韦恩于 1976 年创立，总部位于加州库比蒂诺。公司凭借 Apple II 和带图形界面的 Macintosh 推动了个人电脑的普及，在经历 90 年代的濒临破产后，通过收购 NeXT 迎回乔布斯，并凭借 iMac、iPod、iPhone 和 iPad 实现业务重组与盈利。核心产品涵盖 iPhone、Mac、iPad 等硬件及其配套的 iOS、macOS 系统和 Apple Music、iCloud 等服务，于 2025 年 10 月市值突破 4 万亿美元。

- 安静做好自己的产品,其他公司别来搭理我
#### 公司历史

\- 1976—1984｜创立与个人计算机革命：史蒂夫·乔布斯（Steve Jobs）、史蒂夫·沃兹尼亚克（Steve Wozniak）与罗纳德·韦恩（Ronald Wayne）于1976年创立 Apple Computer，最初销售 Apple I 计算机。1977年推出 Apple II，凭借较完整的软硬件设计成为早期个人电脑市场的重要企业，1980年在纳斯达克上市。1983年推出 Lisa，1984年发布 Macintosh，将图形用户界面、鼠标操作和桌面计算推广至个人电脑市场。

\- 1985—1996｜管理动荡与市场竞争：1985年乔布斯离开苹果并创立 NeXT，随后 Apple 由约翰·斯卡利（John Sculley）等管理者领导。公司推出 Macintosh II、PowerBook、Newton PDA 等产品，并在1994年开始从摩托罗拉处理器向 PowerPC 架构转型。然而，Macintosh 平台的软件生态和市场规模逐渐受到 IBM PC 兼容机及 Microsoft Windows 的竞争压力，多次产品线调整与经营失误使苹果在1990年代中后期陷入严重财务困境。

\- 1997—2006｜乔布斯回归与数字消费电子转型：1997年苹果完成对 NeXT 的收购，乔布斯回归并重新领导公司，随后精简产品线，与 Microsoft 达成合作。1998年推出 iMac，2001年推出 Mac OS X、iPod，并开设 Apple Store 零售店。2003年推出 iTunes Music Store，建立数字音乐购买与播放生态；2006年开始将 Mac 从 PowerPC 迁移至 Intel x86 处理器。公司逐渐从传统电脑制造商发展为软硬件与数字内容一体化的消费电子企业。

\- 2007—2011｜iPhone 与移动互联网生态：2007年正式更名为 Apple Inc.，推出第一代 iPhone，将触摸屏、移动互联网和智能手机交互方式整合。2008年推出 App Store，建立第三方移动应用开发与分发平台；2010年推出 iPad，并逐渐形成 iOS、macOS、App Store、iTunes 与 iCloud 相互连接的产品生态。2011年乔布斯卸任 CEO，蒂姆·库克（Tim Cook）接任，同年乔布斯去世。

\- 2012—2019｜全球化扩张与服务业务增长：库克领导苹果强化全球供应链、芯片研发和高端消费电子产品线。2014年收购 Beats，推出 Apple Pay，并发布 Apple Watch；2016年推出 AirPods，2017年发布采用 Face ID 的 iPhone X。2018年完成收购 Shazam，2019年推出 Apple TV+、Apple Arcade、Apple Card 等服务，同时扩大 Apple Music、App Store 和 iCloud 的订阅业务，形成硬件销售、数字服务与可穿戴设备共同发展的经营结构。

\- 2020—2023｜自研芯片与空间计算：2020年发布 M1 芯片，启动 Mac 从 Intel x86 向自研 ARM 架构 Apple Silicon 的全面迁移，逐步统一 Mac、iPhone、iPad 的芯片技术基础。2021年推出搭载 M1 Pro、M1 Max 的 MacBook Pro，继续发展高性能芯片与专业计算设备。2023年发布 Apple Vision Pro，正式进入空间计算领域，同时强化 Apple Watch 健康监测、iPhone 影像计算及设备间互联能力。

\- 2024—2026｜人工智能、空间计算与领导层更替：2024年 Apple Vision Pro 正式上市，苹果发布 Apple Intelligence，将生成式 AI 与 Siri、系统写作工具及照片处理等功能结合。2025年完成收购 Pixelmator，继续发展自研芯片、AI 和专业创意软件。2026年收购音频 AI 企业 Q.ai，推出 MacBook Neo、Apple Creator Studio，以及新一代 Siri AI、iPhone 18 Pro 和首款折叠屏 iPhone Duo。2026年9月1日，约翰·特努斯（John Ternus）接任 CEO，蒂姆·库克转任董事会执行主席，苹果进入新的管理阶段。

#### 控股公司及子公司

集团主体：Apple Inc.（苹果公司）

- 总部位于美国加利福尼亚州库比蒂诺（Cupertino），纳斯达克上市（AAPL），成立于1976年，2007年由 Apple Computer, Inc. 更名为 Apple Inc.。
- Apple 本身是集团顶层上市公司，没有另一家企业作为其控股母公司。公司采用广泛的公众股东持股结构，由董事会负责公司治理。
- 截至2026年10月，约翰·特努斯（John Ternus）担任 CEO，蒂姆·库克（Tim Cook）担任董事会执行主席。
- 按2025财年年报，Apple 主要按照地域划分五个报告分部：美洲（Americas）、欧洲（Europe）、大中华区（Greater China）、日本（Japan）、亚太其他地区（Rest of Asia Pacific）。其主要收入类别包括 iPhone、Mac、iPad、可穿戴设备与家居配件、服务业务。

主要子公司及控股实体：

- Apple Operations International Limited：注册于爱尔兰，是 Apple 国际业务体系的重要法律实体，涉及集团海外运营与公司架构管理。
- Apple Operations Limited：注册于爱尔兰，属于 Apple 国际运营体系的重要子公司。
- Apple Distribution International Limited：注册于爱尔兰，承担 Apple 国际产品分销与相关商业运营职能。
- Apple Asia Limited / Apple Asia LLC：分别注册于中国香港和美国特拉华州，属于集团亚洲业务相关法律实体。
- Apple Computer Trading (Shanghai) Co., Ltd.（苹果电脑贸易〔上海〕有限公司）：Apple 在中国大陆的重要经营实体，涉及产品销售及相关商业活动。
- Apple India Private Limited：Apple 在印度的重要经营实体，负责当地业务运营。
- Apple Japan, Inc. / Apple Korea Limited：分别为 Apple 在日本和韩国的重要经营实体。
- Apple Canada Inc. / Apple Pty Limited：分别为 Apple 在加拿大和澳大利亚的经营实体。
- Apple Vietnam Limited Liability Company / Apple South Asia Pte. Ltd.：属于 Apple 在越南及东南亚地区的经营实体。
- Apple Services Pte. Ltd.：注册于新加坡，属于集团数字服务业务相关实体。
- Braeburn Capital, Inc.：注册于美国内华达州，是 Apple 旗下投资管理公司，负责集团部分现金及金融资产管理。
- Apple Insurance Company, Inc.：注册于美国亚利桑那州，是 Apple 集团保险业务相关子公司。

以上属于 Apple 在2025财年 SEC 文件中披露的重要法律实体，该名单允许省略部分非重要子公司，因此不代表集团全部子公司。

主要收购企业及整合业务：

- NeXT：1997年完成收购，由乔布斯创立的计算机和操作系统公司。其 NeXTSTEP 技术成为后来 Mac OS X 及苹果现代操作系统架构的重要基础。
- P.A. Semi：2008年完成收购，主营低功耗处理器设计，为 Apple 后续自研 A 系列和 M 系列芯片积累了关键技术与人才。
- Siri Inc.：2010年完成收购，开发智能语音助手，相关技术整合为 iOS 的 Siri 服务。
- AuthenTec：2012年完成收购，主要从事指纹识别及信息安全技术研发，成为 Touch ID 生物识别系统的重要技术来源。
- PrimeSense：2013年完成收购，主营三维感知和深度摄像技术，其技术及人才为 Face ID、TrueDepth 摄像头等系统的发展提供了支持。
- Beats Electronics / Beats Music：2014年以约30亿美元完成收购，涉及耳机、音频设备及音乐流媒体业务。Beats 保留独立消费品牌，Beats Music 的部分技术和团队被整合进入 Apple Music。
- Shazam Entertainment：2018年完成收购，主营音乐识别和音频分析技术，保留 Shazam 品牌，同时整合进入 Apple Music 和 iOS。
- Intel 智能手机调制解调器业务：2019年完成收购，获得相关专利、设备及研发团队，强化 Apple 自研蜂窝通信芯片能力，随后推出 C 系列调制解调器。
- Pixelmator：2025年完成收购，旗下包括 Pixelmator Pro、Photomator 等图像编辑软件，相关业务进入 Apple 专业创意软件生态。
- Q.ai：2026年1月完成收购，以色列人工智能企业，研究语音理解、音频增强及机器学习交互技术，相关团队加入 Apple。

需要区分：上述收购业务有些已完全整合进入 Apple 内部研发部门，有些仍以独立品牌运营，不能一概认定为仍然独立存在的法律子公司。

#### 主要产品

\- iPhone 智能手机系列：iPhone 17、iPhone 17e、iPhone Air、iPhone 18 Pro、iPhone 18 Pro Max、iPhone Duo（折叠屏），覆盖入门、标准、轻薄、旗舰及折叠形态。

\- Mac 笔记本电脑：MacBook Neo、MacBook Air、MacBook Pro，分别面向入门计算、轻薄办公与专业高性能计算。

\- Mac 台式电脑：iMac、Mac mini、Mac Studio，覆盖一体机、小型桌面设备及专业工作站。Mac Pro 已于2026年停止销售。

\- iPad 平板电脑：iPad、iPad mini、iPad Air、iPad Pro，配套 Apple Pencil、Magic Keyboard 等生产力配件。

\- Apple Watch 智能手表：Apple Watch SE、Apple Watch Series 12、Apple Watch Ultra 4，覆盖日常健康监测、运动追踪及户外专业场景。

\- AirPods 与 Beats 音频设备：AirPods 5、AirPods Pro 3、AirPods Max 2，以及 Beats Studio、Beats Solo、Powerbeats 等耳机产品。

\- Apple Vision 空间计算：Apple Vision Pro、visionOS，提供混合现实、空间交互、沉浸式影音及空间计算应用平台。

\- Apple Home 智能家居：Apple TV 4K、HomePod、HomePod mini、Apple Home、HomeView、Apple Home Collection，覆盖家庭影音、语音助手、智能家居中枢及家用智能配件。

\- Apple Silicon 自研芯片：A 系列移动处理器（A20 Pro 等）、M 系列桌面处理器（M5、M5 Pro、M5 Max、M5 Ultra、M6 等）、C 系列蜂窝调制解调器、N 系列无线连接芯片，以及 Secure Enclave 安全架构。

\- Apple 操作系统：iOS、iPadOS、macOS、watchOS、tvOS、visionOS，分别服务于 iPhone、iPad、Mac、Apple Watch、Apple TV 和 Apple Vision 设备。

\- Apple Intelligence 人工智能：Apple Intelligence、Siri AI、Writing Tools、Image Playground、Genmoji、Visual Intelligence、Private Cloud Compute，提供生成式 AI、自然语言交互、图像生成和端云协同智能服务。

\- Apple 云服务与账户体系：iCloud、iCloud+、Apple Account、Find My（查找）、iCloud Keychain、Apple Passwords，覆盖云存储、设备同步、账户管理和密码安全。

\- Apple 办公与生产力软件：Pages、Numbers、Keynote、Freeform、Notes、Reminders、Calendar、Mail，提供文档、表格、演示、白板、笔记和日程管理。

\- Apple Creator Studio 专业创意软件：Final Cut Pro、Logic Pro、Pixelmator Pro、Motion、Compressor、MainStage，覆盖视频剪辑、音乐制作、图像编辑与专业多媒体创作。

\- Apple 开发者工具与框架：Xcode、Swift、SwiftUI、TestFlight、Instruments、Metal、Core ML、ARKit、RealityKit、Foundation Models framework，涵盖应用开发、性能分析、图形计算、机器学习和空间计算。

\- Apple 应用分发与开发者服务：App Store、App Store Connect、Apple Developer Program、TestFlight、Game Center，构成 Apple 软件开发、测试、分发及商业化生态。

\- Apple 数字内容与娱乐服务：Apple Music、Apple TV（原 Apple TV+ 流媒体品牌）、Apple Arcade、Apple Podcasts、Apple Books、Apple Fitness+、Apple News+，覆盖音乐、影视、游戏、播客、电子书、健身和新闻订阅。

\- Apple 支付与金融服务：Apple Pay、Apple Wallet、Apple Card、Apple Cash，提供移动支付、数字钱包、信用卡及资金转账服务，部分产品具有地区限制。

\- Apple 地图与日常应用：Apple Maps、Safari、Photos、FaceTime、Messages、Apple Translate、Shortcuts、Apple Sports，覆盖地图导航、浏览器、照片管理、通信、翻译、自动化及体育资讯。

\- Apple 健康与安全服务：Apple Health、Apple Fitness、HealthKit、Medical ID、Emergency SOS、Crash Detection，以及 Apple Watch 健康传感与运动监测功能。

\- Apple 企业与教育服务：Apple Business Manager、Apple School Manager、Apple Business Essentials、AppleCare for Enterprise、Managed Apple Accounts，提供企业设备部署、身份管理、终端管理和教育信息化支持。

\- Apple 硬件配件：Apple Pencil、Magic Keyboard、Magic Mouse、Magic Trackpad、Studio Display、Studio Display XDR、AirTag、MagSafe 及各类官方保护配件。

\- Apple 零售与售后服务：Apple Store、Apple Online Store、Apple Trade In、AppleCare+、Apple One，覆盖实体零售、线上销售、设备换购、延长保障与订阅服务组合。

#### 招聘情况
- [招聘官网](https://www.apple.com/careers/cn/)
- 公众号: Apple招聘

招聘岗位比起谷歌和微软都多上不少,但产品人员和硬件开发招的比较多,软件开发的岗位实际上也很少:

![示意图](PixPin_2026-04-25_11-59-57.webp)
### Meta
不在内地招人,可直接跳过
#### 公司概况
Meta Platforms, Inc.（前身为 Facebook, Inc.）是一家总部位于加州门洛帕克的美国跨国科技巨头，与 Alphabet、亚马逊、苹果、微软及英伟达并称为美国六大科技巨头（Big Tech）。该公司由马克·扎克伯格于 2004 年创立，旗下拥有 Facebook、Instagram、WhatsApp、Messenger 和 Threads 等全球主流社交与通信平台，广告收入占其总营收的 97.8% 以上。2021 年，公司正式更名为 Meta，反映其转向构建以虚拟现实（VR）和增强现实（AR）技术为核心的“元宇宙”生态系统的战略布局。作为全球研发投入最高的公司之一，Meta 在 2023 年福布斯全球 2000 强中排名第 31 位。
#### 公司历史

\- 2004—2007｜创立与社交网络平台化：马克·扎克伯格（Mark Zuckerberg）与爱德华多·萨维林（Eduardo Saverin）、达斯汀·莫斯科维茨（Dustin Moskovitz）、克里斯·休斯（Chris Hughes）于2004年在哈佛大学创立 TheFacebook，最初面向大学生提供个人资料、好友关系和校园社交服务。2005年更名为 Facebook，2006年推出 News Feed（动态消息）并向公众开放注册，2007年推出 Facebook Platform 和广告平台，逐渐建立围绕用户关系网络、第三方应用与精准广告的商业模式。

\- 2008—2011｜全球扩张与移动社交转型：2008年引入谢丽尔·桑德伯格（Sheryl Sandberg）担任首席运营官，强化广告销售和商业化运营。2009年推出 Like（赞）按钮，2010年月活跃用户突破5亿，2011年推出 Facebook Messenger 和 Timeline（时间线）。公司扩大数据中心基础设施，强化移动端应用与社交广告系统，逐渐发展为全球大型互联网社交平台。

\- 2012—2014｜上市与社交帝国扩张：2012年 Facebook 在纳斯达克上市（FB），以约10亿美元收购图片社交平台 Instagram；2013年推出面向移动端的信息流广告，并收购移动分析企业 Onavo。2014年以约190亿美元收购即时通信平台 WhatsApp，同时收购虚拟现实企业 Oculus VR，形成 Facebook、Instagram、WhatsApp、Messenger 等社交产品组合，并开始进入 VR 硬件与沉浸式计算领域。

\- 2015—2020｜视频社交、数字支付与虚拟现实：Facebook 持续扩展 Messenger、Instagram Stories、Facebook Live、Marketplace、Groups 等业务，强化视频内容、社群和电子商务生态。2016年推出 Oculus Rift 消费级 VR 头显，2019年推出独立式 Oculus Quest，同时宣布 Libra 数字货币计划（后更名 Diem，最终终止）。2020年推出 Instagram Reels 和 Oculus Quest 2，收购 GIF 平台 Giphy，进一步扩展短视频与 VR 业务，但也面临隐私保护、数据使用和反垄断监管压力。

\- 2021—2023｜Meta 品牌重组与元宇宙战略：2021年 Facebook, Inc. 更名为 Meta Platforms, Inc.，将 Facebook 保留为旗下社交产品品牌，公司将长期战略转向元宇宙、虚拟现实和增强现实。2022年推出 Meta Quest Pro，强化 Horizon 虚拟社交平台及 Reality Labs 研发投入。2023年推出文本社交平台 Threads、Meta Quest 3 和 Llama 系列大语言模型，同时继续推动 Instagram Reels、WhatsApp Business 和 AI 广告系统的发展，逐渐形成社交网络、沉浸式硬件与人工智能并行的业务结构。

\- 2024—2026｜生成式 AI、智能眼镜与个人智能体：2024年推出 Llama 3 和面向多款应用的 Meta AI，持续发展 Ray-Ban Meta 智能眼镜、Meta Quest 3S、Horizon OS 和生成式 AI 广告工具。2025年发布 Llama 4、独立 Meta AI 应用，并投资 Scale AI，组建 Meta Superintelligence Labs，重点发展超级智能、AI 模型和计算基础设施。2026年推出个人 AI 智能体 Muse、Muse Spark 与 Muse Wonder 模型，扩展 Ray-Ban Meta、Oakley Meta 和 Meta Ray-Ban Display 智能眼镜产品，并发布计划于2027年上市的 Meta VR Glasses，逐渐将战略重点扩展至个人 AI、智能可穿戴设备及下一代计算平台。

#### 控股公司及子公司

集团主体：Meta Platforms, Inc.（元平台公司）

- 总部位于美国加利福尼亚州门洛帕克（Menlo Park），纳斯达克上市（META），2004年以 Facebook 公司为基础成立，2021年更名为 Meta Platforms, Inc.。
- Meta 本身是集团顶层上市公司，没有其他企业作为其控股母公司。创始人马克·扎克伯格（Mark Zuckerberg）担任董事长兼 CEO，通过拥有较高表决权的 B 类股票保持控制权。截至2026年10月1日，其持有约13.4%的经济权益，但控制约60.6%的股东表决权。
- 按2026年第三季度财报，集团分为 Family of Apps（FoA，应用家族）与 Reality Labs（RL，现实实验室）两个报告分部。前者包括 Facebook、Instagram、Messenger、WhatsApp 等社交与广告业务；后者包括虚拟现实、增强现实、智能眼镜、相关软件及内容业务。人工智能研发则贯穿多个业务部门。

主要子公司及收购业务：

- Instagram, LLC：2012年以约10亿美元收购，主营图片、短视频与社交内容分享，旗下包括 Instagram、Instagram Stories、Instagram Reels、Instagram Direct 等产品，是 Meta 核心社交与广告平台之一。
- WhatsApp LLC：2014年以约190亿美元收购，主营即时通信、语音视频通话及企业消息服务，主要产品包括 WhatsApp、WhatsApp Business、WhatsApp Business Platform。
- Oculus VR：2014年完成收购，主营虚拟现实头显、空间计算技术及 VR 内容生态，后来整合进入 Meta Reality Labs，Oculus 品牌逐渐由 Meta Quest 替代。
- Beat Games：2019年完成收购，捷克虚拟现实游戏开发商，代表作品为音乐节奏游戏《Beat Saber》，属于 Meta VR 游戏内容生态。
- CTRL-labs：2019年完成收购，研究基于肌肉电信号（EMG）的神经交互技术，其技术被整合进入 Reality Labs，成为 Meta Neural Band 等交互设备的重要技术基础。
- Mapillary：2020年完成收购，提供众包街景图像、道路识别及计算机视觉地图数据服务，相关技术服务于 Meta 地理信息和地图基础设施。
- Within Unlimited：2023年完成收购，虚拟现实健身应用开发商，代表产品为 Supernatural，属于 Meta Quest 运动健身内容生态。
- Luxexcel：2022年完成收购，荷兰光学技术企业，主要开发用于智能眼镜的光学镜片和相关制造技术，加入 Reality Labs。
- Limitless：2025年完成收购，原名 Rewind，开发 AI 录音、语音转写、信息检索与可穿戴设备技术，相关团队加入 Meta 个人 AI 和智能可穿戴业务。

集团重要法律实体：

- Facebook Holdings, LLC：注册于美国特拉华州，属于 Meta 集团重要控股法律实体。
- Facebook Procurement, LLC：注册于特拉华州，属于集团采购相关法律实体。
- Meta Platforms Ireland Limited：注册于爱尔兰，属于 Meta 欧洲及国际运营体系的重要实体。
- FCL Tech Limited：注册于爱尔兰，属于集团国际业务架构。
- Meta Payments Inc.：注册于美国佛罗里达州，属于集团支付及相关金融服务体系。
- Siculus LLC / Sidecat LLC：注册于特拉华州，属于 Meta 集团的重要法律实体。

以上法律实体根据 Meta 2025财年 SEC Exhibit 21.1 披露整理。该名单并不包含集团全部子公司。

其他重要投资、合作及历史股权关系：

- Scale AI：2025年 Meta 以约143亿美元取得其49%的非投票股权，并引入联合创始人亚历山大·王（Alexandr Wang）参与领导 AI 研发。Scale AI 主要从事 AI 数据标注、模型评估和数据基础设施业务，属于 Meta 重要战略投资对象，不能视为控股子公司。
- EssilorLuxottica（依视路陆逊梯卡）：全球眼镜集团，拥有 Ray-Ban、Oakley 等品牌，与 Meta 合作开发智能眼镜。双方属于战略合作及投资关系，Ray-Ban 和 Oakley 并非 Meta 自有品牌。
- Manus：2025年末 Meta 收购这家通用 AI 智能体企业，2026年因中国监管机构要求撤销交易，Meta 于8月完成剥离，因此已不属于现有控股子公司。
- Giphy：2020年完成收购，主营 GIF 动图搜索与分享，2023年因英国反垄断监管要求，以约5300万美元出售给 Shutterstock。
- Kustomer：2022年完成收购，主营企业客户关系管理（CRM）与在线客服系统，2023年重新独立运营，Meta 保留少数股权，不再属于其控股业务。

#### 主要产品

\- Facebook 社交网络：Facebook、Facebook Feed、Facebook Stories、Facebook Reels、Facebook Groups、Facebook Pages、Facebook Events、Facebook Marketplace、Facebook Dating、Facebook Forum，覆盖社交关系、内容分享、群组、社区和本地交易。

\- Instagram 图片与视频社交：Instagram、Instagram Stories、Instagram Reels、Instagram Direct、Instagram Live、Instagram Shopping、Instagram Edits，覆盖图片分享、短视频、私信、直播、社交电商及内容编辑。

\- WhatsApp 即时通信：WhatsApp、WhatsApp Business、WhatsApp Business Platform、WhatsApp Cloud API、WhatsApp Channels、WhatsApp Communities，覆盖个人通信、企业客服、商业消息及社区运营。

\- Messenger 即时通信：Facebook Messenger、Messenger Rooms（历史产品）、Messenger for Business，以及相关聊天机器人、视频通话和企业消息功能。

\- Threads 文本社交：Threads、Threads Communities、Threads Feeds，提供短文本发布、实时公共讨论、社区交流及社交内容推荐。

\- Meta AI 人工智能助手：Meta AI、Meta AI App、Meta AI Studio、Imagine、Meta AI in WhatsApp / Instagram / Facebook / Messenger，提供智能问答、图像生成、信息检索、创作者 AI 和应用内智能服务。

\- Muse 个人 AI 智能体：Muse、Muse Secure VM、Muse Code、Muse Spark、Muse Wonder、Muse Wonder Full，涉及自主任务执行、网页操作、长期目标管理、安全隔离计算环境、AI 编程及智能体基础模型。

\- Llama 大语言模型：Llama 2、Llama 3、Llama 3.1、Llama 3.2、Llama 4，覆盖文本理解、内容生成、多模态处理及模型部署。Llama 系列以开放权重模型为重要特色，部分版本的许可仍存在商业使用条件。

\- AI 开发与模型服务：Meta Model API、Meta AI Studio、Llama Stack、llama.cpp 生态支持、Meta AI Research，涵盖模型调用、智能体构建、模型研究与开发者工具，其中部分项目属于开源生态或合作社区。

\- Meta Quest 虚拟现实设备：Meta Quest 2（历史产品）、Meta Quest Pro（历史产品）、Meta Quest 3、Meta Quest 3S，提供独立式 VR、混合现实、沉浸式娱乐、空间交互及虚拟办公能力。

\- Meta VR Glasses：2026年发布的新一代轻量化 VR 眼镜，采用眼镜式形态与外置计算单元，搭载 Meta Horizon OS，计划于2027年春季上市。

\- Meta 智能眼镜系列：Ray-Ban Meta（Gen 2、Gen 3）、Ray-Ban Meta Audio、Oakley Meta HSTN、Oakley Meta Vanguard、Meta Ray-Ban Display、Meta Glasses Collection，覆盖音频交互、拍摄、AI 助手、运动场景及镜片内显示功能。

\- Meta 神经交互与 AR 技术：Meta Neural Band、EMG 手势识别技术、Orion AR 眼镜原型、Aria Research Kit，涉及肌电信号交互、增强现实、空间感知和下一代人机交互研究。

\- Meta Horizon 虚拟现实生态：Meta Horizon OS、Meta Horizon Worlds、Meta Horizon Store、Meta Horizon App、Meta Quest Link，覆盖 VR 操作系统、虚拟社交空间、应用分发、内容管理和 PC VR 连接。

\- Meta VR 游戏与应用：Beat Saber、Supernatural、Asgard's Wrath、Population: One、Horizon Worlds，涵盖节奏游戏、VR 健身、角色扮演、多人竞技和虚拟社交，其中部分游戏由 Meta 自有工作室开发，部分由旗下发行体系运营。

\- Meta 广告与营销平台：Meta Ads Manager、Meta Business Suite、Meta Business Manager、Meta Ads Library、Meta Pixel、Conversions API、Meta Audience Network，覆盖广告投放、商业账户管理、效果分析、转化追踪及跨平台广告分发。

\- Meta 商业与电商服务：Facebook Marketplace、Facebook Shops、Instagram Shopping、WhatsApp Business、Meta Commerce Manager，覆盖线上商品展示、社交交易、商业消息及销售管理，具体商业功能因地区而异。

\- Meta 创作者与订阅服务：Meta Verified、Meta One、Facebook Stars、Instagram Subscriptions、Facebook Subscriptions、Meta Creator Marketplace，提供账号认证、会员订阅、创作者变现及商业合作服务。

\- Meta 支付与账户服务：Meta Pay、Meta Account、Accounts Center、Meta Verified，涉及支付处理、跨平台身份管理、账户同步和认证订阅。

\- Meta 开源软件与开发框架：React、React Native、PyTorch、FAISS、RocksDB、Docusaurus、GraphQL，涉及前端开发、移动应用、深度学习、向量检索、数据库存储和 API 查询。其中 React、PyTorch 等已发展为具有独立社区或基金会治理结构的开源项目。

\- Meta AI 基础设施与芯片：Meta Training and Inference Accelerator（MTIA）、AI Research SuperCluster（RSC）、Meta 自建数据中心，以及大规模 AI 训练和推理基础设施，主要为集团广告推荐、模型训练、生成式 AI 与智能体服务提供算力支持。

### Amazon (亚马逊)
- 对于亚马逊退出中国市场一事我一直很遗憾
#### 公司概况
Amazon.com, Inc.（简称亚马逊）是一家总部位于华盛顿州西雅图的美国跨国科技巨头，业务涵盖电子商务、云计算、在线广告、数字流媒体及人工智能。公司由杰夫·贝佐斯于 1994 年创立，最初是一家在线书店，后演变为提供全品类商品的“万能商店”（The Everything Store）。作为“五大科技巨擘”（Big Tech）之一，亚马逊在多个领域占据全球领先地位：它是全球最大的在线零售商、智能音箱供应商和云计算服务商（通过 AWS）。
#### 公司历史

\- 1994—1999｜创立与互联网零售：杰夫·贝索斯（Jeff Bezos）于1994年在美国华盛顿州创立 Amazon，最初名为 Cadabra，随后更名为 Amazon。1995年正式上线网上书店，凭借互联网直接面向消费者销售图书，并建立商品搜索、用户评价及个性化推荐系统。1997年在纳斯达克上市（AMZN），1998年开始销售音乐、影视等商品，并收购 IMDb，逐渐从在线书店转向综合电子商务平台。1999年前后进一步扩大商品类别，建立全球物流和仓储网络。

\- 2000—2006｜电商平台化与云计算诞生：2000年正式发展第三方卖家平台 Amazon Marketplace，使外部商家能够通过 Amazon 销售商品。2001年实现首次季度盈利，逐渐完善仓储、物流、支付和推荐算法。2005年推出 Amazon Prime 会员服务，通过快速配送建立用户订阅体系。2006年正式推出 Amazon Web Services（AWS）云计算服务，发布 Amazon S3 对象存储和 EC2 云服务器，将公司内部积累的计算基础设施能力商业化，为后来的云计算产业奠定基础。

\- 2007—2013｜数字内容、智能硬件与物流自动化：2007年推出 Kindle 电子阅读器和 Amazon Fresh 生鲜配送服务，开始向数字出版、智能硬件及食品零售扩展。2008年收购 Audible，2009年收购鞋类电商 Zappos。2011年推出 Kindle Fire 平板电脑，逐渐形成电子阅读、数字内容和设备销售生态。2012年收购仓储机器人企业 Kiva Systems，将机器人技术引入物流中心；2013年收购 Goodreads，并推出 Amazon 在印度的电商业务。AWS 同期持续发展数据库、内容分发和企业基础设施服务。

\- 2014—2019｜智能家居、流媒体与全球零售扩张：2014年推出 Echo 智能音箱和 Alexa 语音助手，并收购游戏直播平台 Twitch。2015年收购芯片设计企业 Annapurna Labs，加强云计算自研处理器研发；2016年进一步扩大 Prime Video 流媒体服务。2017年以约137亿美元收购 Whole Foods Market，进入大型实体生鲜零售市场；2018年收购 Ring 和 PillPack，拓展智能安防与在线医疗。2019年收购 eero，强化家庭网络设备业务，并启动 Project Kuiper 低轨卫星互联网计划，逐渐形成电商、云计算、数字内容、智能设备和实体零售并行发展的经营结构。

\- 2020—2023｜业务多元化与生成式人工智能：2020年收购自动驾驶企业 Zoox，强化无人驾驶技术布局。2021年安迪·贾西（Andy Jassy）接任 CEO，贝索斯转任执行董事长。2022年完成对米高梅（MGM）的收购，扩大 Prime Video 的影视内容与知识产权储备；2023年完成对 One Medical 的收购，进入线下初级医疗服务领域。同年 AWS 推出 Amazon Bedrock 生成式 AI 平台，并与 Anthropic 建立战略投资和云计算合作关系。公司持续扩展自研 Graviton、Trainium、Inferentia 芯片及云计算基础设施。

\- 2024—2026｜生成式 AI、卫星互联网与算力基础设施：2024年推出 Amazon Nova 自研基础模型，并继续发展 Bedrock、Amazon Q 和 Trainium 系列 AI 芯片；2025年推出 Alexa+ 生成式 AI 助手，扩大 AI 在购物、智能家居、办公和云服务中的应用。Project Kuiper 于2025年开始正式部署卫星星座，并更名为 Amazon Leo。2026年扩大与 Anthropic 的算力合作，同时宣布向 OpenAI 投资500亿美元，并通过 AWS 为其提供云计算和 AI 芯片服务。同期将购物助手 Rufus 更名为 Alexa for Shopping，调整实体零售战略，关闭 Amazon Go 和 Amazon Fresh 实体门店并扩大 Whole Foods Market 网络，继续发展 AI 数据中心、自研芯片、自动驾驶及低轨卫星通信。

#### 控股公司及子公司

集团主体：Amazon.com, Inc.（亚马逊公司）

- 总部位于美国华盛顿州西雅图（Seattle），纳斯达克上市（AMZN），成立于1994年，1996年在美国特拉华州重新注册。
- Amazon 本身是集团顶层上市公司，没有另一家企业作为其控股母公司。创始人杰夫·贝索斯（Jeff Bezos）担任执行董事长，安迪·贾西（Andy Jassy）自2021年起担任 CEO。
- 按2025财年年报及2026年第二季度财报，集团主要分为北美业务（North America）、国际业务（International）和亚马逊云科技（Amazon Web Services，AWS）三个报告分部，覆盖电子商务、物流配送、云计算、广告、数字内容和会员订阅等业务。

主要子公司及收购业务：

- Amazon Web Services（AWS）：2006年正式推出，是 Amazon 旗下云计算业务，提供云服务器、对象存储、数据库、人工智能、企业安全和云基础设施服务。集团旗下设有 Amazon Web Services, Inc. 等相关法律实体。
- Whole Foods Market：2017年以约137亿美元收购，美国大型天然与有机食品连锁超市，经营 Whole Foods Market、Whole Foods Market Daily Shop 等零售业态。
- Zappos：2009年完成收购，美国在线鞋履与服饰零售平台，经营 Zappos.com，保留独立电商品牌。
- Audible：2008年完成收购，主营有声读物、播客及数字音频订阅服务，主要产品为 Audible。
- IMDb（Internet Movie Database）：1998年完成收购，提供电影、电视剧、演员、制作团队、评分及行业信息数据库，同时运营 IMDbPro 专业影视信息服务。
- Goodreads：2013年完成收购，主营图书评价、阅读记录、书籍推荐和读者社交服务，与 Kindle 电子书生态形成协同。
- Twitch Interactive：2014年以约9.7亿美元完成收购，主营游戏直播、实时互动与创作者内容平台，旗下包括 Twitch、Twitch Turbo、Twitch Partner Program 等服务。
- Amazon MGM Studios：2022年完成对 MGM Holdings（米高梅）的收购，整合进入 Amazon 影视制作和发行体系，拥有 MGM、Orion Pictures 等影视品牌，以及《James Bond》《Rocky》等影视知识产权的相关权益。
- Ring：2018年完成收购，主营智能门铃、家庭安防摄像头、报警设备和家庭安全服务，属于 Amazon 智能家居业务体系。
- Blink：2017年完成收购，主营智能家居安防摄像头、视频门铃及监控配件，与 Ring 共同构成 Amazon 家庭安防产品体系。
- eero：2019年完成收购，主营 Mesh Wi-Fi 路由器、家庭网络管理及网络安全服务，属于 Amazon 家庭网络设备业务。
- Amazon Robotics（原 Kiva Systems）：2012年收购 Kiva Systems，2015年更名为 Amazon Robotics，专注仓储机器人、物流自动化及智能分拣系统，相关技术主要用于 Amazon 自有物流网络。
- Annapurna Labs：2015年完成收购，以色列半导体设计企业，主要负责 AWS 自研芯片和相关硬件技术，参与 Graviton、Trainium、Inferentia 等处理器研发。
- PillPack：2018年完成收购，美国在线药房企业，主营处方药配送、药品分类包装和长期用药管理，相关业务与 Amazon Pharmacy 整合。
- One Medical（1Life Healthcare）：2023年完成收购，美国医疗服务企业，经营线下初级医疗诊所、线上问诊及会员制医疗服务，属于 Amazon Health Services 医疗业务体系。
- Zoox：2020年完成收购，美国自动驾驶技术企业，专注于专门设计的无人驾驶电动车、自动驾驶系统及 Robotaxi 出行服务，已在拉斯维加斯向公众开放服务，并在旧金山开展有限范围的乘客服务。
- Woot：2010年完成收购，美国折扣电商平台，主营限时促销、库存商品、消费电子及综合零售。
- AbeBooks：2008年完成收购，加拿大在线图书交易平台，专注二手书、绝版书、古籍及收藏类图书交易。

集团重要法律实体：

- Amazon.com Services LLC：注册于美国特拉华州，Amazon 全资子公司，承担集团美国业务运营及相关管理职能。
- Amazon.com Sales, Inc.：注册于特拉华州，Amazon 全资子公司，属于美国零售与销售业务相关法律实体。
- Amazon Web Services, Inc.：注册于特拉华州，Amazon 全资子公司，属于 AWS 云计算业务相关法律实体。
- Amazon Data Services, Inc.：注册于特拉华州，Amazon 全资子公司，涉及集团数据中心及云基础设施相关业务。
- Amazon Technologies, Inc.：注册于美国内华达州，Amazon 全资子公司，属于集团技术及知识产权相关法律实体。
- Amazon.com NV Investment Holdings LLC：注册于内华达州，Amazon 全资子公司，承担集团部分投资控股职能，也是2026年 Amazon 投资 OpenAI 的重要交易主体。
- Amazon US Services LLC：注册于特拉华州，Amazon 全资子公司，属于集团美国业务服务体系。
- A100 ROW, Inc.：注册于特拉华州，Amazon 全资子公司，属于集团重要法律实体。
- Day One Insurance, Inc.：注册于美国亚利桑那州，Amazon 全资子公司，属于集团保险业务相关实体。

以上法律实体依据 Amazon 2025财年 SEC Exhibit 21.1 披露整理，均为100%持股，但该名单未包含集团全部子公司。

其他重要投资及股权关系：

- Anthropic：美国人工智能企业，开发 Claude 大语言模型。Amazon 自2023年开始投资，2026年进一步扩大投资与算力合作，成为重要少数股东，并通过 AWS 提供 Trainium 芯片及云计算资源。Anthropic 保持独立运营，不属于 Amazon 控股子公司。
- OpenAI：美国人工智能研究与产品公司。2026年2月 Amazon 宣布总额500亿美元的投资计划，并于2026年第三季度前完成相关投资，同时建立长期 AWS 云计算及 AI 模型合作关系。OpenAI 仍为独立企业，不属于 Amazon 控股子公司。
- Blue Origin（蓝色起源）：由贝索斯于2000年另外创立的航天企业，主营运载火箭、航天运输及太空基础设施。虽然与 Amazon Leo 存在卫星发射合作，但并非 Amazon 子公司。
- iRobot：扫地机器人 Roomba 的开发企业。Amazon 于2022年宣布收购，但因监管障碍于2024年终止交易，因此 iRobot 不属于 Amazon 控股子公司。

#### 主要产品

\- Amazon 电子商务平台：Amazon.com、Amazon Marketplace、Amazon Shopping、Amazon Business、Amazon Outlet、Amazon Renewed、Amazon Haul，覆盖综合零售、第三方卖家交易、企业采购、折扣商品及翻新商品。

\- Amazon Prime 会员服务：Amazon Prime、Prime Student、Prime Video、Prime Reading、Prime Gaming、Amazon Photos，覆盖快速配送、影视、电子阅读、游戏及云端照片存储。

\- Amazon 卖家与电商服务：Amazon Seller Central、Fulfillment by Amazon（FBA）、Amazon Multi-Channel Fulfillment（MCF）、Amazon Global Selling、Amazon Brand Registry、Amazon Vine，提供商家入驻、仓储配送、跨境贸易、品牌保护和商品评价服务。

\- AWS 云计算基础设施：Amazon EC2、Amazon S3、Amazon EBS、Amazon EFS、Amazon VPC、Amazon CloudFront、Amazon Route 53，覆盖云服务器、对象存储、文件存储、虚拟网络、内容分发和域名解析。

\- AWS 容器与无服务器计算：AWS Lambda、Amazon ECS、Amazon EKS、AWS Fargate、AWS App Runner、AWS Batch，覆盖函数计算、容器编排、Kubernetes 托管和批处理任务。

\- AWS 数据库与数据分析：Amazon RDS、Amazon Aurora、Amazon DynamoDB、Amazon Redshift、Amazon ElastiCache、Amazon OpenSearch Service、AWS Glue、Amazon Athena、Amazon Kinesis，涵盖关系型数据库、NoSQL、缓存、数据仓库、搜索分析及实时数据处理。

\- AWS 人工智能与机器学习：Amazon Bedrock、Amazon Bedrock AgentCore、Amazon SageMaker、Amazon Rekognition、Amazon Transcribe、Amazon Textract、Amazon Polly、Amazon Lex，覆盖基础模型调用、AI 智能体开发、模型训练、计算机视觉、语音识别和文档处理。

\- Amazon Nova 自研 AI 模型：Amazon Nova 2、Nova Lite、Nova Sonic、Nova Reel、Nova Canvas、Nova Multimodal Embeddings、Nova Act、Nova Forge，覆盖语言理解、推理、语音交互、图像视频生成、多模态检索、浏览器智能体及模型定制。

\- AWS 企业 AI 与开发工具：Amazon Quick、Amazon Quick Sight、Kiro、Amazon Q Developer、AWS Transform、AWS Cloud9、AWS CloudShell、AWS CloudFormation、AWS CDK、AWS Amplify，覆盖企业 AI 助手、商业智能、AI 编程、代码迁移及云应用开发。其中 Amazon Q Business 已向 Amazon Quick 演进，Amazon Q Developer 的 IDE 插件计划于2027年停止支持，AI 编程业务重点逐渐转向 Kiro。

\- AWS 安全与运维服务：AWS Identity and Access Management（IAM）、Amazon CloudWatch、AWS CloudTrail、Amazon GuardDuty、AWS Security Hub、Amazon Inspector、AWS WAF、AWS Shield、AWS Secrets Manager，涉及身份权限、系统监控、日志审计、威胁检测和网络安全。

\- AWS 企业应用与通信：Amazon Connect、Amazon SES、Amazon SNS、Amazon SQS、AWS Step Functions、Amazon WorkSpaces，涵盖智能客服、邮件发送、消息队列、工作流编排及虚拟桌面。

\- AWS 自研芯片与计算硬件：AWS Graviton、AWS Trainium、AWS Inferentia、AWS Nitro System、AWS Neuron，分别涉及 ARM 服务器处理器、AI 训练芯片、AI 推理芯片、硬件虚拟化及专用 AI 软件工具链。

\- Alexa 智能助手：Alexa、Alexa+、Alexa for Shopping、Alexa Skills、Alexa App、Alexa.com，提供语音助手、生成式 AI、智能家居控制、购物辅助及跨设备智能服务。Alexa for Shopping 原名 Rufus，于2026年完成更名。

\- Echo 智能音箱与显示设备：Echo、Echo Dot、Echo Dot Max、Echo Studio、Echo Pop、Echo Show、Echo Spot，覆盖智能音箱、语音交互、家庭控制及智能显示屏。

\- Kindle 电子阅读系列：Kindle、Kindle Paperwhite、Kindle Colorsoft、Kindle Scribe、Kindle Scribe Colorsoft、Kindle Kids，覆盖电子书阅读、彩色电子墨水屏、手写笔记和儿童阅读。

\- Fire 平板与电视设备：Fire 7、Fire HD 8、Fire HD 10、Fire Max 11、Fire TV Stick、Fire TV Cube、Fire TV Omni、Fire TV OS，覆盖平板电脑、流媒体设备、智能电视和家庭娱乐。

\- Ring 智能安防：Ring Video Doorbell、Ring Indoor Cam、Ring Stick Up Cam、Ring Spotlight Cam、Ring Floodlight Cam、Ring Alarm、Ring Protect，提供视频门铃、摄像头、报警系统和家庭安防订阅服务。

\- Blink 智能家居监控：Blink Mini、Blink Indoor、Blink Outdoor、Blink Video Doorbell、Blink Sync Module，主营低功耗家用摄像头、视频门铃及相关监控设备。

\- eero 家庭网络设备：eero 6+、eero Pro 6E、eero 7、eero Pro 7、eero Max 7、eero Secure，提供 Mesh Wi-Fi 路由器、家庭网络覆盖及网络安全服务。

\- Amazon 影音流媒体：Prime Video、Amazon MGM Studios、MGM+、Amazon Music、Amazon Music Unlimited、Audible、IMDb，覆盖影视流媒体、影视制作、音乐订阅、有声读物及影视信息服务。

\- Twitch 游戏直播平台：Twitch、Twitch Turbo、Twitch Drops、Twitch Creator Dashboard、Twitch Partner Program，提供直播、观众互动、创作者变现及游戏社区服务。

\- Amazon Games 游戏业务：Amazon Games、Amazon Luna、Luna Controller，以及旗下游戏开发、发行和云游戏平台，涉及大型多人在线游戏、游戏发行及流媒体游戏服务。

\- Amazon 广告业务：Amazon Ads、Sponsored Products、Sponsored Brands、Sponsored Display、Amazon DSP、Amazon Marketing Cloud、Amazon Attribution，覆盖商品搜索广告、展示广告、程序化广告及营销数据分析。

\- Amazon 物流与配送网络：Fulfillment by Amazon（FBA）、Amazon Logistics、Amazon Shipping、Amazon Air、Amazon Flex、Amazon Prime Air、Delivery Service Partner（DSP）Program，覆盖仓储物流、末端配送、航空货运及无人机配送。

\- Amazon Robotics 仓储机器人：Proteus、Sparrow、Robin、Hercules、Sequoia、Vulcan 等机器人及自动化系统，覆盖货架搬运、包裹分拣、商品识别、仓储操作和自动化物流。相关设备主要面向 Amazon 内部物流业务。

\- Whole Foods 与生鲜零售：Whole Foods Market、Whole Foods Market Daily Shop、Amazon Fresh 在线生鲜配送、Amazon Grocery，提供有机食品、实体超市及在线生鲜销售。Amazon Go 和 Amazon Fresh 实体门店已于2026年宣布关闭，但 Amazon Fresh 在线配送品牌继续运营。

\- Amazon 医疗健康服务：Amazon Pharmacy、Amazon One Medical、One Medical On-Demand Care、PillPack、Amazon Health AI，覆盖线上药房、处方药配送、会员制初级医疗、远程问诊和 AI 健康辅助服务。

\- Amazon Leo 卫星互联网：Amazon Leo（原 Project Kuiper）、Leo Nano、Leo Pro、Leo Ultra，利用低地球轨道卫星网络提供宽带互联网服务，覆盖个人、企业、交通运输及偏远地区通信。2025年开始正式部署卫星星座，2026年继续扩大在轨卫星数量和商用测试。

\- Zoox 自动驾驶出行：Zoox Robotaxi、Zoox App、Zoox Autonomous Driving System，提供专门设计的无人驾驶电动车、自动驾驶技术与 Robotaxi 出行服务。

\- Amazon 智能机器人与实验性硬件：Amazon Astro、Amazon One、Amazon Dash Cart、Just Walk Out，涉及家庭机器人、掌纹识别、智能购物车及无收银台结算技术，其中部分产品主要应用于试验性项目或商业场景。

\- Amazon 开源软件与开发工具：Firecracker、Bottlerocket、AWS SDK、AWS CDK、Strands Agents、OpenSearch，涉及轻量级虚拟化、容器操作系统、云开发工具、AI 智能体框架和分布式搜索分析。


#### 招聘情况
- [招聘官网](https://www.amazon.jobs/zh)
- 公众号: 亚马逊招聘

![示意图](PixPin_2026-04-25_12-32-22.webp)

与Apple一样,管理岗位和产品岗位招的特别多,真正的软件开发岗位很少


### Intel (英特尔)
母校不是上交的可以直接跳过了
#### 公司概况
英特尔（Intel）是总部位于加州圣克拉拉的跨国科技巨头，由戈登·摩尔和罗伯特·诺伊斯于1968年创立，是硅谷崛起的核心基石。作为x86架构的奠基者，英特尔曾通过“Wintel”联盟长期统治个人电脑市场，目前仍是全球领先的半导体制造商，核心业务涵盖酷睿（Core）系列处理器、Arc显卡、芯片组及数据中心基础设施。尽管近年来面临AMD的激烈竞争及移动互联网转型的挑战，英特尔依然凭借其集设计与制造于一体的IDM模式，在PC和服务器芯片领域保持着显著的市场领先地位。

#### 公司历史

\- 1968—1980｜创立与微处理器诞生：罗伯特·诺伊斯（Robert Noyce）与戈登·摩尔（Gordon Moore）于1968年创立 Intel Corporation，安迪·格鲁夫（Andy Grove）随后作为早期核心员工加入。公司最初专注半导体存储器，1970年推出 Intel 1103 DRAM，1971年发布 Intel 4004，成为商业微处理器发展的重要里程碑。随后推出 8008（1972）、8080（1974）、8086（1978）及8088（1979），逐渐建立 x86 处理器架构的技术基础。1971年在纳斯达克上市，开始从存储器制造商向微处理器企业转型。

\- 1981—1992｜IBM PC 与 x86 架构崛起：1981年 IBM PC 采用 Intel 8088 处理器，使 Intel 成为个人电脑产业的重要芯片供应商。1982年推出 80286，1985年推出 80386，1989年推出 80486，逐步建立 x86 处理器的性能与兼容性优势。面对日本存储器厂商的激烈竞争，Intel 于1985年前后退出 DRAM 主营业务，集中资源发展微处理器。1987年安迪·格鲁夫接任 CEO，1991年推出 Intel Inside 品牌营销计划，进一步巩固在 PC 处理器市场的地位。

\- 1993—2005｜Pentium 时代与 PC 市场主导：1993年推出 Pentium 处理器，随后发展 Pentium Pro、Pentium II、Pentium III 和 Pentium 4，逐渐建立从消费级电脑到服务器的完整 CPU 产品线。1998年推出 Celeron 经济型处理器，2001年正式确立 Xeon 服务器处理器品牌，2003年推出 Centrino 移动计算平台，推动笔记本无线网络普及。期间 Intel 与 Microsoft 形成高度互补的 Wintel 生态，x86 架构成为 PC 市场主流。2000年代初期开始发展超线程、多核心处理器及64位 x86 扩展技术。

\- 2006—2014｜Core 架构与半导体制造优势：2006年推出 Core 2 Duo，逐渐取代以高频率为核心的 Pentium 4 架构，并在2008年推出 Nehalem 微架构。2011年发布第二代 Core 处理器 Sandy Bridge，2012年将 Tri-Gate 三维晶体管引入22nm量产工艺，进一步扩大性能与能效优势。同期形成 Core i3、i5、i7、i9 等消费级处理器等级体系，并发展 Atom 低功耗处理器、Xeon 数据中心产品及 Thunderbolt 高速接口。然而，Intel 未能在智能手机处理器领域取得与 PC 相当的市场地位，移动计算市场逐渐由 ARM 架构主导。

\- 2015—2020｜大型收购与制程竞争失利：2015年以约167亿美元收购 FPGA 企业 Altera，2017年以约153亿美元收购自动驾驶技术企业 Mobileye，扩大数据中心、可编程芯片和汽车计算业务。2017年推出 Core X 高性能桌面平台，2018年推出第九代 Core i9 处理器。然而，10nm 制程研发和量产持续延迟，Intel 在先进制造工艺上逐渐落后于台积电，同时面临 AMD Zen 架构的竞争。2019年收购以色列 AI 芯片企业 Habana Labs，2020年推出 Xe GPU 架构，但同年苹果宣布 Mac 向自研 Apple Silicon 转型，进一步削弱 Intel 在个人电脑市场的长期优势。

\- 2021—2024｜IDM 2.0 与晶圆代工转型：2021年帕特·基辛格（Pat Gelsinger）接任 CEO，提出 IDM 2.0 战略，扩大美国和欧洲晶圆厂投资，推动 Intel Foundry 对外提供芯片制造服务。2022年推出 Arc 独立显卡，推动 Mobileye 在纳斯达克独立上市；2023年推出 Meteor Lake 架构的 Core Ultra 处理器，引入分离式芯粒设计和独立 NPU，开始向 AI PC 转型。2024年推出 Lunar Lake、Arrow Lake 处理器及 Arc B 系列显卡，并将晶圆代工业务进一步独立核算。但巨额资本支出、先进制程研发成本和市场份额下降造成持续经营压力，公司实施裁员、暂停派息与业务重组，基辛格于2024年12月离任。

\- 2025—2026｜业务重组与18A 制程量产：2025年陈立武（Lip-Bu Tan）接任 CEO，推动组织精简、资本支出调整及核心产品聚焦。同年向私募股权机构 Silver Lake 出售 Altera 51%股权，保留49%少数股权；美国政府通过股权投资参与 Intel 资本重组，NVIDIA 和软银亦成为重要战略投资者。2025年正式展示 Panther Lake 和 Clearwater Forest 架构，2026年推出基于 Intel 18A 工艺的 Core Ultra Series 3 和 Xeon 6+ 处理器，实现 RibbonFET 环绕栅极晶体管与 PowerVia 背面供电技术的商业化。同期推出 Xeon 600 工作站处理器、Arc Pro B 系列显卡，并加强 AI 基础设施、先进封装及晶圆代工业务。2026年第二季度营收同比增长25%，但 Intel Foundry 仍处于持续投入与亏损阶段。

#### 控股公司及子公司

集团主体：Intel Corporation（英特尔公司）

- 总部位于美国加利福尼亚州圣克拉拉（Santa Clara），纳斯达克上市（INTC），成立于1968年，是全球主要的半导体设计与制造企业之一。
- Intel 本身是集团顶层上市公司，没有另一家企业作为其控股母公司。2025年美国政府宣布投资约89亿美元取得约9.9%股权，但不获得董事会席位或日常经营控制权；软银于2025年投资20亿美元，NVIDIA 于同年12月完成50亿美元股权投资，三者均属于重要外部股东。
- 陈立武（Lip-Bu Tan）自2025年3月起担任 CEO，负责推动产品研发、先进制造和集团业务重组。
- 按2026年第二季度财报，Intel 主要分为 Client Computing and Physical AI Group（CCPG，客户端计算与物理 AI）、Data Center and AI（DCAI，数据中心与人工智能）、Intel Foundry（英特尔晶圆代工）三个报告分部，另外设有包含 Mobileye、IMS Nanofabrication 等业务的 All Other 类别。

主要控股公司及收购业务：

- Mobileye Global Inc.：2017年以约153亿美元完成收购，以色列自动驾驶技术企业，2022年在纳斯达克独立上市（MBLY）。截至2026年6月，Intel 持有约77.1%的普通股和96.9%的表决权，继续保持控股。主要产品包括 EyeQ 芯片、Mobileye SuperVision、Mobileye Chauffeur、Mobileye Drive 和 Road Experience Management（REM）。
- Mentee Robotics：2026年2月由 Mobileye 完成收购，以色列 AI 人形机器人企业，开发结合视觉、运动控制和机器学习的通用机器人系统，成为 Intel 集团通过 Mobileye 间接控股的业务。
- IMS Nanofabrication：2015年纳入 Intel 集团，奥地利半导体设备企业，主要研发多电子束光掩模写入设备，是先进 EUV 光刻掩模制造的重要设备供应商。2023年 Intel 向 Bain Capital 和台积电出售部分股权，截至2026年仍持有约68%股份，保持控股。
- Habana Labs：2019年以约20亿美元完成收购，以色列人工智能芯片企业，开发 Gaudi AI 加速器和相关软件技术，现已整合进入 Intel 数据中心与人工智能业务。
- Movidius：2016年完成收购，爱尔兰计算机视觉和低功耗 AI 处理器企业，主要技术包括 Myriad 视觉处理器，相关能力整合进入 Intel 边缘 AI 和视觉计算业务。
- Barefoot Networks：2019年完成收购，美国可编程网络芯片企业，开发 Tofino 系列以太网交换 ASIC 及 P4 网络编程技术，相关技术和团队进入 Intel 网络与数据中心业务。
- eASIC：2018年完成收购，美国定制化 ASIC 芯片企业，专注结构化 ASIC 和定制逻辑技术，相关业务整合进入 Intel 定制芯片产品体系。
- NetSpeed Systems：2018年完成收购，美国片上网络（Network-on-Chip，NoC）设计企业，主要提供 SoC 内部互连架构及相关知识产权，技术整合进入 Intel 芯片设计业务。

重要制造与投资业务：

- Intel Foundry：Intel 旗下晶圆制造和代工业务，提供芯片制程研发、晶圆制造、先进封装、测试和设计支持。2024年开始推进更加独立的运营及财务核算，但截至2026年仍由 Intel 控制，其业务收入主要来自集团内部产品制造。
- Intel Capital：成立于1991年的企业风险投资业务，重点投资半导体、人工智能、计算基础设施和技术创业公司。2025年 Intel 宣布计划将其分拆为独立基金并保留基石投资者身份；截至已核实资料，不能仅凭该计划认定其已完成独立。
- Arizona Semiconductor Co-Investment Program（Arizona SCIP）：Intel 与 Brookfield 共同参与的美国亚利桑那州晶圆厂投资安排，Intel 保留51%权益，Brookfield 持有49%，主要涉及 Fab 52、Fab 62 等制造设施的融资与建设。
- Ireland SCIP：Intel 与 Apollo 于2024年设立的爱尔兰 Fab 34 晶圆厂投资安排。2026年4月 Intel 以约142亿美元回购 Apollo 持有的49%权益，恢复100%持股。
- Intel Ignite：Intel 创业企业扶持与加速计划，为技术创业公司提供指导、行业资源及合作机会，属于集团创新生态业务。

集团重要法律实体：

- Intel International, Inc.：注册于美国加利福尼亚州，Intel 国际业务体系的重要法律实体。
- Intel Capital Corporation：注册于美国特拉华州，集团投资业务相关法律实体。
- Intel Overseas Funding Corporation：注册于特拉华州，承担部分海外融资及资本管理职能。
- Intel Americas, Inc.：注册于加利福尼亚州，集团美洲地区业务相关实体。
- Intel Corporation (UK) Limited：注册于英国，集团英国业务相关法律实体。
- Intel Electronics Ltd.：注册于以色列，集团当地半导体研发及运营体系的重要实体。
- Intel Kabushiki Kaisha：注册于日本，承担 Intel 日本市场业务。
- Intel China Ltd.：注册于中国，集团中国业务体系的重要实体。
- Intel Semiconductor (Dalian) Ltd.：注册于中国大连，属于集团半导体制造相关法律实体。
- Intel Products (Chengdu) Ltd.：注册于中国成都，涉及半导体封装、测试及相关制造活动。
- Intel Technology Sdn. Berhad：注册于马来西亚，是集团重要的制造及技术运营实体。
- Intel Products Vietnam Co., Ltd.：注册于越南，承担半导体封装、测试和制造相关业务。
- Arizona Fab LLC / Arizona Fab Holdco Inc.：注册于美国特拉华州，属于集团美国晶圆厂投资和持有架构。

以上法律实体主要依据 Intel 截至2025年12月27日的 SEC Exhibit 21.1 披露整理，名单不包含全部子公司。

[image](https://www.google.com/s2/favicons?domain=https://www.sec.gov\&sz=32)

美国证券交易委员会

+2



其他重要股权及历史业务：

- Altera：2015年以约167亿美元收购，主营 FPGA 可编程逻辑芯片及相关开发工具。2025年9月 Intel 向 Silver Lake 出售51%股权，保留49%少数股权，Altera 已脱离 Intel 合并报表范围，不能再视为控股子公司。
- Solidigm：原 Intel NAND 闪存及 SSD 业务。2021年 Intel 将相关业务出售给 SK hynix，并逐步以 Solidigm 品牌独立运营，2025年完成剩余交易，目前不属于 Intel 集团。
- McAfee：Intel 于2011年完成收购，曾将其整合为 Intel Security。2017年出售多数股权后重新独立，2022年消费者业务被投资财团收购，目前不属于 Intel。
- Wind River：2009年 Intel 完成收购，主要开发 VxWorks 实时操作系统及嵌入式软件，2018年出售给 TPG，后来进入其他投资机构的控股体系。
- Intel NUC：2013年推出的小型计算机产品线，2023年 Intel 停止直接经营 NUC 业务，并与 ASUS 达成相关授权和业务转移协议，现有 ASUS NUC 产品不属于 Intel 直接经营的整机产品。
- Tower Semiconductor：以色列晶圆代工企业，Intel 于2022年宣布收购，但2023年因未取得全部必要监管批准而终止交易，目前属于独立上市公司。
- NVIDIA：2025年以50亿美元投资 Intel，同时双方宣布合作开发结合 Intel x86 CPU、NVIDIA NVLink 和 RTX GPU 技术的新一代数据中心与 PC 芯片。双方属于投资与战略技术合作关系，NVIDIA 并非 Intel 的控股母公司。

#### 主要产品

\- Intel Core Ultra 移动处理器：Core Ultra Series 1（Meteor Lake）、Series 2（Lunar Lake、Arrow Lake）、Series 3（Panther Lake），包含 Core Ultra 5、7、9，以及第三代部分产品中的 Core Ultra X7、X9，覆盖轻薄笔记本、AI PC、高性能笔记本及移动工作站。

\- Intel Core Ultra 桌面处理器：Core Ultra 200S（Arrow Lake）、Core Ultra 200S Plus，代表型号包括 Core Ultra 9 285K、Core Ultra 7 265K、Core Ultra 7 270K Plus、Core Ultra 5 245K、Core Ultra 5 250K Plus，主要面向桌面办公、游戏、内容创作和高性能计算。

\- Intel Core 传统消费级处理器：Core i3、Core i5、Core i7、Core i9，以及更新命名体系下的 Core 3、Core 5、Core 7，包含第12代 Alder Lake、第13代 Raptor Lake、第14代 Raptor Lake Refresh 等产品，覆盖入门、主流、高性能和发烧级 PC 市场。

\- Intel 低功耗与入门处理器：Intel Processor N 系列、Intel Core N 系列、Intel Atom 系列，以及历史上的 Pentium、Celeron，主要用于入门笔记本、迷你主机、低功耗设备、工控机及嵌入式系统。其中 Pentium、Celeron 已逐步被新的 Intel Processor 等命名取代。

\- Intel Xeon 服务器处理器：Xeon Scalable、Xeon 6（Granite Rapids、Sierra Forest）、Xeon 6+（Clearwater Forest），面向企业服务器、云计算、虚拟化、数据库、AI 推理和高性能计算。Xeon 6+ 于2026年推出，采用 Intel 18A 工艺，部分型号最多提供288个能效核心。

\- Intel Xeon 工作站处理器：Xeon W-2400、Xeon W-3400、Xeon 600，覆盖专业图形工作站、工程仿真、科学计算、3D 渲染和高性能开发环境。2026年推出的 Xeon 600 最高提供86个性能核心。

\- Intel Arc 消费级独立显卡：Arc A 系列（Alchemist）、Arc B 系列（Battlemage），包括 Arc A380、A580、A750、A770、B570、B580，面向游戏、图形处理、视频编解码和本地 AI 推理，支持 XeSS 超级采样及硬件光线追踪。

\- Intel Arc Pro 专业显卡：Arc Pro A 系列、Arc Pro B 系列，包括 Arc Pro A40、A50、A60、B50、B60、B65、B70，面向 CAD、3D 建模、图形工作站和 AI 推理。2026年的 Arc Pro B70 提供32GB GDDR6 显存，进一步强化专业计算及本地 AI 部署能力。

\- Intel Arc 集成图形与掌机处理器：Intel Iris Xe、Intel Graphics、Intel Arc Graphics，以及2026年推出的 Arc G3、Arc G3 Extreme 掌机处理器，提供图形加速、媒体处理、游戏渲染和移动游戏设备计算能力。

\- Intel Gaudi AI 加速器：Gaudi、Gaudi 2、Gaudi 3，源自 Habana Labs 技术，面向大语言模型训练、推理及数据中心 AI 计算。Gaudi 3 提供 PCIe 加速卡及服务器集群部署方案，与 NVIDIA GPU、AMD Instinct 等产品竞争。

\- Intel 数据中心 GPU 与 AI 推理芯片：Intel Data Center GPU Max Series、Flex Series，以及 Crescent Island 等 AI 推理 GPU 项目，主要涉及高性能计算、媒体处理、云端图形加速及大模型推理。Crescent Island 截至2026年仍处于推进与早期交付阶段，不能视为已大规模商业部署。

\- Intel 网络与以太网控制器：Intel Ethernet 700 Series、800 Series、E810、E830、E835，提供从千兆到高速200GbE网络连接能力，主要用于数据中心服务器、云基础设施和企业网络。

\- Intel 基础设施处理器（IPU）：Intel Infrastructure Processing Unit、IPU E2000、IPU E2100 等系列，负责网络流量处理、基础设施卸载、安全隔离与数据中心资源管理，面向云计算运营商及大型数据中心。

\- Intel Wi-Fi 与无线通信：Intel Wi-Fi 6、Wi-Fi 6E、Wi-Fi 7、Killer Wi-Fi 系列，以及 AX200、AX210、BE200 等无线网卡，覆盖笔记本、台式机、工控设备和无线网络连接。

\- Intel 芯片组与主板平台：Intel Z 系列、B 系列、H 系列、W 系列芯片组，包括 Z790、B760、Z890、B860、W790、W890 等，提供主板 I/O、PCIe 扩展、USB、存储和处理器平台支持。

\- Intel Thunderbolt 高速接口：Thunderbolt 3、Thunderbolt 4、Thunderbolt 5，以及相关控制器和认证体系，主要用于高速数据传输、外接显示器、扩展坞及外置存储设备。

\- Intel vPro 企业计算平台：Intel vPro、Intel vPro Enterprise、Intel vPro Essentials、Intel Active Management Technology（AMT），提供企业级远程管理、硬件安全、设备维护及 IT 终端管理功能。

\- Intel Evo 笔记本认证平台：Intel Evo Platform、Intel Evo Edition，针对轻薄笔记本的性能、续航、即时唤醒、连接体验及综合使用体验制定认证要求，属于平台认证体系，不是独立硬件产品。

\- Intel Foundry 晶圆代工服务：Intel 7、Intel 4、Intel 3、Intel 18A、Intel 18A-P，以及研发规划中的 Intel 14A，提供不同代际的半导体制造工艺。其中 Intel 18A 于2025—2026年进入商业量产阶段，Intel 14A 仍属于面向后续产品及外部客户的先进工艺研发项目。

\- Intel 先进晶体管与供电技术：RibbonFET、PowerVia、FinFET，分别涉及环绕栅极晶体管、背面供电网络及鳍式场效应晶体管，属于 Intel 芯片制造和工艺技术体系。

\- Intel 先进封装技术：Foveros、Foveros Direct、EMIB、EMIB-T、Co-EMIB，提供三维芯片堆叠、多芯粒互连及异构集成技术，服务于 CPU、GPU、AI 加速器及芯片代工业务。

\- Intel 定制芯片与 ASIC 服务：Intel Foundry Custom Silicon、结构化 ASIC 及相关芯片设计支持，面向数据中心、网络设备、AI 基础设施和特殊用途计算，提供芯片定制与制造服务。

\- Intel OpenVINO 人工智能软件：OpenVINO Toolkit、OpenVINO Model Server、OpenVINO GenAI，支持深度学习模型优化、部署及推理加速，可在 Intel CPU、GPU 和 NPU 等硬件上运行。

\- Intel oneAPI 并行计算软件：Intel oneAPI Base Toolkit、oneAPI DPC++/C++ Compiler、oneMKL、oneDNN，提供跨 CPU、GPU 等计算设备的并行编程、数学运算及性能优化能力。

\- Intel 开发与性能分析工具：Intel VTune Profiler、Intel Advisor、Intel Inspector、Intel MPI Library、Intel Distribution for Python，覆盖性能分析、程序优化、并行计算、内存检查和高性能计算开发。

\- Intel AI 与机器学习开发工具：Intel Extension for PyTorch、Intel Neural Compressor、Intel AI Tools、Intel Geti，提供深度学习加速、模型量化、计算优化及计算机视觉 AI 开发支持。

\- Intel 安全与硬件虚拟化技术：Intel SGX、Intel TDX、Intel VT-x、Intel VT-d、Intel AES-NI、Intel CET，覆盖可信执行环境、机密计算、硬件虚拟化、加密加速和控制流保护。

\- Intel 计算加速指令与技术：Intel AVX、AVX2、AVX-512、Intel AMX、Intel DL Boost、Intel QuickAssist Technology（QAT），面向向量运算、矩阵计算、深度学习推理、压缩及加密加速。

\- Intel 图形与媒体软件技术：Intel XeSS、Intel Graphics Software、Intel Media SDK（历史项目）、Intel oneVPL、Intel Video Processing Library，提供游戏超采样、显卡控制、视频编解码和媒体处理技术。

\- Intel 自动驾驶与汽车计算（通过 Mobileye）：Mobileye EyeQ、EyeQ Ultra、Mobileye SuperVision、Mobileye Chauffeur、Mobileye Drive、Mobileye REM，提供车载视觉芯片、辅助驾驶、自动驾驶和道路环境建模技术。

\- Intel 机器人与物理 AI（通过 Mobileye 等业务）：Mentee Robotics 人形机器人系统，以及 Intel Core Ultra 边缘 AI 计算平台，涉及机器人感知、环境理解、运动控制与工业自动化。

\- Intel FPGA 与可编程逻辑（历史控股产品）：Altera Agilex、Stratix、Arria、Cyclone、MAX、Quartus Prime，主要用于通信、工业控制、边缘计算和硬件加速。自2025年9月 Altera 控制权转移至 Silver Lake 后，这些产品属于 Altera 独立业务，不再归入 Intel 控股产品线。
#### 招聘情况
- [招聘官网](https://jobs.intel.cn/intel/home/index#/index/about/icg)
- 服务号: 英特尔招聘在线

![示意图](PixPin_2026-04-25_12-25-27.webp)
![示意图](PixPin_2026-04-25_12-25-57.webp)

只在上海闵行区招聘AI岗位,目标院校是什么不用多说...

- 招聘岗位特别少,看的出来是不愿意在中国招人的那种,可以直接跳过

### Nvidia(英伟达)
入职能送我5090吗😃
#### 公司概况

NVIDIA 是一家全球领先的科技巨头，总部位于美国加利福尼亚州圣克拉拉。公司由黄仁勋、Chris Malachowsky 和 Curtis Priem 于 1993 年创立。其核心竞争力在于设计与研发**图形处理器 (GPU)**、**系统级芯片 (SoC)** 以及支撑高性能计算的 **CUDA** 软件架构。
#### 公司历史

\- 1993—1999｜创立与图形处理器革命：黄仁勋（Jensen Huang）、克里斯·马拉科夫斯基（Chris Malachowsky）与柯蒂斯·普里姆（Curtis Priem）于1993年创立 NVIDIA，最初专注个人电脑图形加速技术。1995年推出首款图形芯片 NV1，1997年发布 RIVA 128，开始在消费级3D图形市场取得竞争力。1999年在纳斯达克上市（NVDA），同年推出 GeForce 256，将硬件变换与光照计算集成进入图形芯片，并将其推广为 GPU（Graphics Processing Unit，图形处理器），逐渐成为 PC 显卡行业的重要企业。

\- 2000—2006｜GeForce 扩张与可编程 GPU：2000年收购 3dfx 的部分图形技术及资产，进一步扩大技术储备。2001年为微软初代 Xbox 提供图形处理芯片，随后推出 GeForce 3、GeForce FX、GeForce 6、GeForce 7 等显卡系列，逐步发展可编程着色器、SLI 多显卡技术及专业图形计算平台。2006年发布 GeForce 8 系列和 Tesla GPU 架构，同时推出 CUDA（Compute Unified Device Architecture）并行计算平台，使 GPU 能够广泛用于图形渲染之外的通用计算任务，为科学计算和人工智能发展建立软件生态基础。

\- 2007—2015｜CUDA 生态与深度学习发展：2007年推出 Tesla 计算加速器，开始进入高性能计算与科学研究市场；2008年收购 AGEIA，将 PhysX 物理模拟技术整合进入 GeForce 生态。此后陆续推出 Fermi（2010）、Kepler（2012）、Maxwell（2014）等 GPU 架构，完善 Tesla、Quadro 和 GeForce 产品体系。2012年 AlexNet 深度神经网络利用 NVIDIA GPU 获得 ImageNet 图像识别竞赛突破性成绩，推动深度学习对 GPU 算力的需求。同期 CUDA、cuDNN 等开发工具逐渐成为机器学习与高性能计算的重要基础设施。

\- 2016—2019｜人工智能计算与 RTX 图形技术：2016年推出 Pascal 架构、Tesla P100 和首款 DGX-1 AI 超级计算机，开始向企业提供软硬件整合的深度学习计算平台。2017年推出 Volta 架构和 Tesla V100，引入 Tensor Core 张量核心，显著提升 AI 矩阵计算能力。2018年推出 Turing 架构和 GeForce RTX 20 系列，将实时光线追踪、Tensor Core 与 AI 图像处理技术引入消费级显卡，并推出 DLSS 深度学习超级采样技术。2019年宣布收购以色列网络芯片企业 Mellanox，进一步向数据中心网络和系统级计算扩张。

\- 2020—2023｜数据中心、AI 加速器与生成式 AI：2020年完成对 Mellanox 的约70亿美元收购，将 InfiniBand 高速互连、以太网交换机和网络适配器整合进入数据中心产品体系。同年推出 Ampere 架构、A100 AI 加速器和 GeForce RTX 30 系列，并宣布收购 Arm，但该交易因监管障碍于2022年终止。2022年推出 Hopper 架构和 H100 GPU、GeForce RTX 40 系列、Omniverse 数字孪生平台，并收购 Bright Computing。2023年 ChatGPT 等生成式 AI 应用带动大型模型训练和推理需求迅速增长，NVIDIA 凭借 H100、CUDA、NVLink、DGX 和网络产品形成完整 AI 计算平台，数据中心业务逐渐成为公司核心增长来源。

\- 2024—2025｜Blackwell 架构与 AI 基础设施平台化：2024年发布 Blackwell GPU 架构、B200、GB200 Grace Blackwell 超级芯片和 GB200 NVL72 机架级系统，进一步整合 GPU、CPU、高速互连与液冷服务器。同年收购 Run:ai、Deci 等企业，强化 GPU 集群调度与模型推理优化能力。2025年推出 Blackwell Ultra、GB300 NVL72、GeForce RTX 50 系列、DGX Spark，以及 Nemotron、Cosmos、Isaac GR00T 等 AI 模型与机器人技术，并收购 SchedMD，持续强化 AI 集群管理。公司逐渐从 GPU 芯片供应商转向覆盖芯片、网络、服务器、模型、软件和云服务的 AI 基础设施企业。

\- 2026｜Vera Rubin 与 AI 工厂生态扩张：2026年正式发布 Vera Rubin 新一代 AI 计算平台，整合 Vera CPU、Rubin GPU、NVLink 6、ConnectX-9、BlueField-4、Spectrum-6，以及通过技术授权引入的 Groq LPU 架构，面向大规模模型训练、推理和 AI 智能体服务。同期推出 Groq 3 LPX 推理加速器、Vera Rubin NVL72、DGX Rubin 等系统，并公布 Feynman 下一代架构路线图。2026年9月宣布计划以约129亿美元收购 Hugging Face，进一步向开源模型和 AI 开发者平台扩张，但交易截至2026年10月尚未完成。公司继续加大对 AI 数据中心、网络互连、机器人、自动驾驶和物理 AI 的投入。

#### 控股公司及子公司

集团主体：NVIDIA Corporation（英伟达公司）

- 总部位于美国加利福尼亚州圣克拉拉（Santa Clara），纳斯达克上市（NVDA），成立于1993年，是全球主要的 GPU、AI 加速计算和数据中心基础设施供应商。
- NVIDIA 本身是集团顶层上市公司，没有另一家企业作为其控股母公司。创始人黄仁勋（Jensen Huang）长期担任总裁兼 CEO，同时担任董事会成员。公司采用公众股东持股结构，主要机构股东包括 Vanguard、BlackRock 等大型资产管理公司。
- NVIDIA 是以芯片设计、软件和计算平台研发为核心的无晶圆厂半导体企业（Fabless），先进 GPU 的制造、封装和存储器供应主要依靠台积电、三星、SK hynix、Micron 等外部供应商，不拥有类似 Intel 的完整先进晶圆制造体系。
- 按2026财年年报及2027财年第二季度财报，集团主要分为计算与网络（Compute & Networking）和图形（Graphics）两个报告分部。前者包括 AI GPU、CPU、网络设备、数据中心系统、AI 软件及相关服务，后者包括 GeForce 游戏显卡、专业可视化 GPU 和图形计算技术。2026年公司对外披露的市场平台主要划分为 Data Center（数据中心）和 Edge Computing（边缘计算）。
- 截至2026年7月26日的季度，NVIDIA 营收约962亿美元，其中数据中心业务约890亿美元，表明 AI 计算基础设施已经成为集团最主要的收入来源。

主要子公司及收购业务：

- Mellanox Technologies：2020年以约70亿美元完成收购，以色列高性能网络芯片与互连技术企业，主营 InfiniBand、以太网交换芯片、高速网卡及数据中心互连系统。现为 NVIDIA 网络业务的重要技术基础，旗下技术发展为 ConnectX、BlueField、Quantum、Spectrum 等系列。
- Cumulus Networks：2020年完成收购，美国数据中心网络软件企业，主营基于 Linux 的网络操作系统 Cumulus Linux，以及自动化网络管理和数据中心交换机软件，相关业务整合进入 NVIDIA Networking。
- SwiftStack：2020年完成收购，美国软件定义存储企业，专注对象存储、多云数据管理和大规模数据基础设施，相关技术整合进入 NVIDIA 数据中心及 AI 存储生态。
- DeepMap：2021年完成收购，美国高精度地图与自动驾驶技术企业，开发高精地图、定位及自动驾驶环境感知技术，相关业务整合进入 NVIDIA DRIVE 自动驾驶平台。
- Bright Computing：2022年完成收购，荷兰高性能计算集群管理软件企业，核心产品为 Bright Cluster Manager，负责服务器集群部署、配置、监控及运维管理，现属于 NVIDIA AI 基础设施软件体系。
- Excelero：2022年完成收购，以色列高性能存储软件企业，主要开发分布式 NVMe 存储技术，相关技术整合进入 NVIDIA 数据中心存储及加速计算平台。
- OmniML：2023年完成收购，美国边缘 AI 优化企业，专注深度学习模型压缩、推理优化及边缘设备部署，相关研发能力整合进入 NVIDIA AI 软件体系。
- Deci AI：2024年完成收购，以色列人工智能模型优化企业，开发模型自动优化、推理加速和模型部署技术，原法律实体已被整合，相关能力用于提升 NVIDIA AI 推理软件生态。
- Run:ai：2024年12月以约7亿美元完成收购，以色列 AI 基础设施管理企业，主营 GPU 集群调度、计算资源虚拟化及 Kubernetes AI 工作负载管理，帮助企业提高 GPU 利用率。
- Shoreline.io：2024年完成收购，美国云基础设施自动化与运维软件企业，开发自动故障诊断、系统监控及事件响应技术，相关团队与技术进入 NVIDIA AI 基础设施业务。
- Brev.dev：2024年完成收购，美国 AI 开发基础设施企业，提供 GPU 云开发环境、远程计算资源管理及模型开发工具，相关能力整合进入 NVIDIA 开发者及云计算生态。
- Lepton AI：2025年完成收购，美国 AI 云计算和推理服务企业，提供 GPU 云资源、模型部署和 AI 应用运行平台，相关技术成为 NVIDIA DGX Cloud Lepton 的重要基础。
- SchedMD：2025年12月完成收购，美国高性能计算软件企业，主要开发与维护 Slurm 开源集群工作负载管理系统，负责大型计算集群的任务排队、资源调度及作业管理。
- AGEIA Technologies：2008年完成收购，美国物理计算技术企业，开发 PhysX 物理模拟引擎和物理加速硬件，相关技术整合进入 GeForce 和 NVIDIA 游戏物理计算生态。
- 3dfx Interactive：2000年 NVIDIA 收购其部分知识产权及资产，获得 Voodoo 图形技术、相关专利和研发资源，进一步强化早期图形芯片业务。该交易不能简单等同于收购并持续运营整个 3dfx 公司。

集团重要法律实体：

- Mellanox Technologies, Ltd.：注册于以色列，NVIDIA 100%控股的重要子公司，承担高性能网络芯片与数据中心互连技术相关业务。
- NVIDIA International, Inc.：注册于美国特拉华州，NVIDIA 100%控股，属于集团国际业务相关法律实体。
- NVIDIA Singapore Pte Ltd：注册于新加坡，NVIDIA 100%控股，属于集团亚洲及国际业务运营的重要法律实体。

以上三家为 NVIDIA 截至2026年1月25日的 SEC Exhibit 21.1 中披露的重要子公司。该文件允许省略部分非重要子公司，因此不代表集团全部法律实体。前述部分收购企业已经整合进入 NVIDIA 内部业务，不应全部视为仍然独立存在的子公司。

其他重要投资、合作及股权关系：

- Arm Holdings：英国半导体架构设计企业，主营 ARM CPU 指令集与处理器 IP 授权。NVIDIA 于2020年宣布计划以约400亿美元收购 Arm，但因监管障碍于2022年终止交易。Arm 后来独立上市，目前不属于 NVIDIA 控股子公司。
- Groq：美国 AI 推理芯片企业，开发 LPU（Language Processing Unit）语言处理器。2025年12月与 NVIDIA 达成约170亿美元规模的非独家技术授权及人才引进协议，NVIDIA 获得相关推理技术使用权并吸纳部分核心研发人员。Groq 仍然独立运营，NVIDIA 未通过该交易收购其股权或整体公司。
- Hugging Face：美国 AI 开源模型与开发者平台，提供模型、数据集、推理工具及机器学习应用托管服务。2026年9月 NVIDIA 宣布以约129亿美元收购，计划保留其开放平台属性。根据交易公告，预计2027年上半年完成交割，截至2026年10月仍属于拟收购企业。
- CoreWeave：美国 AI 云计算企业，主营 GPU 云基础设施及大型模型训练与推理服务。NVIDIA 长期与其开展 GPU 供应、云服务和技术合作，2026年1月进一步投资20亿美元，成为重要股东，但 CoreWeave 仍为独立上市公司。
- Intel：美国半导体设计与制造企业。2025年 NVIDIA 以50亿美元进行战略股权投资，并宣布合作开发结合 Intel x86 CPU、NVIDIA NVLink 和 RTX GPU 技术的计算产品。双方属于投资与技术合作关系，不存在控股关系。
- Marvell Technology：美国数据中心网络与定制芯片设计企业，2026年3月 NVIDIA 宣布投资20亿美元，并围绕 NVLink Fusion、定制 AI 芯片和硅光互连开展合作，Marvell 保持独立运营。
- Synopsys：美国电子设计自动化（EDA）软件企业，NVIDIA 于2025年宣布投资20亿美元，双方围绕芯片设计、仿真和 AI 加速工程软件开展合作，Synopsys 不属于 NVIDIA 控股子公司。
- 台积电（TSMC）：NVIDIA 最重要的先进芯片制造合作伙伴之一，负责生产多代 GPU、AI 加速器和相关芯片，并提供先进封装服务。双方属于芯片设计与代工供应关系，台积电并非 NVIDIA 子公司。

#### 主要产品

\- GeForce RTX 消费级桌面显卡：GeForce RTX 20、RTX 30、RTX 40、RTX 50 系列，最新 Blackwell 架构产品包括 RTX 5090、5080、5070 Ti、5070、5060 Ti、5060、5050，主要面向 PC 游戏、图形渲染、视频处理及本地 AI 计算。

\- GeForce RTX 笔记本显卡：GeForce RTX 5090 Laptop GPU、5080 Laptop GPU、5070 Ti Laptop GPU、5070 Laptop GPU、5060 Laptop GPU、5050 Laptop GPU，主要用于游戏本、专业创作笔记本及移动工作站。

\- NVIDIA RTX PRO 专业图形显卡：RTX PRO 6000、5500、5000、4500、4000、2000 Blackwell 系列，以及历史上的 Quadro、RTX A 系列，面向 CAD、3D 建模、工程仿真、专业渲染、科学计算及本地 AI 推理。

\- GeForce 游戏图形技术：NVIDIA DLSS、DLSS Multi Frame Generation、Ray Tracing、RTX Neural Rendering、NVIDIA Reflex、NVIDIA G-SYNC、NVIDIA RTX Remix，覆盖 AI 超分辨率、帧生成、光线追踪、低延迟游戏及显示同步技术。

\- GeForce 软件与创作者工具：NVIDIA App、NVIDIA Broadcast、NVIDIA Studio、NVIDIA Canvas、NVIDIA Game Ready Driver、NVIDIA Studio Driver，提供显卡管理、游戏优化、直播降噪、AI 绘图和创作者软件支持。

\- GeForce NOW 云游戏服务：GeForce NOW、GeForce NOW Ultimate 等订阅服务，利用云端 NVIDIA GPU 运行游戏，并将画面串流至电脑、手机、平板和电视等终端。

\- NVIDIA SHIELD 家庭娱乐设备：SHIELD TV、SHIELD TV Pro，属于历史推出的 Android TV 流媒体硬件，提供影音播放、游戏串流及家庭娱乐功能。

\- NVIDIA 数据中心 GPU：Tesla P100、V100、A100、H100、H200、B100、B200、B300，以及 Rubin 系列 GPU，面向 AI 模型训练、推理、科学计算、高性能计算及大规模数据处理。其中 Tesla 为历史品牌，后续数据中心 GPU 逐渐以架构和芯片型号命名。

\- NVIDIA Grace 与 Vera CPU：NVIDIA Grace CPU、Grace CPU Superchip、Grace Hopper Superchip（GH200）、Grace Blackwell Superchip（GB200、GB300）、Vera CPU，采用 ARM 架构，面向服务器、AI 数据中心和高性能计算，通常与 NVIDIA GPU 配套工作。

\- NVIDIA AI 超级芯片与计算平台：NVIDIA GH200、GB200、GB300、Vera Rubin、Rubin GPU、Vera CPU，覆盖 GPU 与 CPU 高速互连、统一内存架构及大规模 AI 训练和推理平台。

\- NVIDIA Vera Rubin 平台：Vera Rubin NVL72、NVIDIA Vera CPU Rack、NVIDIA Groq 3 LPX、NVIDIA BlueField-4 STX、NVIDIA Spectrum-6 SPX，整合 GPU、CPU、LPU、网络交换及存储加速，面向大规模 AI 工厂和智能体计算。其中部分平台于2026年进入量产和初期交付阶段。

\- NVIDIA 下一代 GPU 架构：Blackwell、Blackwell Ultra、Rubin、Rubin Ultra、Feynman，属于 NVIDIA 2024—2028年前后的 AI 计算技术路线。其中 Blackwell 已大规模商业部署，Rubin 正推进量产与交付，Rubin Ultra 和 Feynman 属于后续规划架构。

\- NVIDIA HGX 数据中心平台：HGX H100、HGX H200、HGX B200、HGX B300，提供多 GPU 服务器计算板、互连架构及参考设计，主要面向云服务商、AI 数据中心及企业服务器制造商。

\- NVIDIA DGX AI 超级计算机：DGX A100、DGX H100、DGX H200、DGX B200、DGX B300、DGX GH200，以及 DGX SuperPOD，属于面向 AI 研发机构、企业和大型数据中心的软硬件集成计算系统。

\- NVIDIA DGX 个人 AI 计算设备：DGX Spark、DGX Station，主要面向开发者、研究人员和企业 AI 团队，提供桌面级本地模型开发、推理、微调和高性能计算能力。

\- NVIDIA DGX Cloud 云计算：DGX Cloud、DGX Cloud Lepton、NVIDIA AI Cloud，提供 GPU 算力租赁、模型训练、推理和分布式 AI 开发服务，并与外部云计算企业共同构建 AI 基础设施。

\- NVIDIA AI Enterprise 企业软件：NVIDIA AI Enterprise、NVIDIA NIM、NVIDIA NeMo、NVIDIA AI Blueprints、NVIDIA Base Command Manager，提供企业 AI 模型部署、智能体开发、GPU 集群管理及生产环境技术支持。

\- NVIDIA AI 推理框架：TensorRT、TensorRT-LLM、Triton Inference Server、NVIDIA Dynamo、NVIDIA Inference Microservices（NIM），主要用于模型优化、量化、推理加速、分布式部署及在线模型服务。

\- NVIDIA AI 基础模型与智能体：NVIDIA Nemotron、NVIDIA Cosmos、NVIDIA Isaac GR00T、NVIDIA Alpamayo、NVIDIA BioNeMo，分别覆盖语言模型与智能体、物理世界模型、机器人控制、自动驾驶和生物医药 AI。

\- CUDA 并行计算平台：CUDA Toolkit、CUDA Runtime、CUDA Driver API、CUDA C++、CUDA Python、NVCC、Nsight Compute、Nsight Systems，提供 GPU 通用计算、程序编译、性能分析及开发工具。

\- NVIDIA 深度学习与计算库：cuDNN、cuBLAS、cuFFT、cuSPARSE、NCCL、CUTLASS、Thrust、CUDA-X，覆盖矩阵计算、神经网络、快速傅里叶变换、稀疏计算、多 GPU 通信和计算优化。

\- NVIDIA 数据科学与 AI 开发框架：RAPIDS、cuDF、cuML、DALI、NVIDIA Modulus、cuOpt，涉及 GPU 数据处理、机器学习、数据加载、科学仿真和组合优化。

\- NVIDIA 高速互连技术：NVLink、NVLink Switch、NVSwitch、NVLink Fusion，提供 GPU、CPU 及 AI 加速芯片之间的高速互连，支持单机、多 GPU 和机架级 AI 计算。

\- NVIDIA InfiniBand 网络：NVIDIA Quantum、Quantum-2、Quantum-X800、ConnectX、NVIDIA UFM，面向 AI 集群、高性能计算和数据中心的低延迟、高带宽网络。

\- NVIDIA 以太网交换技术：NVIDIA Spectrum、Spectrum-X、Spectrum-XGS、Spectrum-6、Cumulus Linux，提供数据中心以太网交换机、网络操作系统及 AI 网络解决方案。

\- NVIDIA 网络适配器与 DPU：ConnectX-6、ConnectX-7、ConnectX-8、ConnectX-9、BlueField-2、BlueField-3、BlueField-4，以及 NVIDIA DOCA，覆盖高速网卡、基础设施处理器、网络卸载、数据中心安全及存储加速。

\- NVIDIA AI 工厂与数据中心管理：NVIDIA Mission Control、NVIDIA Base Command、NVIDIA Run:ai、NVIDIA Bright Cluster Manager、Slurm、NVIDIA DSX，涉及 AI 集群部署、GPU 调度、任务管理、监控、数据中心数字孪生及基础设施运营。

\- NVIDIA Omniverse 数字孪生平台：NVIDIA Omniverse、Omniverse Kit、Omniverse Nucleus、Omniverse USD Composer、Omniverse Cloud、Omniverse DSX Blueprint，提供基于 OpenUSD 的三维协作、工业仿真、数字孪生及 AI 工厂建模技术。

\- NVIDIA RTX 渲染与可视化软件：NVIDIA RTX Renderer、NVIDIA OptiX、NVIDIA Iray、NVIDIA RTX Virtual Workstation、NVIDIA vGPU，提供光线追踪、专业图形渲染、虚拟工作站和 GPU 虚拟化技术。

\- NVIDIA Jetson 边缘 AI 计算平台：Jetson Nano、Jetson Xavier、Jetson Orin Nano、Jetson Orin NX、Jetson AGX Orin、Jetson AGX Thor，提供面向机器人、无人机、工业视觉和智能终端的低功耗 AI 计算模组。

\- NVIDIA 机器人开发平台：NVIDIA Isaac、Isaac Sim、Isaac Lab、Isaac ROS、Isaac GR00T、Isaac OS，覆盖机器人仿真、强化学习、视觉导航、运动控制和人形机器人基础模型。

\- NVIDIA 物理 AI 与世界模型：NVIDIA Cosmos、Cosmos Predict、Cosmos Transfer、Cosmos Reason、NVIDIA Omniverse NuRec，提供物理环境模拟、合成数据生成、机器人和自动驾驶系统训练。

\- NVIDIA 自动驾驶计算平台：NVIDIA DRIVE AGX Orin、DRIVE AGX Thor、NVIDIA Hyperion、DriveOS、NVIDIA DRIVE AV，提供车载 AI 芯片、自动驾驶软件、传感器参考架构及车辆计算平台。

\- NVIDIA 自动驾驶 AI 与安全技术：NVIDIA Alpamayo、NVIDIA Halos、NVIDIA DRIVE Sim、NVIDIA Omniverse NuRec，面向自动驾驶推理、道路场景仿真、安全验证及自动驾驶系统开发。

\- NVIDIA 智能城市与工业视觉：NVIDIA Metropolis、NVIDIA DeepStream SDK、NVIDIA Holoscan、NVIDIA AI Blueprint for Video Search and Summarization，涉及视频分析、工业检测、实时传感器处理、医疗影像与智能城市应用。

\- NVIDIA 医疗与生命科学 AI：NVIDIA Clara、MONAI、BioNeMo、NVIDIA Parabricks、NVIDIA Holoscan，提供医疗影像分析、药物发现、基因组分析、医学 AI 开发和医疗设备实时计算支持。

\- NVIDIA 通信与 AI-RAN：NVIDIA Aerial、NVIDIA Aerial CUDA-Accelerated RAN、NVIDIA AI-RAN、NVIDIA ARC，面向5G、6G、无线接入网络及 AI 驱动的通信基础设施。

\- NVIDIA 量子计算与科学计算：NVIDIA CUDA-Q、NVIDIA cuQuantum、NVIDIA NVQLink、NVIDIA Modulus，提供量子计算模拟、量子与 GPU 混合计算、科学机器学习及物理仿真。

\- NVIDIA 开发者与创业生态：NVIDIA Developer Program、NVIDIA NGC Catalog、NVIDIA Inception、NVIDIA Deep Learning Institute（DLI）、NVIDIA GTC，分别提供软件工具、模型与容器资源、创业支持、技术培训及开发者交流平台。

#### 招聘情况
- [招聘官网](https://www.nvidia.cn/about-nvidia/careers/)
- 公众号: NVIDIA英伟达

![示意图](PixPin_2026-04-25_12-45-11.webp)
招聘岗位在外企里算多的了,建议优先考虑,但比较偏硬件

### Tesla (特斯拉)
尽管是汽车公司,但是还是有不少软件需求的...
#### 公司概况
特斯拉（Tesla, Inc.）总部位于德克萨斯州奥斯汀，是一家集汽车与清洁能源为一体的美国跨国公司。公司由马丁·艾伯哈德和马克·塔彭宁于 2003 年创立，随后由埃隆·马斯克领投并出任 CEO。特斯拉不仅通过 **Model S/3/X/Y** 等车型引领了全球纯电动汽车（BEV）市场，还涉足家用及电网级储能设备、太阳能产品。尽管在 2025 年底失去了全球最大电动汽车制造商的地位，但其市值多次突破 1 万亿美元，稳居全球市值最高车企。
##### 马斯克控股公司名列
这些企业并没有像其他巨头一样整合成一家公司,所以有必要在这里说一下:
* **Tesla (特斯拉)**：马斯克担任 CEO 且为第一大股东。虽然是上市公司，但他通过持股和极高的个人影响力行使控制权。
* **SpaceX (太空探索技术公司)**：马斯克担任 CEO 兼首席技术官，拥有绝对控股权。这是目前全球估值最高的私有航天企业，旗下包含 **Starlink (星链)** 卫星互联网业务。
* **X (原 Twitter)**：马斯克于 2022 年全资收购并将其私有化。目前他拥有 100% 的决策权。
* **xAI**：马斯克于 2023 年创立的人工智能公司，旨在开发 **Grok** 等大模型，与 OpenAI 竞争。其计算资源常与 X 平台深度整合。
* **Neuralink**：脑机接口技术公司，马斯克为联合创始人及主要控股人，致力于实现人脑与计算机的直接连接。
* **The Boring Company (隧道挖掘公司)**：马斯克创立的地下交通基础设施公司，旨在通过超高速隧道解决城市拥堵。


#### 招聘情况
- 公众号: 特斯拉招聘

社会招聘在[官网](https://www.tesla.cn/careers),但校园招聘用的是[第三方平台](https://app.mokahr.com/campus-recruitment/tesla/),看不懂了.

![示意图](PixPin_2026-04-25_13-22-55.webp)


服务岗位很多,软件类的岗位还是很少的

### AMD 
岗位均偏硬件方向
#### 公司概况
AMD（Advanced Micro Devices,超威半导体）总部位于加州圣克拉拉，由杰里·桑德斯于 1969 年创立，是硅谷历史最悠久的半导体巨头之一。公司经历了从存储器生产到 x86 处理器授权制造，再到自研架构的战略演变，凭借 **Zen** 架构及 **Ryzen（锐龙）**、**EPYC（霄龙）** 系列处理器，AMD 在 2020 年代实现了史诗级逆袭：不仅在 2022 年市值首次超越宿敌英特尔，更在 2026 年初将其桌面 CPU 市场份额推至 36.4% 的历史新高，并在高利润的服务器营收份额中突破 41%。通过 2022 年对 **Xilinx（赛灵思）** 的世纪收购，AMD 完成了从 PC 芯片商向覆盖数据中心、AI、嵌入式及游戏主机的全能型高性能计算领导者的转型。
#### 公司历史
- [Wiki](https://en.wikipedia.org/wiki/Advanced_Micro_Devices)
##### 1969–1981：初创与“第二供应商”模式
* **起源与创立**：1969年5月1日，杰里·桑德斯（Jerry Sanders）与七位仙童半导体同事共同创立 AMD。由于起步比英特尔晚一年，AMD 最初作为“第二供应商”，生产由仙童和国家半导体设计的逻辑芯片，并以美军标准（Mil-Spec）的严苛品控赢得了初期市场。
* **进入处理器市场**：1975年，AMD 通过逆向工程推出了英特尔 8080 的克隆版 **Am9080**。1976年，两家公司签署了微代码交叉授权协议，确立了长期竞合关系的法律基础。
* **西门子注资**：1977年，德国西门子购入 AMD 20% 股份，资金注入助力其产品线扩张及海外工厂建设。

##### 1982–2005：x86 授权与自主研发的转型
* **IBM 强制授权**：1982年，因 IBM 要求其 PC 必须拥有两个处理器来源，英特尔被迫与 AMD 签署技术交换协议，AMD 成为 8086、80186、80286 芯片的法定授权制造商。
* **走向独立竞争**：80年代中后期，由于日本半导体的低价倾销，AMD 退出 DRAM 市场。1991年推出兼容英特尔架构但完全自研的 **Am386**，标志着两家公司正式进入直接竞争。
* **战略收购**：1996年收购 NexGen 奠定了 **AMD K6** 的成功。2003年，为专注处理器业务，将闪存业务分拆成立 Spansion（后与富士通合资）。

##### 2006–2019：架构动荡与苏姿丰时代的复兴
* **ATI 世纪收购**：2006年以54亿美元收购显卡巨头 **ATI**，AMD 成为全球唯一同时拥有高性能 CPU 和 GPU 技术的公司。
* **轻资产化转型**：2008-2009年，AMD 将其制造部门分拆为独立的代工厂 **GlobalFoundries**，转型为专注于芯片设计的“无厂”（Fabless）半导体公司。
* **濒临破产与主机救命**：2010年代初期，受 Bulldozer 架构失利及 Intel 挤压，AMD 裁员超 25%。最终依靠为 **PS4** 和 **Xbox One** 提供半定制芯片带来的稳定现金流度过危机。
* **Lisa Su 掌舵**：2014年苏姿丰（Lisa Su）出任 CEO，将战略重心转向高性能计算和数据中心。2017年 **Zen** 架构及 **Ryzen（锐龙）** 系列发布，AMD 开始在性能和能效比上反超英特尔。

##### 2020–2026：AI 爆发与市场格局重塑
* **赛灵思并购**：2022年完成对 **Xilinx（赛灵思）** 的500亿美元收购，极大强化了其在 FPGA 和自适应计算领域的地位。
* **服务器与 AI 逆袭**：
    * **份额跃升**：至2025年7月，AMD 在服务器 CPU 市场的份额已攀升至 **36.5%**。
    * **算力竞赛**：2024-2025年连续收购 Silo AI 和 ZT Systems 以构建 AI 生态。2025年6月发布 **MI400** 系列 AI 芯片（Helios 服务器核心）。
    * **OpenAI 深度绑定**：2025年10月，AMD 与 **OpenAI** 达成协议，未来五年内供应 6GW 的 AI 处理器。作为交易，OpenAI 获得增持 AMD 10% 股份的期权。
* **市值巅峰**：2024年市值首次突破 3000 亿美元。2026年初，随着 AI 算力需求爆发，AMD 已成为 Nvidia 在数据中心推理市场的主要竞争对手。

---

#### 控股公司及产品

##### 核心事业部
* **Computing and Graphics**：负责锐龙（Ryzen）消费级 CPU 及 Radeon 显卡。
* **Data Center Solutions**：负责霄龙（EPYC）服务器芯片及 **Instinct MI** 系列 AI 加速器。
* **Embedded Group**：整合赛灵思业务，专注 FPGA、自适应 SoC。
* **Semi-Custom Business**：负责游戏机（PS5/Xbox）及手持设备芯片。

##### 核心产品线
* **桌面/笔记本 CPU**：Ryzen 5/7/9, Ryzen AI (集成 NPU)。
* **服务器 CPU**：EPYC (Gen 4/5/6)。
* **AI/高性能计算**：**AMD Instinct MI300/MI400** 系列。
* **可编程器件**：Versal Adaptive SoC, Virtex FPGA。
* **图形技术**：Radeon RX 系列显卡, **FSR (FidelityFX Super Resolution)** 图像技术。
#### 招聘情况
- [招聘官网](https://careers.amd.com/careers-home/jobs)
![示意图](PixPin_2026-04-25_13-36-03.webp)

招的岗位也很多,但不少是面向AI模型和硬件架构的,难度很高.

### Cisco (思科)
岗位很少,可直接跳过
#### 公司概况
思科（Cisco Systems）总部位于加州圣何塞，由斯坦福大学两位计算机科学家于 1984 年创立，是全球联网技术与网络安全领域的绝对领导者。作为 LAN（局域网）多协议路由系统的先驱，思科在 2000 年互联网泡沫巅峰期曾一度超越微软成为全球市值最高的公司，目前市值约 3170 亿美元。公司业务深度覆盖核心网络硬件、网络安全、云计算、物联网（IoT）及人工智能，拥有 Webex、OpenDNS 等知名品牌.
#### 公司历史
- [Wiki](https://en.wikipedia.org/wiki/Cisco)


##### 1984–1995：多协议路由器的先驱与上市
* **起源与争议**：1984 年 12 月，斯坦福大学计算机科学家列昂纳德·波萨克和桑迪·勒纳夫妇创立思科。初期产品源于斯坦福校内的“蓝箱”（Blue Box）多协议路由器。由于涉及知识产权争议，思科于 1987 年向斯坦福支付了授权费。
* **命名与品牌**：公司名称取自旧金山（San Fran**cisco**），标志则是由金门大桥的双塔抽象而成的电波信号。
* **走向公众**：1990 年思科在纳斯达克上市。同年，创始人勒纳因与资方冲突被解雇，波萨克随之辞职。
* **早期战略**：思科凭借 **Cisco 2500** 等经典型号统治市场，并开始通过收购（如 Crescendo）切入以太网交换领域，形成了著名的 **Catalyst** 业务线。

##### 1996–2012：互联网泡沫与业务转型
* **巅峰时刻**：在约翰·钱伯斯的领导下，思科抓住互联网协议（IP）普及的浪潮。2000 年互联网泡沫顶峰，其市值突破 **5000 亿美元**，一度成为全球市值最高的公司。
* **技术重塑**：面对 Juniper 等对手在硬件转发上的挑战，思科自研了高性能 **ASIC** 芯片，并于 2004 年推出 **CRS-1** 核心路由器。
* **消费市场尝试与撤退**：曾通过收购 Linksys 尝试进入家庭消费市场，并提出“人类网络”口号。但 2011 年后因利润不及预期，思科大幅裁员，并在 2013 年出售了 Linksys，重新聚焦企业级服务。

##### 2013–2023：云转型与安全转型
* **领导层交替**：2015 年，钱伯斯卸任，查克·罗宾斯接任 CEO。思科开始从单纯的硬件厂商向**软件订阅与服务模式**转型。
* **核心收购**：2013 年以 27 亿美元收购 **Sourcefire**，强化网络安全能力。2017 年推出 **Cisco Umbrella** 云安全网关。
* **自研芯片突破**：2019 年发布 **Silicon One** ASIC 芯片，打破了 Broadcom 在高速网络芯片市场的垄断。
* **退出俄罗斯**：2022 年俄乌冲突后，思科停止在俄销售并于 2023 年销毁了无法复运出口的价值 2300 万美元的库存设备。

##### 2024–2026：AI 驱动与 Splunk 时代的开启
* **史上最大收购**：2024 年 3 月，思科以 **280 亿美元** 完成对网络安全与数据分析巨头 **Splunk** 的收购，标志着思科全面向 AI 驱动的监控与安全领域转型。
* **AI 伦理与技术协作**：2024 年 4 月，CEO 罗宾斯与教皇方济各签署《罗马 AI 伦理倡议》。2026 年，思科继续优化其 Silicon One 芯片至 G200 规格，支持 **51.2 Tbit/s** 的超高速 AI 算力集群网络。
* **结构调整**：2024 至 2025 年间，思科多次精简团队以整合网络、安全与协作部门。尽管如此，至 2025 年底其财报显示营收仍稳步增长，市值维持在 **3170 亿美元** 左右。

#### 控股公司及产品

##### 核心事业部
* **Networking (网络)**：交换机（Catalyst、Nexus）、路由器（ASR、ISR）。
* **Security (安全)**：防火墙、云安全服务（Umbrella、Duo）、Splunk 数据分析平台。
* **Collaboration (协作)**：Webex 会议系统、IP 电话及智能协同终端。
* **Observability (可观测性)**：集成 AppDynamics 与 Splunk，提供全栈监控服务。

##### 关键子品牌与收购实体
* **Splunk**：2024 年并入，负责网络安全与机器数据分析的核心。
* **Meraki**：云管理网络设备的领导者。
* **Webex**：全球领先的企业级音视频协作平台。
* **AppDynamics**：应用性能管理（APM）平台。

##### 核心产品线
* **硬件架构**：**Catalyst** 系列交换机（企业网核心）、**Nexus**（数据中心）、**Silicon One** 芯片。
* **软件系统**：**Cisco IOS / IOS-XE / IOS-XR**（网络操作系统）、**Cisco DNA Center**。
* **人工智能**：**Webex AI Assistant**（实时翻译与摘要）、**AI-Native Security Cloud**。


#### 招聘情况
![示意图](PixPin_2026-04-25_13-44-29.webp)
招人,但都是无关紧要的岗位.
### Airbnb (爱彼迎)
岗位很少,可直接跳过
#### 公司概况
Airbnb（爱彼迎）总部位于旧金山，由布莱恩·切斯基、乔·杰比亚和内森·布莱查奇克于 2008 年创立，是全球共享经济模式的开创者。作为一家轻资产的在线旅行租赁平台，它通过连接房东与房客，提供从气垫床到城堡的多样化住宿及当地体验服务，并从中抽取佣金。尽管经历了 2020 年疫情的冲击及 2022 年撤出中国本土房源市场的战略调整，Airbnb 目前仍是全球市值最高的旅游科技公司之一，市值超 1000 亿美元。
#### 公司历史
- [Wiki](https://en.wikipedia.org/wiki/Airbnb)

##### 2007–2009：从“气垫床”到“孵化器”
* **起源**：2007 年，乔·杰比亚和布莱恩·切斯基为了支付旧金山的房租，在公寓里放置了三张气垫床并提供早餐（Airbed and Breakfast）。2008 年，内森·布莱查奇克加入并担任 CTO，公司正式成立。
* **筹资奇招**：早期公司极度缺钱，创始人曾在 2008 年大选期间设计并销售定制款麦凯恩和奥巴马主题早餐麦片（Obama O's），赚取了 3 万美元的启动资金。
* **Y Combinator**：2009 年公司进入顶级孵化器 YC。在保罗·格雷厄姆的建议下，创始人飞往纽约亲自为房源拍摄高质量照片，这一举动成为公司业绩的转折点。

##### 2010–2019：共享经济的全球化
* **指数级增长**：2011 年，Airbnb 获得红杉资本注资，估值突破 10 亿美元，正式开启全球扩张。
* **体验业务**：2016 年推出 **Airbnb Experiences**（体验），将业务从单一的住宿扩展到由当地人领队的旅游活动。
* **中国市场**：2015 年正式进入中国，起名“爱彼迎”。

##### 2020–2026：疫情冲击、上市与业务重塑
* **裁员与转型**：2020 年初受疫情重创，营收暴跌 80%。布莱恩·切斯基随后宣布裁员 25% 并大幅削减非核心项目（如酒店和交通）。
* **IPO**：2020 年 12 月，Airbnb 在纳斯达克上市。尽管处于疫情中，其市值在首日即突破 1000 亿美元。
* **后疫情策略**：随着远程办公普及，Airbnb 转向推广“长租”和“非城市中心”房源。
* **退出中国本土市场**：2022 年 5 月，Airbnb 宣布停止中国本土房源的经营，保留跨境旅游业务（Outbound），将重心转回服务出境游的中国游客。
* **AI 整合 (2025-2026)**：2026 年，Airbnb 深度整合了 **Joule-like** 生成式 AI 系统，用户可以通过自然语言描述复杂的旅行方案（如“适合带狗、有恒温泳池且附近有酒庄的意式庄园”），AI 可实现端到端的筛选与预订。

#### 控股公司及产品

##### 核心管理主体
* **Airbnb, Inc.**：位于旧金山的母公司，负责全球平台运营。
* **Airbnb China (爱彼迎中国)**：现阶段主要负责中国游客的海外房源预订及跨境服务支持。

##### 核心产品线
* **Airbnb Stays**：核心住宿业务，涵盖单间、整套公寓、独特房源（如树屋、城堡）。
* **Airbnb Experiences**：由当地达人提供的徒步、烹饪、工作坊等在地化服务。
* **Airbnb for Work**：针对企业出差团队的商务住宿管理工具。
* **Airbnb Luxe**：提供经过严苛筛选的高端豪华住宅及管家服务。


#### 招聘情况
- [招聘官网](https://careers.airbnb.com/positions/?_where_you_work=china)

内地岗位很少:
![示意图](PixPin_2026-04-25_15-53-18.webp)
### SAP
#### 公司概况
SAP SE（思爱普）总部位于德国沃尔多夫，由五位前 IBM 工程师于 1972 年创立，是全球最大的企业管理软件（ERP）供应商。作为欧洲市值最高的科技公司及全球最大的非美软件企业，SAP 专注于开发能够处理企业核心业务流程（如财务、后勤、人力资源）的集成系统。从早期的 R/2、R/3 架构到如今基于内存计算技术的 **S/4HANA** 平台，SAP 的产品支撑着全球绝大多数大型企业的运作。其业务遍布 180 个国家，是德国 DAX 指数及欧洲蓝筹股的核心成分股，代表了企业级应用软件的工业标准。
#### 公司历史

\- 1972—1980｜创立与企业管理软件起步：迪特马尔·霍普（Dietmar Hopp）、哈索·普拉特纳（Hasso Plattner）、克劳斯·韦伦罗伊特（Claus Wellenreuther）、克劳斯·奇拉（Klaus Tschira）和汉斯-维尔纳·赫克托（Hans-Werner Hector）五名前 IBM 员工于1972年在德国创立 SAP，最初名称为 Systemanalyse Programmentwicklung（系统分析与程序开发）。1973年推出财务会计软件 RF，逐渐发展为 SAP R/1，实现财务、采购、库存等企业业务数据的实时处理和集成。1979年开始研发 SAP R/2，1980年迁入德国沃尔多夫（Walldorf）总部，逐步形成标准化企业管理软件的商业模式。

\- 1981—1991｜大型机 ERP 与国际化扩张：1980年代初正式推广 SAP R/2，将财务会计、物料管理、生产计划、销售和人力资源管理整合至大型机系统，使大型企业能够跨部门共享实时业务数据。1988年在德国证券交易所上市，并改组为 SAP AG。公司逐步进入欧洲、美国和亚洲市场，与 IBM 等大型计算机厂商合作，推动企业资源规划（Enterprise Resource Planning，ERP）软件在大型跨国企业中的应用。

\- 1992—2000｜R/3 架构与全球 ERP 市场扩张：1992年推出 SAP R/3，采用客户端、应用服务器和数据库三层架构，支持 Unix、Windows NT 等系统及多种数据库，大幅提升软件部署的灵活性。SAP R/3 逐渐成为全球大型企业 ERP 系统的重要标准，推动 SAP 向全球企业软件市场扩张。1998年在纽约证券交易所上市，1999年推出 mySAP.com 战略，将 ERP 与互联网、电子商务、供应链协作和企业门户结合，开始从单一 ERP 软件向综合企业应用平台转型。

\- 2001—2009｜企业应用套件与技术平台：2001年收购企业门户软件公司 TopTier，随后发展 SAP NetWeaver 中间件和企业应用集成平台。2004年推出 SAP ERP Central Component（ECC）及新一代 SAP Business Suite，形成 ERP、CRM、SCM、SRM 等企业应用产品体系。2008年完成对商业智能软件企业 Business Objects 的收购，扩展报表、数据分析和商业智能产品。同期发展 SAP Business One、SAP Business ByDesign 等产品，逐步覆盖中小企业市场，并从传统 ERP 向企业应用、数据库与分析平台扩展。

\- 2010—2014｜内存数据库与云计算转型：2010年推出 SAP HANA 内存数据库，并以约58亿美元收购数据库企业 Sybase，增强数据库、移动技术和数据处理能力。2011年 SAP HANA 开始进入实际商业应用，显著提升实时分析和业务计算性能。2012年收购 SuccessFactors 和 Ariba，进入云端人力资源管理与采购网络市场；2013年收购 Hybris，扩展电子商务业务；2014年收购 Fieldglass 和 Concur，形成云端人力资源、采购、差旅与费用管理产品体系。同年公司改制为 SAP SE（欧洲股份公司），开始加快从本地软件授权向云服务订阅转型。

\- 2015—2019｜S/4HANA 与云 ERP 生态：2015年推出 SAP S/4HANA，基于 HANA 内存数据库重构核心 ERP 系统，采用简化数据模型、实时分析与 SAP Fiori 用户界面，逐步取代传统 SAP ECC。同期发展 SAP Cloud Platform、SAP HANA Cloud 和云端企业应用。2018年收购 CallidusCloud 和 Qualtrics，扩展销售绩效、客户体验与员工体验管理。2019年推出 SAP Intelligent Enterprise 战略，推动 ERP、供应链、人力资源、客户体验和数据分析系统集成，形成更加完整的企业云应用生态。

\- 2020—2023｜云优先战略与企业数字化转型：2020年克里斯蒂安·克莱因（Christian Klein）出任 CEO，公司进一步将战略重点转向云 ERP、企业流程管理和订阅服务。2021年推出 RISE with SAP，整合 S/4HANA Cloud、技术平台和转型服务，并收购 Signavio、AppGyver，强化业务流程管理与低代码开发。2022年收购 Taulia，扩展供应链金融与营运资本管理；2023年收购 LeanIX，强化企业架构管理，并出售 Qualtrics 全部股权。同期发展 SAP Business Technology Platform（BTP）、SAP Datasphere 和生成式 AI 助手 Joule，推动业务应用、数据分析和人工智能一体化。

\- 2024—2025｜Business Suite 重组与企业 AI：2024年 SAP 宣布大规模组织转型，重点投入生成式 AI、云计算与业务流程自动化，并以约15亿美元收购数字化应用引导企业 WalkMe。2025年重新提出 SAP Business Suite 战略，将 SAP Cloud ERP、SAP Business Data Cloud、SAP Business AI 和 SAP Business Technology Platform 整合为统一的企业软件体系，并与 Databricks 合作发展企业数据云。同年完成收购招聘软件公司 SmartRecruiters，扩展 SuccessFactors 产品组合，发布 SAP-RPT-1 表格数据基础模型，进一步强化企业数据与 AI 智能体的结合。

\- 2026｜自主企业与 AI 智能体平台：2026年 SAP 完成对 Reltio、Dremio 和 Prior Labs 的收购，分别强化主数据管理、数据湖仓和表格基础模型研发能力。公司推出 Joule Work、Joule Agents、Joule Assistants 等企业智能体与统一工作空间，发展 SAP Business AI Platform 和 AI Agent Hub，推动 AI 在财务、采购、人力资源、供应链及客户管理等流程中的自动执行。2026年第三季度 SAP 单季度营收首次突破100亿欧元，云收入同比增长26%，继续向以云 ERP、企业数据和 AI 自动化为核心的企业软件平台转型。

#### 控股公司及子公司

集团主体：SAP SE（思爱普公司）

- 总部位于德国巴登-符腾堡州沃尔多夫（Walldorf），成立于1972年，1988年在德国上市，1998年进入纽约证券交易所。目前普通股在法兰克福证券交易所上市，股票代码 SAP；美国存托凭证在纽约证券交易所交易（SAP）。
- SAP 本身是集团顶层上市公司，没有另一家企业作为其控股母公司。2014年由 SAP AG 改制为 SAP SE，采用欧洲股份公司（Societas Europaea）法律形式。
- 克里斯蒂安·克莱因（Christian Klein）自2020年4月起担任 CEO 兼执行董事会主席，公司实行德国式双层董事会制度，由执行董事会负责经营、监事会负责监督。
- 按2025财年年报，SAP 集团包含216家公司，主要划分为应用、技术与支持（Applications, Technology & Support，ATS）和核心服务（Core Services）两个报告分部。前者负责云应用、软件及技术平台，后者主要负责企业咨询、实施和专业支持服务。

主要子公司及收购业务：

- SAP BusinessObjects：2008年完成收购，原法国商业智能软件企业，主要开发企业报表、数据可视化、商业智能和分析平台，产品包括 SAP BusinessObjects Business Intelligence、Crystal Reports 等。
- Sybase：2010年以约58亿美元完成收购，美国数据库与企业移动技术企业，主要产品包括 SAP Adaptive Server Enterprise（ASE）、SQL Anywhere 等，相关技术整合进入 SAP 数据库及企业移动计算业务。
- SuccessFactors：2012年完成收购，美国云端人力资本管理（HCM）软件企业，提供招聘、员工管理、绩效考核、培训和薪酬管理，现为 SAP SuccessFactors HCM 产品体系的核心。
- Ariba：2012年以约43亿美元完成收购，美国企业采购与供应商协作平台，主要经营电子采购、供应商管理、采购合同及供应链协作服务，现为 SAP Ariba 与 SAP Business Network 的重要基础。
- Hybris：2013年完成收购，瑞士电子商务与客户体验软件企业，主要开发全渠道电商与客户交易平台，其产品与技术整合进入 SAP Commerce Cloud。
- Fieldglass：2014年完成收购，美国外部劳动力管理软件企业，主营临时员工、外包服务与服务供应商管理，保留 SAP Fieldglass 产品品牌。
- Concur Technologies：2014年以约83亿美元完成收购，美国企业差旅与费用管理软件企业，主要经营 Concur Expense、Concur Travel、Concur Invoice 等产品，保留 SAP Concur 品牌。
- CallidusCloud：2018年以约24亿美元完成收购，美国云端销售绩效管理企业，开发销售佣金、销售绩效与报价管理软件，相关技术进入 SAP Sales Cloud、SAP SuccessFactors 等产品体系。
- Emarsys：2020年完成收购，奥地利全渠道营销自动化企业，主营客户互动、个性化营销及营销分析。2026年 SAP 将原 SAP Emarsys 产品更名为 SAP Engagement Cloud。
- Signavio：2021年完成收购，德国业务流程管理与流程挖掘软件企业，主要产品包括 SAP Signavio Process Intelligence、Process Manager、Process Insights，现为 SAP 企业转型管理平台的重要组成部分。
- AppGyver：2021年完成收购，芬兰无代码应用开发企业，主要开发可视化应用设计及低代码开发平台，技术整合进入 SAP Build Apps。
- Taulia：2022年收购其控股股权，美国供应链金融和营运资本管理企业，主要提供供应商融资、提前付款、动态折扣及应收账款融资，保留 Taulia 品牌运营。
- LeanIX：2023年完成收购，德国企业架构管理软件企业，主营 IT 资产分析、应用组合管理、企业架构规划和数字化转型管理，现以 SAP LeanIX 品牌运营。
- WalkMe：2024年以约15亿美元完成收购，以色列数字化应用引导软件企业，开发 Digital Adoption Platform（DAP），提供应用内操作指导、工作流自动化和软件使用分析，现为 SAP 业务转型管理体系的重要组成部分。
- SmartRecruiters：2025年9月完成收购，美国 AI 招聘管理软件企业，主营人才招聘、申请人追踪系统（ATS）、招聘流程自动化和候选人管理，保留品牌并与 SAP SuccessFactors 集成。
- Reltio：2026年5月完成收购，美国云端主数据管理（MDM）软件企业，主要提供主数据整合、数据清洗、数据治理和企业数据统一管理，相关技术整合进入 SAP Business Data Cloud 体系。
- Dremio：2026年7月完成收购，美国数据湖仓（Lakehouse）技术企业，提供基于 Apache Iceberg 等开放技术的数据查询、数据目录及数据管理平台，强化 SAP Business Data Cloud 对 SAP 与非 SAP 数据的统一分析能力。
- Prior Labs：2026年7月完成收购，德国人工智能研究企业，专注表格基础模型（Tabular Foundation Models）及结构化数据机器学习，核心技术包括 TabPFN。收购后保留相对独立的研究组织，与 SAP-RPT-1 等企业数据 AI 模型研发形成协同。

集团重要法律实体：

- SAP Deutschland SE & Co. KG：注册于德国沃尔多夫，是 SAP 德国市场的重要经营实体，承担当地企业软件销售、实施及客户服务业务。
- SAP America, Inc.：注册于美国宾夕法尼亚州，是 SAP 北美市场的重要运营实体，负责软件销售、企业客户服务及相关商业活动。
- SAP Industries, Inc.：注册于美国宾夕法尼亚州，属于 SAP 美国业务体系的重要法律实体。
- SAP National Security Services, Inc.：注册于美国宾夕法尼亚州，主要面向美国政府及国家安全相关客户提供符合特定监管和安全要求的 SAP 软件与服务。
- Ariba, Inc.：注册于美国加利福尼亚州，是 SAP 采购软件及供应商网络业务的重要法律实体。
- Concur Technologies, Inc.：注册于美国华盛顿州，是 SAP Concur 差旅与费用管理业务的重要法律实体。
- Concur Holdings (Netherlands) B.V.：注册于荷兰，属于 SAP Concur 国际控股及运营体系。
- SAP (UK) Limited：注册于英国，是 SAP 英国市场的重要经营实体。
- SAP France：注册于法国，负责 SAP 法国市场相关运营。
- SAP (Schweiz) AG：注册于瑞士，属于 SAP 瑞士市场的重要经营实体。
- SAP China Co., Ltd.（SAP 中国）：注册于中国上海，是 SAP 中国市场的重要运营实体，涉及企业软件销售、技术支持及客户服务。
- SAP India Private Limited：注册于印度班加罗尔，是 SAP 印度市场的重要经营实体，与当地研发和全球服务体系密切相关。
- SAP Japan Co., Ltd.（SAP Japan）：注册于日本东京，负责 SAP 日本市场业务。
- SAP Australia Pty Ltd.：注册于澳大利亚悉尼，是 SAP 澳大利亚市场的重要法律实体。
- SAP Brasil Ltda. / SAP Canada, Inc. / SAP México S.A. de C.V.：分别属于 SAP 巴西、加拿大和墨西哥业务体系的重要经营实体。

以上为 SAP 2025财年年报披露的主要子公司，均由 SAP SE 全资拥有或控制，但不代表集团全部法律实体。

其他重要投资及历史股权关系：

- Qualtrics：2018年 SAP 宣布以约80亿美元收购的美国体验管理（Experience Management，XM）软件企业，主营客户体验、员工体验及市场调研。2021年独立上市，2023年 SAP 将其全部股权出售给 Silver Lake 等投资方，目前不属于 SAP 集团。
- Litmos：SAP 曾经营的企业在线培训与学习管理平台，2022年出售给 Francisco Partners，不再属于 SAP 控股业务。
- Sapphire Ventures：由 SAP 企业风险投资业务发展而来，投资企业软件、云计算和人工智能创业公司，现作为独立风险投资机构运营，不能简单视为 SAP 全资子公司。
- Databricks：美国数据分析与 AI 平台企业，2025年与 SAP 建立深度战略合作，为 SAP Business Data Cloud 提供数据湖仓、分析和 AI 开发能力。双方属于技术与商业合作关系，Databricks 并非 SAP 子公司。
- Microsoft、Amazon Web Services、Google Cloud：SAP 的重要云基础设施及技术合作伙伴。SAP Cloud ERP 可部署或运行于多种大型云服务商基础设施上，三家公司均不属于 SAP 集团。

#### 主要产品

\- SAP ERP 企业资源规划：SAP R/2、SAP R/3、SAP ERP Central Component（ECC）、SAP S/4HANA，覆盖财务会计、采购、销售、生产、库存、人力资源及企业管理。其中 R/2、R/3 为历史系统，ECC 为逐步退出主流维护的上一代 ERP 产品，S/4HANA 为新一代核心 ERP 平台。

\- SAP Cloud ERP 云端企业资源规划：SAP Cloud ERP（原 SAP S/4HANA Cloud Public Edition）、SAP Cloud ERP Private（原 SAP S/4HANA Cloud Private Edition）、SAP S/4HANA，面向不同规模企业提供公有云、私有云及本地部署的 ERP 解决方案。

\- SAP Business Suite 企业应用套件：SAP Business Suite、SAP Cloud ERP、SAP Business AI、SAP Business Data Cloud、SAP Business Technology Platform（BTP），整合企业管理应用、业务数据、AI 与技术平台，构成 SAP 新一代企业软件体系。

\- RISE with SAP 与 SAP GROW：RISE with SAP 面向现有大型企业提供 ERP 云迁移、业务流程优化和技术转型服务；SAP GROW 主要面向新客户及成长型企业，提供基于公有云 ERP 的标准化实施与订阅方案。两者属于产品与服务组合，而非独立 ERP 内核。

\- SAP 中小企业 ERP：SAP Business One、SAP Business ByDesign，分别面向中小企业和中型成长企业，提供财务、采购、库存、销售、生产及运营管理，其中 Business ByDesign 属于较早一代云 ERP 产品。

\- SAP 财务与会计管理：SAP S/4HANA Finance、SAP Financial Accounting（FI）、SAP Controlling（CO）、SAP Central Finance、SAP Group Reporting、SAP Advanced Financial Closing，提供财务核算、管理会计、集团合并、财务结算和财务数据管理。

\- SAP 财务规划与资金管理：SAP Analytics Cloud for Planning、SAP Treasury and Risk Management、SAP Cash Management、SAP Billing and Revenue Innovation Management，覆盖预算预测、资金管理、风险分析、收入管理和财务规划。

\- SAP SuccessFactors 人力资本管理：SAP SuccessFactors Employee Central、Employee Central Payroll、Recruiting、Onboarding、Learning、Performance & Goals、Compensation、Time Tracking、Workforce Analytics，以及 SmartRecruiters for SAP SuccessFactors，覆盖员工管理、薪酬、招聘、培训、绩效和人力资源分析。

\- SAP Ariba 企业采购管理：SAP Ariba Buying、SAP Ariba Sourcing、SAP Ariba Contracts、SAP Ariba Supplier Management、SAP Ariba Supplier Risk，提供采购申请、供应商管理、合同管理、招标、采购执行和采购风险分析。

\- SAP Business Network 企业协作网络：SAP Business Network for Procurement、for Supply Chain、for Logistics、Asset Collaboration，连接企业与供应商、承运商、物流企业及设备服务商，实现跨企业的采购、物流、资产和供应链协同。

\- SAP Concur 差旅与费用管理：Concur Expense、Concur Travel、Concur Invoice、Concur Request、Concur Detect、TripIt，提供商务出差预订、费用报销、发票管理、差旅审批和支出分析。

\- SAP Fieldglass 外部劳动力管理：SAP Fieldglass Contingent Workforce Management、Services Procurement、Worker Profile Management，主要用于临时员工、外包服务、供应商及外部劳动力管理。

\- Taulia 供应链金融：Taulia Supply Chain Finance、Dynamic Discounting、Accounts Receivable Finance、Inventory Finance，提供供应商提前付款、应收账款融资、营运资本优化及现金流管理。

\- SAP 供应链规划：SAP Integrated Business Planning（IBP）、SAP Supply Chain Control Tower、SAP Demand Planning、SAP Response and Supply Planning，覆盖需求预测、库存优化、产能规划、供应链风险和销售运营计划。

\- SAP 制造与生产管理：SAP Digital Manufacturing、SAP Manufacturing Execution、SAP Production Planning、SAP Integrated Product Development，提供生产排程、车间执行、制造数据分析、产品设计和制造过程管理。

\- SAP 物流与仓储管理：SAP Extended Warehouse Management（EWM）、SAP Transportation Management（TM）、SAP Yard Logistics、SAP Logistics Business Network，覆盖仓储、库存、运输规划、物流调度及供应链执行。

\- SAP 资产与设备管理：SAP Enterprise Asset Management（EAM）、SAP Asset Performance Management、SAP Asset Intelligence Network、SAP Service and Asset Manager，提供企业设备维护、资产生命周期管理、预测性维护及设备状态分析。

\- SAP Customer Experience（CX）客户体验平台：SAP Sales Cloud、SAP Service Cloud、SAP Commerce Cloud、SAP Customer Data Cloud、SAP Customer Data Platform、SAP Engagement Cloud，覆盖销售管理、客户服务、电子商务、客户身份、数据管理和个性化营销。

\- SAP Sales Cloud 销售管理：SAP Sales Cloud、SAP Sales Cloud Version 2、SAP CPQ、SAP Sales Performance Management，提供客户关系管理、销售机会跟踪、销售自动化、产品报价及销售绩效管理。

\- SAP Commerce Cloud 电子商务：SAP Commerce Cloud、SAP Commerce Cloud Composable Storefront，提供 B2B、B2C 商城建设、商品目录、订单处理、客户体验及全渠道零售能力，技术基础部分来自原 Hybris。

\- SAP Engagement Cloud 智能营销：SAP Engagement Cloud（原 SAP Emarsys）、SAP Customer Data Platform，提供全渠道营销自动化、客户画像、个性化推荐及实时营销活动管理。

\- SAP Business Technology Platform（BTP）：SAP BTP、SAP Integration Suite、SAP Build、SAP HANA Cloud、SAP Datasphere、SAP AI Core、SAP Event Mesh、SAP Mobile Services，提供企业应用集成、开发、数据库、数据分析、AI 和自动化技术平台。

\- SAP 数据库与数据管理：SAP HANA、SAP HANA Cloud、SAP Adaptive Server Enterprise（ASE）、SAP SQL Anywhere、SAP Master Data Governance（MDG）、SAP Reltio，覆盖内存数据库、关系型数据库、主数据管理与企业数据治理。

\- SAP Business Data Cloud 企业数据云：SAP Business Data Cloud、SAP Datasphere、SAP Analytics Cloud、SAP Databricks、Dremio、SAP Reltio，整合 SAP 与第三方企业数据，提供数据湖仓、语义建模、数据产品、数据分析及 AI 数据基础设施。其中 SAP Databricks 为与 Databricks 合作提供的技术方案。

\- SAP 商业智能与分析：SAP Analytics Cloud（SAC）、SAP BusinessObjects Business Intelligence、SAP Crystal Reports、SAP Web Intelligence、SAP BW/4HANA，覆盖企业报表、仪表盘、数据仓库、商业智能和预测分析。

\- SAP Joule 人工智能助手：SAP Joule、Joule Work、Joule Agents、Joule Assistants、Joule Studio，提供自然语言业务查询、流程自动化、跨系统任务执行、AI 智能体编排及自定义企业 AI 开发。

\- SAP Business AI Platform：SAP Business AI Platform、SAP AI Core、SAP AI Launchpad、Generative AI Hub、SAP AI Agent Hub、Joule Studio，覆盖大模型调用、AI 开发部署、智能体管理、模型治理和企业 AI 服务。

\- SAP 企业 AI 模型：SAP-RPT-1、Prior Labs TabPFN，以及面向企业业务数据的预测模型和 AI 技术，重点支持结构化数据分析、表格预测、财务与业务决策。

\- SAP 低代码与应用开发：SAP Build Apps、SAP Build Process Automation、SAP Build Code、SAP Build Work Zone、SAP Business Application Studio，提供低代码开发、工作流设计、自动化、企业应用开发和工作空间建设。

\- SAP 应用集成与 API：SAP Integration Suite、Cloud Integration、API Management、Event Mesh、Open Connectors、SAP Business Accelerator Hub，提供企业应用、数据、事件、API 和第三方系统集成。

\- SAP 开发语言与应用框架：ABAP、ABAP Cloud、SAPUI5、SAP Fiori、SAP Cloud Application Programming Model（CAP）、SAP Business Application Studio，覆盖 ERP 定制开发、Web 应用、企业 UI 和云原生应用开发。

\- SAP Signavio 业务流程管理：SAP Signavio Process Manager、Process Intelligence、Process Insights、Process Transformation Manager、Collaboration Hub，提供业务流程建模、流程挖掘、效率分析及流程优化。

\- SAP LeanIX 企业架构管理：SAP LeanIX Enterprise Architecture Management、Application Portfolio Management、Technology Risk and Compliance、AI Agent Hub，帮助企业梳理 IT 系统、应用依赖关系、技术风险及数字化转型规划。

\- SAP WalkMe 数字化应用引导：WalkMe Digital Adoption Platform、WalkMe Insights、WalkMe Workstation、WalkMe Automation，提供软件操作指导、用户行为分析、跨应用工作流自动化和数字化培训。

\- SAP 应用生命周期管理：SAP Cloud ALM、SAP Solution Manager、SAP Focused Run、SAP Enable Now，支持企业系统实施、监控、测试、维护及应用生命周期管理。其中 SAP Solution Manager 属于上一代企业应用管理平台。

\- SAP 企业安全与身份管理：SAP Identity Authentication Service（IAS）、SAP Identity Provisioning Service（IPS）、SAP Cloud Identity Access Governance、SAP GRC Access Control，提供企业身份认证、用户权限、风险控制及合规治理。

\- SAP 可持续发展管理：SAP Sustainability Control Tower、SAP Sustainability Footprint Management、SAP Green Ledger、SAP Responsible Design and Production、SAP Green Token，覆盖 ESG 披露、碳排放核算、环境数据分析、循环经济和供应链可持续发展。

\- SAP 行业解决方案：SAP for Automotive、SAP for Retail、SAP for Utilities、SAP for Banking、SAP for Insurance、SAP for Healthcare、SAP for Oil, Gas, and Energy，针对汽车、零售、公用事业、金融、医疗和能源行业提供专门的企业管理功能。

\- SAP 企业学习与开发者生态：SAP Learning、SAP Learning Hub、SAP Certification、SAP Community、SAP Developer Center、SAP Discovery Center、SAP Store，提供产品培训、开发文档、技术认证、开发者社区及企业应用市场。
#### 招聘情况
- [官网](https://jobs.sap.com/) 

![示意图](PixPin_2026-04-25_13-49-13.webp)

- 公众号: SAP招聘,会跳转到一个移动端网站
![示意图](PixPin_2026-04-25_13-54-52.webp)

看着多,但软件岗位依然很少.


### Oracle (甲骨文)
直接跳过,不在中国招人
#### 公司概况
Oracle（甲骨文）总部位于德克萨斯州奥斯汀，由拉里·埃里森等人在 1977 年创立，是全球最大的数据库软件供应商及核心企业级软件巨头。作为全球市值排名前 20 的顶级科技公司，Oracle 以其核心的**关系型数据库（Oracle Database）**统治了金融、电信等关键行业数十年，并以此为基础构建了涵盖 ERP、HCM 和供应链管理（SCM）的完整企业应用生态。
#### 公司历史
- [Wiki](https://en.wikipedia.org/wiki/Oracle_Corporation)

##### 1977–1989：从 CIA 项目到数据库霸主
* **初创与灵感**：1977 年，拉里·埃里森（Larry Ellison）与鲍勃·迈纳、爱德·欧茨在加州创立了 SDL 公司。其灵感源于埃德加·科德（Edgar F. Codd）关于**关系型数据库（RDBMS）**的论文。
* **命名渊源**：公司首个客户是美国中央情报局（CIA），其项目代号为“Oracle”。1983 年，公司正式更名为 **Oracle Systems Corporation**，与其核心产品保持一致。
* **商业奇才**：三位创始人认为埃里森编程最差，于是让他负责销售。他通过演示 **SQL** 语言的强大威力成功打开市场。1986 年，Oracle 在纳斯达克上市。
* **人才策略**：早期大规模从名校招聘，由于职位供不应求，部分名校毕业生甚至先担任接待员或分发咖啡，直到研发岗位空缺。

##### 1990–2009：应用软件扩张与“红木城”时代
* **全栈转型**：80 年代末，Oracle 开始基于数据库销售财务和制造软件。虽然初期应用软件业务亏损多年，但埃里森坚持通过收购（如 2005 年对 **PeopleSoft** 的恶意收购）切入 ERP 领域，最终使 Oracle 能够与 SAP 竞争。
* **战略 footprint**：通过提供完整的软件栈，Oracle 从单一的技术供应商转型为客户的战略合作伙伴，成功进入大企业的董事会决策层。

##### 2010–2020：云端追赶与总部迁移
* **融合应用**：2010 年发布 **Fusion Applications**，整合了此前收购的 PeopleSoft、Siebel 和 JD Edwards 的技术优势。
* **迁移奥斯汀**：2018 年在德克萨斯州奥斯汀设立办公室，并于 2020 年宣布将全球总部从加州红木岸正式迁至奥斯汀。
* **云联盟**：为了挑战 AWS，Oracle 曾与宿敌微软结盟，实现 **Oracle Cloud** 与 **Microsoft Azure** 的直接互联。

##### 2021–2026：AI 基础设施与全球版图重塑
* **医疗与 AI 收购**：2022 年以 283 亿美元完成对医疗 IT 巨头 **Cerner** 的收购。
* **AI 军备竞赛**：
    * **Stargate 计划**：2025 年初，Oracle 与 OpenAI、软银等参与了 5000 亿美元的“Stargate”AI 基础设施投资计划。
    * **超级云联盟**：2025 年，Oracle 数据库已登陆四大超算平台（AWS、Azure、Google Cloud、OCI），实现了真正的多云部署。
* **权力交接与 TikTok 交易**：2025 年 9 月，萨夫拉·卡茨卸任 CEO，由 Clay Magouyrk 和 Mike Sicilia 接任**联合 CEO**。2026 年 1 月，Oracle 正式获得 **TikTok** 美国业务 15% 的股权。
* **总部再迁**：2024 年宣布计划将总部从奥斯汀迁往田纳西州的纳什维尔（Nashville）。
* **最新业绩 (2026)**：截至 2025 年底，其云基础设施（IaaS）营收同比增长 **68%**。由于 AI 算力需求旺盛，其剩余履约义务（RPO）高达 **1300 亿美元**。

#### 控股公司及产品

##### 核心事业部
* **Oracle Cloud Infrastructure (OCI)**：提供高性能计算、存储及 AI 算力集群。
* **Cloud Applications**：包含 ERP、HCM、CX 及 SCM 云套件。
* **Financial & Healthcare**：包含 Cerner 业务，专注行业深度方案。

##### 核心产品线
* **数据库**：**Oracle Database 23c/25c**（支持向量检索、AI 驱动）、**MySQL HeatWave**。
* **云平台**：**OCI (Oracle Cloud Infrastructure)**，因其能效比高、网络延迟低，成为许多 AI 模型训练的首选。
* **应用软件**：**Oracle Fusion Cloud**、**NetSuite**（针对中小企业）。


#### 招聘情况
![示意图](PixPin_2026-04-22_18-55-39.webp)

不在中国招人,印度人倒是招的挺多,就别看了.


## 内地企业
### 腾讯
#### 公司概况
腾讯是一家总部位于深圳的全球顶尖科技与投资控股公司，成立于1998年。它是全球最大的游戏发行商及领先的社交媒体巨头，运营着微信（WeChat）和QQ等国民级应用。业务横跨娱乐、人工智能、金融科技及云服务，通过对全球600多家企业的股权投资，构建了庞大的产业生态。
- 横跨多个领域的巨头

#### 事业部门
- [来源](https://join.qq.com/about.html)

```mermaid
flowchart LR
    T["Tencent 腾讯<br/>1998 年成立 · 总部深圳"]:::root
    B["六大事业群<br/>Business Groups"]:::hub

    T --> B

    B --> CDG["CDG<br/>企业发展事业群"]:::bg
    B --> CSIG["CSIG<br/>云与智慧产业事业群"]:::bg
    B --> IEG["IEG<br/>互动娱乐事业群"]:::bg
    B --> PCG["PCG<br/>平台与内容事业群"]:::bg
    B --> TEG["TEG<br/>技术工程事业群"]:::bg
    B --> WXG["WXG<br/>微信事业群"]:::bg

    CDG --> D1["Corporate Development Group<br/>金融科技 · 腾讯广告<br/>战略投资 · 新业务孵化"]:::detail
    CSIG --> D2["Cloud & Smart Industries Group<br/>腾讯云 · AI · 大数据 · 安全<br/>产业数字化解决方案"]:::detail
    IEG --> D3["Interactive Entertainment Group<br/>腾讯游戏 · 腾讯电竞<br/>游戏研发 · 运营与发行"]:::detail
    PCG --> D4["Platform & Content Group<br/>QQ · QQ空间 · 腾讯视频<br/>腾讯新闻 · 应用宝 · QQ浏览器"]:::detail
    TEG --> D5["Technology Engineering Group<br/>技术中台 · 数据中心 · 数据库<br/>网络基础设施 · 技术研发"]:::detail
    WXG --> D6["Weixin Group<br/>微信 · 公众号 · 小程序 · 视频号<br/>微信支付 · 企业微信 · 微信读书"]:::detail

    classDef root fill:#0755A3,stroke:#0755A3,color:#FFFFFF,stroke-width:2px
    classDef hub fill:#D9EAFE,stroke:#438BDC,color:#164679,stroke-width:2px
    classDef bg fill:#DDF5F0,stroke:#30A69B,color:#075E58,stroke-width:1.5px
    classDef detail fill:#F5F8FD,stroke:#B8CDE2,color:#25374C,stroke-width:1px

    linkStyle default stroke:#91AFC9,stroke-width:1.6px
```

画成表格:

| 事业群                | 核心定位         | 主要负责领域                                   |
| :-------------------- | :--------------- | :--------------------------------------------- |
| **CDG** 企业发展      | 战略与商业化     | 金融科技、广告营销、战略投资、并购和新业务孵化 |
| **CSIG** 云与智慧产业 | 产业互联网       | 腾讯云、云计算、AI、安全及行业数字化           |
| **IEG** 互动娱乐      | 游戏与电竞       | 游戏研发、运营、发行和电子竞技                 |
| **PCG** 平台与内容    | 社交与数字内容   | QQ、视频、新闻、动漫、浏览器和应用平台         |
| **TEG** 技术工程      | 集团技术基础设施 | 数据中心、数据库、网络、技术中台和前沿技术     |
| **WXG** 微信          | 微信生态         | 微信、公众号、小程序、视频号、支付及微信读书   |

>WXG很明显应该放在PCG里吧,能够单开一个事业群出来就反映了该部门的强势和地位.


由于每个事业群内部的岗位种类很多,所以我们重点要关注核心岗位:
| 事业群                | 核心岗位或团队方向                                           |
| :-------------------- | :----------------------------------------------------------- |
| **WXG** 微信          | 微信基础架构、支付、小程序、视频号推荐、搜索                 |
| **CDG** 企业发展      | 腾讯广告、金融科技、支付后台、广告推荐与风控                 |
| **IEG** 互动娱乐      | 《王者荣耀》《和平精英》《三角洲行动》等成熟游戏的研发与后台 |
| **TEG** 技术工程      | AI Infra、混元大模型、数据库、分布式平台、基础架构           |
| **CSIG** 云与智慧产业 | 腾讯云核心基础设施、AI算力、数据库、云原生、AI产品           |
| **PCG** 平台与内容    | QQ核心通信、社交技术、推荐算法、视频平台基础技术             |

从2026年最新公开经营数据来看：

* **游戏、广告、微信生态**：具有成熟商业模式，是腾讯当前的重要收入和利润来源。
* **AI、大模型、算力基础设施**：属于重点投资方向，技术人才需求较强，但组织调整也十分频繁。
* **云计算与企业服务**：业务收入增长，竞争压力和商业化考核仍值得关注。
* **传统内容平台、非核心游戏项目**：已有业务缩减、工作室裁撤或人员调整的公开案例。

重点还是看个人选择,不过我还是很看好CSIG的,毕竟代表着云计算和Agent两大热潮,如果能够和政府部门对接好,那么未来几年是相当吃香的.


#### 公司历史

\- 1998—2003｜创立与即时通信业务：马化腾、张志东、许晨晔、陈一丹和曾李青于1998年在深圳创立腾讯（Tencent），最初从事互联网寻呼及即时通信软件开发。1999年推出 OICQ，后更名为 QQ，逐渐发展为中国重要的互联网即时通信平台。2000年推出 QQ 会员和移动增值服务，2001年获得南非 MIH 集团投资，建立以即时通信、会员订阅和移动增值业务为核心的商业模式。2003年推出 QQ 游戏、QQ 邮箱、QQ 秀及腾讯网，开始从单一通信工具向互联网综合服务平台转型。

\- 2004—2010｜上市与互联网娱乐生态扩张：2004年腾讯控股在香港联合交易所上市（0700.HK），进一步扩展网络游戏、在线广告与数字内容业务。2005年推出 QQ 空间、QQ 音乐，并收购 Foxmail 邮件客户端。随后推出《QQ 幻想》《QQ 飞车》《地下城与勇士》（中国大陆代理）、《穿越火线》（中国大陆代理）等网络游戏，逐渐成为中国重要的网络游戏运营商。2009年腾讯游戏成为中国收入规模最大的网络游戏平台之一，2010年推出微信前身相关移动通信研发项目，并逐渐布局电子商务、搜索、社交网络和移动互联网服务。

\- 2011—2014｜微信崛起与移动互联网转型：2011年由张小龙团队推出微信（Weixin），迅速建立移动即时通信和社交平台，并逐步加入朋友圈、公众平台和移动支付等功能。同年收购 Riot Games 多数股权，获得《英雄联盟》开发商的控制权。2012年微信用户规模快速增长，2013年推出微信支付和微信游戏中心，腾讯云正式对外提供服务。2014年推出微信红包和理财通，投资京东、滴滴等互联网企业，并参与发起成立微众银行，逐渐形成以微信、QQ、游戏、支付和云计算为核心的移动互联网生态。

\- 2015—2018｜数字内容帝国与产业互联网布局：2015年成立腾讯影业，推动文学、动漫、影视和游戏知识产权的跨领域开发；2015年收购 Riot Games 剩余股权，实现全资控股。2016年通过财团收购芬兰游戏企业 Supercell 多数股权，进一步扩大海外游戏业务。2017年阅文集团在香港上市，腾讯持续布局文学、音乐、影视、电竞及短视频领域；2018年腾讯音乐娱乐集团在纽约证券交易所上市。同年进行大规模组织架构调整，成立云与智慧产业事业群（CSIG）和平台与内容事业群（PCG），推动从消费互联网向产业互联网扩张。

\- 2019—2022｜企业服务、全球游戏投资与监管调整：2019年提出“用户为本，科技向善”的使命，进一步发展腾讯云、企业微信、腾讯会议、腾讯文档等企业服务。2020年受远程办公和在线娱乐需求增长影响，企业协作、在线教育、视频会议和数字内容业务快速发展。2021年完成对搜狗的私有化收购，整合搜索、输入法和 AI 技术；同年在游戏防沉迷、个人信息保护及互联网平台监管变化下调整部分业务。2022年出售部分美团股份，推动投资组合调整，同时加强海外游戏发行、视频号商业化、金融科技和云计算业务。

\- 2023—2024｜混元大模型与微信商业生态：2023年正式发布腾讯混元（Hunyuan）大语言模型，开始将生成式 AI 应用于腾讯云、广告、搜索、办公和内容生产。2024年推出腾讯元宝 AI 助手，发布混元视频生成、3D 生成等多模态模型，并持续发展腾讯云 AI 基础设施。微信生态进一步扩展视频号、小程序、小游戏和微信小店，形成连接社交、内容消费、电商、支付及本地生活服务的平台体系。游戏业务继续发展《王者荣耀》《和平精英》《英雄联盟》以及海外 Supercell、Riot Games 旗下产品。

\- 2025—2026｜AI 智能体、混元升级与全球化：2025年进一步推动混元模型、腾讯元宝、ima 知识库、CodeBuddy AI 编程等产品，强化生成式 AI 与微信、QQ、腾讯云和企业服务的整合。2026年推出 WorkBuddy、QClaw 等 AI 智能体工具，并将混元模型体系升级为 Tencent Hy，发布 Hy3、Hy4 preview 等模型，支持复杂推理、编程、办公及多工具协作。同期扩大腾讯云 AI 服务、TokenHub、模型推理和企业智能体平台投入，推动 AI 技术进入金融、制造、游戏、办公等场景。2026年第二季度集团营收达到2048亿元人民币，同比增长11%，增值服务、营销服务、金融科技与企业服务继续构成核心收入来源。

#### 控股公司及子公司

集团主体：腾讯控股有限公司（Tencent Holdings Limited）

- 总部位于中国广东省深圳市，注册地为开曼群岛，2004年在香港联合交易所上市，股票代码为0700.HK，是中国主要的互联网与科技企业之一。
- 腾讯控股是集团顶层上市公司，没有另一家企业作为其控股母公司。创始人马化腾担任董事会主席兼 CEO，刘炽平（Martin Lau）担任总裁。
- 南非 Naspers 集团通过荷兰上市公司 Prosus 及旗下 MIH 持有腾讯重要少数股权，截至2026年3月31日持股约22.66%，属于最大股东，但未取得绝对控股权。马化腾通过个人及控股实体持有约8.8%股份，是重要创始人股东。
- 按2026年第二季度财报，腾讯主要分为增值服务（Value Added Services）、营销服务（Marketing Services）、金融科技及企业服务（FinTech and Business Services）、其他业务四个报告分部。增值服务包括游戏、社交网络和数字内容；营销服务包括广告业务；金融科技与企业服务主要涵盖支付、理财、云计算及产业数字化。
- 集团通过全资子公司、控股上市公司、协议控制实体（VIE）及战略投资构成业务体系。部分中国大陆互联网经营实体通过合同安排纳入合并报表，在法律股权结构上与直接持股子公司存在区别。

主要控股公司及收购业务：

- Riot Games（拳头游戏）：2011年腾讯收购多数股权，2015年实现全资控股，美国游戏开发与发行企业，主要产品包括《英雄联盟》（League of Legends）、《无畏契约》（VALORANT）、《云顶之弈》（Teamfight Tactics）、《符文之地传说》等，保持相对独立的研发与运营体系。
- Supercell：2016年腾讯通过收购财团取得芬兰游戏公司的控制权，截至2025年底集团持股约93.48%。主要产品包括《部落冲突》（Clash of Clans）、《皇室战争》（Clash Royale）、《荒野乱斗》（Brawl Stars）和《海岛奇兵》（Boom Beach），专注全球移动游戏市场。
- 腾讯音乐娱乐集团（Tencent Music Entertainment Group，TME）：2016年通过整合 QQ 音乐、酷狗音乐、酷我音乐等业务成立，2018年在纽约证券交易所上市（TME），2022年在香港上市（1698.HK）。截至2025年底腾讯持股约53.26%，保持控股，旗下包括 QQ 音乐、酷狗音乐、酷我音乐、全民 K 歌、喜马拉雅等音乐与音频产品。
- 阅文集团（China Literature Limited）：2015年整合腾讯文学与盛大文学相关业务成立，2017年在香港上市（0772.HK）。截至2025年底腾讯持股约57.46%，主要运营起点中文网、QQ 阅读、创世中文网、红袖读书、潇湘书院等文学平台，并开展网络文学版权开发、出版及影视业务。
- 新丽传媒（New Classics Media）：2018年阅文集团完成收购的中国影视制作企业，主要从事电视剧、电影制作及文学 IP 影视化，代表作品包括《庆余年》等，属于腾讯通过阅文集团间接控制的影视业务。
- 虎牙公司（HUYA Inc.）：2020年腾讯通过增持取得控制权，美国纽约证券交易所上市（HUYA），主营游戏直播、电竞内容和游戏相关服务。截至2026年3月，腾讯持有约65.4%股份及95.0%表决权。
- 搜狗（Sogou）：2013年腾讯向搜狗注入搜搜等相关业务并成为重要股东，2021年完成私有化收购。主要业务包括搜狗输入法、搜索技术、语言处理和 AI 软件，相关业务已整合进入腾讯体系。
- 喜马拉雅（Ximalaya）：2026年5月18日由腾讯音乐娱乐集团完成全资收购，主营有声读物、播客、知识音频、广播剧与数字音频订阅服务，成为腾讯音乐旗下全资子公司，也是腾讯通过 TME 间接控股的业务。
- Funcom：2020年完成全资收购，挪威游戏开发与发行企业，主要作品包括《流放者柯南》（Conan Exiles）、《沙丘：觉醒》（Dune: Awakening）等，专注大型多人游戏、开放世界和生存游戏。
- Grinding Gear Games：2018年腾讯收购多数股权，随后逐步提高持股比例，至2025年已实现全资控股。新西兰游戏开发企业，代表作品包括《流放之路》（Path of Exile）、《流放之路2》（Path of Exile 2）。
- Digital Extremes：2020年腾讯通过收购乐游科技（Leyou Technologies）取得控制权，加拿大游戏开发企业，代表作品为《星际战甲》（Warframe），保持相对独立运营。
- Splash Damage：曾通过2020年收购乐游科技进入腾讯集团，英国游戏开发企业，主要从事多人射击游戏研发。其后业务所有权经历调整，不能仅依据2020年的收购将其持续认定为现有全资子公司。
- Klei Entertainment：2021年腾讯收购多数股权，加拿大游戏开发企业，代表作品包括《饥荒》（Don't Starve）、《饥荒联机版》（Don't Starve Together）、《缺氧》（Oxygen Not Included），保留独立开发团队及创作方向。
- Techland：2023年腾讯取得多数股权，波兰游戏开发企业，代表作品包括《死亡岛》（Dead Island，早期开发）、《消逝的光芒》（Dying Light）系列，主要从事开放世界、动作与生存类游戏研发。
- Sharkmob：腾讯旗下瑞典游戏开发工作室，主要从事 PC 与主机多人在线游戏研发，属于集团海外游戏研发体系。
- WeGame：腾讯游戏发行与数字游戏平台，提供 PC 游戏购买、下载、更新及社区服务，属于腾讯内部游戏业务，不能单独视为独立法律子公司。

集团重要法律实体：

- 深圳市腾讯计算机系统有限公司：成立于1998年，是腾讯中国大陆互联网业务的重要运营实体，涉及互联网增值服务、广告及相关业务。由于外资准入要求，该公司通过协议控制安排纳入腾讯集团合并报表。
- 腾讯科技（深圳）有限公司：腾讯在中国大陆的重要外商独资企业，主营软件研发、信息技术及相关服务，属于集团全资子公司。
- 深圳市世纪凯旋科技有限公司：腾讯中国大陆重要互联网广告及增值业务运营实体，通过协议控制安排纳入集团合并报表。
- 腾讯云计算（北京）有限责任公司：腾讯云业务的重要境内经营实体，涉及信息系统集成及相关服务，通过协议控制安排纳入集团合并报表。
- 深圳市腾讯天游科技有限公司：主要承担游戏及互联网增值服务相关经营业务，属于集团协议控制的经营实体。
- 北京腾讯文化传媒有限公司：腾讯广告、内容与文化传媒业务的重要经营实体。
- 深圳市腾讯文化传媒有限公司：腾讯在中国大陆的文化传媒及广告业务相关法律实体。
- 广州腾讯科技有限公司：腾讯在广州的重要研发与技术服务实体，承担软件开发及信息技术相关业务。
- 腾讯科技（上海）有限公司：腾讯在上海的重要研发与技术运营实体，主要从事软件开发和信息技术服务。
- 腾讯科技（成都）有限公司：腾讯在成都的重要研发与技术运营实体。
- 腾讯数码（天津）有限公司：腾讯在天津的软件研发及技术服务相关实体。
- Tencent Asset Management Limited：注册于英属维尔京群岛，承担腾讯集团部分资产及投资管理职能。
- Riot Games, Inc.：注册于美国，是腾讯全资控股的重要海外游戏研发和运营实体。
- Supercell Oy：注册于芬兰，是腾讯控股的重要海外游戏开发企业。
- China Literature Limited：注册于开曼群岛，是腾讯控股的上市文学及版权运营企业。
- Tencent Music Entertainment Group：注册于开曼群岛，是腾讯控股的上市音乐与音频娱乐企业。

上述重要法律实体主要依据腾讯2025财年年报披露整理，不包含集团全部子公司。

腾讯内部主要事业群及研发组织：

- 微信事业群（WXG）：负责微信、WeChat、微信支付、小程序、视频号、公众号、企业微信及相关开放生态。
- 互动娱乐事业群（IEG）：负责腾讯游戏、电竞、海外游戏发行和相关娱乐业务，旗下拥有天美、光子、魔方、北极光等研发工作室群。
- 云与智慧产业事业群（CSIG）：负责腾讯云、产业数字化、企业服务、云计算、人工智能基础设施和行业解决方案。
- 平台与内容事业群（PCG）：负责 QQ、腾讯视频、腾讯新闻、腾讯体育及相关内容和平台业务。
- 技术工程事业群（TEG）：负责腾讯基础技术架构、计算基础设施、技术平台和集团技术研发。
- 企业发展事业群（CDG）：负责集团战略、投资、金融科技、商业合作及企业发展相关事务。
- 天美工作室群（TiMi Studio Group）：腾讯内部游戏研发组织，代表产品包括《王者荣耀》《QQ 飞车》《使命召唤手游》《三角洲行动》。
- 光子工作室群（LIGHTSPEED Studios）：腾讯内部游戏研发组织，代表产品包括《和平精英》《PUBG MOBILE》《英雄联盟手游》《金铲铲之战》等。
- 魔方工作室群（Morefun Studios）：腾讯内部游戏研发组织，代表产品包括《火影忍者》手游、《暗区突围》《暗区突围：无限》等。
- 北极光工作室群（Aurora Studio）：腾讯内部游戏研发组织，代表产品包括《天涯明月刀》《光与夜之恋》等。
- NExT Studios：腾讯旗下游戏研发团队，重点开展独立游戏、创新玩法和 PC、主机游戏研发，代表作品包括《疑案追声》《只只大冒险》等。

其他重要投资及股权关系：

- Prosus / Naspers：腾讯最大股东体系。Naspers 是南非投资集团，Prosus 为其控制的荷兰上市互联网投资公司，通过 MIH 持有腾讯重要少数股权，但腾讯不是其全资子公司。
- 微众银行（WeBank）：2014年由腾讯等企业共同发起设立的中国互联网银行，腾讯是重要股东之一，但微众银行属于独立持牌金融机构，不应直接视为腾讯全资子公司。
- Epic Games：美国游戏开发与游戏引擎企业，开发《堡垒之夜》（Fortnite）、Unreal Engine 和 Epic Games Store。腾讯于2012年投资并取得约40%股权，属于重要少数股东，Epic Games 保持独立运营。
- Ubisoft（育碧）：法国游戏发行企业，拥有《刺客信条》《孤岛惊魂》《彩虹六号》等系列。腾讯自2018年起投资育碧，2025年进一步投资其新设子公司 Vantage Studios，属于战略参股及合作关系，育碧集团本身未被腾讯收购。
- 快手（Kuaishou）：中国短视频与直播平台，腾讯是重要战略股东之一，但快手独立上市并经营，不属于腾讯控股子公司。
- 京东集团（JD.com）：中国电商与供应链企业，2014年腾讯建立战略投资关系，2021年宣布向股东分派大部分所持京东股份，随后继续保持业务合作。京东不是腾讯控股子公司。
- 美团（Meituan）：中国本地生活服务平台，腾讯曾是重要股东，2022年通过股份分派大幅降低持股比例，目前不能视为腾讯集团旗下企业。
- 拼多多（PDD Holdings）：腾讯曾参与早期融资，但拼多多始终保持独立经营，不能将其列为腾讯控股子公司。
- Spotify：瑞典音乐流媒体企业，腾讯音乐与 Spotify 于2017年建立交叉持股和商业合作关系，双方均保持独立经营。
- 哔哩哔哩（Bilibili）：中国视频社区与数字内容平台，腾讯是其重要战略投资者之一，双方在动漫、游戏及内容等方面开展合作，但哔哩哔哩不属于腾讯控股子公司。
- Reddit：美国网络社区平台，腾讯于2019年参与融资并持有少数股权，属于财务及战略投资关系，不构成控制权。

#### 主要产品

\- 微信与 WeChat 即时通信：微信、WeChat、微信朋友圈、微信收藏、微信状态、微信语音通话、微信视频通话，提供即时通信、社交互动、内容分享和生活服务。

\- 微信内容与开放平台：微信公众号、微信视频号、微信小程序、微信小游戏、微信搜一搜、微信问一问、微信小店，覆盖内容创作、短视频、搜索、电商、小程序开发和商业服务。

\- QQ 社交与通信：QQ、QQ 空间、QQ 邮箱、QQ 频道、QQ 群、QQ 会员、超级会员，提供即时通信、社区互动、电子邮件及会员增值服务。

\- 腾讯社交与社区应用：QQ、微信、QQ 空间、微信视频号、腾讯频道类社交功能，以及相关的音视频通话、兴趣社群和数字社交服务。

\- 腾讯元宝人工智能助手：腾讯元宝（Yuanbao），基于腾讯混元等大模型能力，提供智能问答、联网搜索、文档分析、内容写作、学习辅助和多模态交互服务。

\- 腾讯混元大模型（Tencent Hunyuan / Tencent Hy）：混元大语言模型、混元图像生成模型、混元视频生成模型、混元3D生成模型、Hy3、Hy4 preview，覆盖自然语言理解、推理、编程、图像视频生成、3D资产生成及 AI 智能体任务。2026年腾讯将新一代模型体系进一步发展为 Tencent Hy。

\- 腾讯 AI 智能体与效率工具：WorkBuddy、WorkBuddy Enterprise、QClaw、ClawPro、腾讯元宝、ima，覆盖个人办公、企业工作流、自动任务执行、知识管理和智能体交互。

\- 腾讯 CodeBuddy AI 编程：Tencent CodeBuddy、CodeBuddy IDE 及相关开发插件，提供代码生成、程序理解、错误修复、项目开发、代码重构和 AI 辅助软件工程能力。

\- 腾讯 ima 知识管理：ima、ima 知识库、ima AI 阅读与写作，支持个人和团队知识库、文档问答、资料管理、知识检索及 AI 辅助内容创作。

\- 腾讯 AI 模型与智能体开发平台：腾讯云大模型服务平台 TokenHub、腾讯云智能体开发平台（ADP）、Agent Runtime、WorkBuddy Managed Agents，提供多模型 API、模型推理、智能体构建、运行环境和企业智能体管理。

\- 腾讯游戏国内核心产品：《王者荣耀》《和平精英》《三角洲行动》《暗区突围》《穿越火线》《地下城与勇士》《QQ 飞车》《英雄联盟手游》《金铲铲之战》《火影忍者》手游、《天涯明月刀》手游、《元梦之星》等，覆盖 MOBA、射击、竞技、动作、赛车和角色扮演游戏。其中部分游戏由腾讯代理发行，相关知识产权并非全部由腾讯拥有。

\- 腾讯海外游戏与发行平台：Level Infinite、Riot Games、Supercell、Funcom、Grinding Gear Games、Digital Extremes 等研发及发行体系，覆盖全球 PC、主机和移动游戏市场。

\- Riot Games 游戏系列：《英雄联盟》（League of Legends）、《无畏契约》（VALORANT）、《云顶之弈》（Teamfight Tactics）、《符文之地传说》（Legends of Runeterra）、《双城之战》相关衍生内容，以及其他英雄联盟宇宙产品。

\- Supercell 游戏系列：《部落冲突》（Clash of Clans）、《皇室战争》（Clash Royale）、《荒野乱斗》（Brawl Stars）、《海岛奇兵》（Boom Beach）、《卡通农场》（Hay Day），主要面向全球移动游戏市场。

\- 腾讯海外 PC 与主机游戏：《流放之路》《流放之路2》《星际战甲》《消逝的光芒》《消逝的光芒2》《流放者柯南》《沙丘：觉醒》《饥荒》《饥荒联机版》《缺氧》，主要来自腾讯控股的海外游戏工作室。

\- 腾讯游戏发行与社区服务：腾讯游戏、WeGame、Level Infinite、腾讯游戏助手、掌上英雄联盟、王者营地，提供游戏下载、更新、发行、社区互动、赛事资讯和游戏账号服务。

\- 腾讯电竞：腾讯电竞、英雄联盟职业联赛（LPL）、王者荣耀职业联赛（KPL）、和平精英职业联赛（PEL）、无畏契约冠军巡回赛中国赛区（VCT CN）等赛事运营及合作业务，涵盖职业电竞、直播、赛事制作和商业合作。

\- 腾讯视频与流媒体：腾讯视频、腾讯视频 VIP、腾讯视频 SVIP、WeTV、腾讯视频海外服务，提供电视剧、电影、综艺、纪录片、动漫和短视频等内容。

\- 腾讯新闻与资讯：腾讯新闻、腾讯网、腾讯体育、腾讯财经、腾讯自选股，覆盖综合新闻、体育资讯、财经数据和互联网信息服务。

\- 腾讯音乐娱乐：QQ 音乐、酷狗音乐、酷我音乐、全民 K 歌、波点音乐、懒人听书、喜马拉雅、TME Live，提供在线音乐、数字专辑、音乐社交、音频节目、有声书与演出服务。

\- 阅文数字文学：起点中文网、起点读书、QQ 阅读、创世中文网、红袖读书、潇湘书院、WebNovel，覆盖网络文学创作、数字阅读、海外文学发行和文学版权开发。

\- 腾讯动漫与数字 IP：腾讯动漫、腾讯影业、阅文集团、新丽传媒，以及相关动画、影视、游戏和文学 IP 开发业务，覆盖数字漫画、动画制作、影视制作及跨媒体内容运营。

\- 腾讯微信支付与财付通：微信支付、WeChat Pay、财付通、微信收付款、微信商家支付、微信红包、微信转账，提供移动支付、商户收单、个人转账和支付基础设施服务。

\- 腾讯金融科技与理财服务：腾讯理财通、微信信用卡还款、腾讯自选股、微企付、TenPay Global、WeChat Pay HK，覆盖财富管理、企业支付、跨境支付和金融信息服务，具体业务受金融监管及地区限制。

\- 腾讯云计算基础设施：腾讯云服务器（CVM）、轻量应用服务器（Lighthouse）、弹性伸缩（AS）、裸金属云服务器、GPU 云服务器，提供计算资源、云主机、应用部署和 AI 算力服务。

\- 腾讯云容器与无服务器计算：腾讯云容器服务（TKE）、Serverless Cloud Function（SCF）、Serverless Framework、微服务平台（TSF）、云托管，覆盖 Kubernetes、函数计算、微服务治理和云原生应用部署。

\- 腾讯云存储服务：对象存储（COS）、云硬盘（CBS）、文件存储（CFS）、归档存储、日志服务（CLS）、数据万象（CI）、GooseFS、NitroFS，提供对象存储、块存储、文件共享、日志管理及 AI 数据存储。

\- 腾讯云数据库：TDSQL、TDSQL-C、TDSQL PostgreSQL、TDSQL Boundless、TencentDB for MySQL、PostgreSQL、Redis、MongoDB、SQL Server，覆盖关系型数据库、分布式数据库、NoSQL 和云原生数据管理。

\- 腾讯云网络与边缘计算：私有网络（VPC）、负载均衡（CLB）、内容分发网络（CDN）、EdgeOne、云解析 DNSPod、弹性公网 IP、全球应用加速（GAAP），提供网络隔离、流量转发、边缘加速、域名解析和全球网络连接。

\- 腾讯云音视频与实时通信：腾讯云实时音视频（TRTC）、即时通信 IM、云直播（CSS）、云点播（VOD）、媒体处理（MPS）、腾讯云音视频终端 SDK，提供实时通信、互动直播、视频处理及多媒体应用开发服务。

\- 腾讯云 AI 基础设施：腾讯云 GPU 算力、腾讯云智算、高性能计算（HPC）、混元模型 API、TokenHub、向量数据库（Tencent Cloud VectorDB）、机器学习平台（TI-ONE），提供 AI 模型训练、推理、向量检索和数据处理能力。

\- 腾讯云安全：腾讯云 Web 应用防火墙（WAF）、DDoS 防护、主机安全、云防火墙、数据安全中心、密钥管理系统（KMS）、安全运营中心，覆盖云基础设施安全、身份认证、网络攻击防护和数据保护。

\- 腾讯云开发与运维：云开发（CloudBase）、腾讯微搭低代码、CODING DevOps、腾讯云 API 网关、消息队列 TDMQ、腾讯蓝鲸、持续集成与持续部署工具，提供 Web 与小程序开发、DevOps、低代码开发、自动化部署和运维管理。

\- 腾讯企业微信（WeCom）：企业微信、客户联系、客户群、企业通讯录、审批、考勤、企业微信开放平台，提供企业内部通信、客户关系管理、组织协作及与微信生态连接的商业服务。

\- 腾讯会议（VooV Meeting）：腾讯会议、腾讯会议商业版、腾讯会议企业版、VooV Meeting、腾讯会议 Rooms、腾讯会议 Webinar，覆盖视频会议、在线协作、网络研讨会和企业会议室管理。

\- 腾讯文档与办公协作：腾讯文档、腾讯在线表格、腾讯在线文档、腾讯幻灯片、腾讯收集表、腾讯智能表、腾讯乐享，提供协同文档、电子表格、演示文稿、信息收集和企业知识管理。

\- 腾讯企点企业服务：腾讯企点、腾讯企点客服、腾讯企点营销云、腾讯企点销售、腾讯企点商通，提供企业客服、客户关系管理、营销自动化和数字化商业运营。

\- 腾讯广告与营销：腾讯广告、腾讯广告投放平台、腾讯营销 API、微信广告、朋友圈广告、视频号广告、公众号广告、腾讯广告智能投放工具，覆盖精准广告、程序化投放、品牌营销和广告效果分析。

\- 腾讯搜索与输入法：搜狗输入法、微信搜一搜、QQ 浏览器搜索、搜狗搜索相关技术，覆盖中文输入、信息检索、AI 搜索及自然语言处理。

\- 腾讯浏览器与应用工具：QQ 浏览器、应用宝、腾讯手机管家、腾讯电脑管家、腾讯文件管理相关工具，提供网页浏览、应用分发、安全管理及基础计算机工具。

\- 腾讯地图与位置服务：腾讯地图、腾讯位置服务、腾讯地图开放平台、地图 SDK、地理编码、路线规划、实时定位和位置数据 API，提供地图导航、位置搜索及企业地理信息服务。

\- 腾讯车联网与智慧出行：腾讯智慧出行、腾讯智能座舱、腾讯车联、腾讯地图车载服务、腾讯云汽车行业解决方案，覆盖智能车载系统、地图导航、汽车云计算及出行数据服务。

\- 腾讯智慧医疗：腾讯觅影、腾讯健康、腾讯医疗健康云、微信医疗健康服务、医疗 AI 辅助技术，涉及医疗影像分析、医院数字化、在线健康服务及医疗数据平台。

\- 腾讯智慧教育：腾讯教育、腾讯课堂（历史产品）、腾讯云教育解决方案、企业微信教育版、腾讯会议教育应用，覆盖教育信息化、在线协作、智慧校园及 AI 教育工具。

\- 腾讯智慧零售与产业数字化：腾讯智慧零售、腾讯智慧城市、腾讯智慧工业、腾讯云政务、腾讯云金融、腾讯云交通，主要提供基于微信生态、云计算、AI、数据分析及行业软件的企业数字化解决方案。

\- 腾讯区块链与可信技术：腾讯区块链、至信链、腾讯云区块链服务、电子存证与数字版权保护技术，涉及可信数据记录、版权保护、供应链追溯和企业区块链应用。

\- 腾讯开发者与开源生态：Tars、TDesign、TencentOS Server、TencentOS Tiny、ncnn、Tencent Angel、MMKV、Mars、Kona JDK，覆盖微服务框架、前端组件、操作系统、机器学习、移动端推理、存储和 Java 开发工具。

\- 腾讯公益与数字公共服务：腾讯公益、久久公益节（原99公益日）、腾讯志愿者、微信城市服务及相关公益数字化平台，提供公益募捐、公益项目管理、社会服务和数字公共服务支持。

#### 招聘情况
- [官网](https://careers.tencent.com/home.html)
![示意图](PixPin_2026-04-24_23-15-29.webp)

腾讯的业务很多,岗位也非常多,官网上的要求都比较简单,但实际应聘的时候都是会狠狠拷打你的:
![示意图](PixPin_2026-04-23_17-37-11.webp)

- 翻了翻都是远程面试,还不错

##### 面试流程一览
[腾讯面试流程](https://github.com/0voice/cpp_backend_awsome_blog/blob/main/%E3%80%90NO.82%E3%80%91%E8%80%97%E6%97%B61%E4%B8%AA%E6%9C%88%EF%BC%8C%E4%B8%87%E5%AD%97%E5%B9%B2%E8%B4%A7%EF%BC%8C%E8%AF%A6%E8%A7%A3%E8%85%BE%E8%AE%AF%E9%9D%A2%E8%AF%95%EF%BC%88T1-T9%EF%BC%89%E6%A0%B8%E5%BF%83%E6%8A%80%E6%9C%AF%E7%82%B9%EF%BC%8C%E9%9D%A2%E8%AF%95%E9%A2%98%E6%95%B4%E7%90%86.md)
##### 面经1
- [来源](https://www.nowcoder.com/feed/main/detail/f054aef412104109a1dfa85e273e6faf?sourceSSR=enterprise)

```md
## 项目深挖与常规问答


* **自我介绍**
* **核心项目介绍：** 挑一个花费时间最多、最重点的项目介绍，并罗列一两个难点。
* **后续追问：** 目前项目的访问量多大？（如实回答目前仅作个人和朋友测试使用）。

---

## 计算机基础与后端八股

### 操作系统与网络
* Python多进程解决OOM问题，为什么不用多线程？
* 进程和线程在操作系统层面的核心区别是什么？
* FastAPI 服务端延迟极低，客户端发起请求时，TCP 建立连接的过程是怎样的？
* 项目中实现在线推送为什么使用 WebSocket 而不用 HTTP 轮询？

### JVM 基础
* Java 程序运行时，JVM 内存分为哪几块？
* 堆里的对象是一定会被回收的吗？
* 引用类型会被回收吗？

### Redis
* 项目中的布隆过滤器、互斥锁、逻辑过期分别是解决什么问题的？
* 逻辑过期和物理过期的区别是什么？
* HyperLogLog、ZSet、Bitmap 的底层原理和适用场景是什么？
* 场景题：如何统计最近七天内每天都活跃的日活用户交集？

### 消息队列 (RabbitMQ)
* 如何保证消息百分之百入库？描述消息从生产到消费的完整可靠链路。
* 死信队列里面是怎么处理的？
* 怎么保证消息的幂等性？

### 数据库 (MySQL)
* 索引场景题：有用户表、签到表（自增ID，user_id，签到时间，状态），要查某个用户某个月的签到记录，怎么加索引？
* 如果不用 Redis，直接在 MySQL 层面避免高并发下的重复点赞，怎么设计？
* 如果并发量很大，使用乐观锁和悲观锁的区别？使用悲观锁有什么问题？

---

## 算法与代码手撕

* 实现 `O(1)` 时间复杂度的 LRU 缓存
* 合并 K 个升序链表

---

## AI 与大模型工程

* RAG（检索增强生成）的工作流分哪几步？
* RAG 知识库生成的步骤是什么？
* 向量检索时，怎么判断相似度？
* 你项目里的 Agent 架构是怎么设计的？

---

## 反问环节

* 如果有幸入职，主要会做哪些工作？难点在哪里？
* 腾讯内部对使用 AI 辅助编程的态度是什么？
* 对我今天的面试表现有什么评价或建议？
```
### 阿里
#### 公司概况
阿里巴巴是一家成立于1999年、总部位于杭州的全球性科技巨头，也是全球最大的电子商务与零售平台之一。其业务体系以淘宝、天猫为核心，覆盖了云计算、数字媒体、物流及金融科技（蚂蚁集团）等多元领域。2014年阿里巴巴在纽交所完成了当时全球规模最大的IPO。进入2026年，阿里通过“千问”大模型全面向AI驱动转型，旗下云智能与国际商业板块表现强劲，目前仍是全球最具价值的互联网公司之一。

#### 公司历史

\- 1999—2002｜创立与 B2B 电子商务：马云（Jack Ma）、蔡崇信（Joseph Tsai）等18位创始人于1999年在浙江杭州创立阿里巴巴（Alibaba），最初以连接中国中小企业与海外采购商为目标，推出国际批发贸易平台 Alibaba.com 和国内批发平台阿里巴巴中国站（后发展为1688）。2000年获得软银等机构投资，逐渐建立以企业会员、贸易信息发布、供应商认证和在线营销为核心的 B2B 商业模式。2002年实现全年盈利，成为中国早期互联网商业服务的重要企业。

\- 2003—2008｜淘宝、支付宝与电商生态建立：2003年推出淘宝网（Taobao），进入个人消费者电子商务市场，并通过免费开店策略与 eBay 易趣竞争。同年推出支付宝担保交易服务，2004年正式成立支付宝，解决网络交易中的信用与支付问题。2005年与雅虎达成战略交易，获得雅虎中国业务及10亿美元投资。2007年推出阿里妈妈广告营销平台，旗下 B2B 业务在香港上市。2008年推出淘宝商城（2012年更名为天猫），将品牌商家与个人卖家市场区分，逐渐形成淘宝、天猫、支付宝、阿里妈妈共同发展的电商基础设施。

\- 2009—2013｜移动电商、云计算与物流网络：2009年成立阿里云（Alibaba Cloud），开始研发飞天（Apsara）分布式云计算操作系统，并首次举办“双11”购物活动。2010年推出全球零售平台 AliExpress（速卖通）和手机淘宝，推动电商业务国际化与移动化。2011年支付宝业务重组，进一步形成独立于阿里巴巴上市集团的金融科技体系。2012年阿里巴巴 B2B 业务从香港退市，2013年成立菜鸟网络（Cainiao），联合物流企业建设电子商务物流基础设施。同年马云卸任 CEO，由陆兆禧接任，阿里巴巴逐渐形成电子商务、支付、物流和云计算相互连接的平台生态。

\- 2014—2018｜美国上市与数字经济集团化：2014年阿里巴巴集团在纽约证券交易所上市（BABA），完成当时全球规模最大的 IPO 之一。同年收购高德地图和 UC 优视，进入移动地图、浏览器与数字内容领域，并投资优酷土豆。2015年取得阿里健康控制权，2016年完成优酷土豆私有化，同时取得东南亚电商平台 Lazada 的控制权。2016年提出“新零售”战略，推出盒马鲜生，推动线上电商、实体零售、支付和供应链融合。2017年成立达摩院，发展人工智能、芯片和前沿科技研究；2018年全资收购饿了么，成立平头哥半导体，进一步扩展本地生活与半导体业务。

\- 2019—2022｜香港上市、云计算扩张与监管调整：2019年阿里巴巴在香港联合交易所第二上市（9988.HK），马云卸任集团董事会主席，由张勇（Daniel Zhang）接任。2020年通过增持取得高鑫零售控股权，进一步整合大润发等实体零售业务，并扩大阿里云、钉钉、盒马和菜鸟网络的发展。2021年受到中国互联网平台反垄断监管影响，集团因“二选一”等行为被处以182.28亿元人民币罚款，并调整平台经营规则。2022年继续发展国际电商、云计算、企业协作及物流业务，同时面临国内电商竞争加剧、消费增长放缓和成本调整压力。

\- 2023—2024｜组织架构重组与聚焦核心业务：2023年宣布“1+6+N”组织变革，拟建立由集团控股、多个业务集团独立经营的架构，业务涵盖淘宝天猫、阿里国际、阿里云、菜鸟、本地生活和数字文娱。2023年9月蔡崇信接任董事会主席，吴泳铭（Eddie Wu）接任 CEO，进一步明确“用户为先、AI 驱动”战略。2024年撤回菜鸟香港上市申请，并提出收购其少数股东股份，同时取消阿里云分拆上市计划，将资源重新集中于核心电商与云计算。同期阿里巴巴在香港转为主要上市，并持续发展通义千问（Qwen）大模型、AI 开发平台和跨境电商。

\- 2025｜电商整合与全栈 AI 战略：2025年完成高鑫零售和银泰商业相关出售交易，减少传统实体零售资产，集中投资电商、云计算和人工智能。同年将淘宝天猫、饿了么和飞猪整合为阿里巴巴中国电商集团，推出淘宝闪购，扩大即时零售和本地配送业务；12月饿了么 App 正式更名为淘宝闪购。阿里云推出 Qwen3 系列模型，持续扩展通义千问、万相、百炼和 AI 算力基础设施，并宣布未来三年投入至少3800亿元建设云计算与 AI 基础设施。集团逐渐将战略中心转向 AI 与云计算、消费和即时零售。

\- 2026｜AI 云与算力、电商及智能体全面整合：2026年进一步调整组织架构，将国内电商、国际电商和盒马整合为阿里巴巴电商集团；将阿里云与平头哥半导体整合为 AI 云与算力服务；将 AI 模型实验室、千问消费者业务和千问办公整合为 AI 实验室与应用，形成三大核心业务与其他业务并行的结构。公司推出 Qwen3.5、Qwen3.8、千问办公（QwenWork）以及 Qwen Intelligence 等模型和智能体产品，并将 AI 购物助手接入淘宝。2026年9月云栖大会发布真武 V900 AI 芯片、升级版 AI 超节点及面向智能体的云计算方案，同时公布 Qwen4 训练进展与后续模型路线图。2026年6月季度集团营收达到2689.53亿元人民币，同比增长9%，AI 云与算力服务成为新的重要增长动力。

#### 控股公司及子公司

集团主体：阿里巴巴集团控股有限公司（Alibaba Group Holding Limited）

- 总部及主要经营管理中心位于中国浙江省杭州市，注册地为开曼群岛，1999年成立。2014年在纽约证券交易所上市（BABA），2019年在香港联合交易所上市（9988.HK），2024年将香港上市地位升级为主要上市。
- 阿里巴巴是集团顶层上市公司，没有另一家企业作为其控股母公司。蔡崇信（Joseph Tsai）担任董事会主席，吴泳铭（Eddie Wu）担任 CEO。集团通过公众股东持股和阿里巴巴合伙人制度共同形成公司治理体系，软银曾是重要大股东，近年来已大幅减少持股。
- 按2026年8月公布的新组织架构，集团主要分为阿里巴巴电商集团（Alibaba E-commerce Group）、AI云与算力服务（AI Cloud and Compute Services）、AI实验室与应用（AI Labs and Applications）以及其他业务（All Others）四个报告分部。
- 阿里巴巴电商集团包括中国电商、即时零售、国际电商、全球批发及盒马等业务；AI云与算力服务主要包括阿里云和平头哥半导体；AI实验室与应用包括千问模型实验室、千问消费者业务和千问办公；其他业务包括菜鸟、高德、阿里健康、虎鲸文娱、灵犀互娱等。
- 集团采用直接控股、间接控股、上市子公司及协议控制实体（VIE）相结合的经营架构，部分中国大陆互联网经营实体通过合同安排纳入集团合并财务报表，需要与直接持股子公司区分。

主要子公司及收购业务：

- 淘宝（Taobao）：2003年成立，中国主要的综合电子商务平台之一，经营淘宝网、手机淘宝、淘宝直播、淘金币、淘工厂等业务，覆盖个人卖家、品牌商家、直播电商和综合消费。
- 天猫（Tmall）：2008年作为淘宝商城推出，2012年更名为天猫，主营品牌商家 B2C 零售业务，旗下包括天猫、天猫国际、天猫超市、天猫奢品等产品，现与淘宝共同构成阿里巴巴国内电商体系的核心。
- 1688：1999年由阿里巴巴中国批发贸易业务发展而来，主营国内 B2B 商品批发、制造商直销和供应链采购，主要面向中小商家、零售商及企业采购客户。
- 阿里巴巴国际站（Alibaba.com）：1999年成立，面向全球采购商、制造商及出口企业提供 B2B 国际贸易平台，是集团最早的核心业务之一，现属于阿里巴巴电商集团的全球批发业务。
- AliExpress（全球速卖通）：2010年推出，面向海外消费者的跨境零售电商平台，主要经营中国及其他市场商家面向全球的商品销售，提供跨境交易、国际物流及本地配送服务。
- Lazada：2016年阿里巴巴取得其控制权，东南亚大型电子商务平台，主要经营印度尼西亚、马来西亚、菲律宾、新加坡、泰国及越南市场，提供在线零售、商家服务和本地物流。
- Trendyol：2018年阿里巴巴投资并取得控制权，土耳其大型电子商务企业，主营服饰、综合零售、即时配送及国际电商服务，是阿里巴巴连接土耳其、欧洲和中东市场的重要平台。
- Daraz：2018年完成收购，南亚电子商务平台，主要经营巴基斯坦、孟加拉国、斯里兰卡和尼泊尔等市场，提供在线零售、商家服务及电商物流。
- 盒马（Freshippo）：2015年开始筹建，2016年推出盒马鲜生，主营线上线下一体化生鲜零售、食品超市和即时配送，旗下包括盒马鲜生、盒马 NB 等业态。2026年整合进入阿里巴巴电商集团。
- 淘宝闪购（原饿了么）：2018年阿里巴巴完成对饿了么的全资收购，原主营在线外卖、餐饮配送和本地生活服务。2025年与淘宝即时零售深度整合，并将饿了么 App 更名为淘宝闪购，扩展餐饮、商超、医药、鲜花和消费电子等即时零售品类。
- 飞猪（Fliggy）：由阿里旅行相关业务发展而来，2016年启用飞猪品牌，主营酒店、机票、旅游度假、景区门票和在线旅行服务，2025年整合进入阿里巴巴中国电商业务体系。
- 闲鱼（Xianyu）：2014年推出，主营二手商品交易、闲置物品流转、兴趣交易和个人消费品转售，属于集团国内电商业务。
- 菜鸟网络（Cainiao）：2013年由阿里巴巴联合物流及投资企业成立，主要从事电商物流基础设施、仓储、供应链、国际物流和末端配送。阿里巴巴2017年取得控股权，2024年撤回其香港上市申请并进一步提出收购少数股东股份的方案。
- 阿里云（Alibaba Cloud）：2009年成立，主营公有云、混合云、数据库、大数据、人工智能和企业数字化服务，是阿里巴巴 AI 云与算力服务体系的核心。
- 平头哥半导体（T-Head）：2018年通过整合阿里巴巴达摩院芯片研发团队和中天微相关技术成立，主营 CPU、AI 加速器、智能网卡和芯片互连技术，核心产品包括倚天、玄铁、真武、含光等系列，2026年整合进入 AI 云与算力服务。
- 钉钉（DingTalk）：2014年开始研发，2015年正式推出，主营企业即时通信、在线办公、协作平台、组织管理及企业 AI 服务，旗下包括钉钉文档、钉钉会议、钉钉宜搭、钉钉 AI 等。
- 高德地图（Amap / AutoNavi）：2014年阿里巴巴完成全资收购，主营地图导航、交通信息、位置服务及本地生活服务，主要产品包括高德地图、高德打车、高德开放平台、高德扫街榜。
- UC 优视（UCWeb）：2014年完成全面收购，主要经营 UC 浏览器、信息分发和相关移动互联网业务，部分团队与产品能力参与夸克等 AI 信息服务产品研发。
- 夸克（Quark）：由阿里巴巴旗下智能信息业务发展而来，提供 AI 搜索、浏览器、网盘、学习、扫描、文档处理等服务，已逐步发展为集团面向消费者的重要 AI 应用。
- 虎鲸文娱集团（Hujing Digital Media and Entertainment Group）：由阿里巴巴数字媒体与娱乐相关业务整合形成，主要涉及优酷、影视制作、演艺及相关数字内容业务。
- 优酷（Youku）：2015年阿里巴巴宣布收购优酷土豆，2016年完成私有化，主营在线视频、电视剧、电影、综艺、动漫和数字娱乐内容，是阿里巴巴数字文娱业务的重要组成部分。
- 大麦娱乐（Damai Entertainment Holdings Limited）：原阿里巴巴影业集团，2025年更名为大麦娱乐，在香港上市（01060.HK），阿里巴巴通过旗下实体持有控制性股权，主要经营演出票务、影视制作、IP 开发及相关娱乐服务。
- 大麦（Damai）：阿里巴巴于2017年取得其控制权，主营演唱会、话剧、音乐节、体育赛事及现场娱乐票务服务，现属于大麦娱乐体系。
- 阿里健康（Alibaba Health Information Technology Limited）：2014年阿里巴巴通过资产注入和股权交易进入其业务体系，2015年取得控制权，在香港上市（00241.HK），主要经营线上医药零售、医药电商平台、数字医疗和健康管理服务。
- 灵犀互娱（Lingxi Games）：阿里巴巴旗下游戏开发与运营业务，主要从事移动游戏研发、发行及游戏 IP 运营，代表产品包括《三国志·战略版》《三国志·战棋版》等。

集团重要法律实体：

- Alibaba Group Holding Limited（阿里巴巴集团控股有限公司）：注册于开曼群岛，是集团顶层上市及控股主体。
- Taobao Holding Limited（淘宝控股有限公司）：注册于开曼群岛，是阿里巴巴全资子公司，承担中国电商相关业务的控股职能。
- Taobao China Holding Limited（淘宝中国控股有限公司）：注册于中国香港，是 Taobao Holding Limited 全资子公司，承担部分中国电商业务的控股职能。
- 淘宝（中国）软件有限公司：阿里巴巴全资控制的重要境内实体，为淘宝平台提供软件研发和技术服务。
- 浙江天猫技术有限公司：阿里巴巴全资控制的重要境内实体，主要为天猫平台提供软件及技术服务。
- 浙江淘宝网络有限公司：淘宝业务相关境内经营实体，属于集团通过协议控制等安排纳入合并报表的主体。
- 浙江天猫网络有限公司：天猫业务相关境内经营实体，属于集团协议控制经营架构的一部分。
- 阿里巴巴（中国）有限公司：注册于中国，是集团重要境内经营及管理实体。
- 阿里巴巴（中国）网络技术有限公司及相关技术经营实体：承担集团中国大陆互联网、电子商务及相关技术业务，具体经营范围依实体而有所不同。
- 阿里云计算有限公司：注册于中国，是阿里云重要的境内云计算经营实体。
- 杭州阿里云飞天信息技术有限公司：阿里云相关研发与技术经营实体，涉及分布式计算、云基础设施及相关技术。
- 阿里云计算（上海）信息科技有限公司：阿里云境内重要经营实体，涉及云计算和企业技术服务。
- 上海盒马网络科技有限公司：盒马鲜生及相关零售业务的重要境内法律实体。
- 拉扎斯网络科技（上海）有限公司：原饿了么业务的重要境内经营实体，现与淘宝闪购及即时零售体系相关。
- 浙江飞猪网络技术有限公司：飞猪旅游平台相关境内经营实体。
- 高德软件有限公司：高德地图相关境内经营实体。
- 钉钉（中国）信息技术有限公司：钉钉办公协作业务的重要法律实体。
- 平头哥（上海）半导体有限公司：平头哥半导体研发及相关芯片业务的重要经营实体。
- 优酷信息技术（北京）有限公司：优酷视频业务相关法律实体。
- 北京大麦文化传媒发展有限公司：大麦演艺票务及娱乐业务相关经营实体。
- Alibaba.com Limited（阿里巴巴网络有限公司）：注册于开曼群岛，是集团全资子公司，承担国际数字商业及云业务相关控股职能。
- Alibaba.com Investment Holding Limited：注册于英属维尔京群岛，属于集团国际电商及云业务相关控股实体。
- Alibaba Investment Limited：注册于英属维尔京群岛，属于集团重要投资控股实体。
- Alibaba Group Services Limited：注册于中国香港，承担部分集团资金管理及相关服务职能。
- Cainiao Smart Logistics Network Limited：注册于开曼群岛，是菜鸟物流业务的重要控股法律实体。
- Lazada South East Asia Pte. Ltd.：注册于新加坡，是东南亚 Lazada 电商业务的重要控股和经营实体。
- Alibaba Southeast Asia Holding Private Limited：注册于新加坡，属于集团东南亚投资及控股架构。
- Alibaba Cloud (Singapore) Private Limited：注册于新加坡，是阿里云国际业务的重要运营实体。
- Alibaba Cloud LLC：注册于美国，属于阿里云国际经营体系。
- Alibaba Cloud Japan Services Corporation：注册于日本，承担阿里云日本市场的相关业务。
- Alibaba Cloud (Malaysia) Sdn. Bhd.：注册于马来西亚，是阿里云东南亚业务相关法律实体。
- AliExpress International (Netherlands) B.V.：注册于荷兰，属于 AliExpress 国际零售业务相关实体。
- Damai Entertainment Holdings Limited：注册于百慕大，是大麦娱乐业务的香港上市主体。
- Alibaba Health Information Technology Limited：注册于百慕大，是阿里健康业务的香港上市主体。

以上法律实体主要依据阿里巴巴截至2026年3月31日的年度报告及 SEC Exhibit 8.1 披露整理。该名单包括直接和间接控股公司及部分协议控制实体，不代表集团全部法律实体。

其他重要投资及历史股权关系：

- 蚂蚁集团（Ant Group）：由支付宝及阿里巴巴相关金融科技业务发展而来，主要经营支付宝、蚂蚁财富、网商银行相关金融科技、保险科技和企业数字化服务。阿里巴巴持有约33%股权，属于重要参股企业和关联方，蚂蚁集团具有独立股权和治理结构，不属于阿里巴巴控股子公司。
- 支付宝（Alipay）：由淘宝担保交易业务发展而来，目前主要由蚂蚁集团体系运营。虽然与阿里巴巴电商平台深度合作，但支付宝的法律归属需要按照蚂蚁集团股权结构理解，不能直接列为阿里巴巴集团全资产品。
- 网商银行（MYbank）：2015年成立的互联网银行，由蚂蚁集团等股东发起，属于独立持牌金融机构，不是阿里巴巴集团直接控股子公司。
- SoftBank Group（软银集团）：日本投资集团，2000年成为阿里巴巴重要早期投资者，此后长期是集团主要股东之一。近年来大幅降低持股比例，软银与阿里巴巴不构成母子公司关系。
- Yahoo（雅虎）：2005年与阿里巴巴达成重大股权和业务合作交易，曾是阿里巴巴重要股东。后续通过股份回购及其他交易逐渐退出主要股东地位，雅虎中国业务也已退出历史舞台。
- 高鑫零售（Sun Art Retail Group）：运营大润发、欧尚等超市业务，阿里巴巴于2020年取得控制权，2025年完成出售，现不属于集团控股业务。
- 银泰商业（Intime Retail）：阿里巴巴曾通过收购取得控制权，经营百货及购物中心业务，2024年宣布出售，并于2026财年完成相关交易，现不属于集团控股业务。
- 苏宁易购：阿里巴巴曾是重要战略投资者，双方在电商、零售和供应链领域开展合作，但苏宁易购属于独立上市企业。
- 分众传媒：阿里巴巴曾投资其相关股权，并在数字广告及商业营销方面展开合作，分众传媒保持独立上市和经营。
- 哔哩哔哩（Bilibili）：阿里巴巴曾通过淘宝中国等实体参与投资，并开展内容、电商和营销合作，但哔哩哔哩并非其控股子公司。
- 小鹏汽车（XPeng）：阿里巴巴曾是重要投资者之一，双方在互联网汽车和技术领域开展合作。阿里巴巴后续减持相关股份，小鹏汽车保持独立上市和经营。
- 新浪微博（Weibo）：阿里巴巴于2013年起投资微博，并与其开展广告和电商合作，属于战略参股关系，微博不是阿里巴巴控股子公司。
- 哈啰出行（Hello）：阿里巴巴及蚂蚁集团相关投资体系曾参与其融资，主要经营共享单车、两轮出行和本地出行服务，哈啰属于独立运营企业，不能直接列为阿里巴巴全资业务。

#### 主要产品

\- 淘宝综合电商：淘宝、手机淘宝、淘宝直播、淘宝逛逛、淘宝店铺、淘宝会员、88VIP、淘宝百亿补贴，覆盖综合商品交易、直播带货、内容电商和会员消费服务。

\- 天猫品牌零售：天猫、天猫国际、天猫超市、天猫奢品、天猫旗舰店、天猫品牌商家服务，主要面向品牌商家及消费者提供 B2C 电商、跨境进口、品牌营销和在线零售服务。

\- 1688 国内批发平台：1688、1688 App、1688 诚信通、1688 超级工厂、1688 工业品、1688 跨境供货，覆盖国内商品批发、制造商直销、企业采购和供应链交易。

\- Alibaba.com 国际 B2B 平台：Alibaba.com、Alibaba.com Seller Center、Alibaba.com Trade Assurance、Alibaba.com RFQ、Alibaba.com Logistics，提供全球批发贸易、国际采购、供应商展示、交易保障和跨境商贸服务。

\- AliExpress 全球速卖通：AliExpress、AliExpress Choice、AliExpress Seller Center，面向全球消费者提供跨境商品零售、本地化销售及商家服务。

\- Lazada 东南亚电商：Lazada、LazMall、Lazada Seller Center、Lazada Logistics，覆盖东南亚综合零售、品牌旗舰店、商家运营和本地物流。

\- Trendyol 土耳其电商：Trendyol、Trendyol Go、Trendyol Express，提供综合电商、即时配送和物流服务，主要面向土耳其及周边国际市场。

\- Daraz 南亚电商：Daraz、DarazMall、Daraz Seller Center、Daraz Logistics，覆盖南亚综合电商、品牌零售、商家运营及物流配送。

\- 闲鱼二手交易：闲鱼、闲鱼 App、闲鱼验货宝、闲鱼回收及相关个人闲置交易功能，提供二手商品转让、兴趣交易和循环消费服务。

\- 淘宝闪购即时零售：淘宝闪购（原饿了么）、淘宝即时零售频道、蜂鸟配送相关服务，覆盖餐饮外卖、生鲜商超、药品、鲜花、电子产品及其他即时配送商品。

\- 盒马新零售：盒马鲜生、盒马 NB、盒马 App、盒马自有品牌，提供生鲜食品、超市零售、食品加工及线上线下一体化配送。

\- 飞猪在线旅行：飞猪旅行、飞猪酒店、飞猪机票、飞猪度假、飞猪景区门票、飞猪商家平台，覆盖酒店预订、交通出行、旅游度假和在线旅行服务。

\- 阿里妈妈数字广告：阿里妈妈、万相台、直通车、引力魔方、淘宝联盟、阿里妈妈营销平台，提供商家广告投放、精准营销、流量分发和广告效果分析。

\- 阿里云计算基础设施：阿里云服务器 ECS、轻量应用服务器、GPU 云服务器、弹性伸缩、弹性裸金属服务器、高性能计算平台，覆盖云主机、AI 计算、企业服务器及高性能计算服务。

\- 阿里云容器与无服务器计算：容器服务 ACK、容器镜像服务 ACR、函数计算 FC、弹性容器实例 ECI、Serverless 应用引擎 SAE、微服务引擎 MSE，提供 Kubernetes、容器编排、函数计算和云原生应用部署。

\- 阿里云存储服务：对象存储 OSS、块存储 EBS、文件存储 NAS、CPFS、日志服务 SLS、云备份，覆盖对象存储、文件共享、高性能存储、日志管理和数据备份。

\- 阿里云数据库：云数据库 RDS、PolarDB、PolarDB-X、Tair、Lindorm、AnalyticDB、Hologres、Tablestore，覆盖关系型数据库、分布式数据库、NoSQL、缓存和实时分析。

\- 阿里云大数据平台：MaxCompute、DataWorks、Realtime Compute for Apache Flink、EMR、Hologres、Quick BI、DataV，提供离线数据处理、实时计算、数据开发、数据仓库和商业智能。

\- 阿里云网络与边缘计算：专有网络 VPC、负载均衡 SLB、NAT 网关、CDN、DCDN、全球加速 GA、云企业网 CEN、边缘节点服务 ENS，提供网络隔离、流量分发、内容加速和全球网络连接。

\- 阿里云安全服务：Web 应用防火墙 WAF、DDoS 防护、云安全中心、云防火墙、密钥管理服务 KMS、操作审计 ActionTrail、应用身份服务 IDaaS，覆盖云安全、身份认证、访问控制及数据保护。

\- 阿里云 AI 基础设施：人工智能平台 PAI、PAI-EAS、灵骏智算、阿里云百炼（Model Studio）、模型推理服务、AI 超节点、GPU 云服务器，提供大模型训练、推理、模型部署和 AI 应用开发基础设施。

\- 阿里云百炼大模型服务：阿里云百炼（Model Studio）、模型广场、模型 API、知识库、智能体应用、工作流编排及相关 MaaS 服务，提供模型调用、提示词开发、模型微调、RAG 和 AI 智能体构建能力。

\- 阿里云 Agentic Cloud：AI Native Cloud、Smart Studio、Smart Fusion、Smart Video，以及面向模型、智能体运行环境和上下文管理的云服务，支持大规模 AI 智能体开发、运行及企业自动化。

\- 通义千问基础模型：Qwen、Qwen2、Qwen2.5、Qwen3、Qwen3.5、Qwen3.6、Qwen3.8，覆盖语言理解、复杂推理、代码生成、多模态交互和智能体任务。其中 Qwen4 截至2026年10月仍在训练，Qwen4.5、Qwen5 属于后续规划。

\- 通义千问多模态模型：Qwen-VL、Qwen-Audio、Qwen-Omni、Qwen-Image、Qwen3.8-LiveTranslate、Qwen-Audio-3.1-TTS-Next，覆盖图像识别、语音理解、音视频交互、图像生成和实时翻译。

\- 通义千问编程模型：Qwen2.5-Coder、Qwen3-Coder、Qwen3-Coder-Next 及相关代码模型，面向代码生成、程序理解、软件测试、仓库级代码分析与智能体编程。

\- 通义万相 AI 创作模型：通义万相（Wan）、Wan2.1、Wan2.2、Wan2.6、Wan2.7，提供文生图、图像编辑、文生视频、图生视频和多镜头视频生成服务。

\- 千问 AI 助手：千问 App、Qwen App、千问 AI 购物助手、千问 AI 搜索及相关多模态交互功能，提供智能问答、内容生成、学习辅助、购物推荐、商品下单和生活服务。

\- 千问办公（QwenWork）：QwenWork、千问办公网页版、桌面客户端、云端智能体、桌面智能体、企业协作智能体，提供文档处理、任务自动化、跨应用操作和企业工作流执行。原 QoderWork、MuleRun、悟空相关能力于2026年整合进入这一平台。

\- 千问智能体与 AI 开发：Qwen Intelligence、Qwen Agent、千问模型 API、智能体开发工具及模型部署服务，支持复杂任务规划、工具调用、多模态交互、智能手机 AI 和企业智能体应用。

\- 千问 AI 智能眼镜：千问 AI 眼镜 G1、S1、N1、N1 Pro，提供第一视角拍摄、AI 语音问答、实时翻译、会议记录、图像识别及部分型号的近眼显示、眼动追踪功能。

\- 千问 AI 可穿戴与个人硬件：千问 AI 耳夹式耳机、QwenNote 智能笔记设备，以及相关智能体计算终端，覆盖语音交互、随身信息记录、AI 助理和移动办公。

\- 平头哥 AI 芯片：含光800、真武 M890、真武 V900，覆盖 AI 推理、模型训练和数据中心加速计算。其中真武 V900 已于2026年9月发布，计划于2027年第一季度正式量产上市。

\- 平头哥 CPU 与处理器 IP：倚天710、倚天720、倚天730，以及玄铁（Xuantie）RISC-V 处理器系列，覆盖数据中心 CPU、嵌入式芯片、物联网设备和 RISC-V 架构技术。其中部分下一代产品仍处于规划阶段。

\- 平头哥网络与互连芯片：磐脉智能网卡、ICN 互连芯片、镇岳 SSD 控制器及相关数据中心专用芯片，提供高速网络、存储控制和 AI 超节点互连能力。

\- 阿里云磐久服务器与超节点：磐久服务器、真武 M890 AI 超节点、真武 V900 超节点及相关集群基础设施，面向数据中心、AI 模型训练与大规模推理，部分下一代系统计划于2027年交付。

\- 飞天云计算操作系统：飞天（Apsara）、飞天企业版、飞天云操作系统相关分布式计算技术，负责云服务器、存储、网络和大规模计算资源的统一调度与管理。

\- 钉钉企业协作：钉钉、钉钉文档、钉钉会议、钉钉日历、钉钉项目、钉钉审批、钉钉考勤、钉钉通讯录、钉钉直播，提供企业通信、组织管理及协同办公。

\- 钉钉 AI 与低代码开发：钉钉 AI 助理、钉钉宜搭、钉钉开放平台、钉钉 AI 表格、钉钉智能体及相关自动化功能，提供企业应用开发、业务流程自动化和 AI 协作服务。

\- 夸克 AI 搜索与浏览器：夸克、夸克 AI 搜索、夸克浏览器、夸克 AI 超级框、夸克学习，提供信息检索、知识问答、内容总结和智能浏览服务。

\- 夸克网盘与文档工具：夸克网盘、夸克扫描王、夸克文档处理、夸克 PDF、夸克 AI PPT，提供云端文件管理、文档扫描、PDF 转换、资料处理和办公创作。

\- 高德地图与导航：高德地图、高德导航、高德实时路况、高德公交、高德步行导航、高德骑行导航、高德地图车机版，覆盖地图搜索、路线规划、导航和交通信息服务。

\- 高德本地生活与出行：高德打车、高德扫街榜、高德酒店、高德门票、高德位置服务，提供聚合出行、商家发现、餐饮推荐、旅游消费及本地生活信息服务。

\- 高德开放平台：高德地图 API、位置服务 API、地图 SDK、导航 SDK、地理编码、路径规划、实时定位和空间智能服务，面向开发者、汽车企业及互联网应用提供地理信息技术。

\- UC 浏览器与信息服务：UC 浏览器、UC 大字版、UC 网盘及相关信息分发工具，提供移动网页浏览、内容阅读、文件管理和互联网信息服务。

\- 菜鸟物流与供应链：菜鸟、菜鸟国际、菜鸟供应链、菜鸟仓储、菜鸟跨境物流、菜鸟无忧物流，覆盖国内仓储、国际配送、跨境履约和供应链管理。

\- 菜鸟末端配送：菜鸟驿站、菜鸟裹裹、菜鸟速递及相关快递服务，提供包裹寄送、物流查询、社区自提和末端配送。

\- 菜鸟物流技术：菜鸟物流科技、菜鸟仓储自动化、智能分拣系统、物流管理系统及相关机器人技术，涉及智慧仓储、路径优化、物流数据和自动化配送。

\- 阿里健康医药服务：阿里健康、阿里健康大药房、天猫健康、阿里健康互联网医院及相关医疗服务，覆盖药品零售、线上问诊、健康管理和医药电商。

\- 优酷视频与流媒体：优酷、优酷 VIP、优酷国际版 YOUKU、优酷少儿等产品，提供电视剧、电影、综艺、动漫和在线影视内容。

\- 大麦演艺票务：大麦、大麦 App、演唱会票务、音乐节票务、剧场演出票务、体育赛事票务及相关现场娱乐服务。

\- 大麦娱乐影视业务：大麦娱乐、阿里影业相关影视制作和发行、IP 开发、娱乐内容投资及数字化娱乐服务。

\- 灵犀互娱游戏：《三国志·战略版》《三国志·战棋版》及其他灵犀互娱研发和发行的移动游戏，主要面向策略类和角色扮演游戏市场。

\- 阿里妈妈商家营销技术：阿里妈妈广告投放平台、万相台、淘宝联盟、商家经营分析及 AI 智能营销工具，为淘宝、天猫等平台商家提供广告、流量与经营服务。

\- 阿里巴巴企业采购与跨境贸易服务：1688 企业采购、Alibaba.com 国际批发、国际站 Trade Assurance、一达通及相关跨境贸易数字化服务，涵盖商贸撮合、订单管理、贸易履约和供应链服务。

\- 阿里巴巴开发者与开源生态：ModelScope（魔搭社区）、Qwen 开源模型、Dragonwell（龙蜥相关 Java 运行时）、OpenAnolis（龙蜥操作系统社区）、Nacos、Dubbo、RocketMQ、Sentinel、Arthas、Seata，覆盖模型共享、Java 运行环境、微服务、消息队列、流量治理和分布式事务。其中部分开源项目已由独立社区或基金会治理。

\- 阿里云应用开发与 DevOps：云效（Alibaba Cloud DevOps）、函数计算、API 网关、微服务引擎 MSE、应用实时监控 ARMS、运维事件中心、Terraform Provider for Alibaba Cloud，覆盖代码托管、持续集成、自动部署、系统监控和应用运维。

\- 阿里巴巴公益与社会服务：阿里巴巴公益、公益宝贝、蚂蚁森林（蚂蚁集团旗下产品）、乡村振兴相关数字服务，涉及互联网公益、公益捐赠和数字化社会服务。其中蚂蚁森林由蚂蚁集团运营，不属于阿里巴巴上市集团直接经营的产品。

#### 招聘情况
- 公众号: 阿里巴巴集团招聘
- [校园招聘](https://campus-talent.alibaba.com/)
- [社会招聘](https://talent-holding.alibaba.com/)


![示意图](PixPin_2026-04-24_23-13-40.webp)

- 目前的趋势是全面拥抱AI,很多岗位都是算法和Agent.

需要注意的是,阿里很多岗位都是实习转正的,如果目标确定是阿里的话建议先投递暑期实习.

阿里的招聘要求说的都比腾讯清楚很多,能够让应聘者快速知道自己是不是这块料:
```md
职位要求
1.基础条件
● 计算机、软件工程、人工智能等相关专业优先。
2.专业能力
● AI编程工具重度玩家：Cursor、Claude code等AI编程工具重度或顶级玩家，具备极强的Prompt编写与调优能力，有过完整的项目级开发经验，理解如何让AI写出生产级代码。
● 大模型能力理解与掌握：理解主流LLM的能力与局限，能够清晰拆解任务并通过LLM或确定性逻辑兜底实现；熟悉主流大模型的应用范式(Context Engineering、Prompt Engineering、Agent、工具/函数调用等等)及主流Agent框架(如LangChain等)，具备大模型幻觉、Prompt注入等风险的工程化应对思路。
● 扎实的代码和工程能力：具备扎实的计算机基础知识，深入理解数据结构、算法、网络和操作系统等相关知识，能至少在一种主流编程语言（如 Java / Python / JS 等）上有深度的实践经验，掌握常见工程实践并具备优秀的Coding 能力，能够根据场景灵活选型并快速上手。
3.能力特质
● 学习能力： 具备快速啃透前沿论文（Paper）的能力，并能将理论知识转化为工程代码。
● 开放性与动手能力： 拒绝纸上谈兵，有自己独立完成的小项目（开源项目或个人 Demo），展现极客精神。
● 好奇心与想象力： 面对未知事物有独特的想法，具备敏锐的问题定义能力和坚韧的解决问题能力。
● 审美追求： 技术亦有审美，鼓励你提出能提出打动人心、简洁优雅的好想法。
● 高能动性： 具备强烈的自驱力，能够主动探索边界，而不是等待被分配任务。
加分项
● 有AI应用或Agent实际落地经验：包括不限于RAG系统、多智能体编排、结合MCP、Skill等的Agent项目，有可展示的项目/实习成果者优先。
● 开源贡献或技术影响力：在Github上有高质量AI项目、技术博客或社区影响力。
● 对AI Infra有基本理解：了解vLLM、Ollama等推理框架原理，理解延迟优化、KV cache优化、流式输出等工程全局视角。
● 在 CV（计算机视觉）或 NLP（自然语言处理）方向有扎实的理论基础，有实际业务场景模型训练(SFT、RL)等经验的优先。
```

##### 面经1
```md
### Java线程池的使用及工作原理

### 并发情况下线程安全的问题介绍一下

### HashMap是线程安全的吗

### ConcurrentHashMap原理，是如何实现线程安全的？

### ConcurrentHashMap的段是怎么划分的？ConcurrentHashMap的存储结构是怎样的？

### ConcurrentHashMap和HashMap存储数据的区别是什么？

### NIO和AIO分别是什么原理？

### 零拷贝介绍一下

### HTTPS加密通信的过程？

### MySQL四种隔离级别是什么？分别怎么实现的？

### 你的MySQL设置的隔离级别是什么？可重复读如何实现的？

### 两个字符串的最长连续相等字符串长度
```
### 字节
#### 公司概况
字节跳动（ByteDance）是一家成立于2012年、总部位于北京的全球领先互联网技术巨头，由张一鸣、梁汝波等人创立。公司凭借TikTok和抖音（Douyin）重塑了全球短视频社交格局，同时拥有资讯平台今日头条（Toutiao）、视频剪辑工具剪映（CapCut）以及Lemon8等多元化产品矩阵，并在生成式人工智能领域积极布局。
#### 公司历史

\- 2012—2015｜创立与算法推荐平台：张一鸣（Zhang Yiming）、梁汝波（Liang Rubo）等人于2012年在北京创立字节跳动（ByteDance），最初专注移动互联网信息分发和个性化推荐技术。同年推出今日头条（Toutiao），利用机器学习和用户行为数据构建个性化内容推荐系统，减少对传统门户网站编辑和人工订阅的依赖。2013年推出头条号内容创作平台，逐步吸引媒体、自媒体和专业内容生产者。2014年获得红杉资本等机构投资，并推出内涵段子等移动内容产品。公司逐渐形成以推荐算法、内容平台和信息流广告为核心的互联网商业模式。

\- 2016—2018｜短视频崛起与全球化扩张：2016年推出抖音（Douyin），将个性化推荐算法、短视频创作工具和全屏沉浸式内容消费结合，迅速进入中国短视频市场。同年开始发展西瓜视频、火山小视频等视频内容平台。2017年推出国际短视频应用 TikTok，并以约10亿美元收购 Musical.ly，2018年将 Musical.ly 与 TikTok 合并，形成面向全球市场的统一短视频平台。同期推出懂车帝、番茄小说等垂直内容产品，开始将信息分发技术应用于汽车、文学、娱乐等领域。抖音、今日头条与 TikTok 逐渐构成公司国内外内容业务的核心。

\- 2019—2021｜内容生态、电商与企业服务扩张：2019年字节跳动加快发展抖音电商、直播、游戏、教育和企业服务，推出飞书（Feishu）企业协作平台及海外版本 Lark，并建立朝夕光年（Nuverse）游戏发行品牌。2020年推出抖音支付相关布局，发展抖音小店、直播带货和本地生活业务，同时受印度市场禁令及美国针对 TikTok 的监管措施影响，全球业务面临新的合规挑战。2021年成立火山引擎（Volcano Engine）商业化云服务体系，将推荐算法、数据分析、音视频和云计算能力向企业开放。同年收购 VR 企业 PICO 及游戏企业沐瞳科技，扩展虚拟现实、游戏研发和国际娱乐业务。2021年张一鸣卸任 CEO，由联合创始人梁汝波接任。

\- 2022—2023｜业务板块化与 AI 技术转型：字节跳动逐步形成抖音、TikTok、飞书、火山引擎、朝夕光年、PICO 等主要业务体系，继续扩大抖音电商、生活服务、TikTok Shop、剪映和 CapCut 等平台。2022年强化云计算、数据基础设施与 AI 模型研发，推动推荐算法和机器学习能力向通用大模型技术扩展。2023年成立或整合 Seed 大模型研发团队，推出豆包（Doubao）AI 助手，并发展扣子（Coze）智能体开发平台。同期收缩教育、游戏和部分 VR 投入，调整朝夕光年组织架构，逐渐将资源集中于短视频、电商、云服务及生成式人工智能。

\- 2024—2025｜豆包大模型与生成式 AI 产品化：2024年正式发布豆包大模型家族，通过火山方舟向企业提供大模型 API、模型推理和应用开发服务，并推出即梦 AI（Jimeng AI）、扣子（Coze）等生成式 AI 产品。剪映、CapCut、飞书和抖音开始更深度集成 AI 视频编辑、图像生成、文档处理和智能推荐技术。2024年 TikTok 通过投资取得印尼电商平台 Tokopedia 的控制权，扩大东南亚电商布局。2025年进一步推出豆包 1.5、Seedream、Seedance 等语言、图像和视频生成模型，发展 TRAE AI 编程工具、豆包手机助手及企业智能体服务。美国针对 TikTok 的法律监管持续推进，公司开始调整美国市场的运营与股权结构。

\- 2026｜AI 原生应用、模型升级与组织整合：2026年1月完成 TikTok 美国数据安全合资企业的股权重组，字节跳动保留19.9%股权，其余80.1%由美国及国际投资者持有，相关美国业务转入新的独立治理架构。2月推出 Seedance 2.0 多模态视频生成模型，随后发展 Seedance 2.5、Seedream 5.0 Pro、Seed2.1 等模型，强化视频生成、图像编辑、复杂推理和智能体能力。7月进行重要组织调整，将飞书产品团队与豆包产品团队整合，并将飞书企业市场与销售体系并入火山引擎相关组织，强化 AI 产品、企业协作和云服务之间的协同。同期推进出售沐瞳科技、收缩非核心游戏资产，持续发展豆包、即梦、TRAE、火山方舟和 AI 硬件，逐渐形成以短视频与电商提供商业基础、以 AI 模型和云计算拓展新业务的技术平台体系。

#### 控股公司及子公司

集团主体：字节跳动有限公司（ByteDance Ltd.）

- 总部及主要管理中心位于中国北京市，集团顶层控股主体注册于开曼群岛，成立于2012年，是中国主要的互联网、数字内容、人工智能和企业云服务企业之一。
- 字节跳动目前仍为非上市公司，未在香港、美国或中国大陆证券交易所公开上市，因此没有公开交易的股票代码，也没有上市企业那样完整的定期财务披露制度。
- 联合创始人梁汝波（Liang Rubo）自2021年起担任集团 CEO，目前同时担任董事长。创始人张一鸣（Zhang Yiming）已退出日常经营管理，但仍是集团重要股东及 AI 战略相关人物。
- 集团主要股东包括创始团队、员工及机构投资者。重要机构投资者包括红杉资本相关基金、General Atlantic、Susquehanna International Group、KKR、Tiger Global 等。具体股权比例没有持续公开的完整官方披露。
- 截至2026年，主要业务包括抖音及国内内容平台、TikTok 国际业务、豆包与 Seed 人工智能、火山引擎云服务、飞书企业协作、剪映与 CapCut 数字创作、PICO 虚拟现实以及游戏等。
- 集团通过境外控股公司、境内经营实体、协议控制安排（VIE）、直接控股子公司及少数股权投资开展业务。由于属于非上市公司，部分境内外实体的完整股权及财务关系公开程度有限。

主要控股公司及核心业务：

- 抖音集团（Douyin Group）：字节跳动旗下国内核心业务体系，主要经营抖音、今日头条、西瓜视频、番茄小说、红果短剧、抖音电商及相关内容与商业服务。集团通过境内外控股实体和协议控制安排运营相关业务。
- TikTok：2017年推出的国际短视频平台，主要面向中国大陆以外的市场，经营 TikTok、TikTok LIVE、TikTok Shop、TikTok for Business 等业务。2026年美国业务进行特殊股权重组，其他地区业务仍属于字节跳动国际业务体系。
- TikTok Shop：TikTok 旗下国际电商业务，依托短视频、直播、创作者营销及商品推荐提供购物服务，主要经营东南亚、英国、美国等市场。
- Tokopedia：印度尼西亚大型电子商务企业。2024年 TikTok 以约8.4亿美元取得其75.01%股权，并将 TikTok Shop 印尼业务整合进入 Tokopedia，形成当地重要的电商平台体系。
- PICO：2021年字节跳动完成收购的中国虚拟现实企业，主营 VR 一体机、虚拟现实操作系统和沉浸式内容，主要产品包括 PICO 4、PICO 4 Ultra 等，属于集团 XR 硬件业务。
- 火山引擎（Volcano Engine）：字节跳动旗下企业云计算与人工智能服务业务，向企业提供公有云、大模型 API、云原生计算、数据库、音视频、大数据和智能体开发平台。其境内主要运营实体包括北京火山引擎科技有限公司等。
- BytePlus：字节跳动面向国际市场的企业技术服务平台，主要提供 AI 模型、推荐系统、数据分析、实时音视频和云计算技术服务，承担部分火山引擎国际业务。
- 飞书（Feishu）：字节跳动旗下企业协作与办公平台，主要经营即时通信、在线文档、多维表格、视频会议、知识库、工作流及 AI 协作服务。2026年飞书产品团队与豆包产品团队整合，企业销售与市场体系并入火山引擎相关组织，但飞书品牌和产品继续运营。
- Lark：飞书面向国际市场的企业办公与协作平台，提供 Lark Messenger、Lark Docs、Lark Base、Lark Meetings 等产品，由集团国际企业服务相关实体运营。
- 剪映（Jianying）：字节跳动旗下视频剪辑与内容创作平台，提供移动端、桌面端和云端视频剪辑、智能字幕、数字人及 AI 生成内容工具。
- CapCut：剪映的国际化视频创作产品体系，提供在线视频编辑、专业视频剪辑、商业模板和 AI 内容生成服务，是字节跳动面向全球创作者的重要软件品牌。
- 即梦 AI（Jimeng AI / Dreamina）：字节跳动旗下 AI 视觉创作平台，提供图像生成、视频生成、数字人、智能编辑及多模态创作服务，主要基于 Seedream、Seedance 等模型技术。
- 豆包（Doubao）：字节跳动旗下通用 AI 助手及相关产品体系，提供智能问答、内容生成、知识检索、多模态理解、语音交互和 AI 智能体服务。
- Seed：字节跳动核心 AI 基础模型研发组织，负责语言模型、多模态模型、图像生成、视频生成、语音、强化学习及相关前沿研究。Seed 属于集团内部研发组织，不应直接认定为独立法律子公司。
- 扣子（Coze）：字节跳动旗下 AI 智能体与自动化开发平台，提供智能体开发、工作流编排、知识库、插件及模型调用服务，具有国内与国际化产品体系。
- TRAE：字节跳动旗下 AI 原生编程工具，提供 AI 辅助编程、项目理解、代码生成、Agent 自动开发及相关软件工程功能。
- 朝夕光年（Nuverse）：字节跳动旗下游戏研发与发行品牌，2019年前后开始发展，曾扩大对中重度手游及海外游戏企业的投资。2023年后经历大规模业务调整，2026年继续保留部分游戏研发及发行项目。
- 小荷健康：字节跳动旗下医疗健康业务品牌，提供医学科普、医生服务和相关医疗服务，旗下包括小荷医典、小荷医生及美中宜和相关医疗业务。
- 美中宜和医疗：由小荷健康体系控股的医疗服务企业，经营妇产、儿科及其他医疗业务，属于集团通过医疗健康业务间接控制的实体。
- 北京美中爱瑞肿瘤医院：小荷健康体系旗下医疗机构，主要从事肿瘤相关诊疗及医疗服务。

集团重要法律实体：

- ByteDance Ltd.：注册于开曼群岛，字节跳动集团顶层控股公司。
- BytePlus Ltd.：注册于开曼群岛，属于集团国际企业技术服务和云服务相关控股实体。
- Nuverse Co., Ltd.：注册于开曼群岛，属于集团游戏业务相关控股实体。
- Nuverse Pte. Ltd.：注册于新加坡，是 Nuverse 国际游戏业务相关法律实体。
- Douyin Group (HK) Limited（抖音集团〔香港〕有限公司）：注册于中国香港，属于集团国内业务的重要境外控股实体。
- Douyin Vision Co., Ltd.：注册于中国大陆，属于抖音相关业务控股和运营体系中的重要法律实体。
- Douyin Co., Ltd.（抖音有限公司）：注册于中国大陆，通过协议控制安排纳入字节跳动集团业务体系，承担部分互联网业务相关经营职能。
- Beijing Douyin Information Services Co., Ltd.（北京抖音信息服务有限公司）：注册于中国大陆，属于抖音相关互联网经营实体。
- Lark Technologies Ltd.：注册于开曼群岛，属于飞书及 Lark 企业服务相关控股实体。
- Pico Immersive Limited：注册于开曼群岛，属于 PICO 虚拟现实业务相关控股实体。
- TikTok Ltd.：注册于开曼群岛，属于集团 TikTok 国际业务相关控股实体。
- TikTok Information Technologies UK Limited：注册于英国，属于 TikTok 国际运营体系中的重要法律实体。
- TikTok LLC：注册于美国，属于集团美国 TikTok 相关法律实体，具体业务及控制范围需要结合2026年美国业务重组后的安排判断。
- TikTok Inc.：注册于美国，属于 TikTok 在美国的重要法律实体。
- BD TikTok USA LLC：注册于美国，属于 TikTok 美国业务相关公司架构。
- TT Commerce & Global Services LLC：注册于美国，属于 TikTok 商业与全球服务业务相关法律实体。
- 北京字节跳动科技有限公司：字节跳动中国大陆重要技术及经营实体，涉及软件研发、信息技术和相关互联网业务。
- 北京火山引擎科技有限公司：火山引擎云计算及企业技术服务相关重要运营实体。
- 北京朝夕光年信息技术有限公司：字节跳动游戏研发与发行相关重要境内法律实体。

以上境外实体主要依据字节跳动官方披露的集团公司架构整理。部分中国大陆业务采用协议控制结构，2026年 TikTok 美国业务重组也使部分实体的实际控制及经营范围发生变化，因此不能仅依据历史持股关系认定全部实体仍处于相同控制范围。

主要收购企业与历史业务：

- Musical.ly：2017年以约10亿美元完成收购，原短视频与音乐对口型社交平台。2018年与 TikTok 合并，原品牌停止独立运营，成为 TikTok 国际用户和产品生态的重要组成部分。
- Flipagram：2017年完成收购，美国短视频与图片音乐制作应用，后来更名并整合进入 Vigo Video 等产品体系，相关业务最终停止独立运营。
- PICO（北京小鸟看看科技有限公司）：2021年完成收购，主营虚拟现实硬件、VR 软件和相关内容生态，目前仍属于集团 XR 业务的重要组成部分。
- 沐瞳科技（Moonton）：2021年字节跳动以超过40亿美元的价格完成收购，上海游戏开发企业，代表作品包括《Mobile Legends: Bang Bang》（决胜巅峰）等。2026年3月与沙特 Savvy Games Group 达成超过60亿美元的出售协议，拟将沐瞳及相关游戏知识产权转让给 Savvy，不能在不核实最终交割状态的情况下继续认定其为稳定的长期控股资产。
- 有爱互娱：字节跳动曾于2020—2021年取得控制权，主要从事游戏研发与发行，代表作品包括《红警OL》等。2024年向中国儒意旗下企业出售相关股权，不再属于集团现有核心控股业务。
- Musical.ly 及 Vigo 系列：属于集团历史上的国际短视频和社交产品，后续通过品牌整合与业务调整退出独立产品体系。
- Tokopedia：2024年 TikTok 完成控股投资，将其与 TikTok Shop 印度尼西亚业务整合，保留当地电商平台品牌，并与原股东 GoTo 保持合作。
- Oladance：2024年字节跳动收购的开放式音频设备相关企业，主营开放式耳机及声学硬件技术，相关能力与集团 AI 音频和智能可穿戴设备布局有关。

其他重要投资及股权关系：

- TikTok USDS Joint Venture LLC：2026年1月成立并完成相关交易的美国 TikTok 数据安全合资企业，由美国及国际投资者持有80.1%股权，字节跳动保留19.9%。主要负责美国用户数据保护、算法安全、内容审核及相关安全治理，属于独立治理的合资实体，不能直接视为字节跳动多数控股子公司。
- Oracle：美国数据库与云计算企业，持有 TikTok 美国合资企业15%股权，负责相关云基础设施和安全技术合作。Oracle 不是字节跳动子公司。
- Silver Lake：美国私募股权投资机构，持有 TikTok 美国合资企业15%股权，属于重要投资者。
- MGX：阿联酋投资机构，持有 TikTok 美国合资企业15%股权，属于重要投资者。
- GoTo Group：印度尼西亚科技集团，原 Tokopedia 的控股股东。2024年 TikTok 取得 Tokopedia 控制权后，GoTo 保留部分股权与商业合作关系，GoTo 集团本身仍独立经营。
- 懂车帝：2017年由今日头条汽车频道孵化，主营汽车资讯、车型数据、汽车评测和汽车交易服务。2024年开始独立公司化和融资调整，部分经营实体股权转入新的独立架构。其最终股权与控制关系公开信息不完整，不能简单按字节跳动100%直接持股处理。
- 红杉资本相关基金：字节跳动重要早期机构投资者之一，属于股权投资关系。
- General Atlantic：美国成长型股权投资机构，字节跳动长期机构股东之一。
- Susquehanna International Group：美国金融投资机构，字节跳动重要早期投资者相关集团。
- KKR：美国全球投资机构，曾参与字节跳动融资，属于机构股东。
- Tiger Global：全球科技投资机构，属于字节跳动重要历史投资者之一。

#### 主要产品

\- 抖音短视频与社交：抖音、抖音极速版、抖音火山版、抖音直播、抖音搜索、抖音精选，提供短视频分享、内容推荐、直播互动、信息检索和社交娱乐服务。

\- 抖音内容创作者平台：抖音创作者中心、抖音创作服务平台、巨量星图、抖音直播伴侣、抖音热点宝，提供视频发布、创作者数据分析、内容管理、商业合作及直播制作服务。

\- 抖音电商与在线零售：抖音商城、抖音小店、抖店、抖音电商罗盘、抖音精选联盟、抖音直播带货，覆盖商品展示、品牌销售、商家管理、达人带货和电商数据分析。

\- 抖音生活服务：抖音团购、抖音到店、抖音酒店、抖音酒旅、抖音外卖相关服务、抖音生活服务商家平台，提供餐饮、酒店、休闲娱乐和本地消费服务。

\- 抖音支付与金融科技：抖音支付、抖音月付、抖音钱包及相关支付服务，覆盖电商支付、消费分期和平台交易结算，部分金融产品由合作持牌机构提供。

\- 今日头条新闻与资讯：今日头条、今日头条极速版、头条号、微头条、头条文章、头条问答，提供新闻聚合、个性化信息推荐、自媒体创作与内容分发。

\- 西瓜视频与中长视频：西瓜视频、西瓜创作平台及相关视频内容服务，覆盖中长视频、影视解说、知识创作和视频内容推荐。

\- 番茄小说数字阅读：番茄小说、番茄免费小说、番茄作家助手，提供免费网络文学阅读、小说推荐、作者创作和数字文学分发。

\- 番茄畅听数字音频：番茄畅听、番茄畅听音乐版等相关产品，提供有声小说、听书、音频故事及数字音频内容服务。

\- 红果短剧：红果短剧、红果免费短剧、红果短剧创作者相关服务，提供免费短剧、微短剧推荐、短剧制作与内容发行。

\- 懂车帝汽车服务：懂车帝、懂车帝 App、懂车帝汽车评测、懂车帝车型库、懂车帝二手车等，提供汽车资讯、汽车测试、价格查询和汽车交易信息。该业务已进行独立公司化调整。

\- TikTok 国际短视频：TikTok、TikTok LIVE、TikTok Stories、TikTok Search、TikTok Now（历史产品）、TikTok Series，覆盖全球短视频、直播、内容创作和社交互动。

\- TikTok 国际电商：TikTok Shop、TikTok Shop Seller Center、TikTok Shop Affiliate、TikTok Shop Academy、TikTok Shop Ads，提供跨境及本地电商、商家运营、创作者带货和广告推广服务。

\- TikTok for Business 广告平台：TikTok Ads Manager、TikTok Business Center、TikTok Pixel、TikTok Events API、TikTok Creative Center、TikTok One，提供广告投放、商业账户管理、营销数据分析及创作者商业合作。

\- TikTok 创作者与音乐服务：TikTok Studio、TikTok Creator Marketplace 相关功能、TikTok LIVE Studio、SoundOn，提供视频创作、直播制作、音乐发行和创作者变现服务。

\- Lemon8 生活方式社区：Lemon8，面向海外市场提供图片、短视频、生活方式分享、时尚、美妆、旅行及兴趣社区服务。

\- 剪映视频剪辑：剪映、剪映专业版、剪映云剪辑、剪映图文成片、智能字幕、AI 配音、数字人及智能剪辑功能，面向短视频创作者、专业视频剪辑及商业内容生产。

\- CapCut 国际创作软件：CapCut、CapCut Desktop、CapCut Web、CapCut Pro、CapCut Commerce Pro，提供移动端与桌面端剪辑、模板创作、自动字幕、AI 视频生成和商业营销内容制作。

\- 醒图图像编辑：醒图、醒图 AI 修图、智能美颜、照片处理、图像滤镜及相关创意工具，主要面向个人照片编辑、人像美化与社交内容制作。

\- 轻颜相机与影像应用：轻颜相机、Ulike、B612 等影像创作及美颜工具相关业务，提供人像拍摄、滤镜、美颜、智能修图和摄影辅助功能。其中部分产品的历史开发与经营主体存在差异。

\- 即梦 AI 生成式创作：即梦 AI（Jimeng AI）、Dreamina、即梦图片生成、视频生成、数字人、智能编辑和 AI 音效功能，提供基于文本、图片、音频和视频的多模态创作。

\- 豆包 AI 助手：豆包、豆包 App、豆包电脑版、豆包网页版、豆包语音通话、豆包实时视频通话、豆包 AI 搜索、豆包文档问答，提供多模态对话、联网搜索、学习、写作、代码和信息处理能力。

\- 豆包海外 AI 助手：Dola（原 Cici），面向国际市场提供 AI 对话、内容生成、学习辅助、语言交流和智能生产力服务。

\- 豆包教育与学习产品：豆包爱学及相关学习辅助功能，提供题目讲解、知识问答、语言学习、作文辅助和智能学习服务。

\- 猫箱 AI 角色互动：猫箱、AI 角色聊天、互动剧情及相关虚拟角色功能，提供基于生成式 AI 的角色对话、故事互动和沉浸式娱乐体验。

\- 海绵音乐 AI 创作：海绵音乐、AI 歌曲生成、AI 编曲、AI 人声及相关音乐生成工具，支持歌词创作、音乐生成和数字音频内容制作。

\- 即创 AI 商业内容：即创、即创 AI 文案、AI 图片、AI 视频、智能数字人、营销视频生成，主要面向抖音商家、广告营销和电商内容创作者。

\- 豆包 Seed 大语言模型：Doubao、Doubao Seed 1.5、Seed 2.0、Seed 2.1、Doubao Seed Evolving 等模型系列，覆盖自然语言理解、复杂推理、代码生成、工具调用和 AI 智能体任务。

\- Seedance AI 视频生成模型：Seedance 1.0、Seedance 1.5、Seedance 2.0、Seedance 2.5，支持文生视频、图生视频、多模态素材参考、镜头控制、音视频同步和视频编辑。

\- Seedream AI 图像生成模型：Seedream 3.0、Seedream 4.0、Seedream 5.0 Pro，提供文本生成图像、参考图生成、多图融合、精准图像编辑和商业视觉内容创作。

\- Seed 多模态与语音模型：Seed Audio、Seed TTS、Seed ASR、SeedRealtime、Seed Audio-Visual、Seed GR-RL 等研发与产品模型，涉及语音识别、语音合成、实时多模态交互和机器人相关研究。

\- 扣子智能体开发平台：扣子（Coze）、Coze Studio、Coze Workflow、Coze Plugin、Coze Knowledge、扣子编程，提供低代码和可视化智能体开发、工作流编排、知识库及工具调用能力。

\- TRAE AI 编程工具：TRAE、TRAE CN、TRAE IDE、TRAE Agent 等功能，提供代码补全、代码库分析、项目生成、调试辅助和 AI 自动编程。

\- 豆包 AI 智能硬件：豆包手机助手、Ola Friend AI 耳机，以及相关 AI 手机协作与可穿戴设备技术，覆盖语音助手、移动终端操作、智能交互和多设备 AI 服务。其中部分属于与硬件厂商合作开发的技术方案。

\- 火山引擎云计算基础设施：火山引擎云服务器 ECS、GPU 云服务器、弹性伸缩、裸金属服务器、高性能计算及相关云资源，提供企业计算、应用部署和 AI 算力服务。

\- 火山引擎容器与云原生：容器服务 VKE、镜像仓库、函数服务、微服务引擎、云原生应用平台，支持 Kubernetes、容器编排、应用部署和微服务管理。

\- 火山引擎存储服务：对象存储 TOS、云盘 EBS、文件存储 vePFS、日志服务 TLS及相关存储产品，提供对象存储、块存储、高性能文件系统和日志管理。

\- 火山引擎数据库：veDB、ByteHouse、云数据库 MySQL、PostgreSQL、Redis、MongoDB及相关数据库服务，覆盖关系型数据库、缓存、分析型数据库和云原生数据管理。

\- 火山引擎大数据平台：ByteHouse、DataLeap、DataSail、流式计算 Flink、EMR及相关数据管理产品，提供数据开发、实时处理、离线计算、数据集成和商业分析。

\- 火山引擎网络与边缘计算：私有网络 VPC、负载均衡、CDN、边缘计算、全站加速、DNS及相关网络服务，支持流量分发、全球网络加速和企业云连接。

\- 火山引擎音视频服务：视频点播 VOD、视频直播、实时音视频 RTC、媒体处理、视频云及相关音视频 SDK，提供直播、短视频处理、视频会议、低延迟互动及数字内容分发。

\- 火山方舟大模型平台：火山方舟（Volcengine Ark）、模型广场、模型 API、模型推理、模型评测、模型精调、方舟 Coding Plan、Agent Plan，提供企业大模型调用、模型开发与 AI 应用部署服务。

\- 火山引擎智能体平台：AgentKit、Managed Agents、HiAgent、ArkClaw、智能体工作流及相关智能体开发工具，提供智能体构建、任务编排、运行环境、模型调用和企业级自动化服务。

\- 火山引擎 AI 视频与图像服务：Seedance API、Seedream API、即梦 AI 企业服务、AI MediaKit、剧创 Agent，支持视频生成、图像生成、商业内容制作、短剧生产和企业创意自动化。

\- 火山引擎安全服务：Web 应用防火墙 WAF、DDoS 防护、云安全中心、密钥管理、数据安全、身份访问控制及风险识别服务，覆盖云计算安全、业务风控和数据保护。

\- 火山引擎增长与营销技术：增长分析、A/B 测试、客户数据平台 CDP、智能推荐、营销自动化、用户增长分析，主要基于字节跳动内部积累的推荐算法、用户行为分析和实验平台技术。

\- BytePlus 国际云服务：BytePlus ModelArk、BytePlus Recommend、BytePlus Data Intelligence、BytePlus RTC、BytePlus MediaLive及相关 AI、数据和音视频服务，主要面向海外企业市场。

\- 飞书企业即时通信：飞书、飞书消息、飞书群组、飞书通讯录、飞书邮箱、飞书日历，提供组织通信、企业邮箱、团队协作和信息管理服务。

\- 飞书在线文档：飞书文档、飞书表格、飞书幻灯片、飞书知识库、飞书思维笔记，提供在线文档编辑、电子表格、演示文稿、团队知识管理和协同写作。

\- 飞书多维表格：飞书多维表格（Bitable）、自动化工作流、仪表盘、数据视图、AI 字段和表格应用，支持轻量级数据库、业务管理、项目追踪及自动化办公。

\- 飞书会议与企业协作：飞书会议、飞书妙记、飞书会议室、飞书项目、飞书 OKR、飞书审批、飞书考勤，覆盖视频会议、会议转写、项目管理、目标管理和组织流程。

\- 飞书 AI 与低代码开发：飞书 AI、豆包工作、飞书 Aily、飞书妙搭、飞书开放平台、飞书多维表格 AI，提供企业 AI 助手、知识检索、智能体构建和低代码应用开发。

\- Lark 国际企业协作：Lark Messenger、Lark Docs、Lark Base、Lark Meetings、Lark Calendar、Lark Approval，主要面向海外企业提供团队协作、办公自动化和业务管理。

\- PICO 虚拟现实设备：PICO Neo 系列、PICO 4、PICO 4 Pro、PICO 4 Ultra、PICO Enterprise 系列，覆盖消费级 VR、混合现实、企业培训和沉浸式应用。

\- PICO XR 软件与内容：PICO OS、PICO Store、PICO Connect、PICO Business、PICO 开发者平台，提供 XR 操作系统、VR 应用分发、PC VR 连接及企业级虚拟现实解决方案。

\- 朝夕光年游戏业务：朝夕光年（Nuverse）、Nuverse Games、《航海王：热血航线》及其他游戏研发和发行项目，涵盖角色扮演、动作、休闲及多人在线游戏。部分历史发行作品的运营权已经调整或转移。

\- 字节游戏研发项目：《托托比亚》《不问凡尘》等2026年公开的研发项目，分别涉及多人派对和角色扮演游戏，其中项目公布、获得版号与正式商业上线需要区分。

\- 沐瞳科技历史游戏产品：《Mobile Legends: Bang Bang》（决胜巅峰）、《Mobile Legends: Adventure》《Magic Chess: Go Go》等，属于字节跳动2021年收购沐瞳后曾经控股的产品体系。2026年已宣布相关出售交易，后续归属应以最终交割为准。

\- 小荷健康医疗服务：小荷健康、小荷医典、小荷医生、小荷健康医生工作室，提供医学科普、医生服务、医疗信息及健康管理服务。

\- 美中宜和医疗服务：美中宜和妇产儿童医疗及相关医疗机构、北京美中爱瑞肿瘤医院，属于字节跳动医疗健康业务体系中的线下医疗服务。

\- 巨量引擎商业广告：巨量引擎、巨量广告、巨量千川、巨量星图、巨量云图、巨量算数，提供广告投放、创作者商业合作、精准营销、用户洞察和商家经营分析。

\- 巨量千川电商广告：巨量千川、千川智能投放、直播广告、商品广告及相关营销服务，主要面向抖音电商商家提供广告投放、流量增长和销售效果分析。

\- 巨量星图达人营销：巨量星图、达人任务、品牌合作、创作者营销和商业内容管理，连接广告主、MCN 机构与内容创作者。

\- 抖音企业号与商业服务：抖音企业号、抖音来客、抖店、企业号经营平台，帮助品牌商家进行账号管理、商品运营、本地生活营销和客户触达。

\- 字节跳动推荐与搜索技术：个性化推荐系统、内容理解、多模态检索、智能搜索、广告排序、推荐模型及相关机器学习平台，是抖音、今日头条、TikTok 和电商产品的核心技术基础。

\- 字节跳动开源软件与开发者生态：CloudWeGo、Kitex、Hertz、Monolith、Volcengine SDK、TRAE 开发工具及相关开源项目，覆盖 Go 微服务框架、RPC 通信、HTTP 服务、云开发和 AI 软件工程。

\- 字节跳动企业研发与工程平台：内部基础设施、分布式计算、推荐系统、数据处理平台及 AI 训练推理系统，主要支撑集团内部产品与企业云业务，部分技术通过火山引擎或开源项目对外提供。
#### 招聘情况
- [招聘官网](https://jobs.bytedance.com/)
- 公众号: 字节跳动招聘,实质上还是跳转到招聘官网

由于字节的业务增长迅速,人才缺口是头部企业中最旺盛的,光是上海的实习岗就有1800个:
![示意图](PixPin_2026-04-25_16-02-21.webp)

### 美团
#### 公司概况
美团（Meituan）是一家成立于2010年、总部位于北京的领先生活服务电子商务平台，由王兴创立。公司通过美团、大众点评及境外品牌 KeeTa，构建了涵盖外卖配送、到店餐饮、酒店旅游及即时零售的全方位业务矩阵。截至2024年底，美团年度交易用户已突破7.7亿，年活跃商家达1450万，是全球最大的本地生活服务平台之一，并于2018年在香港联交所成功上市。

- 专注于生活领域
#### 公司历史

\- 2010—2012｜创立与团购市场竞争：王兴（Wang Xing）于2010年3月在北京创立美团网（Meituan），最初模仿美国 Groupon 的团购模式，为消费者提供餐饮、娱乐和本地商家的折扣商品与服务。公司通过互联网聚合本地商家、吸引消费者在线购买团购券，并建立商家推广和交易佣金的商业模式。2011年获得阿里巴巴等机构投资，在中国互联网“千团大战”中逐渐扩大市场份额。2012年开始进入酒店预订、电影票务等业务，逐渐从单一团购网站向综合本地生活服务平台转型。

\- 2013—2015｜外卖业务崛起与大众点评合并：2013年正式推出美团外卖，通过移动互联网连接餐饮商家、消费者和配送人员，逐渐建立即时配送网络。同年推出猫眼电影等在线票务业务，并进一步发展酒店旅游服务。2014年美团外卖快速扩张，成为公司新的核心增长业务。2015年收购酒店旅游搜索企业酷讯，进一步扩展旅游业务；同年10月美团与大众点评宣布合并，成立美团点评（Meituan Dianping），整合团购、商家点评、餐饮预订和本地生活服务，形成覆盖消费者交易、商户信息和商家营销的平台体系。

\- 2016—2018｜综合生活服务与香港上市：2016年完成新一轮融资，并收购第三方支付企业钱袋宝，获得支付业务相关牌照与技术能力，开始发展美团支付及金融科技服务。2017年推出美团打车，在南京等城市探索网约车业务，同时扩大酒店、旅游、到店服务和即时配送。2018年以约27亿美元的股权和现金对价收购摩拜单车（Mobike），进入共享单车领域，并推出面向本地零售商家的美团闪购。2018年9月美团点评在香港联合交易所上市（3690.HK），逐步建立以餐饮外卖、到店酒旅和新业务为核心的经营结构。

\- 2019—2021｜即时零售与“零售+科技”战略：2019年推出美团买菜，采用前置仓模式提供生鲜食品即时配送，进一步发展快驴进货、美团跑腿、美团单车等业务。2020年将上市公司名称由美团点评更改为美团（Meituan），推出美团优选社区团购和团好货电商业务，扩大零售业务边界。2021年提出“零售+科技”战略，推动餐饮外卖、即时零售、食杂零售、供应链和物流基础设施协同发展。同期加强无人配送车、无人机、智能调度算法和自动化物流研发，并因平台“二选一”等问题受到反垄断监管处罚。

\- 2022—2024｜核心本地商业与海外扩张：2022年调整财务报告业务分部，形成核心本地商业（Core Local Commerce）和新业务（New Initiatives）两大板块，将餐饮外卖、到店、酒店旅游和即时零售整合进核心本地商业体系。2023年将美团买菜升级为小象超市，扩大生鲜、日用百货及即时零售品类；同年在中国香港推出 Keeta 外卖平台，正式开启国际化外卖业务。2024年整合到店、到家等业务管理体系，并将 Keeta 拓展至沙特阿拉伯，继续投资配送机器人、无人机和人工智能技术，逐渐形成国内本地生活与海外即时配送并行发展的经营格局。

\- 2025｜即时零售竞争与业务结构调整：2025年正式将美团闪购升级为独立即时零售品牌，提出“30分钟万物到家”，扩大数码家电、日用百货、医药健康等非餐饮品类，并推出覆盖多种生活场景的美团会员体系。面对阿里巴巴淘宝闪购、京东外卖等平台的竞争，美团加大补贴和配送投入，国内即时零售竞争显著加剧。同年调整食杂零售业务，将美团优选在多数地区逐步关停，并于12月停止剩余区域接单，同时暂停团好货（美团电商）快递电商业务，将资源集中于小象超市、闪购和快乐猴社区超市。国际业务方面，Keeta 继续进入中东和巴西市场；人工智能方面，推出 LongCat 大模型及面向本地生活的 AI 助手“小团”。

\- 2026｜AI 智能体、全球配送与零售重构：2026年2月美团宣布拟以约7.17亿美元收购叮咚买菜中国业务100%股权，以增强生鲜供应链与即时零售能力，截至10月交易仍待满足监管审批等交割条件。6月推出 LongCat-2.0 万亿参数开源模型，并发布 AI 原生浏览器 Tabbit；7月推出 CatPaw AI Agent 平台，将人工智能应用于办公自动化、商家经营和企业服务。同期升级“小团”AI 助手，发展智能掌柜、袋鼠管家等工具，继续投资无人机、无人车及智慧物流。2026年第二季度集团营收达到1046亿元人民币，同比增长14.4%，其中核心本地商业收入715亿元，新业务收入331亿元。小象超市扩展至68个城市，快乐猴线下门店达到40家，集团继续推动零售、配送、AI 和国际化业务整合。

#### 控股公司及子公司

集团主体：美团（Meituan）

- 总部位于中国北京市，注册地为开曼群岛，2010年由王兴创立，2018年以美团点评名义在香港联合交易所上市，股票代码为3690.HK，2020年正式更名为美团。
- 美团是集团顶层上市公司，没有另一家企业作为其控股母公司。创始人王兴（Wang Xing）担任董事会主席兼 CEO，联合创始人穆荣均担任执行董事兼高级副总裁。
- 集团采用同股不同权（Weighted Voting Rights，WVR）架构，A 类股份每股拥有10票表决权，B 类股份每股拥有1票。根据2025年年报披露的信息，王兴通过个人及相关信托持有约9.3%股份，控制约45.3%的表决权，穆荣均通过相关持股安排掌握约5.6%的表决权。
- 按2026年第二季度财报，集团主要分为核心本地商业（Core Local Commerce）和新业务（New Initiatives）两个报告分部。核心本地商业涵盖餐饮外卖、到店餐饮、酒店旅游、美团闪购、医药健康及相关即时配送业务；新业务主要包括小象超市、快乐猴、快驴进货、Keeta 国际业务及其他创新业务。
- 集团通过直接控股、间接控股、协议控制实体（VIE）及战略投资等方式开展业务，部分中国大陆互联网经营实体由创始人等境内股东依法持股，并通过合同安排纳入集团合并财务报表。

主要控股公司及核心业务：

- 大众点评（Dianping）：2003年由张涛创立，最初提供餐厅评价、商家信息和消费指南。2015年与美团合并，形成美团点评集团，现保留大众点评 App 及品牌，主要经营餐饮评价、到店消费、商家推荐、生活服务和消费决策业务。
- 美团外卖：2013年推出，主营在线餐饮订购、骑手配送、外卖商家服务和餐饮即时履约，属于集团核心本地商业的重要业务，相关经营活动由美团体系内多个法律实体承担。
- 美团闪购：2018年开始发展，2025年升级为独立即时零售品牌，主营超市便利、数码家电、日用百货、鲜花、医药及其他商品即时配送，是集团非餐饮即时零售业务的重要组成部分。
- 小象超市：2019年以美团买菜品牌推出，2023年升级为小象超市，采用前置仓与线上线下一体化零售模式，主要经营生鲜食品、日用百货及家庭消费品。2026年第二季度已进入68个城市。
- 快乐猴（Happy Monkey）：2025年开始发展，美团旗下线下社区超市品牌，主要经营生鲜食品、日用百货和高性价比生活商品，采用硬折扣零售及供应链直采模式，2026年第二季度已开设40家门店。
- 快驴进货：美团旗下餐饮供应链服务业务，面向餐饮商家提供食材采购、商品批发、仓储配送及供应链管理，属于集团食杂零售和企业服务体系。
- 美团买药：集团医药健康业务，主要提供药品即时零售、在线问诊、健康管理及药品配送服务，与连锁药房、医疗机构和第三方医疗服务商开展合作。
- 美团配送：集团即时物流与履约业务，连接骑手、商家和消费者，提供餐饮外卖、即时零售、跑腿等订单的配送能力，是美团外卖和美团闪购的重要基础设施。
- Keeta：2023年在中国香港推出的国际外卖与即时配送品牌，2024年进入沙特阿拉伯，2025年拓展至卡塔尔、科威特、阿联酋、巴林及巴西等市场。截至2026年10月，Keeta 已在多个海外市场运营，并继续扩大巴西城市覆盖范围。
- 摩拜单车（Mobike）：2018年被美团收购的共享单车企业，主要经营共享自行车、车辆调度和城市短途出行服务，后逐渐整合为美团单车，原摩拜品牌停止独立运营。
- 钱袋宝：2016年美团完成全资收购的第三方支付企业，拥有中国人民银行颁发的支付业务许可证，相关技术和牌照用于美团支付、商户收单及金融科技服务。
- 美团金融科技：集团内部金融服务业务，主要涉及支付、消费信贷、小微企业融资及商家金融服务，旗下包括相关支付和小额贷款经营主体。不同金融服务由集团持牌实体或合作金融机构依法提供。
- 美团无人机：集团自主研发的低空即时配送业务，主要开发无人机、自动化机巢、低空物流调度系统和城市低空配送网络，已在深圳、上海等城市开展商业化运营。
- 美团无人车：集团自动驾驶配送业务，主要研发自动配送车、无人驾驶系统、路径规划和智慧物流调度，面向城市社区、商超及即时配送场景。
- 美团 LongCat：集团人工智能基础模型研发业务，2025年开始对外发布 LongCat 系列模型，2026年推出 LongCat-2.0，重点研究大语言模型、多模态理解、复杂推理、工具调用和 AI 智能体。
- 美团 CatPaw：2026年推出的企业级 AI Agent 平台，提供个人智能工作台、跨设备任务执行、智能体开发和企业数字员工服务，属于美团 AI 技术与企业服务业务。
- 美团 Tabbit：2026年推出的 AI 原生浏览器，提供网页浏览、智能搜索、文档总结、AI 对话和智能体自动化操作，属于集团面向个人和企业用户的 AI 应用。
- 美团餐饮系统：集团面向餐饮商家的软硬件服务体系，主要包括美团收银、美团管家、开店宝、餐饮营销、智能硬件及门店数字化经营工具。
- 美团龙珠（Meituan DragonBall）：2017年成立的产业投资平台，主要投资消费、零售、供应链及相关科技企业，属于美团战略投资体系的一部分。相关投资基金与被投资公司需按照具体基金架构和股权关系分别判断控制权。

集团重要法律实体：

- Meituan（美团）：注册于开曼群岛，是集团顶层上市及控股主体。
- Inspired Elite Investments Limited：注册于英属维尔京群岛，是美团直接持有100%股权的重要投资控股公司。
- 北京三快在线科技有限公司（Beijing Sankuai Online Technology Co., Ltd.）：注册于中国北京，美团间接全资子公司，主要经营电子商务平台相关技术与服务。
- 汉海信息技术（上海）有限公司（Hanhai Information Technology (Shanghai) Co., Ltd.）：注册于中国上海，美团间接全资子公司，主要提供多媒体信息技术服务。
- 厦门三快在线科技有限公司（Xiamen Sankuai Online Technology Co., Ltd.）：注册于中国厦门，美团间接全资子公司，主要经营电子商务平台相关业务。
- 上海三快智送科技有限公司（Shanghai Sankuai Zhisong Technology Co., Ltd.）：注册于中国上海，美团间接全资子公司，主要经营即时配送及相关物流服务。
- 重庆美团三快小额贷款有限公司（Chongqing Meituan Sankuai Micro-credit Co., Ltd.）：注册于中国重庆，美团间接全资子公司，主要经营持牌小额贷款业务。
- 北京三快科技有限公司（Beijing Sankuai Technology Co., Ltd.）：注册于中国北京，是美团重要的协议控制实体，主要承担电子商务平台经营业务。
- 上海三快科技有限公司（Shanghai Sankuai Technology Co., Ltd.）：注册于中国上海，属于集团协议控制实体，主要涉及在线零售平台业务。
- 北京三快云计算有限公司（Beijing Sankuai Cloud Computing Co., Ltd.）：注册于中国北京，属于集团协议控制实体，主要涉及云计算及相关技术业务。
- 上海汉涛信息咨询有限公司（Shanghai Hantao Information Consultancy Co., Ltd.）：注册于中国上海，属于集团协议控制实体，主要经营商家信息咨询及相关互联网服务，是大众点评业务体系的重要法律实体。
- 天津三快科技有限公司（Tianjin Sankuai Technology Co., Ltd.）：注册于中国天津，属于集团协议控制实体，主要承担部分境内投资控股职能。
- 北京新美大科技有限公司：2016年成立，属于美团通过协议控制安排纳入合并报表的境内经营实体。
- 北京摩拜科技有限公司：原摩拜单车相关经营实体，2018年收购后进入美团共享出行业务体系，通过协议控制安排纳入集团合并报表。

以上主要依据美团2025财年年报附注及公司架构披露整理。其中直接及间接全资子公司与协议控制实体在法律股权性质上存在区别，后者虽然纳入美团合并报表，但美团不一定直接持有其股权。

主要收购企业及历史业务：

- 大众点评：2015年与美团合并，原本独立的餐饮评价与生活服务平台进入美团体系，品牌至今保留，是美团到店业务的重要基础。
- 酷讯旅游：2015年美团收购的旅游搜索和旅游服务企业，原主营机票、酒店及旅游信息搜索，相关技术和团队逐渐整合进入美团酒店旅游业务。
- 钱袋宝：2016年完成全资收购，原独立第三方支付公司，收购使美团获得相关支付业务资质，成为其金融科技业务的重要基础。
- 摩拜单车：2018年完成收购，原中国大型共享单车运营商，后与美团出行和城市交通服务整合，逐渐以美团单车品牌经营。
- 叮咚买菜（Dingdong）：2017年创立的生鲜即时零售平台，2021年在纽约证券交易所上市（DDL）。2026年2月美团宣布拟以约7.17亿美元收购其中国业务100%股权，海外业务不在交易范围内。截至2026年10月，交易仍待完成必要审批与交割程序，因此不能提前认定为已完成收购的控股子公司。
- 美团优选：2020年推出的社区团购业务，采用“预售+次日自提”模式，覆盖生鲜食品和日用百货。2025年逐步退出主要市场，并于12月暂停最后两个运营区域接单，目前不应列为正常扩张中的核心产品。
- 团好货 / 美团电商：2020年推出的快递电商业务，后以美团电商品牌运营，2025年12月宣布暂停，相关资源转向即时零售和食杂零售业务。
- 美团打车：2017年推出的网约车业务，经历自营网约车与聚合出行模式调整，现主要以平台化出行服务为主，不再按照早期大规模自营扩张模式经营。

其他重要投资及股权关系：

- 理想汽车（Li Auto）：中国新能源汽车企业，2019年起获得王兴及美团相关投资，是美团重要战略参股企业。截至2026年3月31日，美团持有约12.73%股权，王兴长期参与其董事会治理，但理想汽车属于独立上市企业，不是美团控股子公司。
- 宇树科技（Unitree Robotics）：中国机器人企业，主营四足机器人、人形机器人及机器人运动控制技术。美团通过相关投资体系参与其融资，截至2026年3月31日持有约7.61%股权，属于重要少数股东。
- 智谱（Zhipu AI）：中国人工智能基础模型企业，主要研发 GLM 系列大语言模型及相关 AI 服务。美团参与其融资，截至2026年3月31日持有约3.86%股权，属于战略投资关系。
- 猫眼娱乐（Maoyan Entertainment）：最初由美团内部电影票务业务发展而来，后引入光线传媒、腾讯等股东并独立经营，2019年在香港上市（1896.HK）。美团近年来持续降低持股比例，2026年4月减持后持股约4.96%，不再属于美团控股子公司。
- 腾讯控股（Tencent）：2015年美团与大众点评合并后成为重要战略投资者，长期支持美团平台、支付及流量合作。腾讯于2022年宣布向股东分派大部分所持美团股份，随后大幅降低持股比例，腾讯并非美团控股母公司。
- 阿里巴巴（Alibaba）：美团2011年的重要早期投资者之一，后来随着美团与大众点评合并及市场竞争关系变化逐渐退出主要股东体系，双方不存在控股关系。
- 美团龙珠投资组合：主要涉及消费品牌、餐饮零售、供应链和科技企业。被投资企业通常保持独立经营，不能因为接受美团投资就直接列为集团子公司。

#### 主要产品

\- 美团综合生活服务：美团 App、美团团购、美团会员、美团搜索、美团推荐、美团直播，覆盖餐饮、购物、住宿、娱乐、旅游和日常生活服务。

\- 大众点评消费评价：大众点评、大众点评必吃榜、大众点评必住榜、大众点评必玩榜、餐厅评分、用户点评、商家推荐，提供商家信息、真实评价、消费决策及到店服务。

\- 美团外卖餐饮配送：美团外卖、美团外卖 App、拼好饭、外卖红包、外卖会员、外卖商家版，提供在线点餐、餐饮配送、团体拼单和商家运营服务。

\- 美团外卖优惠与会员：拼好饭、神抢手、美团会员、外卖红包及相关优惠服务，覆盖低价套餐、联合拼单、会员权益和餐饮促销。

\- 美团闪购即时零售：美团闪购、闪电仓、品牌闪电仓、闪购品牌馆、美团闪购品牌通，提供日用百货、数码家电、鲜花、生鲜、母婴和生活商品的即时购物与配送服务。

\- 美团闪购数码与家电：美团闪购手机、数码产品、家用电器、电脑配件、智能设备及其他高价值商品即时零售，并与品牌商家合作开展快速配送和安装服务。

\- 小象超市食杂零售：小象超市、小象超市 App、小象自有品牌、前置仓配送、线下体验门店，提供生鲜水果、蔬菜肉禽、乳制品、零食、家庭日用品和即时配送服务。

\- 快乐猴社区超市：快乐猴、快乐猴线下超市及相关自有品牌和商品体系，采用硬折扣零售模式，主要经营食品、生鲜、家庭用品和日常消费商品。

\- 快驴进货餐饮供应链：快驴进货、快驴商家采购、快驴食材供应链、快驴仓储配送，面向餐饮企业提供食材、调味品、日用品、餐饮耗材及批量采购服务。

\- 美团买药医药零售：美团买药、24小时买药、美团医药健康、美团自营大药房、药品即时配送，提供非处方药、符合监管要求的处方药、医疗器械及家庭健康用品。

\- 美团医疗健康服务：美团问诊、线上医保购药、健康卡、小团健康管家、家庭健康档案、体检及线下医疗预约相关服务，覆盖药品购买、医疗咨询、健康管理和医疗服务连接。

\- 美团到店餐饮：美团团购、到店餐饮、美团餐厅推荐、餐厅订座、餐饮优惠券、餐厅排行榜，提供商家搜索、餐饮优惠、线上预订和餐厅消费服务。

\- 美团酒店与住宿：美团酒店、美团酒店预订、美团民宿、钟点房、酒店套餐、住宿团购，提供酒店搜索、住宿预订、价格比较和本地住宿服务。

\- 美团旅行与旅游度假：美团旅行、美团门票、景区门票、旅游线路、周边游、度假套餐及相关旅游预订服务，覆盖景区、酒店、休闲旅游和本地出游。

\- 美团休闲娱乐与生活服务：美团 KTV、美团洗浴、美团足疗、美团健身、美团密室逃脱、美团剧本杀、美团亲子、美团美容美发，提供本地商家搜索、优惠团购、在线预约和服务消费。

\- 美团医美与专业服务：美团医美、口腔服务、皮肤护理、美容服务及相关医疗机构信息，提供合规商家展示、消费评价、预约和营销服务，具体服务由相应医疗机构提供。

\- 美团结婚与婚庆服务：美团婚庆、婚纱摄影、婚宴酒店、婚礼策划及相关商家服务，提供本地婚庆信息、消费评价及在线预订。

\- 美团亲子与教育服务：美团亲子、儿童乐园、兴趣培训、亲子活动及相关本地商家信息，覆盖家庭消费、休闲娱乐和线下服务预订。

\- 美团配送即时物流：美团配送、美团专送、美团快送、美团众包、美团骑手 App，提供餐饮外卖、即时零售及其他本地商品的配送履约服务。

\- 美团跑腿同城配送：美团跑腿、帮买、帮取、帮送及相关同城即时服务，提供文件、商品、鲜花及其他符合规定物品的同城配送。

\- 美团骑手服务平台：美团骑手、美团众包、骑手工作台、配送调度及骑手安全管理工具，提供接单、导航、订单管理、配送结算和骑手工作支持。

\- 美团单车城市出行：美团单车、美团骑行、共享单车及相关城市慢行交通服务，原摩拜单车业务已整合进入美团品牌。

\- 美团电单车：美团电单车、共享电动助力车及相关短途出行服务，在符合当地管理规定的城市提供共享两轮出行。

\- 美团打车与聚合出行：美团打车、聚合网约车、第三方运力接入及相关出行服务，为用户提供车辆查询、网约车呼叫和出行订单管理。

\- 美团充电宝：美团共享充电宝、商家充电宝设备和相关租借服务，提供线下消费场所的移动电源租赁。

\- Keeta 国际外卖：Keeta、Keeta App、Keeta Merchant、Keeta Rider，主要面向香港、中东和巴西等市场提供在线点餐、餐饮外卖和即时配送服务。

\- Keeta 国际即时零售：Keeta Grocery、Keeta Mart 及各市场相关商品即时配送服务，覆盖超市商品、便利店、生活用品和即时购物，具体服务范围因国家和地区而异。

\- 美团无人机配送：美团无人机、自动配送机巢、低空配送航线、无人机物流调度平台，提供城市低空即时配送及相关软硬件基础设施。

\- 美团无人车配送：美团自动配送车、美团无人配送系统、城市低速自动驾驶、无人配送调度平台，主要用于社区、商超、园区及其他即时物流场景。

\- 美团“小黄蜂”配送机器人：小黄蜂智能配送机器人、室内外协同配送及相关自动导航系统，面向机场、园区和大型综合体等复杂场景提供自动化配送服务。

\- 美团商家运营平台：美团开店宝、美团商家版、美团商户通、美团推广通、美团商家中心，提供商家入驻、线上店铺管理、团购商品管理、订单管理和营销推广。

\- 美团收银与餐饮系统：美团收银、美团餐饮系统、美团管家、美团点餐、美团排队、美团发票，提供 POS 收银、餐饮点单、排队叫号、库存、经营管理及门店数字化服务。

\- 美团餐饮智能硬件：美团收银机、自助点餐设备、智能收银终端、厨房打印机及相关餐饮软硬件解决方案，面向餐厅、茶饮店和零售门店提供数字化经营设施。

\- 美团商家营销与广告：美团推广通、美团旺铺宝、美团品牌营销、美团商家广告、闪购品牌通，提供本地商家曝光、精准广告、品牌营销和经营数据分析。

\- 美团商家会员与客户管理：美团全渠道会员、商家 CRM、用户营销、优惠券管理及相关会员运营工具，提供客户管理、复购营销和会员服务。

\- 美团企业服务：美团企业版、美团商企通、企业用餐、企业差旅及相关企业消费管理服务，覆盖企业员工餐饮、差旅预订、费用管理与商务消费。

\- 美团支付与金融服务：美团支付、钱袋宝、美团钱包、美团月付、美团借钱及相关金融服务，提供支付结算、消费信贷和账户管理，相关信贷业务由持牌实体或合作金融机构提供。

\- 美团商家金融服务：美团生意贷、商家经营贷款、商家收单服务及相关经营融资工具，帮助商家获得支付、资金管理及符合监管规定的融资服务。

\- 美团 LongCat 大语言模型：LongCat-Flash-Chat、LongCat-Flash-Thinking、LongCat-Flash-Thinking-2601、LongCat-2.0，以及相关文本、代码、推理和智能体模型，覆盖自然语言理解、复杂推理、编程与工具调用。

\- 美团 LongCat 多模态模型：LongCat-AudioDiT、LongCat 系列语音与多模态研发模型，涉及语音生成、音色克隆、多模态理解及相关生成式 AI 技术。

\- 美团 LongCat AI 开发生态：LongCat 开源模型、模型权重、推理引擎、技术文档、模型 API 及相关工具，支持企业和开发者开展模型调用、私有化部署、智能体开发及 AI 编程。

\- 美团 CatPaw AI Agent：CatPaw、CatPaw PC 客户端、CatPaw 移动端、CatPaw 云端智能体、企业 Agent 托管平台，提供跨设备任务执行、文件操作、网页自动化、工具调用和企业数字员工服务。

\- 美团 Tabbit AI 浏览器：Tabbit、Tabbit AI 搜索、Tabbit 智能问答、网页总结、智能翻译、浏览器 Agent、妙招（Skill）广场，提供网页浏览、信息检索、智能交互和浏览器自动化。

\- 美团“小团”AI 助手：小团、小团 AI 搜索、消费决策助手、商家推荐、旅行规划、餐饮推荐和服务预订，利用美团本地生活数据帮助用户查询商品、比较服务并执行部分消费任务。

\- 美团商家 AI 工具：美团智能掌柜、袋鼠管家、CatPaw 商家 Agent 及相关智能经营工具，提供智能客服、门店评价分析、商品文案、营销策划、经营数据分析和商家自动化服务。

\- 美团 AI 健康管理：小团健康管家、健康卡、家庭健康档案、AI 报告解读、用药提醒及相关医疗健康辅助工具，提供健康信息、家庭健康管理和医疗服务连接。

\- 美团 AI 研究与智能体评测：LongCat、EvoCUA、LoHoSearch、MineExplorer 等模型、研究项目及评测工具，涉及计算机操作智能体、复杂搜索、多模态理解和长程任务能力评估。

\- 美团物流算法与智慧调度：即时配送路径规划、智能派单、运力预测、动态定价、配送时效优化和物流仿真技术，主要为美团外卖、闪购、Keeta 及配送网络提供技术支持。

\- 美团技术基础设施与开发框架：MCP（Meituan Channel Package）、OCTO、Leaf、MTrace、CAT 等内部研发、分布式系统、服务治理及相关开源项目，涉及 Java 服务框架、分布式 ID、链路追踪、监控和基础设施工程。其中部分项目已形成独立社区或存在历史维护状态差异。

\- 美团云计算与数据平台：集团内部云计算、大数据处理、机器学习平台、数据仓库、实时计算和数据分析系统，主要服务于美团自身的海量交易、即时配送、推荐和 AI 模型研发需求，不应与阿里云、腾讯云等完整对外公有云业务等同。

\- 美团龙珠投资与产业服务：美团龙珠、美团产业投资及相关投资基金，主要投资消费品牌、供应链、零售科技、人工智能和硬件技术，属于集团投资与生态建设业务。

\- 美团公益与社会服务：美团公益、美团青山计划、美团乡村儿童操场、美团绿色科技基金及相关公益项目，覆盖环境保护、乡村发展、儿童公益和社区服务。

#### 招聘情况
- [招聘官网](https://zhaopin.meituan.com/web/home)
![示意图](PixPin_2026-04-25_16-28-03.webp)

招聘情况也很多,但是AI/算法岗位占比很高,超过一半了.
### 京东
#### 公司概况
京东（JD.com）是一家成立于1998年、总部位于北京的中国最大零售商，由刘强东创立。公司自2004年转型线上零售以来，凭借自建物流体系和B2C自营模式，发展成为与天猫比肩的电商巨头，2024年营收超过1588亿美元，位列财富世界500强前列。其业务版图涵盖零售、物流、科技、健康、工业及国际商业等多个领域，以正品保障和极速配送为核心竞争力。
- 主打电商平台
#### 公司历史

\- 1998—2003｜创立与线下电子产品零售：刘强东（Richard Qiangdong Liu）于1998年在北京中关村创立京东前身“京东多媒体”，最初以代理销售光磁产品、电脑配件和消费电子产品为主，逐渐建立以正品行货、库存管理和直接采购为核心的零售经营模式。2003年非典疫情期间，京东开始尝试通过互联网论坛和线上渠道销售商品，为后续电子商务转型积累经验。

\- 2004—2009｜全面转型电商与自建物流：2004年正式上线京东多媒体网，结束以实体门店为主的经营模式，转向 B2C 在线零售。2007年更名为京东商城（360buy），开始自建仓储和物流配送体系，逐渐减少对第三方快递的依赖，形成采购、仓储、销售和配送一体化的自营电商模式。2008年扩大商品品类，从3C数码、家电逐步延伸至日用百货等综合零售领域。2009年开始建设大型物流中心和信息技术系统，为后续全国仓储配送网络奠定基础。

\- 2010—2013｜综合电商与供应链体系扩张：2010年正式推出第三方商家开放平台，形成自营零售与平台商家并行的商业模式，并推出“211限时达”等物流服务。2011年上线京东团购及相关数字消费业务，扩大服装、图书、家居和生活消费品等品类。2012年进一步发展开放平台、仓储配送和企业采购业务。2013年正式将360buy更名为JD.com及“京东”，获得腾讯等互联网企业之外的持续资本支持，并推进京东金融、云计算及智能物流等新业务布局。

\- 2014—2017｜美国上市与平台生态形成：2014年京东在纳斯达克上市（JD），同年与腾讯建立战略合作关系，获得微信、手机QQ等移动端流量入口，并接收腾讯部分电商资产。2015年扩大京东到家、京东超市、京东金融及物流服务，逐步进入即时零售、金融科技和生活服务领域。2016年与沃尔玛建立战略合作，获得一号店相关业务，并投资达达，推动线上零售、实体商超和同城配送整合。2017年京东物流正式独立运营，开始向外部企业开放仓储、运输、配送和供应链服务；同期成立京东产发相关业务，推动物流仓储基础设施资产管理。

\- 2018—2020｜无界零售、产业服务与港股上市：2018年京东持续发展智慧物流、无人配送、京东云和企业采购服务，并将零售业务向线下扩张。2019年成立京东健康，整合京东大药房、互联网医院、医药电商和健康服务；京东工业品业务也逐渐独立发展。2020年京东在香港联合交易所二次上市（9618.HK），京东健康同年在香港上市（6618.HK）。集团进一步扩大京东物流、京东科技、京东工业、京东产发等业务，形成以供应链为基础，覆盖综合零售、物流、医疗健康、工业采购及数字技术的综合企业集团。

\- 2021—2023｜子公司上市与供应链产业化：2021年京东物流在香港上市（2618.HK），成为集团重要的独立上市业务，并持续发展一体化供应链物流、快递和大型仓储设施。2022年京东物流取得德邦股份控制权，强化大件快运和零担运输能力；京东集团进一步增持达达，扩大京东到家与即时配送网络。2023年许冉（Sandy Ran Xu）接任京东集团 CEO，刘强东继续担任董事局主席。集团推进“低价战略”、百亿补贴和第三方商家生态，并深化七鲜、京东MALL、京东家政、京东养车及企业供应链业务，强化自营零售与开放平台协同。

\- 2024—2025｜即时零售、外卖与全球化重组：2024年将京东到家与京东即时零售能力进一步整合，升级为京东秒送，并扩大3C数码、医药、生鲜及生活商品即时配送。2025年正式推出京东外卖，进入餐饮即时配送市场，并通过骑手保障、商家合作和补贴扩张业务；同年完成达达私有化，使其成为全资子公司。2025年12月京东工业在香港上市（7618.HK），形成京东集团、京东物流、京东健康和京东工业四家上市公司。国际业务方面，宣布拟收购德国消费电子零售企业 CECONOMY，扩大欧洲零售与物流布局，同时继续发展 Joybuy 国际电商和海外仓储配送体系。

\- 2026｜即时配送整合、欧洲电商与 AI 技术发展：2026年3月正式在英国、德国、法国、荷兰、比利时和卢森堡上线 Joybuy 电商平台，以品牌商品、本地仓储和快速配送进入欧洲消费市场。京东物流于3月完成德邦私有化，德邦从上海证券交易所退市，并进一步整合原达达的即时配送能力。集团继续发展京东外卖、京东秒送、七鲜、京东MALL，以及京东工业的企业采购和供应链服务。AI 方面强化 JoyAI 模型、JoyAgent 智能体、JoyCode 编程、数字人和京东云智算基础设施。2026年第二季度集团营收约3464亿元人民币，京东物流业务保持增长；欧洲 CECONOMY 收购继续接受监管审查，截至10月24日尚未完成交割。

#### 控股公司及子公司

集团主体：京东集团股份有限公司（JD.com, Inc.）

- 总部及主要经营中心位于中国北京市，注册地为开曼群岛。1998年创立线下零售业务，2004年正式进入电子商务市场，2014年在美国纳斯达克上市（JD），2020年在香港联合交易所上市（9618.HK）。
- 京东集团是顶层上市公司，没有另一家企业作为其控股母公司。创始人刘强东（Richard Qiangdong Liu）担任董事局主席，许冉（Sandy Ran Xu）自2023年5月起担任 CEO。
- 集团采用同股不同权架构，B类普通股享有较高表决权。截至2026年3月18日，刘强东通过个人及相关持股安排控制约12.7%的股份和73.1%的表决权，保持对集团的控制权。
- 按2026年第二季度财报，集团主要划分为京东零售（JD Retail）、京东物流（JD Logistics）和新业务（New Businesses）三个报告分部。京东零售包括京东健康、京东工业等业务；京东物流涵盖集团内外物流、仓储及配送；新业务主要包括京东外卖、京喜、京东产发和国际业务。
- 京东采用直接控股、间接控股、上市子公司、战略投资及协议控制实体（VIE）相结合的经营架构，部分中国大陆互联网经营实体通过合同安排纳入集团合并报表，在法律股权结构上与直接持股子公司存在区别。

主要控股公司及核心业务：

- 京东零售（JD Retail）：集团最主要的经营业务，涵盖京东商城、京东超市、京东家电家居、京东数码、京东国际、京东京造、京东MALL 等线上线下零售服务。以自营商品销售为核心，同时经营第三方商家平台、广告营销及零售技术服务。
- 京东物流（JD Logistics, Inc.）：2007年开始建设自有物流网络，2017年正式独立运营，2021年在香港上市（2618.HK）。截至2026年初京东集团持有约63%股份，保持控股。主要提供仓储、快递、快运、冷链、跨境物流和一体化供应链服务。
- 京东健康（JD Health International Inc.）：2019年独立运营，2020年在香港上市（6618.HK）。截至2026年初京东集团持有约67%股份，保持控股。主营医药电商、京东大药房、互联网医院、在线问诊、健康管理及医疗数字化服务。
- 京东工业（JINGDONG Industrials, Inc.）：由京东工业品业务发展而来，2025年12月在香港上市（7618.HK）。上市后京东集团仍控制约72%的股份，主要面向制造、能源、交通和大型企业提供工业品采购、工业供应链管理和数字化采购服务。
- 京东产发（JINGDONG Property, Inc.）：2018年成立的物流及产业基础设施开发与资产管理平台，主营现代物流园区、仓储设施、产业园和基础设施投资管理。京东集团持有约75%的股权，保持控股。2026年1月再次向香港联合交易所递交上市申请，截至2026年10月尚未确认完成上市。
- 达达集团（Dada Nexus Limited）：2016年京东投资达达，2022年通过增持取得控制权，2025年6月完成私有化，使其成为全资子公司。原主要经营达达快送、京东到家等即时零售和同城配送服务，相关业务逐渐与京东秒送、京东物流整合。
- 德邦物流（Deppon Logistics）：1996年创立，主营大件快递、零担快运、整车运输和综合物流服务。2022年京东物流取得其控制权，2026年完成私有化，3月31日从上海证券交易所退市。目前属于京东物流控股体系。
- 跨越速运（Kuayue Express）：主营企业级限时快运、航空货运、大件运输和综合物流服务。京东物流于2020年取得其控制权，随后持续增持，形成面向企业客户的高时效物流网络。
- 京东五星电器（Five Star Appliance）：1998年成立的家电零售企业，2019年京东收购其46%股权，2020年实现全资控股。主要运营京东MALL、京东电器城市旗舰店、京东五星电器等线下零售业态。
- 七鲜（7FRESH）：京东旗下生鲜食品及零售业务，2018年推出首家七鲜超市，逐渐发展七鲜超市、七鲜线上零售及相关即时配送业务，主要经营生鲜、食品和日用消费品，属于集团零售业务体系。
- 京东京造：2018年推出的京东自有消费品牌，主要经营家居、日用百货、数码配件、智能设备、食品和生活消费品，依托京东供应链、品质管理和代工生产体系开展业务。
- 京东国际（JD Worldwide）：京东跨境进口零售平台，主要经营海外品牌商品、跨境进口商品、海外直采及保税仓配送，属于京东零售体系。
- 京喜（Jingxi）：2019年推出的社交电商和下沉市场零售业务，后经历京喜拼拼、京喜自营等多次调整，目前重点围绕低价商品、供应链效率和大众消费市场开展业务。
- 京东外卖（JD Food Delivery）：2025年正式推出的餐饮外卖业务，依托京东主站、京东秒送和京东物流配送网络提供餐饮配送、商家运营及本地生活服务，属于集团新业务。
- Joybuy：京东旗下国际零售品牌，2026年3月在英国、德国、法国、荷兰、比利时和卢森堡正式上线本地化电商平台，经营消费电子、家电、家居、美妆等商品，依托欧洲本地仓储和配送网络提供快速履约。
- 京东云（JD Cloud）：京东旗下云计算和企业技术服务品牌，主要提供云服务器、数据库、云原生、大数据、AI 算力、智能体开发和企业数字化解决方案，与京东集团及京东科技相关技术体系密切联系。
- 京东科技（JD Technology）：由京东金融、京东数字科技等业务发展而来，主要经营金融科技、支付科技、数字技术和企业解决方案。截至2025年底，京东集团持有其约54.9%的经济权益，但仅拥有约23.3%的表决权；由于特殊表决权安排，京东科技仍由刘强东控制，并由京东集团采用权益法核算，不能仅根据过半经济权益将其认定为京东集团并表控股子公司。
- 京东家政：京东旗下家庭服务业务，主要提供家庭保洁、深度清洁、家电清洗、维修和相关上门服务，依托京东平台及服务人员网络运营。
- 京东养车：京东旗下汽车后市场服务品牌，提供汽车维修保养、轮胎安装、汽车配件及线下门店服务，属于京东汽车及相关服务体系。
- 京东云 JoyAI：京东人工智能技术和应用体系，涵盖大语言模型、多模态模型、数字人、AI 搜索、AI 编程和智能体开发平台，服务于集团电商、物流、客服及企业技术业务。

集团重要法律实体：

- JD.com, Inc.：注册于开曼群岛，是集团顶层上市及控股主体。
- Jingdong Technology Group Corporation：注册于开曼群岛，属于京东集团重要的境外技术业务控股实体，需要与由刘强东实际控制、京东集团按权益法核算的境内京东科技区分。
- JD Logistics, Inc.：注册于开曼群岛，是京东物流香港上市主体。
- JD Health International Inc.：注册于开曼群岛，是京东健康香港上市主体。
- JINGDONG Industrials, Inc.：注册于开曼群岛，是京东工业香港上市主体。
- JINGDONG Property, Inc.：注册于开曼群岛，是京东产发业务的重要控股主体。
- JD Property Holding Limited：注册于开曼群岛，属于集团不动产和物流基础设施控股体系。
- JD Assets Holding Limited：注册于开曼群岛，承担部分非物流不动产及相关资产的控股职能。
- JD.com Investment Limited：注册于英属维尔京群岛，属于集团重要投资控股实体。
- JD Asia Development Limited：注册于英属维尔京群岛，承担集团部分物流物业及相关资产的投资持有职能。
- JD Jiankang Limited：注册于英属维尔京群岛，属于京东健康业务相关控股实体。
- JD Industrial Technology Limited：注册于英属维尔京群岛，属于京东工业业务相关控股实体。
- JD Sunflower Investment Limited：注册于英属维尔京群岛，属于集团投资控股体系。
- JD Logistics Holding Limited：注册于中国香港，属于京东物流重要控股实体。
- Jingdong E-Commerce (Trade) Hong Kong Co., Ltd.：注册于中国香港，是集团电子商务和贸易相关控股实体。
- JD.com International Limited：注册于中国香港，属于集团国际业务相关法律实体。
- 北京京东世纪贸易有限公司（Beijing Jingdong Century Trade Co., Ltd.）：京东重要境内零售经营实体，承担商品销售、采购及相关商业运营职能。
- 江苏京东信息技术有限公司（Jiangsu Jingdong Information Technology Co., Ltd.）：集团境内重要信息技术与电子商务经营实体。
- 重庆京东海嘉电子商务有限公司（Chongqing Jingdong Haijia E-commerce Co., Ltd.）：集团重要电子商务经营实体。
- 北京京东尚科信息技术有限公司（Beijing Jingdong Shangke Information Technology Co., Ltd.）：集团重要技术研发及信息服务实体。
- 江苏新川海联供应链管理有限公司（Jiangsu Xinchuan Hailian Supply Chain Management Co., Ltd.）：属于集团供应链及物流经营体系。
- 上海晟达元信息技术有限公司（Shanghai Shengdayuan Information Technology Co., Ltd.）：集团境内重要信息技术相关实体。
- 宿迁汉邦投资管理有限公司（Suqian Hanbang Investment Management Co., Ltd.）：属于集团境内投资管理体系。
- 北京沃东天骏信息技术有限公司（Beijing Wodong Tianjun Information Technology Co., Ltd.）：集团信息技术及相关经营实体。
- 京东物流供应链有限公司（Jingdong Logistics Supply Chain Co., Ltd.）：京东物流体系重要经营实体，涉及仓储、配送及供应链服务。
- 江苏汇吉空间科技有限公司（Jiangsu Huiji Space Technology Co., Ltd.）：属于集团重要的供应链与技术经营体系。

集团主要协议控制实体（VIE）：

- 北京京东叁佰陆拾度电子商务有限公司：京东境内互联网业务的重要协议控制实体，承担部分电子商务和相关互联网经营业务。
- 江苏圆周电子商务有限公司：京东重要境内协议控制实体，涉及电商及相关互联网业务。
- 江苏京东邦能投资管理有限公司：属于集团协议控制及投资经营架构。
- 宿迁涵宇科技有限公司：京东境内重要协议控制实体。
- 西安京东信成信息技术有限公司：属于集团境内协议控制经营体系。
- 宿迁聚合数字企业管理有限公司：属于集团协议控制体系相关实体。
- 北京快京邦达贸易有限公司（Beijing Jingbangda Trade Co., Ltd.）：属于京东重要的配送与物流相关协议控制经营体系。

以上境外及境内法律实体主要依据京东2025财年 SEC Exhibit 8.1 披露整理。协议控制实体通过合同安排纳入京东合并财务报表，不能与直接持股的全资子公司混同。

其他重要收购及历史业务：

- 达达快送：原达达集团旗下即时配送品牌，主营同城配送、众包配送和商家履约。2025年达达完成私有化后，2025年10月其即时配送业务由京东物流收购并整合，形成全职骑手与众包骑手结合的配送网络。
- 京东到家：原达达集团旗下即时零售平台，主要连接商超、便利店、药房及品牌商家，后与京东即时零售业务整合为京东秒送体系，原品牌逐渐退出独立经营。
- 德邦股份：京东物流于2022年取得控股权，2026年完成私有化并从上海证券交易所退市，成为京东物流业务体系内的重要企业。
- 一号店（Yihaodian）：2008年成立的早期综合电商企业，2016年京东与沃尔玛达成战略合作，取得一号店及相关资产，逐步将其用户、供应链和零售资源整合进入京东体系。
- 易迅网（Yixun）：原腾讯旗下电子商务平台，2014年京东与腾讯建立战略合作时取得相关业务资源，其技术、渠道与用户逐渐整合进入京东零售体系。
- 京东五星电器：2019—2020年分阶段完成收购，成为京东线下家电零售网络的重要组成部分。
- CECONOMY AG：德国消费电子零售集团，旗下拥有 MediaMarkt、Saturn 等欧洲家电数码零售品牌。2025年7月京东提出每股4.60欧元的现金收购要约，相关股份接受比例达到约59.8%，但交易仍受欧盟外国补贴审查等监管条件约束。截至2026年10月24日尚未确认交割完成，因此不能将 CECONOMY、MediaMarkt 或 Saturn 列为京东现有控股子公司。
- Ochama：京东曾在欧洲推出的自动化零售及全渠道购物业务，2022年从荷兰市场起步，后来进行业务模式调整。2026年京东将欧洲零售资源进一步集中于 Joybuy 品牌。

其他重要投资及股权关系：

- 腾讯控股（Tencent）：2014年京东与腾讯建立战略合作关系，腾讯向京东转移部分电商资产并成为重要股东，双方围绕微信购物入口、支付和电商营销开展合作。2021年腾讯宣布以股份分派方式大幅减少京东持股，腾讯不属于京东集团控股母公司。
- 沃尔玛（Walmart）：2016年与京东建立战略合作关系，并曾成为重要股东，双方在零售、供应链、山姆会员店及即时零售等方面合作。2024年沃尔玛出售其所持京东股份，退出主要股东体系。
- 永辉超市：京东曾通过战略投资持有永辉股权，并围绕零售供应链、数字化和超市业务开展合作。2025年京东出售所持主要股份，目前永辉不属于京东集团控股子公司。
- 唯品会（Vipshop）：中国特卖电商企业，2017年京东与腾讯共同投资并建立合作关系，唯品会始终保持独立上市和经营。
- 爱回收 / 万物新生（ATRenew）：中国二手消费电子回收及循环经济企业，2019年京东将拍拍二手业务与爱回收整合，并成为重要股东。2021年万物新生在美国上市（RERE），属于京东重要战略投资对象，具体控制关系需按其最新股权与表决权结构判断。
- 京东科技控股股份有限公司：京东集团的重要关联企业，截至2025年底京东集团持有54.9%的经济权益、23.3%的表决权，刘强东通过特殊表决权结构保持控制。京东支付、京东金融等相关产品主要属于京东科技体系，不能直接等同于京东上市集团的全资业务。
- 红杉中国及高瓴资本相关基金：曾参与京东集团或其相关子公司融资，属于机构投资关系，不构成母子公司关系。
- CECONOMY / Convergenta：京东对 CECONOMY 的拟收购涉及其创始家族控股实体 Convergenta。交易完成后双方计划形成长期战略合作，但在监管批准及交割完成前，仍需将其列为拟收购企业。

#### 主要产品

\- 京东综合电子商务：京东商城、京东 App、京东网页版、京东百亿补贴、京东PLUS会员、京东直播，覆盖3C数码、家电家居、服装、食品、日用百货和综合商品零售。

\- 京东自营零售：京东自营、京东自营旗舰店、京东自营售后及相关采购配送服务，依靠京东统一采购、库存管理、物流和售后体系经营商品。

\- 京东第三方商家平台：京东开放平台、京东商家后台、京麦、京东店铺、京东服务市场、京东商家成长中心，提供商家入驻、商品管理、订单运营和平台交易服务。

\- 京东PLUS会员：京东PLUS、PLUS专享价、PLUS会员权益、运费优惠及相关合作权益，提供购物优惠、会员服务和增值消费权益。

\- 京东超市：京东超市、京东食品、京东生鲜、京东母婴、京东个护、京东日用百货，提供食品饮料、家庭用品、母婴商品和综合日用品零售。

\- 京东数码与电脑：京东电脑数码、京东手机、京东电脑办公、京东智能设备、京东装机大师及相关商品服务，覆盖手机、笔记本、台式机、计算机配件、相机和智能硬件。

\- 京东家电与家居：京东家电、京东家居、京东家装、京东家具、家电以旧换新、家电安装及相关服务，提供大型家电、智能家居、家具和家装消费。

\- 京东国际跨境购物：京东国际、京东全球购相关业务、跨境进口商品、海外品牌旗舰店及保税仓配送，覆盖进口美妆、母婴、保健、服饰和消费电子。

\- 京喜低价零售：京喜、京喜自营及相关低价商品经营业务，主要面向大众消费市场提供日用百货、食品和其他高性价比商品。

\- 京东京造自有品牌：京东京造、京东京造家居、京东京造日用百货、京东京造数码配件、京东京造智能设备，提供家居生活、食品、消费电子及相关自有品牌商品。

\- 七鲜生鲜零售：七鲜、七鲜超市、七鲜线上购物及相关自有商品，提供生鲜食品、餐饮食品、超市商品和线上线下一体化零售服务。

\- 京东秒送即时零售：京东秒送、京东附近好店、商超即时配送、药品即时配送、数码商品即时配送，提供本地商家商品搜索、在线下单和快速配送服务。

\- 京东外卖餐饮配送：京东外卖、外卖商家入驻、外卖商家管理、京东骑手配送及相关餐饮平台服务，覆盖在线点餐、商家经营和本地餐饮配送。

\- 京东本地生活与服务：京东家政、京东到家相关整合业务、京东服务、上门安装、家电清洗、家居维修等，提供家庭及本地生活服务。

\- 京东家政：家庭保洁、深度保洁、家电清洗、家居清洁、日常上门服务及相关家政服务人员管理。

\- 京东汽车与京东养车：京东汽车、京东养车、京东汽车用品、汽车轮胎、保养维修、汽车配件和线下汽车服务门店，覆盖汽车后市场和车辆日常维护。

\- 京东MALL线下零售：京东MALL、京东电器城市旗舰店、京东五星电器、京东之家，提供家电、数码、智能家居和科技体验式零售。截至2026年第二季度，京东MALL已开设30家门店。

\- 京东拍卖与特殊商品交易：京东拍卖、司法拍卖、资产拍卖、二手商品拍卖和企业资产处置服务，提供线上竞价及相关交易服务。

\- 京东二手与循环经济：京东以旧换新、京东回收、拍拍二手历史业务及与万物新生合作的消费电子回收服务，覆盖旧机回收、二手交易和循环消费。

\- Joybuy 欧洲电商：Joybuy、Joybuy App、JoyPlus会员、Joybuy品牌店，主要面向英国、德国、法国、荷兰、比利时和卢森堡提供消费电子、家电、家居及综合零售服务。

\- 京东国际贸易与跨境服务：京东全球售、京东跨境进口、京东海外仓、国际供应链和跨境商家服务，覆盖跨境商品交易、海外仓储和国际物流。

\- 京东物流快递配送：京东快递、京东特快、京东标快、京东快递个人寄件、京东快递企业寄件，提供国内快递、同城寄件、商务快递和个人包裹配送。

\- 京东物流大件与快运：京东快运、京东大件物流、德邦快递、德邦快运、跨越速运，覆盖家电家具配送、大件运输、零担物流、整车运输及企业级限时配送。

\- 京东物流仓储服务：京东仓储、京东物流云仓、智能仓储、一体化仓配、仓储托管及相关库存管理，提供商品入库、分拣、存储、配送和供应链履约服务。

\- 京东物流一体化供应链：京东物流一体化供应链解决方案、供应链规划、库存管理、订单履约、智能补货和物流网络优化，主要面向零售、快消、汽车、服装和制造企业。

\- 京东物流国际业务：京东物流国际快递、国际供应链、海外仓、跨境物流、JoyExpress及相关国际物流服务，提供跨境运输、海外仓储和本地配送。

\- 京东物流冷链与生鲜配送：京东冷链、医药冷链、生鲜冷链、冷链仓储与温控运输，服务食品、生鲜、药品及对温度敏感的商品。

\- 达达快送同城配送：达达快送、达达商家配送、众包配送及相关即时履约技术，提供餐饮、商超、零售和其他本地商品的即时配送，现已与京东物流配送业务整合。

\- 京东物流无人配送：京东无人配送车、京东物流自动配送系统、自动驾驶物流车辆和相关无人配送调度技术，主要应用于园区、城市社区及末端配送场景。

\- 京东物流仓储机器人：京东物流“狼族”机器人、天狼智能仓储系统、地狼智能仓储系统、自动分拣机器人、智能搬运设备，提供仓储自动化、智能分拣和物流作业优化。

\- 京东物流智慧供应链技术：京东物流仓储管理系统、运输管理系统、智能调度、数字孪生仓储和物流数据分析，服务集团自营物流及第三方企业客户。

\- 京东产发物流基础设施：京东产发、现代物流园、智能仓储园区、产业园、物流设施资产管理、基础设施投资与运营，主要面向物流、制造、供应链和大型企业客户。

\- 京东工业企业采购：京东工业、京东工业品、京东工品汇、京东工业企业购及相关采购平台，提供工业耗材、工具、设备、备品备件和生产物资采购。

\- 京东工业供应链管理：京东工业太璞数智供应链、工业供应链数字化解决方案、工业品库存管理和智能采购，帮助制造、能源和大型工业企业优化采购和库存。

\- 京东工业MRO产品：工业紧固件、机械工具、电气设备、劳保用品、设备维修耗材、生产辅料和工厂日常运营物资，覆盖工业维护、维修与运营（MRO）采购。

\- 京东工业企业采购平台：企业采购管理、采购寻源、订单协同、供应商管理、工业品标准化和工业供应链数字化服务。

\- 京东健康线上药房：京东大药房、京东买药、京东健康药房、处方药合规销售、非处方药及健康商品零售，提供线上药品购买、配送和相关用药服务。

\- 京东健康互联网医院：京东互联网医院、京东在线问诊、京东医生、京东健康医疗咨询，提供线上医生咨询、复诊、处方流转和医疗健康服务。

\- 京东健康家庭健康服务：京东家医、家庭医生服务、慢病管理、健康管理、医疗服务预约及相关家庭健康服务。

\- 京东健康AI医疗：京东健康AI医生、京医千询医疗大模型及相关医疗智能体，提供医疗信息辅助、健康问答、医学资料处理和医疗服务支持。

\- 京东健康企业与医疗机构服务：京东健康医疗数字化、企业健康服务、药企数字营销、医院及药店数字化解决方案，服务医药企业、医疗机构和企业客户。

\- 京东云计算基础设施：京东云云主机、弹性计算、裸金属服务器、GPU云服务器、弹性伸缩和专有云，提供企业计算、应用部署和云端算力服务。

\- 京东云容器与云原生：京东云容器服务、Kubernetes、容器镜像、微服务平台、Serverless及相关云原生产品，支持容器编排、应用部署和分布式系统管理。

\- 京东云存储与数据库：对象存储、云硬盘、文件存储、云数据库MySQL、PostgreSQL、Redis和相关分布式数据库服务，提供企业数据存储、缓存和数据库管理。

\- 京东云网络与安全：私有网络VPC、负载均衡、CDN、云防火墙、DDoS防护、Web应用防火墙及相关网络安全服务，提供企业网络连接、内容分发、应用安全和基础设施保护。

\- 京东云大数据与分析：京东云数据仓库、数据集成、实时计算、智能数据分析、JD BI及相关数据平台，提供企业数据处理、报表分析和商业智能。

\- 京东云AI算力服务：京东云智算中心、GPU计算服务、模型训练、模型推理、AI开发平台及相关算力资源管理，面向企业AI模型部署和智能体运行。

\- 京东JoyAI人工智能模型：JoyAI、JoyAI-VL、JoyAI-Code、JoyAI-Voice、JoyAI-Image、JoyAI-Video、JoyAI-Echo等模型与研发项目，涉及语言理解、代码生成、视觉理解、语音交互、图像视频生成和具身智能。

\- 京东JoyAI多模态交互：JoyAI-VL-Interaction、JoyAI-Talker、JoyAI-Voice、JoyAI-Image-Edit、JoyAI-Video-Edit，提供实时视觉理解、语音生成、数字人交互及多媒体内容处理能力。

\- 京东JoyAgent智能体平台：JoyAgent、JoyAgent智能体开发、知识库、工作流编排、工具调用及相关企业Agent服务，支持企业AI助手、智能客服、业务自动化和智能体部署。

\- 京东JoyBuilder模型开发平台：JoyBuilder、模型微调、模型评测、模型部署及相关AI开发工具，提供模型开发、优化和企业私有化部署能力。

\- 京东JoyCode AI编程：JoyCode、AI代码生成、智能调试、项目生成、代码理解、Agent开发及相关云端开发工具，提供AI辅助软件工程和应用部署能力。

\- 京东数字人技术：京东言犀数字人、JoyAvatar、京东数字人直播及相关生成式AI技术，面向电商直播、商家营销、智能客服和内容制作。

\- 京东智能客服：京东言犀、京东客服智能助手、商家智能客服、AI导购、客服机器人及相关企业服务，覆盖商品咨询、订单服务、客户沟通和售后支持。

\- 京东智能营销：京点点、JoyMarketing、京东广告AI创意、智能投放及相关广告生成工具，提供商品文案、广告素材、营销创意和商家运营自动化。

\- 京东AI购物：京东AI购、智能导购、商品推荐、智能搜索、AI购物助手及相关消费智能体，为用户提供商品检索、比较、推荐和购物决策辅助。

\- 京东智能硬件与AIoT：JoyInside、京东智能设备接入平台及相关AI硬件解决方案，提供语音助手、智能交互、家居控制和终端AI能力。

\- 京东企业采购：京东企业购、京东慧采、京东政企采购、企业福利采购及相关采购管理平台，服务政府机构、大型企业、中小企业和组织采购。

\- 京东企业数字化服务：企业采购管理、企业供应链、数字营销、云计算、智能客服、企业AI与数字化运营方案，提供采购、IT、营销和业务管理的综合技术服务。

\- 京东科技金融服务：京东金融、京东支付、京东白条、京东金条、京东小金库、京东钱包，以及相关金融科技产品，主要由京东科技及持牌合作机构运营。其中消费信贷和理财服务受金融监管要求约束。

\- 京东科技支付与商家服务：京东支付、京东收银、企业支付、商家结算及相关支付科技，面向零售商家和企业客户提供交易结算与支付服务。

\- 京东科技产业数字化：供应链金融科技、风险管理技术、智能营销、企业数字化及相关技术服务，属于与京东集团保持紧密业务合作的京东科技体系。

\- 京东广告与商家营销：京准通、京东快车、京东展位、京东直投、京东营销平台、京东数坊等产品及相关演进服务，提供搜索广告、展示广告、品牌营销和数据分析。其中部分名称属于历史产品或已经升级整合。

\- 京东开放平台与开发者生态：京东开放平台API、京东云SDK、商家接口、物流开放接口、支付及企业采购接口，支持第三方应用接入、店铺管理、系统集成和业务开发。

\- 京东商家软件与运营工具：京麦、京东商家后台、京东店铺管理、营销工具、数据分析和订单管理，为第三方商家提供商品运营和电商管理服务。

\- 京东技术研究与开源：JoyAI开源模型、京东探索研究院（Joy Future Academy）、京东云开发工具及相关技术项目，涉及AI模型研发、计算机视觉、语音交互、具身智能、云计算和供应链技术。

\- 京东公益与社会服务：京东公益、京东公益平台、物资捐赠、乡村振兴和供应链公益项目，利用电商及物流基础设施开展公益捐赠与社会服务。
#### 招聘情况
- [招聘官网](https://zhaopin.jd.com/home)

![示意图](PixPin_2026-04-25_16-35-25.webp)

需求比起前面的公司骤减,并且全面拥抱AI.
### 网易
#### 公司概况
网易是一家成立于1997年、总部位于杭州的领先互联网技术公司，由丁磊创立。作为全球顶尖的游戏开发商，其核心支柱为《梦幻西游》等自研游戏及暴雪游戏的中国代理，同时深度布局网易云音乐、网易有道（在线教育）和网易邮箱等多元化服务。凭借2023年达146亿美元的营收规模，网易在深耕国内内容社区的同时，正通过在全球建立工作室加速向国际化游戏市场转型。

- 核心业务是游戏
#### 公司历史
- [Wiki](https://en.wikipedia.org/wiki/NetEase)

##### 1997–2003：从邮箱服务到游戏转型
* **1997年6月：** 丁磊在广州创立网易，初期仅有3名员工，主要销售邮件服务器软件。
* **1998–1999年：** 推出 163 邮箱，成为中国首个提供免费邮箱、在线社区和个性化信息的门户网站。
* **2000年7月1日：** 在美国纳斯达克（Nasdaq）上市，发行价 15.5 美元。
* **2001年：** 成立网易游戏（NetEase Games）；推出首款自主研发的 MMORPG《大话西游 Online》，标志着公司战略重心的转移。
* **2003年：** 获得高盛、软银等机构投资；邮箱注册用户达到 170 万。

##### 2004–2014：多元化探索与暴雪合作
* **2005–2007年：** 推出博客服务；正式上线自主搜索引擎“有道（Youdao）”，取代与谷歌的合作。
* **2008年：** 开始与**暴雪娱乐**（Blizzard Entertainment）合作，获得《魔兽世界》等作品在中国内地的代理权。
* **2011年：** 推出网易轻博客 **LOFTER**，成为中国最活跃的同人文化平台之一。
* **2013年：** 与 Coursera 合作推出中文公开课平台；上线**网易云音乐**，进入音乐流媒体市场。
* **2014年：** 与腾讯产生版权纠纷，最终达成音乐版权转授权协议，成为行业标准模型。

##### 2015–2022：电商高潮、全球收购与监管挑战
* **2015–2016年：** 推出跨境电商**考拉海购**及自营品牌**网易严选**；在旧金山设立首个美国办公室。
* **2017年：** 与漫威（Marvel）达成合作，出版中国超级英雄漫画；邮箱用户突破 9.4 亿。
* **2019年：** 将考拉海购以 20 亿美元出售给阿里巴巴。
* **2020年：** 在香港联交所完成二次上市。
* **2021–2022年：** * **收购与扩张：** 全资收购 Quantic Dream、草蜢工作室（Grasshopper Manufacture）；入股 Devolver Digital。
    * **合作伙伴关系：** 推出《永劫无间》及《暗黑破坏神：不朽》。
* **2023年1月：** 由于授权协议到期，暴雪旗下游戏（除《暗黑破坏神：不朽》）在中国内地暂时停服。

##### 2023–至今：AI 驱动、暴雪回归与海外收缩
* **2023年3月：** 推出动画品牌 Anici。
* **2024年4月：** 宣布与暴雪娱乐更新协议，暴雪游戏重返中国市场；同时与微软达成战略合作。
* **2024年12月：** 自研游戏《漫威争锋》（Marvel Rivals）上线，前三天注册用户即突破 1000 万。
* **2024–2025年：** **战略调整期。** 为应对行业变化并与腾讯、米哈游竞争，网易开始收缩海外投资，关停包括 Ouka Studios、Jar of Sparks、Fantastic Pixel Castle 在内的多家海外工作室，寻求更小而精的全球布局。
* **2025–2026年：** 发布《命运：崛起》等重磅作品；部分海外工作室（如名越工作室、GPTRACK50）转向自筹资金或自出版模式。
  
#### 旗下公司及产品

##### 主要产品
- **核心游戏：**
    - **经典自研：** 《梦幻西游》、《大话西游》、《倩女幽魂》、《天下》、《逆水寒》（端手游）。
    - **爆款竞技/生存：** 《永劫无间》、《第五人格》、《蛋仔派对》、《荒野行动》、《明日之后》。
    - **国际合作：** 《漫威争锋》（Marvel Rivals）、《命运：崛起》（Destiny: Rising）、《暗黑破坏神：不朽》、《光·遇》（国内代理）。
- **通信与工具：**
    - **网易邮箱：** 包含 163、126、Yeah.net，中国领先的电子邮件服务商。
    - **网易有道：** 包含有道词典、有道翻译、有道精品课等智能学习工具。
- **数字内容：**
    - **网易云音乐：** 领先的音乐社区，主打独立音乐人扶持与歌单社交。
    - **网易新闻：** 门户网站 163.com 及移动端新闻客户端。
    - **LOFTER：** 泛兴趣创作社区（国内领先的同人/绘画社区）。
- **生活与电商：**
    - **网易严选：** 自营生活方式品牌。
    - **网易味央：** 现代农业品牌（网易黑猪）。

##### 核心工作室群 (NetEase Games)
- **国内事业群：**
    - **梦幻事业部：** 负责核心西游 IP 运营。
    - **雷火游戏/雷火事业群：** 驻地杭州，代表作《倩女幽魂》、《逆水寒》、《永劫无间》。
    - **互动娱乐事业群 (在线游戏)：** 包含广州和上海等地的多个工作室，负责《阴阳师》、《第五人格》等。
- **国际工作室 (控股/全资)：**
    - **Quantic Dream (法国)：** 代表作《底特律：变人》，全资收购。
    - **Grasshopper Manufacture (日本)：** 由须田刚一领导，全资收购。
    - **SkyBox Labs (加拿大)：** 曾支持《光环》、《我的世界》开发，全资收购。

##### 控股及关联公司
- **网易有道 (Youdao, Inc.)：** 纽交所上市公司，网易控股。
- **云音乐 (Cloud Village Inc.)：** 港交所上市公司，网易控股。
- **24 Entertainment：** 《永劫无间》开发商，隶属于雷火事业群。
- **Mattel163：** 与美泰 (Mattel) 合资成立，开发《UNO》等手游。
- **策略投资：** 持有 **Bungie**（少数股权）、**Devolver Digital**（约 8% 股份）等全球游戏公司的股权。

#### 招聘情况
- [招聘官网](https://game.campus.163.com/position)
![示意图](PixPin_2026-04-25_19-01-07.webp)
岗位很少,均为游戏相关,想去的话注意校招的时候抓紧投递
### 百度
#### 公司概况
百度（Baidu）是一家成立于2000年、总部位于北京的全球领先人工智能及互联网服务巨头，由李彦宏和徐勇创立。作为中国搜索引擎市场的统治者，百度不仅拥有百度搜索、百度百科、爱奇艺及百度贴吧等核心互联网产品，更转型为拥有全栈AI技术实力的科技公司，业务涵盖自动驾驶（Apollo）、智能硬件（小度）及云计算基础设施。作为首家入选纳斯达克100指数的中国企业.


>曾经的头部企业,由于战略走向问题逐渐衰落,如今抱牢着人工智能和智能驾驶慢慢恢复生机,但是既然有这么多战略失误,而且方向都向智能驾驶靠拢了,所以建议放到第二梯队.

#### AI总结的战略失误
百度在互联网时代的战略失误，常被外界总结为“错过了一个时代”或“在关键路口反复横跳”。其核心症结在于过早建立的搜索霸权带来的路径依赖，导致在多次行业重塑中落后。

以下是百度公认的四大战略失误：

##### 1. 错过移动互联网的“入口门票”
* **失误点：** 百度在移动化转型上极其迟钝。当阿里巴巴布局手机淘宝、腾讯孵化微信时，百度仍寄希望于通过“手机百度”浏览器承载一切。
* **后果：** 移动时代形成了“App孤岛”，搜索不再是唯一入口。百度直到 2013 年才斥资 19 亿美元收购 91 无线，试图通过应用商店补票。但这被公认为一次昂贵的失败，因为随后 App Store 和各手机厂商自带商店迅速封死了第三方商店的空间。

##### 2. O2O 战略的摇摆与收缩
* **失误点：** 2015 年，李彦宏曾高调宣布“拿 200 亿砸向 O2O（百度外卖、糯米）”，试图将搜索与生活服务闭环。
* **后果：** 在与美团、饿了么的烧钱大战中，百度由于内部资源整合不力及战略耐性不足，最终在 2017 年前后全面退缩，卖掉外卖业务。这导致百度失去了继搜索之后最真实的用户消费场景和支付数据。

##### 3. 短视频与内容生态的缺位
* **失误点：** 百度拥有强大的技术基因，却缺乏产品经理基因。在短视频爆发前夕，百度并未利用其搜索带来的巨大流量孵化出类似抖音、快手的短视频应用。
* **后果：** 当用户的信息获取习惯从“搜文字”转向“看短视频”时，百度流量遭到字节跳动等对手的结构性打击。虽然百度后来补齐了好看视频和百家号，但已无法撼动已成型的市场格局。

##### 4. “医疗广告”对品牌护城河的侵蚀
* **失误点：** 过度依赖医疗竞价排名带来的高利润。2016 年的“魏则西事件”成为百度的品牌分水岭。
* **后果：** 这次危机不仅导致了严格的监管处罚，更重创了公众对百度的信任。这种品牌负资产使得百度在后来的产品推广中（如 AI、自动驾驶）背负了极高的心理信任成本。

---

##### 总结
百度的技术基因使其在 AI 领域领先（如 2017 年起全力押注 Apollo 和大模型），但**产品化能力的缺失**和**对核心营收（广告）的过度依赖**，使其在过去十年中不断面临“赢了技术、输了场景”的尴尬局面。

直到 2024-2025 年，随着萝卜快跑（Robotaxi）和文心大模型（ERNIE）在 B 端与 C 端的落地，百度才算真正找到了摆脱“搜索路径依赖”的第二增长曲线。
#### 公司历史
- [Wiki](https://en.wikipedia.org/wiki/Baidu)

##### 1994–2004：RankDex 算法与搜索引擎诞生
* **1996年：** 李彦宏在 IDD 期间开发了 **RankDex** 站点评分算法，这是全球首个利用超链接评估网站质量的引擎，比谷歌的 PageRank 早两年。
* **2000年1月18日：** 李彦宏与徐勇在北京创立百度。
* **2001年：** 推出竞价排名（竞标广告位），早于谷歌采用类似的广告模式。
* **2003年：** 上线新闻搜索和图片搜索，利用识别技术对文章进行自动聚类。

##### 2005–2016：纳斯达克上市与移动转型
* **2005年8月5日：** 百度在纳斯达克挂牌上市，成为当时美股市场的焦点。
* **2007–2008年：** 成为首个获得新闻发布牌照的搜索平台；启动日本搜索业务（后于2015年关闭）。
* **2010年1月：** 遭遇著名的 DNS 劫持攻击，导致服务中断四小时。
* **2013年：** 以 18.5 亿美元收购 **91 无线**，创下当时中国互联网史上最大并购案；收购纵横中文网成立百度文学。
* **2014年：** 吴恩达（Andrew Ng）加盟担任首席科学家，百度研究院开始发力人工智能（AI）。

##### 2017–2022：自动驾驶与 AI 转型
* **2017年4月：** 推出 **Apollo（阿波罗）** 自动驾驶开放平台，正式进军智能驾驶领域。
* **2017年9月：** 联合阿里、腾讯等注资 120 亿美元入股中国联通。
* **2018年：** 剥离全球移动应用业务（如 ES 文件浏览器），更名为 DO Global 独立运营；被中国政府指定为“人工智能国家队”。
* **2021年3月：** 在香港联交所完成二次上市。
* **2022年6月：** 旗下集度汽车（Jidu Auto）发布首款概念车 ROBO-01。

##### 2023–至今：大模型爆发与全球布局
* **2023年8月：** 正式向公众发布大语言模型 **文心一言（Ernie Bot）**。
* **2024年4月：** 自动驾驶出行平台“萝卜快跑（Apollo Go）”累计订单突破 600 万单，在武汉部署超 400 辆无人车。
* **2025年3月：** 发布 **文心大模型 4.5** 及推理模型 **ERNIE X1**，宣称在性能对标 DeepSeek R1 的同时成本仅为一半。
* **2025年7月：** 与 **Uber** 达成合作，计划将萝卜快跑（Apollo Go）部署至美国和中国内地以外的市场。
* **2026年1月：** 百度正式向港交所提交申请，拆分其半导体业务子公司 **昆仑芯（Kunlunxin）** 独立上市。
#### 旗下公司及产品

##### 1. 移动生态与人工智能应用
* **百度 App：** 旗舰产品，集成搜索、信息流、百家号、小程序等功能，目前深度嵌入 **文心一言 (ERNIE Bot)** 实现 AI 原生搜索。
* **文心大模型 (ERNIE)：**
    * **文心一言 5.0：** 2026 年 1 月发布的下一代原生多模态大模型，支持文字、视觉、音频的统一理解与生成。
    * **ERNIE X1：** 高性能推理模型，主打逻辑推理与深度思考（Deep Thinking），对标全球顶尖推理模型。
* **百度百科 & 百度贴吧：** 核心内容社区，国内最大的百科全书和基于兴趣的中文论坛。
* **爱奇艺 (iQIYI)：** 控股的长视频流媒体平台。

##### 2. 智能云与算力基础设施
* **百度智能云 (Baidu AI Cloud)：** 国内市场份额领先的 AI 云供应商，主打 **MaaS (Model-as-a-Service)** 模型即服务，为企业提供大模型训练与部署环境。
* **昆仑芯 (Kunlunxin)：** 百度旗下的半导体子公司，专注 AI 芯片（如 M100/M300 系列），已于 2026 年 1 月正式启动在港上市流程。

##### 3. 智能驾驶与机器人
* **萝卜快跑 (Apollo Go)：** 全球领先的无人驾驶出行服务平台。
    * **规模：** 截至 2026 年初，累计订单突破 2000 万单，在武汉、北京等地实现商业化盈利（Unit Economics Breakeven）。
    * **全球布局：** 与 **Uber** 达成全球战略合作，2026 年上半年开始在英国伦敦及中东迪拜测试及部署无人车车队。
* **Apollo RT6：** 自研 Level 4 级量产无人车，采用无方向盘设计，单车成本降至 3 万美元（约 20 万人民币）以内。

##### 4. 智能硬件与消费电子
* **小度 (Xiaodu)：** 独立运营的智能硬件品牌。
    * **智能屏与音箱：** 搭载 DuerOS 系统的智能家居核心。
    * **小度添添家庭智能机器人：** 2025 年推出的全球首款大模型驱动的家庭机器人，具备情绪互动与护理功能。
    * **AI 酒店解决方案 4.0：** 2026 年 4 月发布，覆盖客房数突破 260 万间，并拓展至新加坡、泰国市场。

---

##### 核心事业部架构
* **MEG (移动生态事业群)：** 负责搜索、信息流、贴吧、百家号等。
* **ACG (智能云事业群)：** 负责云计算、企业级 AI 服务、昆仑芯业务。
* **IDG (智能驾驶事业群)：** 负责 Apollo 自动驾驶、萝卜快跑、智能交通。
* **SLG (智能生活事业群)：** 即小度科技，负责智能硬件与语音助手。
#### 招聘情况
##### 面经1
```md
## 题目

> **题目来源**：https://www.nowcoder.com/feed/main/detail/d39aabc0debd4dba810b4b9671d54348

**1.基础题**

- 有几种网络 Io 模型？
- 异步网络模型在什么场景下你了解有应用过？（回答了线程相关的场景）
- 除了用线程完成，还有什么操作可以完成异步操作？
- 同步阻塞和同步非阻塞在Java层面怎么实现？（说前面网络io模型答得挺顺畅，具体实现细节还需要提升一下）
- 描述一下一次完整的 Http 请求
- 知道的长连接有几种实现方式？
- 一个 Http 请求包含哪几部分内容？

**2.代码题**

- 设计一个 HashSet（完全不会）

**3.场景题**

- 1T 的数据怎么加载到 200M 的内存中，并且找到两行一样的数据？
- Java 打开 1T 文件，第一部操作做什么？
- 用代码打开一个文件和用鼠标打开一个文件有什么区别？
```


### 快手
#### 公司概况
快手科技（Kuaishou Technology）是一家成立于2011年、总部位于北京海淀区的中国上市科技公司（由宿华和程一笑创立）。公司主要通过同名短视频 App、社交网络及视频特效编辑工具提供服务，是中国领先的短视频与直播平台之一。在海外市场，该应用以 **Kwai** 之名运营，而在印度、巴基斯坦及印度尼西亚等地区则被称为 **Snack Video**。目前，快手已在香港联交所上市，且包含部分国有股份。

#### 公司历史
- [Wiki](https://en.wikipedia.org/wiki/Kuaishou)
##### 2011–2013：从 GIF 工具到短视频转型
* **2011年3月：** 曾在谷歌和百度工作的工程师宿华与程一笑在北京创立“GIF 快手”，最初是一款制作和分享 GIF 图片的工具。
* **2013年：** 转型为短视频社交平台，用户数迅速突破 1 亿。

##### 2014–2020：流量爆发与国际化受挫
* **2017–2018年：** 获得腾讯领投的 3.5 亿美元融资，估值达 180 亿美元。2018 年因涉及未成年妈妈等低俗内容被央视曝光并短暂下架整改。
* **2019年：** 日活用户突破 2 亿；与《人民日报》达成 AI 技术合作。
* **2020年：** 受中印边境冲突影响，海外版 Kwai 在印度被禁。

##### 2021–2023：港股上市与裁员重组
* **2021年2月：** 在**香港联交所**上市，首日股价飙升 194%，市值一度突破 1590 亿美元。
* **2021年12月：** 受监管环境及业绩压力影响，股价从巅峰下跌近 80%。公司启动大规模重组，裁员 30%，主要针对高薪中层。
* **2022年10月：** 北京广播电视台入股快手，快手正式成为部分国有的控股公司。

##### 2024–2025：AI 突破与安全危机
* **2024年4-6月：** * 媒体曝光其内部代号为“石灰石”的裁员计划，被指清退 35 岁以上高龄员工。
    * 进军巴西市场，在圣保罗建立分支中心。
    * **技术飞跃：** 发布视频生成大模型 **Kling（可灵）**，支持生成 2 分钟 1080p 视频，性能对标 OpenAI 的 Sora。
* **2025年12月：** 遭受网络攻击，导致平台短时间内涌入大量违禁暴力与色情内容。

##### 核心争议与标签

* **年龄歧视：** 内部“石灰石”计划被指针对 30 岁中后期员工进行结构性优化。
* **内容监管：** 历史上多次因低俗内容引发监管关注，并曾遭受严重的黑客攻击导致内容失控。
* **资本背景：** 拥有腾讯等头部互联网资本支持，并包含地方官方媒体的国有股份。

#### 旗下产品

* **快手/快手极速版：** 国内核心短视频与直播电商平台，以“老铁文化”和高互动率为特征。
* **Kwai / Snack Video：** 负责拉美（巴西为主）及东南亚市场的国际化拓展。
* **快影 (KwaiCut)：** 视频剪辑工具，目前是可灵（Kling）大模型的主要入口。
* **可灵 (Kling)：** 领先的 Diffusion Transformer 架构视频生成模型。
#### 招聘情况

### 米哈游
#### 公司概况
米哈游（miHoYo）是一家长安成立于 2012 年、总部位于上海的全球领先电子游戏开发商。公司以开发《原神》、《崩坏》系列、《未定事件簿》及《绝区零》等高产值、全球化运作的抽卡类（Gacha）游戏闻名，业务范围涵盖动画、小说、漫画、音乐及周边产品。凭借《原神》获得的巨大全球成功，公司于 2022 年在新加坡设立全球发行品牌 **HoYoverse**（其运营实体为 Cognosphere），负责中国大陆以外市场的全球化内容制作与发行，目前在蒙特利尔、洛杉矶、东京及首尔设有办事处。
>The letters "H" and "Y" in **miHoYo**'s name are derived from the names of two of the three founders, Cai Haoyu and Luo Yuhao. 
The letter "O" was then added because famous companies like Facebook, Google and Microsoft contain that letter. 
Since the combination "HoYo" was already registered, the prefix "mi" was prepended to the name. The prefix "mi" **was inspired by the VOCALOID software Hatsune Miku**, who was chosen due to her widespread popularity among the otaku community. 
- 这名字到底是怎么想出来的...

#### 公司历史
- [wiki](https://en.wikipedia.org/wiki/MiHoYo)
##### 2011–2012：技术宅男的宿舍创业
* **2011年：** 上海交通大学学生蔡浩宇、刘伟和罗宇皓在宿舍创立 miHoYo 工作室，核心理念为“技术宅拯救世界”。同年发布首款移动游戏 **《FlyMe2theMoon》**，主角为琪亚娜·卡斯兰娜（Kiana）。
* **2012年2月：** **上海米哈游网络科技股份有限公司**正式成立。随后发布横版射击游戏《崩坏学园》（Zombiegal Kawaii）。

##### 2013–2016：崩坏 IP 的确立
* **2014年：** **《崩坏学园2》**（Guns Girl Z）上线并走红，为公司积累了早期核心粉丝。同年启动《崩坏3》项目。
* **2016年10月：** **《崩坏3》**（Honkai Impact 3rd）发布，凭借 3D 渲染技术和极致的打击感，米哈游实现了从 2D 到 3D 的技术跨越，并开始走向亚洲市场。

##### 2017–2020：破圈与《原神》奇迹
* **2017年：** 启动开放世界项目《原神》。同年申请 A 股 IPO，因过度依赖单一 IP 等原因面临质疑。
* **2018年：** 推出官方社区 **米游社**（Miyoushe）。
* **2020年：** * 撤回 IPO 申请，保持私人控股。
    * 7月发布乙女向律政手游《未定事件簿》。
    * **9月28日：** **《原神》**（Genshin Impact）全球全平台同步上线，迅速成为全球收入最高的移动游戏之一，标志着米哈游跻身世界顶级开发商行列。

##### 2021–2024：全球化布局与多赛道并发
* **2021年：** 员工人数突破 1000 人。虚拟偶像 **鹿鸣 (Lumi)** 走红。
* **2022年2月：** 推出全球发行品牌 **HoYoverse**（新加坡运营），正式确立全球化战略。
* **2023年：** * 4月发布银河冒险回合制游戏 **《崩坏：星穹铁道》**，市场表现极佳。
    * 9月蔡浩宇卸任董事长，由刘伟接任。蔡浩宇转向北美专注于 AI 与前沿技术研究。
* **2024年7月：** 都市动作冒险游戏 **《绝区零》**（Zenless Zone Zero）全球公测。

##### 2025–2026：法律维权与 AI 深耕
* **2025年：** 米哈游通过打击内鬼（泄密者）诉讼获得约 538 万美元赔偿金。
* **2026年2月：** 在美国佐治亚州对著名内鬼 **HomDGCat** 提起诉讼，指控其非法获取并泄露未发布的测试版本内容（侵犯版权与窃取商业秘密）。
* **2026年：** 鹿鸣 (Lumi) 停止活跃，公司资源进一步向 AI 模型研究及新项目整合。


##### 核心标签与特质

* **技术驱动：** 坚持自主研发引擎技术，将 3D 卡通渲染（Cel-shading）推向行业顶尖。
* **IP 宇宙：** 围绕“崩坏”和“提瓦特”构建多媒体矩阵（动画、漫画、音乐、周边）。
* **独立性：** 极少接受外部投资（仅有一笔 100 万人民币的天使投资），由创始团队绝对控股。
* **反泄密铁腕：** 长期与“内鬼”进行法律博弈，通过 DMCA 警告和高额索赔维护商业秘密。

#### 主要产品
* **崩坏系列：** 《FlyMe2theMoon》、《崩坏学园2》、《崩坏3》、《崩坏：星穹铁道》。
* **开放世界：** 《原神》（Genshin Impact）。
* **都市/动作：** 《绝区零》（Zenless Zone Zero）。
* **女性向：** 《未定事件簿》（Tears of Themis）。
* **虚拟技术：** N0va Desktop（鹿鸣）、HoYoLAB（玩家社区）。

#### 招聘情况



### 滴滴
#### 公司概况
滴滴出行（DiDi）是一家成立于2012年、总部位于北京的全球领先移动出行科技公司，由程维创立。公司通过整合原滴滴打车与快的打车，并于2016年收购优步中国（Uber China），确立了在中国共享出行市场的统治地位，业务涵盖网约车、出租车、单车、汽车服务及自动驾驶等。尽管在2021年纽交所上市后经历了严峻的网络安全审查、退市及巨额罚款，滴滴于2023年初恢复新用户注册并重回正常运营，目前正持续深耕国内市场并积极拓展拉美等海外业务。
- 负责打车业务,中国uber
#### 公司历史
- [Wiki](https://en.wikipedia.org/wiki/DiDi)

##### 2012–2014：初创与补贴大战
* **2012年6月：** 程维在北京创立“滴滴打车”（小桔科技），最初仅提供出租车呼叫服务。随后获得腾讯 1500 万美元投资。
* **2014年：** 与阿里巴巴支持的“快的打车”展开疯狂的补贴大战，争夺刚兴起的移动出行市场入口。

##### 2015–2016：巨头合并与击退 Uber
* **2015年2月：** 滴滴打车与快的打车宣布战略合并，成立“滴滴快的”，占据国内出租车打车市场 99% 的份额。随后更名为“滴滴出行”。
* **2016年8月：** 滴滴宣布收购 **优步中国 (Uber China)**。交易完成后，Uber 获得滴滴 17.7% 的经济权益。此举标志着滴滴彻底终结了中国网约车市场的混战，确立了绝对统治地位。

##### 2017–2020：安全危机与整改
* **2017年：** 完成多轮巨额融资（包括软银、苹果投资），公司估值达到 500 亿美元。
* **2018年：** 发生两起“顺风车”乘客遇害严重安全事件。滴滴随后无限期下线顺风车业务（后逐步恢复），并投入 2000 万美元用于安全系统升级，设立 8000 人客服团队。
* **2018年：** 启动“红旗方向盘”计划，招募 1000 名党员司机以增强合规与安全性。

##### 2021–2022：监管风暴与纽交所退市
* **2021年6月30日：** 滴滴在**纽约证券交易所 (NYSE)** 挂牌上市。
* **2021年7月：** 上市仅数日，因违反《网络安全法》等法规，滴滴被国家网信办（CAC）实施网络安全审查，旗下 25 款应用被要求下架。
* **2022年6月：** 滴滴正式从纽交所退市。同年 7 月，网信办对其处以 **80.26 亿元人民币**巨额罚款。

##### 2023–至今：恢复增长与造车业务整合
* **2023年1月：** 经报网络安全审查办公室同意，滴滴恢复“新用户注册”。
* **2023年8月：** 滴滴策略性收缩造车业务。将旗下智能电动汽车（Mona 项目）及自动驾驶资产以约 7.44 亿美元对价出售给 **小鹏汽车 (XPeng)**，并成为小鹏的战略股东。
* **2024年5月：** 联合创始人**柳青 (Jean Liu)** 辞去总裁及董事职务，转任“永久合伙人”及首席人才官，公司不再设总裁职位。
* **2025–2026年：** 滴滴持续深耕海外市场（如拉美、非洲），并加速与小鹏、比亚迪在定制网约车及自动驾驶技术上的协同落地。

---

#### 旗下业务与产品板块

* **核心出行：** 滴滴快车、滴滴优享、滴滴专车、滴滴豪华车。
* **公共出行：** 滴滴出租车、滴滴公交（路线查询及定制巴士）。
* **两轮车：** 青桔单车、青桔电单车。
* **汽车服务：** 小桔能源（充电、加油）、养车、租赁及二手车。
* **自动驾驶：** **DiDi Autonomous Driving**（已与小鹏、广汽等深入合作落地 L4 级技术）。
* **海外业务：** 覆盖巴西（收购 99 平台）、墨西哥、智利、南非、日本等多个国际市场。

#### 招聘情况
### 华为
#### 公司概况
华为（Huawei）是一家成立于1987年、总部位于深圳的全球通信技术巨头，由任正非创立。公司业务涵盖电信网络基础设施、智能终端、云服务、智能汽车解决方案及光伏产品，是全球最大的电信设备制造商。尽管近年来面临严峻的美国制裁与国际准入限制，华为通过剥离荣耀品牌、自主研发鸿蒙系统（HarmonyOS）及麒麟芯片实现战略突围，2025年起重回中国智能手机市场前列。作为技术领先的“国家冠军”企业，华为正全面发力 5.5G 通信、全栈 AI 算力及汽车智能化转型。
- 真正的国家队,基岩后台,横跨手机,汽车,通信,芯片等硬件领域
#### 公司历史
- [wiki](https://en.wikipedia.org/wiki/Huawei)

#### 华为发展历史时间线 (1987–2026)

---

##### 1987–1995：初创与农村包围城市
* **1987年：** 前解放军团级干部任正非在深圳创立华为，注册资本 2.1 万人民币。初期业务为代销香港交换机（PBX）。
* **1992–1993年：** 确立“农村包围城市”战略，避开国际巨头（阿尔卡特、朗讯）直面竞争。1993 年发布 **C&C08** 数字程控交换机，打破国外垄断。
* **1994年：** 任正非提出“交换机技术关乎国家安全”观点，获得国家高层认可。

##### 1996–2009：全球扩张与技术积淀
* **1996年：** 被政府和军队确立为“国家冠军”企业，获得政策支持并限制海外竞争对手进入。
* **1997–1998年：** 开启全球扩张，从非洲和中东起步；1999 年在印度班加罗尔建立 R&D 中心。
* **2003–2007年：** 先后与 3Com（成立 H3C）、赛门铁克成立合资公司；2005 年海外合同首次超过国内销售额。
* **2009年：** 在挪威奥斯陆交付全球首个 LTE/EPC 商业网络。

##### 2010–2020：登顶全球与制裁冲击
* **2010年：** 首次入选《财富》世界 500 强。
* **2012年：** 超越爱立信成为全球最大电信设备商。
* **2018–2019年：** 美国启动制裁；CFO 孟晚舟在加拿大被拘。华为发布 **鸿蒙系统 (HarmonyOS)** 应对安卓禁令；将荣耀（Honor）品牌出售以求生存。
* **2020年Q2：** 华为手机出货量首次超越三星，登顶全球第一。

##### 2021–2024：战略突围与重回巅峰
* **2021–2022年：** 业绩因制裁大幅下滑；孟晚舟获释回国。华为加码 R&D 投入，位列全球第二。
* **2023–2024年：** 实现供应链去美化，国产零件替代成功。2024 年 Q1 利润同比增长近 6 倍；6 月宣布 **HarmonyOS** 装机量突破 9 亿台。
* **2024年：** 萝卜快跑及其他无人驾驶技术落地，华为智能汽车解决方案（华为系车型）市场爆发。

##### 2025–至今：全球合规争议与 AI 算力布局
* **2025年3–4月：** 遭遇欧洲合规危机。因涉嫌贿赂、伪造和洗钱，华为说客被禁止进入欧洲议会，欧盟委员会宣布不再会见华为相关利益代表。
* **2026年：** 保持全球 PCT 专利申请量第一（连续 8 年）。华为全栈 AI 算力集群（昇腾系列）成为中国大模型训练的核心基础设施。

---

#### 旗下公司及产品

##### 1. 终端与生态
* **智能手机：** Mate 系列（商务旗舰）、Pura 系列（原 P 系列，影像旗舰）、Nova 系列。
* **操作系统：** **HarmonyOS**（手机/全场景）、**OpenHarmony**（开源底座）、**EulerOS**（服务器）。
* **硬件：** 平板电脑（MatePad）、笔记本（MateBook）、智能穿戴及全屋智能。

##### 2. 华为智能汽车解决方案 (Huawei Inside / 鸿蒙智行)
* **问界 (AITO)：** 与赛力斯合作。
* **智界 (Luxeed)：** 与奇瑞合作。
* **享界 (Stelato)：** 与北汽合作。
* **自研技术：** 乾崑 (Qiankun) 智驾、ADS 3.0 高阶辅助驾驶、鸿蒙座舱。

##### 3. 运营商与企业业务
* **5.5G (5G-A)：** 推动 5G 向万兆速率演进。
* **华为云 (Huawei Cloud)：** 提供基础设施及盘古大模型（Pangu Models）。
* **昇腾 (Ascend) & 鲲鹏 (Kunpeng)：** 自研 AI 算力芯片及通用计算芯片。

##### 4. 其它领域
* **华为数字能源：** 智能光伏、车载充电系统。
* **海思 (HiSilicon)：** 负责核心半导体芯片设计。


#### 招聘情况
- [招聘官网](https://career.huawei.com/cn)
![示意图](PixPin_2026-04-25_21-32-03.webp)
![示意图](PixPin_2026-04-25_21-33-50.webp)
社会招聘的技术岗位基本为零...看得出来是很不缺人了,待遇真的好到大家都不愿意跳槽吗😃
### 小米

#### 公司概况
小米（Xiaomi）是一家成立于2010年、总部位于北京的全球顶尖科技巨头，由雷军及其合伙人创立。公司以智能手机、互联网物联网（IoT）平台及电动汽车为核心业务，凭借高性价比策略和独特的粉丝文化迅速崛起，2025年已稳居全球第三大智能手机厂商，并成为《财富》世界500强中最年轻的企业。通过自研的澎湃 OS（HyperOS）及庞大的生态链系统，小米构建了涵盖家电、穿戴设备及智能出行的全方位科技生态。

- 手机和汽车厂商,计算机的只招ML和硬件领域的,同样放在第二梯队
#### 公司历史
- [Wiki](https://en.wikipedia.org/wiki/Xiaomi)

##### 2010–2013：初创与“互联网手机”风暴
* **2010年4月6日：** 雷军联合林斌（原谷歌）、周光平（原摩托罗拉）等七人于北京创立小米。
* **2010年8月：** 发布基于 Android 的自研系统 **MIUI**（现已演进为 HyperOS）。
* **2011年8月：** 首款手机 **小米1** 发布，以 1999 元的颠覆性价格和“为发烧而生”的定位开启互联网手机时代。
* **2013年：** 引入谷歌副总裁 Hugo Barra 负责国际化；同年发布小米3及首款小米智能电视。

##### 2014–2020：生态链扩张与港股上市
* **2014年：** 以 360 万美元购买 **mi.com** 域名；小米成为中国市场份额第一的手机品牌，估值达 450 亿美元。
* **2015–2017年：** 经历巴西扩张受挫及国内市场调整；2017 年在印度市场超越三星夺冠；确立“小米生态链”模式，投资石头科技等初创公司。
* **2018年7月：** 在**香港联交所**正式挂牌上市。随后推出游戏手机品牌黑鲨（Black Shark）及高性价比品牌 **POCO**。
* **2020年：** 小米手机出货量升至全球第三；发布首款折叠屏手机 Mi Mix Fold。

##### 2021–2024：造车战略与高端化转型
* **2021年3月：** 雷军宣布“人生最后一次重大创业”——**投入 100 亿美元进军电动汽车领域**。同时更换由原研哉设计的“超椭圆”新 Logo。
* **2022–2023年：** 成立半导体公司芯片研发团队；与徕卡（Leica）达成影像战略合作；与华为达成 5G 等通信技术全球专利交叉许可协议。
* **2024年：** 首款电动轿车 **小米 SU7** 正式上市并交付，凭借强大的生态连接能力迅速引爆汽车市场。

##### 2025–至今：自研芯片、AI 大模型与 SUV 落地
* **2025年4-5月：** 进军大模型领域，推出 **Xiaomi MiMo**；5月正式发布自研 **3nm 工艺**手机处理器芯片 **XRING O1**，首搭于小米 15S Pro。
* **2025年6月：** 首款纯电 SUV 车型 **小米 YU7** 正式上市。
* **2025年10月：** 推出短剧应用“微观短剧”，探索内容分发新赛道。
* **2026年4月：** 发布万亿参数大语言模型 **MiMo-V2-Pro**；雷军宣布未来三年将投入至少 **87 亿美元** 深耕人工智能领域。

#### 旗下公司及产品

##### 1. 智能终端
* **手机：** 小米系列（高端/影像）、红米（Redmi，高性价比）、POCO（海外）。
* **可穿戴设备：** 小米手环、小米手表、耳机。
* **自研芯片：** 澎湃 (Surge) 系列（电源管理、影像处理）、XRING 系列（核心 SoC）。

##### 2. 小米汽车 (Xiaomi EV)
* **小米 SU7：** 纯电 C 级高性能轿车。
* **小米 YU7：** 2025 年发布的纯电 SUV。
* **核心技术：** 超级电机 (HyperEngine)、自研 CTB 电池技术、全栈自研自动驾驶系统（Deepmotion 收购支持）。

##### 3. AI 与软件生态
* **HyperOS (澎湃 OS)：** 贯穿手机、人、家、车的全生态操作系统。
* **MiMo 系列大模型：** 涵盖轻量化端侧模型及万亿参数专业模型。

##### 4. 生态链控股/参股公司
* **智米 (Smartmi)：** 空气净化器、空调等。
* **石头科技 (Roborock)：** 扫地机器人。
* **华米 (Zepp Health)：** 智能穿戴。
* **九号公司 (Segway-Ninebot)：** 平衡车、电动滑板车。
* **半导体布局：** 珠海芯试半导体、湖北小米长江产业基金投资的多家国产芯片厂商。

#### 招聘情况

### 得物
#### 公司概况
得物（Poizon）是一家成立于2015年、总部位于上海的全球领先潮流网购社区，由杨冰创立（原虎扑联合创始人）。公司最初作为潮流资讯社区起步，后通过首创“先鉴别，后发货”的购物流程，解决了球鞋及奢侈品行业的真伪痛点，确立了其在中国年轻人潮流消费市场的领导地位。业务涵盖球鞋、服装、美妆、数码以及二手交易等。

#### 公司历史
- [Wiki](https://zh.wikipedia.org/wiki/%E5%BE%97%E7%89%A9)

##### 2015–2017：社区起步与资讯积累
* **2015年7月：** 杨冰在虎扑内部孵化出“毒”App，最初定位为纯粹的潮流资讯与球鞋鉴别社区。
* **2017年：** 正式引入电商交易模式，首创“先鉴别，后发货”的商业逻辑，从资讯平台转型为闭环交易平台。

##### 2018–2019：爆发式增长与融资潮
* **2018年：** 获得红杉中国、普思资本等多轮投资，平台交易额（GMV）进入高速增长期，成为独角兽企业。
* **2019年：** 完成由 DST Global 领投的 A轮融资，估值达到 10 亿美元。平台通过“球鞋指数”及透明的交易机制，深刻影响了国内球鞋二级市场的定价体系。

##### 2020–2022：品牌升级与品类扩张
* **2020年1月：** “毒”App正式更名为“得物 (Poizon)”，旨在淡化单一的球鞋标签，向全品类潮流生活方式平台迈进。
* **2021年：** 大力拓展美妆、数码、潮玩、艺术品等非鞋类业务，并吸引超过数千家国内外知名品牌入驻开设官方旗舰店。
* **2022年：** 建立全球规模领先的查验鉴别中心，通过计算机视觉、AI 辅助与人工复核相结合，进一步提升查验效率与准确性。

##### 2023–至今：全球化布局与技术深耕
* **2023年：** 加速海外版 Poizon 的运营，通过跨境电商模式将中国潮流设计推向全球市场。
* **2024年：** 进一步强化社区内容生态，投入数亿元扶持潮流博主，强化“社交+电商”的双轮驱动模式。
* **2025–2026年：** 持续优化“鉴别实验室”技术体系，探索 AR 试穿、VR 购物等前沿交互体验，并与头部品牌深度联动开发独家限量单品。

---

#### 旗下业务与产品板块

* **核心电商：** 得物 App（涵盖球鞋、服装、箱包、配饰等全品类）。
* **技术创新：** **Poizon Lab**（专注于商品鉴别算法、3D 建模及数字水印技术）。
* **海外业务：** **Poizon Global**（覆盖北美、欧洲及东南亚市场，提供全球化的潮流消费体验）。
#### 招聘情况

##### 面经1
```md
## 题目

> 题目来源：https://www.nowcoder.com/discuss/525371909735792640

**（1）八股：**

- 生产场景下什么时候用 ArrayList ，什么时候用 LinkedList
- 创建线程的方式
- 为什么 volatile 能保证多线程可见
- 在并发量特别高的情况下是使用 synchronized 还是 ReentrantLock
- 说一下 ConcurrentHashMap 中并发安全的实现
- 你说高并发下 ReentrantLock 性能比 synchronized 高，那为什么 ConcurrentHashMap 在 JDK 1.7 中要用 ReentrantLock，而 ConcurrentHashMap 在 JDK 1.8 要用 Synchronized
- 有哪些并发安全的实现方式（简单讲了下 JUC）

**（2）场景题：**

- 不用 ThreadLocal 你会想用什么方式存用户信息
- 有千万级数据，如何判断一个整数是否存在（布隆过滤器）
- 如何理解：布隆过滤器说某个元素存在，则大概率在。布隆过滤器说某个元素不在，则一定不在
- 千万级数据用布隆过滤器初始化的时候 redis 太慢了，有没有什么好方法（RDB 的 bgsave）
- 多线程间如何传值（volatile修饰共享变量、阻塞队列、ThreadLocal）
- 如何设计登陆黑名单

**（3）手撕：面试官说看我笔试AK了，就不出手撕了**
```
### 拼多多

#### 公司概况
拼多多（Pinduoduo）是拼多多控股（PDD Holdings）旗下的核心电商平台，由黄峥于2015年在上海创立。通过开创性的“拼购”社交电商模式和对下沉市场及农产品供应链的深耕，拼多多在阿里与京东的垄断中迅速崛起，并在2020年成为中国用户规模最大的电商平台。2023年公司更名为拼多多控股，并将法律总部迁至爱尔兰都柏林，同时推出全球化平台 **Temu**。截至2026年初，凭借“C2M”模式和全球化的半托管策略，PDD Holdings 已成为全球利润率最高的零售实体之一，2025年营收突破617亿美元，其现金储备甚至一度超越阿里巴巴。
- 一家初创公司能够在非常成熟的电商领域里,在阿里和京东两大巨头的垄断下,杀出一条血路,用的手段一定**非常肮脏**
#### 公司历史
- [Wiki](https://en.wikipedia.org/wiki/PDD_Holdings)

##### 2015–2017：差异化崛起
* **2015年：** 软件工程师黄峥创立拼多多，初期深耕农业领域，在阿里与京东垄断的电商市场中通过“社交拼团”模式寻找生存空间。
* **2017年：** 凭借微信生态的病毒式传播迅速扩张，触达传统电商忽视的下沉市场和低收入群体。

##### 2018–2020：纳斯达克上市与用户增长神话
* **2018年7月：** 拼多多在**纳斯达克 (NASDAQ)** 上市。随后因假货和“山寨”产品问题遭遇中国监管部门（SAMR）调查及卖家抗议。
* **2019年：** 推出“百亿补贴”战略，试图扭转品牌形象并吸引一二线城市用户。
* **2020年：** * 疫情期间推出“多多买菜”，进军社区团购。
    * 上线“多多批发” B2B 平台。
    * **里程碑：** 年度活跃买家数达 7.88 亿，首次超越阿里巴巴成为中国用户规模最大的购物 App。

##### 2021–2023：全球化与总部迁移
* **2021年：** GMV（成交总额）达到 4.17 万亿人民币。黄峥辞任董事长。
* **2022年9月：** 姊妹公司 **Temu** 在美国上线，开启全球化扩张。
* **2023年：** PDD Holdings 将法律总部（注册地）从上海迁至**爱尔兰都柏林**。同年，主站 App 因存在利用 Android 漏洞的恶意代码风险被谷歌下架。

##### 2024–至今：合规压力与东南亚版图
* **2024年：** * 因强迫劳动质疑和知识产权盗窃指控，Temu 在美国遭遇严厉审查，多个州对其提起消费欺诈诉讼。
    * 内部“竞业协议”争议引发媒体关注，被指通过视频监控证据起诉跳槽员工。
* **2025年12月：** 启动马来西亚战役，在当地推行免运费政策，加速深耕东南亚。
* **2026年：** PDD Holdings 成为全球利润率最高的零售企业之一。


#### 核心争议与挑战

* **假货与山寨：** 长期被美国贸易代表办公室 (USTR) 列入“恶名市场”名单。尽管公司采取封店和 10 倍赔偿措施，但供应链监管压力持续存在。
* **网络安全与隐私：** 2023 年被多家国际安全机构（如卡巴斯基、CNN 访谈团队）贴上“恶意软件”标签，指控其非法获取用户文件及通知权限。
* **劳工与竞业：** 极高强度的工作节奏及针对基层员工的严苛竞业条款在行业内引发广泛争议。


#### 旗下产品

* **拼多多 (Pinduoduo)：** 国内 C2M 社交电商平台，核心竞争力在于农产品直采和低价策略。
* **Temu：** 全球化跨境电商平台，通过“全托管/半托管”模式在北美、欧洲、东南亚极速扩张。
* **多多买菜：** 高频生活服务入口，负责生鲜配送及社区自提业务。
#### 招聘情况
自己搜吧


## 总结

### 巨头分析
一步领先,步步领先,上述企业中的巨头很早就在市场的对应领域上建立了统治地位,并且屹立十年/二十年/三十年不倒,可想而知,不发生什么特别离谱的事情的话,这些巨头将会持续存在下去,并将业务越做越大,不断蚕食和合并初创公司和小型企业,就像韩国的三星那样垄断了多个特定区域/领域的市场.

而这些巨头也有自己的本钱:
1. 高投入的科研机构
2. 顶尖人才的聚集
3. 庞大的产业帝国
4. 不必打广告就人尽皆知的名气

一家初创公司如果不是瞄准某个特别刁钻的痛点,如果没有大量资金的投入,如果没有完美的运营方式,是不太可能与这些巨头抗衡的,只能在角落瑟瑟发抖.
### 内地公司分析
内地的互联网公司起步普遍比外企晚了二十年以上,比得过外企反而是不正常的.

组织架构上也都比较稚嫩,历史底蕴也不深,很多公司的领导人至今都没变过,技术积累也不多,产业链也不够庞大,不少还保留着暴发户的气质,有点强盗/小偷风范.

由于政府的支持和内地的特殊环境,内地企业能够轻松抵御巨头的外来影响,统治本土市场,但想要向外推广通常都是举步维艰的.

