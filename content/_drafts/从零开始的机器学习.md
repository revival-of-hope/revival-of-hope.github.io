---
title: 从零开始的机器学习
draft: true
tags:
image:
---


## Intro
事实上,我一直都想试着学习一下机器学习,但我在到今日为止总共尝试了三次,浅尝辄止,最终都不了了之.
- 第一次是大一开学后不久,我跟着一本入门书下载了anaconda,跟着学numpy,pandas这些库函数,但当时我连基本的python语法都没完全学会,调试臃肿的anaconda又极其麻烦,于是不久后就弃坑了
- 第二次是学校的一个sitp项目要求我去学一点机器学习的内容,但由于项目本身的内容我就觉得很枯燥,不对我的胃口,自然提不起多少兴趣,拿ai糊弄了一下就没后文了
- 第三次是不久前看到了"动手学深度学习-pytorch"这个github项目,但是由于这本书的逻辑性不强,基本全是内容的罗列,让我这个初学者看了就提不起兴趣,敲了几个ipynb文件后就不管了

总结一下我放弃的原因: 教材不够有深度,基础不够扎实,没有这方面的学习需求.

但现在我的条件已经具备了:线性代数和概率论方面的知识没有全部忘光;有了uv这一个方便的包管理工具,从而彻底摆脱anaconda;有了对整个计算机领域的初步了解;有一个需要用到机器学习的项目需求.
尽管说'人不能两次踏入同一条河流',也说'事不过三',但很可惜这已经是第四次了,希望我能真正的学到一些机器学习的精华.

## 人工智能(AI)的概念
尽管我们总是在说机器学习啊AI啊之类的概念,但很少会有人知道机器学习只是AI的子集之一,而AI这个概念的内涵比我们想象的要多得多.
![alt text](../images/2026-04-14/1.webp)

