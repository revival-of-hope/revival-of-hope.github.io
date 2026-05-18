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
![alt text](PixPin_2026-05-08_21-26-18.webp)

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
![alt text](PixPin_2026-05-11_10-23-03.webp)

## ch8: 网关
网关进行协议间的转换,如"ftp转http","https转http"

![alt text](PixPin_2026-05-11_17-30-35.webp)
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

![alt text](PixPin_2026-05-17_09-22-15.webp)
- 总结的太到位了,这本书确实写的很烂.
## 绪论
本书描述的是Linux2.6.11版的内核,而现在的Linux内核版本号都到7.1了,甚至还有不少代码是由rust写的:

![alt text](PixPin_2026-05-11_23-19-18.webp)
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
![alt text](image.png)

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
![alt text](image-1.png)

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
![alt text](PixPin_2026-05-14_09-32-43.webp)

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


# 机器学习论文合集
- 大致按照年份排序,有一个先后关系
## Learning representations by back-propagating errors(1986)
- 老论文就是劲大,特别通俗,容易理解.

![alt text](PixPin_2026-05-14_17-04-17.webp)

如标题所说,这篇论文将反向传播算法引入了多层神经网络的学习,堪称深度学习领域论文的祖师爷.
## ADAM: A METHOD FOR STOCHASTIC OPTIMIZATION(2015)
![alt text](PixPin_2026-05-08_17-07-53.webp)
- 这篇2015年的论文提出了一种新的神经网络学习方法:ADAM,是两年后推出的Transformer模型的核心算法,还是很有必要了解的
- 第一次读论文,也不知道怎么读,总不至于全部复制过来再逐个翻译吧,想了想还是读完全文后做一点要点总结算了.

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
![alt text](PixPin_2026-05-10_20-09-14.webp)
通过一个简单的等比数列求和,我们发现某一时刻的梯度被缩小到了真实值的$(1 - \beta_2^t)$ 倍,所以在伪代码中我们会在计算出两个参数后对其进行误差修正.

### 4个实验
选取的实验都是非常经典的模型,而不是像某些垃圾论文一样用一些奇怪的数据集在奇怪的模型上训练.

- training cost: 指的就是损失函数值
#### LOGISTICR EGRESSION
![alt text](PixPin_2026-05-10_20-19-56.webp)
#### MULTI-LAYER NEURAL NETWORKS

![alt text](PixPin_2026-05-10_20-22-13.webp)
#### CONVOLUTIONAL NEURAL NETWORKS
![alt text](PixPin_2026-05-10_20-25-26.webp)
#### BIAS-CORRECTION TERM
![alt text](PixPin_2026-05-10_20-25-51.webp)

基本都是全方位打压以前的反向传播算法
### 结论
- 有个扩展的AdaMax算法被我忽略掉了
- 附录也被我省略了,数学不好的人是看不得这种东西的
  - ![alt text](PixPin_2026-05-10_20-28-55.webp)
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

## Attention Is All You Need(2017)
![alt text](PixPin_2026-05-10_20-31-11.webp)
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

![alt text](PixPin_2026-05-11_13-07-49.webp)

#### 编码器和解码器架构
**编码器(Encoder)**由6个完全相同的层并行组成,每个层都有两个子层:
1. 多头子注意力层,后面会详细解释
2. **position-wise fully connected feed-forward network**(前馈全连接层)

在每个子层后,都有一个正规化层
### 
## Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks(2021)
- 在Agent构建中被广泛应用的RAG概念就是这篇2021年的论文提出的
![alt text](PixPin_2026-05-13_17-49-29.webp)

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

![alt text](PixPin_2026-05-13_18-42-20.webp)
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
![alt text](PixPin_2026-05-14_16-45-54.webp)

真正做Agent的话,RAG的能力还是很有限的,它有以下弊端:
1. 企业要想真正使用RAG,就需要把开源的模型或者自己开发的模型部署好后,在每次针对特定语料库训练时进行参数上的微调,这是很麻烦的,如果不微调的话表现会更差.
   1. 况且这篇论文没怎么讲如何实现参数微调,我有理由怀疑只是把语料喂进去重新训练了而已,而非是在输出端口进行微调.
2. 鉴于大多数企业不具备自主开发优秀大模型的能力,就需要调用第三方的API,调用API的话就不能对模型做手脚,而是要对自己本地的语料进行处理,储存一个向量数据库,并在输出时进行拼接.至于怎么实现,我看也不是很成熟,不然为什么这么缺这方面的人才.






## LLaMA: Open and Efficient Foundation Language Models(2023)
![alt text](PixPin_2026-05-10_20-30-42.webp)



