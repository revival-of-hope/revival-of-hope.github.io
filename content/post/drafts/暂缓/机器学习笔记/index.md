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
![示意图](1.webp)

- [wiki](https://en.wikipedia.org/wiki/Artificial_intelligence)
>Artificial intelligence (AI) is the capability of **computational systems** to perform tasks typically associated with human intelligence, such as learning, reasoning, problem-solving, perception, and decision-making. It is a field of research in **engineering, mathematics and computer science** that develops and studies methods and software that **enable machines** to **perceive their environment** and use learning and intelligence to **take actions that maximize their chances of achieving defined goals**.

AI的主要子领域有以下几个:
1. 学习（包括机器学习、深度学习、强化学习等子领域）
2. 感知（例如计算机视觉）
3. 自然语言处理（NLP）
4. 生成能力：生成模型与生成式人工智能
## 自然语言处理(NLP)
- [优秀的参考文章](https://transformers.run/c1/nlp/)
  - 这篇文章深入浅出的讲述了自然语言处理的前世今生,所以我这里就不再就自然语言的历史有更多的涉及了
要了解自然语言处理,首先我们需要知道[自然语言](https://en.wikipedia.org/wiki/Natural_language)是什么:

>简单来说，**自然语言**就是人类在日常生活中“自然而然”学会并使用的语言，比如汉语、英语或手语。它没有明确的设计者，而是随着人类社会的繁衍演变出来的。
* **属于自然语言**：你平时说的话、写的信，甚至是带有地方口音的方言，以及海地克里奥尔语这种由多种语言融合而成的混合语。
* **不属于自然语言**：计算机编程语言（如 Python、C++）、逻辑运算符号、虚构作品中的人造语言（如《魔戒》里的精灵语），以及动物的沟通方式（如鲸鱼叫声或蜜蜂跳舞）。
  * 也就是说图像,视频,声音处理都不是自然语言处理,其中图像和视频可以归结为计算机视觉领域;声音处理归为语音处理领域

NLP(自然语言)的全称为**Natural language processing**,经过了数十年的研究和演进,现在公认的最好处理方法就是通过深度学习中的神经网络来处理自然语言,这也就是我们所说的**神经语言模型**.

神经网络最特殊的地方在于它需要经过预训练来学习如何预测数据,换句话说,我们需要喂给神经语言模型大量的语料和数据才可以让它能够产出比较合理的结果,而当我们喂给神经语言模型的数据量增多时,神经网络的参数也需要相应增多,当模型的规模大到一定程度时,会产生"智力上的飞跃",能够惊人地根据输入得到合理的回答,这类大规模神经语言模型被称为**大语言模型**(Large Language Model,LLM).

- **直到现在也没有人能够清楚的解释**为什么模型规模增大会产生这种飞跃,但LLM仍然吸引了资本的大量流入,这是很可怕的一件事

自然,我们现在常用的AI都是大语言模型,且都是**解码器架构**,至于什么是解码器架构,后面会深入探析.
## 计算机视觉(CV)
- [wiki](https://en.wikipedia.org/wiki/Computer_vision)
CV的全称为**Computer vision**,它通过统计学模型,将摄像头获取的图像,视频或者3D数据,转化成机器可以理解的符号,从而被加工和处理,提取出我们所需的信息.
### CV的历史

#### 1960年代：从“夏季项目”起步
* **起源**：1966年，麻省理工学院（MIT）发起了一个著名的本科夏季项目，试图通过给计算机连接摄像头并让其“描述所见物”来模仿人类视觉。当时人们乐观地认为这只需一个夏天就能完成，但随后发现其复杂度远超预期。
* **目标定位**：最初作为机器人赋予智能的基石，旨在实现三维结构的提取与全场景理解。

#### 1970年代：基础算法的奠基
* **技术突破**：形成了现代 CV 算法的底层框架，包括边缘提取、线条标记、多面体建模，以及对**光流（Optical Flow）**和运动估计的初步研究。
* **逻辑核心**：侧重于从二维图像中重建三维物理世界的几何关系。

#### 1980年代：严谨数学模型的引入
* **理论深化**：引入了更复杂的数学分析，如**尺度空间（Scale-space）**概念。
* **线索推理**：研究如何从阴影（Shading）、纹理、焦点等视觉线索中推断形状（Shape from X）。
* **框架统一**：开始利用马尔可夫随机场（MRF）和正则化等数学优化框架来处理图像问题。

#### 1990年代：统计学习与摄影测量
* **三维重建**：通过相机标定和**捆集调整（Bundle Adjustment）**技术，实现了从多张图像中进行稀疏和稠密的三维场景重建。
* **图像分割**：图割算法（Graph Cut）被用于解决复杂的分割难题。
* **人脸识别**：统计学习技术首次进入实战，代表作是 **Eigenface（特征脸）**。
* **视觉与图形学融合**：全景拼接、图像变形（Morphing）等跨学科技术开始涌现。

#### 2000年代至今：特征工程与深度学习的统治
* **特征时代**：手工设计的特征算子（如 SIFT, HOG）与机器学习技术结合，通过复杂优化框架解决识别问题。
* **深度学习革命**：2012年后，以 **CNN（卷积神经网络）** 为代表的深度学习技术在分类、分割、光流预测等基准测试中全面超越传统方法。
* **现状**：深度学习赋予了 CV 极高的准确率，使其在自动驾驶、医疗诊断和人脸识别等领域实现了大规模商用落地。

## 机器学习
原先的机器学习只是想通过数学手段实现对未来数据的预测而已,谁想到它竟然成了人工智能问题的通解,直接统治了计算机视觉,自然语言处理,音频处理等多个人工智能子领域
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

- 换句话说,深度学习可以使用上述四种训练方法中的任何一种或者几种,它的主要特征是通过深层神经网络来实现**学习**,至于数据是如何处理的则与它是不是深度学习没有任何关系.

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
## 总结
如前所说,所有的人工智能子领域都被深度学习占据了,**神经网络**大行其道,所以,想要学习好人工智能,首先我们就需要理解神经网络和操纵神经网络的框架: Pytorch.

- 接下来除了有必要做说明或者解释的地方,我都会只放上经典的参考书或者论文,让能看到这篇文章的读者少走弯路,少看二手资料,少一点无意义的摸索.

# 书单
**<< Deep Learning From Scratch >>**
- 看完这本书可以轻松了解神经网络,卷积神经网络这些看似很复杂的概念,真正地入门深度学习.

