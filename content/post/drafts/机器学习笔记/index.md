---
title: 人工智能笔记
draft: true
tags:
image:
---

事实上,我一直都想试着学习一下人工智能,但我在到今日为止总共尝试了三次,浅尝辄止,最终都不了了之.
- 第一次是大一开学后不久,我跟着一本入门书下载了anaconda,跟着学numpy,pandas这些库函数,但当时我连基本的python语法都没完全学会,调试臃肿的anaconda又极其麻烦,于是不久后就弃坑了
- 第二次是学校的一个sitp项目要求我去学一点人工智能的内容,但由于项目本身的内容我就觉得很枯燥,不对我的胃口,自然提不起多少兴趣,拿ai糊弄了一下就没后文了
- 第三次是不久前看到了"动手学深度学习-pytorch"这个github项目,但是由于这本书的逻辑性不强,基本全是内容的罗列,让我这个初学者看了就提不起兴趣,敲了几个ipynb文件后就不管了

总结一下我放弃的原因: 教材不够有深度,基础不够扎实,没有这方面的学习需求.

但现在我的条件已经具备了:
- 线性代数和概率论方面的知识没有全部忘光;
- 有了uv这一个方便的包管理工具,从而彻底摆脱anaconda;
- 有了对整个计算机领域的初步了解;
- 想要了解一下前沿的大模型研究和算法岗究竟是做什么的.

尽管说'人不能两次踏入同一条河流',也说'事不过三',但很可惜这已经是第四次了,希望我能真正的学到一些人工智能的精华.

# 前置概念

## 人工智能(AI)的概念
尽管我们总是在说机器学习啊AI啊之类的概念,但很少会有人知道机器学习只是AI的子集之一,而AI这个概念的内涵比我们想象的要多得多.
![alt text](1.webp)