# 计算机体系结构: 量化研究方法
- 鉴于国内关于计算机指令设计架构的教材都太烂了,所以找了点正常的教材来读,由于国内教材还在讲老掉牙的MIPS架构,而这本书早在2017年的第六版就换成讲解RISC架构,为了应试,只好看2011年的第五版了.(如果可以的话,直接看24年出版的第七版更好)

>《计算机体系结构:量化研究方法》是最权威的计算机体系结构著作，是久负盛名的经典作品。书中系统地介绍了计算机系统的设计基础、指令集系统结构、流水线和指令集并行技术、层次化存储系统与存储设备、互连网络以及多处理器系统等重要内容

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
![alt text](image-2.png)

### Amdahl定律: 计算加速比
Amdahl定律用于计算升级某个部件/功能时获得的**加速比**,即采用升级前所用的时间与升级后所用时间的比值,从而衡量出某个部件/功能的贡献大小:

$$S_{\text{latency}} = \frac{1}{(1 - p) + \frac{p}{s}}$$

* $S_{\text{latency}}$：整个任务执行速度的理论加速比。
* $p$：任务中受益于资源改进的部分所占的时间比例（$0 \le p \le 1$）。
* $s$：受改进部分原本的性能提升倍数。

![alt text](PixPin_2026-05-16_10-25-13.webp)

### CPI: 衡量处理器的性能
所有计算机都有一个时钟周期,那么CPU执行某个任务的时间就等于**经过的周期数乘以一个时钟周期的时间**.

我们使用**每条指令的周期数**(Cycle Per Instruction,CPI)来衡量某条指令所花的时间长度:

$$\text{CPI} = \frac{\text{程序的CPU时钟周期数}}{\text{指令数}}$$

那么处理器的性能就取决于三个变量: 时钟周期,CPI,指令数.

## 存储器层次结构设计
鉴于快速存储器非常昂贵,现代计算机都使用分层的存储器结构,从而实现以下效果:
- **每字节的成本几乎与最便宜的存储器级别相同,速度几乎与最快速的级别相同**


![alt text](image-3.png)

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

![alt text](PixPin_2026-05-17_09-46-34.webp)

5. 采用多种缓存,提高缓存带宽.
   1. 将缓存划分成多个相互独立的,支持同时访问的缓存组
6. 关键字优先和提前重启动,降低缓存不命中的代价
   1. 缓存与主存交换数据的最小单位是块(Block),一个块包含多个字(word),当CPU只需要某一块其中的一个字时,缓存控制器直接跳转到对应的地址获取那个缺失的字,让CPU恢复执行后再发送该块的剩余部分
   2. 另一种实现方法,缓存保持顺序读取,实时检查当前块中是否出现了CPU需要的字,一旦出现就直接发送给CPU,再接着发送剩余部分.

7. 合并写缓冲区,降低缓存不命中的代价
   1. 为了不让CPU每次执行缓存的写入操作时都等待新数据从缓存慢慢传回内存,我们会设计一个写缓冲区,CPU将数据写入该缓冲区后继续执行,缓冲区负责将数据异步写入下级存储.
   2. 如果新写入的数据与缓冲区中某个数据属于一个块(这是非常常见的情况,因为代码和数据通常都保存在一块连续内存上),则直接将这两部分数据合并,节省写缓冲区空间

![alt text](image-4.png)

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

## 附录B: 存储器层次结构
## 附录C: 流水线
## 指令级并行
# GAME ENGINE ARCHITECTURE
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

![alt text](PixPin_2026-05-15_11-27-50.webp)
### 游戏开发全貌
![alt text](image-6.png)
## 游戏支持系统
### 子系统的启动和终止
>游戏引擎由多个互相合作的子系统结合组成,当引擎启动/终止时,需要按照一定的顺序启动/终止子系统.

如果使用C++原生的构造函数和析构函数,尽管同一文件中的构造/析构顺序是一定的,但不同文件中的构造/析构顺序是未知的,那么这就会导致子系统的构造/析构顺序发生紊乱,导致程序崩溃.

书中提出的解决方法是:不使用原生的构造函数和析构函数,改成自定义的启动管理器函数和终止管理器函数,在调用某个子系统时,直接调用其启动函数,并在终止子系统时,调用终止函数.如此一来,就可以避免原生语法带来的混乱.
### 内存管理
由于new/malloc操作符需要操作系统从用户模式切换至内核模式来进行堆分配,存在一个**上下文切换**的时间开销,一旦这类动态内存分配多了,就会极大的影响游戏的运行速度.c++类游戏引擎为了解决这个问题,通常会定制分配器来是实现内存分配

##
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

