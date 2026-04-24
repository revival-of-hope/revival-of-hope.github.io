---
title:  面向面试学习(一)-面试须知
categories:
  - 动态更新
tags:
  - 调研
  - 职场
date: 2026-04-23 08:00:00
image: 72471572_p0-秦こころ.webp
---


# 技术岗位概览
首先我们需要知道有哪些技术岗位
## 岗位术语
**每家公司**都有自己独特的术语,相同岗位的名字可能大不相同,我们列举~~几个~~一堆常见的术语,从而能够在看到某一个岗位名字的时候能够快速定位:

- Software Engineer(SWE): **最通用**的称呼,无论什么技术岗位都可以叫做是软件工程师,因此必须要看招聘的具体要求才好判断到底是什么岗位.
- Software Dev Engineer(SDE): **软件开发工程师**,如名字所说是负责软件开发的,至于是负责哪一部分还是要看招聘需求的
- Operations(Ops): 简称**运维**,维护系统,负责产品部署和监控
- Infrastructure(Infra): 负责搭建底层工具链,需要精通底层语言和硬件原理
- Architect: 这就是我们俗称的**架构师**,一般来说架构师都是在其他岗位历练后转调过来的,不太可能让一个实习生去架构吧.
- Site Reliability Engineering(SRE): 最早由Google提出,主要责任是管理大规模集群网络,解决系统故障,相当于**高级运维**
- **[DevOps](https://en.wikipedia.org/wiki/DevOps)**: 这鬼名字谁第一次看了不迷糊😅,不管怎样,该岗位的职责如名字所说是**开发 (Dev) + 运维 (Ops)**,需要能够一边开发软件一边负责部署上线,一看就是事最多的岗位.
- CI/CD: **Continuous Integration**,持续集成;**Continuous Delivery & Deployment**,持续部署.换句话说就是精细化的版本控制.

# 面试题分析
自然,招聘网站上的信息只是一个初步的筛查而已,大厂还需要通过面试来真正的筛查所需的雇员.
事实上,从公司面试里出的技术题能够精确的反映面试者需要学习的知识点,因此,我在此处调研了多个领域的面试题,总结出各个领域所需的知识点,如果这些知识点你想都不想就能回答出来的话,那该你拿offer.
## 计算机网络
主要考点: 老生常谈的TCP/UDP,HTTP/IP协议理解

- "**谈一谈点击一个URL链接后页面响应的全过程,越详细越好**"
  - 解答: 先在网络层之上回答,第一轮是与某个DNS服务器的DNS查询,第二轮再与真正的服务器进行TCP握手(想炫技的话可以说TLS握手,把TLS的加密过程也掺进去),经过三次握手后传回网页内容;
  - 再在网络层和链路层回答,如果使用的是以太网则讲一讲分组交换机和ARP广播,如果使用的是WiFi和5G则讲一讲无线链路.再宽泛的讲一讲路由转发.
  - 还想装逼的话就可以讲一讲如果是在局域网里,就需要通过DHCP来获取自己的动态IP地址.
  - **HTTPS有什么优点和缺点？**
  - **常用的HTTP请求方法,分别详细说明**
  - **一个 Http 请求包含哪几部分内容？**
  - 说真的,一本"自顶向下方法"就能搞定的事情真的没必要单独去破碎的吸收二手博客和总结.

## 前端(待补充)
- 由于我对前端没有任何考量,所以就先搁置了


## 后端
### C/C++
说真的,cpp特性太多了,就算都学过了,一下子被问到的时候我还是不能说的很明白.
- 基础知识
  - **谈一谈指针和引用**
    - 解答:
  - **常量指针和指针常量**
  - **谈一谈C中的malloc和Cpp中的new,delete**
  - **struct和class的区别**
  - **#include<filename.h>和#include“filename.h”有什么区别？**
  - **C语言是强类型的语言，这是什么意思？**
- 进阶知识
  - **动态库与静态库的区别**
  - **深拷贝和浅拷贝**
  - **inline,const,volatile,extern关键字的用法**
  - **左值和右值**
  - **谈一谈智能指针的用法**
  - **谈一谈常用的STL容器**
  - **C++友元的具体原理**
  - **C和C++的区别**
  - **为什么要有虚析构函数**
  - **C++中一个空类的大小为什么是1**
  - **define和typedef的区别**
  - **构造函数和析构函数的执行顺序？**
- 内存管理
  - **谈一谈cpp中的内存分配,栈,堆,静态存储区**
  - **内存泄漏,野指针,指针越界你分别是怎么处理的**
  - **谈一谈结构体中的内存对齐**
    - **一个结构体中有一个int，一个char，一个static int，问这个结构体占多少内存？**
### Python
- 基础语法
  - **yield的用法**
  - **wsgi是什么**
  - **Session,Cookie,JWT的理解**
  - **python的垃圾回收机制**
  - ***args 和 **kwargs**
  - **Python中单下划线和双下划线**
- 爬虫
  - **你用过的爬虫框架或者模块有哪些？优缺点？**
  - **怎么样让 scrapy 框架发送一个 post 请求（具体写出来）**
  - **你所知道的分布式爬虫方案有哪些？**
  - **常见的反爬虫和应对方法？**

### Java

- Java基础语法
- 垃圾回收机制
  - **Java中的内存泄露例子**
    - 解答:
- Java的反射,多线程,泛型等高级特性
  - **Java的反射是什么**
  - **谈一谈Java的线程池机制**
- 消息队列
  - **为什么使用消息队列？消息队列有什么优点和缺点？Kafka、ActiveMQ、RabbitMQ、RocketMQ 都有什么优点和缺点？**
  - **如何解决消息队列的延时以及过期失效问题？消息队列满了以后该怎么处理？有几百万消息持续积压几小时，说说怎么解决？**
  - **如果让你写一个消息队列，该如何进行架构设计啊？说一下你的思路。**
- 搜索引擎
  - **ES 的分布式架构原理能说一下么（ES 是如何实现分布式的啊）？**
  - **ES 写入数据的工作原理是什么啊？ES 查询数据的工作原理是什么啊？底层的 Lucene 介绍一下呗？倒排索引了解吗？**
  - **ES 生产集群的部署架构是什么？每个索引的数据量大概有多少？每个索引大概有多少个分片？**

### Go
- 基础语法
  - **为什么说 Go 语言字符串是不可变的？**
  - **Go 语言 map 是并发安全的吗？**
  - **Go 语言 new 和 make 关键字的区别**
  - **Goroutine调度策略**
### Android
## 数据库
事实上很多后端岗位都需要涉及跟数据库的交互,因此面试题里总会问到数据库的具体数据结构等这些知识点.
- Redis
  - **使用Redis有哪些好处**
  - **Redis性能问题都有哪些**
  - **Redis的同步机制**
  - **Redis中的底层数据结构**
  - **Redis 和 Memcached 有什么区别？Redis 的线程模型是什么？为什么单线程的 Redis 比多线程的 Memcached 效率要高得多？**
  - **Redis 集群模式的工作原理能说一下么？在集群模式下，Redis 的 key 是如何寻址的？分布式寻址都有哪些算法？了解一致性 hash 算法吗？如何动态增加和删除一个节点？**
  - **生产环境中的 Redis 是怎么部署的？**
  - **了解什么是 Redis 的雪崩、穿透和击穿？Redis 崩溃之后会怎么样？系统该如何应对这种情况？如何处理 Redis 的穿透？**
  - **使用 Redis 如何设计分布式锁？使用 Zookeeper 来设计分布式锁可以吗？以上两种分布式锁的实现方式哪种效率比较高？**
- MongoDB
  - **MongoDB的架构和优势**
- MySQL
  - **为什么MySQL使用B+树做索引？**
  - **如何实现 MySQL 的读写分离？MySQL 主从复制原理是啥？如何解决 MySQL 主从同步的延时问题？**
- 通用
  - **CRUD是哪四个词**
  - **数据库的几大范式**
  - **谈一谈B+,B,B-树,红黑树,跳表**

## 游戏开发
- 计算机图形学
- Unity
## 架构
- 微服务
  - **什么是微服务？微服务之间是如何独立通讯的？**
  - **你所知道的微服务技术栈都有哪些？**
- 数据处理
  - **如何从大量的 URL 中找出相同的 URL？**
  - **如何从 5 亿个数中找出中位数？**
    - 解答: 使用分治法不断处理二进制最高位分组,直到凑齐2.5亿个数
  - **1T 的数据怎么加载到 200M 的内存中，并且找到两行一样的数据？**
- 设计模式
  - **谈谈常见的设计模式?**
## NLP/ML/CV
这三个领域的很多知识都是掺杂在一起的,所以就放到一起了.
- **CPU和GPU 的区别？**
- **深度学习框架有哪些？各有什么特点？**
- **求解马尔科夫决策过程都有哪些方法？**

# 常见要求
## 工作经验
我们很容易看到某个岗位要求"**X年工作经验**",但是就算真这么说了,如果你有相应实力的话,还是去试试水呗,你要是能胜任这个岗位的话工作经验就没那么重要了.
[Reddit讨论](https://www.reddit.com/r/jobs/comments/3grlr6/why_the_required_years_of_experience_on_a_job/?tl=zh-hans)
## 英语能力
面外企的话,可以看看自己的英语能力在哪个档:
1. 会读和写: 基础条件,一个合格的技术人员的最低标准.
2. 会听和说: 有些岗位标明需要**流畅地**与native speaker交谈

但实际上来说只要你的面试口语不是太差,总会让你过的.

# 实战
本章通过剖析一些常见的招聘信息来说明找工作真没有那么难,**难的只是找到自己心仪的工作而已**.

**外企**
## 亚马逊
以这个[招聘信息](https://www.amazon.jobs/zh/jobs/3179483/software-dev-engineer-intern-opensearch-2026-shanghai)为例:

**描述**
职位：SDE上海
· 毕业时间：2026年10月 - 2027年7月之间毕业的应届毕业生
· 入职日期：2026年5月及之前
· 实习时间：保证一周实习4-5天全职实习，至少持续6个月
· 工作地点：上海


**基本任职资格**
- Currently enrolled in Bachelor's or Master's degree in Computer Science, Software Development, Machine Learning, Mathematics, or related majors
- Graduation date: November 2026 - July 2027
- Available for minimum 6-month internship
- Proficient in Java/Python/C++/JavaScript/TypeScript
- Solid foundation in algorithms and data structures
- Strong English reading and writing skills

**优先任职资格**
- Previous technical internship or project experience
- Experience with agent frameworks
- Experience with distributed systems, algorithms, and relational databases
- Experience in optimization mathematics (linear programming, nonlinear optimization)
- Verbal proficiency in English

因为是个实习岗,所以要求很少,但其实细致考量一下的话,会发现这个岗位其实没有任何要求,任何一个普通的计算机专业学生都可以应聘...
## 特斯拉
**职位描述**

**Full Stack Engineer (Golang/Python+React), AI**

> We're looking for a highly motivated full stack engineer specialized in backend development with desktop application experience. You will build scalable, high-performance desktop and web applications that enable agents to interact with users and automate complex workflows. The platform you build will power innovative features used by thousands of internal and external users.


**Responsibilities**
* **Design and build scalable desktop and web applications with modern frontend frameworks**
* Design and implement production-level AI agents and tool integrations
* Create end-to-end agentic workflows that enable AI agents to interact with internal system
* **Work with backend Frameworks (Go, Python) to build high performance agent system**
* Leverage AI coding tools (Cursor, Claude Code, GitHub Copilot) to accelerate development
* Work closely with product, other application team, and AI/ML teams
* Experience of AI coding assistants
* **Experience with Next.JS**
* Proficient in English, able to communicate with global team regarding solution and plan

**Requirements**
* **5+ years of strong development experience in building highly-reliable, mission-critical software**
* Degree in Computer Science, Information Systems, or the equivalent in experience
* Experience in building AI agents or LLM-powered applications
* Experience with agent frameworks, tool calling, and agent orchestration
* **Experience with backend development (Go, Python) and understanding of microservices architecture**
* **Frontend experience is a plus**
* Deep knowledge of best practices, information security, and API design principles
* Experience with gathering and building requirements from multiple stakeholders
* Go, Kubernetes, and distributed systems experience a plus

看着东西多,其实一点都不吓人,只需要看我着重的部分就可以了,可以简单总结一下要求:
1. 5年以上的Go/Python后端开发经验
2. 要会NextJs,但不用实际干过前端
3. 要会用AI工具来搭建一个好用的智能体

很显然,这个岗位不用自己训练模型,只需要调用API就行了,还能用AI开发,那不是有手就行了.
- 事实上,如果他能够在招人的时候网开一面,不死守五年工作经验的话,我都可以去了...

## 英伟达

**描述**
SAI Verification Engineer


**What you’ll be doing**:
•    Be part of NVIDIA SAI multi-national R&D team, contribute code to SAI community and Nvidia SAI implementation.
•    Design and implement robust, maintainable, and efficient automation test suite.
•    Work with continuous integration systems, regression tools, automate builds, run test suites, generate test reports, isolate and classify failures and review new degradation.
•    Work with experienced teams which are well known in the SAI community.
•    Develop high quality code, most of the code is open source and published and reviewed in industry leading open source environments.

**What we need to see**:
•    B.Sc. degree or equivalent experience in Engineering/Computer Science/related field.
•    5+ years of experience as a Software Engineer.
•    Intrinsically motivated with a desire for automation programming.
•    Strong programming skills in Python.
•    Strong technical abilities, problem solving skills, coding and design skills.
•    Ability to lead feature development, take full ownership and deliver independently.
•    Linux knowledge: have a general understanding of Linux operation system concepts.
•    C experience and extensive knowledge.
•    Ability to understand, debug and improve 3rd party complex code.
•    Excellent communication in English and leading skills.

**Ways to stand out from the crowd**:
•    Knowledge in one or more of the following Networking areas: Ethernet, VLANs, TCP/UDP/IP, QoS, L2-L3 protocols.
•    Prior software testing experience, with an understanding of Software Testing Tools and Methodologies.
•    Experience in development in Linux (user and/or kernel modes).
•    Python specialist.


要求也很简单,五年工作经验,会python,懂C语言和底层通信技术,吃苦耐劳,能够团队协作.
- 不厚道的说,我还是可以去应聘...



**内地**
## 腾讯

## 阿里