- [wiki](https://en.wikipedia.org/wiki/Artificial_intelligence)
>Artificial intelligence (AI) is the capability of **computational systems** to perform tasks typically associated with human intelligence, such as learning, reasoning, problem-solving, perception, and decision-making. It is a field of research in **engineering, mathematics and computer science** that develops and studies methods and software that **enable machines** to **perceive their environment** and use learning and intelligence to **take actions that maximize their chances of achieving defined goals**.

AI的主要子领域有以下几个:
1. 学习（包括机器学习、深度学习、强化学习等子领域）
2. 感知（例如计算机视觉）
3. 自然语言处理（NLP）
4. 生成能力：生成模型与生成式人工智能

## 机器学习
### 基本概念
- [wiki](https://en.wikipedia.org/wiki/Machine_learning)
>Machine learning (ML) is a field of study in artificial intelligence concerned with the development and study of statistical algorithms that can **learn from data and generalize to unseen data**, and thus perform tasks without explicit programming language instructions.
>
>Within a **subdiscipline** of machine learning, advances in the field of **deep learning** have allowed neural networks, a class of statistical algorithms, to **surpass** many previous machine learning **approaches** in performance.

- 换句话说,机器学习就是根据现有的数据来推断新数据的数学模型,而深度学习在最近十几年成为了机器学习的主流分支,实际上已经统治了整个人工智能领域

>**Statistics and mathematical optimisation** (mathematical programming) methods compose the **foundations** of machine learning. Data mining is a related field of study, focusing on exploratory data analysis (EDA) through **unsupervised learning**

### 机器学习的历史

#### 1943年 - 1950年代：神经元建模与逻辑奠基
* **1943年**：McCulloch和Pitts提出MCP模型，首次用简单电路模拟生物神经元逻辑运算。
* **1950年**：图灵（Alan Turing）提出“图灵测试”，定义了机器智能的判定标准。
* **1957年**：Rosenblatt发明**感知机 (Perceptron)**，这是首个具备学习能力的线性分类器硬件实现。

#### 1960年代 - 1980年代：逻辑停滞与联结主义复兴
* **1969年**：Minsky证明感知机无法解决异或（XOR）线性不可分问题，领域进入第一个寒冬。
* **1986年**：Hinton等普及**反向传播算法 (Backpropagation)**，解决了多层神经网络的权重训练难题。
* **1989年**：LeCun结合反向传播与卷积操作，发明卷积神经网络（CNN），初步实现手写数字识别。

#### 1990年代 - 2000年代初：统计学习与核方法的统治
* **1995年**：Vapnik提出**支持向量机 (SVM)**。因其严谨的数学理论（结构风险最小化）和在小样本上的优异表现，压制了神经网络近20年。
* **2001年**：Breiman提出**随机森林 (Random Forest)**，集成学习成为工业界处理结构化数据的首选。

#### 2006年 - 2012年：深度学习的突破
* **2006年**：Hinton提出逐层预训练方法，解决深层网络梯度消失问题，正式定名“深度学习”。
* **2012年**：**AlexNet**在ImageNet竞赛中以绝对优势夺冠，证明了GPU加速下深层卷积神经网络的威力。

#### 2017年 - 2023年：Transformer与大模型浪潮
* **2017年**：Google提出**Transformer**架构，引入自注意力机制（Self-Attention），取代RNN成为NLP基础架构。
* **2020年**：OpenAI发布**GPT-3**，展示了超大规模参数（1750亿）带来的零样本学习能力。
* **2022年-2023年**：ChatGPT与GPT-4发布，标志着从特定任务模型向**通用人工智能 (AGI)** 的范式转移。

#### 2024年 - 2026年：多模态与自主智能体
* **多模态融合**：模型实现文本、图像、视频、音频的统一表征与原生生成（如Sora、Gemini系列）。
* **推理与具身智能**：研究重点转向提升大模型的逻辑推理（如O1模型）以及模型与物理世界交互的具身控制能力。
### 机器学习中的训练方法
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


## 深度学习
### 基本概念
- [wiki](https://en.wikipedia.org/wiki/Deep_learning)

>In machine learning, **deep learning** (DL) focuses on utilizing multilayered **neural networks** to perform tasks such as **classification, regression, and representation learning**. The field **takes inspiration from biological neuroscience** and revolves around stacking artificial neurons into layers and "training" them to process data. The adjective "deep" refers to the use of multiple layers (ranging from three to several hundred or thousands) in the network. Methods used can be **supervised, semi-supervised or unsupervised**.

- 换句话说,深度学习可以使用上述四种训练方法中的任何一种或者几种,它的主要特征是通过神经网络来实现**机器的学习**,至于数据是如何处理的则与它是不是深度学习没有任何关系.

>Some common deep learning network architectures include fully connected networks, deep belief networks, recurrent neural networks, convolutional neural networks, generative adversarial networks, transformers, and neural radiance fields. These architectures have been applied to fields including **computer vision, speech recognition, natural language processing, machine translation, bioinformatics, drug design, medical image analysis, climate science, material inspection and board game programs**, where they have produced results comparable to and in some cases surpassing human expert performance.

- 如之前所说的,深度学习俨然已经统治了整个人工智能领域

### 深度学习框架简介
#### Pytorch
- [wiki](https://en.wikipedia.org/wiki/PyTorch)
Pytorch是基于torch的开源深度学习框架,而torch是使用lua语言的开源深度学习框架,由于lua比较小众,故由facebook研究小组重新开发了python版本并进行了大幅度的升级,于2017年正式发布

>A number of commercial deep learning architectures are built on top of PyTorch, including **ChatGPT**,**Tesla Autopilot**, **Uber's Pyro**, Hugging Face's **Transformers**, and **Catalyst**.
#### Tensorflow
- [wiki](https://en.wikipedia.org/wiki/TensorFlow)
由Google团队开发的开源深度学习框架,于2015年发布.

>TensorFlow can be used in a wide variety of programming languages, including **Python, JavaScript, C++, and Java,**facilitating its use in a range of applications in many sectors.
#### 概述
事实上,Pytorch现在基本在研究领域和应用广泛程度上都击败了Tensorflow,相当于后来居上,成为了行业标准.因此,我也只会学习和使用Pytorch.

- 最令人震惊的就是这些框架的发布时间距离现在也就十年,就已经让世界发生了天翻地覆的变化
## 自然语言处理(NLP)
NLP的全称为**Natural language processing**
# Pytorch学习
根据我先前发布的uv学习博客,可以很轻松的用uv搭建一个pytorch的学习环境,完美避开Anaconda这一个毒瘤.
- 现在我认为,`.ipynb`文件的广泛应用是**极其不合理**的,将python嵌入到文档中执行并不会真正让整个执行逻辑清晰多少,反而会造成语义上的极端割裂,并且造就了很多人学习pytorch却连python基本语法都不会的好笑现状,一个连类封装都不会的人是不应该去接触这些高深知识的.
  - 更值得一提的是大多数教程包括官方文档都还死死抱着pip不放,不愿意去接触更为先进的包管理器,从而减少初学者的学习负担

## OVERVIEW