- [wiki](https://en.wikipedia.org/wiki/Artificial_intelligence)
>Artificial intelligence (AI) is the capability of **computational systems** to perform tasks typically associated with human intelligence, such as learning, reasoning, problem-solving, perception, and decision-making. It is a field of research in **engineering, mathematics and computer science** that develops and studies methods and software that **enable machines** to **perceive their environment** and use learning and intelligence to **take actions that maximize their chances of achieving defined goals**.

AI的主要子领域有以下几个:
1. 学习（包括机器学习、深度学习、强化学习等子领域）
2. 感知（例如计算机视觉）
3. 自然语言处理（NLP）
4. 生成能力：生成模型与生成式人工智能

## 机器学习的概念
- [wiki](https://en.wikipedia.org/wiki/Machine_learning)
>Machine learning (ML) is a field of study in artificial intelligence concerned with the development and study of statistical algorithms that can **learn from data and generalize to unseen data**, and thus perform tasks without explicit programming language instructions.
>
>Within a **subdiscipline** of machine learning, advances in the field of **deep learning** have allowed neural networks, a class of statistical algorithms, to **surpass** many previous machine learning **approaches** in performance.

- 换句话说,机器学习就是根据现有的数据来推断新数据的数学模型,而深度学习在最近十几年成为了机器学习的主流分支,实际上已经统治了整个人工智能领域

>**Statistics and mathematical optimisation** (mathematical programming) methods compose the **foundations** of machine learning. Data mining is a related field of study, focusing on exploratory data analysis (EDA) through **unsupervised learning**

## 机器学习的历史

### 1. 神经元逻辑的建立 (1940s)
机器学习的底层逻辑源于对人类认知机制的模拟。1943年，Walter Pitts 与 Warren McCulloch 建立了神经元的数学模型，试图用算法镜像人类思维。1949年，Donald Hebb 提出的赫布理论（Hebb's Rule）解释了神经元间的交互如何形成知识结构，这直接定义了现代神经网络节点间数据传递的基础机制。



### 2. 概念确立与棋类实验 (1950s)
1950年代，Arthur Samuel 开发了世界上首个国际象棋程序，该程序通过计算获胜概率来优化决策。1959年，Samuel 正式定义了“机器学习”这一术语，标志着该学科从广义的人工智能中独立出来。此时的研究重点是“自学计算机”，即让机器在没有明确编程的情况下获得能力。

### 3. 硬件尝试与模式识别 (1960s - 1970s)
这一阶段，研究从理论转向初步应用。Raytheon 公司开发的 Cybertron 机器利用原始的强化学习分析声呐和心电图信号，并引入了人工干预纠错机制（"goof" 按钮）。随后，Nils Nilsson、Duda 和 Hart 等人的著作将研究重心引向“模式分类”，奠定了机器处理图像和信号识别的工程基础。

### 4. 任务驱动与范式转移 (1980s - 1990s)
1980年代，神经网络开始具备实操价值，能够识别字母和数字。1997年，Tom Mitchell 提出了机器学习的现代操作定义：将学习过程量化为任务（T）、性能（P）和经验（E）的函数。这一转变使机器学习脱离了模糊的认知模拟，转向了严谨的数学优化和统计学评估。


### 5. 算法分化与范式重构 (2010s 至今)

现代机器学习已演化为由数据反馈机制定义的四大核心路径。没有任何单一算法能解决所有问题，研究重心已转向根据任务需求匹配相应的学习范式。

---

#### **监督学习 (Supervised Learning)**
**机制**：通过“特征向量”与“标签（监督信号）”构成的训练数据进行迭代优化。
* **核心逻辑**：学习一个将输入映射到输出的通用规则（映射函数），并能对未见过的数据做出准确预测。
* **细分任务**：
    * **分类 (Classification)**：输出受限于离散集合（如垃圾邮件过滤）。
    * **回归 (Regression)**：输出为连续数值（如气温预测）。
    * **相似性学习 (Similarity Learning)**：度量对象间的相关性，用于人脸验证及推荐系统。



#### **无监督学习 (Unsupervised Learning)**
**机制**：在无标签数据中发现隐含的结构与共性。
* **聚类 (Clustering)**：基于相似性度量将观测值划分为子集，要求簇内紧凑、簇间分离。
* **降维 (Dimensionality Reduction)**：通过主成分分析（PCA）或流形学习减少特征变量数量，将高维数据映射到低维空间。
* **自监督学习 (Self-supervised)**：现代深度学习的关键变体，通过数据自身生成监督信号。



#### **半监督学习 (Semi-supervised Learning)**
**机制**：介于上述两者之间，利用少量标注数据配合大量未标注数据。
* **核心优势**：在标注成本高昂时，通过未标注数据提升学习精度。
* **弱监督学习**：处理带有噪声或不精确标签的数据，以获取更大的有效训练集。

#### **强化学习 (Reinforcement Learning)**
**机制**：智能体（Agent）通过与动态环境交互来最大化累积奖励。
* **核心逻辑**：不依赖预设标签，而是将环境表示为马尔可夫决策过程（MDP），通过“行动-状态-奖励”的闭环反馈进行决策优化。
* **应用领域**：自动驾驶、复杂博弈（如 AlphaGo）及多智能体系统。


## 深度学习的概念
- [wiki](https://en.wikipedia.org/wiki/Deep_learning)

>In machine learning, **deep learning** (DL) focuses on utilizing multilayered **neural networks** to perform tasks such as **classification, regression, and representation learning**. The field **takes inspiration from biological neuroscience** and revolves around stacking artificial neurons into layers and "training" them to process data. The adjective "deep" refers to the use of multiple layers (ranging from three to several hundred or thousands) in the network. Methods used can be **supervised, semi-supervised or unsupervised**.
- 换句话说,深度学习可以使用上述四种范式中的任何一种或者几种,它的主要特征是通过神经网络来实现**机器的学习**,至于数据是如何处理的则与它是不是深度学习没有任何关系.

>Some common deep learning network architectures include fully connected networks, deep belief networks, recurrent neural networks, convolutional neural networks, generative adversarial networks, transformers, and neural radiance fields. These architectures have been applied to fields including **computer vision, speech recognition, natural language processing, machine translation, bioinformatics, drug design, medical image analysis, climate science, material inspection and board game programs**, where they have produced results comparable to and in some cases surpassing human expert performance.
- 如之前所说的,深度学习俨然已经统治了整个人工智能领域
## 深度学习的历史



### 1. 结构起源与早期探索 (1920s - 1960s)
* **1920s - 雏形架构**：Lenz 与 Ising 提出 Ising 模型，虽非学习算法，但构成了非学习型递归神经网络（RNN）的物理基础。
* **1958年 - 感知机 (Perceptron)**：Frank Rosenblatt 提出三层感知机，确立了输入层、隐藏层（当时不可学习）和输出层的基本结构。
* **1965年 - 首个深度学习算法**：Ivakhnenko 与 Lapa 发布 **GMDH**（多层多项式回归），这是首个能训练任意深度网络的算法，并具备原始的“门控”单元。
* **1967年 - SGD 训练**：Shun'ichi Amari 首次使用 **随机梯度下降 (SGD)** 训练出具备两层可调权重的五层多层感知机。

---

### 2. 核心组件与反向传播的建立 (1970s - 1980s)
* **1970年 - 反向传播 (Backpropagation)**：Seppo Linnainmaa 发布了现代形态的 BP 算法（基于链式法则的高效应用）。该技术在 1980 年代经 Werbos 及 Rumelhart 等人推广至神经网络领域。
* **1979年 - 卷积雏形**：福岛邦彦提出 **Neocognitron**，引入了卷积层和下采样层，奠定了计算机视觉（CV）的基础结构。
* **1980s - 递归网络演进**：Hopfield 网络（1982）使递归结构具备自适应性。随后 Jordan 网络（1986）与 Elman 网络（1990）将 RNN 引入认知心理学研究。

---

### 3. 工程化起步与长短期记忆 (1987 - 1999)
* **1987-1989年 - CNN 的工业实践**：Yann LeCun 推出 **LeNet**，成功应用于手写邮政编码识别。此后十年，CNN 处理了美国 10%~20% 的支票数字识别。
* **1991-1995年 - 梯度消失与 LSTM**：Sepp Hochreiter 发现并分析了深度网络中的 **梯度消失问题**。为解决此问题，Hochreiter 与 Schmidhuber 提出 **LSTM**（长短期记忆网络），使其能处理跨越数千步的长序列任务。
* **1991年 - 生成对抗思想**：Schmidhuber 发表了基于零和博弈的对抗神经网络。1999年，带有“忘记门”的现代 LSTM 架构定型。

---

### 4. 算力突破与深度学习革命 (2000s - 2015)
* **2006年 - 深度置信网络 (DBN)**：Hinton 提出通过限制玻尔兹曼机（RBM）逐层预训练深度网络，复兴了神经网络研究。
* **2009-2011年 - GPU 加速与超越人类**：
    * Andrew Ng 等人证明 GPU 可提速深度网络训练 70 倍。
    * Ciresan 等人的 DanNet 首次在视觉比赛中展现出**超越人类**的性能。
* **2012年 - ImageNet 爆发**：**AlexNet** 以显著优势赢得 ImageNet 竞赛，标志着深度学习革命正式开启。
* **2014-2015年 - 极深网络与 GAN**：
    * Ian Goodfellow 正式提出生成对抗网络（**GANs**）。
    * 针对超深网络训练中的退化问题，**Highway networks** 和 **ResNet**（残差网络）相继问世，使网络深度突破百层。

- [拓展阅读:ImageNet](https://zhuanlan.zhihu.com/p/564187742)
更值得去看的是李飞飞本人的自传,她实质上是深度学习的重要推动者
---

### 5. 生成式 AI 的新纪元 (2015 至今)
* **2015年 - 语音与艺术**：Google 语音搜索通过 LSTM 提升 49% 的准确率。DeepDream 与风格迁移展现了深度学习在艺术生成上的潜力。
* **2017-2022年 - 架构统治与扩散模型**：
    * **Transformer** 架构（基于注意力机制）开始统治 NLP 领域。
    * **扩散模型 (Diffusion Models)** 在 2015 年提出后，于 2022 年（DALL·E 2, Stable Diffusion）彻底超越 GAN，成为生成式 AI 的主流底层技术。

- 拓展阅读(Transformer的由来): [Attention Is All You Need](https://arxiv.org/abs/1706.03762)


## 深度学习框架简介
### Pytorch
- [wiki](https://en.wikipedia.org/wiki/PyTorch)
Pytorch是基于torch的开源深度学习框架,而torch是使用lua语言的开源深度学习框架,由于lua比较小众,故由facebook研究小组重新开发了python版本并进行了大幅度的升级,于2017年正式发布

>A number of commercial deep learning architectures are built on top of PyTorch, including **ChatGPT**,**Tesla Autopilot**, **Uber's Pyro**, Hugging Face's **Transformers**, and **Catalyst**.
### Tensorflow
- [wiki](https://en.wikipedia.org/wiki/TensorFlow)
由Google团队开发的开源深度学习框架,于2015年发布.

>TensorFlow can be used in a wide variety of programming languages, including **Python, JavaScript, C++, and Java,**facilitating its use in a range of applications in many sectors.

事实上,Pytorch现在基本在研究领域和应用广泛程度上都击败了Tensorflow,相当于后来居上,成为了行业标准.因此,我也只会学习和使用Pytorch.


- 最令人震惊的就是这些框架的发布时间距离现在也就十年,就已经让世界发生了天翻地覆的变化

## Pytorch学习
根据我先前发布的uv学习博客,可以很轻松的用uv搭建一个pytorch的学习环境,完美避开Anaconda这一个毒瘤.
- 现在我认为,`.ipynb`文件的广泛应用是**极其不合理**的,将python嵌入到文档中执行并不会真正让整个执行逻辑清晰多少,反而会造成语义上的极端割裂,并且造就了很多人学习pytorch却连python基本语法都不会的好笑现状,一个连类封装都不会的人是不应该去接触这些高深知识的.
  - 更值得一提的是大多数教程包括官方文档都还死死抱着pip不放,不愿意去接触更为先进的包管理器,从而减少初学者的学习负担
### OVERVIEW
