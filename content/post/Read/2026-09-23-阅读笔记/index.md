---
title: "阅读笔记"
date: 2026-09-23T15:03:43+08:00
description: 
image: 123579977_p0-『stroll』.webp
math: true
---

# 重构 改善既有代码的设计
## ch1: Intro
>如果你要给程序添加一个特性，但发现代码因缺乏良好的结构而不易于进行更改，那就先重构那个程序，使其比较容易添加该特性，然后再添加该特性。


>无论每次重构多么简单，养成重构后即运行测试的习惯非常重要。
犯错误是很容易的——至少我知道我是很容易犯错的。做完一次修改就运行测试，这样在我真的犯了错时，只需要考虑一个很小的改动范围，这使得查错与修复问题易如反掌。
这就是重构过程的精髓所在：小步修改，每次修改后就运行测试。如果我改动了太多东西，犯错时就可能陷入麻烦的调试，并为此耗费大把时间。小步修改，以及它带来的频繁反馈，正是防止混乱的关键。

- 这章用了巨量的篇幅来修改一个几十行的js代码,从而说明了一个良好的早期架构是有多么的重要,一旦那些架构混乱的项目开始变得复杂,就算是神仙来了也未必能够轻易看懂并重构

**关键点**: 尽可能多的使用OOP,通过多态,继承,接口来实现代码复用和类型统一;通过将复杂表达式拆分为工具函数并择合适的名字来增强代码的可读性

## ch2: 重构的原则
**重构**有两种词性,一种是动词,一种是名词:
- 重构（名词）：对软件内部结构的一种调整，目的是在不改变软件可观察行为的前提下，提高其可理解性，降低其修改成本。
- 重构（动词）：使用一系列重构手法，在不改变软件可观察行为的前提下，调整其结构。


>如果我看见一块凌乱的代码，但并不需要修改它，那么我就不需要重构它。如果丑陋的代码能被隐藏在一个 API 之下，我就可以容忍它继续保持丑陋。只有当我需要理解其工作原理时，对其进行重构才有价值。
另一种情况是，如果重写比重构还容易，就别重构了。这是个困难的决定。如果不花一点儿时间尝试，往往很难真实了解重构一块代码的难度。决定到底应该重构还是重写，需要良好的判断力与丰富的经验，我无法给出一条简单的建议。

>如果一支团队想要重构，那么每个团队成员都需要掌握重构技能，能在需要时开展重构，而不会干扰其他人的工作。这也是我鼓励持续集成的原因：有了 CI，每个成员的重构都能快速分享给其他同事，不会发生这边在调用一个接口那边却已把这个接口删掉的情况；如果一次重构会影响别人的工作，我们很快就会知道。自测试的代码也是持续集成的关键环节，所以这三大实践——自测试代码、持续集成、重构——彼此之间有着很强的协同效应。

## ch3: 代码的坏味道
需要重构的特征有以下几个:
1. 难以捉摸的命名
2. 重复的代码段
3. 函数太长: 将值得用注释说明的部分拆分成函数
4. 过长参数列表: 使用类来传入参数
5. 全局数据: 用函数或者类来封装这个全局数据,尽量控制其作用域
6. 可变数据: 如果一个数据有不同的用途,最好将它按照用途分成不同的类
7. 模块边界不清晰
8. 修改一次需要在多个地方更改
## ch4: 构筑测试体系
>确保所有测试都完全自动化，让它们检查自己的测试结果。

>频繁地运行测试。对于你正在处理的代码，与其对应的测试至少每隔几分钟就要运行一次，每天至少运行一次所有的测试。

考虑可能出错的边界条件，把测试火力集中在那儿。

>每当你收到 bug 报告，请先写一个单元测试来暴露这个 bug。


## ch6: 第一组
### 提炼函数(Extract Function)
**用例**
```js
function printOwing(invoice) {
  printBanner();
  let outstanding = calculateOutstanding();

  //print details
  console.log(`name: ${invoice.customer}`);
  console.log(`amount: ${outstanding}`);
}

function printOwing(invoice) {
  printBanner();
  let outstanding = calculateOutstanding();
  printDetails(outstanding);

  function printDetails(outstanding) {
    console.log(`name: ${invoice.customer}`);
    console.log(`amount: ${outstanding}`);
  }
}
```

>对于“何时应该把代码放进独立的函数”这个问题，我曾经听过多种不同的意见。有的观点从代码的长度考虑，认为一个函数应该能在一屏中显示。有的观点从复用的角度考虑，认为只要被用过不止一次的代码，就应该单独放进一个函数；只用过一次的代码则保持内联（inline）的状态。但我认为最合理的观点是“将意图与实现分开”：**如果你需要花时间浏览一段代码才能弄清它到底在干什么，那么就应该将其提炼到一个函数中**，并根据它所做的事为其命名。以后再读到这段代码时，你一眼就能看到函数的用途，大多数时候根本不需要关心函数如何达成其用途（这是函数体内干的事）。

>如果想要提炼的代码非常简单，例如只是一个函数调用，只要新函数的名称能够以更好的方式昭示代码意图，我还是会提炼它；但如果想不出一个更有意义的名称，这就是一个信号，可能我不应该提炼这块代码。不过，我不一定非得马上想出最好的名字，有时在提炼的过程中好的名字才会出现。有时我会提炼一个函数，尝试使用它，然后发现不太合适，再把它内联回去，这完全没问题。只要在这个过程中学到了东西，我的时间就没有白费。

- “如果需要返回的变量不止一个，又该怎么办呢？”

>有几种选择。最好的选择通常是：挑选另一块代码来提炼。我比较喜欢让每个函数都只返回一个值，所以我会安排多个函数，用以返回多个值。如果真的有必要提炼一个函数并返回多个值，可以构造并返回一个记录对象—不过通常更好的办法还是回过头来重新处理局部变量


### 内联函数（Inline Function）
>这里的内联指的是将不必要的中间层删除,从而让函数更加清晰
```js
function getRating(driver) {
 return moreThanFiveLateDeliveries(driver) ? 2 : 1;
}

function moreThanFiveLateDeliveries(driver) {
 return driver.numberOfLateDeliveries &gt; 5;
}


function getRating(driver) {
 return (driver.numberOfLateDeliveries &gt; 5) ? 2 : 1;
}
```
- 这显然与前面说的提炼函数正好相反,从而说明重构并不是一个简单的活儿,你不好判断加入函数和删除函数这两种做法哪一种会让代码更清晰

## break&总结
后面的部分都是一些具体用例了,大部分内容都需要真正去实践才能体会,所以就不建议去看了.

提炼一下本书的精华:
1. 软件的初步架构需要是合理的,工程化的,否则后期的重构难度甚至超过推翻重写
2. 重构一般是一次一小步进行的,如果你的重构会让项目暂时无法运行,说明你做的不是重构
3. 重构的方法有以下几种:
   1. 提炼/删除 函数
   2. 用类来存放函数和变量
   3. 去除不必要的全局变量
   4. 改一个好的名字
4. 重构与添加新功能可以是同时进行的


# [Transformers快速入门](https://transformers.run/c1/nlp/)
标题很具有迷惑性,事实上,这篇文章的前面几章深入浅出的讲述了大语言模型(LLM)的前世今生,让人受益匪浅
## 自然语言处理
- 这一章的介绍相当精彩,通俗易懂
>要让计算机处理自然语言，首先需要为自然语言建立数学模型，这种模型被称为语言模型（Language Model，LM）,其核心思想是判断一个文字序列是否构成人类能理解并且有意义的句子，即建模文本序列的生成概率。
### 统计语言模型
![示意图](PixPin_2026-04-15_14-04-30.webp)
- 可以看到,这里的数学原理是非常简单的,并不怎么难懂
>即使是使用三元、四元甚至是更高阶的语言模型，依然无法覆盖所有的语言现象。在自然语言中，上下文之间的关联性可能跨度非常大，例如从一个段落跨到另一个段落，这是马尔可夫假设解决不了的。此时就需要使用 LSTM、Transformer 等模型来捕获词语之间的远距离依赖（Long Distance Dependency）了。
### 神经语言模型
#### NNLM模型
![示意图](PixPin_2026-04-15_14-11-19.webp)
>具体来说，NNLM 模型首先从词表C中查询得到前面N个词语对应的词向量,然后将这些词向量拼接后输入到带有激活函数的隐藏层中，通过Softmax函数预测当前词语的概率,它不仅能够能够根据上文预测当前词语，同时还能够给出所有词语的词向量
#### Word2Vec模型
Word2Vec 的模型结构和 NNLM 基本一致，只是训练方法有所不同，分为 CBOW (Continuous Bag-of-Words) 和 Skip-gram 两种:
![示意图](PixPin_2026-04-15_14-15-26.webp)
>可以看到，与严格按照统计语言模型结构设计的 NNLM 模型不同，Word2Vec 模型在结构设计上更加自由，训练目标也更多是为获得词向量服务。特别是 CBOW 训练方法同时通过上文和下文来预测当前词语，打破了语言模型“只通过上文来预测当前词”的固定思维，为后续一系列神经网络语言模型的发展奠定了基础
### 预训练语言模型
>然而，有一片乌云始终笼罩在 Word2Vec 模型的上空——多**义词问题**。一词多义是语言灵活性和高效性的体现，但是 Word2Vec 模型却无法处理多义词，一个词语无论表达何种语义，Word2Vec 模型都只能提供相同的词向量，即将多义词编码到完全相同的参数空间。

>实际上在 20 世纪 90 年代初，雅让斯基（Yarowsky）就给出了一个简洁有效的解决方案——运用词语之间的互信息（Mutual Information）
具体来说，对于多义词，可以使用文本中与其同时出现的互信息最大的词语集合来表示不同的语义。例如对于“苹果”，当表示水果时，周围出现的一般就是“超市”、“香蕉”等词语；而表示“苹果公司”时，周围出现的一般就是“手机”、“平板”等词语
#### ELMo 模型
为了更好地解决多义词问题，2018 年研究者提出了 ELMo 模型（Embeddings from Language Models）。与 Word2Vec 模型只能提供静态词向量不同，ELMo 模型会根据上下文动态地调整词语的词向量。

但是 ELMo 模型存在两个**缺陷**：首先它使用 LSTM 模型作为编码器，而不是当时已经提出的编码能力更强的 Transformer 模型；其次 ELMo 模型直接通过拼接来融合双向抽取特征的做法也略显粗糙
#### GPT 模型
不久之后，OpenAI 将 ELMo 模型中的 LSTM 更换为 Transformer 提出了 **GPT** 模型（Generative Pre-trained Transformer）。并且 GPT 模型继续追随 NNLM 的脚步，采用仅有解码器的 Transformer 架构，只通过词语的上文进行预测。

虽然解码器架构适合于完成**自然语言生成任务**（如文本摘要），但是在一定程度上也限制了模型的应用场景，例如对于文本分类、阅读理解等任务，如果不把词语的下文信息也嵌入到词向量中就会白白丢掉很多信息。
#### BERT 模型
2018 年底，Google 基于 Transformer 模型进一步提出了 BERT 模型（Bidirectional Encoder Representations from Transformers），这一阶段神经网络语言模型的发展终于出现了一位集大成者，BERT 模型在发布时在 11 个任务上都取得了最好性能.

BERT 模型采用和 GPT 模型类似的两阶段框架，首先对语言模型进行预训练，然后通过微调来完成下游任务。但是，BERT 不仅像 GPT 模型一样采用 Transformer 作为编码器，而且采用了类似 ELMo 模型的双向语言模型结构，如图 1-11 所示。因此 BERT 模型不仅编码能力强大，而且对各种下游任务，BERT 模型都可以通过简单地改造输出部分来完成。
### 大语言模型
除了优化模型结构，研究者发现**扩大模型规模**也可以提高性能。在保持模型结构以及预训练任务基本不变的情况下，仅仅通过**扩大模型规模**就可以显著增强模型能力，尤其当规模达到一定程度时，模型甚至展现出了能够解决未见过复杂问题的涌现（Emergent Abilities）能力。例如 175B 规模的 GPT-3 模型只需要在输入中给出几个示例，就能通过上下文学习（In-context Learning）完成各种小样本（Few-Shot）任务，而这是 1.5B 规模的 GPT-2 模型无法做到的。为了区分这两代模型之间的差异，业界将大型预训练语言模型命名为“大语言模型”（Large Language Model，LLM）。

在规模扩展定律（Scaling Laws）被证明对语言模型有效之后，研究者基于 Transformer 结构不断加深模型深度，构建出了许多大语言模型
可以说，大语言模型的出现改变了自然语言处理的范式，从为特定 NLP 任务构建专用模型转变为使用单一的大型模型，通过提示或微调来处理各种语言任务，这使得复杂的语言处理更容易实现。相比早期的语言模型主要面向自然语言的建模与生成，最新的语言模型则侧重于复杂任务的求解。从语言建模到任务求解，这是人工智能科学思维的一次重要跃升。

- (26/4/15): 尽管直到现在都没人彻底搞明白为什么扩大模型规模就能实现性能的跃升,但还是有很多人都信誓旦旦的认为AI将会取代一切.
  - [Reddit讨论](https://www.reddit.com/r/ArtificialInteligence/comments/1s2z5y0/llms_wont_take_us_to_agi_and_this_paper_explains/?tl=zh-hans)
## Transformer模型
>正如第一章所述，自从 BERT 和 GPT 模型取得重大成功之后， Transformer 模型已经替代循环神经网络（RNN）、卷积神经网络（CNN）等传统神经网络结构，成为各种 NLP 模型的标配。
- 换句话说,出于工程应用的角度,不太有必要去学传统神经网络架构了
### Transformer的架构
标准 Transformer 模型主要由**编码器（Encoder）**和**解码器（Decoder）**两个模块组成
其中编码器负责接收输入并构建输入的语义表示（语义特征），从而理解输入内容，而解码器则利用编码器输出的语义表示（语义特征）以及前序输出来生成目标序列。
![示意图](PixPin_2026-04-17_11-43-43.webp)
### Transformer模型分类

* **纯编码器模型（Encoder-Only）**
    **只包含编码器部分**，采用双向语言建模，从两个方向理解上下文。适合需要深度理解文本的任务，例如文本分类、命名实体识别等，典型代表如 **BERT**。

* **纯解码器模型（Decoder-Only）**
    **只包含解码器部分**，从左到右处理文本。尤其擅长文本生成任务，可以根据提示完成句子、撰写文章，甚至生成代码，典型代表如 **GPT**、**Llama**。
  - 大多数大语言模型（LLM）都采用纯解码器架构，这些模型在过去的几年中规模和功能都得到了显著提升，一些最大的模型包含**数千亿个参数**。

* **编码器-解码器模型（Encoder-Decoder）**
    **结合了编码器和解码器**，使用编码器理解输入，解码器生成输出。擅长序列到序列任务，例如翻译、摘要、问答等，典型代表如 **T5**、**BART**。
### 大语言模型的工作原理
**推理**是指大语言模型利用训练中积累的知识，根据给定的输入提示逐字逐句地生成生成类似人类语言文本的过程。具体来说，大语言模型会按照顺序生成的方式，利用从数十亿个参数中学习到的概率来预测和生成序列中的下一个词元（Token），从而生成连贯且与上下文相关的文本。
#### 注意力的作用
注意力机制赋予大语言模型理解上下文并生成连贯响应的能力，在预测下一个词时，句子中的每个词并非都具有相同的权重。
例如，在句子“法国的首都是……”中，“法国”和“首都”这两个词对于确定下一个词是“巴黎”至关重要.

这种识别最相关词以预测下一个词元的方法已被证明非常有效。简而言之，注意力机制是语言模型能够生成既连贯又具有上下文感知能力的文本的关键，它也是使现代语言模型区别于前几代语言模型的关键

想要了解大语言模型实际能够处理多少上下文信息，就需要引出**上下文长度**，或者说模型的“注意力跨度”。**上下文长度**是指大语言模型一次可以处理的最大词元数量，这会受到模型的架构和尺寸、可用计算资源以及输入和期望输出的复杂性等多个因素的限制。

当我们向大语言模型传递信息时，会以某种方式组织输入以引导模型生成所需的输出，这被称为提示词工程（Prompting）。由于模型的主要任务就是**通过注意力机制分析每个输入词元的重要性来预测下一个词元**，因此输入序列的措辞至关重要。相比口语化的简单任务描述，精心设计的提示（Prompt）可以更容易地引导大语言模型生成符合预期的输出。
#### 两阶段推理过程
>大语言模型生成文本的过程主要分为两个阶段：**预填充（Prefill）和解码**.

预填充阶段就像烹饪中的准备阶段，所有初始食材都在此阶段进行加工和准备，该阶段包含三个关键步骤：
1. **分词（Tokenization）**：将输入文本转换为模型可以理解的基本语言单元——词元(token)。
2. **嵌入转换（Embedding Conversion）**：将词元转换为能够表示其语义的密集嵌入表示。
3. **初始处理**：将这些嵌入向量输入模型的神经网络，以深入了解上下文。

>这个阶段计算量很大，因为模型需要一次性处理完所有输入的词元，就像人类在回复消息之前，先需要阅读并理解消息中的所有文字。

预填充阶段处理完输入后，就进入实际生成文本的解码阶段。在这个阶段，模型会逐个生成词元以构建完整的输出，称之为自回归过程（每个新词元都依赖于所有先前的词元）。这一阶段包含了针对每个新词元执行的多个关键步骤：

1. 注意力计算：回顾所有先前的词元以理解上下文；
2. 概率计算：确定下一个可能出现的词元的概率；
3. 词元选择：根据这些概率选择下一个词元；
4. 持续性检查：决定是否继续或停止生成。

>此阶段会占用大量内存，因为模型需要跟踪所有先前已经生成的词元以及它们之间的关系。

#### 采样策略
在模型生成过程中，就像作家可以选择更具创意还是更精确一样，我们也可以调整模型选择词元的方式。当模型生成下一个词元时，它首先会得到词汇表中每个词的**原始概率**（称为logits），然后基于这些概率来选择下一个词元，这个过程包含以下几个步骤:
1. **原始概率**：可以将其视为模型对每个可能的下一个词的初始直觉。
2. **温度控制（Temperature Control）**：就像控制创造力的旋钮，设置较高的值（>1.0）会使选择更随机、更具创造性，而较低的值（<1.0）则会使选择更集中、更具确定性。
3. **Top-p 采样（核采样）**：不考虑所有可能的词语，而是只关注那些概率总和达到选定阈值的最可能词语（例如前 90%）。
4. **Top-k 过滤**：一种替代方法，只考虑最有可能的 k 个下一个词。

此外，大语言模型面临的一个常见挑战是重复性问题，即生成重复的内容。为了解决这个问题，通常可以采用两种惩罚机制:
1. **出现惩罚（Presence Penalty）**：对任何已出现过的词元，无论其出现频率如何都施加固定惩罚，从而防止模型重复使用相同的词；
2. **频度惩罚（Frequency Penalty）**：根据词元使用频率递增的惩罚机制，一个词出现得越多，再次被选中的可能性就越小。

>这些惩罚项会在词元选择的早期阶段就被应用，从而在其他采样策略实施之前就调整原始概率。可以被视为一种温和的引导，鼓励模型探索新的词汇。


最后，考虑到局部最优解未必是全局最优解，如果每次只是简单地选择当前最合适的词元，未必能获得全局质量最好的生成结果，因此还可以使用**束搜索（Beam search）**，同时生成多个词元序列，最后选择总体概率最高的作为最终输出:
1. 在每个步骤中，维护多个候选序列（通常为 5-10 个）。
2. 对于每个候选词，计算其成为下一个词元的概率；
3. 只保留最可能的序列和后续词元组合；
4. 重复此过程，直至达到所需长度或停止；
5. 选择总体概率最高的序列作为输出。

>束搜索通常能生成更连贯、语法更正确的文本，但需要更多的计算资源。
- 但它其实也是局部最优解,要想输出更合理的答案就可以根据之前所说的调整温度和引入惩罚机制
#### 实际挑战与优化
在实际部署大模型时，通常需要考虑以下几个关键指标：

* **首次响应时间（Time to First Token，TTFT）**：获得首次响应的时间，这主要受**预填充阶段**的影响，对于用户体验非常重要。
* **输出每词元所需时间（Time Per Output Token，TPOT）**：用户衡量生成后续词元的速度，这决定了整体生成速度。
* **吞吐量（Throughput）**：可以同时处理的请求数量。
* **显存使用情况**：GPU 显存的消耗量，这通常会成为实际应用中的主要瓶颈。

此外，有效管理上下文长度是大语言模型推理中最具挑战性的问题之一。虽然更长的上下文可以提供更多信息，但也会带来巨大的成本：**内存使用量通常随上下文长度呈二次方增长，而处理速度则通常随上下文长度呈线性下降**。例如像 Qwen2.5-1M 这样的新模型支持数百万个 token 的上下文窗口，但这也导致推理速度显著降低，因此关键在于找到适合实际场景的最佳平衡点。

>为了应对这些挑战，最有效的优化方法之一是 **KV 缓存（Key-Value Caching）**，通过存储和重用中间计算结果来提高推理速度。这项优化可以减少重复计算，从而提升生成速度，使长上下文生成成为可能。虽然代价是会占用更多内存，但性能提升通常远远超过这一成本。
## Transformer详解
- 都是latex公式,就不摘抄了
由于太过专业,因此我自己找AI通俗化了一下:
### 注意力是什么
注意力机制（Attention Mechanism）的本质是**资源的最优分配**。它让模型学会从大量信息中，筛选出对当前任务最关键的少数核心信息。

#### 1. 核心逻辑：图书馆借书
要理解注意力，最经典的模型是 **Query（查询）、Key（键）、Value（值）**。你可以将其想象成在图书馆找书：

* **Query (Q)**：你想找的东西。比如你脑子里的搜索词：“人工智能的历史”。
* **Key (K)**：书架上每本书的**标签/书名**。模型会计算你的 Query 和每一个 Key 的匹配程度（相关性）。
* **Value (V)**：书里的**具体内容**。

**操作流程：**
1.  你拿着 **Q** 去跟所有的 **K** 比对，发现《AI简史》匹配度 0.9，《高等数学》匹配度 0.1。
2.  这个匹配度就是**权重（Attention Weight）**。
3.  最后你带走的知识，就是根据权重加权后的结果：0.9 x `《AI简史》的内容` + 0.1 x `《高数》的内容`。



#### 2. 为什么需要它？（对比传统方法）

在注意力机制出现之前，机器处理信息像**吞枣**：
* **传统模型（如 RNN）**：像一个记性不太好的翻译官。读完一个长句后，他试图把所有信息压缩成一个固定长度的向量。结果就是：读到句尾，句头的信息就模糊了。
* **注意力模型**：像一个带着**荧光笔**的读者。在处理每个词时，它会瞬间扫描全句，把相关的重点划出来。

#### 3. 不同的注意力类型

* **自注意力（Self-Attention）**：自己跟自己找关系。
    * 例子：句子“**它**在马路上跑，因为**它**累了”。当处理第二个“它”时，注意力机制会高亮“跑”和“马路”，从而让模型明白这个“它”是指那个运动的物体。
* **交叉注意力（Cross-Attention）**：在两个不同序列间找关系。
    * 例子：翻译时。当准备输出英文单词 "Apple" 时，解码器会去中文原句里寻找权重最高的词——“苹果”。
### 深入理解注意力机制
Transformer 能够“一眼读完全文”且不丢失信息，主要靠的是**位置编码**和**全连接的并行架构**。

#### 1. 为什么它能“一眼读完”？
传统的 RNN 像**排队进场**，信息必须一个接一个传递，前面的信息在传递过程中会像“传声筒游戏”一样逐渐失真。

Transformer 像**航拍全景**。它利用矩阵运算，在计算的第一步就让序列中所有的词同时进入模型。
* **物理机制**：在自注意力层，每个词都会和全场所有词建立连接。从第 1 个词到第 1000 个词的距离，在矩阵里永远是 $1$。
* **无损传输**：因为不存在“中间商”传递，信息是直接从 A 点点对点触达到 B 点的。



#### 2. 既然是一眼读完，怎么知道谁先谁后？
如果只是把词丢进去，模型会觉得“我吃鱼”和“鱼吃我”是一样的。为了解决这个问题，它引入了**位置编码（Positional Encoding）**。

* **硬性叠加**：在词向量进入模型之前，会加上一个代表位置的“指纹”。这个指纹是用余弦和正弦函数生成的独特数值序列。
* **坐标系化**：这就好比给每个进场的词发了一个**带编号的座位号**。
    * “我”带上了一个“我是第1位”的属性；
    * “鱼”带上了一个“我是第3位”的属性。
* **特征融合**：模型在处理时，不仅能看到“鱼”的含义，还能感知到它携带的“第3位”这个特征。



#### 3. 为什么信息不会丢失？
信息丢失通常发生在“压缩”阶段。Transformer 采用以下手段锁定信息：

* **全连接注意力（All-to-All）**：每一个词在每一层都有机会重新审视全句。即使在第 10 层，它依然可以直接调用第 1 层输入的原始位置信息和语义信息。
* **残差连接（Residual Connection）**：这是最关键的**“保底机制”**。
    * 每一层加工完后，都会把“加工前的原始数据”直接加到“加工后的数据”上。
    * 这相当于给信息铺设了多条**高速公路**。如果某一层加工坏了，原始信息可以直接跳过加工层往后传。
### Transformer概览
Transformer 的核心逻辑是放弃了“排队处理数据”，改用**全连接矩阵并行运算**。它将语言处理变成了一个空间几何问题：通过计算词与词之间的距离和权重，捕捉语义。

---

#### 1. 输入层：数据数字化
计算机不认识文字，第一步是**向量化（Embedding）**。

* **词嵌入（Embedding）**：将每个词映射到一个高维空间的坐标（向量）。意思相近的词，坐标距离更近。
* **位置编码（Positional Encoding）**：由于 Transformer 是同时读入所有词，它无法区分语序。我们必须给每个词的向量叠加上一个“位置指纹”（通常使用正弦/余弦函数生成），让模型知道谁在谁前面。



---

#### 2. 核心机制：自注意力（Self-Attention）
这是 Transformer 的“灵魂”。它解决了**“联系”**的问题。

* **计算逻辑**：每个词都生成三个身份：**Q**（查询）、**K**（键）、**V**（值）。
* **物理过程**：
    1.  每个词拿自己的 **Q** 去跟全场所有词的 **K** 做点积，算出匹配度。
    2.  匹配度经过 Softmax 变成权重（比如 0.8、0.1...）。
    3.  根据权重去提取对应的 **V**（值）。
* **本质**：它让每个词在处理时，都能根据上下文自动聚焦到相关的词上。比如在“他过马路”中，“他”会通过注意力强力连接到语境中的具体人物。



---

#### 3. 编码器（Encoder）：特征提取
编码器由 $N$ 个相同的块堆叠而成。

* **多头机制（Multi-Head）**：并行运行多组自注意力，一组看语法，一组看逻辑，类似于多个人从不同角度审题。
* **残差连接（Residual）与归一化（Norm）**：每一层加工完都会把原始输入加回来，防止深层网络信息丢失或梯度消失。
* **前馈网络（FFN）**：对注意力提取的信息进行非线性转换，进一步强化特征。

---

#### 4. 解码器（Decoder）：序列生成
解码器负责预测下一个词，它比编码器多了两样东西：

* **掩码注意力（Masked Attention）**：训练时把后面的词遮住，强制模型只能根据已有的上文预测未来。
* **交叉注意力（Cross-Attention）**：解码器会去“盯着”编码器输出的特征矩阵。就像写作文时，一边写（解码），一边看题目要求（编码器的输出）。



---

#### 5. 输出层：概率映射
* **线性层**：将解码器的输出映射回词表大小。
* **Softmax**：将数值转换为概率。概率最高的那个词，就是模型认为的“下一个词”。

---

#### 总结：Transformer 为什么强大？
1.  **并行性**：不再像 RNN 那样一个字一个字读，大大缩短了训练时间。
2.  **长程依赖**：因为是全连接，句子开头和结尾的词距离永远是 $1$，不会遗忘。
3.  **可扩展性**：支持模型做大（Scaling Law），参数越多，学到的世界知识就越深邃。

现在的 LLM（如 GPT 系列）多采用 **Decoder-Only** 架构，即去掉了显式的编码器，让解码器自己处理输入并直接续写。
### 编码器是什么
将编码器（Encoder）想象成一个**“深度阅读理解器”**。它的任务是将一串单词，通过层层理解，翻译成机器能懂的“思想地图”。

#### 1. 零件拆解：它由什么组成？
如果把编码器比作一个加工车间，它主要有三个工位：

* **特种雷达（自注意力机制）**：每个词都在扫描全场。比如读到“苹果”这个词，雷达会看周围有没有“好吃”或者“乔布斯”。如果有“乔布斯”，它就把“苹果”理解为科技公司；如果有“好吃”，它就理解为水果。
* **多角度摄像头（多头机制）**：不只用一个雷达，而是用 8 个或更多。有的看语法，有的看语气，有的看逻辑，最后汇总。
* **深加工机床（前馈网络）**：雷达看清关系后，机床会对每个词的特征进行非线性强化，把零散的信号固定成深刻的记忆。



#### 2. 运作流程：数据是怎么走的？
1.  **打标签（位置编码）**：Transformer 是一眼看完一整行字的，为了不让它分不清词序，进门前先给每个词贴个“我是第1个”、“我是第2个”的编号。
2.  **找关系（注意力计算）**：每个词伸出无数条线连接其他词，根据关联程度分配权重。
3.  **加总与校准（残差与归一化）**：算完之后，把原始信息和加工后的信息加在一起（怕算丢了），然后把数值拉回到一个标准范围，防止网络“走火入魔”。

#### 3. 本质区别：为什么它更强？
* **RNN（老方法）**：像一个学生背课文，读了后面忘前面，且必须一个字一个字读。
* **Encoder（新方法）**：像摄影师拍全景。一眼望去，所有的词同时入画，所有的联系瞬间建立。



#### 4. 结论
编码器的最终输出不是词，而是**一组有“灵魂”的向量**。这些向量已经不再是孤立的符号，而是吸收了整句话上下文精华的特征集合。
### 解码器是什么
#### 1. 结构本质：一个“定向生成器”
如果说编码器是**理解**全文，解码器（Decoder）则是**根据理解，逐字产出**。它在编码器的基础上多了一个关键组件：**交叉注意力（Cross-Attention）**。



#### 2. 核心工作机制

* **带掩码的自注意力（Masked Self-Attention）**：
    * **物理约束**：生成时，模型不能“偷看”未来的词。
    * **实现**：通过掩码（Mask）屏蔽掉当前时刻之后的词，确保预测第 $n$ 个词时，只参考前 $n-1$ 个词。
* **交叉注意力（Cross-Attention）**：
    * **桥梁作用**：这是解码器最核心的工位。它一边看着已经生成的词，一边盯着编码器传过来的“思想地图”（特征向量）。
    * **逻辑**：它在问编码器：“根据你刚才理解的原文，我现在写到这一步了，下一步最该接哪个信息？”
* **线性层与 Softmax**：
    * 将高维向量映射到词表大小的维度，通过概率分布选出得分最高的词。

#### 3. 数据流向：从“过去”和“原文”中找答案
1.  **输入**：输入的是已经生成出来的词（起始符或前文）。
2.  **自我对齐**：通过 Masked Attention 整理已生成内容的逻辑。
3.  **吸取原文**：通过 Cross-Attention 强行去对齐原文的重点。
4.  **预测输出**：产出一个概率，选出一个词，然后把这个词再丢回输入端，循环往复。



#### 4. 通俗比喻：像是在写“命题作文”
* **编码器（出题人）**：把复杂的背景资料读完，提炼出一张写满考点的纸。
* **解码器（考生）**：
    * 他右手拿着**已经写好的半篇作文**（已生成的词）；
    * 左手按着**出题人的考点纸**（编码器输出）；
    * 他一边看左手确认别跑题，一边看右手确认逻辑连贯，最后写出下一个字。
### 新型模型架构
- 混合专家架构（Mixture-of-Experts，MoE）: 将Transformer模块中的特定前馈层替换成MoE层,即换成具有不同权重参数的**独立网络(称为专家)**,对于每次输入,选取概率最高的k个专家进行激活,然后加权输出
- 状态空间模型（State Space Model，SSM）: 试图取代Transformer模型,性能依然有差距,代表模型有RetNet,Mamba等.

## Transformer库使用

Transformers 库将目前的 NLP 任务归纳为几下几类：
* **文本分类**：例如情感分析、句子对关系判断等；
* **对文本中的词语进行分类**：例如词性标注 (POS)、命名实体识别 (NER) 等；
* **文本生成**：例如填充预设的模板 (prompt)、预测文本中被遮掩掉 (masked) 的词语；
* **从文本中抽取答案**：例如根据给定的问题从一段文本中抽取出对应的答案；
* **根据输入文本生成新的句子**：例如文本翻译、自动摘要等。

Transformers 库最基础的对象就是 pipeline() 函数，它封装了预训练模型和对应的前处理和后处理环节。我们只需输入文本，就能得到预期的答案。目前常用的 pipelines 有：
* **feature-extraction**：获得文本的向量化表示
* **fill-mask**：填充被遮盖的词、片段
* **ner**：命名实体识别
* **question-answering**：自动问答
* **sentiment-analysis**：情感分析
* **summarization**：自动摘要
* **text-generation**：文本生成
* **translation**：机器翻译
* **zero-shot-classification**：零训练样本分类

### 情感分析

## 断更原因
后面的论述和代码过于专业了,不是我现在能看得懂的,显然这并不是真正的**快速入门**.

# [Docker 从入门到实践](https://yeasy.gitbook.io/docker_practice)
比官方文档要简洁清晰的多

## Docker简介
>无论你的应用是用 Python、Java、Node.js 还是其他语言写的，无论它需要什么样的依赖库和环境，**一旦被打包成 Docker 镜像**，就可以用同样的方式在任何支持 Docker 的机器上运行.
- 也就是说,通过将依赖和软件打包在一起,我们成功实现了无缝的跨环境运行
### Docker不是虚拟机
>传统虚拟机技术是虚拟出一套完整的硬件，在其上运行一个完整的操作系统，再在该系统上运行应用
>
>而 Docker 容器内的应用直接运行于宿主的内核，容器内没有自己的内核，也没有进行硬件虚拟

### Docker历史
>Docker 最初是 dotCloud 公司创始人 Solomon Hykes 在法国期间发起的一个公司内部项目，于 2013 年 3 月以 Apache 2.0 授权协议开源

- 很难想象这么优秀的技术竟然只有十年多一点的历史

### Docker的核心优势
**环境一致性**
>Docker 镜像包含了应用运行所需的 一切：代码、运行时、系统工具、库、配置。这意味着:
1. 开发环境和生产环境完全一致
2. 不会再有 “在我机器上能跑” 的问题

**快速启动**
>传统虚拟机启动需要几分钟 (引导操作系统)，而 Docker 容器启动通常只需要 几秒甚至几百毫秒
- 当然这得要你先构建好了镜像和容器


>Docker 的核心价值可以用一句话概括：让应用的开发、测试、部署保持一致，同时极大提高资源利用效率。 笔者认为，对于现代软件开发者来说，Docker 已经不是 “要不要学” 的问题，而是 必备技能。无论你是前端、后端、运维还是全栈开发者，掌握 Docker 都能让你的工作更高效。

## 基本概念
Docker里有三个基本概念:
1. 镜像(Image): Docker 镜像是一个特殊的文件系统，除了提供容器运行时所需的程序、库、资源、配置等文件外，还包含了一些为运行时准备的一些配置参数 (如匿名卷、环境变量、用户等)。镜像不包含任何动态数据，其内容在构建之后也不会被改变。
2. 容器 (Container)：镜像 (Image) 和容器 (Container) 的关系，就像是面向对象程序设计中的 类 和 实例 一样，镜像是静态的定义，容器是镜像运行时的实体。容器可以被创建、启动、停止、删除、暂停等。
3. 仓库 (Repository)：镜像构建完成后，可以很容易的在当前宿主机上运行，但是，如果需要在其它服务器上使用这个镜像，我们就需要一个集中的存储、分发镜像的服务，Docker Registry 就是这样的服务。

### 镜像
>Docker 镜像是一个只读的模板，包含了运行应用所需的一切：代码、运行时、库、环境变量和配置文件。 如果用一个类比：镜像就像是一张光盘或 ISO 文件。你可以用同一张光盘在不同电脑上安装系统，而光盘本身不会被修改。同样，一个镜像可以创建多个容器，而镜像本身保持不变。

#### 镜像的组成部分
| 类别     | 示例                               |
| :------- | :--------------------------------- |
| 程序文件 | 应用二进制文件、Python/Node 解释器 |
| 库文件   | libc、OpenSSL、各种依赖库          |
| 配置文件 | nginx.conf、my.cnf 等              |
| 环境变量 | PATH、LANG 等预设值                |
| 元数据   | 启动命令、暴露端口、数据卷定义     |

- 镜像是只读的
- 镜像不包含动态数据
- 镜像构建后**内容不会改变**

#### 镜像的分层存储
```dockerfile
FROM ubuntu:24.04          
# 第 1 层：基础系统（约 78MB）
RUN apt-get update         
# 第 2 层：更新包索引
RUN apt-get install nginx  
# 第 3 层：安装 nginx
COPY app.conf /etc/nginx/  
# 第 4 层：复制配置文件
```
换句话说,只要某一行命令对镜像做了修改,就被docker视为单独的一个构建层,不可以被其他构建层修改,但可以与其他镜像共享

#### 镜像标识
**镜像名称和标签**
```dockerfile
## 完整格式

registry.example.com/myproject/myapp:v1.2.3

## 简写（使用 Docker Hub）

nginx:1.25
ubuntu:24.04

## 省略标签（默认使用 latest）

nginx  
# 等同于 nginx:latest
```
**镜像ID**
```bash
$ docker images
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
nginx        latest    a6bd71f48f68   2 weeks ago    187MB
ubuntu       24.04     ca2b0f26964c   3 weeks ago    78.1MB
```
**镜像摘要**
镜像摘要是基于镜像内容生成的哈希码
```bash
$ docker images --digests
REPOSITORY  TAG     DIGEST                                                                    IMAGE ID
nginx       latest  sha256:6db391d1c0cfb30588ba0bf72ea999404f2764184d8b8d10d89e8a9c6... a6bd71f48f68
```

### 容器
>容器是镜像的运行实例。如果把镜像比作程序，那么容器就是进程。 用面向对象编程的术语来说：镜像是类 (Class)，容器是对象 (Instance)。

#### 容器的本质
>笔者认为，理解这一点是理解 Docker 的关键：容器的本质是一个特殊的进程
![示意图](PixPin_2026-04-04_11-48-15.webp)

这种隔离是通过 Linux 内核的 Namespace 技术实现的。具体表现为：
- 进程空间：容器看不到宿主机上的其他进程。
- 网络：容器拥有独立的 IP、端口等网络资源
- 文件系统：容器拥有独立的 root 目录。
- 用户：容器内的 root 用户不等于宿主机的 root 用户。

#### 容器的存储层机制
当容器运行时，Docker 会在镜像的只读层之上创建一个可写层(容器存储层);

而当容器需要修改镜像层中的文件时:
1. Docker将该文件**复制**到容器存储层
2. 在容器存储层中进行修改
3. 原始镜像层**保持不变**

```bash
## 创建容器，写入数据

$ docker run -it ubuntu bash
root@abc123:/# echo "important data" > /data.txt
root@abc123:/# exit

## 删除容器

$ docker rm abc123

## 数据丢了！没有任何办法恢复！
```
既然当容器被删除后数据就全部丢失,那么容器存储层就不应该保留任何重要的信息,而是只保留运行时数据.
- 如果我们想要存储数据,可以使用数据卷(Volume)来存储数据库和应用数据,或者使用绑定到宿主机的目录.


```bash
## 使用数据卷（推荐）

$ docker run -v mydata:/var/lib/mysql mysql

## 使用绑定挂载

$ docker run -v /host/path:/container/path nginx
# 这些位置的读写会跳过容器存储层，直接写入宿主机，性能更好，也不会随容器删除而丢失
```

#### 容器的生命周期

```bash
## 创建并启动容器（最常用）

$ docker run nginx

## 分步操作

$ docker create nginx    # 创建容器（不启动）
$ docker start abc123    # 启动容器

## 停止容器

$ docker stop abc123     # 优雅停止（发送 SIGTERM，等待后发送 SIGKILL）
$ docker kill abc123     # 强制停止（直接发送 SIGKILL）

## 暂停/恢复（不常用，但有时有用）

$ docker pause abc123    # 暂停容器内所有进程
$ docker unpause abc123  # 恢复

## 删除容器

$ docker rm abc123       # 删除已停止的容器
$ docker rm -f abc123    # 强制删除运行中的容器
```
### 仓库
>**Docker Registry** 是存储和分发 Docker 镜像的服务，类似于代码的 GitHub 或包管理的 npm。

Docker Registry 中可以包含多个 Repository，每个 Repository 可以包含多个 Tag:
| 概念                  | 说明               | 示例                          |
| :-------------------- | :----------------- | :---------------------------- |
| **Registry**          | 存储镜像的服务     | Docker Hub、ghcr.io           |
| **Repository (仓库)** | 同一软件的镜像集合 | nginx、mysql、mycompany/myapp |
| **Tag (标签)**        | 仓库内的版本标识   | latest、1.25、alpine          |

一个完整的 Docker 镜像名称由 Registry 地址、用户名/组织名、仓库名和标签组成。了解其结构有助于我们更准确地定位镜像。基本格式如下：
`[registry 地址/][用户名/]仓库名[:标签]`
完整示例如下:
```bash
registry.example.com/mycompany/myapp:v1.2.3
│                    │         │     │
│                    │         │     └── 标签
│                    │         └── 仓库名
│                    └── 用户名/组织名
└── Registry 地址

## Docker Hub 官方镜像（省略 registry 和用户名）

nginx:1.25
ubuntu:24.04

## Docker Hub 用户镜像

jwilder/nginx-proxy:latest

## 其他 Registry

ghcr.io/username/myapp:v1.0
gcr.io/google-containers/pause:3.10
```
#### 公共 Registry 

Docker Hub 是最大的公共 Registry，也是 Docker 的默认 Registry,有以下特点:
1. 拥有大量官方镜像(nginx、mysql、redis)
2. 免费账户可以创建公开仓库
3. 付费账户支持私有仓库

除了 Docker Hub，还有以下几个常见的公共 Registry：
| Registry                      | 地址                       | 说明                                   |
| :---------------------------- | :------------------------- | :------------------------------------- |
| **GitHub Container Registry** | ghcr.io                    | GitHub 提供，与 GitHub Actions 集成好  |
| **Google Container Registry** | gcr.io                     | Google Cloud 提供，Kubernetes 镜像常用 |
| **Quay.io**                   | quay.io                    | Red Hat 提供                           |
| **阿里云容器镜像服务**        | registry.cn-*.aliyuncs.com | 国内访问快                             |
| **腾讯云容器镜像服务**        | ccr.ccs.tencentyun.com     | 国内访问快                             |
## 安装docker
如果是Windows端,开启WSL2后下载官方软件即可运行
如果是Linux端,尽管文章里给了一堆命令,但现在有[Dokploy](https://docs.dokploy.com/docs/core/installation)了.如果是部署在国外服务器上或者自己学习使用的话,使用Dokploy就没必要操心那么多了.
### Dokploy
支持Dokploy的目前有以下服务器厂商:
- Hostinger
- AmericanCloud
- Teramont
- Hetzner
- DigitalOcean
- Vultr
- Linode
- Scaleway
- Google Cloud
- AWS
而Dokploy目前可以在以下系统里部署:
- Ubuntu 24.04 LTS
- Ubuntu 23.10
- Ubuntu 22.04 LTS
- Ubuntu 20.04 LTS
- Ubuntu 18.04 LTS
- Debian 12
- Debian 11
- Debian 10
- Fedora 40
- Centos 9
- Centos 8

换句话说,主流的Linux操作系统现在都支持Dokploy了

>Dokploy is a stable, easy-to-use deployment solution designed to simplify the application management process. Think of Dokploy as your free self hostable alternative to platforms like Heroku, Vercel, and Netlify, **leveraging the robustness of Docker and the flexibility of Traefik**.
- Dokploy本身就是为了简化在Linux服务器部署Docker而产生的

>Dokploy utilizes Docker, so it is essential to have Docker installed on your server. If Docker is not already installed, Dokploy's installation script will install it **automatically**. 
- 甚至都不用提前安装docker,易用性可见一斑

#### 部署
**前置要求**
>To ensure a smooth experience with Dokploy, your server should have **at least 2GB of RAM and 30GB of disk space**. This specification helps to handle the resources consumed by Docker during builds and prevents system freezes.
- 官方推荐使用Hetzner的服务器来省钱

避免以下端口被占用:
1. Port 80: HTTP traffic (used by Traefik)
2. Port 443: HTTPS traffic (used by Traefik)
3. Port 3000: Dokploy web interface

我们只需要运行以下命令便可以在服务器的3000端口访问dokploy界面:
```bash
curl -sSL https://dokploy.com/install.sh | sh
```
第一次进入dokploy界面时需要我们注册管理员账户,然后就可以在面板里部署自己的docker项目了,要进一步了解的话还是去看官方文档吧.
## 使用镜像
### 获取镜像
docker pull用于从镜像仓库获取镜像:
```bash
docker pull [选项] [Registry地址/]仓库名[:标签]
```
镜像名称的标准格式如下:
```bash
docker.io / library / ubuntu : 24.04
────┬────   ───┬───   ──┬───   ──┬──
    │         │        │        │
Registry地址  用户名    仓库名    标签
 (可省略)    (可省略)
```

| 组成部分          | 说明                           | 默认值                       |
| :---------------- | :----------------------------- | :--------------------------- |
| **Registry 地址** | 镜像仓库服务的域名或 IP 地址   | `docker.io` (Docker Hub)     |
| **用户名**        | 镜像所属的用户、组织或命名空间 | `library` (官方镜像默认路径) |
| **仓库名**        | 镜像的具体名称                 | **必须指定**                 |
| **标签 (Tag)**    | 镜像的版本标识或分类标签       | `latest`                     |

**示例**
```bash
## 完整格式

$ docker pull docker.io/library/ubuntu:24.04

## 省略 Registry（默认 Docker Hub）

$ docker pull library/ubuntu:24.04

## 省略 library（官方镜像）

$ docker pull ubuntu:24.04

## 省略标签（默认 latest）

$ docker pull ubuntu

## 拉取第三方镜像

$ docker pull bitnami/redis:latest

## 从其他 Registry 拉取

$ docker pull ghcr.io/username/myapp:v1.0
```
- 镜像是分层下载的,如果本地已经有相同的层(这可以通过ID来识别),那么就会跳过该层继续下载

#### docker pull常用参数
| 选项               | 说明                                          | 示例                                       |
| :----------------- | :-------------------------------------------- | :----------------------------------------- |
| **--all-tags, -a** | 下载仓库中该镜像的所有版本标签                | `docker pull -a ubuntu`                    |
| **--platform**     | 在多架构镜像中指定运行平台（如 arm64, amd64） | `docker pull --platform linux/arm64 nginx` |
| **--quiet, -q**    | 静默模式，只输出镜像 ID，不显示拉取进度详情   | `docker pull -q nginx`                     |

### 管理镜像
#### docker image ls
**基本用法**
```bash
$ docker image ls
REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
redis        latest    5f515359c7f8   5 days ago     183MB
nginx        latest    05a60462f8ba   5 days ago     181MB
ubuntu       24.04     329ed837d508   3 days ago     78MB
ubuntu       noble     329ed837d508   3 days ago     78MB
```
| 字段           | 说明                                            |
| :------------- | :---------------------------------------------- |
| **REPOSITORY** | 镜像仓库名称                                    |
| **TAG**        | 镜像的标签（通常代表版本号）                    |
| **IMAGE ID**   | 镜像的唯一标识符（取 SHA-256 哈希值的前 12 位） |
| **CREATED**    | 镜像在构建服务器上被创建的时间                  |
| **SIZE**       | 镜像解压后在本地磁盘占用的实际空间              |

- 上面的 ubuntu:24.04 和 ubuntu:noble 拥有相同的 IMAGE ID——它们是同一个镜像的不同标签，只占用一份存储空间。

#### 查找镜像
可以根据名字来找镜像:
```bash
## 列出所有 ubuntu 镜像

$ docker images ubuntu
REPOSITORY   TAG     IMAGE ID       SIZE
ubuntu       24.04   329ed837d508   78MB
ubuntu       noble   329ed837d508   78MB
ubuntu       22.04   a1b2c3d4e5f6   72MB
```

#### 镜像删除
##### docker rmi/docker image rm
这两个命令等价,用于删除单个镜像:

**使用ID删除**
```bash
$ docker image ls
REPOSITORY   TAG     IMAGE ID       SIZE
redis        alpine  501ad78535f0   30MB
nginx        latest  e43d811ce2f4   142MB

## 只需输入足够区分的前几位

$ docker rmi 501
Untagged: redis:alpine
Deleted: sha256:501ad78535f0...
```
**使用镜像名删除**
```bash
$ docker rmi redis:alpine
Untagged: redis:alpine
Deleted: sha256:501ad78535f0...
```
- Untagged:移除镜像标签
- Deleted: 删除镜像的存储层

##### docker image prune
```bash
## 查看虚悬镜像

$ docker images -f dangling=true

$ docker image prune
# 不带参数,默认只删除悬空镜像

## 不提示确认

$ docker image prune -f

## 删除所有没有被容器使用的镜像

$ docker image prune -a

## 保留最近 24 小时的

$ docker image prune -a --filter "until=24h"
```
- 虚悬镜像 (dangling)：没有标签且未被容器引用的镜像，通常是旧版本被新版本覆盖后产生的



## 操作容器

### 启动容器
>由于 Docker 容器非常轻量，实际使用中常常是随时删除和新建容器，而不是反复重启同一个容器。

**基本语法**
```bash
docker run [选项] 镜像 [命令] [参数...]
```


**基本例子**
```bash
$ docker run ubuntu:24.04 /bin/echo 'Hello world'
Hello world
```

**基础选项**
| 选项     | 说明                   | 示例                             |
| :------- | :--------------------- | :------------------------------- |
| `-d`     | 后台运行容器（detach） | `docker run -d nginx`            |
| `-it`    | 分配交互式终端         | `docker run -it ubuntu bash`     |
| `--name` | 为容器指定自定义名称   | `docker run --name myapp nginx`  |
| `--rm`   | 容器退出后自动删除     | `docker run --rm ubuntu echo hi` |

**端口映射**
```bash
## 将容器的 80 端口映射到宿主机的 8080 端口

$ docker run -d -p 8080:80 nginx

## 随机映射端口

$ docker run -d -P nginx

## 只绑定到 localhost

$ docker run -d -p 127.0.0.1:8080:80 nginx
```
### 运行容器
>当你在终端运行一个程序时，有两种模式：
>>前台运行：程序占用当前终端，输出直接显示，关闭终端程序就停止
>>后台运行：程序在后台执行，不占用终端，终端关闭也不影响程序
>Docker 容器默认是 前台运行 的。使用 -d (detach) 参数可以让容器在后台运行

**前台运行**
```bash
$ docker run ubuntu:24.04 /bin/sh -c "while true; do echo hello world; sleep 1; done"
hello world
hello world
hello world
hello world
```
>容器会把输出的结果 (STDOUT) 打印到宿主机上面。此时：

1. 终端被占用，无法执行其他命令
2. 按 Ctrl+C 会终止容器
3. 关闭终端窗口，容器也会停止

**后台运行**
```bash
$ docker run -d ubuntu:24.04 /bin/sh -c "while true; do echo hello world; sleep 1; done"
77b2dc01fe0f3f1265df143181e7b9af5e05279a884f4776ee75350ea9d8017a
```
使用 -d 参数后：

1. 容器在后台运行
2. 返回容器的完整 ID
3. 终端立即释放，可以继续执行其他命令
4. 输出不会直接显示 (需要用 docker logs 查看)

### 终止容器
终止容器有三种方式：
| 方式     | 命令          | 说明                               |
| :------- | :------------ | :--------------------------------- |
| 优雅停止 | `docker stop` | 先发 `SIGTERM`，超时后发 `SIGKILL` |
| 强制停止 | `docker kill` | 直接发送 `SIGKILL` 信号            |
| 自动终止 | -             | 容器主进程退出时自动停止           |

我们还可以在镜像被修改后重启容器
```bash
## 先停止再启动

$ docker restart 容器名

## 自定义停止超时

$ docker restart -t 30 容器名
```

### 删除容器
>随着容器的创建和停止，系统中会积累大量的容器。

使用 docker rm 删除已停止的容器：
```bash
$ docker rm 容器名或ID
```
- 该命令与docker container rm等效

使用 docker container prune 批量删除:
```bash
## 方式一：使用 prune 命令（推荐）

$ docker container prune

WARNING! This will remove all stopped containers.
Are you sure you want to continue? [y/N] y
Deleted Containers:
abc123...
def456...
Total reclaimed space: 150MB

## 方式二：不提示确认

$ docker container prune -f
```



## 补充部分: 镜像的文件结构
非常离谱的是,这么详细的文档偏偏没有提到这一点: 镜像内部是怎么存放文件的?
自然,镜像是分层构建存储的,但是这些构建层显然要有个地方放吧.

镜像的**默认工作目录是根目录**,类似于Linux的根目录,当我们需要切换存储目录或者启动某个目录下的脚本时,,可以显式指明,比如说以下的几个命令:
```dockerfile
## 复制文件到指定目录

COPY package.json /app/

## 复制文件并重命名

COPY config.json /app/settings.json
```
- 如此一来,我们成功的将本地文件复制到了app文件夹中.

因此,镜像不仅仅是一个iso,我们可以把它抽象成一个文件系统,存储层堆叠在不同的目录中,可以来回切换访问.



## dockerfile编写

### 概览
>Dockerfile 是一个文本文件，其内包含了一条条的 指令 (Instruction)，每一条指令构建一层，因此每一条指令的内容，就是描述该层应当如何构建。

Dockerfile**不是脚本，而是镜像的"设计图"**。这个区别决定了你如何思考每条指令的作用:
* **合并命令**：应将 `RUN apt-get update && apt-get install -y ...` 写入同一个 `RUN` 指令中,因为它们是同一层的逻辑
* **优化镜像大小**：最后才清理缓存、删除临时文件，让这些"瘦身"操作在同一层完成

### (补充)FROM: 基础镜像
很多时候我们都需要在官方镜像的基础上进行构建,这个时候我们可以这么写:
```dockerfile
FROM node:20-alpine AS deps
# 在这个基础上进行构建
```
这个AS与python中的as一样,都是为导入的镜像重新设一个名字.

- 事实上,如果你不写任何FROM,根本无法运行任何Linux命令

而FROM命令最厉害的地方在于,每一个FROM指令都会重新开辟一个新的文件系统,取代之前的所有内容.
因此,我们可以这么写:
```dockerfile
# 第一阶段：编译环境（命名为 builder）
FROM golang:1.21 AS builder
WORKDIR /app
COPY . .
RUN go build -o myapp main.go  # 物理产生了几百 MB 的编译器和缓存

# 第二阶段：运行环境（最小化镜像）
FROM alpine:latest
WORKDIR /root/
# 物理核心：通过 --from=builder 只从 builder 阶段拷贝最终的可执行二进制文件
COPY --from=builder /app/myapp . 
CMD ["./myapp"]
```
这样既可以利用上一个阶段的构建内容,又不会将多余的内容打包进镜像
### RUN: 执行命令
RUN 是 Dockerfile 中最常用的指令，主要用于在镜像构建阶段执行命令来修改镜像,有以下几个应用场景:
- 安装依赖：`RUN apt-get install nginx`
- 编译程序：`RUN gcc -o app main.c`
- 下载文件：`RUN curl -O https://example.com/file.tar.gz`
- 配置系统：`RUN mkdir -p /app/data`

>理解 RUN 的核心是理解镜像分层：每一个 RUN 都会在当前层之上创建新的一层，这会影响镜像大小。因此，合理使用 RUN（特别是合并多个 RUN）是构建轻量级镜像的关键。

#### 基本语法
有两种格式:
```dockerfile
RUN <command>
RUN ["executable", "param1", "param2"]
```
**shell格式**
```dockerfile
RUN apt-get update
```
- 默认通过 /bin/sh -c 执行。
- 可以使用环境变量、管道、重定向等 Shell 特性。

**exec格式**
```dockerfile
RUN ["apt-get", "update"]
```
- 直接调用可执行文件，不经过 Shell。
- 无法使用 $VAR 环境变量替换 (除非显式调用 shell)

#### 实战
由于每一个 RUN 指令都会新建一层镜像。为了减少镜像体积和层数，应使用 && 连接命令:
```dockerfile
# 糟糕的写法(3层)
RUN apt-get update
RUN apt-get install -y nginx
RUN rm -rf /var/lib/apt/lists/*
# 推荐写法
RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*
```
- 可以看到dockerfile将\用于换行,这与makefile的写法一致

### COPY: 复制文件
COPY 是在构建镜像时，将构建上下文（Dockerfile 所在目录及其子目录）中的文件或目录**复制到镜像内**的指令。它是处理应用代码、配置文件最常用的方式,应用场景如下:
* `COPY . /app` (应用源码)
* `COPY nginx.conf /etc/nginx/nginx.conf` (配置文件)
* `COPY public /app/public`(静态资源)


#### 基本语法
```dockerfile
COPY [选项] <源路径>... <目标路径>
COPY [选项] ["<源路径1>", "<源路径2>", ... "<目标路径>"]
```

**复制文件**
```dockerfile
## 复制文件到指定目录

COPY package.json /app/

## 复制文件并重命名

COPY config.json /app/settings.json

## 复制多个指定文件

COPY package.json package-lock.json /app/

## 使用通配符

COPY *.json /app/
COPY src/*.js /app/src/
```
**复制目录**
```dockerfile
## 复制整个目录的内容（不是目录本身）

COPY src/ /app/src/

# 构建上下文：              镜像内：
# src/                     /app/src/
# ├── index.js      →      ├── index.js
# └── utils.js             └── utils.js
```

#### 指定路径
```dockerfile
# 绝对路径

COPY app.js /usr/src/app/

# 相对路径：基于 WORKDIR

WORKDIR /app
COPY package.json ./        # 复制到 /app/package.json
COPY src/ ./src/            # 复制到 /app/src/

# 如果目标目录不存在，Docker 会自动创建：

## /app/config/ 不存在也会自动创建
COPY settings.json /app/config/
```

#### dockerignore
排除不需要复制的文件,精简镜像体积
```gitignore
## .dockerignore

node_modules
.git
.env
*.log
Dockerfile
.dockerignore
```

#### 实战
```dockerfile
## ✅ 好：先复制依赖定义，再安装，最后复制代码

COPY package.json package-lock.json ./
RUN npm install
COPY . .

## ❌ 差：一次性复制所有文件，代码变更会导致重新 npm install

COPY . .
RUN npm install
```
详细解释一下,docker构建镜像是线性操作的,只有COPY,RUN,ADD三种命令会创建新的存储层,而每次构建时docker都会在本地存储缓存,如果下一次构建镜像时对应的命令没有变化,则会直接复用原来的缓存,不会重新构建;当docker发现COPY的文件内容有改动时,该行之后的所有命令被视为与原缓存不同,需要重新构建.

因此,如果直接写`COPY . .`的话,修改任何一个文件后构建镜像都要重新运行npm install;但如果把`COPY . .`放在后面,只会在package.json变化时重新构建.

### ADD: 更高级的COPY

>实践中的建议：除非你明确需要自动解压功能（比如官方基础镜像构建根文件系统），否则始终使用 COPY。原因很简单——显式优于隐式。你的 Dockerfile 在 6 个月后被接手维护时，清晰的意图会让团队少走很多弯路。

#### 基本用法
```dockerfile
ADD [选项] <源路径>... <目标路径>
ADD [选项] ["<源路径>", ... "<目标路径>"]
```

ADD 在 COPY 基础上增加了两个功能：

1. 自动解压 tar 压缩包
2. 支持从 URL 下载文件 (不推荐)


### CMD: 容器启动命令(4/10)
在深入 CMD 的细节之前，我们需要理解一个关键问题：CMD 和 ENTRYPOINT 应该在什么时候使用？

这是 Dockerfile 使用中最常见的困惑之一。简单的答案是：
1. CMD：定义容器的”默认命令”。如果用户在 docker run 时提供命令，CMD 会被覆盖
2. ENTRYPOINT：定义容器的”入口脚本”。通常用于启动应用的某个特定部分



#### 基本用法
CMD指令用于指定容器启动时默认执行的命令。它定义了容器的 “主进程”。


| 格式类型       | 语法示例                                 | 推荐程度       | 核心机制                                                     |
| :------------- | :--------------------------------------- | :------------- | :----------------------------------------------------------- |
| **Exec 格式**  | `CMD ["executable", "param1", "param2"]` | ✅ **推荐**     | 直接由内核执行，PID 为 1，可接收 `SIGTERM` 信号。            |
| **Shell 格式** | `CMD command param1 param2`              | ⚠️ **简单场景** | 通过 `/bin/sh -c` 调用，无法直接接收信号，环境变量会被解析。 |
| **参数格式**   | `CMD ["param1", "param2"]`               | ⚓ **配合使用** | 仅作为 `ENTRYPOINT` 的默认参数传递。                         |

**exec 格式**
```dockerfile
CMD ["nginx", "-g", "daemon off;"]
CMD ["python", "app.py"]
CMD ["node", "server.js"]
```

**shell格式**
```dockerfile
CMD echo "Hello World"
CMD nginx -g "daemon off;"
```

实际执行：会被包装为 sh -c
```dockerfile
## 你写的

CMD echo $HOME

## 实际执行的

CMD ["sh", "-c", "echo $HOME"]
```
- 换句话说shell写法实际上是使用了sh的exec简写格式.

#### CMD命令只能写一个
多个CMD只有最后一个生效.
因为CMD的PID为1,意思是在Linux内核中它作为根进程,是独一无二的.因此CMD一旦停止,容器就关闭了.

### ENTRYPOINT: 入口点(4/11)
>如果说 CMD 是"容器中的默认程序"，那么 ENTRYPOINT 就是"把容器变成一个命令"。这个思维转变决定了你何时使用 ENTRYPOINT。

#### 是什么,怎么用
ENTRYPOINT 指定容器启动时运行的入口程序。与 CMD 不同，ENTRYPOINT 定义的命令不会被 `docker run` 的参数覆盖，而是 接收这些参数。

**基本语法**
```dockerfile
## exec 格式（推荐）

ENTRYPOINT ["nginx", "-g", "daemon off;"]

## shell 格式（不推荐）

ENTRYPOINT nginx -g "daemon off;"
```
### ENV: 设置环境变量
- 很好理解,就是设置了一个dockerfile中的变量而已.
```dockerfile
## 格式一：单个变量

ENV <key> <value>

## 格式二：多个变量（推荐）

ENV <key1>=<value1> <key2>=<value2> ...
```
**例子**
```dockerfile
ENV NODE_VERSION 20.10.0
ENV APP_ENV production

ENV NODE_VERSION=20.10.0 \
    APP_ENV=production \
    APP_NAME="My Application"
# 包含空格的值用双引号括起来
```

#### 用法
使用 -e 或 --env 覆盖 Dockerfile 中定义的环境变量：
```bash
## 覆盖单个变量

$ docker run -e APP_ENV=development myimage

## 覆盖多个变量

$ docker run -e APP_ENV=development -e DEBUG=true myimage

## 从环境变量文件读取

$ docker run --env-file .env myimage
```

运行时传入密码:
```dockerfile
## ❌ 错误：密码写入镜像

ENV DB_PASSWORD=secret123

## ✅ 正确：运行时传入

## docker run -e DB_PASSWORD=xxx myimage
```

使用docker compose的话就没必要考虑这么多了

### ARG: 构建参数
ARG仅在构建时生效,用于传递版本号之类的信息,可以出现在FROM指令之前,也能在docker build阶段传入对应的参数.换句话说,我们可以更改构建初始镜像所用的版本号.

而ENV则会被打包进入镜像,在容器运行期间永久生效,也不能出现在FROM指令之前.
**基本语法**
```dockerfile
ARG <参数名>[=<默认值>]
```

#### 用法
```dockerfile
ARG BASE_IMAGE=python:3.12-slim
FROM ${BASE_IMAGE}

## 可以构建不同基础镜像的版本

## docker build --build-arg BASE_IMAGE=python:3.14-alpine .

...
```
### VOLUME: 定义匿名卷
#### 是什么,怎么用
>容器存储层应该保持无状态，任何运行时数据都应该存储在volume中。

```dockerfile
# 定义单个volume
FROM mysql:8.0
VOLUME /var/lib/mysql

# 定义多个volume
FROM myapp
VOLUME ["/data", "/logs", "/config"]
```
#### volume的行为
**自动创建匿名卷**
如果运行时未指定挂载，Docker 会自动创建匿名卷：
```bash
$ docker run mysql:8.0
$ docker volume ls
DRIVER    VOLUME NAME
local     a1b2c3d4e5f6...  # 自动创建的匿名卷
```

**会被命名卷覆盖**
```bash
## 使用命名卷替代匿名卷

$ docker run -v mysql_data:/var/lib/mysql mysql:8.0
```

>VOLUME 之后对该目录的修改会被丢弃！

```dockerfile
FROM ubuntu
VOLUME /data

## ❌ 这个文件不会出现在镜像中！

RUN echo "hello" > /data/test.txt
```
>原因：在构建过程中，VOLUME 指令会为该目录创建一个临时的匿名卷。后续 RUN 指令对该目录的写入实际发生在这个临时卷中，而非镜像层。当该 RUN 指令结束后，临时卷被丢弃，因此写入的内容不会保存到最终镜像中。注意：这与容器运行时创建的匿名卷是不同的——运行时创建的卷会在容器生命周期内持续存在。

正确做法
```dockerfile
FROM ubuntu

## ✅ 先写入文件

RUN mkdir -p /data && echo "hello" > /data/test.txt

## 再声明 VOLUME

VOLUME /data
```
#### 在compose中使用
```yml
services:
  db:
    image: postgres:16
    volumes:
      # 命名卷（推荐）

      - postgres_data:/var/lib/postgresql/data
      # Bind Mount

      - ./init.sql:/docker-entrypoint-initdb.d/init.sql

volumes:
  postgres_data:  # 声明命名卷
```
### EXPOSE: 暴露端口(4/12)
#### 是什么,怎么用
>EXPOSE 声明容器运行时提供服务的端口。这是一个**文档性质**的声明，告诉使用者容器会监听哪些端口。
- 换句话说只起一个约定作用,不通过-p的话不会起作用

**基本用法**
```dockerfile
## 声明单个端口

EXPOSE 80

## 声明多个端口

EXPOSE 80 443

## 声明 TCP 和 UDP 端口

EXPOSE 80/tcp
EXPOSE 53/udp
```

使用 docker run -P 时，Docker 会自动映射 EXPOSE 的端口到宿主机随机端口：

```bash
## Dockerfile
# EXPOSE 80

$ docker run -P nginx
$ docker port $(docker ps -q)
80/tcp -> 0.0.0.0:32768
```
#### 实战
```dockerfile
## Dockerfile

FROM nginx
EXPOSE 80    # 1. 声明：这个容器会在 80 端口提供服务
```
```bash
## 运行：需要 -p 才能从外部访问

$ docker run -p 8080:80 nginx    # 2. 映射：宿主机 8080 → 容器 80
```
#### compose中的编写
```yml
services:
  web:
    build: .
    ports:
      - "8080:80"    # 映射端口（类似 -p）
    expose:
      - "80"         # 仅声明（类似 EXPOSE）
```
### WORKDIR: 指定工作目录
>WORKDIR 指定后续指令的工作目录。如果目录不存在，Docker 会自动创建。

**基本用法**
```dockerfile
WORKDIR /app

RUN pwd          # 输出 /app
RUN echo "hello" > world.txt    # 创建 /app/world.txt
COPY . .         # 复制到 /app/
```

```dockerfile
# 相对路径

WORKDIR /a
WORKDIR b
WORKDIR c

RUN pwd    # 输出 /a/b/c
```
#### 实战
**使用绝对命令**
```dockerfile
## ✅ 推荐：绝对路径，意图明确

WORKDIR /app

## ⚠️ 避免：相对路径可能造成混淆

WORKDIR app
```
### USER: 指定当前用户
#### 是什么,怎么用
>USER 指令切换后续指令 (RUN、CMD、ENTRYPOINT) 的执行用户

```dockerfile
USER <用户名>[:<用户组>]
USER <UID>[:<GID>]
```
- 一般是用不上这个的

### HEALTHCHECK: 健康检查
#### 是什么,怎么用
>HEALTHCHECK 指令告诉 Docker 如何判断容器状态是否正常。这是保障服务高可用的重要机制。

```dockerfile
HEALTHCHECK [选项] CMD <命令>
HEALTHCHECK NONE
```
#### 基本用法
```dockerfile
FROM nginx
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
  CMD curl -fs http://localhost/ || exit 1
```
| 选项             | 说明                            | 默认值 |
| :--------------- | :------------------------------ | :----- |
| `--interval`     | 两次检查的间隔                  | 30s    |
| `--timeout`      | 检查命令的超时时间              | 30s    |
| `--start-period` | 启动缓冲期 (期间失败不计入次数) | 0s     |
| `--retries`      | 连续失败多少次标记为 unhealthy  | 3      |


>应用启动可能需要时间 (如 Java 应用)。设置 --start-period 可以防止在启动阶段因检查失败而误判
```dockerfile
## 给应用 1 分钟启动时间

HEALTHCHECK --start-period=60s CMD curl -f http://localhost/ || exit 1
```

### LABEL: 为镜像添加元数据
#### 是什么,怎么用
>LABEL 指令以键值对的形式给镜像添加元数据。这些数据不会影响镜像的功能，但可以帮助用户理解镜像，或被自动化工具使用。

1. 版本管理：记录版本号、构建时间、Git Commit ID
2. 联系信息：维护者邮箱、文档地址、支持渠道
3. 自动化工具：CI/CD 工具可以读取标签触发操作
4. 许可证信息：声明开源协议
```dockerfile
LABEL <key>=<value> <key>=<value> ...
```

```dockerfile
# 定义单个标签
LABEL version="1.0"
LABEL description="这是一个 Web 应用服务器"

# 定义多个标签
LABEL maintainer="user@example.com" \
      version="1.2.0" \
      description="My App Description" \
      org.opencontainers.image.authors="Yeasy"
```

## 数据管理
这一章介绍如何在 Docker 内部以及容器之间管理数据，在容器中管理数据主要有以下几种方式：
1. 数据卷
2. 挂载主机目录
3. tmpfs 挂载

### 数据卷
>容器的存储层有一个关键问题：容器删除后，数据就没了。数据卷 (Volume) 解决了这个问题，它的生命周期独立于容器。
#### 创建和查看数据卷
```bash
# 创建数据卷
$ docker volume create my-vol

# 列出所有数据卷
$ docker volume ls
DRIVER    VOLUME NAME
local     my-vol
local     postgres_data
local     redis_data

# 查看数据卷详情
$ docker volume inspect my-vol
[
    {
        "CreatedAt": "2026-01-15T10:00:00Z",
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/my-vol/_data",
        "Name": "my-vol",
        "Options": {},
        "Scope": "local"
    }
]

```
**关键字段**：
- Mountpoint：数据卷在宿主机上的实际存储位置
- Driver：存储驱动 (默认 local，也可以用第三方驱动)

#### 挂载数据卷
**方式一：--mount：推荐**
```bash
$ docker run -d \
    --name web \
    --mount source=my-vol,target=/usr/share/nginx/html \
    nginx
```
| 参数       | 说明                          |
| :--------- | :---------------------------- |
| `source`   | 数据卷名称 (不存在会自动创建) |
| `target`   | 容器内挂载路径                |
| `readonly` | 可选，只读挂载                |
方式二：-v：简写
```bash
$ docker run -d \
    --name web \
    -v my-vol:/usr/share/nginx/html \
    nginx
```
>提示：官方更推荐使用 --mount。除了语法格式可读性更好之外，最重要的行为差异发生在 **绑定挂载** (Bind Mount) 时：如果挂载的宿主机源路径尚未存在，-v 会擅自将其自动创建为一个空目录；而 --mount 则会严格检查并直接报错。这能有效避免因路径拼写错误而在宿主机上留下垃圾目录（以及导致的容器访问空目录问题）。而对于本节的 数据卷 (Volume) 挂载而言，两者在目标指定的卷不存在时皆会自动创建卷，产生的结果是 完全一致 的。

#### 实战
**数据库持久化**
```bash
## 创建数据卷

$ docker volume create postgres_data

## 启动 PostgreSQL，数据存储在数据卷中

$ docker run -d \
    --name postgres \
    -e POSTGRES_PASSWORD=secret \
    -v postgres_data:/var/lib/postgresql/data \
    postgres:16

## 即使删除容器，数据仍然保留

$ docker rm -f postgres

## 重新启动，数据还在

$ docker run -d \
    --name postgres \
    -e POSTGRES_PASSWORD=secret \
    -v postgres_data:/var/lib/postgresql/data \
    postgres:16
```

**多容器共享数据**
```bash
## 创建共享数据卷

$ docker volume create shared-data

## 容器 A 写入数据

$ docker run -d --name writer \
    -v shared-data:/data \
    alpine sh -c "while true; do date >> /data/log.txt; sleep 5; done"

## 容器 B 读取数据

$ docker run --rm \
    -v shared-data:/data \
    alpine cat /data/log.txt
```

**配置文件持久化**
```bash
## 将 nginx 配置存储在数据卷中

$ docker run -d \
    -v nginx-config:/etc/nginx/conf.d \
    -v nginx-logs:/var/log/nginx \
    -p 80:80 \
    nginx
```

### 挂载主机目录
#### 绑定挂载
>Bind Mount (绑定挂载) 将 Docker daemon 所在主机 上的目录或文件直接挂载到容器中。容器可以读写这台主机上的文件系统。
**Bind Mount vs Volume**
| 特性           | Bind Mount (绑定挂载)                | Volume (数据卷)                                    |
| :------------- | :----------------------------------- | :------------------------------------------------- |
| **数据位置**   | 宿主机任意路径                       | Docker 管理的特定目录 (`/var/lib/docker/volumes/`) |
| **路径指定**   | 必须是绝对路径 (如 `/opt/app/data`)  | 卷名 (如 `my-vol`)，隐式管理物理路径               |
| **可移植性**   | **低**。依赖宿主机特定的文件目录结构 | **高**。不依赖物理路径，易于在不同环境迁移         |
| **性能**       | 依赖宿主机文件系统原生性能           | 绕过 Storage Driver 层，具备原生 I/O 性能          |
| **适用场景**   | 开发环境同步代码、挂载宿主机配置文件 | 生产环境数据库持久化、日志存储、多容器共享         |
| **备份与管理** | 手动定位宿主机路径进行备份           | 使用 `docker volume` 命令管理，备份需挂载容器操作  |
| **隔离性**     | 宿主机进程可轻易修改，安全性较低     | 由 Docker 隔离，减少了被宿主机其他进程误删的风险   |
#### 基本语法
**方案 A：使用 `--mount`（推荐方式）**

```bash
$ docker run -d \
    --name web-bind \
    --mount type=bind,source=/宿主机路径,target=/容器路径 \
    nginx
```

**方案 B：使用 `-v`（简写方式）**

```bash
$ docker run -d \
    --name web-v \
    -v /宿主机路径:/容器路径 \
    nginx
```
可以看到,这里的语法与之前的volume挂载基本相同

## 网络配置
### 配置DNS
Docker 容器的 DNS 配置有两种情况：
1. **默认 Bridge 网络**：继承宿主机的 DNS 配置 (/etc/resolv.conf)。
2. **自定义网络(推荐)**：使用 Docker 嵌入式 DNS 服务器 (Embedded DNS)，支持通过 **容器名** 进行服务发现。
#### 使用自定义网络
```bash
## 1. 创建自定义网络

$ docker network create mynet

## 2. 启动容器 web 并加入网络

$ docker run -d --name web --network mynet nginx

## 3. 启动容器 client 并尝试 ping web

$ docker run -it --rm --network mynet alpine ping web
PING web (172.18.0.2): 56 data bytes
64 bytes from 172.18.0.2: seq=0 ttl=64 time=0.074 ms
```
### 端口映射
容器的网络访问规则如下：
1. 容器之间：可以通过 IP 或容器名 (自定义网络) 互通。
2. 宿主机访问容器：可以通过容器 IP 访问。
3. 外部网络访问容器：❌ 默认无法直接访问。

为了让外部 (如你的浏览器、其他局域网机器) 访问容器内的服务，我们需要将容器的端口 **映射** 到宿主机的端口。
#### 基本用法
```bash
## 将宿主机的 8080 端口映射到容器的 80 端口

$ docker run -d -p 8080:80 nginx:alpine
```
- 此时访问 http://localhost:8080 即可看到 Nginx 页面。
| 格式                          | 含义                                   | 示例                                    |
| :---------------------------- | :------------------------------------- | :-------------------------------------- |
| **ip:hostPort:containerPort** | 绑定指定 IP 的特定端口                 | `-p 127.0.0.1:8080:80` (仅允许本机访问) |
| **ip::containerPort**         | 绑定指定 IP 的随机端口                 | `-p 127.0.0.1::80`                      |
| **hostPort:containerPort**    | 绑定所有网卡 IP (`0.0.0.0`) 的特定端口 | `-p 8080:80` (最常用格式)               |
| **containerPort**             | 绑定所有网卡 IP 的随机端口             | `-p 80`                                 |
##### 随机映射
>如果不关心宿主机使用哪个端口，可以使用随机映射。使用 -P (大写) 参数，Docker 会把 Dockerfile 中 EXPOSE 指令暴露的所有端口发布到宿主机的随机高位端口。具体落在哪个端口，取决于宿主机当前可用的临时端口范围。
```bash
docker run -d -P nginx

docker ps
CONTAINER ID   PORTS
abc123456      0.0.0.0:49153->80/tcp
# 此时 Nginx 被映射到了宿主机的一个随机高位端口49153
```

#### 实战
>默认情况下，-p 8080:80 会监听 0.0.0.0:8080，这意味着任何人只要能连接你的宿主机 IP，就能访问该服务。如果不希望对外暴露 (例如数据库服务)，应绑定到 127.0.0.1：
```bash
## 仅允许本机访问

$ docker run -d -p 127.0.0.1:3306:3306 mysql
```
### 网络隔离
不同网络之间默认隔离，容器只能与同一网络中的容器直接通信：
```bash
## 创建两个网络

$ docker network create frontend
$ docker network create backend

## 容器 A 在 frontend

$ docker run -d --name web --network frontend nginx

## 容器 B 在 backend

$ docker run -d --name db --network backend postgres

## web 无法直接访问 db（不同网络）

$ docker exec web ping db
ping: db: Name or service not known
```
## Docker Compose
### 概览
在学习 Compose 之前，笔者想强调它的真正价值。假设你正在开发一个微服务应用——前端、后端、数据库三个服务。如果你用 Docker 容器分别运行它们，你会遇到这些问题：
1. 启动顺序：需要先启数据库，再启后端，最后启前端
2. 网络连接：三个容器需要能彼此通信
3. 卷挂载：本地代码需要映射到容器内
4. 环境变量：每个服务的配置需要逐个设置

>使用 `docker run` 逐个启动的话，需要记住 3 条复杂的命令。而 `Docker Compose` 的核心价值就是用一个 YAML 文件来定义整个应用，然后一条命令 `docker compose up` 启动所有服务。这是 Compose 被广泛采用的原因——它极大地简化了本地开发和测试的复杂性。

Compose 项目早期由 Python 编写，称为 Docker Compose V1,现在的 Docker Compose V2 是一个 Go 语言编写的 Docker CLI 插件。Docker Desktop 默认包含它

**关键定义**
- **服务** (service)：一个应用容器，实际上可以运行多个相同镜像的实例。
- **项目** (project)：由一组关联的应用容器组成的一个完整业务单元。

可见，一个项目可以由多个服务 (容器) 关联而成，Compose 面向项目进行管理。
### 补充: compose命令行
**基本使用格式**
```bash
docker compose [-f=<arg>...] [options] [COMMAND] [ARGS...]
```
**参数说明**
- `-f, --file FILE`: 指定使用的 Compose 模板文件。默认会自动识别 compose.yaml (也兼容 docker-compose.yml 等)，并且可以多次指定。
- `-p, --project-name NAME`: 指定项目名称，**默认将使用所在目录名称作为项目名**。
- `--verbose`: 输出更多调试信息。
- `-v, --version`: 打印版本并退出。

事实上,想要更好的理解docker compose命令,需要和没有compose的docker命令进行比较:
#### 构建项目
- `docker compose build`: 根据当前目录的`compose.yml`文件进行构建,如果没有用`-f`指定文件名字的话,会在当前目录中按以下顺序检索，匹配到第一个即停止查找
  - compose.yaml（官方推荐的首选名称）
  - compose.yml
  - docker-compose.yaml
  - docker-compose.yml（历史最常用的名称，现降级为备选）
- `docker build`: 根据当前目录的dockerfile构建镜像
**更多的相同点**
1. 都会在目标文件变更时才重新构建镜像

自然,它完全可以被且已经被`docker compose up`取代
#### 启动项目
- `docker run`: 根据镜像名字启动容器,若依赖的镜像尚未构建且可以从远端拉取时,则先拉取该镜像后再启动容器,
- `docker compose up`: 根据compose.yml启动项目,若依赖的services(服务)有一些或者全部没有对应的镜像则会先构建再启动项目.

**更多的相同点**
1. 都支持使用-d参数来后台运行

事实上,`docker compose up`的特性比上面所说的要复杂得多,我们可以`compose.yml`中预先在build关键字中指定了对应的构建目录和dockerfile,则每次运行`docker compose up`时可以加上`--build`参数,来实现在对应的构建目录有更改时自动构建镜像后运行.

因此,如果容器不报错的话我们可以只使用`docker compose up`命令完成实时的构建和项目运行.
#### 停止和删除容器
- `docker compose stop`: 停止所有服务,保留容器和网络,当然也保留数据卷
- `docker compose down`: 停止所有服务后删除容器和网络,默认保留数据卷,除非加上`-v`参数,这会删除所有匿名卷和命名卷,但保留绑定挂载文件
- `docker stop`: 正常停止容器,不会删除容器
- `docker kill`: 强制停止容器,不会删除容器
- `docker rm 容器名`: 删除某个容器
- `docker rmi 镜像名`: `docker remove image`的缩写,删除某个镜像
- `docker container prune`: 删除虚悬容器
- `docker image prune`: 删除虚悬镜像
#### docker compose logs: 日志查看
**基本格式**
```bash
docker compose logs [options] [SERVICE...]
```

**参数**
- `--tail=50`: 指定对应的最新日志行数
tail参数的默认值为`all`,输出所有服务或者在指定服务名字时输出该服务的所有日志.

如果构建报错,都需要使用该命令来查看具体的构建问题.
#### 进阶用法: 多compose文件编排
- [官方文档](https://docs.docker.com/compose/how-tos/multiple-compose-files/merge/)
前面所说的`docker compose up`还可以通过使用多个`-f`参数,实现多文件的覆盖,从而将生产环境和部署环境彻底隔离开来,具体用法如下:

**执行命令**
```bash
docker compose -f compose.yml -f compose.prod.yml up -d
```

**compose.yml**
```yaml
# 核心基础配置，定义通用架构
services:
  web:
    image: nginx:alpine
    # 列表类字段（如 ports）在多文件模式下会执行“取并集”操作
    ports:
      - "8080:80"
    # 映射类字段（如 environment）若键名重复，后续文件将覆盖此处的值
    environment:
      - NODE_ENV=development
      - DEBUG=true
    # 默认重启策略
    restart: "no"

  db:
    image: postgres:15-alpine
    volumes:
      - db_data:/var/lib/postgresql/data

volumes:
  db_data:
```

**compose.prod.yml**
```yaml
# 生产环境专用覆盖，修改性能参数与安全性
services:
  web:
    # 覆盖：将基础镜像替换为稳定版标签
    image: nginx:stable-alpine
    # 覆盖：修改同名环境变量，关闭调试模式
    environment:
      - NODE_ENV=production
      - DEBUG=false
    # 合并：保留基础文件的 8080 端口，并额外增加 443 端口映射
    ports:
      - "443:443"
    # 覆盖：生产环境要求容器崩溃后自动重启
    restart: always
    # 新增：生产环境特有的部署约束
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M

  db:
    # 扩展：仅在生产环境中对数据库启用加密连接强制要求
    command: ["postgres", "-c", "ssl=on"]

# 注意：volumes 和 networks 的合并同样遵循并集原则
```
### 补充: compose编写
#### build: 指定dockerfile路径
>指定 Dockerfile 所在文件夹的路径 (可以是绝对路径，或者相对 Compose 文件的路径)。Compose 将会利用它自动构建这个镜像，然后使用这个镜像.
- Dockerfile 中设置的选项 (例如：CMD、EXPOSE、VOLUME、ENV 等) 将会自动被获取，无需在 Compose 文件中重复设置。
```yml
services:
  webapp:
    build:
      # 指定dockerfile路径
      context: ./dir
      # 指定dockerfile名字
      dockerfile: Dockerfile-alternate   
```
##### 进阶用法
使用arg参数指定构建镜像时的变量:
```yml
  frontend:
    build:
      context: .
      dockerfile: frontend/Dockerfile
      args:
        - VITE_API_URL=https://api.${DOMAIN?Variable not set}
        - NODE_ENV=production
```
#### image: 指定镜像
>指定该服务使用的镜像名称或ID,如果该镜像本地不存在,则会去远程仓库拉取该镜像

##### 进阶用法
image可以与build进行配合,指定build生成的镜像名字:
```yml
services:
  frontend:
    image: '${DOCKER_IMAGE_FRONTEND?Variable not set}:${TAG-latest}'
    build:
      context: .
      dockerfile: frontend/Dockerfile
      args:
        - VITE_API_URL=https://api.${DOMAIN?Variable not set}
        - NODE_ENV=production
```
- `${DOCKER_IMAGE_FRONTEND?Variable not set}`: compose语法`${VAR?ErrorMessage}`,若VAR为定义或为空,则compose会报错并停止运行,在终端输出该调试信息
- `TAG-latest`: compose语法`${VAR-DefaultValue}`,VAR变量未定义时提供默认值

如果compose.yml所在目录的.env文件中有如下定义:
1. `DOCKER_IMAGE_FRONTEND = frontend`
2. `TAG = 1.0`

而该项目的名字为`web`,则这个镜像在docker中的最终名字为`web-frontend:1.0`.
#### volumes: 指定挂载的数据卷
>数据卷所挂载路径设置。可以设置为**宿主机路径 (HOST:CONTAINER)**(即绑定挂载) 或者**数据卷名称 (VOLUME:CONTAINER)**，并且可以设置访问模式 (HOST:CONTAINER:ro)。

**用法**
```yml
volumes:
 - /var/lib/mysql
 - cache/:/tmp/cache
 - ~/configs:/etc/configs/:ro

# 如果路径为数据卷名称，必须在文件中配置数据卷。
services:
  my_src:
    image: mysql:8.0
    volumes:
      - mysql_data:/var/lib/mysql

volumes:
  mysql_data:
```

#### env_file与environment: 环境变量
- `env_file`: 指定环境变量文件路径。
  - 如果通过 docker compose -f FILE 方式来指定 Compose 模板文件，则 env_file 中变量的路径会基于模板文件路径。
  - 如果有变量名称与 environment 指令冲突，则按照惯例，以后者为准。

该环境文件需要严格符合.env格式:
```toml
## common.env: Set development environment

PROG_ENV=development
# 等号两边无空格
```

即使没有使用`env_file`关键字,compose依然会自动读取对应目录的.env文件.

- `environment`: 设置服务的环境变量,如果只给定名称,会自动读取环境变量，可以用来防止泄露不必要的数据.

**示例**
```yml
services:

  db:
    image: postgres:18
    env_file:
      - .env
    environment:
      - PGDATA=/var/lib/postgresql/data/pgdata
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD?Variable not set}
      - POSTGRES_USER=${POSTGRES_USER?Variable not set}
      - POSTGRES_DB=${POSTGRES_DB?Variable not set}
```
#### command: 覆盖容器启动后默认执行的命令
`command: bash scripts/prestart.sh`
#### healthcheck: 健康检查
>通过命令检查容器是否健康运行。
```yml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost:8000/api/v1/utils/health-check/"]
  interval: 10s
  timeout: 5s
  retries: 5
```
- `test`: 检查时执行的命令
- `interval`: 执行间隔
- `timeout`: 超过该时间限制仍未收到响应则视为这次检查失败
- `retries`: 第一次检查失败后的总尝试次数,若5次都失败则将该服务标记未不健康(unhealthy).

该关键字通常与depends_on关键字搭配使用.
#### depends_on
先看这个例子:
```yml
services:
  web:
    build: .
    depends_on:
      - db
      - redis

  redis:
    image: redis

  db:
    image: postgres
```
- web需要在redis和db两个服务都启动后才可以启动.

也就是说depends_on规定了容器启动的先后顺序,保证需要其他服务作为依赖的容器滞后启动.
##### 进阶用法: 搭配healthcheck
```yml
services:
  db:
    image: postgres:18
    restart: always
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
      interval: 10s
      retries: 5
      start_period: 30s
      timeout: 10s
  prestart:
    depends_on:
      db:
        condition: service_healthy
        restart: true    
  backend:
    depends_on:
      db:
        condition: service_healthy
        restart: true
      prestart:
        condition: service_completed_successfully
```
**关键字解析**
- `condition`: 要求相关依赖服务必须达到的具体状态
- `restart`: 对应服务重启时backend也必须重启
- `service_healthy`: 要求对应服务通过了健康检查,状态变为healthy
- `service_completed_successfully`: 用于一次性服务中,要求对应服务运行后正常退出
#### labels
>设置服务标签,供第三方工具识别

例如我们可以给后端加上traefik标签:
```yml
labels:
      - traefik.enable=true
      - traefik.docker.network=traefik-public
      - traefik.constraint-label=traefik-public

      - traefik.http.services.${STACK_NAME?Variable not set}-backend.loadbalancer.server.port=8000

      - traefik.http.routers.${STACK_NAME?Variable not set}-backend-http.rule=Host(`api.${DOMAIN?Variable not set}`)
      - traefik.http.routers.${STACK_NAME?Variable not set}-backend-http.entrypoints=http

      - traefik.http.routers.${STACK_NAME?Variable not set}-backend-https.rule=Host(`api.${DOMAIN?Variable not set}`)
      - traefik.http.routers.${STACK_NAME?Variable not set}-backend-https.entrypoints=https
      - traefik.http.routers.${STACK_NAME?Variable not set}-backend-https.tls=true
      - traefik.http.routers.${STACK_NAME?Variable not set}-backend-https.tls.certresolver=le

      # Enable redirection for HTTP and HTTPS
      - traefik.http.routers.${STACK_NAME?Variable not set}-backend-http.middlewares=https-redirect
```
#### networks
配置容器连接的网络,若不声明,所有服务都加入默认的桥接网络,彼此可见

写法如下:
```yml
services:

  some-service:
    networks:
     - some-network
     - other-network

networks:
  some-network:
  other-network:
```
#### expose: 暴露端口
暴露端口,但不映射到宿主机仅可以指定docker内部端口为参数:
```yml
expose:
 - "3000"
 - "8000"
```
## docker中装载操作系统
# RESTful Web APIs
一本比较优秀的书,如果你不知道如何写API请求,不知道前后端如何通信,不知道如何规范API格式,就可以来看这本书.

- 这本书的作者之一就是著名爬虫库bs4的开创者,还是有一定分量的
- [zlib中文版链接,可惜没有书签](https://zh.z-library.sk/book/eOWLGdNBRb/restful-web-apis%E4%B8%AD%E6%96%87%E7%89%88.html)


## 补充: 什么是RESTful Web API
>非常令人震惊的是,这本书并没有详细谈这一名词的具体概念和历史背景...因此需要在这里做一点补充

- [非常优秀的中文博客解析](https://www.cnblogs.com/lrzr/p/7296439.html)

只看上面的文章就够了,我再加上一点历史背景解析
### 历史背景 
- 根据<< RESTful Web APIs Patterns and Practices Cookbook >>总结

在www(万维网)的概念于1993年左右开始盛行时,并没有一个合适的规范来约束用户端和服务器之间的通信.

于是,web技术大牛**Roy T. Fielding**在1998年的微软演讲提出了Representational State Transfer(REST)的初步构想,并在两年后的论文(“Architectural Styles and the Design of Network-based Software Architectures”)中完整的介绍了REST,总结一下大致意思就是:

>REST provides a set of architectural constraints that, when applied as a whole, emphasizes **scalability of component interactions**, **generality of interfaces**, **independent deployment of components**, and **intermediary components** to reduce interaction latency, enforce security, and encapsulate legacy systems.

看不懂没关系,我们只需要知道Rest的主要准则如下:

| 约束名称                          | 核心要求                                                     | 违背后的后果                                                 |
| :-------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| **客户机-服务器 (Client-Server)** | 前后端分离，职责解耦。                                       | 无法独立演进，扩展性受阻。                                   |
| **无状态 (Stateless)**            | 每个请求必须包含处理所需的全部信息，服务器不保存会话上下文。 | 导致服务器无法水平扩展，容错性降低。                         |
| **可缓存 (Cacheable)**            | 响应必须定义自身是否可缓存。                                 | 增加网络延迟，浪费带宽和服务器资源。                         |
| **统一接口 (Uniform Interface)**  | 包含资源标识、通过表述操纵资源、自描述消息、**HATEOAS**。    | **最常被忽视的一项**。不满足此项的通常只是“带 HTTP 的 RPC”。 |
| **分层系统 (Layered System)**     | 客户端无法感知直接连接的是服务器还是中间件（代理、缓存）。   | 破坏安全性与负载均衡的透明度。                               |
| **按需代码 (Code on Demand)**     | *（可选）* 允许服务器向客户端发送可执行代码（如 JS）。       | 增加客户端复杂度和安全风险。                                 |


如果你的Web架构设计和API请求符合这些原则,则可以被称为Restful Web和Restful Web API.(rest-ful,意思大致为rest风格)
## ch1: Surfing the Web
- 非常详尽的介绍了**点击URL过程中**客户端与服务器之间的交互

在REST中我们将**你所停留的页面**等窗口信息称为**应用状态**(application state),当你上网的时候,客户端从一个应用状态切换到另一个应用状态.

同样,服务器端根据客户端的状态转换(发送GET/POST等HTTP请求)来响应对应的**表述**(representation),并将改变的信息保存在服务器端.

>为什么要在你可以搭建一个每个人都可以使用的网站的时候，开发一种只有计算机专业人员才能理解的工具呢？所有成功的后 Web 协议（post-Web protocols）都是在做一些 Web 做不了的事情：P2P 协议比如 BitTorrent，实时协议比如 SSH。对于大部分的目的，HTTP 已经足够使用了。

## ch2: 一个简单的API
### HTTP响应
每个由服务器发出的HTTP响应可分成三个部分:
1. 状态码(status code): 简要说明了请求目前的进展
2. 消息体(entity body): 采用某种数据格式写成的文档,可以被客户端理解和提取
3. 响应头(response head): 夹在状态码和消息体之间,描述消息体性质和服务器状态
   1. `Content-Type`: 最重要的报头,告诉HTTP客户端如何理解消息体,最常见的内容类型有`text/html`和`image/webp`等

### 令人头疼的API
遗憾的是,大多数企业或者网站都使用的是自定义的json格式,导致不同网站之间的api完全不能兼容,至今为止,api格式仍然没有一个统一的标准,但`JSON:API `有可能成为一个实际标准来挽回这个糟糕的局面.
## ch3: Resources and Representations
### 前置概念
- resource(资源): 一个URL链接对应的事物
- representation(表述): 包含资源(resource)相关信息的文档

那么HTTP的常用方法可以这样定义:
- GET: 获取资源的某个表述
- DELETE: 销毁一个资源
- POST: 基于给定的表述,在当前资源的下一级创建新的资源
- PUT: 用给定的表述替换资源的当前状态
- HEAD: 获取服务器发送过来的报头信息
- OPTIONS: 获取该URL所能响应的HTTP方法列表
- PATCH: 根据提供的表述修改资源的部分状态,但若有些资源未在表述中提及,则保持不变.  
  - 相当于一个强化版的PUT
### HTTP请求概览
```json
// 请求方法,请求路径,使用的HTTP协议版本

POST /orders HTTP/1.1

// 请求报头

// 目标服务器域名
Host: api.example.com
// 请求体的格式
Content-Type: application/vnd.collection+json
// 希望收到的返回体格式
Accept: application/vnd.collection+json

// 请求体

{
  "template": {
    "data": [
      {
        "name": "full-name",
        "value": "John Doe"
      },
      {
        "name": "email",
        "value": "jdoe@example.com"
      },
      {
        "name": "order-id",
        "value": "98765"
      }
    ]
  }
}
```
这是使用了HTTP POST方法的请求,尽管看上去很复杂,但不同的请求方法对应的请求格式也不一样,比如GET请求就可以没有任何HTTP报头和请求体.
### HTTP GET
HTTP规范中表示: GET请求是为了获取网页内容而作的请求,主观上没有改变服务器资源状态的意图.也就是说,当我们得到了一个URL但没有更多信息可供参考时,我们一般都会发送GET请求,而不会产生任何负面作用.

- 所以GET请求是幂等的,即多次请求和一次请求返回的结果相同
### HTTP DELETE
当客户端想要一个资源消失的时候,它可以发送一个DELETE请求,可能会收到以下状态码:

1. 204: `No Content`,删除成功,我没有其他关于这个资源的表述了
2. 200: `OK`,删除成功,这里是关于它的一条消息
3. 202: `Accepted`,我等下就删除它

- 同样,DELETE请求是幂等的,因为你不可能反复删除同一个资源


### HTTP POST
HTTP规范中对POST的功能定义如下:
1. 对现有资源的注解
2. 发布新消息
3. 提交表单等用户输入
4. 向数据库追加数据

POST方法**既不安全也不幂等**,因为它没有指定要生成的资源对应的URL,服务器就只能创建一个新的URL来存放新的数据,如果发送了多个POST请求,服务器也会生成多个新的URL.

```json
POST /api/ HTTP/1.1
Content-Type: application/vnd.collection+json
{
"template" : {
"data" : [
{"name" : "text", "value" : "testing"}
]
}
}
```

### HTTP PUT
由于PUT指定了唯一的用于替换的表述信息和对应的URL,因此发送多次PUT请求的结果和发送一次的结果相同,也就是说PUT是**幂等的**.

```json
PUT /api/q1w2e HTTP/1.1
Content-Type: application/vnd.collection+json

{
  "template" : {
    "data" : [
      {"name" : "text", "value" : "tasting"}
    ]
  }
}
```
### HTTP PATCH
PATCH与POST一样是非幂等的,因为它同样不会指定存放资源的URL路径,而是直接发送一个**只有部分信息被修改**的表述(representation),并让服务器根据这个表述来做出对应的更改,**它可能会产生新的数据**.

### HTTP HEAD
对HEAD最好的理解就是轻量级版本的GET,服务器应该和处理GET方法一样处理HEAD方法,但只需要发送状态码和报头,不需要发送消息体.

- 由于服务器发送该消息还是要经历一个完整的RTT(往返时间),只是不用发送报文而已,所以用处不是很大

### HTTP OPTIONS
获取该URL支持的所有请求方法,很少会被用到.
```txt
OPTIONS /api/a1s2d3 HTTP/1.1
Host: www.youtypeitwepostit.com
200 OK
Allow: GET PUT DELETE HEAD OPTIONS
```

## ch4: Hypermedia(超媒体)
- **hypermedia(超媒体)**: 超文本(hypertext)的对应概念,是对HTML链接,表单,图像等事物的通称,可以实现用户交互

超媒体有以下作用:
1. 引导请求,引导用户点击链接跳转到其他URL
2. 对响应做出承诺,比如在html中展示外部图像

## ch11: HTTP for APIs
- 第五章到第十章的内容都过于古老陈旧了,故直接跳过

我们可以将www(万维网)分成三层技术栈,自上而下分别是:
1. Hypermedia: 下一步要做什么
2. HTTP: 如何与这些资源通信
3. URL: 资源在哪里

这一章主要围绕HTTP协议展开
### HTTP/1.1(RFC 2616)
#### 响应码
HTTP1.1定义了41个响应码,按照百位数字可以进行分类:
- 1xx: Informational
  - 仅在HTTP客户端与服务器之间进行协商时使用
- 2xx: Successful
  - 客户端要求的状态转换已经发生
- 3xx: Redirection
  - 客户端要求的状态转换没有发生,但如果客户端愿意发起一个稍有不同的HTTP请求,服务器就会完成对应的行为
- 4xx: Client Error
  - 由于HTTP请求的问题,客户端要求的状态转换没有发生,该请求可能有缺陷,不和逻辑或者无法被服务器接收
- 5xx: Server Error
  - 由于服务器的问题,客户端要求的状态转换没有发生.



#### 报头
HTTP1.1定义了47种HTTP请求和响应报头
#### 表述(representation)选择
当服务器为一个资源提供了多种可用的表述时,客户端想要获取特定的表述时(如选择中文版本,选择XML文本,选择详细版本),可以通过内容协商来实现
#### 内容协商
- 内容协商(content negotiation): 客户端使用特定的HTTP请求报头来告诉服务器它想要哪些表述.

HTTP1.1定义了5个与之相关的请求报头,统称为**Accept-*报头**.最重要的两个报头是Accept和Accept_Language.

如果服务器因为某个Accept限制而不能处理某个请求,它可以发送响应码406(Not Acceptable)
### HTTP优化
HTTP1.1定义了一些优化方案用于帮助服务器拦截一些可能没有意义的请求,降低一般请求的开销.
1. 缓存(Caching): 服务器通过**Cache-Control**报头让客户端调整缓存
2. 条件GET(Conditional GET): 
   1. **Last-Modified**报头告诉客户端该资源状态上次改变的时间,若该资源状态没有变化,服务器会在客户端再次访问时发送状态码304(Not Modified),并且不再附带实体消息体
   2. **ETag**报头包含一些随机字符串,只要对应的表述发生了变化,该字符串就会改变,与Last-Modified的作用基本相同,但不需要关注具体的更改日期,可以节省带宽,更为可靠
3. **压缩**,通过**Accept-Encoding**和**Content-Encoding**来设置服务器和客户端能够接受和发送的文档压缩格式,可以大量节省带宽

### API认证
API认证有两个步骤:
1. 用户设置自己的证书(如创建网站的账号或者将现有的账号绑定到此次会话中)
2. 用户每次发送API请求时自动提交用户证书

>之所以每次请求都要提交证书,是因为HTTP的无状态约束要求服务器不保留客户端的任何信息.

接下来会介绍3种常见的认证技术:
1. Basic认证
2. OAuth1.0
3. OAuth2.0

这三种技术都通过WWW-Authenticate和Authorization报头来进行证书确认,一个完整的流程如下:
```json
// 客户端发送请求

GET / HTTP/1.1
Host: api.example.com

// 由于未经认证,服务器会进行拦截,返回以下状态码

401 Unauthorized HTTP/1.1
WWW-Authenticate: Basic realm="My API"

// 客户端通过注册获得了证书,再次发送请求

GET / HTTP/1.1
Host: api.example.com
Authorization: Basic YWxpY2U6cGFzc3dvcmQ=

// 这次服务器会正常返回信息了
```
#### Basic认证
Basic认证是一种简单的用户名/密码方法.用户通过附属网站或者电子邮件注册一个账户,获得自己的用户名和密码,并加入Authorization请求报头来申请访问服务器,服务器则会正常返回信息:
```json
GET / HTTP/1.1
Host: api.example.com
Authorization: Basic YWxpY2U6cGFzc3dvcmQ=

HTTP/1.1 200 OK
Content-Type: application/xhtml+xml
...
```

这种方法确实很简单,但不够安全可靠
#### OAuth 1.0
OAuth(short for **open authorization**)中,用户针对每个客户端都单独提供一套独特的证书,如果它决定不再使用某个客户端,则会撤销该客户端的证书,而其他客户端不受任何影响.

例如,当用户未被授权时,服务器会返回以下响应:
```json
HTTP/1.1 401 Unauthorized
WWW-Authorization: OAuth realm="My API"
```

很多时候我们都是通过OAuth进行第三方授权的(如Google登录,QQ登录,微信登录),这类请求的本质如下:
1. 用户点击当前网页`www.fun.cn`里面的第三方注册/登录按钮
2. 客户端发送该请求到该网页所在服务器,服务器向用户的浏览器发送了一个HTTP重定向响应,让用户前往第三方网站(如Google弹窗).
3. 用户同意是否使用第三方网站的令牌证书来授权当前网站.
4. 用户做出决定后,浏览器重定向回网站`www.fun.cn`
5. 如果用户选择不同意,则网站不会得到任何信息,若选择同意,则该网站被允许通过第三方网站的api获得第三方网站的用户证书,样式如下:

```json
GET / HTTP/1.1
Host: api.example.net
Authorization: OAuth realm="Example API",
oauth_consumer_key="rQLd1PciL0sc3wZ",
oauth_signature_method="HMAC-SHA1",
oauth_timestamp="1363723000",
oauth_nonce="JFI8Bq",
oauth_signature="4HBjJvupgIYbeEy4kEOLS%Ydn6qyV%UY"
```
##### 缺点
当用户的所有活动都发生在浏览器中的时候,Oauth1.0就足够了.但当用户使用的是桌面或者手机应用时,就需要弹出一个浏览器窗口来进行认证,这显然有点突兀了(尽管很多APP/桌面端使用这一方式来进行认证).

#### 补充: OAuth 2.0
- [阮一峰教程](https://www.ruanyifeng.com/blog/2019/04/oauth_design.html)
- OAuth2.0是为了解决1.0版本的缺陷而推出的,但这本书并没有深入谈及它的原理和应用

>简单说，OAuth 就是一种授权机制。数据的所有者告诉系统，同意授权第三方应用进入系统，获取这些数据。系统从而产生一个短期的进入令牌（token），用来代替密码，供第三方应用使用。

令牌（token）与密码（password）的作用是一样的，都可以进入系统，但是有三点差异。

（1）令牌是短期的，到期会自动失效，用户自己无法修改。密码一般长期有效，用户不修改，就不会发生变化。

（2）令牌可以被数据所有者撤销，会立即失效。以上例而言，屋主可以随时取消快递员的令牌。密码一般不允许被他人撤销。

（3）令牌有权限范围（scope），比如只能进小区的二号门。对于网络服务来说，只读令牌就比读写令牌更安全。密码一般是完整权限。
## 总结
本书涉及了很多种古老或者新颖(*本书出版于2013年,HTTP2.0都尚未制定完成*)的通信文本框架,从一个比较高的维度讲述了一个符合Rest规范的通信框架应该是怎么样的.实战代码相对较少,理念比较多,但读完还算有一点收获,对于前后端的通信规范理解的更深入了.
- 对于有一定基础的人来说,最有价值的也许是附录A和附录B.

# 程序员自我修养
- (4/5): 讲的很深,可惜的是逻辑比较混乱,如果能再版后重构一下就真的是神书了
- (6/16): 回来鞭尸了,这本书的遗毒太深了,导致我对编译器产生了很多乱七八糟的误解,尽管这能够让我从错误中更好地学习,但还是不希望其他人拿这本书入门编译原理,不太推荐.
## OUTLINE
1. 简介
2. 编译和链接
3. 目标文件里有什么
4. 静态链接
5. windows PE/COFF
6. exe的装载与进程
7. 动态链接
8. Linux的共享库
9. Windows中的动态链接
10. 内存
11. 运行库
12. 系统调用与API
13. 运行库的实现

可以很明显的看出来,这本书主要涉及的是C语言程序经过编译与链接后装载的过程.
## 编译和链接
### 程序运行的过程
当我们使用GCC编译Hello World程序时,只需要这样写:
```bash
gcc hello.c -o ./a.out
# './a.out'是文件名和路径,后缀名可以随便起,写成tho没有后缀或者a.xyz也可以
```
上述过程可以分解为4个步骤:
1. 预处理(Preprocessing)
2. 编译(Compilation)
3. 汇编(Assembly)
4. 链接(Linking)

#### 预处理
c文件和h文件会被预处理成.i文件,cpp文件和hpp文件会被预处理为.ii文件.
- 对应的命令为`gcc -E hello.c -o a.i`
该阶段主要处理源代码中以"#"打头的预编译指令,如'#include','#define'等,主要运行过程如下:
1. 将所有的"#define"删除,并展开所有的宏定义,比如,将含有"#define PI 3.14"的文件中的所有PI替换为3.14
2. 处理所有的条件预编译指令,如"#if","endif"等
3. 处理"#include",将被包含的文件插入到文件中该预编译指令所在的行,该过程是递归执行的
4. 删除所有的注释"//"和"/*  */"
5. 添加行号和文件名标识,如 " #2 "hello.c" 2 ",这就是我们在程序报错的时候看到的那些行号和文件名的来历,至于行尾的2,是一个给编译器看的标志位
6. 保留所有的"#pragma"指令

因此,经过预处理后的.i文件不包含任何宏定义,包含的文件也被插入到.i文件中

#### 编译
对.i文件进行一系列词法分析,语法分析,语义分析和优化,生成相应的汇编代码文件.
- 对应的命令为`gcc -S hello.i -o hello.s`
#### 汇编
根据汇编代码构建目标文件
- 对应的命令为`gcc -c hello.s -o hello.o`
  - 或者一步完成: `gcc -c hello.c -o hello.o`

#### 链接
```bash
ld -static crt1.o crti.o crtbeginT.o hello.o -start-group -1gcc -1gcc_eh -1c -end-group crtend.o crtn.o
```
可以看到需要链接一堆文件才可以得到最终的可执行文件
### 编译的详细原理
下面我们来以一段简单的c语言代码为例来分析编译的全过程:
```c
array[index] = (index+4)*(2+ 6)
```
#### 词法分析
源代码被输入到扫描器(Scanner),产生一系列记号:关键字,标识符,数字,字符串和特殊符号(加号,等号)等.
#### 语法分析
语法分析器(Grammar Parser)对扫描器产生的记号进行语法分析,产生由表达式组成的语法树(Syntax Tree)
![示意图](PixPin_2026-03-27_12-43-31.webp)
#### 语义分析
语义分析器(Semantic Analyzer)对表达式进行**静态**的语义分析,标识各个表达式的类型;动态语义则只能在运行期确定.
![示意图](PixPin_2026-03-27_12-44-40.webp)
#### 中间代码的生成
现代编译器会对源代码进行优化,将整个**语法树**转换成**中间代码**,尽管非常接近目标代码,但它与运行的操作系统无关,不包含数据尺寸,变量地址和寄存器名字等信息.
根据中间代码可以把编译器分为前端和后端.前端负责产生于操作系统无关的中间代码,后端负责将中间代码转换成目标文件
**Java 编译体系 (Bytecode)**

前端：javac。它将 .java 源码编译成与平台无关的 Java Bytecode (.class 文件)。这就是所谓的中间代码。

后端：JVM (Java Virtual Machine) 中的 JIT 编译器 (如 C1、C2)。当程序运行时，JIT 将字节码转换为当前运行机器（Windows x64、Linux ARM 等）的具体指令集。



#### 目标代码的生成与优化
编译器后端主要包括**代码生成器**和**目标代码优化器**二者.
代码生成器将中间代码转换成目标机器代码,例如:
```text
t1 = y + z
x = t1

->

mov rax, QWORD PTR [rbp-8]   ; 将变量 y 加载到寄存器 rax
add rax, QWORD PTR [rbp-16]  ; 将变量 z 的值加到 rax 中
mov QWORD PTR [rbp-24], rax  ; 将结果 rax 存回变量 x 的内存地址
```
然后由**目标代码优化器**对上述目标代码进行优化,比如选择合适的寻址方式,使用位移来代替乘法运算,删除冗余指令等

#### 总结
经过这么多步骤后,源代码被编译成了目标代码,但有一个问题,变量的存储地址还没有确定,而且如果这个变量是来自其他模块的话又该怎么办?这就是链接派上用场的地方了

### 链接概览
![示意图](PixPin_2026-03-31_13-09-29.webp)
链接有以下几个步骤:
1. 地址和空间分配(Address and Storage Allocation)
2. 符号决议(Symbol Resolution)
3. 重定位(Relocation)
## 补充: 编译全过程;编译器的前端和后端
由于书上对这些概念没有做一个很清晰的介绍,因此我再在这里做一点辨析方便后续的阅读:
**流水线解释**
- 预处理: 转换宏定义,删除注释
- 编译(狭义): 将cpp源码翻译成汇编代码(人类可读)
- 汇编:
  - 将汇编代码翻译成**机器指令**(二进制码)
  - 根据机器指令,地址位置等信息构造**目标文件**
- 链接: 将目标文件与系统库,用户库关联起来,得到可执行文件
- 编译(广义): 由于大多数人对cpp的装载过程没有一个清晰的认识,故通常使用编译代指从`.cpp`到`.exe`的全过程,也就是说我们一般都用广义的编译概念,很少特指"真正的编译"

但是,我们所用的编译器如gcc,clang等都是广义上的编译器,也就是说不仅仅做的是编译,而是包揽了从`.cpp`到目标文件的全构建过程.
如果用前端和后端的概念来划分的话,是这样的:
### 前端（Frontend）
**范畴：** 仅包含“编译”这一步的前半部分。
* **输入：** 预处理后的源码。
* **任务：** 词法分析（Lexical Analysis）、语法分析（Syntax Analysis）、语义分析（Semantic Analysis）、生成**中间表示（IR, Intermediate Representation）**。
* **特性：** 与具体的硬件架构（如 x86、ARM）无关，只与 C++ 语言本身的规则有关。

### 后端（Backend）
**范畴：** 包含“编译”这一步的后半部分，以及“汇编”的全部。
* **任务：** * **中端优化（Optimizer）**：对 IR 进行架构无关的优化。
    * **代码生成（Code Generator）**：将 IR 转换为特定硬件的**汇编代码**。
    * **汇编器（Assembler）**：将汇编代码转换为机器指令，产出目标文件。
* **特性：** 强依赖于硬件架构。

### 其他项
* **预处理（Preprocessing）**：通常被视为编译前的“文本清洁工作”，不属于狭义编译器（Compiler Core）的前后端逻辑。
* **链接（Linking）**：属于编译链的下游，是一个独立的二进制处理过程，不属于编译器（Compiler）的范畴。

## 目标文件: 汇编的产物


### 目标文件的格式
可执行文件的格式主要有Windows中的PE(Portable Executable,不是那个重装windows用的Preinstallation Environment)和Linux中的ELF(Executable Linkable Format),两者都是COFF(Common file format)的变种.从广义上看,可执行文件的格式与目标文件基本相同,故这里将它们看作一种类型的文件,在Windows中称为PE-COFF文件格式,在Linux中称为ELF文件格式.(也就是说我们这里把目标文件就看成是ELF文件)
- 事实上,动态链接库(DLL,Dynamic Linking Library)(Windows.dll和Linux的.so)和静态链接库(Static Linking Library)(Windows的.lib和Linux的.a)的存储方式也是可执行文件.

更为标准的分类方法如下:
| ELF 文件类型                             | 说明                                                                                                                                | 实例                                      |
| :--------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------- |
| **可重定向文件**<br>(Relocatable File)   | 包含代码和数据，可被用来链接成可执行文件或共享目标文件，静态链接库也归为此类。                                                      | Linux 的 `.o`<br>Windows 的 `.obj`        |
| **可执行文件**<br>(Executable File)      | 包含可以直接执行的程序。                                                                                                            | Linux 的 `/bin/bash`<br>Windows 的 `.exe` |
| **共享目标文件**<br>(Shared Object File) | 包含代码和数据。可由链接器与其他可重定向/共享目标文件链接产生新目标文件；或由动态链接器与可执行文件结合，作为进程映像的一部分运行。 | Linux 的 `.so`<br>Windows 的 `DLL`        |
| **核心转储文件**<br>(Core Dump File)     | 当进程意外终止时，系统将该进程的地址空间内容及终止时的其他信息转储到该文件。                                                        | Linux 下的 `core dump`                    |

### ELF文件的内容
![示意图](PixPin_2026-04-09_14-02-28.webp)

目标文件将不同类型的信息用段(section)的形式存储:
1. File Header: 描述了整个文件的文件属性,包括文件是否可执行,目标硬件,目标操作系统等信息;还包括一个段表(section table),描述目标文件中各段的属性
   1. 使用C语言的结构体来定义
2. .text section: 保存汇编得到的及其代码
3. .data section: 保存已经初始化的全局变量和局部静态变量
4. .bss section: 保存未初始化的全局变量和局部静态变量,由于它们都是0,故没有必要放入.data段中,同时,由于程序运行时需要记录这两类变量,因此需要用.bss段来额外预留位置.该段并没有内容,故在目标文件中也不占据空间.

>bss的来历
BSS(Block Started by Symbol)来源于1950年代IBM大型机的汇编器中的一个伪指令,后来被引入标准汇编器FAP中,用于定义符号并且为该符号预留给定数量的未初始化空间

整体来说,源代码被编译后分成两段:程序指令(代码段),程序数据(数据段和.bss段).


事实上,ELF文件的内部结构比上述所说的四段式结构要复杂的多:
![示意图](PixPin_2026-04-10_15-06-33.webp)

* **[ 0] (NULL)**：索引为 0 的段物理上必须存在且全为空，用于标识无效引用。
* **[ 1] .text**：**代码段**。存放程序经过编译后的物理机器指令。
* **[ 2] .rel.text**：**代码重定位段**。记录 `.text` 段中哪些物理地址需要在链接时进行修正。
* **[ 3] .data**：**已初始化数据段**。存放程序中已初始化的全局变量和局部静态变量。
* **[ 4] .bss**：**未初始化数据段**。为未初始化的全局变量预留的物理占位符，在文件中不占实际磁盘空间。
* **[ 5] .rodata**：**只读数据段**。存放常量（如字符串常量、`const` 修饰的变量）。
* **[ 6] .comment**：**注释段**。物理记录编译器版本信息（如 "GCC: (GNU) ..."）。
* **[ 7] .note.GNU-stack**：**堆栈属性段**。物理标识堆栈是否可执行，用于系统安全防御（NX 位）。
* **[ 8] .shstrtab**：**段表字符串表**。存储所有段名（如 ".text", ".data"）的物理字符串池。
* **[ 9] .symtab**：**符号表**。记录程序中定义和引用的所有函数名、变量名及其物理偏移。
* **[10] .strtab**：**字符串表**。存储符号表中所使用的所有名称字符串。

下面我们来一个个解析:
### 文件头,段表,重定位表

#### 文件头
- [拓展阅读](https://man7.org/linux/man-pages/man5/elf.5.html)

本书使用的示例c程序分析得到的文件头内容如下:
* **Magic (魔数)**：`7f 45 4c 46 01 01 01 00 ...` 
    * 物理意义：文件开头的 16 个字节，用于标识该文件是一个 ELF 格式的可执行或目标文件。
* **Class (类别)**：`ELF32`
    * 物理意义：该文件是为 **32 位** 架构设计的。
* **Data (数据存储方式)**：`2's complement, little endian`
    * 物理意义：采用二补码形式，且为 **小端序**（低位字节存储在低地址）。
* **Version (版本)**：`1 (current)`
    * 物理意义：当前 ELF 格式的版本号。
* **OS/ABI (操作系统/接口)**：`UNIX - System V`
    * 物理意义：该文件遵循的物理调用约定标准。
* **Type (文件类型)**：`REL (Relocatable file)`
    * 物理意义：这是一个**可重定位文件**（通常为 `.o` 文件），尚未经过链接。
* **Machine (硬件平台)**：`Intel 80386`
    * 物理意义：物理运行的目标指令集架构。
* **Entry point address (入口地址)**：`0x0`
    * 物理意义：由于是可重定位文件，尚未装载，因此物理入口地址为 0。
* **Start of program headers (程序头起点)**：`0 (bytes into file)`
    * 物理意义：目标文件中通常不包含程序头表（Program Header Table），该表仅在可执行文件中存在。
* **Start of section headers (段表起点)**：`280 (bytes into file)`
    * 物理意义：**段表（Section Header Table）**在文件内部的物理偏移地址。
* **Size of this header (ELF 头大小)**：`52 (bytes)`
    * 物理意义：ELF Header 本身物理占据的字节长度。
* **Size of section headers (单段描述符大小)**：`40 (bytes)`
    * 物理意义：段表中每个条目物理占据的空间。
* **Number of section headers (段的数量)**：`11`
    * 物理意义：该文件物理包含 11 个段（如 `.text`, `.data`, `.bss` 等）。
* **Section header string table index (段表字符串表索引)**：`8`
    * 物理意义：存储段名字符串的表在段表中的物理下标。

事实上,这些信息是以C语言的结构体存储的:


```c
typedef struct {
    unsigned char e_ident[16];   // 物理魔数区（含架构、字节序信息）
    Elf32_Half    e_type;        // 物理文件类型
    Elf32_Half    e_machine;     // 物理硬件平台
    Elf32_Word    e_version;     // 物理版本
    Elf32_Addr    e_entry;       // 物理程序入口地址
    Elf32_Off     e_phoff;       // 程序头表物理偏移
    Elf32_Off     e_shoff;       // 段表物理偏移
    Elf32_Word    e_flags;       // 处理器标志位
    Elf32_Half    e_ehsize;      // ELF 头物理大小
    Elf32_Half    e_phentsize;   // 单个程序头描述符大小
    Elf32_Half    e_phnum;       // 程序头描述符数量
    Elf32_Half    e_shentsize;   // 单个段表描述符大小
    Elf32_Half    e_shnum;       // 段表描述符数量
    Elf32_Half    e_shstrndx;    // 段名字符串表所在段的索引
} Elf32_Ehdr;
```

>在 ELF 文件格式定义中，为了屏蔽不同平台下 `int` 或 `long` 长度不一带来的物理对齐问题，官方定义了一套标准数据类型：

| 自定义类型      | 描述                  | 原始类型   | 长度（字节） |
| :-------------- | :-------------------- | :--------- | :----------- |
| **Elf32_Addr**  | 32 位版本程序地址     | `uint32_t` | 4            |
| **Elf32_Half**  | 32 位版本无符号短整型 | `uint16_t` | 2            |
| **Elf32_Off**   | 32 位版本偏移地址     | `uint32_t` | 4            |
| **Elf32_Sword** | 32 位版本有符号整型   | `int32_t`  | 4            |
| **Elf32_Word**  | 32 位版本无符号整型   | `uint32_t` | 4            |
| **Elf64_Addr**  | 64 位版本程序地址     | `uint64_t` | 8            |
| **Elf64_Half**  | 64 位版本无符号短整型 | `uint16_t` | 2            |
| **Elf64_Off**   | 64 位版本偏移地址     | `uint64_t` | 8            |
| **Elf64_Sword** | 64 位版本有符号整型   | `int32_t`  | 4            |
| **Elf64_Word**  | 64 位版本无符号整型   | `uint32_t` | 4            |



带上示例来解释:

| 成员            | 内容                                     | 物理/逻辑解释                                                                 |
| :-------------- | :--------------------------------------- | :---------------------------------------------------------------------------- |
| **e_ident**     | **Magic**: 7f 45 4c 46 01 01 01 00...    | **ELF 魔数**。包含文件机器字节长度、数据存储方式、版本、运行平台及 ABI 版本。 |
| **e_type**      | **Type**: REL (Relocatable file)         | **ELF 文件类型**。标识是可重定位文件、可执行文件还是共享对象文件。            |
| **e_machine**   | **Machine**: Intel 80386                 | **CPU 平台属性**。相关常量以 `EM_` 开头（如 EM_386）。                        |
| **e_version**   | **Version**: 0x1                         | **ELF 版本号**。通常为常数 1。                                                |
| **e_entry**     | **Entry point address**: 0x0             | **入口地址**。规定程序开始执行的虚拟地址。可重定位文件（.o）通常为 0。        |
| **e_phoff**     | **Start of program headers**: 0          | **程序头（Program Header）偏移**。在链接视图中暂不关心，执行视图的核心。      |
| **e_shoff**     | **Start of section headers**: 280        | **段表（Section Header）偏移**。即段表在文件内的起始物理位置。                |
| **e_word**      | **Flags**: 0x0                           | **ELF 标志位**。标识特定平台相关的属性，格式通常为 `EF_machine_flag`。        |
| **e_ehsize**    | **Size of this header**: 52 (bytes)      | **ELF 文件头本身的大小**。在本例中物理占据 52 字节。                          |
| **e_phentsize** | **Size of program headers**: 0           | **程序头描述符的大小**。                                                      |
| **e_phnum**     | **Number of program headers**: 0         | **程序头描述符的数量**。                                                      |
| **e_shentsize** | **Size of section headers**: 40 (bytes)  | **段表描述符的大小**。物理上等于 `sizeof(Elf32_Shdr)`。                       |
| **e_shnum**     | **Number of section headers**: 11        | **段的数量**。物理记录了 ELF 文件中拥有的段表描述符总数。                     |
| **e_shstrndx**  | **Section header string table index**: 8 | **段表字符串表下标**。存储段名字符串的表在段表中的物理索引位置。              |

##### 魔数详解
e_ident成员的前四个字节`7f 45 4c 46`中,第一个字节对应的是ASCII中的DEL控制符,后三个字节刚好是ELF这三个字母的ASCII码,从而唯一标识了ELF文件,故被称为**ELF文件的魔数**.

>接下来的一个字节用来标识ELF的文件类,`01`表示是32位的,`02`表示是64位的;第六个字节是字节序,规定该文件是大端存储还是小端存储;第七个字节为该文件的主版本号,一般是1,因为ELF标准从1.2版后就没有更新过.后面的9个字节ELF标准没有定义,一般填0.
>至于为什么要多出来这9个字节,主要是为了兼容老编译器的考量.



自然,所有的可执行文件都有一个**魔数**用来标识自己,比如PE/COFF文件的最开始两个字节为`4d,5a`,即ASCII字符MZ.

#### 段表
>段表用于保存ELF文件中各个section(段)的基本信息,比如段的名字,长度,存储位置,读写权限等属性.编译器,链接器和装载器都是依靠段表来定位和访问各个段的属性的,至于段表的位置则是由文件头中的`e_shoff`字段来定义的.

- 尽管书上讲的很详细,但我想只需要大概知道段表的作用即可

#### 重定位表
链接器在处理目标文件的时候,需要对目标文件中的某些部分进行重定位,即.text段和.data段中对绝对地址引用的位置.

对于每个要重定位的.text段和.data段,都会有一个相应的重定位表.

### 链接的接口: symbol
如果目标文件B用到了目标文件A中的函数foo,那么就称A**定义**(define)了foo,B**引用**(reference)了A中的函数foo.

在链接中,函数和变量统称为符号(symbol),函数名和变量名则为符号名(symbol name).

链接中很关键的一部分就是符号的管理,每一个目标文件都有一个相应的**符号表**,记录该目标文件中用到的所有符号,每个定义的符号有一个对应的**符号值**,对于变量和函数来说,符号值就是它们的地址.

除了函数和变量之外，还存在其他几种不常用到的符号。我们将符号表中所有的符号进行分类，它们可能是下面这些类型中的一种：

* 定义在本目标文件的**全局符号**，可以被其他目标文件引用。比如 SimpleSection.o 里面的 “func1”、“main” 和 “global_init_var”。
* 在本目标文件中引用的全局符号，却没有定义在本目标文件，这一般叫做**外部符号**（External Symbol），也就是我们前面所讲的符号引用。比如 SimpleSection.o 里面的 “printf”。
* 段名，这种符号往往由编译器产生，它的值就是该段的起始地址。比如 SimpleSection.o 里面的 “.text”、“.data” 等。
* 局部符号，这类符号只在编译单元内部可见。比如 SimpleSection.o 里面的 “static_var” 和 “static_var2”。调试器可以使用这些符号来分析程序或崩溃时的核心转储文件。这些局部符号对于链接过程没有作用，链接器往往也忽略它们。
* 行号信息，即目标文件指令与源代码中代码行的对应关系，它也是可选的。
#### 符号修饰与函数签名
在cpp中我们可以通过命名空间(namespace)和函数重载定义多个同名函数,那么编译器和链接器就需要在链接过程中区分这两个函数.

首先,我们可以使用**函数签名**(function signature)来区分不同的函数,它包含了函数的名字,参数类型,命名空间,所在的类及其他信息.这样可以保证每一个函数都有一个独特的函数签名.

其次,我们可以根据函数签名在编译过程中**修饰**这些函数,例如:
| 函数签名             | 修饰后名称（符号名） |
| :------------------- | :------------------- |
| int func(int)        | _Z4funci             |
| float func(float)    | _Z4funcf             |
| int C::func(int)     | _ZN1C4funcEi         |
| int C::C2::func(int) | _ZN1C2C24funcEi      |
| int N::func(int)     | _ZN1N4funcEi         |
| int N::C::func(int)  | _ZN1N1C4funcEi       |

自然,cpp中的全局变量和静态变量也有同样的签名和修饰机制,而C语言由于不存在重名机制,故不需要对涉及的符号进行**任何修改**.


#### 强弱符号
在C/CPP中,函数和初始化的全局变量为**强符号**(strong symbol),未初始化的全局变量为**弱符号**(weak symbol).


编译器按照以下三个规则来处理强弱符号:
1. 不允许强符号被**多次定义**,否则链接器会报出符号重复定义的错误
2. 如果一个符号在某个目标文件中是强符号,在其他目标文件中是弱符号,则将它看作为强符号
3. 如果一个符号在所有目标文件中都是弱符号,那么选择占用空间最大的一个作为它的定义,如int和double中选择double.
#### 强弱引用
当目标文件中引用外部符号时,如果在链接时,没有找到该符号的定义,那么就会报出未定义错误,这类引用被称为强引用(strong reference).

但是还有一类特殊的引用即使在链接时没找到该符号的定义也不报错,被称为弱引用(weak reference).这允许了冗余代码和缺失功能模块的设计.
#### 调试信息
目标文件里还会保存调试信息,如果我们用GCC编译时加上 “-g” 参数，编译器就会在产生的目标文件里面加上调试信息，我们通过 readelf 等工具可以看到，目标文件里多了很多 “debug” 相关的段：

| [Nr] | Name             | Type     | Addr     | Off    | Size   | ES   | Flg  | Lk   | Inf  | Al   |
| :--- | :--------------- | :------- | :------- | :----- | :----- | :--- | :--- | :--- | :--- | :--- |
| ...  |                  |          |          |        |        |      |      |      |      |      |
| [ 4] | .debug_abbrev    | PROGBITS | 00000000 | 000040 | 000034 | 00   | 0    | 0    | 1    |      |
| [ 5] | .debug_info      | PROGBITS | 00000000 | 000074 | 0000af | 00   | 0    | 0    | 1    |      |
| [ 6] | .rel.debug_info  | REL      | 00000000 | 000738 | 000038 | 08   | 9    | 5    | 4    |      |
| [ 7] | .debug_line      | PROGBITS | 00000000 | 000123 | 000037 | 00   | 0    | 0    | 1    |      |
| [ 8] | .rel.debug_line  | REL      | 00000000 | 000770 | 000008 | 08   | 19   | 7    | 4    |      |
| [ 9] | .debug_frame     | PROGBITS | 00000000 | 00015c | 000034 | 00   | 0    | 0    | 4    |      |
| [10] | .rel.debug_frame | REL      | 00000000 | 000778 | 000010 | 08   | 19   | 9    | 4    |      |
| [11] | .debug_loc       | PROGBITS | 00000000 | 000190 | 00002c | 00   | 0    | 0    | 1    |      |

- 调试信息在目标文件和可执行文件中占用了很大的空间,往往比程序的代码和数据本身大好几倍,因此,发布程序时,我们需要去除这些对于用户没有用的调试信息,从而节省大量的空间
  - 例如可以在VS中选用Release模式而非Debug模式,从而将大部分调试信息排除在打包的可执行文件以外.

## 静态链接(4/15)
![示意图](PixPin_2026-04-19_15-13-29.webp)
当我们运行`gcc -c a.c b.c`后,得到两个目标文件`a.o`和`b.o`,如何将他们链接起来,形成一个可执行文件?这个过程中发生了什么?
### 链接方法
对于多个目标文件,链接器有以下两种方法,将他们的各个段(section)合并到一个可执行文件中:
1. 按序叠加
2. 相似段合并
#### 按序叠加
这种方法将输入的目标文件按照次序叠加起来:
![示意图](PixPin_2026-04-19_15-18-14.webp)
显然,这种做法非常浪费空间,会堆积一大堆冗余数据

#### 相似段合并
将相同性质的段合并到一起是一个更为实际的方法,也是主流的链接器空间分配策略:
![示意图](PixPin_2026-04-19_15-22-42.webp)
这种链接方式分为两步:
1. **空间和地址分配**: 扫描所有的目标文件,将符号表中的所有信息统一放到一个全局符号表
2. **符号解析和重定位**: 根据上一步的信息,进行符号解析和重定位,调整代码中的地址

### 空间与地址分配

通过 `objdump -h` 命令观察目标文件 `a.o`、`b.o` 以及链接后的可执行文件 `ab` 的段分配情况：

#### a.o (目标文件)
| Idx  | Name      | Size     | VMA      | LMA      | File off | Algn   | Flags                                        |
| :--- | :-------- | :------- | :------- | :------- | :------- | :----- | :------------------------------------------- |
| 0    | **.text** | 00000034 | 00000000 | 00000000 | 00000034 | 2\*\*2 | CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE |
| 1    | **.data** | 00000000 | 00000000 | 00000000 | 00000068 | 2\*\*2 | CONTENTS, ALLOC, LOAD, DATA                  |
| 2    | **.bss**  | 00000000 | 00000000 | 00000000 | 00000068 | 2\*\*2 | ALLOC                                        |

#### b.o (目标文件)
| Idx  | Name      | Size     | VMA      | LMA      | File off | Algn   | Flags                                        |
| :--- | :-------- | :------- | :------- | :------- | :------- | :----- | :------------------------------------------- |
| 0    | **.text** | 0000003e | 00000000 | 00000000 | 00000034 | 2\*\*2 | CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE |
| 1    | **.data** | 00000004 | 00000000 | 00000000 | 00000074 | 2\*\*2 | CONTENTS, ALLOC, LOAD, DATA                  |
| 2    | **.bss**  | 00000000 | 00000000 | 00000000 | 00000078 | 2\*\*2 | ALLOC                                        |

#### ab (链接后的可执行文件)
| Idx  | Name      | Size     | VMA      | LMA      | File off | Algn   | Flags                                 |
| :--- | :-------- | :------- | :------- | :------- | :------- | :----- | :------------------------------------ |
| 0    | **.text** | 00000072 | 08048094 | 08048094 | 00000094 | 2\*\*2 | CONTENTS, ALLOC, LOAD, READONLY, CODE |
| 1    | **.data** | 00000004 | 08049108 | 08049108 | 00000108 | 2\*\*2 | CONTENTS, ALLOC, LOAD, DATA           |

* **VMA (Virtual Memory Address)**：链接前目标文件的 VMA 均为 `0`，因为尚未物理分配虚拟地址；链接后 `ab` 中的段被物理分配到了以 `0804xxxx` 开头的地址空间。
  * **LMA(Load Memory Address)**: 装载地址,正常情况下该值与VMA相同,但在部分嵌入式系统中,两个值是不同的.
* **Size 合并**：`ab` 的 `.text` 段大小（`0x72`）约等于 `a.o`（`0x34`）与 `b.o`（`0x3e`）之和，体现了链接器的**段合并策略**。
* **Flags 变化**：链接后的 `ab` 移除了 `RELOC` 标志，说明物理重定位已完成。

>可执行文件里没有物理地址,在执行时才由操作系统将虚拟地址映射到物理地址
### 符号解析与重定位(4/22)
- **重定位**: 修正编译器产生的**符号**(函数与变量)地址
- **符号解析**: 根据全局符号表查找所需符号的地址,用于重定位

### C++相关的链接问题(待补充)
## Windows PE/COFF
>之所以叫PE/COFF,是因为windows32位的可执行文件格式PE与ELF一样,都是从古老的COFF格式发展来的.换句话说,**PE(Portable Executable)**是COFF的一种扩展,结构上大致相同,与ELF格式也基本相同,都采用了**段的格式**
- windows64位中,对原本的PE格式做了一点修改,叫做PE32+,它没有增加新的字段,只是把原来的32位字段变成了64位,因此我们也可以把它看作是一般的PE文件.

总的来说的话,在Windows中目标文件为COFF格式,为`.obj`后缀;可执行文件/动态链接库为PE格式,为`.exe`/`dll`后缀

### COFF文件结构
**COFF 目标文件格式 (COFF Object File Format)** 的常见结构如下：
1.  **Image Header** (`IMAGE_FILE_HEADER`)
2.  **Section Table** (`IMAGE_SECTION_HEADER[]`)
3.  **.text**（代码节）
4.  **.data**（数据节）
5.  **.drectve**（指示节）
6.  **.debug$S**（调试符号节）
7.  **other sections**（其他节）
8.  **Symbol Table**（符号表）

- 与ELF文件格式确实很像

前两个部分是COFF文件的文件头,分别是描述文件总体结构和属性的映像头和描述各段属性的段表

- **映像**(image): PE文件在装载时会被直接映射到进程的虚拟空间中,是进程虚拟空间的映像.
### PE文件结构
**PE 文件格式 (PE File Format)** 的常见结构如下：

1.  **Image DOS Header** (`IMAGE_DOS_HEADER`)
2.  **Image DOS Stub**
3.  **PE File Header** (`IMAGE_NT_HEADERS`)
    * **Image Header** (`IMAGE_FILE_HEADER`)
    * **Image Optional Header** (`IMAGE_OPTIONAL_HEADER32`)
4.  **Section Table** (`IMAGE_SECTION_HEADER[]`)
5.  **.text**
6.  **.data**
7.  **.drectve**
8.  **.debug$S**
9.  **other sections**
10. **Symbol Table**

第一段和第二段中DOS部分的来历:

>在Windows发展的早期,古老的DOS系统还十分盛行,而此时的Windows甚至不能脱离DOS环境独立运行,所以为Windows1编写的程序必须加入这两个DOS段来兼容DOS系统.
为了兼容古老的程序,直到现在的Windows可执行文件都包含了这两个段

#### Image DOS Header详解
“IMAGE_DOS_HEADER”结构也被定义在 WinNT.h 里面，该结构的大多数成员我们都不关心，唯一值得关心的是“e_lfanew”成员，这个成员表明了 PE 文件头（IMAGE_NT_HEADERS）在 PE 文件中的偏移，我们需要使用这个值来定位 PE 文件头。

这个成员在 DOS 的“MZ”文件格式中的值永远为 0，所以当 Windows 开始执行一个后缀名为“.exe”的文件时，它会判断“e_lfanew”成员是否为 0。如果为 0，则该“.exe”文件是一个 DOS“MZ”可执行文件，Windows 会启动 DOS 子系统来执行它；如果不为 0，那么它就是一个 Windows 的 PE 可执行文件，“e_lfanew”的值表示“IMAGE_NT_HEADERS”在文件中的偏移。
#### Image DOS Stub详解
当 PE 可执行映像在 DOS 下被加载的时候，DOS 系统检测该文件，发现最开始两个字节是“MZ”，于是认为它是一个“MZ”可执行文件。然后 DOS 系统就将 PE 文件当作正常的“MZ”文件开始执行。

DOS 系统会读取 **“e_cs”** 和 **“e_ip”** 这两个成员的值，以跳转到程序的入口地址。然而 PE 文件中，“e_cs”和“e_ip”这两个成员并不指向程序真正的入口地址，而是指向文件中的 **“DOS Stub”**。

**“DOS Stub”** 是一段可以在 DOS 下运行的一小段代码，这段代码的唯一作用是向终端输出一行字：
> **“This program cannot be run in DOS”**

然后退出程序，表示该程序不能在 DOS 下运行。所以我们如果在 DOS 系统下运行 Windows 的程序就可以看到上面这句话，这是因为 PE 文件结构兼容 DOS “MZ” 可执行文件结构的缘故。
## 可执行文件的装载
>可执行文件只有**装载**到内存以后才能被 CPU 执行。早期的程序装载十分简陋，装载的基本过程就是把程序从外部存储器中读取到内存中的某个位置。随着硬件 MMU 的诞生，多进程、多用户、虚拟存储的操作系统出现以后，可执行文件的装载过程变得非常复杂。
### 进程虚拟地址空间
如前所说,可执行文件里的地址都是虚拟地址,在运行时拥有自己独立的虚拟空间地址,并被操作系统映射到实际的硬件地址上.

在32位平台下,我们有4GB(2^32-1)的虚拟空间地址可以分配.

默认情况下,Linux会将这4GB分成两部分:

1. 1GB的操作系统空间
2. 3GB的用户进程运行空间,换句话说,所有的代码,数据申请的虚拟空间之和不可以超过3GB

而在Windows中,默认情况下会分给操作系统2GB空间(因为系统比Linux更为臃肿庞大),进程只有2GB空间,尽管我们可以通过修改启动参数来将操作系统的空间减少到1GB.

### 装载的方式
程序执行时所需要的指令和数据**必须在内存中**才能够正常运行,但我们永远不会也不需要在内存里装载所有程序的指令.只需要将**程序最常用的部分**驻留在内存中,将**不太常用的数据**存放在磁盘里,这被称为动态装载,即只装载当前所需的数据,不需要的数据就放在磁盘中.

动态装载有两种具体的实现方法:
1. 覆盖装载(Overlay): 已经被完全淘汰
2. 页映射(Paging): 现代操作系统都使用该方法

#### 覆盖装载
>尽管该方法被淘汰了,但体现的一些思想还是很有意义的,并且在内存受限的环境下还可能用得到.

程序员在编写程序的时候必须手工将程序分割成若干块,还需要编写一个**辅助代码**(被称为**覆盖管理器**(overlay manager)),用于管理模块何时驻留内存以及何时被替换,这个覆盖管理器需要常驻内存指挥内存调用.

之所以叫覆盖装载,是因为我们可以在程序的某个部分不再被用到时,把一个被用到的程序部分装载到它的内存空间,从而节省内存.

- 显然,当程序复杂起来时,我们需要考虑程序之间的依赖关系,保证覆盖时不会影响其他正在使用的进程.不管怎样,确实非常麻烦.
#### 页映射
页映射将内存和所有磁盘中的数据和指令按照页(Page)为单位划分并进行操作和装载.

- Intel IA32处理器使用4096字节的页,那么512MB的物理内存就有`512*1024*1024/4096=131072`个页

当内存中的剩余空间不足以容纳新进程时,我们就需要抛弃旧的进程来腾出空间,有两种简单的算法来选择被抛弃的进程:
1. 先进先出(FIFO): 将第一个被分配的内存页抛弃
2. 最少使用(LUR): 将最不常用的内存页抛弃

不管使用的什么算法,我们都由**操作系统的存储管理器**来进行内存页的分配和抛弃,所以接下来让我们从操作系统的角度看看可执行文件的装载过程

### 实际的装载过程
#### 创建进程
创建进程需要做以下三件事:
1. 创建一个独立的虚拟地址空间
2. 读取可执行文件头,建立虚拟空间和可执行文件的映射关系
3. 将cpu的指令寄存器设置成可执行文件的入口地址,运行可执行文件
#### 页错误
上述的步骤执行完后,可执行文件的真正指令和数据都没有被装入内存,**仅仅是在内存开辟一个存放虚拟地址映射关系的数据结构而已**.

当CPU开始在入口地址执行可执行文件时,发现往后的页面都是空的,不存在任何数据,这被称为**页错误**(Page Fault),于是CPU将控制权交给操作系统,让操作系统根据数据结构找到空页面对应的**VMA(Virtual Memory Area,虚拟内存区域)**,这个VMA就是进程中代码所对应的执行空间.

操作系统在物理内存中分配该VMA对应的物理页,并将控制权还给CPU,让进程从刚才的页错误位置重新开始执行.

随着进程的执行,页错误不断产生,新的VMA也不断地被分配,直到所有的页面都被读取完,这时进程也被执行完了.

#### VMA区域分类
VMA(虚拟内存区域)除了用来映射要执行的代码段/数据段等`section`外,还可以用来存储**栈(stack)和堆(heap)**,整体上我们可以将进程分为以下几种VMA:


| VMA 类型     | 权限特征         | 映射源 (Backing Store)   | 内存性质               | 扩展方向          |
| :----------- | :--------------- | :----------------------- | :--------------------- | :---------------- |
| **代码 VMA** | 只读、可执行     | 可执行映像文件 (`.text`) | 文件映射 (File-backed) | 固定              |
| **数据 VMA** | 可读写、可执行   | 可执行映像文件 (`.data`) | 文件映射 (File-backed) | 固定              |
| **堆 VMA**   | 可读写、可执行   | 无 (由内核分配物理页)    | 匿名内存 (Anonymous)   | 向上扩展 (高地址) |
| **栈 VMA**   | 可读写、不可执行 | 无 (由内核分配物理页)    | 匿名内存 (Anonymous)   | 向下扩展 (低地址) |

一个完整的映射关系如下所示:

![示意图](sGemini2.png)
### Linux装载ELF
当我们在Linux的bash中执行某个ELF文件时,**bash进程**调用`fork()`函数创建一个新的进程,新的进程调用`execve()`函数来执行该ELF文件,原先的**bash进程**等待该新进程结束后用户重新输入的命令.

执行可执行文件的具体过程如下:

1. `execve()`函数会调用`do_execve()`函数,读取被执行的文件的前128个字节来确定文件格式
   1. >为什么要这么做呢？因为我们知道，**`Linux`** 支持的可执行文件不止 **`ELF`** 一种，还有 **`a.out`**、**`Java`** 程序和以 **`“#!”`** 开始的脚本程序。**`Linux`** 还可以支持更多的可执行文件格式，如果某一天 **`Linux`** 须支持 **`Windows PE`** 的可执行文件格式，那么我们可以编写一个支持 **`PE`** 装载的内核模块来实现 **`Linux`** 对 **`PE`** 文件的支持。这里 **`do_execve()`** 读取文件的前 128 个字节的目的是**判断文件的格式**，每种可执行文件的格式的开头几个字节都是很特殊的，特别是**开头 4 个字节**，常常被称作**魔数（`Magic Number`）**，通过对魔数的判断可以确定文件的格式和类型。比如 **`ELF`** 的可执行文件格式的头 4 个字节为 **`0x7F`**、**`'e'`**、**`'l'`**、**`'f'`**；而 **`Java`** 的可执行文件格式的头 4 个字节为 **`'c'`**、**`'a'`**、**`'f'`**、**`'e'`**；如果被执行的是 **`Shell`** 脚本或 **`perl`**、**`python`** 等这种解释型语言的脚本，那么它的第一行往往是 **`“#!/bin/sh”`** 或 **`“#!/usr/bin/perl”`** 或 **`“#!/usr/bin/python”`**，这时候**前两个字节** **`'#'`** 和 **`'!'`** 就构成了魔数，系统一旦判断到这两个字节，就对后面的字符串进行解析，以确定具体的解释程序的路径。
2. 之后Linux根据文件格式调用对应的**装载函数**,比如ELF的装载函数叫做`load_elf_binary()`
3. 以`load_elf_binary()`为例,它会执行以下步骤:
   1. 检查 ELF 可执行文件格式的有效性，比如魔数、程序头表中段（Segment）的数量。
   2. 设置动态链接器路径
   3. 根据 ELF 可执行文件的程序头表的描述，对 ELF 文件进行映射，比如代码、数据、只读数据。
   4. 初始化 ELF 进程环境，比如进程启动时 EDX 寄存器的地址应该是 DT_FINI 的地址（参照动态链接）。
   5. 将系统调用的返回地址修改成 ELF 可执行文件的入口点，这个入口点取决于程序的链接方式，对于静态链接的 ELF 可执行文件，这个程序入口就是 ELF 文件的文件头中 e_entry 所指的地址；对于动态链接的 ELF 可执行文件，程序入口点是动态链接器。
4. 当**装载函数**执行完毕时,上述的第五步已经将寄存器的地址改成了ELF程序的入口地址了,于是开始真正执行该程序,完成装载
### Windows装载PE
- RVA: Relative Virtual Address,相对虚拟地址,相对于PE文件的装载基地址的偏移地址

装载一个 **`PE`**（**`Portable Executable`**）文件并执行是一个比 **`ELF`** 相对简单的过程：

#### **一、 头部读取与校验**
*   **读取首页**：首先读取文件的第一个页，其中包含了 **`DOS 头`**、**`PE 文件头`**和**`段表`**。

#### **二、 地址空间分配**
*   **检查目标地址**：检查进程地址空间中，目标地址是否可用。
*   **地址占用处理**：如果不可用，则另外选择一个装载地址。对于可执行文件（`.exe`）来说，这通常不是问题，因为它是进程第一个装入的模块。该步骤主要针对 **`DLL`** 文件的装载。

#### **三、 内存映射与重定位**
*   **段映射**：使用段表提供的信息，将 **`PE`** 文件中所有的段一一映射到地址空间中相应的起始位置。
*   **进行 Rebasing**：如果实际装载地址不是预设的目标地址，则进行 **`Rebasing`**（重定向）。

#### **四、 符号解析与依赖处理**
*   **装载 DLL**：装载所有 **`PE`** 文件运行所需的 **`DLL`** 动态链接库文件。
*   **解析导入符号**：对 **`PE`** 文件中的所有导入符号进行解析与绑定。

#### **五、 环境初始化与启动**
*   **建立栈和堆**：根据 **`PE`** 头中指定的参数，建立初始化的**栈（`Stack`）**和**堆（`Heap`）**。
*   **启动进程**：建立主线程并且启动进程。

## 动态链接
### 动态链接的引入
#### 空间浪费
>尽管静态链接很简单,但是**会浪费大量的内存和磁盘空间**，想象一下每个程序内部除了都保留着 printf()函数、scanf()函数、strlen()等这样的公用库函数，还有数量相当可观的其他库函数及它们所需要的辅助数据结构。在现在的 Linux 系统中，一个普通程序会使用到的 C 语言静态库至少在 1 MB 以上，那么，**如果我们的机器中运行着 100 个这样的程序，就要浪费近 100 MB 的内存**；如果磁盘中有 2 000 个这样的程序，就要浪费近 2 GB 的磁盘空间，很多 Linux 的机器中，/usr/bin 下就有数千个可执行文件。
#### 更新困难
>静态链接对程序的更新、部署和发布也会带来很多麻烦。比如程序 Program1 所使用的 Lib.o 是由一个第三方厂商提供的，当该厂商更新了 Lib.o 的时候（比如修正了 lib.o 里面包含的一个 Bug），那么 Program1 的厂商就需要拿到最新版的 Lib.o，然后将其与 Program1.o 链接后，将新的 Program1 整个发布给用户。这样做的缺点很明显，即一旦程序中有任何模块更新，整个程序就要重新链接、发布给用户。比如一个程序有 20 个模块，每个模块 1 MB，那么每次更新任何一个模块，用户就得重新获取这个 20 MB 的程序。如果程序都使用静态链接，那么通过网络来更新程序将会非常不便，**因为一旦程序任何位置的一个小改动，都会导致整个程序重新下载**。

#### 动态链接是什么
要解决上述两个问题,有一个很简单的方法: 把程序划分成多个独立的文件,而不是静态地拼接在一起,直到程序要运行时再进行链接.换句话说,**动态链接**把链接这个过程**推迟到了程序运行时再执行**.

比如说,当我们拆分出`p1.o,p2.o,lib.o`这三个目标文件,当`p1.o`被系统加载到内存时,发现还需要导入`lib.o`,那么系统接着加载`lib.o`到内存,如果它们还依赖其他的目标文件,则一并导入,等到所有的依赖关系都满足时,系统开始将这些文件链接在一起后开始运行.

如果还需要运行`p2.o`,我们不需要重新加载`lib.o`,因为它已经被载入内存里了,系统只需要将`p2.o`与`lib.o`链接在一起即可.

#### 动态链接的基本实现
实际的动态链接过程中,我们无法直接把目标文件拿来链接,而是要把目标文件稍加改动.

在Linux中,ELF动态链接文件被称为**动态共享对象**(DSO,Dynamic Shared Objects),文件扩展名为`.so`;在Windows中,动态链接文件被称为**动态链接库**(Dynamical Linking Library),文件扩展名为`.dll`.

>由于动态链接在程序每次装载时都要重新进行链接,会导致程序的一些性能损失,**经过优化之后的性能损失大约在5%以下**,影响并不大,这样看来还是很值得的.

### 地址无关代码
在动态链接的情况下,由于共享文件是一个个装载的,我们无法确定后来的文件会不会占用先前的文件的虚拟地址,如果通过硬编码的形式来一一指定文件的虚拟地址,那么就极易出现错误和混淆.因此,我们有两种可能的方法来解决这个问题:

1. 装载时重定位
2. 地址无关代码

>可执行文件往往是第一个被加载的文件,因此它可以硬编码自己的虚拟空间地址,无需程序员担忧.

#### 装载时重定位
该想法的思路是: **在链接时不重定位所有绝对地址的引用,而是推迟到装载时进行重定位**,这又被称为基址重置(Rebasing).

该方法并不适合解决上述问题,由于装载时重定位后还需要按照可执行文件的地址对指令修改,**那么同一个共享文件的指令部分是无法被多个进程共享的.**比如说可执行文件A的物理地址是100,那么指令就要修改成`jmp 100`,但如果可执行文件B的物理地址是500的话,修改后的共享文件就无法识别了.
#### 地址无关代码
**地址无关代码(PIC,Position-independent Code)**,基本想法是将共享文件中需要修改的指令部分分离出来,和数据部分放在一起,这样共享文件的指令部分就可以保持不变,而数据部分可以在每个进程中拥有一个副本.

我们先分析一下代码中各种类型的地址引用方式,从而确定哪些指令部分需要重定位:

![示意图](image.png)

##### 类型一: 模块内部调用或跳转
由于被调用的函数与调用者位于同一个文件中,相对位置是固定的,所以不需要重定位.
##### 类型二: 模块内部数据访问
由于文件被分页之后的相对位置是固定的,数据部分和指令部分往往是在相邻的页中,因此我们可以通过相对寻址来访问内部数据,通常也不需要重定位.
##### 类型三: 模块间数据访问
不同模块间的访问地址需要到装载时才能确定,为了保证代码是地址无关的,我们需要建立一个指向这些外部全局变量的指针数组,也被称为**全局偏移表**(Global Offset Table),当代码需要引用外部全局变量时,可以根据GOT来查找并间接引用该变量.

详细过程如下:

1. 动态链接器在装载时会查找每个变量所在的地址来填充GOT,将其存放在数据段
2. 需要访问外部变量时,程序根据GOT查找到该变量的目标地址

![示意图](ssimage-1.png)
##### 类型四: 模块间调用和跳转
显然,我们可以把函数的地址也放入GOT中实现简单的调用和跳转,但ELF采用了一种更加复杂和精巧的方法,会在之后涉及.


### 延迟绑定
**延迟绑定(Lazy Binding)**的基本思想是,**只有当函数第一次被用到时才进行绑定**(符号查找,重定位等),如果没有用到则不进行绑定,这样就可以大幅加快程序的启动速度.
- 具体原理非常无聊,就不展开了


### Linux中的动态链接
在可执行文件被映射到虚拟空间后,操作系统会启动**动态链接器**(Dynamic Linker)来进行动态链接,在Linux中动态链接器就是`ld.so`文件,可以看得到它本身也是一个共享对象.

Linux在加载完ld后,会进入ld的入口地址开始执行初始化和动态链接操作.

### 实际的动态链接
动态链接的步骤可以分为以下三步:
1. 启动动态链接器
2. 加载所有需要的共享对象(.so或者.dll文件)
3. 重定位和初始化
#### 启动动态链接器
其他共享文件的重定位可以依靠动态链接器来执行,但动态链接器本身是不可以依靠其他文件的,也就是说它不可以用到**其他库**,也不可以在启动的时候用到**全局变量和静态变量**.这被称为**自举(Bootstrap)**.

- 在某些情况下,动态链接器启动的时候也不可以调用函数,可想而知动态链接器代码的编写有多么困难
#### 装载共享对象
根据可执行文件依赖的所有共享对象进行递归导入,一般来说采用广度优先算法,即bfs.
#### 重定位和初始化
重新遍历可执行文件和所有共享对象的重定位表,修正需要再次重定位的地址
## Windows中的动态链接
### DLL简介
Windows中的DLL文件与EXE文件均是PE格式的二进制文件,稍微不同的地方在于PE文件头中有符号位表明该文件是EXE还是DLL,同时DLL文件的扩展名未必是`.dll`,还可以是`.ocx`和`.cpl`.

ELF中默认所有的全局符号(全局函数和变量)都可以被导出,但在DLL中默认所有符号都不导出,我们需要显式告诉编译器我们需要导出某个符号.一种方法是在符号名字前加上`__declspec`关键字修饰,但也可以通过CMake进行自动添加.
### 符号导出导入表
#### 导出表
当一个PE需要将一些函数或者变量提供给其他PE使用时,我们称之为**符号导出**.在PE中,所有需要导出的符号都集中存放在了文件头的**导出表***中,它的结构如下:
```c
typedef struct _IMAGE_EXPORT_DIRECTORY {
    DWORD   Characteristics;
    DWORD   TimeDateStamp;
    WORD    MajorVersion;
    WORD    MinorVersion;
    DWORD   Name;
    DWORD   Base;
    DWORD   NumberOfFunctions;
    DWORD   NumberOfNames;
    DWORD   AddressOfFunctions;     // RVA from base of image
    DWORD   AddressOfNames;         // RVA from base of image
    DWORD   AddressOfNameOrdinals;  // RVA from base of image
} IMAGE_EXPORT_DIRECTORY;
```
#### 导入表
如果在某个程序中用到了来自dll的函数或者变量,我们称为**符号导入**,所有被导入的dll地址存放在文件头的**导入表**中
### 后续部分待补充
## 内存
内存空间中有一部分是要保留给操作系统使用的,剩下的空间被称为**用户空间**,有如下区域:
1. 栈: 维护函数调用的上下文,一般位于用户空间的最高地址处,通常有几个MB大小
2. 堆: 容纳应用程序动态分配的内存区域,位于栈的下方,比栈的容量大,可至数百兆字节
3. 可执行文件映像: 可执行文件装载时的位置.
4. 保留区: 不是一个单一的内存区域,而是对内存中受到保护而禁止访问的内存区域的总称.
   - 例如,大多数操作系统里,极小的地址都是不允许访问的

Linux的内存分配如图所示:
![示意图](PixPin_2026-05-08_08-03-55.webp)

可以看到,栈向低地址增长,而堆向高地址增长,但在Windows系统中,就不是这样了:
![示意图](PixPin_2026-05-09_11-28-58.webp)

可以看到堆和栈都是散乱分布的,而Windows中的堆也不存在向上增长的规律.
### 栈
栈保存了函数调用所需要的维护信息:
1. 函数的返回地址和参数
2. 临时变量
3. 保存的上下文: 在函数调用前后需要保持不变的寄存器

在i386中,一个函数的活动记录使用ebp和esp两个寄存器划定范围:
1. **esp(Extended Stack Pointer)**: 始终指向当前函数栈帧的顶部,故随着函数运行会有所变动
2. **ebp (Extended Base Pointer)**: 固定指向函数调用前ebp的值,通过偏移量可以定位函数调用时的各个参数,还可以在函数返回时,帮助恢复到调用前的值.

i386中的函数调用过程:
1. 把所有或者一部分参数压入栈中
2. 把当前指令的下一条指令地址压入栈中
3. 跳转到函数体执行

- 后面是一大段逆向分析,就直接跳过了
### 堆与内存管理
栈上的数据在函数返回时就会被释放掉,无法将数据传递到函数外部,而程序运行时又无法产生新的全局变量,只能在编译的时候就确定,所以**堆**就成了唯一的选择.

堆的占用空间巨大,往往占据了用户空间的绝大部分,程序可以在堆中申请一块连续内存并自由使用,直到程序主动放弃前都一直可用.

例如在C语言中可以这样申请堆内存:
```c
int main(){
  // 创建一个有1000字节大小的char数组
  char* p =(char*) malloc(1000);
  // 随便做点什么
  free(p); //释放掉内存
}
```

malloc的实现有两种可能的方法:
1. 每次申请空间时都进行**系统调用**,让系统来管理内存,由于系统调用的开销很大,要经过多层API,所以会严重影响性能
2. 程序向操作系统申请一块空间后,由程序自己管理内存,这种做法也是实际的内存分配过程.

>malloc本身是对Linux的系统函数和Windows系统函数的封装,我们无需知道它的具体分配原理,放心使用即可.

#### 堆分配算法
这里介绍三种比较简单实用的堆分配算法:
1. **空闲链表**:把堆中各个空闲的块按照链表的方式连接起来,当用户请求堆时,可以遍历整个列表,直到找到合适大小的块后再将它拆分分给用户
   1. >![示意图](ssimage-2.png)
   2. 显然这种方法容易将堆空间拆成一个非常破碎的结构,一旦链表被越界的读写操作破坏就无法正常工作.
2. **位图(Bitmap)**: 将整个堆划分成大量大小相同的块,每次分配时都分配数个整块空间给用户,第一个块被称为头(**head**),其余的块被称为主体(**body**),我们可以使用一个整数数组来记录块的使用情况,由于一个块只有 头/主体/空闲 三种状态,故只用两位就可以表示一个块,所以叫做位图.
   1. 具体实现就不附上了,比较琐碎
3. **对象池**: 假定用户每次申请的空间大小都不变,按照这个大小把整个堆空间划分成大量的小块,每次请求的时候只需分给用户一个小块即可,无须反复遍历查找.

在实际使用时,常常是针对不同的空间大小申请采用不同的堆分配算法.

## 运行库
### 入口函数与程序初始化
#### "main创论"
操作系统装载程序后,首先运行的代码并不是main的第一行,而是某些别的代码,这些代码负责初始化main函数执行所需的环境并调用main函数,在main函数返回之后也会记录main函数的返回值,调用收尾函数后结束进程.

运行这些代码的函数被称为**入口函数**,它往往是运行库的一部分,一个典型的程序运行步骤如下:
1. 操作系统创建进程后,跳转到程序入口执行,这个入口即运行库中的某个入口函数
2. 入口函数初始化运行环境,包括堆,I/O,线程,全局变量构造,等等
3. 入口函数初始化之后,调用main函数,正式执行程序主体部分
4. main函数执行完毕后,返回到入口函数,进行清理工作,包括全局变量析构,堆销毁,关闭I/O等,然后结束进程.
### C/C++运行库
#### C语言运行库
一个C语言运行库(C Runtime Library,CRT)包含以下功能:
1. 启动与退出: 入口函数和入口函数依赖的其他函数
2. 标准函数: C语言标准库中的库函数,如**math.h**,**stdio.h**等
3. I/O: I/O功能的封装和实现
4. 堆: 堆的封装和实现
5. 语言实现: 语言中特殊功能的实现
6. 调试: 实现调试功能的代码

>初生的 C 语言在功能上非常不完善，例如不提供 I/O 相关的函数。因此在 C 语言的发展过程中，C 语言社区共同意识到建立一个基础函数库的必要性。与此同时，在 20 世纪 70 年代 C 语言变得非常流行时，许多大学、公司和组织都自发地编写自己的 C 语言变种和基础函数库，因此当到了 80 年代时，C 语言已经出现了大量的变种和多种不同的基础函数库，这对代码迁移等方面造成了巨大的障碍，许多大学、公司和组织在共享代码时为了将代码在不同的 C 语言变种之间移植搞得焦头烂额。于是对此惨状忍无可忍的美国国家标准协会（American National Standards Institute, ANSI）在 1983 年成立了一个委员会，旨在对 C 语言进行标准化，此委员会所建立的 C 语言标准被称为 ANSI C。第一个完整的 C 语言标准建立于 1989 年，此版本的 C 语言标准称为 C89。在 C89 标准中，包含了 C 语言基础函数库，由 C89 指定的 C 语言基础函数库就称为 ANSI C 标准运行库（简称标准库）。其后在 1995 年 C 语言标准委员会对 C89 标准进行了一次修订，在此次修订中，ANSI C 标准库得到了第一次扩充，头文件 iso646.h、wchar.h 和 wctype.h 加入了标准库的大家庭。在 1999 年，C99 标准诞生，C 语言标准库得到了进一步的扩充，头文件 complex.h、fenv.h、inttypes.h、stdbool.h、stdint.h 和 tgmath.h 进入标准库。自此，C 语言标准库的面貌一直延续至今。

## 总结
花了一段时间,总算把这本书读完了,可以说收获满满,透彻了解一个C/C+++程序从编译到运行的整个过程,但是这本书有一些不足之处,列举如下:
1. 结构安排混乱,部分内容前后重复或者顺序不合理
2. 汇编代码分析多,很多地方举的汇编例子并不具有代表性,而且分析的也不够深入,不了解汇编代码的我只好直接跳过
# Deep Learning from Scratch
- [pdf链接](https://github.com/qiaohaoforever/DeepLearningFromScratch/blob/master/%E3%80%8A%E6%B7%B1%E5%BA%A6%E5%AD%A6%E4%B9%A0%E5%85%A5%E9%97%A8%EF%BC%9A%E5%9F%BA%E4%BA%8EPython%E7%9A%84%E7%90%86%E8%AE%BA%E4%B8%8E%E5%AE%9E%E7%8E%B0%E3%80%8B%E9%AB%98%E6%B8%85%E4%B8%AD%E6%96%87%E7%89%88.pdf)
如前所说,阅读<< Transformers快速入门 >>的前提是要搞懂神经网络是什么,于是我辗转找到了这本享有盛名的书,希望能够彻底理解神经网络的概念
## 感知机(perceptron)
感知机是一个类似于电路节点的模型,它接收多个输入信号,输出一个信号,该信号只有两个值: 0和1,**0对应不传递信号**,**1对应传递信号**.
![示意图](PixPin_2026-04-28_10-49-37.webp)

如图:x1和x2是输入信号,被送往y节点时会分别乘以权重(weight),w1和w2,y节点会计算w1x1+w2x2的结果,当总和超过某个界限值时,才会输出1,这也被称为**神经元激活**.我们将这个界限值称为**阈值**,用`θ`表示.

数学公式表示:
![示意图](PixPin_2026-04-28_10-52-25.webp)

但我们可以把阈值与总和移到同一侧:
![示意图](PixPin_2026-04-28_11-01-59.webp)

这里的b就是`-θ`,被称为偏置(bias),决定了神经元被激活的容易程度.

显然,单层感知机是一个线性数学模型,它无法处理非线性空间:

![示意图](PixPin_2026-04-28_11-05-20.webp)

因此,我们可以使用**多层感知机的叠加**来实现非线性模型
### 多层感知机
为了实现异或电路,我们可以这样写:
```py
def XOR(x1, x2):
  s1 = NAND(x1, x2)
  s2 = OR(x1, x2)
  y = AND(s1, s2)
  return y

XOR(0, 0) # 输出 0
XOR(1, 0) # 输出 1
XOR(0, 1) # 输出 1
XOR(1, 1) # 输出 0
```
对应的图像为:

![示意图](PixPin_2026-04-28_11-17-18.webp)

我们将最左边的一列称为第0层,中间一列称为第1层,最右边一列称为第2层,这也就是**多层感知机**(multi-layered perceptron).
## 神经网络
### 从感知机到神经网络
我们之前的多层感知机结构可以再优化一下,将偏置b也作为输入参数:
![示意图](PixPin_2026-04-30_13-04-20.webp)

$$y = \begin{cases} 0 & (b + w_1x_1 + w_2x_2 \le 0) \\ 1 & (b + w_1x_1 + w_2x_2 > 0) \end{cases}$$
并且,由于分段函数不太好看,我们可以将上述式子,改写成下面的两个式子:
$$y = h(b + w_1x_1 + w_2x_2)$$

$$h(x) = \begin{cases} 0 & (x \le 0) \\ 1 & (x > 0) \end{cases}$$

这个h(x)函数会将输入信号的总和转换成输出信号,它被称为**激活函数(activation function)**.

如果我们把总和(add)称为a的话,就可以这样画图:
![示意图](PixPin_2026-04-30_13-11-10.webp)


这就得到了我们的神经网络，我们把最左边的一列称为
输入层，最右边的一列称为输出层，中间列全部称为中间层:
![示意图](PixPin_2026-04-30_12-59-58.webp)


### 激活函数
$$h(x) = \begin{cases} 0 & (x \le 0) \\ 1 & (x > 0) \end{cases}$$
由于上述的阶跃函数太过单调,不具有可操控性,在神经网络中我们通常采用一些非线性的,更复杂的激活函数.

- 之所以不用线性的,是因为多层的线性函数叠加总可以被单层的线性函数所替代.(例如a^3=a * a * a)
#### sigmoid函数
该函数是神经网络的常用激活函数:

$$h(x) = \frac{1}{1 + e^{-x}}$$

效果如下,非常平滑:
![示意图](PixPin_2026-04-30_13-19-50.webp)

#### ReLU函数
ReLU,全称为**Rectified Linear Unit**,比起sigmoid函数更为简单:

$$h(x) = \max(0, x)$$

写成分段函数形式更为清晰一点：
$$h(x) = \begin{cases} x & (x > 0) \\ 0 & (x \le 0) \end{cases}$$

它有以下特性:

*   **线性增长**：当输入 $x$ 大于 0 时，直接输出 $x$，没有任何梯度消失问题。
*   **单侧抑制**：当输入 $x$ 小于等于 0 时，输出硬性截断为 0，使神经元进入“休眠”状态


### 用矩阵来表示神经网络
![示意图](PixPin_2026-04-30_13-40-24.webp)
由于用普通的乘法运算来表示神经网络过于麻烦,所以我们引入了矩阵运算:

$$\boldsymbol{A}^{(1)} = \boldsymbol{X}\boldsymbol{W}^{(1)} + \boldsymbol{B}^{(1)}$$

**其中的几个符号定义如下:**

$$\boldsymbol{A}^{(1)} = \begin{pmatrix} a_1^{(1)} & a_2^{(1)} & a_3^{(1)} \end{pmatrix}$$

$$\boldsymbol{X} = \begin{pmatrix} x_1 & x_2 \end{pmatrix}$$

$$\boldsymbol{B}^{(1)} = \begin{pmatrix} b_1^{(1)} & b_2^{(1)} & b_3^{(1)} \end{pmatrix}$$

$$\boldsymbol{W}^{(1)} = \begin{pmatrix} w_{11}^{(1)} & w_{21}^{(1)} & w_{31}^{(1)} \\ w_{12}^{(1)} & w_{22}^{(1)} & w_{32}^{(1)} \end{pmatrix}$$
### 输出层的处理
对于输出层,我们单独把它的激活函数用`σ()`来表示,用于重点标明它的特殊性.因为根据不同的应用场景我们需要采用不同的输出层激活函数,而中间层的激活函数通常是不用变的.一般来说,**回归问题用恒等函数,分类问题用softmax函数.**

- 在学习过程中和实际部署时,我们可以随时替换输出层,从而实现不同的任务目标.

恒等函数很好理解,将所有输入原样输出,不做任何处理,重点需要理解的是softmax函数
### softmax函数
其公式如下:

$$y_k = \frac{\exp(a_k)}{\sum_{i=1}^{n} \exp(a_i)}$$

- 可以看到,对于每一个输出信号,softmax函数都考虑了所有的输入信号,并通过指数函数进行平滑化处理
- softmax函数的**输出值总和为1**,所以我们可以将softmax函数的输出解释为**概率**

由于当输入信号过大时会导致指数爆炸,使用计算机程序计算softmax函数的结果时会发生数据溢出,所以我们需要对上式做一些加工:

$$y_k = \frac{\exp(a_k)}{\sum_{i=1}^{n} \exp(a_i)} = \frac{C \exp(a_k)}{C \sum_{i=1}^{n} \exp(a_i)}$$

$$= \frac{\exp(a_k + \log C)}{\sum_{i=1}^{n} \exp(a_i + \log C)}$$

$$= \frac{\exp(a_k + C')}{\sum_{i=1}^{n} \exp(a_i + C')}$$

>上述的推导有一个奇怪的地方,本来应该是lnC,却被写成了logC,我四处搜寻答案找到一条比较合理的解答:
>![示意图](PixPin_2026-05-01_10-42-09.webp)

上述的式子说明,在进行softmax计算时,加上或者减去某个常数并不会改变运算的结果,所以我们可以通过**减去输入信号中的最大值**来防止溢出.


## 神经网络的学习
实际的神经网络中有成千上万甚至几千亿的权重参数,想要人工一个个处理标注这些参数是不可能的,因此我们需要让神经网络自己**学习**如何设置这些参数.

机器学习中,我们将数据分成**训练数据和测试数据**两部分,才可以正确评价模型的**泛化能力**(即处理新数据的能力),并确保不出现**过拟合**(over fitting),训练数据也被称为**监督数据**.
### 损失函数(loss function)
神经网络以某个指标为线索寻找最优的权重参数,该指标被称为**损失函数**,一般使用均方误差和交叉熵误差来计算.

我们通常将正确解的参数表示为1,其他解的参数表示为0,这被称为 **one-hot 表示**,例如:
```py
>>> y = [0.1, 0.05, 0.6, 0.0, 0.05, 0.1, 0.0, 0.1, 0.0, 0.0]
>>> t = [0, 0, 1, 0, 0, 0, 0, 0, 0, 0]
```

这里的t只给正确解标注了1,其他解都标注为0.
#### 均方误差
均方误差公式如下所示:
$$E = \frac{1}{2} \sum_{k} (y_k - t_k)^2$$
- $y_k$: 神经网络的输出
- $t_k$: 监督数据
- $k$: 数据的维数

均方误差会计算神经网络的输出和监督数据的各个元素之差的平方和
#### 交叉熵误差(cross entropy error)
交叉熵误差公式如下:
$$E = -\sum_{k} t_k \log y_k$$

这里，$\log$ 表示以 $\text{e}$ 为底数的自然对数 ($\log_{\text{e}}$)。$y_k$ 是神经网络的输出，$t_k$ 是正确解标签。并且，$t_k$ 中只有正确解标签的索引为 1，其他均为 0（one-hot 表示）。

因此,上式实际上只计算正确解标签的输出的自然对数而已.

由于输出值$y_k$的取值范围为0-1,那么**当它越接近1时,神经网络的交叉熵就越接近0,代表误差越小;当它越接近0时,神经网络的交叉熵就越接近正无穷,代表误差越大.**
#### mini-batch(小批量)学习
计算损失函数时,我们需要把所有的训练数据都考虑进去,如果训练数据有一百组,就要计算这一百组损失函数的总和,尽量让他变小:
$$E = -\frac{1}{N} \sum_{n} \sum_{k} t_{nk} \log y_{nk}$$

这里，假设数据有 $N$ 个，$t_{nk}$ 表示第 $n$ 个数据的第 $k$ 个元素的值（$y_{nk}$ 是神经网络的输出，$t_{nk}$ 是监督数据）。

当数据过多时,直接选取所有数据计算总和是不太合理的,比如说有60000个数据,我们从中随机选取100个,再用这100个数据来学习,这被称为**mini-batch学习**.
### 梯度法
>这里需要注意的是，梯度表示的是各点处的函数值减小最多的方向。因此，
无法保证梯度所指的方向就是函数的最小值或者真正应该前进的方向。实际
上，在复杂的函数中，梯度指示的方向基本上都不是函数值最小处。
#### 梯度法的定义
- **梯度法**: 不断沿着梯度方向前进,逐渐减小函数值.
  - 该方法经常被用在神经网络的学习中.

数学表示如下:

$$
\begin{aligned}
x_0 &= x_0 - \eta \frac{\partial f}{\partial x_0} \\
x_1 &= x_1 - \eta \frac{\partial f}{\partial x_1}
\end{aligned}
$$

式子中的η表示更新量,在神经网络中被称为**学习率**(learning rate),决定了在一次学习中应该学习多少,以及在多大程度上更新参数.

学习率需要通过试验得到一个合理的值,如果学习率过大,则容易错过最优解;学习率过小的话,更新幅度会很小,需要经过更久的循环运算.

#### 在神经网络中运用梯度法
对于一个形状为2X3的权重W的神经网络,损失函数用L表示,那么梯度可以表示成L对W中各个参数的偏导数:

$$
\begin{aligned}
\boldsymbol{W} &= \begin{pmatrix} w_{11} & w_{12} & w_{13} \\ w_{21} & w_{22} & w_{23} \end{pmatrix} \\
\frac{\partial L}{\partial \boldsymbol{W}} &= \begin{pmatrix} \frac{\partial L}{\partial w_{11}} & \frac{\partial L}{\partial w_{12}} & \frac{\partial L}{\partial w_{13}} \\ \frac{\partial L}{\partial w_{21}} & \frac{\partial L}{\partial w_{22}} & \frac{\partial L}{\partial w_{23}} \end{pmatrix}
\end{aligned}
$$
## 误差反向传播法
- 我们可以通过数学公式和计算图两种方式来理解反向传播

在看前面的文章时我就想到了,单纯的梯度下降法只能够处理一层参数,再加上输出层的`σ()`函数,怎么说也只可以实现一个简单的2层神经网络.但实际上的神经网络都是成千上万层的,那这些参数又是如何调试的呢?这就用到了**反向传播**

### 计算图
#### 计算图的引入
![示意图](PixPin_2026-05-05_15-50-09.webp)
上图即为计算图: 通过节点和箭头表示计算过程,节点用⚪表示,⚪中是计算的内容,计算的中间结果写在箭头上方.

我们可以只把运算符写在⚪中,将具体的变量数提出来放在外面:
![示意图](PixPin_2026-05-05_15-52-14.webp)


一个更为复杂的问题求解,但还是很好理解:
![示意图](PixPin_2026-05-05_15-52-42.webp)

### 链式法则与反向传播
反向传播的通俗理解:

>将对损失函数的贡献度通过输出层一步步回传至输入层,计算出各层的权重参数对该次训练结果误差的贡献,并让权重参数针对自身的贡献进行大小上的调整.

- 具体原理则是通过导数的乘积和加减实现.


**加法原样传递参数**
![示意图](PixPin_2026-05-06_13-02-09.webp)
**乘法交叉传递导数**
![示意图](PixPin_2026-05-06_13-03-39.webp)
### 实战
```py
import numpy as np


# 1. 激活函数：将线性结果压缩到 (0,1) 之间，模拟神经元激发
def sigmoid(x):
    return 1 / (1 + np.exp(-x))


# 2. 激活函数的导数：用于反向传播中计算梯度
# Sigmoid导数公式：f'(x) = f(x) * (1 - f(x))
def sigmoid_derivative(x):
    return x * (1 - x)


# --- 初始化数据 ---
# 输入数据 (4个样本, 3个特征)
X = np.array([[0, 0, 1], [0, 1, 1], [1, 0, 1], [1, 1, 1]])

# 期望输出 (4个样本, 1个目标)
y = np.array([[0, 1, 1, 0]]).T

# 随机初始化权重（层与层之间的连接强度）
# 3个输入 -> 4个隐藏神经元 -> 1个输出
weights0 = 2 * np.random.random((3, 4)) - 1
weights1 = 2 * np.random.random((4, 1)) - 1

# --- 训练过程 ---
for i in range(10000):
    # 【前向传播 - Forward Propagation】
    # 逻辑：信息从输入层流向输出层
    layer0 = X
    layer1 = sigmoid(np.dot(layer0, weights0))  # 隐藏层输出
    layer2 = sigmoid(np.dot(layer1, weights1))  # 最终预测输出

    # 【计算误差 - Error Calculation】
    # 逻辑：预测值离目标值差了多少
    # 这里简单的使用了结果相减代替了损失函数,如果使用损失函数的话还需要对其进行求导得到误差
    layer2_error = y - layer2

    if (i % 2000) == 0:
        print(f"Error after {i} iterations: {np.mean(np.abs(layer2_error))}")

    # 【反向传播 - Backpropagation】
    # 核心：利用链式法则，将误差从后往前分配给每个参数

    # A. 计算输出层的“贡献度”（梯度）
    # 误差 * 当前输出的斜率 = 该层神经元对总误差的“责任”
    layer2_delta = layer2_error * sigmoid_derivative(layer2)

    # B. 计算隐藏层的“贡献度”
    # 逻辑：隐藏层对误差的责任 = 输出层责任 * 连接两层的权重
    # 这步体现了“误差回传”：权重越高，分担的责任越大
    layer1_error = layer2_delta.dot(weights1.T)
    layer1_delta = layer1_error * sigmoid_derivative(layer1)

    # 【权重更新 - Weight Update】
    # 逻辑：根据责任（Delta）微调权重，减小下次误差
    # 梯度下降：新权重 = 旧权重 + 输入 * 责任
    weights1 += layer1.T.dot(layer2_delta)
    weights0 += layer0.T.dot(layer1_delta)

print("\nTraining Final Result:")
print(layer2)
```
## 优化神经网络的学习
### 参数的更新
在前面几章,为了找到最优参数,我们不断沿着梯度方向更新参数,并重复多次,从而逐渐靠近最优参数,这被称为**随机梯度下降法**(stochastic gradient descent,SGD),公式如下:

$$\boldsymbol{W} \leftarrow \boldsymbol{W}-\eta \frac{\partial L}{\partial \boldsymbol{W}}$$


![示意图](PixPin_2026-05-07_08-34-15.webp)
由于梯度的方向未必是最小值的方向,所以SGD很多时候的效率比较低,因此我们又有Momentum,AdaGrad,Adam三种方法来代替SGD.
#### Momentum(动量法)
$$\begin{aligned} \boldsymbol{v} & \leftarrow \alpha \boldsymbol{v}-\eta \frac{\partial L}{\partial \boldsymbol{W}} \\ \boldsymbol{W} & \leftarrow \boldsymbol{W}+\boldsymbol{v} \end{aligned}$$

通过α我们能够更精细的调整增量的大小,效果如下:
![示意图](PixPin_2026-05-07_08-34-28.webp)

如果不好理解的话,我们可以结合物理学知识来看:
- $\alpha \boldsymbol{v}$: 惯性项,保留一部分上次的速度,通常取0.9等小于1的值
- $\eta \frac{\partial L}{\partial \boldsymbol{W}}$: 冲量,当前的梯度更新方向

通过保留之前的一部分动量,动量法能够让函数更加平稳地前进,而不至于忽上忽下.
#### AdaGrad
在神经网络学习中有一种技巧:
>随着学习进行,不断减小学习率,即一开始多学,后面逐渐少学,从而降低了整体参数的学习率.

AdaGrad(Adaptive Grad)进一步发展了该想法,针对每个参数都适当地调整学习率,公式如下:
$$\begin{aligned} \boldsymbol{h} & \leftarrow \boldsymbol{h}+\frac{\partial L}{\partial \boldsymbol{W}} \odot \frac{\partial L}{\partial \boldsymbol{W}} \\ \boldsymbol{W} & \leftarrow \boldsymbol{W}-\eta \frac{1}{\sqrt{\boldsymbol{h}}} \frac{\partial L}{\partial \boldsymbol{W}} \end{aligned}$$

- $\odot$ 表示Hadamard积,也被称为逐元素乘法,即对于两个维度相同的矩阵或者向量,对应位置的元素直接相乘,而不需要进行行列求和,换句话说这里其实在计算每一个参数各自**梯度的平方**.

这里新引入了变量h,如果元素的梯度越大,学习率就会越小,反过来则是会大幅度增加学习率,效果如下:
![示意图](PixPin_2026-05-07_08-54-19.webp)

- 变量h实际上会记录过去所有梯度的平方和,所以会一直增大,学习越深入,更新幅度就会越小.

#### 补充: Adam
>2017年提出的Transformer即采用了2015年提出的Adam方法进行训练,所以需要重点了解,书上几乎没怎么介绍它,因此要在这里补充一下.

Adam结合了Momentum和AdaGrad两种方法,具体原理如下:

**1. 计算梯度**
在当前时间步 $t$，计算损失函数对参数 $\boldsymbol{W}$ 的随机梯度：
$$\boldsymbol{g}_t \leftarrow \nabla_{\boldsymbol{W}} L(\boldsymbol{W}_{t-1})$$

- 之前的偏导数写法不够正式,故这里从整体上写成梯度了,原理是一样的
**2. 更新一阶矩估计（动量项）**
利用指数移动平均（EMA）计算梯度的平均值：
$$\boldsymbol{m}_t \leftarrow \beta_1 \boldsymbol{m}_{t-1} + (1 - \beta_1) \boldsymbol{g}_t$$
* **物理意义**：代表梯度的“方向”和“惯性”。
* **超参数**：$\beta_1$ 通常设为 **0.9**。

>这里的β就是动量法中的α,m实质上就是动量法中的速度,但这次我们对冲量的修饰不再使用学习率η,而是用`1-β`.

**3. 更新二阶矩估计（环境自适应项）**
计算梯度平方的指数移动平均：
$$\boldsymbol{v}_t \leftarrow \beta_2 \boldsymbol{v}_{t-1} + (1 - \beta_2) (\boldsymbol{g}_t \odot \boldsymbol{g}_t)$$
* **物理意义**：代表梯度的“波动剧烈程度”。若 $\boldsymbol{v}_t$ 很大，说明该参数更新频繁且震荡剧烈。
* **超参数**：$\beta_2$ 通常设为 **0.999**。

这里实际上就是对AdaGrad的参数修正,梯度的作用被大幅度削弱了:
$$\boldsymbol{h} \leftarrow \boldsymbol{h}+\frac{\partial L}{\partial \boldsymbol{W}} \odot \frac{\partial L}{\partial \boldsymbol{W}}$$



**4. 偏差修正（Bias Correction）**
由于 $\boldsymbol{m}$ 和 $\boldsymbol{v}$ 初始化为零向量，在训练初期其估计值会严重偏向零。通过以下公式消除偏差：
$$\hat{\boldsymbol{m}}_t \leftarrow \frac{\boldsymbol{m}_t}{1 - \beta_1^t}$$
$$\hat{\boldsymbol{v}}_t \leftarrow \frac{\boldsymbol{v}_t}{1 - \beta_2^t}$$

>这里的t即为t次方,故随着训练次数增多,削弱幅度会逐渐增大,从而保证参数不会剧烈震荡.
**5. 参数更新**
利用修正后的矩估计调整参数：
$$\boldsymbol{W}_t \leftarrow \boldsymbol{W}_{t-1} - \eta \frac{\hat{\boldsymbol{m}}_t}{\sqrt{\hat{\boldsymbol{v}}_t} + \epsilon}$$
* **$\eta$**：学习率。
* **$\epsilon$**：数值稳定项。

这里实际上就是把魔改后的参数缝合到了AdaGrad公式中:
$$\boldsymbol{W} \leftarrow \boldsymbol{W}-\eta \frac{1}{\sqrt{\boldsymbol{h}}} \frac{\partial L}{\partial \boldsymbol{W}}$$


Adam有以下机制:
* **自适应步长**：当某个参数的梯度很大时，分母中的 $\sqrt{\hat{\boldsymbol{v}}_t}$ 也会变大，从而调小步长；反之，梯度极小的参数会获得更大的步长。
* **消除震荡**：分子中的 $\hat{\boldsymbol{m}}_t$ 保留了历史方向，抵消了随机噪声。

- 显然,这种丑陋且复杂的调参是研究者经过了多次实验才发明出来的,意外的极其有效,所以才一战成名.但具体原理是什么,谁也说不清楚.

>2019年又提出了改进的AdamW算法,是BERT,GPT,Llama等Transformer模型的核心算法,就不具体分析了.

- 可以看到这些算法的本质并不多么高深,但总有些营销号喜欢把简单的事情复杂化...

### 权重的初始值
#### 可以设定为0吗
在误差方向传播法中,如果将所有权重的初始值设定为0,那么所有的权重都会被更新成相同的值,这显然是不理想的,所以我们需要随机生成初始值.
#### 标准初始值
对于sigmoid/tanh激活函数,推荐的各层权重的初始参数符合标准差为$\frac{1}{\sqrt{n}}$的正态分布,这被称为**Xavier 初始值**,公式如下:

$$w \sim \mathcal{N}\left(0, \frac{1}{n}\right)$$

n为前一层的节点数,那么如果前一层的节点数越多,当前的初始权重分布就会越靠近0,即绝对值会越小.


对于ReLU等非线性激活函数来说,推荐使用**He 初始值**,它同样也是正态分布,但标准差是**Xavier 初始值**的根号二倍:

$$w \sim \mathcal{N}\left(0, \frac{2}{n}\right)$$

- 之所以用2倍的系数,是因为ReLU的负值区域的值为0,需要让它更有广度一点.

![示意图](PixPin_2026-05-08_09-16-33.webp)
### batch normalization
![示意图](PixPin_2026-05-08_09-21-17.webp)

batch normalization于2015年提出,由于可以加速学习和抑制过拟合,被广泛使用在机器学习中.

该方法实质上是在隐藏层前加了一个数据处理层,使用四步将mini batch(小批量样本)中的输入数据正规化成标准正态分布:

$$\mu_{B} \leftarrow \frac{1}{m} \sum_{i=1}^{m} x_{i}$$

$$\sigma_{B}^{2} \leftarrow \frac{1}{m} \sum_{i=1}^{m}\left(x_{i}-\mu_{B}\right)^{2}$$

$$\hat{x}_{i} \leftarrow \frac{x_{i}-\mu_{B}}{\sqrt{\sigma_{B}^{2}+\varepsilon}}$$

最后一步则是用两个参数来修饰正规化后的数据:

$$y_{i} \leftarrow \gamma \hat{x}_{i} + \beta$$

- 一开始,γ=1,β=0,后续再通过学习调整到合适的值.

### 正则化
#### 过拟合
两种情况下会发生过拟合:
1. 模型参数过多,表现力强
2. 训练数据少

我们有两种方法来抑制过拟合: 权值衰减和Dropout
#### 权值衰减
由于很多过拟合是在权重参数取值过大时才出现的,该方法通过在学习的过程中对大权重进行惩罚,来抑制过拟合.

>复习一下，神经网络的学习目的是减小损失函数的值。这时，例如为损失函数加上权重的平方范数（L2 范数）。这样一来，就可以抑制权重变大。用符号表示的话，如果将权重记为 $W$，L2 范数的权值衰减就是 $\frac{1}{2}\lambda W^2$，然后将这个 $\frac{1}{2}\lambda W^2$ 加到损失函数上。这里，$\lambda$ 是控制正则化强度的超参数。$\lambda$ 设置得越大，对大的权重施加的惩罚就越重。此外，$\frac{1}{2}\lambda W^2$ 开头的 $\frac{1}{2}$ 是用于将 $\frac{1}{2}\lambda W^2$ 的求导结果变成 $\lambda W$ 的调整用常量。

>自然,我们在反向传播的时候在损失函数中加上$\lambda W$即可实现权值衰减,但在求梯度偏导的时候,对于某一层而言,只有该层的参数会被计入计算,而其他层的参数都被视为常数,因此异常的权重参数不会将影响扩大至其他层.

#### Dropout
如果神经网络的复杂度比较高,只用权值衰减是不够的,还需要使用Dropout方法.

**Dropout**会在学习的过程中随机删除神经元,具体原理是:
1. 训练时,每传递一次数据,就随机选择要删除的神经元
2. 测试时,虽然会传递所有的神经元信号,但对于各个神经元的输出,要乘上训练时的删除比例.

代码如下:
```py
class Dropout:
    def __init__(self, dropout_ratio=0.5):
        """
        dropout_ratio: 神经元被关闭的比例（例如 0.5 表示关闭一半）
        """
        self.dropout_ratio = dropout_ratio
        self.mask = None

    def forward(self, x, train_flg=True):
        """
        x: 输入数据
        train_flg: 是否为训练模式（Dropout 仅在训练时使用）
        """
        if train_flg:
            # 生成与 x 形状相同的随机数，大于比例的位置设为 True（即保留）
            # 注意：这里存下 mask 是为了反向传播时对应位置置零
            self.mask = np.random.rand(*x.shape) > self.dropout_ratio
            
            # Inverted Dropout 技巧：在训练阶段除以 (1 - ratio)
            # 这样预测阶段（inference）就无需做任何处理，直接输出即可
            return x * self.mask / (1.0 - self.dropout_ratio)
        else:
            # 预测阶段：所有神经元都参与计算，直接返回输入
            return x

    def backward(self, dout):
        """
        反向传播：只有前向传播中保留下来的神经元才能传递梯度
        """
        # 依然需要除以 (1 - ratio) 保持梯度缩放一致
        return dout * self.mask / (1.0 - self.dropout_ratio)
```

![概念图](PixPin_2026-05-09_12-14-00.webp)

实验效果如下:
![示意图](PixPin_2026-05-09_12-15-57.webp)
- 成功地抑制了过拟合,并且减小了训练数据和测试数据的识别精度差距

### 超参数的调整
- **超参数**(hyper-parameter): 各层的神经元数量,batch大小,学习率和权值衰减率等参数.权重和偏置等则是普通参数.

调整和评估超参数时,我们不能使用测试数据,因为这样一来超参数就会对测试数据发生过拟合,从而严重影响测试效果.

所以我们要再拿一批数据作为**验证数据**(validation data).
#### 超参数的最优化
我们可以这么做: 
1. 先大致设定一个范围,从这个范围中随机选出一个超参数,用它来评估识别精度
2. 多次重复步骤1,逐渐缩小超参数的范围
3. 缩小到一定程度时,从中选出一个超参数的值.


## 卷积神经网络
- 久闻卷积神经网络的大名,终于见到本人了

### 整体结构

之前的神经网络中,相邻层的所有神经元之间都有连接,这被称为**全连接**:
![示意图](PixPin_2026-05-09_12-42-11.webp)

而卷积神经网络(CNN)中新增了**Convolution**层(卷积层)和**Pooling**层(池化层):

![示意图](PixPin_2026-05-09_12-44-04.webp)

### 卷积层
#### 全连接层的问题
全连接层存在一个问题: 忽视了数据的形状.例如,输入数据是图像时,图像通常是长,宽,通道方向上的三维形状.但是全连接层输入时,需要将3维数据拉平为1维数据,否则根本无法进行输入.

- 比如前面的MNIST数据集,输入的图像是1通道,长28像素,宽28像素的形状,却被排成了1列,以784个数据的形式进入了初始层.

而卷积层可以保持输入数据的形状不变,我们将卷积层的输入输出数据称为**特征图**(feature map).
#### 卷积运算
![示意图](PixPin_2026-05-10_16-07-39.webp)

卷积运算即对输入的数据使用**滤波器**,**对应元素两两直接相乘后相加,将和放到对应坐标位置**:
![示意图](PixPin_2026-05-10_16-07-54.webp)

加上偏置时是对输出数据的每一位都加上偏置:
![示意图](PixPin_2026-05-10_16-08-34.webp)
#### 填充
为了调整输出的大小,我们可以在输入数据的周围**填充**固定数据(如0或者1),从而扩充输出数据的维度:
![示意图](PixPin_2026-05-10_16-10-20.webp)

- 如果我们不进行填充,那么输出数据的维度将越变越小,直到变成一维,那就失去卷积运算的意义了.

#### 步幅
应用滤波器的位置间隔称为**步幅**(stride),先前的例子中步幅为1,如果将步幅设置为2,则是这样的:
![示意图](PixPin_2026-05-10_16-12-13.webp)
#### 3维数据的卷积运算
先前的例子中的数据都是二维的,如果输入一个三维的图像数据,就需要针对每一个输入的二维图形设置单独的滤波器,将多个二维图形的结果加起来作为输出数据:
![示意图](PixPin_2026-05-10_16-16-30.webp)

### 池化层
池化(pooling)是缩小长宽方向上空间的运算,常用的max池化会取输入数据中的最大值:
![示意图](PixPin_2026-05-10_16-23-15.webp)

但是池化运算是针对每个通道单独进行处理的,所以不会缩小维度:
![示意图](PixPin_2026-05-10_16-29-22.webp)

### 补充: 卷积神经网络的反向传播
>非常离谱的是,文章没有提到卷积层和池化层是怎么进行反向传播的,但这却是非常重要的一个环节.

**池化层**的反向传播比较好处理,如果是max池化的话,直接将梯度传回最大值所在的位置即可,其他位置的梯度填充为0;如果是平均池化,那么就要对梯度进行均摊,例如: $2 \times 2$ 的平均池化,梯度值为 $g$,则回传给前层该区域的 4 个点每个点都是 $g/4$.

卷积层的反向传播就很复杂了,需要对当前层的梯度矩阵进行填充后,与**卷积核**(即前文所说的滤波器)再次进行卷积,与乘法的反向传播是交换导数类似,卷积核需要旋转180度再与梯度相乘,然后将误差传递给卷积层.
### CNN的种类
本书主要介绍1998年提出的元祖LeNet和2012年提出的新秀AlexNet.
#### LeNet
![示意图](PixPin_2026-05-10_17-07-04.webp)

Lenet使用子采样(subsampling)来缩小中间数据的大小,而不像现在使用Max池化,但其他的结构与现在的CNN差别不大.

#### AlexNet
![示意图](PixPin_2026-05-10_17-09-39.webp)
大致结构与LeNet没有什么差别,只是引入了ReLU作为激活函数,使用Dropout用来正则化参数.

## 深度学习
>深度学习本质上就是加深了网络层数的神经网络学习.
### 加深网络
加深网络的好处如下:
1. 通过多层卷积层运算,可以使用更少的参数实现同样甚至更优的效果
2. 减少学习数据,实现更高效的学习
### 深度学习的高速化
深度学习中的大部分时间到耗费在卷积层上:
![示意图](PixPin_2026-05-10_17-53-34.webp)

如前所说,卷积计算需要将卷积核与输入数据逐个相乘,完全可以拆分成并行计算后再将结果相加,这恰恰是GPU最擅长的地方.

如果要进一步加速的话,可以使用多个GPU或者多个机器进行学习,这被称为**分布式学习**:
![示意图](PixPin_2026-05-10_17-56-14.webp)

>显然这就是为什么如今的AI模型回答速度这么快的原因,这背后需要大量的GPU进行算力支持.

由于双精度浮点数和单精度浮点数的位数过多,而根据实验结果,即使是16位的**半精度浮点数**(half float)也足够支持深度学习了,所以现在的AI芯片全面转向支持16位甚至是8位的浮点运算,直接将运算速度翻倍了.

## 总结
这本书之所以这么有名是有理由的,讲的确实很好,足够深入浅出,让我这个小白也有幸懂得了神经网络和深度学习是什么.

我没怎么附上算法的具体实现代码,因为书中的示例代码过于简陋和破碎了,需要额外去阅读其他书籍来学习真正的神经网络代码编写.

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
![示意图](simage11.png)

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
![示意图](simage12.png)

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
![示意图](ssimage-6.png)
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
# 网络游戏核心技术与实战
- 讲的挺全面的,要想搞懂联机游戏是什么看这本书就对了.尽管如此,很多地方都讲的很啰嗦,实战代码部分也不够清晰,中规中矩吧.

## 要点总结
### 为什么不能用数据库存储游戏信息
>假如要在搭载了 6502 芯片的家用游戏机上使用 RDBMS 会怎么样呢？当然首先必须通过 SQL 语句，但是像 SELECT * from FlyingObjects 这样的语句，单单判断语法是否正确就要消耗几百个 CPU 周期，显然不现实。
>
>游戏编程必须在 1 帧内完成坐标的判断和保存。为此，必须只通过组合 CPU 所具有的一些最原始的命令来实现这些处理，只是读取数据就要花费几百个周期是相当不合理的。因此，在家用游戏机中，基本不考虑使用 RDBMS 这种方式。
# Agentic Design Patterns
不推荐阅读,一开始以为是讲Agent设计的,但实际上是讲一些宽泛的关于Agent使用的知识,调用几个框架就结束了,甚至还教你怎么写提示词😅
# AI Engineering Building Applications with Foundation Models
不推荐阅读,读起来有一种受骗上当的感觉...
# Generative AI with Python 
- 不推荐阅读
# 基于大模型的RAG应用开发与优化
- 值得一看,尽管很多地方都是不太重要的接口调用和代码分析,但讲的还算不错,能有不少收获

![RAG应用架构示意图](PixPin_2026-05-29_17-36-37.webp)
# Essential GraphRAG Knowledge Graph-Enhanced RAG
## 总结
很高兴能够看到这本书,尽管只有薄薄的一百多页,但它成功帮我拨开了关于RAG的迷雾,让我真正地明白了一件事:
- 在部署端使用RAG的效果是微乎其微的.

我们可以将RAG拆成一个比较完整的几步:
1. 将本地文件拆分成向量并存入向量数据库中
2. 调用第三方的embedding API或者使用本地部署的小模型来将用户的提示词转变成embedding层的向量
3. 根据提示词向量在数据库中查询得到关联度最大的文档向量(通常是计算两个向量的余弦相似度)
4. 将文档向量对应的文本块附加在提示词之后交给API
5. API返回经过了RAG的回答.

尽管如此,RAG的原型论文是说的用这一回答来微调大模型本身,而非用在API上的微调.如果我们需要让大模型来处理隐私文档和数据,那就不应该走API,而应该使用本地训练的模型,那么就无所谓RAG了,直接把内部文件作为初始训练语料就可以了;但话又说回来,不具备本地训练模型条件的公司和个人又不太需要保护所谓的内部知识库,大方交给API就行了.

而在如今,主流大模型的知识库储备都是相当恐怖的,完全不需要我们来给API额外提供公开的文档知识,如果你希望了解最近发生的事情,现在的AI甚至还可以主动去联网搜索,在大模型端进行RAG处理,而不需要我们这边提供任何的信息.

总体来看,要不要在部署端用RAG是相当矛盾的一件事,粗暴一点说的话,这事我看成不了.

>但话又说回来,在大模型端使用RAG确实很有必要,所以自2021年RAG被正式提出后,这方面的论文层出不穷
# 数据库系统实现
- 不推荐,内容太老了,讲的也比较宽泛
# C和指针
不推荐阅读,甚至没找到有必要做笔记的地方,你就说写的有多烂吧.

![豆瓣评分](PixPin_2026-05-27_11-37-51.webp)

可是这种书却能拿到这么高的分数,反而说明了C系语言的教材有多么匮乏和枯燥.
# 深度探索C++对象模型
不推荐阅读,内容太老了,讲的也不清晰
# Linux内核设计与实现
- 尽管源码分析很多,好在都有一些比较概括性的介绍,只看介绍就行了,谁愿意看你那些破碎的代码分析呢.再说Linux的0.01版只有一万行代码,真要研究的话看那个也足够了.


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
  - 实际使用方法和调用库函数没有任何的区别,所以就直接略过了
## 中断
- 中断: 由硬件向内核发出的常规通知,内核针对中断值来区分不同的中断信号
- 异常: 由处理器向内核发出的错误通知,实际处理方式与处理中断类似

>二者的差异就在于中断是由硬件引发而非由软件引发
## 内核同步
- 临界区: 存放共享数据的代码段
- 同步: 避免两个进程在同一个临界区中同时执行,因为进程调度中发生进程抢占的情况经常出现,例如中断,内核抢占和多处理器
- 加锁: 在进程执行时给临界区加锁可以让其他进程无法进入临界区,从而实现进程同步
- 死锁: 每个进程都在等待被加锁的资源才能继续执行,而这个资源被解锁的条件恰恰是该进程执行完毕
  - 自死锁: 一个进程在执行中申请获得自己持有的锁,那么该进程只能永远等待下去
  - 自旋锁(spin lock): 最多只能被一个可执行进程持有的锁,其他进程在等待该进程执行完毕时必须不停地反复询问,原地旋转(spin).
  - 读/写自旋锁: 多个读任务可以同时持有读者锁,但只能由一个写任务持有写者锁,且写者代码执行时不可以有读者代码同时执行.**该类锁显然是针对读写任务设计的**
  - 信号量: 信号量是一种睡眠锁,如果一个进程试图获取被占用的信号量时,将会被推进一个等待队列并睡眠,只有当信号量被释放时才能被唤醒.**该类锁是针对需要长时间执行的进程设定的.**

![两个进程的例子](PixPin_2026-05-29_09-44-33.webp)

## 时间管理
1. **处理器的时钟频率是可调的**,操作系统可以根据自己的需要动态调节时钟频率,这也是为什么在低功耗模式下打游戏会卡顿,时钟频率下降后,单位时间内操作系统能够处理的任务数就变少了.
2. 更高的时钟频率可以提高内核定时器的精度,细化每个任务的分配时间,从而提高整体的运行速度.
## 虚拟文件系统(virtual file system,VFS)
>之所以我们能够直接对外接硬盘进行操作,就是虚拟文件系统的功劳

VFS定义了所有文件系统都支持的接口,通过把文件视为文件对象来做统一的处理.

VFS 中有四个主要的对象类型，它们分别是：

* 超级块对象，它代表一个具体的已安装文件系统。
* 索引节点对象，它代表一个具体文件。
* 目录项对象，它代表一个目录项，是路径的一个组成部分。
* 文件对象，它代表由进程打开的文件。
## 块I/O层

- 块设备: 能够随机访问固定大小的数据片的硬件设备,如硬盘和闪存
- 字符设备: 可以按照字符流的方式有序访问,如键盘和音箱
- 块: 文件系统的最小寻址单元,为固定大小的数据片,需要是扇区的整数倍大小,通常为4KB
- 扇区: 设备的最小寻址单元,为512B/4KB大小
- 缓冲区: 块被调入内存时的存储区,每个缓冲区对应一个块
### I/O调度程序
Linux2.6中同时存在四种I/O调度程序:

| 调度器                | 主要目标       | 特点                                               |
| --------------------- | -------------- | -------------------------------------------------- |
| `noop`                | 尽量少做事     | 简单 FIFO，适合硬件自己已经会调度的场景            |
| `deadline`            | 避免请求饿死   | 给请求设置期限，尤其保护读请求延迟                 |
| `anticipatory` / `as` | 预测后续读请求 | 服务完一次读请求后短暂等待，避免马上切去远处写请求 |
| `cfq`                 | 公平性         | 按进程/队列分配 I/O 时间，强调公平和桌面体验       |


## 进程地址空间
用户空间中的进程内存被称为**进程地址空间**,由虚拟内存(VMA)映射而成.

![示意图](PixPin_2026-06-02_10-37-51.webp)

将虚拟内存映射到物理内存是通过页表实现的:

![示意图](PixPin_2026-06-02_10-39-56.webp)
# 深度学习理论与实战：基础篇
- 写的不是很好,也不够通俗,看的出来很多论述都是戛然而止的,非常浅显,我只能认为是被编辑砍掉了,不然和姊妹书的差别还是太大了
# 深度学习理论与实战：提高篇
- 这本书我是偶然发现的,知名度并不高,但是里面的不少内容都讲的很好,比起某些深度依赖框架的深度学习书好很多,希望能有更多人看到这种优秀的中文文章.

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
#### 二分查找(过)
### 排序
#### 选择排序(selection sort)
>每轮从未排序的区间选择最小的元素,将其放到已排序区间的末尾

```cpp
/* 选择排序 */
void selectionSort(vector<int> &nums) {
    int n = nums.size();
    // 外循环：未排序区间为 [i, n-1]
    for (int i = 0; i < n - 1; i++) {
        // 内循环：找到未排序区间内的最小元素
        int k = i;
        for (int j = i + 1; j < n; j++) {
            if (nums[j] < nums[k])
                k = j; // 记录最小元素的索引
        }
        // 将该最小元素与未排序区间的首个元素交换
        swap(nums[i], nums[k]);
    }
}
```
这显然是O(n^2)的时间复杂度,对于相同大小的元素,有可能发生相对顺序的改变,因此是非稳定的:

![示意图](PixPin_2026-05-27_11-52-25.webp)


#### 冒泡排序(bubble sort)
>连续地与相邻元素交换,每一轮将当前最大的元素交换至正确位置

```cpp
/* 冒泡排序（标志优化）*/
void bubbleSortWithFlag(vector<int> &nums) {
    // 外循环：未排序区间为 [0, i]
    for (int i = nums.size() - 1; i > 0; i--) {
        bool flag = false; // 初始化标志位
        // 内循环：将未排序区间 [0, i] 中的最大元素交换至该区间的最右端
        for (int j = 0; j < i; j++) {
            if (nums[j] > nums[j + 1]) {
                // 交换 nums[j] 与 nums[j + 1]
                // 这里使用了 std::swap() 函数
                swap(nums[j], nums[j + 1]);
                flag = true; // 记录交换元素
            }
        }
        if (!flag)
            break; // 此轮“冒泡”未交换任何元素，直接跳出
    }
}
```
由于相等元素之间不交换,所以,前后顺序能够保持不变,是稳定的.
#### 插入排序(insertion sort)
>从第一个元素开始保证局部有序,不断将后面的元素插入到前面已经排序好的队列中

```cpp
/* 插入排序 */
void insertionSort(vector<int> &nums) {
    // 外循环：已排序区间为 [0, i-1]
    for (int i = 1; i < nums.size(); i++) {
        int base = nums[i], j = i - 1;
        // 内循环：将 base 插入到已排序区间 [0, i-1] 中的正确位置
        while (j >= 0 && nums[j] > base) {
            nums[j + 1] = nums[j]; // 将 nums[j] 向右移动一位
            j--;
        }
        nums[j + 1] = base; // 将 base 赋值到正确位置
    }
}
```
由于需要遍历读取和遍历查找,所以还是n^2的时间复杂度.如果如上述示例中所写,相等的值将会被插入到右侧,因此是稳定的.

#### 快速排序(quick sort)
- 逻辑比较复杂,所以我以前学算法的时候都没彻底搞懂快排...

>首先锚定一个基准数,将左侧比基准数大的放到右侧,右侧比基准数小的放到左侧,处理完后的两边对于基准数来说是有序的,之后再递归处理即可.


```cpp
/* 哨兵划分 */
int partition(vector<int> &nums, int left, int right) {
    // 以 nums[left] 为基准数
    int i = left, j = right;
    while (i < j) {
        while (i < j && nums[j] >= nums[left])
            j--;                // 从右向左找首个小于基准数的元素
        while (i < j && nums[i] <= nums[left])
            i++;                // 从左向右找首个大于基准数的元素
        swap(nums[i], nums[j]); // 交换这两个元素
    }
    swap(nums[i], nums[left]);  // 将基准数交换至两子数组的分界线
    return i;                   // 返回基准数的索引
}

/* 快速排序 */
void quickSort(vector<int> &nums, int left, int right) {
    // 子数组长度为 1 时终止递归
    if (left >= right)
        return;
    // 哨兵划分
    int pivot = partition(nums, left, right);
    // 递归左子数组、右子数组
    quickSort(nums, left, pivot - 1);
    quickSort(nums, pivot + 1, right);
}
```
#### 归并排序(merge sort)
>大致想法其实和快速排序差不多,都是将大数组不断拆分成小数组后进行排序,不同的是快速排序在拆分前就排序,而归并排序是在拆分后进行排序
```cpp
/* 合并左子数组和右子数组 */
void merge(vector<int> &nums, int left, int mid, int right) {
    // 左子数组区间为 [left, mid], 右子数组区间为 [mid+1, right]
    // 创建一个临时数组 tmp ，用于存放合并后的结果
    vector<int> tmp(right - left + 1);
    // 初始化左子数组和右子数组的起始索引
    int i = left, j = mid + 1, k = 0;
    // 当左右子数组都还有元素时，进行比较并将较小的元素复制到临时数组中
    while (i <= mid && j <= right) {
        if (nums[i] <= nums[j])
            tmp[k++] = nums[i++];
        else
            tmp[k++] = nums[j++];
    }
    // 将左子数组和右子数组的剩余元素复制到临时数组中
    while (i <= mid) {
        tmp[k++] = nums[i++];
    }
    while (j <= right) {
        tmp[k++] = nums[j++];
    }
    // 将临时数组 tmp 中的元素复制回原数组 nums 的对应区间
    for (k = 0; k < tmp.size(); k++) {
        nums[left + k] = tmp[k];
    }
}

/* 归并排序 */
void mergeSort(vector<int> &nums, int left, int right) {
    // 终止条件
    if (left >= right)
        return; // 当子数组长度为 1 时终止递归
    // 划分阶段
    int mid = left + (right - left) / 2;    // 计算中点
    mergeSort(nums, left, mid);      // 递归左子数组
    mergeSort(nums, mid + 1, right); // 递归右子数组
    // 合并阶段
    merge(nums, left, mid, right);
}
```

- 实际上我并没有听说过有什么程序使用归并排序来处理数据结构的.

#### 堆排序(heap sort)

```cpp
/* 堆的长度为 n ，从节点 i 开始，从顶至底堆化 */
void siftDown(vector<int> &nums, int n, int i) {
    while (true) {
        // 判断节点 i, l, r 中值最大的节点，记为 ma
        int l = 2 * i + 1;
        int r = 2 * i + 2;
        int ma = i;
        if (l < n && nums[l] > nums[ma])
            ma = l;
        if (r < n && nums[r] > nums[ma])
            ma = r;
        // 若节点 i 最大或索引 l, r 越界，则无须继续堆化，跳出
        if (ma == i) {
            break;
        }
        // 交换两节点
        swap(nums[i], nums[ma]);
        // 循环向下堆化
        i = ma;
    }
}

/* 堆排序 */
void heapSort(vector<int> &nums) {
    // 建堆操作：堆化除叶节点以外的其他所有节点
    for (int i = nums.size() / 2 - 1; i >= 0; --i) {
        siftDown(nums, nums.size(), i);
    }
    // 从堆中提取最大元素，循环 n-1 轮
    for (int i = nums.size() - 1; i > 0; --i) {
        // 交换根节点与最右叶节点（交换首元素与尾元素）
        swap(nums[0], nums[i]);
        // 以根节点为起点，从顶至底进行堆化
        siftDown(nums, i, 0);
    }
}
```
### 动态规划(dynamic programming)
要点:
1. 明确初始状态
2. 找到状态转移方程
3. 开始递归

>**无后效性**是动态规划能够有效解决问题的重要特性之一，其定义为：给定一个确定的状态，它的未来发展只与当前状态有关，而与过去经历的所有状态无关。

如果待求解问题的"有后效性"特别显著,那么就不能用动态规划,而是换成其他的算法.
#### 背包问题
>在一定的背包容量下,尽可能让装入物品的总价值最大.

之所以背包问题能够用动态规划来解决,也是因为我们可以将背包问题拆分成逐个放入物品的过程,当前的最大价值只与当前放入的物品有关.

**0-1背包问题**

![示意图](PixPin_2026-06-02_09-15-05.webp)

**完全背包问题**

之所以叫完全背包,是因为每个物品都可以重复选取

![示意图](PixPin_2026-06-02_09-29-00.webp)
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

对于MIPS来说,由于所有指令的长度都是相同的,而且指令格式的种类很少,每一条指令中源寄存器字段的位置也相同,所有的操作都可以通过流水线完成.

流水线冒险,意为**在下一个时钟周期中无法执行下一条指令**,可以分为三种类型:
1. 结构冒险: 硬件不支持多条指令在同一时钟周期执行,例如存储器在同一周期被两条指令的特定阶段都同时访问
2. 数据冒险: 一个流水级必须等待另一个流水级完成,导致流水线暂停.这是由于一条指令依赖于另一条还在流水线中的指令造成的.

一种解决方法是: 我们可以让需要等待来自其他指令结果x的流水线先进行到需要x的地方,再由特定的硬件直接将计算好的x送给该流水线,这被称为旁路(bypassing).


![示例](PixPin_2026-05-27_10-04-36.webp)

| 符号    | 全称               | 中文含义        | 主要功能                             |
| ------- | ------------------ | --------------- | ------------------------------------ |
| **IF**  | Instruction Fetch  | 取指令          | 从指令存储器中取出当前 PC 指向的指令 |
| **ID**  | Instruction Decode | 指令译码        | 解析指令，读取寄存器，生成控制信号   |
| **EX**  | Execute            | 执行 / 地址计算 | ALU 运算、分支判断、计算访存地址     |
| **MEM** | Memory Access      | 访存            | 访问数据存储器，完成 load / store    |
| **WB**  | Write Back         | 写回            | 将运算结果或访存结果写回寄存器       |



上述的示例是理想的情况,由于ALU运算的结果刚好在下一个周期前回流到了减法的流水线,所以流水线不会中断.但实际上很多时候我们需要停留一两个周期才能获取上一个流水线的结果,停留的周期被称为**阻塞**(stall).

我们可以通过重排指令来避免阻塞:
![例题](PixPin_2026-05-27_10-15-29.webp)

3. 控制冒险: 接下来的决策依赖于某一条正在执行的指令结果,这类指令通常都是条件分支指令(beq,ben),有可能产生不同的指令结果.

指令集采用**预测(predict)**的方法来处理条件分支问题,在预测正确的时候不停止流水线的运行,在预测失败的时候需要重新执行流水线.

一种简单的设想是,认为所有的分支都不会生效,那么当预测正确的时候(分支生效),流水线可以全速执行,当分支生效时才会阻塞流水线.

更为成熟的做法是,预测一些分支生效而另一些分支不生效,对于分支生效的指令,会提前跳转到对应的分支地址进行执行.

>控制冒险实际上就是我们在程序编写中常见的while和for循环操作.

## 存储器
### 前置概念
- 局部性原理:
  - 时间局部性(temporal locality): 如果某个数据项被访问，那么在不久的将来它可能再次被访问
  - 空间局部性(spatial locality): 如果某个数据项被访问,与它地址相邻的数据项可能很快也将被访问

根据局部性原理,我们可以将存储器设计成分层的结构:

![示意图](PixPin_2026-05-28_12-29-14.webp)

### cache的设计
cache的基本原理可以这样表述:
>将主存中的内存块映射到cache中的每一行中,如果cache有8行,那么就对主存地址取模8,将余数相同的地址全部对应到cache的一行中

当然,我们需要对cache中某一行存储的内存块设置**标签**(tag),否则无法区分这到底是哪个内存块,如果cache有8行,那么我们可以直接将内存地址的低三位设置为余数,其他位数设置为标签,例如(10111)对应的是cache第8行,标签为10.






## 总结
总体看下来的感受还是可以的,大多数内容都讲的比较详细,解决了我关于MIPS指令集的不少疑问.
# 计算机体系结构: 量化研究方法
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
![示意图](simage13.png)

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


![示意图](ssimage-3.png)

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

![示意图](ssimage-4.png)

8. 采用编译器优化,降低缓存不命中的概率
   1. 编译器会对代码进行优化处理,帮助处理器以更高的效率执行代码

上面的这些做法都在现代计算机体系结构中得到了广泛的应用.
### 存储器种类
- Static Random Access Memory(SRAM): 通常用作缓存,集成在处理器的芯片上,响应速度远超DRAM
- Dynamic Random Access Memory(DRAM): 用作内存条,在每次读取信息后会破坏该信息,所以要进行**刷新**后写回数据,速度比较慢,适合放在硬盘和缓存中间作为缓冲存储器.
- SDRAM: 同步DRAM,DRAM的优化版本,现代的内存条都是SDRAM.
- NAND flash(闪存): 最常见的闪存就是SSD(固态硬盘),通常为最后一级存储器,速度很慢,但比起HDD(机械硬盘)又快得多.

## 附录B: 存储器层次结构
### 前置概念
1. 根据主存块在cache中的放置位置,可以讲cache的组织方式分成三种:
   1. 直接映射: `(块地址)MOD(缓存行数)`
   2. 全相联: 块可以放在缓存中的任意位置
   3. 组相联: 块可以放在缓存中的有限个位置组成的组(set)中.块首先通过`(块地址)MOD(缓存组数)`映射到组,可以放在组中的任意位置.
      1. 如果组中有n个块,就被称为n路组相联
      2. 有m块的全相联实际上就是只有一组的m路组相联
2. 处理器在寻找一个主存块时,会提供给cache两个信息: **块地址和块偏移**,块地址可以拆分成**tag**字段和**索引**字段,索引字段可以定位cache的某一行/某几行,tag字段可以与cache中的tag位进行比较,从而判断cache中该行是否存储了要寻找的主存块,如果不匹配,则说明发生了cache miss,需要从主存中加载数据到cache中,并重置cache中对应的tag位.
3. 发生cache miss时,由于直接映射时只需替换被映射的那一行,所以不用多操心;但对于组相联的cache,我们主要有三种算法来决定替换该组中的哪一行:
   1. RAND: 随机选择该组中的任意一行
   2. LRU(最近最少使用): 替换掉最近最少使用的一行,这应用了局部性原理.
   3. FIFO(先入先出): 替换掉最早被使用的哪一行.

![效果图](PixPin_2026-05-30_10-49-09.webp)

4. 将数据写入缓存时,有两种方法:
   1. 直写: 写入缓存和主存中
      1. 实现起来比较简单,而且发生cache miss时也不需要再对主存进行写入,主存中存有数据的最新副本
   2. 写回: 写入缓存,缓存中的数据如果被修改了,那么在被替换时才会被写入主存中.
      1. 写入时占用的时钟周期短,节省功耗

### 缓存优化
1. 增加相联度: 主存块可以放进cache的候选位置变多,被替换的概率下降
2. 增大存取的主存块大小: 根据空间局部性,如果程序访问了某个地址,它很可能马上访问附近的地址;但主存块太大的话,cache容纳的主存块个数过少,反而会降低性能
3. 增大cache容量: 装的主存块个数变多
4. 使用多级缓存,多级缓存的存储器平均访问时间计算方法如下:

![示意图](sGemini1.png)


### 虚拟存储器
>如果由程序员亲自负责物理内存的分配,拆分过于庞大的内存,确保程序不会越界访问,这显然很累人,尽管早期计算机确实是这么做的.

为了解决这个问题,虚拟存储器诞生了,处理器负责计算得到要处理的虚拟地址,由MMU单元按照操作系统提供的页表完成从虚拟地址到物理地址的映射(通过偏移量实现),再访问cache/主存中的实际物理地址.
## 指令级并行
### 前置概念
- 指令级并行: 有两种实现方式,一种是依靠硬件来动态实现并行,一种是依靠编译器来静态发现并实现并行.

为了确定能否开展指令级并行,我们需要判断指令间是否相关,总共有三种类型的相关:
1. **数据相关**: 指令i的结果可能会被指令j使用,或者指令i的结果会被指令k使用,而指令k的结果会被指令j使用,这两种情况都被称为数据相关.
   1. 如果两条指令数据相关,那么他们必须顺序执行,无法真正的并行.
2. **名称相关**: 指令i需要用到指令j需要的寄存器/存储器位置
   1. 名称相关非常好解决,既可以让编译器对涉及冲突的寄存器进行**重命名**(即更换寄存器),也可以让硬件更改冲突的存储器位置.
3. **控制相关**: 条件语句中的条件指令与执行语句只能顺序执行.
### 编译器优化
编译器可以智能地帮助我们合并指令,减少流水线停顿:

![示意图](ssimage-7.png)
### 硬件优化
硬件优化的代表性算法是**Tomasulo算法**,它能够通过寄存器重命名降低数据相关和名称相关的指令数量,实现流水线的乱序执行(在指令可用时立刻执行而无需等待).


![示意图](PixPin_2026-06-02_10-56-46.webp)

例如,上面这个指令序列可以通过两个临时寄存器被改写成这样,让指令间互不相关:

![示意图](PixPin_2026-06-02_10-57-18.webp)

## 数据级并行
>SIMD通过使用单条指令启动多次数据运算,比起MIMD更为高效.

SIMD有以下三种实际应用:
1. 向量处理机: 将处理器硬件全部替换成适配向量操作的结构,当需要大规模的数据运算时,可以直接使用矩阵来快速简化运算,而无需如同普通处理器一样通过多次循环来迭代处理.
   1. 很明显,向量处理机不是那么好实现的,效果也未必有多好,不然不会在推出几十年后也没成功商业化
2. 多媒体SIMD扩展: 简单来说就是对MIMD进行扩展,例如允许64位寄存器同时操作8个8位操作数,这适用于诸如图形处理,色彩渲染等功能.本质上来说是延续了向量处理机的实现方法.
3. GPU(Graphic Process Unit): 与CPU的架构差别很大

![示意图](ssimage-8.png)

## 线程级并行
为了实现线程级并行,我们需要同时运行多个处理器,按照存储器的组织方式,多处理器方案可以分成两种:
1. SMP(对称多处理器): 处理器数量少,有各自的独立缓存,但同时共享一个下一级缓存:

![架构图](PixPin_2026-06-05_08-25-03.webp)

2. DSM(分布式共享存储器): 处理器数量多,处理器之间不共享存储器,缩短了存储器存取延迟,但也让处理器之间传送数据变得更加复杂
# 计算机网络:自顶向下方法(第八版)
- 很早的阅读笔记,现在看来质量堪忧,待日后解决

## 应用层
### 应用层协议
#### http协议(2026/1/28)
事实上我把之前博客里写的内容直接搬过来了,比书上还是要详细不少的
##### 概览
- [参考链接](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Guides/Overview)
>HTTP 是一个客户端—服务器协议：请求由一个实体，即用户代理（user agent），或是一个可以代表它的代理方（proxy）发出。大多数情况下，这个用户代理都是一个 Web 浏览器，不过它也可能是任何东西，比如一个爬取网页来充实、维护搜索引擎索引的机器爬虫。
>
>每个请求都会被发送到一个服务器，它会处理这个请求并提供一个称作响应的回复。在客户端与服务器之间，还有许许多多的被称为代理的实体，履行不同的作用，例如充当网关或缓存。

**客户端发送的请求**
```HTTP
POST /api/v1/user/update?id=1024 HTTP/1.1
Host: www.example.com
Content-Type: application/json
User-Agent: Mozilla/5.0
Authorization: Bearer eyJhbGci...
Content-Length: 45

{
  "nickname": "Apollo",
  "gender": "male"
}
```
- POST: 客户端发起的请求所用方法
- `/api/v1/user/update?id=1024`:服务器对应资源的路径和Query参数
- Host: 目标服务器域名
- Content-Type: 传输数据格式声明
- User-Agent: 使用的浏览器代理
- Authorization: cookie或token等身份识别头
- Content-Length: 请求体字节长度
- `{"nickname": "Apollo","gender": "male"}`: 传输的数据

**服务端返回的报文**
```
HTTP/1.1 200 OK
Date: Sat, 09 Oct 2010 14:28:02 GMT
Server: Apache
Last-Modified: Tue, 01 Dec 2009 20:18:22 GMT
ETag: "51142bc1-7449-479b075b2891b"
Accept-Ranges: bytes
Content-Length: 29769
Content-Type: text/html

<!DOCTYPE html>…（此处是所请求网页的内容）
```
##### METHOD
- [wiki](https://zh.wikipedia.org/wiki/%E8%B6%85%E6%96%87%E6%9C%AC%E4%BC%A0%E8%BE%93%E5%8D%8F%E8%AE%AE)

HTTP/1.1 协议中共定义了八种方法来以不同方式操作指定的资源,下面我列举常用的几种
**GET**
The request is for a representation of a resource.The server should only retrieve data; not modify state.

**HEAD**
The request is like a GET except that the response should not include the representation data in the body. 
HEAD = GET − Response Body

**POST**
The request is to process a resource in some way.
**PUT**
The request is to create or update a resource with the state in the request.
**DELETE**
The request is to delete a resource.


##### status code
>In HTTP, you send a numeric status code of 3 digits as part of the response.
These status codes have a name associated to recognize them, but the important part is the number.

>In short:
100 - 199 are for "Information". You rarely use them directly. Responses with these status codes cannot have a body.
200 - 299 are for "Successful" responses. These are the ones you would use the most.
200 is the default status code, which means everything was "OK".
Another example would be 201, "Created". It is commonly used after creating a new record in the database.
A special case is 204, "No Content". This response is used when there is no content to return to the client, and so the response must not have a body.
300 - 399 are for "Redirection". Responses with these status codes may or may not have a body, except for 304, "Not Modified", which must not have one.
400 - 499 are for "Client error" responses. These are the second type you would probably use the most.
An example is 404, for a "Not Found" response.
For generic errors from the client, you can just use 400.
500 - 599 are for server errors. You almost never use them directly. When something goes wrong at some part in your application code, or server, it will automatically return one of these status codes.

##### [User Agent](https://developer.mozilla.org/zh-TW/docs/Web/HTTP/Reference/Headers/User-Agent)

>[wiki](https://zh.wikipedia.org/wiki/%E7%94%A8%E6%88%B7%E4%BB%A3%E7%90%86)
用户代理（user agent）在计算机科学中指的是代表用户行为的程序（软件代理程序）。例如，网页浏览器就是一个“帮助用户获取、渲染网页内容并与之交互”的用户代理

简单来说,user agent是http header里的客户端标识,告诉目标服务器自己是通过哪个浏览器进行访问的

- 爬虫总是需要伪装自己是通过某个代理访问服务器的,否则容易被拦截

**一般格式**
```html
User-Agent: <product> / <product-version> <comment>
```

**web浏览器的通用格式**
```html
User-Agent: Mozilla/5.0 (<system-information>) <platform> (<platform-details>) <extensions>
```

**具体示例**
```html
Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36
Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36 Edg/91.0.864.59
```


##### cookie
>[MDN](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Guides/Cookies)
服务器收到 HTTP 请求后，服务器可以在响应标头里面添加一个或多个 Set-Cookie 选项。浏览器收到响应后通常会保存下 Cookie，并将其放在 HTTP Cookie 标头内，向同一服务器发出请求时一起发送。你可以指定一个过期日期或者时间段之后，不能发送 cookie。你也可以对指定的域和路径设置额外的限制，以限制 cookie 发送的位置

##### Web cache
>Web缓存是用于临时存储（缓存）Web文档（如HTML页面和图像），以减少服务器延迟的一种信息技术。Web缓存系统会保存下通过这套系统的文档的副本；如果满足某些条件，则可以由缓存满足后续请求

流程如下：

1. 浏览器建立 **TCP 连接** 到 **Web Cache**，发送 HTTP 请求获取某个对象。

2. Web Cache 查询本地缓存。

   * 若存在对象副本（cache hit），直接返回 HTTP 响应给浏览器。

3. 若本地没有该对象（cache miss），Web Cache 建立 **TCP 连接** 到 **Origin Server**。

4. Web Cache 通过该 TCP 连接向 Origin Server 发送 HTTP 请求。

5. Origin Server 返回包含对象的 HTTP 响应。

6. Web Cache 接收响应后：

   * 在本地缓存该对象副本
   * 通过已有的 **浏览器 ↔ Web Cache TCP 连接** 将 HTTP 响应返回给浏览器。

##### 从HTTP/1到HTTP/3
HTTP1采用非持续连接,每个HTTP请求都使用独立的TCP连接,可想而知慢的吓人
因此,HTTP1.1采用了并行的TCP持续连接,共享带宽,但这会增加连接占用的带宽,容易引发网络阻塞
这也是HTTP2推出的原因,只使用一个TCP持续连接来处理多个并行请求,将每个HTTP报文划分为帧单位,在第一个请求发送第一帧后,发送第二个请求的第一帧,以此类推,不断循环
至于HTTP3,改进的程度比较有限,且基于UDP而非TCP连接,在22年已经标准化
#### SMTP协议(3/4)
SMTP,一种广泛使用,历史悠久的邮件传输协议,与HTTP一样使用的是持续的TCP连接
流程如下:
1. Alice 在 **用户代理（Mail User Agent）** 中输入 Bob 的邮箱地址（如 `bob@someschool.edu`），编写邮件并发送。

2. 用户代理将邮件发送到 **Alice 的邮件服务器（Mail Server）**，邮件进入服务器的 **邮件队列（message queue）**。

3. Alice 邮件服务器上的 **SMTP 客户端** 从队列中发现该邮件，并建立 **TCP 连接** 到 **Bob 的邮件服务器上的 SMTP 服务器**。

4. 完成 **SMTP 握手** 后，SMTP 客户端通过该 TCP 连接发送邮件内容。

5. Bob 的邮件服务器上的 **SMTP 服务器** 接收邮件，并将邮件存入 **Bob 的邮箱（mailbox）**。

6. Bob 在需要时启动 **用户代理**，从邮箱中读取邮件。

#### DNS
>识别主机有两种方式———主机名(hostname)和 IP 地址。人们喜欢便于记忆的主机名标识方式,而路由器则喜欢定长的、有着层次结构的 IP 地址,因为hostname(如www.baidu.com)不能给路由器任何有关这个主机所在位置的信息

因此,我们需要一种能够将主机名转换成IP地址的服务,也就是 域名系统（ Domain Name System ， DNS ）,由DNS服务器和DNS协议构成,运行在UDP之上,故也是应用层协议
##### 常用查询方法
* **A 记录查询 (Address Record)**
  * **物理定义**：将域名直接映射到一个具体的 **IPv4 地址**。
  * **工作机制**：当发起 A 记录查询时，DNS 服务器会返回一个由 4 组数字组成的物理地址（如 `192.168.1.1`）。
  * **特性**：它是最基础、速度最快的解析方式。浏览器拿到 A 记录后，可以直接根据该 IP 地址物理寻找目标服务器并建立 TCP 连接。


* **CNAME 记录查询 (Canonical Name Record)**
  * **物理定义**：将一个域名指向**另一个域名**，而不是具体的 IP 地址。
  * **工作机制**：
    1. 客户端查询 `www.example.com`。
    2. DNS 返回一个 CNAME 记录（如 `example.cdn.com`）。
    3. 客户端必须针对这个新域名**再次发起** DNS 查询，直到最终获得一个 A 记录（IP 地址）。
  * **特性**：
  * **别名逻辑**：常用于 CDN 加速或云服务。当后端物理服务器 IP 变动时，只需更改最终域名的 A 记录，所有指向它的 CNAME 无需修改。
  * **性能成本**：相比 A 记录，CNAME 至少会增加一轮 DNS 查询的物理往返时间。
---
- [阮一峰教程](https://www.ruanyifeng.com/blog/2016/06/dns.html)

>[为什么DNS用UDP](https://draven.co/whys-the-design-dns-udp-tcp/)
我们可以简单总结一下 DNS 的发展史，1987 年的 RFC1034 和 RFC1035 定义了最初版本的 DNS 协议，刚被设计出来的 DNS 就会同时使用 UDP 和 TCP 协议，对于绝大多数的 DNS 查询来说都会使用 UDP 数据报进行传输，TCP 协议只会在区域传输的场景中使用，其中 UDP 数据包只会传输最大 512 字节的数据，多余的会被截断；两年后发布的 RFC1123 预测了 DNS 记录中存储的数据会越来越多，同时也第一次显式的指出了发现 UDP 包被截断时应该通过 TCP 协议重试
##### 实际应用举例
![示意图](PixPin_2026-03-22_14-44-32.webp)
来看这样一个图,这是我在服务器上部署好了网站后,并在dynadot购买域名进入后台时将服务器的IP地址与对应域名绑定的过程.

使用A记录时,只要将服务器的ip地址填入就可以生效,但是别人访问这个服务器的时候只能在地址栏输入类似`qin******.com`的内容来访问.
但用户可能会输入`www.qin******.com`来访问这个服务器,但DNS并不会自动帮我将www前缀删除,所以我需要增加一条CNAME记录,将`www.qin******.com`指向`qin******.com`.
- www前缀代表着这个网站使用的是http协议,是一个web网站,但由于现在基本都是web网站,少有类似`ftp.qin*****.com`这样的网站名了
#### P2P协议
BitTorrent是里面最为著名的代表,简单来说是一种多人之间互相传数据分包的协议,从而避免多人仅通过连接一台服务器导致的下载速度延缓.
磁力链接,torrent等资源链接都采用这一协议进行传输

#### DASH和CDN
DASH(Dynamic Adaptive Streaming over HTTP),将视频编码为不同清晰度的版本,根据用户的可用带宽来动态选择对应画质版本的视频

CDN(Content Distribution Network),由名字可以看出来,CDN相当于一个存储视频,文档等数据的分布式服务器,避免只用一个服务器来接受http请求导致的各种问题

### Port(端口)
>可以理解为通信接口,也就是说,应用层的进程通过特定的端口实现与运输层TCP/UDP的连接.
- 一个端口号使用16位无符号整数（unsigned integer）来表示，其范围介于0与65535之间
- 在TCP协议中，端口号0是被保留的，不可使用。1--1023 系统保留，只能由root用户使用。1024--4999 由客户端程序自由分配。5000--65535 由服务器端程序自由分配。在UDP协议中，来源端口号可选择是否填上，如果设为0，则代表无来源端口号。


## 运输层

### Reliable Data Transfer Protocol (RDT)

- 显然书上这部分的引入太长了,而且并没有作者自以为的讲得很详细很清晰,还是让AI来总结一下吧
可靠数据传输协议（Reliable Data Transfer Protocol，RDT）是计算机网络中用来保证**发送方的数据能够完整、正确、按顺序送达接收方**的一类协议。即使底层信道可能存在丢包、乱序或传输错误，RDT 也能通过设计机制让数据安全传输
---

#### 1. RDT 的核心问题

在现实网络中，直接发送比特流存在很多潜在问题：

1. **丢包**：数据包在传输中可能完全丢失。
2. **数据错误**：信道噪声或硬件故障可能导致比特翻转，接收方收到的数据与发送方发送的数据不同。
3. **重复数据**：网络重传机制或路由问题可能导致同一个数据包被接收多次。
4. **乱序**：数据包可能通过不同路径传输，先发送的包晚到达。

可靠数据传输协议需要解决这些问题，保证**端到端**的可靠性。

---

#### 2. 核心机制概览

RDT 的核心机制可以概括为五个部分：

1. **分包（Segmentation）**

   * 将大数据拆分成较小的数据包，每个包称为 **segment**。
   * 优点：小包更容易重传，减少重发的代价，同时便于序列号管理。
   * 每个包通常包含以下内容：

     * 数据内容（payload）
     * 序列号（Sequence Number）
     * 校验和（Checksum）

2. **错误检测（Error Detection）**

   * 利用 **Checksum** 或 **CRC（Cyclic Redundancy Check）** 检测数据在传输中是否被破坏。
   * 发送方：计算数据包的校验和并附加在包头。
   * 接收方：收到包后重新计算校验值，如果与包头的值相同，则认为数据正确，否则认为数据出错。
   * 示例：

     ```text
     数据内容: 10110011
     校验和:   0110
     ```

     接收方校验，如果不匹配，就触发重传。

3. **序列号（Sequence Number）**

   * 每个数据包被赋予唯一的序列号（Sequence Number），用于：

     * **防止重复包处理**
     * **保证接收顺序**
   * 序列号通常为 0、1 或更大的整数，循环使用。
   * 接收方通过序列号判断是否收到新的包还是重复包。

4. **确认机制（Acknowledgment, ACK / Negative Acknowledgment, NAK）**

   * **ACK（确认）**：接收方收到正确的数据包后发送 ACK 给发送方。
   * **NAK（否定确认）**：接收方收到错误数据包时发送 NAK，要求发送方重发。
   * **作用**：

     * 让发送方知道哪些数据包成功到达。
     * 在丢包或错误情况下触发重传。
   * 示例流程：

     ```text
     发送方 -> 数据包 1 -> 接收方
     接收方 -> ACK 1 -> 发送方
     ```

5. **重传机制（Timeout & Retransmission）**

   * 发送方设置 **超时时间（Timeout）**。
   * 如果在超时时间内没有收到 ACK，发送方会自动 **重发数据包**。
   * 与 ACK/NAK 配合，可以保证即使网络丢包，最终数据仍然完整送达。
   * 关键点：

     * 超时必须合理，否则可能导致过早重发或等待过久。
     * 与序列号结合，保证重发的数据仍能正确排序，不被重复处理。

---

#### 3. 可靠数据传输模型示例

##### 3.1 Stop-and-Wait RDT（最基础模型）

* **发送端**：

  1. 发送一个数据包，附带序列号。
  2. 等待接收方发送 ACK。
  3. 如果超时未收到 ACK，重发数据包。
  4. 收到 ACK 后发送下一个包。

* **接收端**：

  1. 收到数据包，检查校验和。
  2. 如果正确，处理数据并发送 ACK。
  3. 如果错误或重复，丢弃数据或发送 NAK。

* 优点：简单易实现，理解方便。

* 缺点：效率低，因为发送方在等待 ACK 期间 **无法发送下一个数据包**。

##### 3.2 Sliding Window RDT（滑动窗口机制,流水线机制）

* 改进 Stop-and-Wait，允许 **发送方在等待 ACK 的同时发送多个包**。
* 核心概念：

  * **发送窗口**：发送方未确认的数据包集合。
  * **接收窗口**：接收方能够接收的序列号范围。
* 优点：提高链路利用率，尤其是高延迟链路。
* 实现机制：

  1. 发送方维护一个窗口，窗口内的包可以连续发送。
  2. 接收方按序号接收，并发送 ACK。
  3. 窗口滑动：收到 ACK 后，发送方窗口向前滑动，可以发送新的包。
* 常见变种：

  * **Go-Back-N**：出错时从错误包开始重发之后所有包。
  * **Selective Repeat**：只重发出错的包，更高效。

---

#### 4. RDT 的工作流程总结

以最简单的 Stop-and-Wait 为例，端到端流程如下：

```text
发送方: [数据包 seq=0] -------->
接收方: 检查校验 -> 正确 -> [ACK seq=0] -------->
发送方: 收到 ACK -> 发送下一个数据包 seq=1
```

**异常情况：**

1. 数据包丢失：

   * 发送方超时重发。
2. 数据包出错：

   * 接收方丢弃包并发送 NAK 或不发送 ACK。
3. ACK 丢失：

   * 发送方超时重发数据包，接收方根据序列号判断重复，避免重复处理。

> 核心思想：**发送方持续重发，接收方持续确认，直到每个包安全到达**。

---




### UDP(User Datagram Protocol)
UDP的原理非常简单,就是将`src post`传输的数据 打包进UDP报文,并传递给网络层,再分发给`dst post`
d
- 使用 UDP 时，在发送报文段之前,发送方和接收方的运输层实体之间没有握手.正因为如此，UDP 被称为无连接的.

#### 为什么要用UDP
- 无连接状态。TCP 需要在端系统中维护连接状态。此连接状态包括接收和发送缓存、拥塞控制参数以及序号与确认号的参数。另一方面， UDP 不维护连接状态 ， 也不跟踪这些参数。 因此， 当应用程序运行在 UDP 之上而不是运行在 TCP 上时，某些专门用于某种特定应用的服务器一般都能支持更多的活跃客户。
- 分组首部开销小 。每个 TCP 报文段都有 20 字节的首部开销 ， 而 UDP 仅有 8 字节的开销。
- TCP 的拥塞控制会导致如因特网电话、视频会议之类的实时应用性能变得很差 。由于这些原因，多媒体应用开发人员通常将这些应用运行在 UDP 之上而不是 TCP 之上
#### UDP包分析
一个完整的 UDP 包由 UDP 头部 + 数据负载（Payload）组成
##### UDP头部(固定8字节)
| 字段                 | 字节数 | 说明                           |
| -------------------- | ------ | ------------------------------ |
| **Source Port**      | 2      | 源端口                         |
| **Destination Port** | 2      | 目标端口                       |
| **Length**           | 2      | UDP 头 + 数据总长度            |
| **Checksum**         | 2      | 校验和，验证头部和数据是否损坏 |

```py
0      15 16     31
+---------+---------+
| src port| dst port|
+---------+---------+
| length  | checksum|
+---------+---------+
```
##### UDP 数据负载（Payload）
- 长度 = UDP Length – 8（头部大小）
- 完全由应用程序生成

**UDP检验和**
检验和用于确定当 UDP 报文段从源到达目的地移动时，其中的比特是否发生了改变 （ 例如，由于链路中的噪声干扰或者存储在路由器中时引入问题 ）。发送方的 UDP 对报文段中的所有 16 比特字的和进行反码运算，求和时遇到的任何溢出都被回卷(把最高位进位送入最低位相加) 。 得到的结果被放在 UDP 报文段中的检验和字段.
显然接收方可以再进行一次求和与反码相加,如果出现了0就说明数据有地方出错了.

### TCP(Transmission Control Protocol)
>TCP 被称为是面向连接的 （ connection-oriented），这是因为在一个应用进程可以开始向另一个应用进程发送数据之前 ， 这两个进程必须先相互 “ 握手 ”，即它们必须相互发送某些预备报文段，以建立确保数据传输的参数
#### TCP报文段分析

一个完整的 TCP 报文段由 **TCP头部（Header）+ 选项（Options，可选）+ 数据负载（Payload）**组成，其中最小 TCP 头部固定 **20 字节**。

##### TCP头部（最小20字节）

| 字段                      | 字节数 | 说明                                           |
| ------------------------- | ------ | ---------------------------------------------- |
| **Source Port**           | 2      | 源端口，标识发送应用进程                       |
| **Destination Port**      | 2      | 目标端口，标识接收应用进程                     |
| **Sequence Number**       | 4      | 序列号，标识第一个数据字节编号                 |
| **Acknowledgment Number** | 4      | 确认号，期望收到的下一个字节编号（ACK置1有效） |
| **Data Offset**           | 4位    | TCP头部长度（单位：32位字/4字节）              |
| **Reserved**              | 3位    | 保留，必须置0                                  |
| **Flags（控制位）**       | 9位    | URG, ACK, PSH, RST, SYN, FIN 等                |
| **Window Size**           | 2      | 接收端可接收缓冲区大小（流量控制）             |
| **Checksum**              | 2      | TCP头+数据+伪首部校验和                        |
| **Urgent Pointer**        | 2      | 紧急指针，URG置1时有效                         |

##### TCP头部字段示意图

```
0                   15 16                  31
+-------------------+--------------------+
|  Source Port      |  Destination Port  |
+-------------------+--------------------+
|               Sequence Number          |
+---------------------------------------+
|            Acknowledgment Number      |
+----+---+---+--------------------------+
|Data|Res|Flags|       Window Size       |
|Offset|  |     |                        |
+----+---+---+--------------------------+
|      Checksum      |  Urgent Pointer   |
+-------------------+--------------------+
|          Options (可选, 0~40 字节)    |
+---------------------------------------+
|          TCP Payload (数据)           |
+---------------------------------------+
```

* **Flags（控制位）**：

  * URG：紧急指针有效
  * ACK：确认号有效
  * PSH：接收端应用立即读取数据
  * RST：重置连接
  * SYN：同步序列号，用于建立连接
  * FIN：关闭连接

* **数据偏移（Data Offset）**：

  * 表示 TCP 头部长度，单位4字节
  * 最小值 5（20字节），最大 15（60字节，包括选项）

* **窗口大小**用于流量控制，控制发送端发送未确认的数据量。

* **校验和**覆盖 TCP 头部、数据以及伪首部（IP源/目的地址、协议号、TCP长度）。

#### 序号和确认号
>报文段的序号 （ sequence number for a segment ） 是该报文段首字节的字节流编号
>
>举例来说 ，假设主机 A 上的一个进程想通过一条 TCP 连接向主机 B 上的一个进程发送一个数据流 。主机 A 中的 TCP 将隐式地对数据流中的每一个字节编号 。假定数据流由一个包含 500 000 字节的文件组成，其 MSS 为 1000 字节，数据流的首字节编号是 0。则该 TCP 将为该数据流构建 500 个报文段。给第一个报文段分配序号 0 ，第二个报文段分配序号 1000 ，第三个报文段分配序号 2000，以此类推。每一个序号被填入到相应TCP报文段首部的序号字段中。

至于确认号,首先我们需要明确为什么需要确认号这样一个东西,由于TCP连接是双向的,故发送方也需要收到接收方传来的信息,故需要在确认号字段里填写缺失的来自接收方传来的包序号

> 假设主机 A 已收到一个来自主机 B 的包含字节 0 ～ 535 的报文段，以及另一个包含字节 900 ～ 1000 的报文段。 由于某种原因， 主机 A 还没有收到字节 536 ～ 899 的报文段。 在这个例子中， 主机 A 为了重新构建主机 B 的数据流，仍在等待字节 536 （ 和其后的字节）。 因此 ， A 到 B 的下一个报文段将在确认号字段中包含 536 

#### TCP连接的建立(三次握手)
* **第一步：SYN 报文段**
客户端向服务器发送一个首部 **SYN 比特**置为 **1** 的特殊报文段。该报文不含应用层数据，但包含客户端随机选择的初始序号 **client_isn**。该报文段被封装在 IP 数据报中发送。
* **第二步：SYNACK 报文段**
服务器接收到 SYN 后，为连接分配 **TCP 缓存和变量**，并回送允许连接的报文段。此时 **SYN 比特**置为 **1**，确认号字段设为 **client_isn + 1**，同时服务器选择自己的初始序号 **server_isn**。此报文段表明服务器同意建立连接。
* **第三步：ACK 报文段**
客户端收到 SYNACK 后，也为连接分配缓存和变量，并向服务器发送最后的确认报文。此时 **SYN 比特**置为 **0**，确认号字段设为 **server_isn + 1**。该阶段的报文段负载可以开始携带实际的客户数据。
- 注意,第三步的时候客户端可以主动选择终止连接

>拓展:[为什么要三次握手](https://draven.co/whys-the-design-tcp-three-way-handshake/)
想象一下这个场景，如果通信双方的通信次数只有两次，那么发送方一旦发出建立连接的请求之后它就没有办法撤回这一次请求，如果在网络状况复杂或者较差的网络中，发送方连续发送多次建立连接的请求，如果 TCP 建立连接只能通信两次，那么接收方只能选择接受或者拒绝发送方发起的请求，它并不清楚这一次请求是不是由于网络拥堵而早早过期的连接。
>
>使用三次握手和 RST 控制消息将是否建立连接的最终控制权交给了发送方，因为只有发送方有足够的上下文来判断当前连接是否是错误的或者过期的，这也是 TCP 使用三次握手建立连接的最主要原因。

#### TCP连接的终止(四次挥手)
TCP 协议是对称的全双工协议，连接的任何一方（无论最初是客户端还是服务器）都可以主动调用 `close()` 发送 **FIN** 报文段来开启连接终止流程。在**RFC 793**中，通常将发起关闭的一方称为 **Active Closer**（主动关闭方），将接收关闭请求的一方称为 **Passive Closer**（被动关闭方）。
- 全双工:双方都可以同时发送和接收消息
**主流程**

1. **主动方 (Active Closer) 发送 FIN**
该方应用进程决定不再发送数据。TCP 实体构造首部 **FIN** 位为 1 的报文段。发送后，主动方进入 **FIN-WAIT-1** 状态。
2. **被动方 (Passive Closer) 确认 ACK**
被动方收到 FIN 后，由 TCP 协议栈自动回送 **ACK**。此时被动方进入 **CLOSE-WAIT** 状态，并通知上层应用进程对端已关闭。主动方收到 ACK 后进入 **FIN-WAIT-2**。
3. **被动方 (Passive Closer) 发送 FIN**
当被动方的应用进程处理完所有剩余数据后，显式关闭套接字。TCP 发送 **FIN** 位为 1 的报文段，被动方进入 **LAST-ACK** 状态。
4. **主动方 (Active Closer) 发送最终 ACK**
主动方收到对端的 FIN 后，发送最后一个 **ACK**，进入 **TIME-WAIT** 状态。被动方收到此 ACK 后直接进入 **CLOSED** 状态，释放所有资源。
5. **主动方的资源释放延迟**
主动方必须在 **TIME-WAIT** 状态维持 **2MSL** 时长，以确保最后一个 ACK 到达被动方，并清空网络中残存的旧报文段。倒计时结束后，主动方进入 **CLOSED** 并释放资源。
#### TCP中的可靠数据传输
为了实现可靠数据传输,TCP有以下三个机制: 超时间隔,冗余ACK和快速重传

首先,TCP设置一个初始**超时间隔**,发出某个包时开始计时,如果接收方未能在超时间隔内将ACK确认包传来,则标记为**超时**.
每当超时事件发生时,TCP**重传**具有最小序号的还未被确认的报文段。只是每次 TCP 重传时都会将下一次的超时间隔设为先前值的两倍.

接收方保存一个连续接收到的包末端序号,比如说,"已经收到了 100-200 和 300-400，但中间缺了 201-299",那么末端序号就是201,尽管接收到了300-400的包,接收方仍会返回`ACK=201`,如果这次仍未收到201-299的包,则继续发送`ACK=201`,直到收到该部分的包为止,这被称为**冗余ACK**,之后,接收方立刻将序号调整为`ACK=401`.

如果发送方接收到对相同数据的3个ACK时,这说明之后的报文段已经丢失,那么发送方就执行**快速重传**,即重新发送之后的报文段.
- 换句话说,只收到**两个ACK**时不进行重传,原因如下:
  - 如果包 A 比包 B 稍微晚了一点点到达（仅仅是走错了路或者在路由器队列里被插了队），接收方就会因为先收到 B 而发回一个重复 ACK。如果此时发送方立即重传，会导致网络中充斥着大量无谓的重传包，极大地浪费带宽。

因此,重传只在以下两种情况中发生:
1. 超出超时间隔未收到该包对应的ACK时重传,这被称为**超时重传**
2. 收到该包的三个重复ACK则立刻重传,这被称为**快速重传**

#### TCP流量控制
TCP 为它的应用程序提供了流量控制服务 （ flow-control service ） 以消除发送方使接收方缓存溢出的可能性.
为了实现流量控制,发送方维护一个**接收窗口**(receive window,rwnd),接收方为该TCP连接分配了一个接收缓存,并维护以下三个变量:
* **LastByteRead**：应用进程从缓存读出的最后一个字节编号。
* **LastByteRcvd**：放入接收缓存中的最后一个字节编号。
* **RcvBuffer**：接收缓存的总大小。

为防止缓存溢出，必须满足：
**LastByteRcvd - LastByteRead ≤ RcvBuffer**

那么接收窗口就需要根据缓存可用的空间来设置：
**rwnd = RcvBuffer - [ LastByteRcvd - LastByteRead ]**

##### 具体实现
* **通知机制**：主机 B 将当前的 **rwnd** 值放入发给主机 A 的报文段“接收窗口”字段中。
* **发送方限制**：主机 A 跟踪 **LastByteSent**（已发送编号）和 **LastByteAcked**（已确认编号）。
* **发送准则**：主机 A 必须保证在连接生命周期内：
    **LastByteSent - LastByteAcked ≤ rwnd**

如果B的接收缓存已经存满,即 **rwnd = 0** ,主机 B 随后清空缓存但没有数据回传，主机 A 将因无法获知新空间而被阻塞,因此当 **rwnd = 0** 时，主机 A 持续发送仅含**一个字节数据**的探测报文段,这些报文段会被确认，最终主机 B 的确认报文将包含非 0 的 **rwnd** 值，从而恢复传输。
### 拥塞控制原理(3/11)
由于实际应用中网络层总是不能实现具有无限容量的,无数据丢失的信道,故当数据传输量很大时信道很容易发生拥塞,故需要运输层使用拥塞控制方法来尽可能减小拥塞的可能.
在最为宽泛的级别上,我们可根据网络层是否为运输层拥塞控制提供了显式帮助,来区分拥塞控制方法。
#### 端到端拥塞控制
在端到端拥塞控制方法中，网络层没有为运输层拥塞控制提供显式支持。即使网络中存在拥塞，端系统也必须通过对网络行为的观察 （ 如分组丢失与时延） 来推断之
#### 网络辅助的拥塞控制
路由器会向发送方提供关于网络中拥塞状态的显式反馈信息
### TCP拥塞控制
>TCP 所采用的方法是让每一个发送方根据所感知到的网络拥塞程度来限制其能向
连接发送流量的速率 。 
如果一个 TCP 发送方感知从它到目的地之间的路径上没什么拥塞 ， 则 TCP 发送方增加其发送速率 ； 
如果发送方感知沿着该路径有拥塞 ， 则发送方就会降低其发送速率 。 

但是,这种方法提出了三个问题:

1. TCP 发送方如何限制它向其连接发送流量的速率呢 ？ 
2. TCP 发送方如何感知从它到目的地之间的路径上存在拥塞呢 ？ 
3. 当发送方感知到端到端的拥塞时 ， 采用何种算法来改变发送速率呢 ？
#### TCP发送方如何限制发送速率
> 如之前的TCP流量控制所说,TCP 连接的每一端都是由一个接收缓存,一个发送缓存和几个变量 （ LastByteRead 、rwnd 等） 组成。
> 运行在发送方的 TCP 拥塞控制机制跟踪一个额外的变量,即**拥塞窗口(congestion window,cwnd)**,它对一个 TCP 发送方能向网络中发送流量的速率进行了限制,即在一个发送方中未被确认的数据量不会超过 cwnd 与 rwnd 中的最小值.

**`LastByteSent -LastByteAcked≤ min{cwnd，rwnd}`**

因此,在接收窗口比较大的时候,通过调节cwnd的值,发送方可以调整发送数据的速率.

####  TCP发送方如何感知拥塞以及如何调整速率
至于如何感知发生了拥塞,TCP使用下列指导性原则：
* **丢失报文段意味着拥塞**：当丢失报文段时，应当降低 TCP 发送方的速率。一个超时事件或四个确认（一个初始 ACK 和其后的三个冗余 ACK）被解释为“丢包事件”的隐含指示。TCP 发送方应当减小它的拥塞窗口长度，以应对这种推测的丢包事件。
* **确认报文段指示网络交付正常**：当对先前未确认报文段的确认到达时，能够增加发送方的速率。确认的到达被认为是一切顺利的隐含指示，即报文段正成功交付，网络不拥塞。拥塞窗口长度因此能够增加。
* **带宽探测**：TCP 调节其传输速率的策略是增加其速率以响应到达的 ACK，除非出现丢包事件，此时才减小传输速率。为探测拥塞开始出现的速率，TCP 发送方增加它的传输速率，从该速率后退，进而再次开始探测。网络中没有明确的拥塞状态信令，ACK 和丢包事件充当了隐式信号，每个 TCP 发送方根据异步于其他发送方的本地信息而行动。
#### 完整的论述: TCP拥塞控制算法
该算法由三个阶段组成: 
1. 慢启动(Slow Start)
2. 拥塞避免(Congestion Avoidance)
3. 快速恢复(Fast Recovery) - 非必需
##### 慢启动
cwnd的初始值通常都设置的很小,对于发送方而言,希望能够迅速找到可用带宽的大小.因此,cwnd的值以一个**MSS(最大报文长度)**开始,每当传输的报文段被确认就增加一个MSS,这样一来,每经过一个RTT(往返时间),发送速率就翻倍,以指数级别增长,如图所示:
![示意图](PixPin_2026-04-19_10-53-57.webp)

如果丢包事件发生,发送方将会把cwnd值重新置为1,并设置一个新的变量ssthresh (slow start threshold)为cwnd/2-这里的cwnd值检测到丢包时的拥塞窗口大小,然后继续发送包.
当cwnd值增长到等于ssthresh时,发送方结束慢启动阶段,进入拥塞避免阶段
##### 拥塞避免
该阶段中,每次传输后(即经过一个RTT后)将cwnd的值加一.

当再次触发丢包事件时,cwnd的值被再次置为1,ssthresh的值再次置为当前cwnd值的一半.

然而丢包事件有两个可能的触发机制:**超时和收到3个冗余ACK**.
**对于后一种情况**,既然能够收到接收方传来的ACK,这说明**信道不是那么拥塞**,因此,发送方只会将cwnd的值减半,并进入快速恢复阶段.
##### 快速恢复
该阶段中,每当收到针对丢失报文冗余的ACK时,cwnd值加1
最终发送方收到对于丢失报文的ACK时,TCP降低cwnd后进入拥塞避免阶段;如果出现超时事件,则迁移到慢启动状态.


##### 总览
![示意图](PixPin_2026-04-20_10-53-50.webp)

![示意图](PixPin_2026-04-20_10-40-22.webp)
#### TCP连接的公平性
>如果在某一条有限带宽的链路上,不同的TCP连接的传输速率基本相同,则认为该拥塞控制算法是**公平的**.

在实践中,具有较小RTT的TCP连接能够在链路空闲时更快的占据带宽,从而享用更高的吞吐量;而由于UDP没有拥塞控制,所以需要专门抑制UDP的无限制增长来防止UDP占用所有带宽.

不管怎样,这个问题至今都没有很好的得到解决.

### QUIC
QUIC,**Quick UDP Internet Connections**,与HTTPS同为应用层协议,但它使用UDP作为运输层协议,主要特征如下:
1. 数据流: 允许不同的应用程序使用同一个QUIC连接
2. 可靠传输: 尽管UDP是不可靠的,但我们可以让QUIC的应用层可靠,即**加上数据检验和重传机制**


## 网络层(3/12) 
![示意图](PixPin_2026-04-22_10-41-31.webp)
>网络层用一句话来表示就是: 通过多个路由器将数据从服务端移动到客户端.为此,网络层需要具备以下两种功能:
1. 转发: 当数据输入时,路由器需要将数据移动到适当的输出端口
2. 路由选择: 网络层需要解决数据从服务端传输到客户端所采用的路径,相当于规划好了具体要用到的转发路由器


- 注意这里的端口是指物理的输入输出接口,与虚拟的软件端口不是一个概念.
- 网络层不具有重传机制,而是由上层协议来决定是否重传

这样来看的话,网络层便可以分为负责**转发**功能的数据平面和负责**路由选择**功能的控制平面.
### 数据平面
#### 路由器工作原理
路由器有四个组件:
1. 输入端口
2. 交换结构: 将路由器的输入端口连接到输出端口
3. 输出端口
4. 路由选择处理器: 主要作用于交换结构

##### 输入端口处理和基于目的地转发
输入端口可以通过转发表和嵌入式的搜索算法来查找传入的ip地址对应的输出端口,故可以在本地实现转发决策,而无需调用路由选择处理器.

##### 交换方法
**经内存交换**
早期的路由器是传统的计算机,端口之间的交换.一个分组到达一个输入端口时，该端口会先通过中断方式向路由选择处理器发出信号。于是 ，该分组从输入端口处被复制到处理器内存中。路由选择处理器则从其首部提取目的地址，在转发表中查找适当的输出端口,并将该分组复制到输出端口的缓存中.
**经总线交换**
输入端口经一根共享总线将分组直接传送到输出端口,不需要路由选择处理器的干预.由于总线单一时间只能通过一个数据分组,故交换速率受到总线速率的限制.
**经互联网络交换**
克服单一、共享式总线带宽限制的一种方法是,使用一个更复杂的互联网络.如纵横式交换机使用由2N条总线构成的互联网络,能够并发转发多个分组,因此是非阻塞的

![示意图](PixPin_2026-03-13_08-56-16.webp)

##### 输出端口处理
输出端口处理取出已经存放在输出端口内存中的分组并将其发送到输出链路上
- 分组(packet):从传输层传入的打包好的数据帧
##### 排队问题分析
在输入端口和输出端口处都可以形成分组队列，就像在环状交叉路的类比中我们讨论过的情况，即汽车可能等待在流量交叉点的入口和出口。排队的位置和程度（或者在输入端口排队，或者在输出端口排队）将取决于流量负载、交换结构的相对速率和线路速率。

我们现在更为详细地考虑这些队列，因为随着这些队列的增长，路由器的缓存空间最终将会耗尽，并且当无内存可用于存储到达的分组时将会出现丢包（packet loss）。回想前面的讨论，我们说过分组“在网络中丢失”或“被路由器丢弃”。正是在一台路由器的这些队列中，分组被实际丢弃或丢失。
**为什么不加缓存空间?**
我们很容易这样想：更多的缓存必定更好，因为更大的缓冲区能承受更大的分组到达率波动，从而降低路由器的丢包率。

但更大的缓冲区也意味着潜在的更长的排队时延。

对于游戏玩家和交互式电话会议用户，几十毫秒的时延就很关键。

如果为了减少丢包而把每跳路由器的缓冲区大小增加10倍，端到端时延可能随之增加10倍。

增加的RTT会使TCP发送方对拥塞或分组丢失的响应变慢：

- TCP依赖RTT来估计超时重传定时器（RTO）。
- RTT增大 → RTO变大 → 检测到丢包后等待更久才重传。
- 拥塞控制窗口增长更慢（慢启动、拥塞避免阶段受RTT影响）。
- 整体吞吐响应性下降，尤其在突发拥塞或间歇性丢包场景。

##### 如何决定分组转发的优先权?
有以下几种调度方法
**先进先出( First-In-First-Out，FIFO,也称为First-Come-First-Serve，FCFS)**
调度规则按照分组到达输出链路队列的相同次序来选择分组在链路上传输
**优先权排队(priority queuing)**
针对不同分组或者IP地址配置不同优先级别的权限,每次转发分组时均从当前最高优先级别的队列中选择分组来传输,同一级别则采用FIFO方式
**循环排队(round robin queuing discipline)和加权公平排队(Weighted Fair Queuing)**
循环排队像优先权排队规则一样给不同分组分类,但是会轮流处理不同类,从而避免低优先级类难以被转发的情况.
加权公平排队会为不同类分配权重,保证在某一时刻下在排队队列中的某一类能够得到对应权重的转发量.

#### IPv4,IPv6,寻址(3/13)
##### IPv4数据报格式
网络层中的分组被称为数据报,IPv4数据报的格式如下:
1. 版本:使用的IP协议版本,帮助路由器决定如何解释数据报的剩余部分
2. 首部长度:用来确定载荷(运输层报文)实际开始的字节
3. 服务类型: 可以将不同服务类型的数据报区别开来
4. 数据报长度: 首部加上数据的总字节长度,为16bit,故理论最大长度为65535字节,但实际上很少超过1500字节
5. 标识,标志,片偏移: 将一个大数据报分片为几个小数据报所需的字段
6. 寿命: 确保数据报不会一直在网络中循环
7. 协议: 指示数据部分是由哪个协议处理的,例如值为17表示要交给UDP处理
8. 首部检验和: 检验是否有数据错误或丢失
9. 源IP地址和目的IP地址
10. 可选字段: 很少用
11. 数据(有效载荷): 来自运输层
  
##### IPv4编址
>一台主机通常只有一条链路连接到网络 ，当主机中的 IP 想发送一个数据报时，它就在该链路上发送。主机与物理链路之间的边界叫作接口(interface)

路由器与它的任意一条链路之间的边界也叫作接口,因此每台主机与路由器都能发送和接收IP数据报,为了明确源地址和目标地址,故每台主机和路由器接口都有自己的IP地址.

在IPv4协议中,一个IP地址长度为32字节,书写方法为点分十进制记法(dotted-decimal notation),即每个字节都用它的十进制形式书写,因此会有3个点,4个部分,每个部分占8字节,如:
- `193. 32. 216. 9 `:11000001 00100000 11011000 00001001

![示意图](PixPin_2026-03-14_15-09-21.webp)

互联这 3 个主机接口与 1 个路由器接口的网络形成一个子网(subnet),IP编址为这个子网分配一个地址223. 1. 1. 0 / 24,其中, `/24`被称为子网掩码,将地址的前24位设定为该子网的IP地址
表示为`255.255.255.0`.需要时可以通过将子网掩码与ip地址取和得到子网地址;换句话说,只有前24位等于223.1.1的地址才属于这个子网.
- 可以在cmd输入ipconfig查看自己所属的子网.

**IP地址是如何分配的(3/15)**
IP 地址由因特网名字和编号分配机构(Internet Corporation for Assigned Names and Numbers,ICANN)管理,是非盈利的.
当某个组织获得了被分配的地址块后,可以为本组织内的主机与路由器接口逐个分配 IP 地址,这主要由动态主机配置协议 (Dynamic Host Configuration Protocol ， DHCP)完成.

某给定主机每次与网络连接时能得到一个相同的 IP 地址,或者被分配一个临时的 IP 地址. 除了主机 IP 地址分配外，DHCP 还允许一台主机得知它的子网掩码、它的**第一跳路由器地址**（也就是直连路由器,常称为默认网关）与它的本地 DNS 服务器的地址等其他信息.


##### 网络地址转换(Network Address Translation,NAT)


**NAT（网络地址转换）** 是工作在路由器等网关设备上的物理逻辑，它允许整个局域网（LAN）内的成百上千台设备，通过同一个公网 IP 地址（WAN 端）访问互联网。

**A. 出站请求 (SNAT - Source NAT)**

当你的手机（`192.168.1.5`）访问网站时：

1. **原始数据包**：源 IP 是 `192.168.1.5`，源端口是 `10001`。
2. **物理改写**：路由器将源 IP 修改为自己的 **公网 IP**（如 `1.2.3.4`），并将源端口修改为一个新分配的端口（如 `5000`）。
3. **记录映射**：路由器在 NAT 表中记下一笔：`5000 端口 <-> 192.168.1.5:10001`。

**B. 入站响应 (DNAT - Destination NAT)**

当网站服务器回传数据时：

1. **到达数据包**：目标地址是 `1.2.3.4:5000`。
2. **物理查询**：路由器查找 NAT 表，发现 `5000` 端口对应的是内网的 `192.168.1.5:10001`。
3. **物理还原**：路由器将目标 IP 和端口还原，数据包准确送达手机。

##### IPv6
IPv6将地址长度从32bit增加到128bit,确保了IP地址不会被用完,具体结构如下:
- 版本: 4bit长,字段值为6
- 流量类型: 与IPv4的服务类型类似
- 流标签: 对数据流中的某些数据报给出优先权
- 有效载荷长度: 载荷的字节数量
- 下一个首部: 与IPv4中的协议字段含义一样,表示要交付给哪个运输层协议
- 跳限制: 类似于IPv4中的寿命字段,当跳限制计数变为0时,包被丢弃
- 源地址和目的地址
- 数据: 载荷

事实上,IPv6不再使用子网掩码,而是直接用一个整数表示网络部分的位数，写在地址后的斜线后,如:
`fe80::49e0/128`
**如何兼容IPv4**
通过将IPv6数据报整个放入IPv4数据报的载荷部分中,并通过协议字段指示接收方这是一个装入了IPv6的IPv4数据报,从而实现了对网络层中使用IPv4路由器的兼容
#### 补充: 泛化转发(4/22)
之所以叫**泛化转发(Generalized Forwarding)**,是因为这里的转发除了网络层之外,还可能会涉及**链路层**,这与之前路由器的转发**并不相同**,因此加上**泛化**两个字来表示这个转发是宽泛而言的.
- 因此,泛化转发使用的设备也不是简单的使用链路层的交换机或者网络层的路由器,而是称为**分组交换机**

---
- [wiki](https://en.wikipedia.org/wiki/OpenFlow)
泛化转发主要基于**OpenFlow**标准来执行:
##### 流表（Flow Table）
这是泛化转发的逻辑核心。每个分组交换机内部维护一个或多个流表。每个流表项（Flow Table Entry）由三个核心部分组成：
* **首部字段匹配值（Match）**：这是“泛化”的具体体现。匹配字段可以涵盖 **入端口、源/目的 MAC 地址、以太网类型、VLAN 标签、源/目的 IP 地址、协议号（TCP/UDP）以及源/目的端口号**。这种跨 1-4 层的匹配能力，使得分组交换机既可以充当路由器，也可以充当交换机、防火墙或 NAT 设备。
* **计数器（Counter）**：用于实时统计匹配该规则的分组数量、字节数等。这是流量监控与计费的物理基础。
* **操作（Actions）**：当分组匹配成功后执行的动作，包括：
    * **转发**：发送到指定端口。
    * **丢弃**：执行安全过滤逻辑。
    * **修改字段**：例如修改 IP 头部（NAT 功能）或重写 MAC 地址（路由功能）。
    * **入栈/出栈**：针对 MPLS 或 VLAN 标签的封装处理。



##### 匹配-动作（Match-plus-Action）抽象
与传统路由器“查找最长前缀-转发”的单一模式不同，泛化转发将其抽象为通用的“匹配-动作”范式。
* **机制本质**：只要分组匹配首部字段（Match），就执行相应**操作**（Action）。这意味着网络管理员可以自定义非标准的处理流程。
* **流的概念**：被相同规则处理的一系列分组被视为一个“流（Flow）”。网络管理的粒度从单纯的“路径选择”细化到了“流控制”。

##### 控制与数据平面分离
OpenFlow 实现了物理上的解耦：
* **数据平面（Data Plane）**：分组交换机只负责执行流表中的匹配逻辑，逻辑简单且支持硬件加速（通常基于 TCAM 内存）。
* **控制平面（Control Plane）**：由远程控制器（Controller）统一管理。当交换机遇到无法识别的未知流时，会将其通过 OpenFlow 协议发送给控制器。控制器计算出处理规则后，再下发回交换机的流表中。


换句话说,数据在网络层中转发的时候,不再是简单的通过路由器后再经过交换机,而是直接通过**分组交换机转发**,从而大幅度减小了传播过程中出差错的概率.因此,**泛化转发**才是真正的转发,取代了我们之前所说的路由器转发.
#### 中间盒(middlebox)
>**中间盒**: 在源主机和目的主机之间的数据路径上,执行除了 IP 路由器的正常标准功能之外的其他功能的任何中间的盒子,可以提供以下三种功能服务:
- NAT转换
- 安全服务: 如防火墙和电子邮件过滤器等
- 性能增强: 提供内容缓存等功能
### 控制平面
#### 路由选择算法
按照集中式的还是分散式的来给算法分类:
1. 集中式路由选择算法(centralized routing algorithm):也被称为链路状态(Link State,LS)算法,需要提前得知网络中每条链路的开销,从而计算出当前节点的最低开销路径
2. 分散式路由选择算法(decentrlized routing algorithm): 每个节点仅有与其直接相连的节点链路开销,通过迭代和通信逐渐计算出最低开销路径,距离向量(Distance Vector)算法是一个代表.

##### 链路状态(LS)算法
通过链路状态广播(link state broadcast)算法来获取整体的节点信息,并根据Dijkstra算法找到最佳路径.
但是,实际应用中会产生**振荡**(Oscillation)问题,也就是当路由恰巧都沿着最短路径转发时,这条路径的开销由于流量增大而不再是最优路径,因此路由都转向原本开销比较高但现在相对是开销最低的那条线路,又导致这条线路开销变高,路由又都回到原来的路由转发路径上,这样来回切换路径显然不利于网络减小时延.
##### 距离向量(DV)算法
使用Bellman-Ford算法
#### 因特网中自治系统内部的路由选择： OSPF

如果将网络看作一个大规模的路由器互联网络会遇到以下两个问题:
* **规模瓶颈（Scalability）**：数亿台设备若运行单一路由算法，将导致内存耗尽、广播风暴以及算法（如距离向量）无法收敛。
* **管理自治（Administrative Autonomy）**：不同 ISP 需要独立控制内部协议、隐藏拓扑结构，并按自身策略进行管理。
因此,设计者将路由器规划成一个自治系统( Autonomous System,AS):
* **构成**：处于相同管理控制下的路由器和链路集合。
* **标识**：每个 AS 拥有全局唯一的 **AS 号 (ASN)**，由 ICANN 授权机构分配。
* **划分**：ISP 可作为一个 AS，也可拆分为多个 AS。

光这样说还不够,看下面这个表格:

| 运营商       | 网络名称              | AS 号 (ASN) | 角色                                        |
| :----------- | :-------------------- | :---------- | :------------------------------------------ |
| **中国电信** | ChinaNet (163 骨干网) | **AS4134**  | 全球最大的 AS 之一，承载绝大多数宽带流量。  |
| **中国电信** | CN2 (下一代承载网)    | **AS4809**  | 独立的 AS，专注于高质量、低延迟的精品业务。 |
| **中国联通** | 中国联通骨干网        | **AS4837**  | 原中国网通与联通合并后的核心 AS。           |
| **中国移动** | 中国移动骨干网        | **AS9808**  | 移动宽带及移动端流量的核心承载 AS。         |

- 这样就很好理解了,当我们接入网络的时候,实际上是进入了某一个运营商的AS,而不是直接接入整个互联网.

在一个AS内部运行的路由选择算法称为(intra-autonomous system routing protocol).
##### 开放最短路优先 （ OSPF ）
>该算法使用Dijkstra和周期性的路由广播,也就是说:
>
>路由器向自治系统内所有其他路由器广播路由选择信息,而非只向相邻路由器广播. 每当一条链路的状态发生变化时(如开销的变化或连接 / 中断状态的变化)， 路由器就会广播链路状态信息 。即使链路状态未发生变化，它也要周期性地(至少每隔 30min一次)广播链路状态.从而能够运用Dijkstra得到正确的结果.
#### ISP之间的路由选择：BGP
前面讨论的是AS内部的路由选择,现在我们来考虑AS之间的路由选择,在internet中,所有AS运行相同的路由选择协议: 边界网关协议(Border Gateway Protocol,BGP).
##### BGP的作用
作为一种 AS 间的路由选择协议，BGP 为每台路由器提供了一种完成以下任务的手段：

1) 从邻居 AS 获得前缀的可达性信息: 特别是，BGP 允许每个子网向因特网的其余部分通告它的存在。一个子网高声宣布 "我存在，我在这里"，而 BGP 确保在因特网中的所有 AS 知道该子网。如果没有 BGP 的话，每个子网将是隔离的孤岛，即它们孤独地存在，不为因特网其余部分所知和所达。

2) 确定到该前缀的 "最好的" 路由: 一台路由器可能知道两条或更多条到特定前缀的不同路由。为了确定最好的路由，该路由器将本地运行一个 BGP 路由选择过程 (使用它经过相邻的路由器获得的前缀可达性信息)。该最好的路由将基于策略以及可达性信息来确定。

- **前缀**指的是例如138.16.68/22这样的AS子网

##### 通告BGP路由信息
一个AS中有两种类型的路由器:网关路由器(gateway router)和内部路由器(internal router),网关路由器直接与其他AS中的路由器相连接,内部路由器仅连接AS内部的主机和路由器

与先前AS内部的路由广播类似,网关路由器也会将对应的转发信息传递给相邻的网关路由和内部路由,从而找到不同AS之间的转发路由路径


##### IP任播(anycast)
##### 路由选择策略

#### SDN控制平面
- [wiki](https://en.wikipedia.org/wiki/Software-defined_networking)


#### ICMP: 因特网控制报文协议
>[wiki](https://zh.wikipedia.org/wiki/%E4%BA%92%E8%81%94%E7%BD%91%E6%8E%A7%E5%88%B6%E6%B6%88%E6%81%AF%E5%8D%8F%E8%AE%AE)
互联网控制消息协议（英语：Internet Control Message Protocol，缩写：ICMP）是互联网协议族的核心协议之一。它用于网际协议（IP）中发送控制消息，提供可能发生在通信环境中的各种问题反馈。通过这些信息，使管理者可以对所发生的问题作出诊断，然后采取适当的措施解决。
>
>ICMP与传输协议（如TCP和UDP）显著不同：它一般不用于在两点间传输数据。它通常不由网络程序直接使用，除了 ping 和 traceroute 这两个特别的例子.

事实上,ICMP位于IPv4和IPv6报文里面,用于提供网络发生问题时返回报错信息


## 链路层
### OVERVIEW
- 节点: 运行链路层协议的任何设备,包括主机,路由器,交换机,WiFi接入点
- 链路: 连接相邻节点的通信信道
#### 链路层需要提供的服务
- 成帧(framing): 将网络层的数据报封装成链路层帧
- 协调多个节点之间的通信: MAC协议
- 可靠交付: 通过确认和重传确保数据不出错和丢失
- 差错检测
#### 链路层是如何实现的
链路层控制器的大部分功能是在硬件中实现的,但也有部分链路层是在运行与主机CPU上的软件实现的.

### 差错检测和纠正
#### 奇偶校验
假设要发送的信息D有d比特,在偶校验方案中,发送方附加一个校验比特,使得者d+1个比特中1的总数是偶数;在奇校验方案中则保证是奇数.
接收方只需要检测接收的d+1个比特中1的个数即可以验证是否出现差错,比如在偶校验方案中发现了奇数个1比特,则说明至少出现了1个比特差错.
但如果出现了偶数个比特的差错,那就无法检测出差错了.因此,可以采用二维的奇偶校验方案,通过行和列来检验从而减小没有检测到差错的概率
#### 检验和方法
与TCP/UDP协议中采用的检验和类似.
#### 循环冗余检测(Cyclic Redundancy Check,CRC)(待补充)
双方协商取一个最高位为1的r+1位多项式G,发送方在d位数据段D的后端附加r个附加比特R,使得这个d+r位数据在模2算术下可以被G整除,接收方只需要用G去除这个收到的数据就可以知道是否出现差错.
### 多路访问协议(multiple access protocol)
该协议的目标是实现多个发送和接收节点对同一个共享信道的访问.

因为所有的节点都能够传输帧,所以多个节点可能会同时传输帧,那么其他节点就会同时接收到多个帧,发生**碰撞**(collide),这时没有一个节点能够有效获得传输的帧.

在理想情况下，对于速率为 R bps 的广播信道，多路访问协议应该具有以下所希望的特性：

1. 当仅有一个节点发送数据时，该节点具有 R bps 的吞吐量;
2. 当有 M 个节点发送数据时，每个节点吞吐量为 R / M bps. 这不必要求 M 个节点中的每一个节点总是有 R / M 的瞬间速率，而是每个节点在一些适当定义的时间间隔内应该有 R / M 的平均传输速率;
3. 协议是去中心化的; 这就是说不会因某主节点故障而使整个系统崩溃;
4. 协议是简单的，使实现不昂贵.

#### 信道划分协议(过)
#### 随机接入协议
>在随机接入协议中，一个传输节点总是以信道的全部速率（即 R bps）进行发送. 当有碰撞时，涉及碰撞的每个节点反复地重发它的帧（也就是分组），到该帧无碰撞地通过为止. 但是当一个节点经历一次碰撞时，它不必立刻重发该帧. 相反，它在重发该帧之前等待一个随机时延. 涉及碰撞的每个节点独立地选择随机时延. 因为该随机时延是独立地选择的，所以下述现象是有可能的：这些节点之一所选择的时延充分小于其他碰撞节点的时延，并因此能够无碰撞地将它的帧在信道中发出.


### Switched Local Area Networks
![示意图](PixPin_2026-03-22_14-36-18.webp)

#### Link-Layer Addressing and Address Resolution Protocol(ARP)
##### MAC地址
A link-layer address is variously called a LAN address, a physical address, or a **MAC address**.
>事实上,并不是主机或路由器具有链路层地址,而是它们的**适配器**(即网络接口)具有链路层地址

The MAC address is 6 bytes long, giving 2^48 possible MAC addresses. 尽管MAC地址是一个固定值并且是唯一的,但现在有可能用软件改变某个接口的MAC地址.

- 需要注意的是,一般来说一个设备的MAC地址总是不变的,而对应的IP地址总是根据连接到的网络而改变

>一般来说,当源适配器要向向一个目的适配器发送帧时,它会讲目的适配器的MAC地址插入帧中,并将该帧发送到局域网中;有时候源适配器或者中途经过的交换机会将帧广播到所有的适配器.
当目的适配器接收到帧时,如果帧中的目的MAC地址与自己的MAC地址匹配,则会提取出封装的数据报并沿着协议栈向上传输;如果不匹配,则直接丢弃这个帧.
- 有时候源适配器需要让局域网的所有适配器接收并处理自己的帧,这个时候,可以在目的地址字段插入一个特殊的MAC广播地址,对于6字节MAC地址的局域网来说,广播地址是48个连续的1组成的字符串
#####  Address Resolution Protocol,ARP(地址解析协议)
为了在发送链路层帧的时候指明接收该帧的适配器,需要提前知道适配器的MAC地址,从而实现包的正确发送,因此我们采用ARP协议来根据适配器对应路由器或主机的IP地址,找到其MAC地址
- ARP: 将网络层地址与链路层地址相互转换的协议.它和DNS的作用基本类似,但一个重大区别是: DNS可以解析因特网上任意主机或者域名为IP地址,但ARP只为同一个子网的主机和路由器接口解析IP地址为MAC地址
**ARP原理**

每台主机或者路由器在内存中有一个ARP表(ARP table),包含了IP地址与MAC地址的映射关系,还有保存时限值,指示了从表中删除该映射的时间.

主机要发送帧前,先要发送一个ARP packet给自己的适配器,这个ARP分组包括发送和接收方的IP地址以及自己的MAC地址,指示适配器使用MAC广播地址发送这个分组并发送该链路层帧,从而让子网的所有适配器接收这个分组,IP地址与该ARP packet中包含的目的IP地址匹配的适配器会向发送方传回一个响应ARP packet,让发送方可以更新它的ARP表.

- 从这个角度来看,ARP与IP处于同一级别,都位于网络层
**如何跨越子网传输数据**
通过上面的论述,我们可以发现,ARP只适用于子网内部的转发,当我们要跨越子网转发数据时,应该先将数据转发给网关路由,再由网关路由来根据链路层帧包含的IP地址跳到下一个路由器,直到转发到目标主机的网关路由,再将数据交给目标主机
####  以太网(Ethernet)
- 以太网(Ethernet)几乎完全占据了有线局域网市场
##### 以太网的帧结构
![示意图](PixPin_2026-03-23_14-00-29.webp)

- Data field (46 to 1,500 bytes): This field carries the IP datagram. The minimum size of the data field is 46 bytes.This means that if the IP datagram is less than 46 bytes, the data field has to be “stuffed” to fill it out to 46 bytes.
- Destination address (6 bytes): This field contains the MAC address of the destination adapter.
- Source address (6 bytes): This field contains the MAC address of the adapter that transmits the frame onto the LAN
- Type field (2 bytes): 指示数据字段所用网络层协议的类型
- Cyclic redundancy check (CRC) (4 bytes): 检测帧差错
- Preamble (8 bytes): 用于唤醒适配器,告诉它现在有一个以太网帧来了


##### 以太网的无连接传输

以太网技术向网络层提供**不可靠服务**. 具体来说, 当适配器 B 收到一个来自适配器 A 的帧, 它对该帧执行 **CRC 校验**, 但是当该帧通过 CRC 校验时它既不发送确认帧; 而当该帧没有通过 CRC 校验时它也不发送否定确认帧. 当某帧没有通过 CRC 校验, 适配器 B 只是**丢弃**该帧. 因此, 适配器 A 根本不知道它传输的帧是否到达了 B 并通过了 CRC 校验.

在链路层缺乏可靠传输有助于使以太网变得**简单且便宜**. 但是这也意味着传递到网络层的数据报流可能存在**间隙**.

如果由于丢弃了以太网帧而存在间隙, 主机 B 上的应用也会看见这个间隙吗? 正如我们在第 3 章中所学到的, 这完全取决于该应用是使用 **UDP** 还是 **TCP**.

* 如果应用使用的是 **UDP**, 则主机 B 中的应用确实会看到数据中的间隙.
* 另一方面, 如果应用使用的是 **TCP**, 则主机 B 中的 TCP 将不会确认包含在丢弃帧中的数据, 从而引起主机 A 的 TCP **重传**.

注意到当 TCP 重传数据时, 数据最终将回到曾经丢弃它的以太网适配器. 因此, 从这种意义上来说, 以太网确实重传了数据, 尽管以太网本身并不知道它正在传输的是一个包含全新数据的全新数据报, 还是一个包含已经被传输过至少一次的数据的数据报.
#### 链路层交换机(Link-Layer Switches)

##### 转发和过滤
>**Filtering** is the switch function that determines whether a frame should be forwarded to some interface or should just be dropped. 
**Forwarding** is the switch function that determines the interfaces to which a frame should be directed, and then moves the frame to those interfaces. 

假定目的地址为 DD-DD-DD-DD-DD-DD 的帧从交换机接口 x 到达,那么会有以下三种情况:
1. 交换表中没有对应 DD-DD-DD-DD-DD-DD 的表项,则将这个帧广播到所有接口(除了接口x,因为帧是从接口x来的)
2. 交换表中有对应 DD-DD-DD-DD-DD-DD 的表项,但是对应接口为x,那么显然你不可能把从接口x收到的帧再送回接口x,只能就地丢弃这个帧
3. 交换表中有对应 DD-DD-DD-DD-DD-DD 的表项,对应接口不是x而是y,那么交换机就需要把这个帧送入接口y

**疑问:第二种可能中,如果是局域网通信的话,那不就有可能用的是同一个接口吗?**


在局域网（LAN）中，如果两个主机 A 和 B 都在“同一个接口”下，通常只有两种物理物理场景：

* **场景 A：接了集线器（Hub）**
    你将 A 和 B 都接在一个外接 Hub 上，再把 Hub 连到交换机的接口 $x$。
* **场景 B：共享介质（旧式同轴电缆）**
    所有主机物理上连在同一根线上。

交换机（Switch）的核心作用是**隔离冲突域**并**跨端口转发**。

当主机 A 发送一个目的 MAC 为 B 的帧进入接口 $x$ 时：
1.  **查表**：交换机查找 MAC 地址表，发现 B 的 MAC 对应接口也是 $x$。
2.  **判断**：交换机意识到，“目的地”和“来源地”都在同一个物理方向上。
3.  **结论**：如果 A 和 B 都在接口 $x$ 下方，那么当 A 发出信号时，信号在到达交换机之前，**物理上已经流经了 B**（如果是 Hub 或共享总线）。

> **底层逻辑**：交换机认为，既然目标 MAC 就在接收端口所在的网段内，那么目标主机 B 应该已经通过物理介质直接收到了这个帧。如果交换机再把它从接口 $x$ “弹回”去，不仅是浪费带宽，更会导致 B 收到两份重复的数据帧。

##### 交换表的建立与交换机的自学习
1. 交换表初始为空
2. 对于在每个接口接收的帧,交换机会在表中记录以下信息:
   1. 该帧的源MAC地址
   2. 该帧是从哪个接口进来的
   3. 当前时间
3. 如果一段时间后,交换机没有接收到过与记录的源MAC地址相同的帧,那么就会在表中删除这个地址

那么,让我们来详细分析一个新产生的帧被目的MAC地址对应的交换机接收的过程:
1. 当这个帧进入第一个交换机时,由于交换机不认识这个帧,故会在所有接口转发该帧并记录该帧信息
2. 经过很多次转发,在传播路径上的交换机都记录了该帧的三种信息
3. 当目的MAC地址对应的交换机接收到该帧时,由于目的MAC地址对应的服务器一定已经将自己的信息存在了该交换机中(思考一下是为什么),那么只需要将该帧送入服务器的适配器即可完成整个流程.
#### 虚拟局域网(VLAN)
- [wiki](https://zh.wikipedia.org/wiki/%E8%99%9A%E6%8B%9F%E5%B1%80%E5%9F%9F%E7%BD%91)
  - 由于书上讲的不明不白,所以去额外找资料了

>VLAN的工作原理是在广播域内转发的网络帧上添加标签，从而使网络流量看起来如同被分割在不同的网络中。这样即使在同一个物理网络，VLAN也能将网络隔离开来，而无需部署多套电缆和网络设备。



### 无线网络概览
前面谈的都是有线网络,现在来谈谈WiFi,4G等无线网络,它由以下三个要素组成:
1. **无线主机**: 可以是手机,电脑,家用电器,可以是移动的,也可以是位置固定不动的
2. **无线链路**: 主机通过无线链路连接到一个基站或者另一个主机
3. **基站**: 负责收发无线链路数据

我们可以把无线网络分为四类:
1. 具有基站的单跳: 基站和主机之间可以直接通信,不需要经过中继节点,日常见到的无线网络如WiFi和4G都属于这一类型
2. 无基站的单跳: 由一个主机进行收发无线数据,其他设备与该主机通信,而不通过基站,**蓝牙协议**便是典型的例子
3. 具有基站的多跳: 主机与基站通信需要经过中继节点
4. 无基站的多跳: 通过多个主机节点进行通信,这显然是最难设计的一类网络

#### 无线链路的特征
与有线链路相比,无线链路有以下三个特点:
1. 信号强度递减: 电磁波穿过物体时强度将减弱,也就是**路径损耗**
2. 来自其他通信源的干扰: 同一频段的电磁波会相互干扰
3. 多路径传播: 电磁波会经过地面或者物体反射,导致出现**多径传播**的问题
显然,无线网络更容易出现差错,因此我们需要使用更为可靠的传输方法.

- **信噪比**( Signal-to-Noise Ratio，SNR):单位为dB,是接收到的信号振幅与噪声幅度比值的以10为底的对数的20倍,显然,信噪比越大,信号就越干净.
- **比特差错率**(BER): 接收方收到的一个比特为错误的概率

物理层的通信有以下特点:
1. 使用同一个调制方法,SNR越高,BER越低: 因此发送方可以通过增加传输功率提高SNR来降低BER,但是这样会消耗更多的能量,并且当功率超过阈值时不再有实际增益
2. 对于给定的SNR,调制方法的传输速度越高BER越高,这很容易理解,速度越快越容易出差错
3. 对于给定的信道我们可以采用不同的调制技术



### WiFi
尽管无线局域网(WLAN)的通信有很多技术可以选用,但是WiFi占据着统治地位.
WiFi的正式名称为**IEEE 802. 11 无线局域网**

基本服务集 (BSS) 是WiFi的基本构件，有两个部分：
- 无线站点 (Station)：手机、笔记本等终端设备。
- 接入点 (Access Point,AP)：起中央基站作用的节点。

#### 信道与关联
当管理员安装AP时,需要为AP分配一个服务集标识(Service Set Identifier,SSID)和一个信道号.

802.11运行在 2. 4GHz ～ 2. 485GHz的频段中,由11个部分重叠的信道组成, 当且仅当两个信道由 4 个或更多信道隔开时它们才无重叠,因此管理员需要指示AP的信道号避免影响到其他AP.

>显然,当你进入咖啡馆时,你可以收到很多个AP传来的信号,那么我们是符合与一个特定AP连接的呢?
802.11协议要求每个AP周期性的发送信标帧,该帧包括该AP的SSID和MAC地址,供无线站点接收并处理;当然,主机也可以自己发送广播帧来主动扫描附近的AP,选定关联AP,具体过程如图所示:
![示意图](PixPin_2026-03-29_14-26-07.webp)
>选定与之关联的 AP 后，无线主机向该 AP 发送一个关联请求帧，并且该 AP 以一个关联响应帧进行响应。注意，对于主动扫描需要第二个请求 / 响应握手 ，因为一个对初始探测请求的帧进行响应的 AP 并不知道主机选择哪个 （ 可能多个 ） 响应的 AP 进行关联 ， 这与 DHCP 客户能够从多个 DHCP 服务器中进行选择有诸多相同之处 

与AP连接之后,主机便会发送DHCP报文获取自己的IP地址,从而与互联网连接.

#### 802. 11采用的传输协议: CSMA/CA
802.11采用的MAC协议类型为随机接入协议,称为带碰撞避免的CSMA(CSMA with collision avoidance), 简称为CSMA/CA.
之所以802.11采用碰撞避免而非和以太网相同的碰撞检测,有以下两个原因:
1. 检测碰撞需要主机同时具有发送信号和接收其他站点信号的能力,而802.11适配器接收到的信号强度往往远小于发送出去的信号强度
2. 无线信号存在衰减,多路传播,隐藏终端等问题,无法检测到所有的碰撞

##### 802.11的链路层确认方案
由于无线链路中的帧不能无损的到达目的地,因此802.11采用链路层确认方案来实现重传机制.
目的站点收到一个通过CRC校验的帧后,等待一小段时间-这被称为短帧间间隔(short inter-frame spacing),然后发回一个确认帧,如果发送站点在给定时间内没有收到确认帧,它就假定出现了错误并进行重传,如果若干次重传后仍未收到确认帧,则放弃发送并丢弃该帧.

##### 为什么现代以太网不重传而802.11重传
因为802.11的环境极易丢包,如果依靠上层协议如TCP的重传机制,由于跨越了多层硬件,传输速率将会大幅度下降;而以太网线路的环境非常稳定,发生丢包的概率几乎为零,将少量的丢包问题交给上层协议处理可以减少不必要的设计复杂度.


##### CSMA/CA协议的详细原理
1. 如果有一个帧要发送,发送站监听到信道空闲时,它等待一小段时间后发送该帧-这被称为分布式帧间间隔(distributed inter-frame space)
2. 如果信道被占据,则站点选取一个随机回退值,在侦听到信道空闲时减小该值,信道繁忙时则保持该值不变
3. 计数值减到零时,该站点发送帧并等待确认
4. 如果收到确认,则帧被正确接收.如果要传输另一个帧,站点将从第二步重新开始;如果没收到确认,则站点进入第二步并在一个更大的范围内选取随机值
**满格信号网速仍然很慢的原理**
当大量主机使用同一个AP时,为了避免碰撞,单一主机的等待时间大量延长,从而导致了网速的降低;同时,AP的上行光纤容量有限,不允许所有设备以最大功率同时传输.
##### 处理隐藏终端问题
![示意图](PixPin_2026-03-31_12-18-47.webp)
- 尽管每个无线站点对AP都不隐藏,但两者彼此是隐藏的

当H1和H2要发送帧时,由于它们彼此是看不见的,因此都以为信道是空闲的,就会同时发送并导致碰撞.

为了避免碰撞,802.11通过让站点使用请求发送(Request to Send,RTS)控制帧和允许发送(Clear to Send,CTS)控制帧来预约何时访问信道.
发送方在发送帧之前,首先向AP发送一个RTS帧,指示自己传输帧和收到确认帧所需的总时间,AP收到该帧后广播一个CTS帧,指示发送方明确的发送许可并告知其他站点在这段时间内不要发送,从而避免碰撞.
- 这两个控制帧都很短,所以在这个过程中发生碰撞的可能性很小

>尽管 RTS / CTS 交换有助于减少碰撞 ， 但它同样引入了时延并消耗了信道资源。因此 ，RTS / CTS 交换仅仅用于为长数据帧预约信道 。 在实际中，每个无线站点可以设置一个 RTS门限值，仅当帧长超过门限值时，才使用 RTS / CTS 序列。对许多无线站点而言 ，默认的RTS 门限值大于最大帧长值 ， 因此对所有发送的 DATA 帧，RTS / CTS 序列都被跳过。

#### 802.11的帧结构
![示意图](PixPin_2026-03-31_12-35-52.webp)
接下来对其中的重要组成部分做一点分析:
1. 有效载荷与CRC字段
2. 地址字段: 地址4仅在AP相互转发时使用,前三个字段的定义如下:
   1. 地址1是要接收该帧的站点MAC地址
   2. 地址2是传输该帧的站点MAC地址
   3. 地址3是子网默认网关的MAC地址
3. 序号,持续期,帧控制字段
#### 无线站点在同一子网中的不同BSS之间移动
>随着 H1 逐步远离 AP1 ，H1 检测到来自 AP1 的信号逐渐减弱并开始扫描一个更强的信号.H1 收到来自 AP2 的信标帧.
H1然后与 AP1 解除关联,并与AP2 关联起来,同时保持其 IP 地址和维持正在进行的 TCP 会话.新AP2 会发送以太网广播,强制沿途交换机更新路径.
### 蓝牙

蓝牙网络运行在 **2.4 GHz ISM（工业、科学、医学）** 免授权频段。由于该频段同时被微波炉、车库门遥控器和无绳电话等多种设备占用，蓝牙在设计之初就将**抗噪**与**抗干扰**作为核心目标。

#### 蓝牙的物理原理

* **时分复用（TDM）**：蓝牙无线信道被划分为时长为 **625 微秒** 的时间隙。
* **频分跳频扩展频谱（FHSS）**：在每个时间隙中，发送端在 79 个信道中的某一个进行传输。信道（频率）在每个时隙间按照已知但伪随机的规律切换。
* **抗干扰逻辑**：通过跳频技术，即使 ISM 频段内存在其他设备的干扰，也只会影响到**极少数特定时隙**的蓝牙通信，从而保证了整体链路的稳健性。目前蓝牙数据速率最高可达 3 Mbps。

---

#### 蓝牙网络的结构

在蓝牙网络（Piconet）中，设备角色分为以下三类：

1.  **主节点 (Master Device)**：核心控制单元，负责管理连接数量、调度时隙以及控制所有连接设备的传输功率。
2.  **客户设备 (Client/Slave Device)**：受控单元，遵循主节点的跳频序列进行通信。
3.  **存放设备 (Parked Device)**：低功耗睡眠模式设备。它们保持与主节点的同步，但不参与数据传输，仅在需要时由主节点唤醒进入活跃状态。
![示意图](PixPin_2026-04-01_10-59-39.webp)
---

#### 主节点如何与其他设备连接

连接过程本质上是一个从“频率盲区”到“时间与频率双重同步”的过程，分为 **查询（Inquiry）** 和 **寻呼（Paging）** 两个阶段：

##### 第一阶段：设备发现（查询）
* **广播探测**：主节点在 32 个不同的信道上轮流发送询问消息，并将该序列重复传输多达 128 次，以确保覆盖所有可能的监听频率。
* **被动监听**：潜在的客户设备在自己随机选择的频率上进行监听。
* **随机回退机制**：一旦客户设备接收到查询，它会在 **0 ~ 0.3 秒** 之间选择一个随机时间量进行回退。这种“随机退避”设计是为了防止多个客户设备同时响应主节点而引发信号冲突。
* **身份响应**：回退结束后，客户设备发送包含其唯一设备 ID 的报文响应主节点。

##### 第二阶段：建立连接（寻呼）
* **定向寻呼**：主节点在发现范围内所有潜在设备后，开始针对特定设备发送 32 条寻呼邀请报文。由于此时客户设备尚未获得跳频序列，主节点仍需在多个频率上重复发送。
* **确认握手**：客户设备接收到寻呼报文后，返回 **ACK（确认）** 报文。
* **参数交付**：主节点随后向客户设备发送关键配置信息，包括：
    * **跳频序列模式**（告知未来的频率路径）。
    * **时钟同步信息**（校准通信时间基准）。
    * **活跃成员地址**（分配逻辑地址）。
* **轮询激活**：最后，主节点使用已同步的跳频模式对该客户设备进行轮询(polling)。一旦回复成功，双方正式进入连接状态，实现网络层面的握手。

#### 更上层发生了什么
我们可以发现,蓝牙的链路层连接逻辑与其他的协议完全不同,这从而说明蓝牙的上层逻辑也与其他的协议不同,这里就不介绍了.

### Cellular Networks: 4G and 5G
无线网络分为无线局域网和无线广域网,我们前面所说的WiFi和蓝牙就属于局域网,而这里的4G/5G就属于广域网了.

>The term **cellular**(蜂窝) refers to the fact that the region covered by a cellular network is partitioned into a number of geographic coverage areas, known as cells. 
Each cell contains a **base station** that transmits signals to, and receives signals from, the mobile devices currently in its cell.
#### 4G LTE Cellular Networks: Architecture and Elements
>The 4G networks that are pervasive as of this writing in 2020 implement the **4G Long-Term Evolution standard**, or more succinctly **4G LTE**.

![示意图](PixPin_2026-04-02_13-44-10.webp)
4G网络由以下几个部件构成:
1. Mobile device: 连接到蜂窝运营商网络的智能手机 、 平板电脑、笔记本电脑或物联网设备
   1. 该移动设备还具有全球唯一的 64 位标识符，称为国际移动用户身份 （ IMSI），存储在其 SIM （ 用户身份模块） 卡上。IMSI 在全球蜂窝网络系统中识别用户，包括用户所属的国家和归属蜂窝网络 。
2. Base Station: The base station is responsible for managing t**he wireless radio resources** and the **mobile devices** with its coverage area.
   1. 这类似于WiFi中的AP,但还有很多额外的功能
3. Home Subscriber Server (HSS): The HSS is a database, storing information about the mobile devices for which the HSS’s network is their home network.
4. Serving Gateway (S-GW), Packet Data Network Gateway (P-GW), and other network routers: 用于实现NAT,路由转发等功能
5. Mobility Management Entity (MME): 控制平面部件,用于验证设备,设置路径,追踪设备位置

![示意图](PixPin_2026-04-12_13-32-05.webp)


### 无线链路对高层协议的影响
鉴于无线链路传播的比特差错率远高于有线链路,因此需要对上层协议如TCP连接做出针对性的处理

>在所有情况下，TCP 的接收方到发送方的 ACK 都仅仅表明未能收到一个完整的报文段，发送方并不知道报文段是由于拥塞或切换 ， 还是由于检测到比特错误而被丢弃的。在所有情况下 ，发送方的反应都一样 ， 即**重传该报文段** 。 TCP 的拥塞控制响应在所有场合也是**相同**的 ，即 TCP 减小其拥塞窗口,这会导致带宽利用率骤降.

#### 链路层重传 (LL-ARQ)
这是解决无线丢包的最前线。LTE、5G 或 Wi-Fi 协议在数据链路层（MAC/RLC 层）实现了快速重传。
* **机制：** 基站与终端之间发现包序列不连续时，直接在二层进行重传，不向网络层汇报。
* **代价：** 引入了抖动 (Jitter)，因为链路层重传会导致部分包延迟到达。

#### 拥塞控制算法的进化 (BBR)
Google 提出的 **BBR (Bottleneck Bandwidth and RTT)** 算法改变了判断逻辑。
* **原理：** BBR 不再将“丢包”作为减速信号。它通过周期性探测**带宽极大值**和**延迟极小值**来构建网络模型。
* **实战表现：** 在一定比例（如 5% ~ 15%）的随机丢包环境下，BBR 能维持几乎满带宽的传输速率，而 CUBIC 则会因为不断减半窗口而彻底卡死。

#### 选择性确认 (SACK)
原生 TCP 采用累积确认，丢一个包可能导致后续一连串包被重传。
* **机制：** 启用 `TCP_SACK` 选项。接收端在 ACK 中告知发送端具体哪些数据块（Ranges）已收到。
* **效果：** 发送端可以精确补齐缺失的数据，而不是盲目重传所有未确认的包。

#### 拆分连接协议 (Split-TCP / Proxy)
在移动通信核心网中，常使用 **PEP (Performance Enhancing Proxy)**。
* **拓扑：** `终端 <——无线链路——> 基站/边缘网关 <——有线主干——> 服务器`。
* **机制：** 将一个 TCP 连接拆分为两段。无线段使用针对高丢包优化的协议（如调整过初始窗口、禁用慢启动退避的私有协议），有线段保持标准 TCP。
* **逻辑：** 避免了无线端的局部丢包反馈到远端服务器，缩短了重传的往返时间 (RTT)。



## 网络安全
网络通信中的安全需要满足以下要求:
1. 机密性(confidentiality): 仅有发送方和希望的接收方能够理解传输报文的内容,这需要报文能够被加密和解密
2. 完整性(message integrity): 通信内容在传输过程中不应该被篡改,这需要我们实现数据检验和可靠的传输通道
3. 通信认证(end-point authentication): 发送方和接收方都需要能够证明另一方的身份是真实的
4. 防御恶意攻击(operational security): 通过防火墙和入侵检测系统来防御网络攻击

### 密码学
我们现在假设A要向B发送一个报文,最初的文本被称为明文(plaintext),A使用密钥(key)*m*来加密明文,从而得到**密文**(ciphertext),并将其发送出去.
B为了解密这个密文,需要使用密钥*n*来处理这个密文,从而得到明文.

显然,加密过程中最关键的就是密钥了,根据密钥是否对称(相同)可以将加密方式分为两种:
1. 对称密钥系统: A和B所用的密钥是相同而且保密的,否则就没有任何意义了
2. 非对称密钥系统(也称为公开密钥系统): 有两个密钥,一个是公开的密钥,称为**公钥**,所有人都可以获取;另一个是只有A或者B才知道的密钥
#### 攻击手段
根据攻击者掌握的信息,大致有三种攻击手段:
1. 密文攻击: 入侵者只截取到了密文,破解难度最高
2. 已知明文攻击: 攻击者事先知道部分明文对应的密文
3. 选择明文攻击: 攻击者能够选择任意一段明文并获取对应的密文,破解难度最低
#### 对称密钥
#####  Caesar Cipher(凯撒密码)
密钥为字母表偏移量,很容易被破解
##### Block Cipher(块密码)
- TLS采用的就是这个加密方式
将明文划分为固定长度k的块，通过一一对应的映射函数将其转换为相同长度的密文块.如果我们让k=3,就需要让000到111这8个输入转换到对应的三比特输出.

尽管当增大k值时转换表的破解难度大幅度上升,但交流的双方都需要维护一张2^k大小的转换表,这不太现实.
因此,块密码使用函数来模拟转换表,例如:当k=64时,我们可以把64比特块划成8个子块,每个8比特块按照一张独特的k=8的转换表处理,然后将转换后的64比特按照一定规则打乱后再分为8个子块进行处理,进行多次循环.这种算法的密钥是**8张k-8的转换表**.
- 如果用 1 秒破解 56 比特 DES 的计算机 （ 就是说，每秒尝试所有 2^56个密钥 ） 来破解一个 128 比特的 AES 密钥 ，要用大约 149 万亿年的时间才有可能成功
##### Cipher-Block Chaining: 引入随机性
前面的块密码有一个缺陷: 如果有多个块中的明文内容相同,如"HTTP/1.1"这类常见的前缀词,那么将会得到相同的密文,从而被攻击者探测到并进行破解.
因此,我们可以在加密时引入随机数,如下图所示:
![示意图](PixPin_2026-04-04_09-27-52.webp)
这样一来,即使明文相同,得到的密文也会不同,而密文相同时,得到的明文可能相同,破解难度大幅上升.

同时,实际应用中不太可能一个个传输随机数,故块密码使用密码块链接(Cipher-Block Chaining,CBC)来高效传输接收方所需的随机数,基本方法如下:
1. 在发送数据之前,发送方生成一个随机的k比特串(对应k比特块加密),称为初始向量(Initialization Vector,IV).表示为c(0),并以明文方式发给接收方
2. 对第一个块，发送方计算 c(1) = Ks(m(1) ⊕ c(0))后发送密文
3. 对于第 i 个块，发送方根据 c(i) = Ks(m(i) ⊕ c(i-1)) 生成第 i 个密文块


#### 非对称密钥
该类型的密钥有三个关键要素:
1. 一个公开的加密算法和一个公开的解密算法
2. 一个公开的密钥,称为**公钥**
3. 只有通信中的某一方才知道的密钥,称为**私钥**

使用非对称密钥的通信过程如下:
发送者用加密算法和公钥来加密报文,接收者使用解密算法和私钥来解密报文.

但是,这种加密方式有不少问题:
1. 如何保证加密后的报文不会被破解?
2. 由于任何人都可以通过公钥加密报文后发送给接收方,如何确定发送者是可靠的?

尽管有很多算法可以解决上述问题,但RSA算法已经成为了非对称密钥的代名词.

##### RSA算法
为了生成RSA的公钥和私钥,接收方需要执行以下步骤:
1. 选择两个大素数p和q,值越大就越难破解.
2. 计算`n=pq`和`z=(p-1)(q-1)`
3. 选择小于n的一个数e,使得e和z互质.
4. 选择一个数d,满足`ed mod z = 1`
5. 那么接收方的公钥由(n,e)组成,私钥由(n,d)组成

通信过程如下:
1. 发送方发送的报文以二进制形式表示为一个整数m,由于报文的位数有限,故m一般不会很大,在RSA算法中要求m < n,然后计算`c = m^e mod n`,从而得到密文c,并交给接收方.
2. 为了解密c,接收方计算`m = c^d mod n`,得到报文m.

举一个简单的例子:
1. 接收方选择p=5和q=7,得到n=35和z=24,在5,7,11等与24互质的数中选择一个数,比如说5,那么由于`(5x29)-1`可以被24整除(尽管5x5-1等取值也可以被24整除,但假设我们是随机取值取到了29),则d=29.
2. 发送方使用(35,5)加密报文,接收方使用(35,29)报文.

##### 会话密钥
由于大数据的指数运算非常耗时,所以实际应用中我们可以把对称密钥和RSA结合在一起,用RSA来加密对称密钥算法中所需的密钥.这个被加密的密钥称为**会话密钥**(session key)

##### RSA原理
RSA运用了两个数论中的结论,这里不做说明,我们只需要知道通过(n,e)和(n,d)就足够进行加密和解密,攻击者如果想暴力破解，唯一的方法是:
1. 试图从公开的 n 中分解出两个原始质数 p 和 q。
2. 只有得到 p 和 q，才能计算出`z = (p-1)(q-1)`。
3. 通过`ed ≡ 1 mod z` 解出私钥 d。

>RSA 的安全性依赖于这样的事实：目前没有已知的算法可以快速进行一个数的因数分解 ，这种情况下公开值 n 无法快速分解成素数 p 和 q。如果已知 p 和 q ，则给定公开值 e，
就很容易计算出秘密密钥 d 。 另一方面，不确定是否 存在 因数分解一个数的快速算法 ， 从这种意义上来说，RSA 的安全性也不是确保的 。
### 报文完整性的鉴别和数字签名
接收方验证某条消息是否可靠,需要检测以下两个因素:
1. 该报文来自可靠的发送方
2. 该报文在途中没有被篡改

#### 加密哈希函数(cryptographic hash function)
- hash function: 任意输入都会得到相同长度的输出
- cryptographic hash function: 在哈希函数的基础上,需要额外保证: 找到一个不同的输入得到相同的输出是基本不可能的.

从加密哈希函数的定义就可以看出来,攻击者一般来说是无法用其他报文伪造原报文的,从而保证该报文不会被篡改.

常用的加密哈希函数有以下几种:

| 算法      | 哈希长度                 | 基本逻辑                                                                                         | 安全性现状与建议                                                                      |
| :-------- | :----------------------- | :----------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------ |
| **MD5**   | 128 位                   | 将输入信息按 512 位分组，通过复杂的压缩函数进行多轮迭代处理，生成 128 位哈希值。                 | ❌ **已破解**，可人为制造碰撞。**任何安全场景下都不应使用**。                          |
| **SHA-1** | 160 位                   | 逻辑与 MD5 类似，哈希值更长（160 位），处理步骤更复杂，安全性有所提升。                          | ⚠️ **已不足够安全**，存在理论碰撞攻击，Google 等已在 2017 年实现碰撞。**应避免使用**。 |
| **SHA-2** | 224 / 256 / 384 / 512 位 | 采用 Merkle-Damgård 结构，更多轮次和更复杂的逻辑（如更多常量）。其中 SHA-256 和 SHA-512 最常用。 | ✅ **广泛认为安全**，是替代 MD5 和 SHA-1 的**首选标准**。                              |
| **SHA-3** | 224 / 256 / 384 / 512 位 | 采用全新的 **Keccak 海绵函数结构**，与 SHA-2 设计思路完全不同，提供更高的安全冗余。              | ✅ **安全性高**，可作为 SHA-2 的**备选方案**。                                         |


#### 报文鉴别: 使用哈希函数和鉴别密钥
使用哈希函数,我们可以这样验证报文的完整性:

1. Alice生成报文m并计算散列H(m).
2. 然后Alice将H(m)附到报文m上,生成一个扩展报文(m, H(m)),并将该扩展报文发给Bob.
3. Bob接到一个扩展报文(m, h)并计算H(m). 如果H(m) = h,Bob得出结论:一切正常.

但这种方法有一个问题: 攻击者可以声称他就是Alice,并将报文发送给Bob,这显然可以通过报文完整性的验证.

因此,我们还需要加入鉴别密钥(authentication key),即一个被双方共享的秘密比特串,在下述过程中我们将其称为s.

1. Alice生成报文m,加入s生成m+s,并计算H(m+s),这被称为报文鉴别码(Message Authentication Code,MAC).
2. 然后Alice将MAC附加到报文m上,生成扩展报文(m, H(m+s)),并将该扩展报文发送给Bob.
3. Bob接收到一个扩展报文(m,h),由于知道s,计算出报文鉴别码H(m+s).如果H(m+s)=h,Bob得出结论:一切正常.

#### 数字签名
有时候,我们会需要用一个数字签名(digital signature)来标识某个文件,这个数字签名一定是独一无二,不可篡改的,这样才可以保证能够分辨出该文件的所有者.

一种方法是发送方使用某一加密哈希函数取得报文的hash值,并用私钥加密该hash值;而在验证这个签名时,接收方只需要用公钥去解密这个hash值,如果计算结果与该文件的hash值一致,则证明报文的来源可靠

#### 公钥认证
要让公钥密码生效,必须要证明你使用的公钥来源可靠,比如A和B通信时,A需要证明报文中的公钥确实来自B.

因此,我们需要通过CA(certification authority)来将公钥与特定实体(一个人,一台路由器,一个网站等)绑定.

CA有以下两个作用:
1. 证实一个实体的身份.这需要该CA能够执行严格的身份验证,具有权威性,常见的CA有"Let's Encrypt","DigiCert"等
2. 将某个实体的身份与其公钥绑定为证书,由CA对这个证书进行数字签名

### end-point authentication(端点鉴别)
前面的数字签名和公钥认证更像是被动被检测的,而这里提到的**端点鉴别**则是通信的某一方主动向另一方证明自己的身份.

### 应用层的安全服务: 安全电子邮件(过)
### 运输层的安全服务: TLS
TLS(Transport Layer Security)协议是由Netscape设计的安全协议-SSL(Secure Sockets Layer)协议-的升级版,所有的浏览器和服务器都支持该协议(看一下某个网站的URL,如果以https开始,就是启用了TLS),它有以下几个功能:
1. 机密性: 攻击者可能截获购买者的订单并得到银行卡信息
2. 完整性: 攻击者可能会修改购买者的订单地址或者购买数量
3. 服务器鉴别: 证明这个网站是官方的,安全的


![示意图](PixPin_2026-04-11_09-08-26.webp)
可以看到,TLS只在应用层进行了加密而已,并没有深入运输层
#### TLS Intro
先大致描述一下TLS的简化版本(称为类TLS),它具有三个阶段: 握手,密钥生成和传输数据

现在以客户B与服务器A之间的通信来举例说明
##### 握手
在建立TCP连接后,B向服务器A发送一个hello报文,A在响应报文中返回该服务器的证书,里面包含了它的公钥.

由于该证书被某个CA证实过,B知道了这个公钥真的来自A,然后B生成一个主密钥(MS)用于此次TLS会话,使用A的公钥加密MS生成加密的主密钥(EMS),再发给服务器A,A再用私钥解密该EMS得到MS.

如此依赖,双方都知道了这次会话的主密钥MS.
##### 密钥生成
事实上,出于安全性的考量,通信双方都会使用MS生成4个密钥:
- E_B: 从B发送到A时所用的加密密钥
- M_B: 从B发送到A时所用的HMAC密钥(用于验证报文完整性)
- E_A: 从A发送到B时所用的加密密钥
- M_A: 从A发送到B时所用的HMAC密钥

##### 传输数据
>TLS breaks the data stream into records, appends an HMAC to each record for integrity checking, and then encrypts the record + HMAC.
比如说B要发送数据,它需要将数据流分割为一个个record,为每个record附上HMAC,然后使用M_B加密这个record+HMAC包后发送出去.
事实上,这个HMAC中海含有这次发送的record所属的序号,从而保证攻击者不会打乱record的顺序.
##### record的结构
![示意图](PixPin_2026-04-11_09-34-30.webp)

- Type字段: 判断这是握手报文还是传输数据的报文,也用于关闭TLS连接

#### 对于TLS更为精确的描述
##### 握手阶段
TLS不强制通信双方使用特定的加密算法,而是允许双方在TLS会话开始时就统一决定加密算法,真实的步骤如下:
1. 客户发送它支持的密码算法的列表和它选取的不重数(在本次会话中不会第二次出现的数字)
2. 服务器从列表中选择一个对称密钥算法,一种非对称密钥算法和一种HMAC算法,它把这些选择联通证书和另一个不重数发给服务器
3. 客户验证证书后提取服务器的公钥,生成PMS(Pre-Master Secret),用公钥加密该PMS后发送给服务器.
4. 客户和服务器根据PMS和各自的不重数得到上述的四种密钥.
5. 双方发送一段用新生成的密钥加密过的握手信息摘要，用于验证双方计算出的密钥是否一致，以及握手过程是否被篡改


>你可能想知道在步骤 1 和步骤 2 中存在**不重数（Nonce）**的原因。序号不足以防止报文段重放攻击吗？答案是肯定的，但它们并不只是防止“连接重放攻击”

假设 Trudy 嗅探了 Alice 和 Bob 之间的所有报文。第二天，Trudy 冒充 Bob 并向 Alice 发送正好是前一天 Bob 向 Alice 发送的相同的报文序列。

* **若未使用不重数**：Alice 将以前一天发送的完全相同的序列报文进行响应。由于接收到的每个报文都能通过完整性检查，Alice 不会怀疑任何异常。如果 Alice 是一个电子商务服务器，她将认为 Bob 正在进行第二次相同的订购。
* **若使用不重数**：Alice 将对每个 TCP 会话发送不同的不重数，使得两天的加密密钥完全不同。当 Alice 接收到 Trudy 重放的 TLS 记录时，由于密钥不匹配，该记录将**无法通过完整性检查**，假冒的事务便不会成功。

##### 连接终止
如果仅通过TCP连接来终止TLS会话的话,攻击者可以通过**截断攻击**(truncation attack)来提前结束会话,也就是说他可以在会话中发送一个TCP FIN报文,从而让用户不能获取完整的信息.

因此,我们可以用最后一个record指示终止会话.

### 网络层的安全服务: IPsec(过)

### 补充: 有线网络的安全服务
有线网络不提供安全服务,因为链路通信是很难被攻击和篡改的,只需依靠上层的安全服务即可.

### 总结
显然,有这么多的防护措施,普通的cracker是很难通过截获IP数据报的形式来进行攻击的,相反,通过恶意软件(病毒,木马等)可以很轻易的跨越多层封锁,进入最薄弱的环节-主机-中,但这部分就不是网络通信所能负责的范畴了.

## ppt概念补充
### Intro
#### OSI七层协议
事实上,OSI协议的前三层对应了本书中的应用层,后面的都是一一对应的
#### Modem v.s. Router
Modem (调制解调器) 的本质是信号转换器。由于计算机内部处理的是二进制数字信号（Binary stream），而广域网传输介质（如电话线、光纤）传输的是模拟信号（Sinusoidal waves），Modem 负责将数字信号调制为模拟信号发出，并将接收到的模拟信号解调回数字信号。如果家中只有一个上网设备且不需要防火墙等功能，理论上仅需 Modem 即可拨号上网。

#### Circuit Switching and Packet Switching
##### Circuit Switching (电路交换)

**核心流程：**
1.  **建立电路 (Establishment)**：在发送数据前，必须先预留一条端到端的物理路径。
2.  **信息传输 (Transfer)**：数据（模拟或数字）沿专用路径实时流动。
3.  **电路拆除 (Termination)**：释放沿途占用的所有资源。

**关键特性：**
* **优势**：由于资源独占，数据传输速率恒定、带宽有保障，且数据严格按序到达，对用户而言网络是“透明”的。
* **劣势**：存在明显的拨号/建立延迟。资源利用率低，即便不传输数据，信道依然被占用，无法分配给其他用户。
* **复用方式**：通常通过**多路复用 (Multiplexing)** 将物理链路划分为多个子信道



---

##### Packet Switching (分组交换)

**核心流程：**
1.  **分组化 (Packetization)**：将长报文拆分为带有首部（源地址、目的地址、校验码）的小数据包。
2.  **存储转发 (Store-and-forward)**：路由器必须接收完一个分组的所有比特后，才能开始向下一跳转发。

**关键特性：**
* **优势**：
    * **带宽利用率高**：单个分组可以使用链路的全带宽，资源按需分配，支持更多用户接入。
    * **应对突发流量 (Bursty Data)**：互联网流量通常是爆发式的，分组交换通过路由器内的**缓冲区 (Buffer)** 吸收临时流量峰值。
* **劣势**：资源竞争可能导致拥塞和丢包；路由算法复杂；分组可能乱序到达目的地。



---

##### 核心对比总结

| 特性         | 电路交换 (Circuit)     | 分组交换 (Packet)         |
| :----------- | :--------------------- | :------------------------ |
| **资源分配** | 预先静态分配（独占）   | 动态按需分配（共享）      |
| **延迟来源** | 建立连接延迟           | 存储转发延迟、排队延迟    |
| **性能表现** | 稳定、无抖动、带宽保证 | 可能拥塞、有抖动、高并发  |
| **典型应用** | 传统电话网 (PSTN)      | 现代计算机网络 (Internet) |


### 物理层
#### outline
- Bandwidth (带宽) and Data Rate
- Modulation (调制) of a Signal (ASK, PSK, QPSK, QAM)
- Medium and Transmission (传输)
- Multiplexing (复用) (FDMA, TDMA, CDMA)

#### Bandwidth (带宽) and Data Rate
- Bandwidth: 单位时间内从一个节点传送到另一个节点的数据量

##### 奈奎斯特采样定理 (Nyquist Sampling Theorem)

**核心物理含义**
在进行模数转换（将连续信号变为数字点）时，如果模拟信号包含的最高频率为 $H$ Hz，那么每秒钟至少需要进行 $2H$ 次采样（即采样频率 $f_s \ge 2H$），才能通过这些采样点无失真地重建原始信号。这个最小值 $2H$ 被称为奈奎斯特速率。

**采样频率与波形还原**
为了识别一个周期的波形，数学上至少需要记录其一个波峰和一个波谷。如果采样率低于 $2H$，采样点分布太稀疏，捕捉到的数据点在还原时会连成一个错误的低频波形，这种现象称为**混叠 (Aliasing)**。



**混叠 (Aliasing) 的直观理解**
当采样频率不足时，高频信号会“伪装”成低频信号。
* **视觉现象**：在电影（每秒 24 帧采样）中看到快速转动的车轮时，车轮似乎在缓慢倒转，这就是典型的视觉混叠。
* **音频后果**：若采样率过低，录入的高音会变成诡异的低频杂音，且这种失真是永久性的，无法通过软件修复。



**工程应用实例**
* **CD 音质**：人耳听觉上限约为 $20\text{kHz}$。根据定理，采样率必须大于 $40\text{kHz}$。CD 标准采用 $44.1\text{kHz}$，正是为了确保完全覆盖人耳带宽并留出滤过缓冲带。
* **通信带宽**：在带通信号传输中，该定理限制了在给定频率范围内可以传输的最大符号速率，是数字通信设计的底层物理约束。



##### 信道容量与编码定理 (Channel Capacity & Coding Theorems)

**奈奎斯特准则 (Nyquist Theorem) —— 无噪声信道**
在理想的、没有噪声的信道中，由于信号在传输时存在码间串扰（带宽限制了信号的变化速率），最大数据传输速率由带宽和信号电平数（量化等级）决定。
* **公式**：$$R_{max} = 2 \times BW \times \log_2 V \text{ bps}$$
* **参数含义**：
    * **$BW$**：信道带宽（Hz）。
    * **$V$**：信号的离散电平数（量化等级）。
* **物理本质**：在无噪声情况下，理论上可以通过无限增加量化电平数 $V$ 来提升速率，但受限于实际硬件对电平分辨的精确度。



**香农定理 (Shannon's Theorem) —— 有噪声信道**
在存在随机热噪声的实际信道中，由于噪声会掩盖信号的电平细节，最大可靠传输速率（信道容量）存在一个物理极限。
* **公式**：$$C = BW \times \log_2 (1 + \frac{S}{N}) \text{ bps}$$
* **参数含义**：
    * **$C$**：信道容量，即该信道能实现的理论最大信息传输速率。
    * **$S/N$**：信噪比（SNR），信号功率与噪声功率的比值。
* **物理本质**：噪声决定了我们能区分的最小信号电平差。即使无限增加发送电平 $V$，如果电平差小于噪声强度 $N$，接收方也无法识别。因此，带宽和信噪比共同限定了信息交换的上限。



**信噪比与分贝 (SNR in Decibels)**
在工程实践中，信噪比通常跨越多个数量级，因此常使用对数单位**分贝 (dB)** 来表示。
* **分贝换算公式**：$$SNR(dB) = 10 \times \log_{10} (\frac{S}{N})$$
* **典型值参考**：
    * 如果 $S/N = 10$，则 $SNR = 10\text{ dB}$。
    * 如果 $S/N = 100$，则 $SNR = 20\text{ dB}$。
    * 如果 $S/N = 2$（信号是噪声的两倍），则 $SNR \approx 3\text{ dB}$。

**核心逻辑总结**
* **奈奎斯特**告诉我们：由于**带宽限制**，采样率有上限（不能跑太快，否则波形会糊）。
* **香农**告诉我们：由于**噪声存在**，信息的精细度有上限（不能分太细，否则分不清信号和噪声）。
* **实际应用**：在设计网络系统（如 5G 或 Wi-Fi）时，通常会同时计算这两个值，取其中的**较小者**作为实际物理层的理论瓶颈。

#### Modulation


## 专业名词(即使前面提过也会放在这里)
- RTT: Round-Trip Time(往返时延)
- MSS: Maximum Segment Size,TCP 报文段中负载的最大长度限制
- adapter: 适配器,主机与特定网络连接的硬件接口,俗称网卡.
- Internet: 是由无数个使用 TCP/IP 协议族 相互连接的计算机网络，物理上通过路由器和交换机在全球范围内实现数据交换与资源共享的网际网路。
- packet(分组): 在特定层传输的数据包,从应用层,运输层,网络层,到链路层,每经过一层增加一个头部修饰
- MAC: Medium Access Control,介质访问控制协议
- ISP: Internet Service Provider
- NAT: Network Address Translation
- WAN: Wide Area Network - 广域网
- LAN: Local Area Network - 局域网
- SDN: Software Defined Networking,通过软件管理路由转发
- CIDR: Classless Inter-Domain Routing,无类别域间路由,是一个用于给用户分配IP地址的方法
- CSMA: Carrier Sense Multiple Access,发送信号前先监听,从而判断是否要在这个时候发送信号
- 全双工(full-duplex): 可以同时接收和发送数据
- 半双工(half-duplex): 同一时刻要么接收,要么发送,不能同时进行

## 实战

### 备案流程
- [知乎介绍](https://zhuanlan.zhihu.com/p/371579941)

>[wiki](https://zh.wikipedia.org/zh-cn/ICP%E5%A4%87%E6%A1%88)
>个人网站备案需要准备：1份网站负责人的身份证件彩色扫描件或复印件；负责人的半身彩色照片（带接入商名称背景）；网站所使用的独立域名注册证书复印件（加盖公章）；主办单位所在地的详细联系方式；填写《信息安全管理协议》；填写《真实性核验单》。
>
>
>根据相关行政法规，**所有在中国境内的互联网信息服务提供者**都应完成备案登记手续方可开办，未按规定备案的不得开展服务。
>
>2005年2月8日，原中华人民共和国信息产业部部长王绪东签发《非经营性互联网信息服务备案管理办法》，并于3月20日正式实施。**该办法要求从事非经营性互联网信息服务的网站进行备案登记，否则将予以关站、罚款等处理。**


根据《互联网信息服务管理办法》，提供非经营性互联网信息服务需办理备案，而**办理备案的前提是使用中国境内服务商提供的内地机房IP**

事实上,在中国内地，合规运行网站需要两个核心要素：域名实名认证和ICP备案。

1. 后缀限制：并非所有域名后缀都能备案。只有在工信部正式批复的顶级域名列表中的后缀（如 .com, .cn, .net 等）才允许备案。如果你使用 .io, .ai 等部分未批复后缀，即便服务器在国内也无法通过备案。
2. 注册商要求：办理 ICP 备案的域名，其注册商必须在中国内地经过许可。如果你的域名是在 Namecheap、GoDaddy 或 Google Domains 注册的，必须先将域名转入国内注册商（如万网、新网），才能提交备案申请。

(补充): 事实上,所有的备案都是通过第三方的,小程序上线需要通过微信开发者平台备案;网站上线需要通过阿里云,腾讯云备案...
平台初审(一般需要1-2个工作日)通过后,再由平台提交给工信部审核(时间范围不确定,但一般不短),审核通过后会发短信提醒你.
这还没完,当你通过备案后,需要再进行[公安联网备案](https://help.aliyun.com/zh/icp-filing/basic-icp-service/quick-start-for-public-security-network-filing-for-personal-websites?spm=a2c4g.11186623.0.0.637f22faLqR4cq#9e78d861f9k3e),并提交审核,一般为2-3个工作日.

瑟瑟发抖...
# The Elements of Computing Systems
## 概览
- www.nand2tetris.org: 配套官网
- 该书被尊称为**Nand to Tetris**,至于为什么,看完这本书就会知道了
- 第二版于2021年发行,距离第一版已经过了将近二十年,内容上做了相当大的革新

>We wrote this book because we felt that many computer science students are **missing the forest for the trees**. The typical learner is marshaled through a series of courses in programming, theory, and engineering, without pausing to appreciate the beauty of the picture at large. And the picture at large is such that hardware, software, and application systems are **tightly interrelated** through a hidden web of abstractions, interfaces, and contract-based implementations.
>
>We believe that the best way to understand how computers work is to build one from scratch.

涵盖的内容如下:

![结构图](PixPin_2026-06-04_12-24-39.webp)
## 基本逻辑器件
>所有的布尔运算都可以由And,Or,Not三个布尔运算来表示,而由于Nand可以表示这三个布尔运算,所以所有的布尔运算都可以被Nand(Not and,与非)一个运算表示出来,不过实际工程中这么做就太不值当了,还是要用到其他的布尔运算器件的,毕竟简单的取反比与非门好实现得多.


- 门(gate): 实现简单布尔运算的物理器件,通常用蚀刻在硅基板上的晶体管实现,并被封装成芯片(chips)

>好在我们不要担心门的底层是怎么实现的,这是物理学家和电气工程师的事情.

![三种基本逻辑门](PixPin_2026-06-06_11-12-49.webp)

基于三种基本逻辑门,我们可以实现各种各样的复合逻辑门:

![异或门的实现](PixPin_2026-06-06_11-15-18.webp)

### 硬件设计
如今,硬件工程师不需要自己来手动制作任何部件,而是通过硬件描述语言(Hardware Description Language,HDL)来设计芯片架构,并通过计算机进行模拟的运行和测试,得到最终蓝图之后再通过自动化流水线批量生产芯片即可

![HDL示意图](PixPin_2026-06-06_11-19-39.webp)

抛开简单的门电路不谈,我们来看几个高级一点的芯片设计.

多路选择器的实现:
![多路选择器](PixPin_2026-06-06_11-21-34.webp)

分路器的实现:
![分路器](PixPin_2026-06-06_11-23-01.webp)

由于处理器架构通常为16位,32位甚至是64位的,所以我们需要将之前那些只能执行单位计算的门电路改装为多路电路:

![多位非门](PixPin_2026-06-06_11-24-39.webp)

![多位与门](PixPin_2026-06-06_11-24-51.webp)

![多位或门](PixPin_2026-06-06_11-25-04.webp)

![多位多路选择器](PixPin_2026-06-06_11-25-36.webp)
## 进阶逻辑器件

半加器:
![示意图](PixPin_2026-06-07_11-03-36.webp)

全加器:
![示意图](PixPin_2026-06-07_11-04-19.webp)

16位加法器:
![示意图](PixPin_2026-06-07_11-05-20.webp)

算术逻辑单元(Arithmetic Logic Unit,ALU),将一系列通用运算包含在一起,至于包含哪些运算,要看具体的CPU设计了:

![示意图](PixPin_2026-06-07_11-07-09.webp)

上图中的ALU对两个16位二进制补码数和6个1位输入(控制位)进行计算:

![控制位](PixPin_2026-06-07_11-12-44.webp)

于此之外,该ALU还计算了两个输出位zr和ng,分别表示zero和negative,标记输出是否为零或者为负.

## 存储器件

>之前构建的芯片都是与时间无关的,被称为组合逻辑芯片,本章将介绍时序逻辑芯片,芯片的输出与时间有关,这种芯片可以用于存储信息.

- oscillator(振荡器): 最重要的时序逻辑部件,在高低电平间反复变化,用于**产生时钟周期信号**,电路负责将时钟周期信号广播道所有的时序逻辑芯片上
- data flip-flop(DFF,数据触发器,也被称为D触发器,尽管这个名字实在是不知所云,但却能常常在国内教材中看到): 接受一个时钟输入和单比特数据输入,输出一个单比特数据
  - 每个时钟周期会输出上一个时钟周期的输入,如果时钟周期信号的输入线路被暂时锁定,那么DFF就会一直保留上次的输入,直到被时钟周期信号激活
  - 由于实现起来是相当复杂的,所以这本书并没有介绍.

![触发器构造图](PixPin_2026-06-08_13-25-14.webp)

- Bit(单比特寄存器): 基于DFF实现,包含一个输入端口in,空值端口load,输出端口out,只要load位未被置1,那么寄存器就会保持锁存状态,保持状态不变.

![单比特寄存器构造图](PixPin_2026-06-08_13-36-38.webp)

![实现方法](PixPin_2026-06-08_13-53-52.webp)

- Register(寄存器): 基于Bit组合实现

![16位寄存器构造图](PixPin_2026-06-08_13-38-09.webp)

- Random Access Memory(RAM,随机存取存储器): 基于寄存器实现,读取地址m对应的寄存器时,将load置为0即可在不改变内容的情况下输出上一个状态值;写入地址m对应的新值时,将load置为1即可覆盖原内容.
  - 之所以称为随机存取,是因为RAM可以在O(1)时间内访问任意一个寄存器,这是通过诸如3-8译码器或者2-4译码器实现的

![RAM构造图](PixPin_2026-06-08_13-41-47.webp)

- Program Counter(程序计数器): 每次被时间信号激活时就将存储的值加一,基于寄存器实现,增加了两个控制位inc和reset,inc用于判断是否要递增PC,reset用于重置PC为0.

![程序计数器构造图](PixPin_2026-06-08_13-48-48.webp)
## 构建计算机
### 前置概念
- Memory: 存储设备,与CPU有一段距离,故存取速度不是很快
- Processor: 处理器,通常被称为Central Processing Unit(CPU),能够执行所有的指令集指令
- Register: 与CPU紧密连接的寄存器,用于实现高速存取
- **汇编语言**: 使用符号(例如add,r1,r2)表示的机器语言,将汇编语言翻译成二进制代码的程序被称为汇编器.
  - 不同处理器硬件架构使用的汇编语言不同,但理论上都是等价的,能够执行基本相同的一组任务
### Hack处理器架构
这本书自创了一个用于教学的处理器架构:
1. 三个16位寄存器: 数据寄存器(D),地址寄存器(A),可选寄存器(M),汇编代码如下.

![汇编代码示例](PixPin_2026-06-09_11-12-38.webp)

2. Hack处理器支持两类16位指令:
   1. 地址指令(A类指令): 使用符号`@`标识,对应的操作码为0,将A寄存器设定为某个值.也就是说是1位操作码+15位地址值
   2. 运算指令(C类指令): 没有符号标识,对应的操作码为1,基本格式为1位操作码+2位不使用的位(设定为1)+7位comp指令(compute,表示ALU操作)+3位dest指令(存储到哪个位置)+3位jump指令(跳转到哪里)

![指令图](PixPin_2026-06-09_11-16-45.webp)

>非常令人震惊的就是,只用这两种指令就可以实现键盘交互,屏幕显示,数值运算等所有的基本计算机功能了.
## 汇编器
汇编器用来将汇编语言转换成二进制机器码,针对每条汇编指令,汇编器会按照翻译规则进行翻译,至于具体怎么翻译,这本书讲的不是很清晰,就直接跳过了.
## 虚拟机
Hack计算机使用了双层编译器,即将高级语言先转换成中间语言,再将中间语言转换成汇编语言,分别由编译器的前端和后端实现,这里的虚拟机就对应了编译器的后端.

由于书中的实现方法相当简化,所以不太具备学习的价值.
## 编译器与操作系统
这部分由于过于宽泛,也不推荐阅读
## 总结
这本书的前半部分是最有价值的,对于软件工程师来说,物理器件与处理器的关系是最让人迷惑的,而这本书能够让我们看到处理器架构实际上并没有那么难实现.

而后半部分关于编译器和操作系统的讲述,由于过于宽泛和简化,不太有必要去读,不如去专门看操作系统和编译原理相关的书.


# Go语言圣经
- [中文版网站](https://golang-china.github.io/gopl-zh/preface-zh.html)
- (5/7): 看多了Java总觉得有些烦躁,就想着先学习一下Go来看看它的神奇之处
- (5/29): 不推荐拿这本书入门Go,建议先学习了Go的基础语法后再来看,不然会看的很难受
- (6/8): 一直以为是翻译很烂,换了英文版后才发现原来是原文就很烂,很难想象一本语言教科书能够同时实现超过论文程度的诘屈聱牙和垃圾博客的"咬字不清",突然想起类似这种风格的还有C++ Programming Language.

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
由于Go的底层不是和Java,Python一样的引用传值,而是和Cpp,Rust一样的值拷贝,所以还是需要引入指针,**来避免大规模的复制拷贝**.

- 任何类型指针的零值都是**nil**,对应于cpp中的nullptr.
- 非常遗憾的是,Go仍旧没有把解引用符号和指针声明符号区分开,看来设计者真的非常喜欢`*`这个符号

```go
var p = f()

func f() *int {
    v := 1
    return &v
}
```
- 上述代码并不会报错,因为Go底层的垃圾收集器会智能地把依旧要使用的局部变量分配到堆上,不会被回收.这很大程度上解决了C++的指针问题.



## 补充:整合得到的Go特性
- 完全无法理解这本书的组织架构,想必作者也是想到哪写到哪
### const声明
const有两种声明方式:
1. 常规写法:
```go
const Pi float64 = 3.141592653589793
```
2. 分组声明:

```go
const (
    StatusOk      = 200
    StatusTimeout = 408
    StatusError   = 500
)
```
### 字符串
Go中的字符串用双引号括起来,唯一一处会用到单引号的地方是用来表示单个字符,这与cpp的用法一致.

但是,Go中的字符串是不可修改的,不能用类似`s[0]=1`的方式进行修改.

尽管如此,我们可以对字符串进行拼接,在底层实际上是创建了一个更长的字符串,把原来的字符串丢弃掉:

```go
s := "left foot"
t := s
s += ", right foot"
```
## Goroutines
go中的多线程可能是所有语言中最好实现的了,毕竟我们只要在函数前加上两个单词: `go`:
```go
f()    // call f(); wait for it to return
go f() // create a new goroutine that calls f(); don't wait
```
**示例代码**
```go
func main() {
    go spinner(100 * time.Millisecond)
    const n = 45
    fibN := fib(n) // slow
    fmt.Printf("\rFibonacci(%d) = %d\n", n, fibN)
}

func spinner(delay time.Duration) {
    for {
        for _, r := range `-\|/` {
            fmt.Printf("\r%c", r)
            time.Sleep(delay)
        }
    }
}

func fib(x int) int {
    if x < 2 {
        return x
    }
    return fib(x-1) + fib(x-2)
}
```
实际来说,goroutine和多线程有细微的区别,而在主函数返回时,所有的goroutine会被直接打断.
## 总结
暂时弃坑,如果有缘的话会再回来补充.
# 操作系统导论
## 概览
本书围绕操作系统的三个特征展开:
1. 虚拟化(virtualization): 这与程序装载相关
2. 并发(concurrency): 这与程序调度相关
3. 持久性(persistence): 这与硬盘/文件系统相关

## 系统调用
>谁能想到这本书竟然帮我解决了关于系统调用的许多疑问

1. fork(): 复制当前进程创建一个子进程,子进程拥有独立的地址空间,寄存器和程序计数器
   1. fork()系统调用实质上是在执行到当前代码时再新建一个进程,两个进程同时运行,因此,下面这段条件语句能够返回两个值,一个是父进程返回的子进程pid,一个是子进程返回的0
```c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    printf("hello world (pid:%d)\n", (int)getpid());
    int rc = fork();
    if (rc < 0) {
        // fork failed; exit
        fprintf(stderr, "fork failed\n");
        exit(1);
    } else if (rc == 0) {
        // child (new process)
        printf("hello, I am child (pid:%d)\n", (int)getpid());
    } else {
        // parent goes down this path (main)
        printf("hello, I am parent of %d (pid:%d)\n", rc, (int)getpid());
    }
    return 0;
}
```


2. wait(): 让父进程等待子进程执行完毕再继续执行,这显然是I/O,网络请求等让我们深恶痛绝的阻塞的源头.
3. exec(): 因为`fork()`只是创建了一个近乎完全相同的进程,所以我们需要`exec()`来真正的创建一个不同的进程.该调用会从指定的可执行程序中加载代码和静态数据,并覆盖当前子进程的内存区域.

![补充](PixPin_2026-06-04_08-32-14.webp)

>要执行系统调用，程序必须执行特殊的陷阱（trap）指令。该指令同时跳入内核并将特
权级别提升到内核模式。一旦进入内核，系统就可以执行任何需要的特权操作（如果允许），
从而为调用进程执行所需的工作。完成后，操作系统调用一个特殊的从陷阱返回
（return-from-trap）指令，如你期望的那样，该指令返回到发起调用的用户程序中，同时将
特权级别降低，回到用户模式。

## 进程调度
### 进程切换问题
>如果一个进程在 CPU 上运行，这就意味着操作系统没有运行。如果操作系统没有运行，它怎么能做事情？

- 这一问题直接打入了操作系统的核心,非常的透彻.

早期的操作系统由进程来决定何时将CPU的控制权交给内核,内核只能在进程执行时被动地等待.

后来,我们引入了时钟中断(timer interrupt),当中断发生时,当前运行的进程被停止,CPU的控制权会重新交给内核

### 进程调度方法
简单粗暴的几个调度方法有:
1. FIFO: First In First Out,先进先出
2. SJF: Shortest Job First,最短任务优先
3. STCF: Shortest Time-to-Completion First,最短完成时间优先
   1. 从这一算法开始就引入了**抢占**的思想,后来的进程有可能会被内核优先调度

后来,我们将时钟中断和调度联系起来,引入了**轮转**(Round-Robin,RR)算法,每个进程被划分成多个时间片(time slices),时间片长度是时钟中断周期的整数倍,出于公平起见,所有进程在用完一个时间片后就要将CPU让给下一个进程执行.尽管如此,这会大大拖延进程的实际执行完成时间,所以还是不够理想.
### 多级反馈队列
1962年,多级反馈队列(Multi-level Feedback,MLFQ)算法由Corbato提出,大致思想如下:
1. 建立多个不同优先级(priority level)的独立队列,一个进程只能存在于一个队列中
2. 优先级高的队列中的进程优先执行,而同一个队列中的进程采用轮转算法调度
3. 通过观察进程的行为动态调整它的优先级,例如用户交互类进程被划为高优先级,计算密集型进程被划为低优先级

#### 实现MLFQ
我们可以先对该算法进行一个简单的实现:
1. 进程刚开始运行时,放在最高优先级
2. 进程用完一个时间片后,降低其优先级
3. 进程在时间片中主动释放CPU,则优先级不变

显然,这种方法会导致计算密集型进程永远处于饥饿(starvation)状态,也会让恶意程序(如挖矿病毒)伪装成I/O类程序,从而一直保持高优先级.

为了解决恶意程序,我们需要将规则2和规则3修改成一条:
2. 记录一个进程在某一个队列中消耗的总时间,只要它用完了该层中的时间配额,就降低其优先级.

为了让计算密集型进程也能运行一段时间,我们可以这么做:
3. 经过一段时间S,就将所有进程重新加入最高优先级队列

总结一下MLFQ的思想就是:
1. 进程刚开始运行时,放在最高优先级
2. 记录一个进程在某一个队列中消耗的总时间,只要它用完了该层中的时间配额,就降低其优先级.
3. 经过一段时间S,就将所有进程重新加入最高优先级队列

>Windows和MacOS现在仍然在使用MLFQ的变体

### 比例份额调度
比例份额(proportional-share)调度类算法的代表性算法就是彩票调度(lottery scheduling),基本思想如下:
- 每个进程分得一定比例的彩票数,对应了一些彩票编号,接下来反复抽取彩票,每次抽中的彩票编号对应的进程开始运行.
- 父进程可以给子进程分出自己的彩票,再由内核换算出实际的彩票比例
- 不同的进程之间可以转让彩票,同一个进程的彩票数量可以动态变化,这被称为彩票通胀(ticket inflation)

>可以看出来,彩票调度算法具有相当大的随机性,但当执行次数达到一定量级时,每个进程运行的比例也慢慢趋于一个稳定值,所以该类算法适合有大量进程同时执行的情景

尽管设计很巧妙,但该类算法并没有用在主流的操作系统中.
### 多处理器调度
多处理器有以下问题:
1. 缓存一致性: 多个处理器缓存同时访问内存会带来数据上的不一致
2. 数据加锁: 某一处理器在临界区执行时需要给这部分内存加锁,其他处理器此时不能访问该临界区,这会导致性能下降
3. 缓存亲和度: 需要保证一个进程尽可能地在一个CPU上运行,减少切换CPU带来的缓存迁移损耗

文中介绍了两种多处理器调度方法:
1. 单队列多处理器调度(Single Queue Multiprocessor Scheduling，SQMS): 将所有需要调度的进程放入一个单独队列中,每个进程依次被多个处理器调用

![示意图](PixPin_2026-06-07_10-35-53.webp)

- 当然,我们可以对SQMS做一点改进,比如说尽可能让一个进程在同一个处理器上执行

2. 多队列多处理器调度(Multi-Queue Multiprocessor Scheduling，MQMS): 一个处理器控制一个进程队列,尽管这可以解决缓存亲和度的问题,但可能导致一些处理器满负荷运行,而另一些处理器一直空置,这被称为**负载不均**.

- 为了解决这个问题,我们可以不断在处理器队列之中平衡进程的负载
## 虚拟内存
- 由于虚拟地址到物理地址的映射是通过硬件实现的,我们在电脑软件中看到的所有地址都是虚拟地址.

### 简单实现
早期的映射方式是这样实现的:

>每个CPU都有一对基址和界限寄存器（base and bounds register）,由一个**内存管理单元(Memory Management Unit，MMU)**来管理这两个寄存器,base寄存器用来确定进程虚拟地址映射到的实际物理地址的偏移,bound寄存器用来限制该进程能够访问的最大地址.

尽管如此,实际还是要由操作系统来调用这些硬件,所以操作系统是可以直接访问物理内存的,它需要标记当前的空闲物理内存区间,在进程切换时保存和恢复寄存器,在进程终止和创建时分配和回收物理内存
### 分段
上述的映射方式不太灵活,需要将整个进程的地址空间全部装载到内存中,就会有相当大部分的地址被浪费:

![地址空间](PixPin_2026-06-10_10-14-57.webp)

如果我们将进程的地址空间分成多个段(segment),比如说代码内容,堆,栈三个段,每个段都有独立的基址和界限寄存器,分别装载这三个段,就不会占用过多的地址空间了.

为了区分当前进程正在执行的是哪个段,我们使用段寄存器来存储关于段的信息,比如前两位是 00，硬件就知道这是属于代码段的地址.

为了进一步压缩空间,我们可以用硬件将代码段标记为只读,确保多个进程可以共享代码段,却不会更改代码段的内容,只独立的更改自己的栈和堆.

我们还需要建立一个空闲地址列表来追踪所有可用的地址块,每次要用堆分配新的内存时,通过算法匹配到最合适的空闲地址交付给堆,并分割对应大小的地址空间出来.

- 至于用的算法是什么我们就没必要知道了,如书中所说,有几千种备选算法.

尽管如此,这种方法会引入大量的地址碎片,没有足够的连续地址可以装载之后的进程.所以我们需要找到新的解决方法.

### 分页
- 分页: 将地址空间分割成固定长度的块

我们通过页表来管理单个进程中各个虚拟页到物理页的映射:

![转换图](PixPin_2026-06-11_12-36-15.webp)

x86架构中的页表结构如下:
![结构图](PixPin_2026-06-11_12-38-04.webp)
- PFN指的是对应的物理页,其余的符号均为标志位

分页方法有一个非常大的问题,如果每次访问内存时都要通过页表转换,这会引入巨大的内存访问开销.

为了加速内存访问,我们可以使用地址转换旁路缓冲存储器(translation-lookaside buffer,TLB),更好的称呼是地址转换缓存(address-translation cache),每次内存访问时,硬件先检查TLB,如果有对应映射的话就不用再访问页表,从而大幅度提高转换速度.如果TLB未命中,那么就需要硬件去访问页表,并将查找到的映射存储在TLB中.

鉴于内存很宝贵,所以我们需要进一步压缩TLB的大小,将TLB改装成多级的缓存,每一级相对于上一级,只保留真正有效的映射,无效的地址映射则不保留,这样就可以大幅度减小空间占用,但增加了TLB未命中的处理时间,因为需要同时更新多个缓存级:

![三级TLB](PixPin_2026-06-12_08-31-16.webp)

存放在内存中的页数终归是有限的,所以我们需要时不时地将一些页交换到硬盘中,当某个记录在TLB中的页映射被用到时,如果该页不在内存而是被交换到了硬盘,就被称为**页错误(page default)**,需要我们花费更长的时间从硬盘中调用该页.

由于磁盘访问的成本很高,我们需要确定一个比较好的算法来替换不需要的页,以尽可能减少页错误的发生.

- 实际来说,我们使用的是LRU或者类似LRU的算法

>这本书忽略了cache的存在,而是认为CPU可以直接与硬盘交互,而对于实际的操作系统编写来说,这也是正确的,我们无需关注CPU调用硬盘的中途发生了什么
## 并发
### 前置概念
1. 临界区(critical section): 访问共享资源的一段代码,资源通常是一个变量或者数据结构.
2. 竞争(race condition): 多个线程同时进入临界区,导致一些异常的结果
3. 不确定性(indeterminate): 程序中存在一个或多个竞争,导致不确定的输出.

### 锁
我们可以使用锁(lock)来确保只有一个线程在临界区执行,POSIX库中锁被称为互斥量(mutex),用法如下:
```c
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;

Pthread_mutex_lock(&lock);
// wrapper for pthread_mutex_lock()
balance = balance + 1;
Pthread_mutex_unlock(&lock);
```
锁的具体实现是在处理器层面上,经过了一段比较长的演进历史.

最早的锁方案就是在临界区关闭中断:
```c
void lock() {
    DisableInterrupts();
}

void unlock() {
    EnableInterrupts();
}
```
这种方法会让恶意程序一直运行,也无法支持多处理器的情况,效率很低.

>一段时间以来，出于某种原因，大家都热衷于研究不依赖硬件支持的锁机制。
后来这些工作都没有太多意义，因为只需要很少的硬件支持，实现锁就会容易很多（实际在多处理器的早期，就有这些硬件支持）。
而且上面提到的方法无法运行在现代硬件（应为松散内存一致性模型），导致它们更加没有用处。

一个稍微复杂一点的方案叫做test-and-set instruction,也称为原子交换(atomic exchange),该指令是原子地执行的,所以不会被中断所影响:

![工具函数](PixPin_2026-06-14_11-03-47.webp)
![代码](PixPin_2026-06-14_11-02-32.webp)

代码中展示的锁被称为自旋锁(spin lock),会一直自旋等到锁最终可用.这种锁不能保证公平性,在单处理器系统上的开销也相当大.

如果多个线程竞争同一个自旋锁,那么当轮到没能持有锁的线程执行时,由于锁仍然被占用,CPU只会空转一个周期,这样就会大幅度降低线程的执行速度,这需要我们从操作系统的层面来解决这个问题.

一个简单的想法是如果该线程没能持有锁,就直接让出CPU,跳过执行阶段,但这很容易引发饥饿问题.

实际上,不同的操作系统对于这个问题有着不同的解决方案,但大致的思想是这样的: 将没能持有锁的线程/进程从执行队列放入准备队列中,直到锁被释放时才唤醒该线程.
### 条件变量
>假设有一个或多个生产者线程和一个或多个消费者线程。生产者把生成的数据项放入缓冲区；消费者从缓冲区取走数据项，以某种方式消费。这就是生产者/消费者问题.

为了解决这一问题,文中提出可以引入条件变量来让生产者与消费者的调用互不冲突.


但我的意见是,你把生产者和消费者放到两个队列中不就可以了吗?很难理解这种脱裤子放屁的事情,所以直接略过吧.

### 信号量
信号量(semaphore)可以作为锁也可以作为条件变量,是一种比较复杂的并发实现方式.

在POSIX标准中,信号量是一个有整数值的对象,通过`sem_wait()`和`sem_post()`函数来操作它.

```c
#include <semaphore.h>
sem_t s;
sem_init(&s, 0, 1);
```
>其中申明了一个信号量 s，通过第三个参数，将它的值初始化为 1。sem_init()的第二个参数，在我们看到的所有例子中都设置为 0，表示信号量是在同一进程的多个线程共享的。

**两个函数的定义**
```c
int sem_wait(sem_t *s) {
decrement the value of semaphore s by one
wait if value of semaphore s is negative
}
int sem_post(sem_t *s) {
increment the value of semaphore s by one
if there are one or more threads waiting, wake one
}
```


### 死
死锁（deadlock）是一种在许多复杂并发系统中出现的经典问题,死锁的产生需要如下 4 个条件:
- 互斥：线程对于需要的资源进行互斥的访问（例如一个线程抢到锁）。
- 持有并等待：线程持有了资源（例如已将持有的锁），同时又在等待其他资源（例如，需要获得的锁）。
- 非抢占：线程获得的资源（例如锁），不能被抢占。
- 循环等待：线程之间存在一个环路，环路上每个线程都额外持有一个资源，而这个资源又是下一个线程要申请的。

因此,解决死锁问题可以从这四个角度下手,从而预防或者避免死锁.
## 持久性
### I/O设备
>有趣的是，因为所有需要插入系统的设备都需要安装对应的驱动程序，所以久而久之，驱动程序的代码在整个内核代码中的占比越来越大。查看 Linux 内核代码会发现，超过 70%的代码都是各种驱动程序。在 Windows 系统中，这样的比例同样很高。因此，如果有人跟你说操作系统包含上百万行代码，实际的意思是包含上百万行驱动程序代码。


### 磁盘驱动器
- 这一部分讲的是磁盘类的机械硬盘,可以适当的了解一下

### RAID
#### 前置概念
廉价冗余磁盘阵列(Redundant Array of Inexpensive Disks,RAID)使用多个磁盘构建一个更大,更快,更可靠的存储系统.

#### RAID 0
RAID 0没有冗余的磁盘,它以轮转方式将数据块分布在磁盘上,从而保证可以并行读取数据.

![RAID0](PixPin_2026-06-21_11-01-00.webp)

这个方案无法缓解任何磁盘故障问题.

#### RAID 1
RAID 1仅仅是在RAID的基础上,将每个数据块都存储了多个备份而已,常见的备份数量为1:

![RAID1](PixPin_2026-06-21_11-05-20.webp)
#### RAID 4
RAID 4用一个专门的磁盘来存储其他磁盘中数据块的奇偶校验块,例如图中的P1具有从4,5,6,7计算出的冗余信息.
![RAID4](PixPin_2026-06-21_11-09-48.webp)

由于只有一个磁盘负责存储冗余数据,当多行的数据同时更新时,冗余磁盘无法并行处理数据,会降低RAID的性能,这被称为**小写入问题**:
![实例](PixPin_2026-06-21_11-17-40.webp)

#### RAID 5
RAID 5在RAID 4的基础上,将奇偶校验块跨驱动器旋转,从而解决小写入问题:
![RAID5](PixPin_2026-06-21_11-18-12.webp)

### 文件系统
>文件系统是一个纯软件的实现,不需要硬件提供额外的支持,我们需要做的就是使用汇编语言创建open,close等系统调用的接口,使用特殊的数据结构来存储文件和目录,按照精心设计的硬盘调度方式来存放文件系统

#### 简单的文件系统
我们可以将磁盘简单地分成以下几个部分:
1. 数据块(D): 存放真正的文件数据
2. inode table(I): 存放文件的元数据
3. inode bitmap(i): 管理inode table
4. data bitmap(d): 管理数据块
5. superblock(S): 记录inode和数据块的个数和其他有用的全局信息.

![结构图](PixPin_2026-06-18_08-20-14.webp)

几乎所有的文件系统都有类似inode的结构,inode是index node的缩写,因为这些节点早期使用数组存储的,通过index访问特定的节点.

例如ext2的inode内容如下:
![结构图](PixPin_2026-06-18_08-26-09.webp)

如果要支持更大的文件,那么我们就可以在inode中存放指向下一级索引存储块的指针,以4KB为分页的话,那就有1024个指针,文件大小可以增长到1024x4KB,也就是4MB的大小,要想继续增加的话就多来几次指针跳转就行了.

>设计 inode 有另一个更简单的方法，即使用链表（linked list）。这样，在一个 inode 中，不是有多个指针，只需要一个，指向文件的第一个块。要处理较大的文件，就在该数据块的末尾添加另一个指针等，这样就可以支持大文件。
>
>这样的表听起来很熟悉吗？我们描述的是所谓的文件分配表（File Allocation Table，FAT）—文件系统的基本结构。是的，在 NTFS [C94]之前，这款经典的旧 Windows 文件系统基于简单的基于链接的分配方案

文件系统将目录视为特殊类型的文件,目录中可以存放一个inode列表,标识在目录中存放的文件.

>如此一来,我们就可以随意拖拽文件了,因为目录实际上存放的只是具体数据块的链接而已,这也是为什么在同一个磁盘分区中移动文件非常快的原因.

文件系统通过**缓存**来存储临时的块数据,从而避免大量的重复存取操作引发的灾难性影响,然而,数据库这种应用程序不适合使用缓存,需要所有的更改能够立刻执行,早期的数据库会绕过文件系统使用原始的磁盘接口,而现在,而现在由于文件系统的升级,可以直接选择无缓存的系统调用了,所以就不需要额外搞动作了.

#### 更快的文件系统
老式的UNIX文件系统比上述的简单文件系统还要简单,只有三个模块:
![模块图](PixPin_2026-06-18_08-52-35.webp)

由于数据块由inode进行分配,而inode并不了解具体的磁盘情况,可能会让属于同一个文件的数据块散落到各个角落,从而引入非常高的I/O调用成本,大大降低了文件存取的性能.

>伯克利的一个小组决定建立一个更好、更快的文件系统，他们聪明地称之为快速文件系统（Fast File System，FFS）。

FFS 将磁盘划分为一些分组，称为柱面组（cylinder group，而一些现代文件系统，如 Linux ext2 和 ext3，就称它们为块组，即 block group）

因此,FFS可以在每一个组中都分配文件和目录,一个组的结构是这样的,这已经与我们之前的简单文件系统基本相同了:

![结构图](PixPin_2026-06-18_08-56-51.webp)

对于文件，FFS 做两件事。首先，它确保（在一般情况下）将文件的数据块分配到与其inode 相同的组中，从而防止 inode 和数据之间的长时间寻道（如在老文件系统中）。其次，它将位于同一目录中的所有文件，放在它们所在目录的柱面组中

>FFS 也引入了一些其他创新。特别是，设计人员非常担心容纳小文件。事实证明，当时许多文件大小为 2KB 左右，使用 4KB 块虽然有利于传输数据，但空间效率却不太好。因此，在典型的文件系统上，这种内部碎片（internal fragmentation）可能导致大约一半的磁盘浪费。

>FFS 设计人员采用很简单的解决方案解决了这个问题。他们决定引入子块（sub-block），这些子块有 512 字节，文件系统可以将它们分配给文件。因此，如果你创建了一个小文件（比如大小为 1KB），它将占用两个子块，因此不会浪费整个 4KB 块

#### 更稳定的文件系统
每次在原有的文件上新加内容时,我们需要更新三个结构: 文件对应的inode,新数据块对应的bitmap,磁盘上的新数据块内容.如果在更新过程中系统崩溃了,我们有可能只完成了其中的一两项更新,导致系统内部不再保持**一致性**.

早期的文件系统使用**文件系统检查程序(file system checker, fsck)**来解决这个问题,它通过扫描**整个磁盘**和检查各种有可能出错的地方来发现潜在的不一致问题,这种做法非常低效和费时.

后来,我们提出了**日志记录(journaling)**这一从数据库管理系统种借鉴来的方法,在执行事务前先将要执行的操作记入日志,这样就可以在系统恢复时检查哪些操作没能成功执行了,如今的Linux ext3,ext4和Windows的NTFS都采用了这种方法.

假如我们直接往日志中记录我们要提交的所有更改,如果在记录过程中发生了故障,这又会导致系统的不一致,所以我们需要将日志记录分成两步,再加上更改时的记录,总共就是三步了:
1. 日志写入: 写入这次事务的时间,涉及的块等信息
2. 日志提交: 写入这次事务要执行的具体操作
3. 事务执行: 执行最终的磁盘写入,每次写入时提交一个报告或者加上一个检查点

如果崩溃发生在第二步完成之前,我们直接放弃这次更新即可,如果在第二步完成之后,那么就可以从日志中恢复之前的更改了.

## 总结
整体来说是相当精彩的,每个部分都能谈及对应技术的历史背景和发展历程,让人对操作系统有了一个非常好的全局视野,可以说是程序员的必读书籍了.

# 深入浅出密码学
- (6/6): 强烈推荐,如果早点看到这本书就可以少走很多弯路了
## 概述
>本书不会涉及令人害怕的数学公式。本书的目的是揭开密码学的
神秘面纱，介绍当今常用的密码学技术，并给出这些技术在我们身边
的应用案例。本书适合那些对密码学怀有好奇心的人、有强烈求知欲
的工程师、富有冒险精神的软件开发人员和兴趣广泛的研究人员。
## 哈希函数
哈希函数有以下特性:
1. 任意长度的输入都会得到相同的输出长度
2. 同一个输入可以得到相同的输出
3. 实践中无法根据输出得到输入,这被称为**Pre-image Resistance**
4. 根据一个输入无法找到另一个输入得到相同的输出,这被称为**Second Pre-image Resistance**
5. 实践中无法找到两个不同的输入能够产生相同的输出,这被称为**Collision Resistance**

### 绝对安全的哈希函数: SHA系列
SHA-2算法族于2001年标准化,有4个子类,分别是SHA-224、SHA-256、SHA-384 和 SHA-512,它们分别产生 224、256、384 和 512 比特的输出.

SHA-3算法族于2015年标准化,同样有4个子类,分别是SHA-3-224、SHA-3-256、SHA-3-384 和 SHA-3-512.
## 消息认证码(Message Authentication Code,MAC)
- 讲的确实很好,无论有无这方面的基础都能大有收获,一本密码书竟然能够比专门讲网站设计的书还能谈的更深,不过大部分知识我都已经了解了,就不摘抄了.

1. HMAC: 将密钥与SHA-2系列哈希函数结合使用,这是网站验证中最常用的加密方法

![示意图](PixPin_2026-06-06_10-53-57.webp)
2. KMAC: 单纯使用SHA-3系列哈希函数,而不依靠HMAC辅助:

![示意图](PixPin_2026-06-06_10-54-54.webp)

### 长度扩展攻击
之所以不能单纯使用SHA-2系列的哈希函数,就是因为这类哈希函数有可能遭受**长度扩展攻击**,不过书上这部分讲的不是很好,好在有Gemini帮助我:
```md
想象一下，哈希函数就像是一个**自动打包机**。你塞入一堆文件，它经过一系列固定的揉搓动作，最终吐出一个大小固定的**神秘代码**（哈希值）。

长度扩展攻击，简单来说，就是黑客**在不知道你塞了什么秘密文件的前提下**，顺着打包机未完成的动作，**直接在后面拼接自己的小纸条**，并生成一个完全合法的全新神秘代码。

为了让初学者彻底明白，我们可以用一个“接力跑”的故事来解构它。

---

## 一、 核心漏洞：哈希函数的“接力跑”机制

像 MD5、SHA-256 这样的经典哈希函数，在处理很长的信息时，并不是一气呵成的，而是把信息切成一节一节的（比如每节 64 字节），像接力赛一样**分段处理**。

1. **第一棒**：吃进第一段信息，结合初始状态，算出一个“中间结果”。
2. **第二棒**：把第一棒的“中间结果”作为起点，吃进第二段信息，算出下一个“中间结果”。
3. **最后一棒**：吃完最后一段信息，算出的**最终结果，就是我们看到的哈希值**。

**漏洞就在这里**：
对于哈希函数来说，**“最终的哈希值”本质上就是“最后一棒交接时的动作状态”**。哈希函数本身没有记忆，它不知道前面跑了多少棒，它只认当前手里的接力棒状态。

---

## 二、 经典故事：假账本攻击

假设有一家餐厅，老板（服务器）和前台经理（客户端）之间有一个秘密规则：为了防止账本被别人篡改，经理每次传账本时，必须在账本最前面加上老板才知道的**秘密口令（Key）**，然后把它们整体打包算一个哈希值（也就是签名）。

* **秘密口令**：`TopSecret`（黑客不知道）
* **正常账单**：`apple=1`
* **传给老板的组合**：`TopSecret + apple=1` $\rightarrow$ 算出哈希值：`6a2f...99`

黑客（小明）在网络中截获了这段信息。他看到了账单 `apple=1` 和哈希值 `6a2f...99`。小明想在后面偷偷加上一笔：`&banana=5`。

### 黑客的“接力”表演：

小明不需要知道秘密口令 `TopSecret` 是什么，他只需要做两件事：

1. **把哈希值当成“接力棒”**：小明把截获的哈希值 `6a2f...99` 装进自己的哈希计算软件里，作为“当前处于第二棒”的初始状态。
2. **继续跑下一棒**：小明在软件里输入自己想加的内容 `&banana=5`，让软件顺着刚才的状态继续往下算。软件吐出了一个新的哈希值：`9b8c...11`。

最后，小明把修改后的账单（`apple=1 + 自动生成的填充数据 + &banana=5`）和这个新的哈希值 `9b8c...11` 一起发给老板。

### 老板被骗了：

老板收到后，拿出秘密口令 `TopSecret` 拼在账单前面，重新放入打包机计算。因为打包机的物理运行轨迹和黑客在电脑里模拟的接力过程**完全一模一样**，老板算出来的哈希值也一定是 `9b8c...11`。

老板一看：“我算出来的和传过来的一致，账单没有被别人篡改过！” 于是，黑客成功把 `banana=5` 混进了系统。

---

## 三、 总结：为什么它叫“长度扩展”？

* **长度**：黑客虽然不知道秘密口令的内容，但需要猜出秘密口令的**长度**（比如是 9 个字母还是 10 个字母），因为这决定了第一棒跑步的起点位置和对齐补齐的空格数。
* **扩展**：只要知道了长度，黑客就能在原有信息后面，无限期地**扩展**追加自己想要的任何恶意内容。

### 怎么防范它？

这个漏洞是 MD5、SHA-256 这一代哈希函数**天生的物理结构缺陷**。
现代工程师防范它很简单：不再直接使用 `哈希(口令 + 消息)` 这种粗暴的组合，而是改用 **HMAC** 算法。HMAC 相当于在内部跑完接力赛后，在外面又用口令套了一个坚固的安全箱，黑客就再也无法在后面接着跑了。
```
## 对称加密
### 前置概念
对称加密算法的输入为**密钥(secret key)和明文(plaintext)**,输出为**密文（Ciphertext）**.

解密算法的输入为密文和同一个密钥,输出为明文.
### AES算法
>AES是应用最为广泛的加密算法,因此主流处理器都内置了对AES的支持,能够以相当快的速度完成加密和解密.

AES算法加密的输入为一个变长密钥(由用户选择)和一个长度固定为128比特(16字节)的明文,输出一个128比特的密文,解密时输入同一个密钥和密文即可得到明文.

加密时,AES将明文转换成4x4的状态矩阵:

![示意图](PixPin_2026-06-08_10-55-34.webp)

然后,对该矩阵进行多轮加密,每次加密使用的密钥都是由用户设定的密钥随机生成的.

如果要加密一个非常长(远超过超过128比特)的消息,一个简单的方法就是把消息分成多个16字节的块,如果最后一块小于16字节,则追加字节填充到16字节,然后再逐块加密,这被称为**电码本(Electronic Codebook,ECB)模式**.

很显然,如果明文中有多个相同的16字节块,会得到多个完全相同的密文,这有很大的安全隐患.因此,我们可以采用**密码块链接（Cipher Block Chaining，CBC）模式**,该模式会根据明文(*或者随机指定*)生成一个额外的初始向量IV,用于和明文进行迭代的异或操作,从而将明文随机化,相同的明文也会得到完全不同的密文:

![示意图](PixPin_2026-06-08_11-09-51.webp)

解密时,我们需要加密方以明文方式提供IV:

![示意图](PixPin_2026-06-08_11-11-52.webp).

- 上述加密算法被称为AES-CBC

很显然,我们需要对密文和IV进行校验,防止被攻击者篡改,所以我们可以用HMAC算法来给它们加上一个认证标签,这就是AES-CBC-HMAC算法.
### 新型加密算法(过)
## 非对称加密

### 密钥交换
尽管对称加密可以说是万无一失的,但是它需要我们在一开始就告知对方自己的密钥,而这个密钥如果不经过加密传输的话,那么攻击者就极易窃取到这个密钥,从而让对称加密失效.

因此,**密钥交换类算法**诞生了,基本原理如下: 通信双方各自持有一对公钥和私钥,并使用对方的公钥来组合自己的私钥生成共享密钥,**只要私钥得到了保护,那么攻击者就无法获知最终的密钥.**
#### DH密钥交换
- 该算法由Whitfield Diffie 和 Martin E.Hellman 于1976年提出

![算法原理](PixPin_2026-06-10_10-41-35.webp)

1. 所有参与者协商使用一个大素数p和一个生成元g作为公共参数。
2. 每个参与者随机产生一个数x作为私钥。
3. 每个参与者通过计算g^x = h mod p生成自身的公钥h。

如何将上述的所有数学知识应用在 DH 密钥交换算法中呢？可以想象下面的场景：

* Alice 有一个私钥 $a$ 及其对应的公钥 $A = g^a \bmod p$；
* Bob 有一个私钥 $b$ 及其对应的公钥 $B = g^b \bmod p$。

Alice 可以根据 Bob 的公钥和自身的私钥计算双方的共享密钥 $B^a \bmod p$，Bob 也可以进行类似的操作，计算 $A^b \bmod p$。显而易见，双方最终会得到相同的结果：

$$B^a = g^{ba} = g^{ab} = A^b \bmod p$$

该算法需要选择的素数足够大,实践中为2048位,由于实在是太长了,所以不久之后,基于椭圆曲线的 DH 密钥交换算法(Elliptic Curve Cryptography，ECC)诞生了
#### ECDH密钥交换
现在我们构造一个椭圆曲线群，就可以在这个群上实现 DH 密钥交换算法。产生 ECDH 算法密钥对的方法如下。
1. 所有参与者协商一个椭圆曲线方程、一个有限域（最有可能是一个素数）和一个群生成元G（在椭圆曲线密码中通常称为基点）。
2. 每个参与者生成一个随机数x作为自身的私钥。
3. 参与者各自生成自己的公钥[ x ]G。

- [ x ]G表示x个G相加


● Alice 拥有私钥a以及公钥[a]G。
● Bob 拥有私钥b以及公钥[b]G。

Alice 可以根据 Bob 的公钥以及自身的私钥a计算共享密钥[a]B。Bob也可以使用类似的计算得到[b]A。很明显，双方最终计算出相同的最终密码：

![结果](PixPin_2026-06-10_10-59-19.webp)

![选择的椭圆曲线](PixPin_2026-06-10_11-01-44.webp)

因为有着如此可怕的参数,即便攻击者知道了使用的是哪条椭圆曲线,用的是哪个生成元,同时还知道了双方的公钥,这也无济于事,只要双方的私钥足够随机,就无法暴力破解得到最终的密码

如今,ECDH算法取代了DH算法,因为它的密钥更短,更为安全,更好实现.
## 混合加密
实际应用中,我们通常是先用**非对称加密**来进行沟通得到共享密钥,转换后得到**共同的对称密钥**,之后再使用对称密钥来加密通信.这一过程被称为**混合加密**.
### RSA算法
如文中所说,标准的RSA算法是不够安全的,所以可以直接忽略掉.
### ECIES算法
基于椭圆曲线的混合加密标准（Elliptic Curve Integrated Encryption Scheme,ECIES）是应用最为广泛的混合加密算法,过程如下:
1. 双方使用ECDH生成临时共享密钥
2. 将共享密钥作为对称密钥,加密消息后发送给对方.

但如之前所说,我们最好对共享密钥做一些处理,而不要直接拿来作为对称密钥,这本书在后面会谈到这个问题.

## 数字签名
签名用于将特定网站/实体与它所提供的公钥绑定,这一过程是由权威的签名机构实现的,当用户访问网站时,浏览器会自动用公钥验证该网站对应的签名,从而确认该网站是否合法.

- 具体的签名算法由于原理过于复杂,就不深入了
## 随机性和秘密性
我们在计算机中实际使用的随机数都是伪随机的,有的是使用内置的随机化种子,有的是使用操作系统提供的随机数生成接口(内部是通过计算诸如启动顺序,环境噪声等极度随机的变量实现的)

**密钥派生函数(Key Derivation Function，KDF)**用于从输入中得到一个均匀的随机输出密钥,刚好可以用来处理我们之前的ECDH密钥,用来作为新的对称密钥.
## 安全传输
### SSL与TLS协议
>1990年代,SSL(Secure Socket Layer)协议诞生,与HTTP协议结合使用,扩展为HTTPS协议,在3.0版本后,SSL更名为TLS(Transport Layer Security)协议,并于1999年正式发布.

TLS协议可以分成以下两个阶段:
- 握手阶段: 通信双方协商并创建一个安全通信连接
- 安全通信阶段: 加密通信

#### 握手阶段
握手阶段有四项内容:
* **协商：** TLS 协议是高度可配置的，客户端和服务器都使用协商好的 SSL 和 TLS 版本以及加密算法作为通信过程的配置参数。握手的协商阶段旨在找到客户端和服务器之间可选配置参数的共同点，以确保连接的双方是对等的。
* **密钥交换：** 握手阶段的核心是两个参与者之间的密钥交换。使用何种密钥交换算法是客户端与服务器协商过程中要确定的事项之一。
* **认证：** 正如我们在第 5 章密钥交换了解到的那样，中间人攻击者可以轻易模拟密钥交换过程中的任何一方，因此，密钥交换必须经过认证。例如，浏览器必须能够确保自身是在与 google.com 通信，而非与互联网服务提供商（Internet Service Provider, ISP）通信。
* **会话恢复：** 由于浏览器经常重复连接到同一个网站，如果每次都进行密钥交换可能产生高昂的计算代价，并且会降低用户体验，因此，TLS 协议中集成了无须重复密钥交换即可快速跟踪安全会话的机制。
  * 该阶段不是必需的


##### 协商
客户端向服务器发送第一个请求(称为ClientHello),包含客户端支持的TLS协议版本,支持的密码算法和更多的信息,密码算法包括以下部分:
1. 一种或多种密钥交换算法: ECDH算法的各种变体,最新版本的TLS中移除了对RSA算法的支持
2. 两种(握手双方都需要选择一种签名算法)或多种数字签名算法
3. HMAC和HKDF所需的哈希函数
4. 一个或多个对称加密算法

##### 密钥交换
TLS 1.3中的密钥交换是这样的:
1. 客户端使用 TLS 1.3 的协议，向服务器发送 ClientHello 消息以说明自己支持 X25519 和 X448 密钥交换算法，并附加客户端自身的 X25519 算法公钥。
2. 服务器并不支持 X25519 算法，只能支持 X448 算法。因此，服务器向客户端发送 HelloRetryRequest 消息，告诉客户端自己只能支持 X448 密钥交换算法。
3. 客户端重新发送 ClientHello 消息，将自己的 X448 算法公钥告知服务器。
4. 服务器发送ServerHello消息,并告知自己选定的密码套件,并附上自己的X448公钥

后续的对话都会使用选定的密码套件进行加密.

>对于每次会话,双方都会生成新的密钥对,并在交换密钥后立即将其删除

##### 认证
>在 Web 系统上，TLS 协议中的认证通常是单向的。例如，只有浏览器才能验证 google.com 是否确实是 google.com，但 google.com 不会验证浏览器的身份（或者说至少这个步骤不会作为 TLS 协议的一部分）。

首先，浏览器必须信任一组证书认证机构（Certification Authority，CA）的根公钥。通常，浏览器会使用一组硬编码的公钥或由操作系统提供的可信公钥。

其次，想要使用 HTTPS 的网站必须要从上述可信的 CA 中获取证书（即对用于验证签名的公钥本身进行签名）。为此，网站拥有者（或者网站管理员）必须向 CA 证明他们拥有一个特定的域。

![认证流程](PixPin_2026-06-14_11-50-51.webp)

服务器为了向浏览器证明自己确实是 google.com，需要在 TLS 协议握手阶段向浏览器发送一个证书链。这个证书链包括如下内容。

* 服务器自己的叶子证书，其中包含网站的域名（例如 google.com）、网站的长期公钥以及 CA 对这些内容的签名。
* 一条 CA 证书链，该 CA 证书链包含的 CA 证书从为 google.com 签名的 CA 证书开始，到最后一个由根 CA 证书签名的 CA 证书结束。

### 其他安全传输协议
- SSH(Secure Shell): 为不同主机上的远程终端提供安全连接
-  Wi-Fi 保护接入（Wi-Fi Protected Access，WPA）协议
 
所有这些协议都实现了类似 TLS 协议的握手和安全通信的流程，并在 TLS 协议的基础之上加入个性化的设计

## 端到端加密
![信任链](PixPin_2026-06-15_10-55-32.webp)

## 总结
第一部分的每一章都非常有看头,讲的非常透彻,第二部分的安全传输讲的最好,其他的随便看看就行.

# 算法导论
## 理论部分
### 算法复杂度计算
![示意图](PixPin_2026-06-09_14-14-12.webp)
- Θ表示确界,f(n)主要项的次数必须与g(n)相同
- O表示上界,f(n)主要项的次数小于或等于g(n)
- Ω表示下界,f(n)主要项的次数大于或等于g(n)


### 主定理计算分治递归式
![递归方程](PixPin_2026-06-09_14-11-15.webp)


**定理 4.1（主定理）** 令 $a \ge 1$ 和 $b > 1$ 是常数，$f(n)$ 是一个函数，$T(n)$ 是定义在非负整数上的递归式：

$$T(n) = aT(n/b) + f(n)$$

其中我们将 $n/b$ 解释为 $\lfloor n/b \rfloor$ 或 $\lceil n/b \rceil$。那么 $T(n)$ 有如下渐近界：

1. 若对某个常数 $\epsilon > 0$ 有 $f(n) = O(n^{\log_b a - \epsilon})$，则 $T(n) = \Theta(n^{\log_b a})$。
2. 若 $f(n) = \Theta(n^{\log_b a})$，则 $T(n) = \Theta(n^{\log_b a} \lg n)$。
3. 若对某个常数 $\epsilon > 0$ 有 $f(n) = \Omega(n^{\log_b a + \epsilon})$，且对某个常数 $c < 1$ 和所有足够大的 $n$ 有 $a f(n/b) \le c f(n)$，则 $T(n) = \Theta(f(n))$。
## 算法部分
### 分治
- 4.1的论述非常不错,浅显易懂的说明了最大子数组的写法

对于最大子数组和问题,我们可以用两种分治想法来看:
1. 维护一个前缀和数组,遍历所有的前缀和来找到最大和,时间复杂度是O(n^2)
2. 当前最大和只有两种情况,前面的所有元素加上当前的元素和只使用当前元素,从下标1开始遍历到最后一个元素即可,时间复杂度为O(n).

普通的矩阵乘法计算的时间复杂度是O(n^3):

![伪代码](PixPin_2026-06-10_13-15-26.webp)
而Strassen算法能够把时间复杂度压缩到O(n^lg7):

$$T(n) = \begin{cases} \Theta(1) & \text{若 } n = 1 \\ 7T(n/2) + \Theta(n^2) & \text{若 } n > 1 \end{cases}$$

### 排序算法(过)
这本书关于排序的几章都比较宽泛,没什么看头
### 动态规划
#### LCS问题
- 最长公共子序列问题(longest common subsequence): 给定两个序列X和Y,找到X和Y中长度最长的公共子序列(可以不连续).

定理: (LCS 的最优子结构) 令 $X = \langle x_1, x_2, \cdots, x_m \rangle$ 和 $Y = \langle y_1, y_2, \cdots, y_n \rangle$ 为两个序列, $Z = \langle z_1, z_2, \cdots, z_k \rangle$ 为 $X$ 和 $Y$ 的任意 LCS。

1. 如果 $x_m = y_n$, 则 $z_k = x_m = y_n$ 且 $Z_{k-1}$ 是 $X_{m-1}$ 和 $Y_{n-1}$ 的一个 LCS。
2. 如果 $x_m \neq y_n$, 那么 $z_k \neq x_m$ 意味着 $Z$ 是 $X_{m-1}$ 和 $Y$ 的一个 LCS。
3. 如果 $x_m \neq y_n$, 那么 $z_k \neq y_n$ 意味着 $Z$ 是 $X$ 和 $Y_{n-1}$ 的一个 LCS。


上述定理意味着，在求 $X = \langle x_1, x_2, \cdots, x_m \rangle$ 和 $Y = \langle y_1, y_2, \cdots, y_n \rangle$ 的一个 LCS 时，我们需要求解一个或两个子问题。如果 $x_m = y_n$，我们应该求解 $X_{m-1}$ 和 $Y_{n-1}$ 的一个 LCS。将 $x_m = y_n$ 追加到这个 LCS 的末尾，就得到 $X$ 和 $Y$ 的一个 LCS。如果 $x_m \neq y_n$，我们必须求解两个子问题：求 $X_{m-1}$ 和 $Y$ 的一个 LCS 与 $X$ 和 $Y_{n-1}$ 的一个 LCS。两个 LCS 较长者即为 $X$ 和 $Y$ 的一个 LCS。由于这些情况覆盖了所有可能性，因此我们知道必然有一个子问题的最优解出现在 $X$ 和 $Y$ 的 LCS 中。

### 贪心
>自顶向下,反复选择当前最优的选择,然后得出答案,这与动态规划很类似,实际上,每个贪心算法都可以用更繁琐的动态规划算法来表示.

### 图算法
#### 最小生成树
- Kruskal: 将边按权重从低到高排序,只要不形成环路就按顺序将边加入
- Prim: 从任意节点开始,每次选择当前可见范围内的最短边,只要不形成环路即可

#### 单源最短路径
Bellman-Ford与Dijkstra.
#### 所有节点对的最短路径
Warshall算法
### 数论
#### 欧几里得算法
- 最大公约数(greatest common divisor，gcd): 能够整除多个非零整数的最大正整数

欧几里得算法(辗转相除法)可以用来递归计算两个非零整数的最大公约数:

```c
gcd(a,b) = gcd(b,a mod b);
```
实战来说的话只要这么写就行了:
```cpp
int euclid(a,b){
    if(b==0) return a;
    return euclid(b,a mod b);
}
```
写成while循环:
```cpp
while(b>0){
    int temp = a mod b;
    a = b,b = temp;
}
```
### np完全问题
- P问题(Polynomial): 可以在多项式时间内解决的问题
- NP问题(Nondeterministic Polynomial time): 可以在多项式时间内验证解答的问题
- NP完全问题(NP-Complete,NPC): 所有NP类问题都可以在多项式时间内转换成NPC问题,如果能够求解NPC,那么就可以求解所有的NP问题.

>至今为止没有人能够发现任何一个NPC问题的解决方案


## 数据结构
### 二叉搜索树
- 书上讲的非常学术化,同样没什么看头

二叉搜索树中,所有子树的左节点都小于根节点,右节点都大于根节点.
### 红黑树
红黑树是一种平衡的二叉搜索树,每个节点有五个属性,color,key,left,right,p,满足以下性质:
1. 每个节点要么是红色要么是黑色
2. 根节点是黑色的
3. 每个空节点是黑色的
4. 如果一个节点是红色的,那么两个子节点都是黑色的
5. 每个节点到达所有后代空节点的路径上,都有相同数量的黑色节点
### B树(过)
讲的不是很详细,不如看B站视频

## 总结
这本书的内容很丰富,奈何没有几个地方讲的比较深入,整体来说,更适合作为一本参考书,看看有哪些知识点是自己不会的,再专门找资料去学习就行了.


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
# Architecting ASP.NET Core Applications&&# Mastering ASP.NET Core 10
- 两本书翻了好几章全都讲的很烂,确实不应该随便找别人没推荐过的书来看...
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
# Build AI-Enhanced Web Apps
- 拉完了
# Kubernetes Up and Running
- 不如in action详细,不推荐阅读
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
### Describing API responses
```yaml
responses:
  200:
    description: A human description
    content:
      application/json:
        schema:
          type: object
          items:
            type: object
            properties:
              # ...

```
- content: 必须声明一个Media types (aka MIME),常用的有`text/html`,`image/png`,`application/json`等类型.
- properties: 存放所有的查询参数

### 创建资源
部分http方法(如POST,PATCH)可以声明请求体:
```yaml
paths:
  /reviews:
    get: #...
    post:
      description: Create a new Review
      requestBody:
        content:
          application/json:
            schema:
              type: object
              properties:
                message:
                  type: string
                  example: An awesome time for the whole family.
                rating:
                  type: integer
                  minimum: 1
                  maximum: 5
                  example: 5

```

### 身份验证
```yaml
paths:
  /reviews:
    post:
      #...
      security:
        - MyUserToken: []
        # 列表表示该scheme的作用域,不适用于apikey类型,所以留空.
#...
components:
  securitySchemes:
    MyUserToken:
      type: apiKey
      in: header
      name: Authorization

```
![图示](PixPin_2026-07-13_09-25-52.webp)
## 设计
### ch9
这一章很有意思,详细描述了设计数据库的完整过程.
## 总结
这本书还是很不错的,完美体现了OpenAPI在前后端开发中的必要性.
# Powershell Cookbook
- 这本书是21年出版的,所以用的还是PowerShell Core,不推荐,不过拿来学习基本命令还可以
## 前言
Windows早期的shell用的是`cmd.exe`,于93年发布,到了02年,微软设立了一个内部项目Monad,是06年发布的Windows Powershell的前身,在16年,随着.NET Framework变成.NET Core,微软发布了开源跨平台的Powershell Core来取代原先的Windows Powershell,再后来,随着.NET Core更名为`.NET`,Powershell Core于20年也变成了Powershell,在这几年一直停留在7.x版本.


- 这也可以看得出来,微软的底层架构到了现在也没有完全成熟.

而操作系统默认安装的甚至不是Powershell Core,而是Windows Powershell:

```bash
$PSVersionTable

Name                           Value
----                           -----
PSVersion                      5.1.26100.8655
```
而更为古老的cmd也一直留在Windows中,没有被删除.
## 语法
### 基本语法
要在包含空格的命令名称中运行命令，请将其文件名用单引号（'）括起来，并在命令前加上和号（&）:
```bash
& 'C:\Program Files\Program\Program.exe' arguments
```
要在当前目录下运行一个命令，请在文件名前加上.\:
```bash
.\Program.exe arguments
```
- 如果PowerShell能在系统路径中找到某个脚本或工具，则无需显式指定其位置

#### cmdlet命令
Cmdlet 是PowerShell中使用的轻量型单一功能命令,采用“动词-名词”（Verb-Noun）的结构命名，中间以短划线分隔（例如 Get-Process）.

![例子](PixPin_2026-07-13_13-49-10.webp)
### 管道
- ps中最强的命令

在 PowerShell 中，我们使用管道符（|）来分隔管线的每个阶段:
```bash
Get-Process | Where-Object WorkingSet -gt 500kb | Sort-Object - Descending Name
```
- Where-Object是一个非常方便的从列表/终端输出中筛选符合要求的变量的工具,更为简短的别名为`where`和`?`


&& and ||同样也属于管道运算符,可用于输出调试信息:

```bash
PS > Invoke-Command localhost { "Some output" } && "Connection successful!"
Some command output
Connection successful!
```
## 脚本
cmd时代的脚本名字为`.bat`,对应的英文为batch,通常称为批处理文件,而powershell的脚本名字为`.ps1`
## 总结
都说是Cookbook了,自然没有一丁点的可读性,真要学的时候再来翻吧.
# Pro git
- [官网](https://git-scm.com/book/zh/v2)
  - 非常好的教程,比所有的二手资料都齐全.

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
- `git branch`用于确认有哪些分支,`git branch 分支名`用于创建分支,这只不过是创建了一个新的git指针,并不需要复制文件的内容.
- `git checkout`用于切换分支,这是通过git指针的移动实现的.

>在19年,Git引入了git switch和git restore命令,将功能过于繁杂的git checkout拆分成了两个命令.


`git checkout -b 分支名`是两条命令的结合,可以快速创建一个新分支.等价命令就是`git switch -c <branch>`

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
## Git内部原理
>当在一个新目录或已有目录执行 git init 时，Git 会创建一个 .git 目录。 这个目录包含了几乎所有 Git 存储和操作的东西。 如若想备份或复制一个版本库，只需把这个目录拷贝至另一处即可。 本章探讨的所有内容，均位于这个目录内。 新初始化的 .git 目录的典型结构如下：

```bash
$ ls -F1
config
description
HEAD
hooks/
info/
objects/
refs/
```

>config 文件包含项目特有的配置选项。 info 目录包含一个全局性排除（global exclude）文件， 用以放置那些不希望被记录在 .gitignore 文件中的忽略模式（ignored patterns）。

>剩下的四个条目很重要：HEAD 文件、（尚待创建的）index 文件，和 objects 目录、refs 目录。 它们都是 Git 的核心组成部分。 objects 目录存储所有数据内容；refs 目录存储指向数据（分支、远程仓库和标签等）的提交对象的指针； HEAD 文件指向目前被检出的分支；index 文件保存暂存区信息。 

由于这部分讲的不是很详细,只好另外找方法来学习git的内部原理了.
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
>PyCodeObject 对象中包含了最关键的字节码指令，以及关于程序的所有静态信息。
然而有一点，是 PyCodeObject 对象没有包含，也不可能包含的。
这就是关于程序运行的动态信息——执行环境。

执行环境就是命名空间,栈帧的位置等信息.

Python使用PyFrameObject来记录执行环境,每个PyFrameObject和一个Code Block一一对应:

```c
typedef struct _frame {
    PyObject_VAR_HEAD
    struct _frame *f_back;   //执行环境链上的前一个 frame
    PyCodeObject *f_code;    //PyCodeObject 对象
    PyObject *f_builtins;    //builtin 名字空间
    PyObject *f_globals;     //global 名字空间
    PyObject *f_locals;      //local 名字空间
    PyObject **f_valuestack;    //运行时栈的栈底位置
    PyObject **f_stacktop;     //运行时栈的栈顶位置
    ......
    int f_lasti;            //上一条字节码指令在 f_code 中的偏移位置
    int f_lineno;           //当前字节码对应的源代码行
    ......
    //动态内存，维护（局部变量+cell 对象集合+free 对象集合+运行时栈）空间
    PyObject *f_localsplus[1];
} PyFrameObject;

```
#### 名字、作用域和名字空间
每一个.py 文件被称 Python 视为一个 module。这些 module 中，有一个主 module,不管一个 module 是如何被加载的，在加载的过程中都会进行一个动作——执行 module 中的表达式。

一个对象(模块对象,class对象,dict对象,函数对象)的名字空间中的所有名字都称为对象的属性,要使用别的module中的名字,就要通过属性引用`.`来实现.

在一个 module 内部，可能存在多个名字空间，每一个名字空间都与一个作用域对应。位于一个作用域中的代码可以直接访问作用域中出现的名字，所谓“直接访问”，就是指不用加上属性引用方式的访问修饰符“.”：比如在 B.py 中访问 A.py 中的名字 a，需要使用“print A.a”的方式；而在 B.py 中访问自己这个 module 中的名字 a，则直接使
用“print a”这样的方式就可以了。

![图示](PixPin_2026-07-12_11-12-35.webp)

因此,一旦local作用域中定义了某个变量a,那么变量a的作用域就锁定在了local,一旦试图在未定义前访问,就会报错,如下述代码:

![图示](PixPin_2026-07-12_11-17-51.webp)

- 不过正常的程序员不会写出这种代码的...


#### 线程机制
Python虚拟机中的线程仍然使用操作系统的原生线程。用PyThreadState 作为线程状态的抽象.而进程则用 PyInterpreterState 对象来实现。

![图示](PixPin_2026-07-12_11-56-32.webp)

![图示](PixPin_2026-07-12_11-56-50.webp)
### 具体实现
所有的python代码都会被编译成类似汇编代码的字节码,然后虚拟机就使用C语言来执行这些指令,从而完成整个编译过程.
## Python高级
### Python多线程
>为了支持多线程机制，一个基本的要求就是需要实现不同线程对共享资源访问的互斥，Python 也不例外，这正是引入 GIL 的根源所在。Python 中的 GIL 是一个非常霸道的互斥实现，正如它的名字所暗示的，GIL 是一个解释器（Interpreter）级的互斥机制，也就是说，在一个线程拥有了解释器的访问权之后，其他的所有线程都必须等待它释放解释器的访问权，即使这些线程的下一条指令并不会互相影响。初看上去，这样的保护机制粒度太大了，我们似乎只需要将可能被多个线程共享的资源保护起来即可，对于不会被多个线程共享的资源，完全可以不用保护。实际上，在 Python 的发展历史中，确实出现过这样的解决方案，但是令人惊奇的，这样的方案在单处理器上的多线程实现的效率上却没有 GIL 的方案好。所以现在 Python 中的多线程机制是在 GIL 的基础上实现的。

单处理器的本质是不可能并行的，但是对于多处理器，情形就完全不同了，同一时间，确实可以有多个线程独立运行，然而 Python 的 GIL 限制了这样的情形，使得多处理器最终退化为单处理器，性能大打折扣

与操作系统一样,Python虚拟机也需要进行多线程的调度,根据线程执行的指令数量和内置时钟来决定是否要切换线程,但对于切换后将解释器交给哪个进程,Python并没有插手,而是交给了操作系统的线程调度机制来解决.

## 总结
书读的越多,越能发现自己的无知,这本书对Python2.5源码的分析确实非常不错,或许有朝一日我能对现在的Python源码也做一点分析呢.
# 深入剖析Nginx
- 这种深入剖析的书都能让人不得不佩服作者的毅力,枯燥的源码是很难看得下去的.
## 进程模型
![图示](PixPin_2026-07-16_10-19-49.webp)

Nginx的进程有监控进程和工作进程两类,各有一个无限for ( ;;)循环，以便进程持续的等待和处理自己负责的事务，直到进程退出。

为了实现多进程,Nginx效仿Linux实现了Slab机制,用于在多个进程之间共享内存,而不需要向操作系统进行额外的申请,这也是Nginx能够实现高并发的原因.
## 数据结构
Nginx内置了内存池机制,按照页数来分配内存
## 总结
源码固然枯燥,分析也很枯燥,不太推荐阅读.
# Learning Domain-Driven Design
- 基本都是泛泛而谈的空话,没看头.
# NGINX Cookbook
- 不推荐,抓不住重点
## 配置命令
### 拆分nginx
使用 include 指令来引用配置文件、目录或掩码：
```yml
http {
  include conf.d/compression.conf;
  include ssl_config/*.conf
}
```
>通过使用 include 语句，您可以保持 NGINX 配置清晰简洁。您可以对配置进行逻辑分组，以避免配置文件达到数百行。
### 负载均衡
#### HTTP
在 NGINX 的 HTTP 模块内使用 upstream 代码块对 HTTP 服务器实施负载均衡：

```nginx
upstream backend {
    server 10.10.12.45:80 weight=1;
    server app.example.com:80 weight=2;
    server spare.example.com:80 backup;
}
server {
    location / {
        proxy_pass http://backend;
    }
}
```
>HTTP 的 upstream 模块控制着 HTTP 请求负载均衡。该模块定义了一个目标池,每个上游目标都通过 server 指令在上游池中进行定义
#### TCP
在 NGINX 的 stream 模块内使用 upstream 代码块对 TCP 服务器实施负载均衡：

在 `/etc/nginx/nginx.conf` 配置文件中：

```nginx
user nginx;
worker_processes auto;
pid /run/nginx.pid;

stream {
    include /etc/nginx/stream.conf.d/*.conf;
}

```

名为 `/etc/nginx/stream.conf.d/mysql_reads.conf` 的文件可能包含以下配置：
```nginx
stream {
    upstream mysql_read {
        server read1.example.com:3306 weight=5;
        server read2.example.com:3306;
        server 10.10.12.34:3306 backup;
    }

    server {
        listen 3306;
        proxy_pass mysql_read;
    }
}
```
>http 和 stream 上下文之间的主要区别在于它们在 OSI 模型的不同层上运行。http 上下文在应用层（七层）运行，stream 在传输层（四层）运行。这并不意味着 stream 上下文不能通过一些巧妙的脚本获得应用感知能力，而是说 http 上下文是专门为了完全理解 HTTP 协议而设计的，stream 上下文默认情况下只能对数据包进行路由和负载均衡。

#### UDP
在 NGINX 的 stream 模块内使用 upstream 代码块（定义为 udp）对 UDP 服务器实施负载均衡:

```nginx
stream {
    upstream ntp {
        server ntp1.example.com:123 weight=2;
        server ntp2.example.com:123;
    }

    server {
        listen 123 udp;
        proxy_pass ntp;
    }
}

```
## 总结
受不了了,这本书一直在给Nginx Plus打广告,而且讲的一点也不完全.
# CPython Internals
- 很烂,烂到无以复加...
# NGINX HTTP Server
- 不推荐
## 入门
### `include`关键字
该关键字是递归处理的,会将对应文件的内容全部插入调用处.
### http模块
http是顶层模块,其中可以声明多个server块
### 变量
NGINX中的变量始终以$开头:
```nginx
log_format main '$pid - $nginx_version - $remote_addr';
```

字符串则有两种写法:
1. 不带引号的普通值:
```nginx
root /home/example.com/www;
```
2. 带引号的含有空格/花括号/分号的特殊值,单双引号效果相同:
```nginx
root '/home/example.com/my web pages';
```
## 总结
我服了,找了这么多nginx方面的书,没有一本能够清晰的讲清楚nginx配置的,总要弯弯绕绕很久,而官网的文档也不甚清晰,还给F5打广告,受不了了.
# 恶意代码分析实战
- 基本都是泛泛而谈,没真东西
# Nginx应用与运维实战
- 不推荐,抓不住重点

# 从零开始学架构(待补充)
- 确实很详细,待日后有需求再来学.

# Kubernetes in Action, Second Edition(待补充)
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

### 容器管理
Kubernetes部署的单位称为deployment对象,该对象对应了一个或者多个Pod,每个Pod由一个或者多个紧密相关的容器组成,他们共享相同的网络接口和命名空间:

![示意图](PixPin_2026-07-14_17-59-51.webp)

>每个 Pod 都有自己的 IP、主机名、进程、网络接口及其他资源。同
一 Pod 内的容器会认为它们是计算机中唯一运行的程序，即使与其它
Pod 位于同一节点，也不会感知到这些 Pod 中的进程。

```shell
$ kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
kiada-9d785b578-p449x    0/1     Pending   0          1m     #1

```


#### 暴露应用程序
我们使用create deployment命令创建一个deployment对象,但要使得这个对象暴露在主机端口,则需要使用expose deployment命令创建一个Service对象,从而可以被外界访问

```bash
kubectl expose deployment kiada --type=LoadBalancer --port 8080
```
#### 扩展容器
```bash
$ kubectl scale deployment kiada --replicas=3
deployment.apps/kiada scaled
```
- `--replicas=3`参数会创建三个完全相同的容器,这就是我们所说的`横向扩展`


```shell
$ kubectl get deploy
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
kiada   3/3     3            3           18m

```
可以看到我们创建了三个Pod,每个Pod都包含了一个Kiada容器.

当有多个通过`replicas`创建的相同Pod时,Pod之间便会自动进行负载均衡,每次由一个随机的Pod来处理到来的请求

>严格来说，Deployment 对象的用途仅仅是创建特定数量的 Pod 对
象。您可能会想，是否可以直接创建 Pod，而不通过 Deployment
来代劳。当然可以这么做，但如果需要运行多个副本，您就必须手动
逐个创建每个 Pod，并确保为其分配唯一的名称。此后，您还需要持
续监控这些 Pod，一旦它们突然消失或所在节点发生故障，就得立即
替换它们。这正是几乎从不直接创建 Pod、而是使用 Deployment
的根本原因。


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
>大多数面向对象语言都或多或少的学习和吸收了函数式语言的特点,Java也不例外,在Java 8中引入了Lambda表达式和函数式编程.

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

# Rust程序设计语言
## 基础
### 补充: 前瞻体验
不得不承认,rust的代码非常丑陋,导致开发效率很低下:
```rs
use crate::{
    client::Client,
    config::Config,
    error::OpenAIError,
    types::{CompletionResponseStream, CreateCompletionRequest, CreateCompletionResponse},
};

pub struct Completions<'c, C: Config> {
    client: &'c Client<C>,
}

impl<'c, C: Config> Completions<'c, C> {
    pub fn new(client: &'c Client<C>) -> Self {
        Self { client }
    }

    /// Creates a completion for the provided prompt and parameters
    ///
    /// You must ensure that "stream: false" in serialized `request`
    #[crate::byot(
        T0 = serde::Serialize,
        R = serde::de::DeserializeOwned
    )]
    pub async fn create(
        &self,
        request: CreateCompletionRequest,
    ) -> Result<CreateCompletionResponse, OpenAIError> {
        #[cfg(not(feature = "byot"))]
        {
            if request.stream.is_some() && request.stream.unwrap() {
                return Err(OpenAIError::InvalidArgument(
                    "When stream is true, use Completion::create_stream".into(),
                ));
            }
        }
        self.client.post("/completions", request).await
    }
    #[crate::byot(
        T0 = serde::Serialize,
        R = serde::de::DeserializeOwned,
        stream = "true",
        where_clause = "R: std::marker::Send + 'static"
    )]
    #[allow(unused_mut)]
    pub async fn create_stream(
        &self,
        mut request: CreateCompletionRequest,
    ) -> Result<CompletionResponseStream, OpenAIError> {
        #[cfg(not(feature = "byot"))]
        {
            if request.stream.is_some() && !request.stream.unwrap() {
                return Err(OpenAIError::InvalidArgument(
                    "When stream is false, use Completion::create".into(),
                ));
            }

            request.stream = Some(true);
        }
        Ok(self.client.post_stream("/completions", request).await)
    }
}
```

### 变量与常量
1. rust中变量用`let`声明,可以隐式推导类型,但默认为不可变的,即初始化后就不可改变,如果想要让它可变,则要加上mut修饰符,如:

```rs
fn main() {
    let x = 5;
    println!("The value of x is: {x}");
    x = 6;
    println!("The value of x is: {x}");
}
```
>Rust 编译器保证，如果声明一个值不会变，它就真的不会变，所以你不必自己跟踪它。这意味着你的代码更易于推导。

rust中有一个神奇的语法叫做遮蔽(shadowing),当你第二次用`let`声明同一个变量时,就可以覆盖该变量,这可以在同一个作用域中进行,因此与cpp的规则不太一样.


2. 常量用`const`声明,不可加上`mut`修饰,永远不可变,声明时必须要有类型注释(这比隐式推导的Go要好上不少).

```rs
const THREE_HOURS_IN_SECONDS: u32 = 60 * 60 * 3;
```
### 复合类型
1. 元组(tuple): 大致与python中tuple没有什么区别,一旦声明，它的大小就不能增长或缩小:

```rs
fn main() {
    let tup: (i32, f64, u8) = (500, 6.4, 1);
}
// another file
fn main() {
    let tup = (500, 6.4, 1);

    let (x, y, z) = tup;

    println!("The value of y is: {y}");
}
```

2. 数组(array): rust的数组长度是固定的,每个元素必须有相同类型.另一个支持的数组类型则是vector,可变长度,与cpp的vector相似.

```rs
let a: [i32; 5] = [1, 2, 3, 4, 5];
```

### 函数
>Rust 代码中的函数名和变量名通常使用 snake case 风格。在 snake case 中，所有字母都使用小写，并用下划线分隔单词

rust中**语句**是一类没有分号的表达式.

函数可以把值返回给调用它的代码。我们不会给返回值命名，但必须在箭头（->）后面声明它的类型。在 Rust 中，函数的返回值等同于函数体中最后一个表达式的值。你也可以使用 return 关键字并指定一个值，从函数中提前返回；不过大多数函数都会隐式返回最后一个表达式的值。下面是一个带有返回值的函数示例：
```rs
fn five() -> i32 {
    5
}

fn main() {
    let x = five();

    println!("The value of x is: {x}");
}
```
### 控制流
>与Go一样,rust中的if表达式中的条件必须是bool值,不允许隐式的类型转换,否则会报错,使用的仍然是C系的`else if`写法.

Rust 有三种循环：loop、while 和 for:
1. loop 关键字告诉 Rust 反复执行一段代码，要么永远执行下去，要么直到你明确要求它停止。

rust一个比较神奇的地方是可以把控制流赋值给变量:

```rs
fn main() {
    let mut counter = 0;

    let result = loop {
        counter += 1;

        if counter == 10 {
            break counter * 2;
        }
    };

    println!("The result is {result}");
}
```

loop还可以带有标签,这类似于c中的label关键字:
```rs
fn main() {
    let mut count = 0;
    'counting_up: loop {
        println!("count = {count}");
        let mut remaining = 10;

        loop {
            println!("remaining = {remaining}");
            if remaining == 9 {
                break;
            }
            if count == 2 {
                break 'counting_up;
            }
            remaining -= 1;
        }

        count += 1;
    }
    println!("End count = {count}");
}
```
- 与label的待遇一样,正常的代码里是不应该有loop出现的

2. while关键字则为正常的写法:
```rs
fn main() {
    let a = [10, 20, 30, 40, 50];
    let mut index = 0;

    while index < 5 {
        println!("the value is: {}", a[index]);

        index += 1;
    }
}
```
3. for用于遍历容器:
```rs
fn main() {
    let a = [10, 20, 30, 40, 50];

    for element in a {
        println!("the value is: {element}");
    }
}
```
### 所有权（ownership）
>所有程序都必须管理其运行时使用计算机内存的方式。一些语言中具有垃圾回收机制，在程序运行时有规律地寻找不再使用的内存；在另一些语言中，程序员必须亲自分配和释放内存。Rust 则选择了第三种方式：通过所有权系统管理内存，编译器在编译时会根据一系列的规则进行检查。

首先，让我们看一下所有权的规则:
1. Rust 中的每一个值都有一个 所有者（owner）。
2. 值在任一时刻有且只有一个所有者。
3. 当所有者离开作用域，这个值将被丢弃。

```rs
    {
        let s = String::from("hello"); // 从此处起，s 是有效的

        // 使用 s
    }                                  // 此作用域已结束，
                                       // s 不再有效

```

当 s 离开作用域的时候。当变量离开作用域，Rust 为我们调用一个特殊的函数。这个函数叫做 drop，在这里 String 的作者可以放置释放内存的代码。Rust 在结尾的 `}` 处自动调用 drop。

当你给一个已有的变量赋一个全新的值时，Rust 将会立即调用 drop 并释放原始值的内存
```rs
    let s1 = String::from("hello");
    let s2 = s1;
```
当 s2 和 s1 离开作用域，它们都会尝试释放相同的内存。这是一个叫做 二次释放（double free）的错误，也是之前提到过的内存安全性 bug 之一。两次释放（相同）内存会导致内存污染，它可能会导致潜在的安全漏洞。

为了确保内存安全，在 let s2 = s1; 之后，Rust 认为 s1 不再有效，因此 Rust 不需要在 s1 离开作用域后清理任何东西

- 这种语法相当独特,不过确实很合理,正常情况下不应该在同一个作用域中出现两个相同的指针变量.

![copy trait](PixPin_2026-07-31_09-48-37.webp)

```rs
fn main() {
    let s = String::from("hello");  // s 进入作用域

    takes_ownership(s);             // s 的值移动到函数里 ...
                                    // ... 所以到这里不再有效

    let x = 5;                      // x 进入作用域

    makes_copy(x);                  // x 应该移动函数里，
                                    // 但 i32 是 Copy 的，
    println!("{}", x);              // 所以在后面可继续使用 x

} // 这里，x 先移出了作用域，然后是 s。但因为 s 的值已被移走，
  // 没有特殊之处

fn takes_ownership(some_string: String) { // some_string 进入作用域
    println!("{some_string}");
} // 这里，some_string 移出作用域并调用 `drop` 方法。
  // 占用的内存被释放

fn makes_copy(some_integer: i32) { // some_integer 进入作用域
    println!("{some_integer}");
} // 这里，some_integer 移出作用域。没有特殊之处
```
调用一次无返回值的函数`takes_ownership`后,s就被置为无效了,这确实是我闻所未闻的语法,不过另一方面,这确实很合理,正常编写代码的时候不会这样写的.

```rs
fn main() {
    let s1 = gives_ownership();        // gives_ownership 将它的返回值传递给 s1

    let s2 = String::from("hello");    // s2 进入作用域

    let s3 = takes_and_gives_back(s2); // s2 被传入 takes_and_gives_back, 
                                       // 它的返回值又传递给 s3
} // 此处，s3 移出作用域并被丢弃。s2 被 move，所以无事发生
  // s1 移出作用域并被丢弃

fn gives_ownership() -> String {       // gives_ownership 将会把返回值传入
                                       // 调用它的函数

    let some_string = String::from("yours"); // some_string 进入作用域

    some_string                        // 返回 some_string 并将其移至调用函数
}

// 该函数将传入字符串并返回该值
fn takes_and_gives_back(a_string: String) -> String {
    // a_string 进入作用域

    a_string  // 返回 a_string 并移出给调用的函数
}
```
如果不显式返回所有权,那么就说明这个变量不再有用,那么直接收回确实很合理.
s
### reference and borrow
```rs
fn main() {
    let s1 = String::from("hello");

    let len = calculate_length(&s1);

    println!("The length of '{s1}' is {len}.");
}

fn calculate_length(s: &String) -> usize {
    s.len()
}
```
& 符号表示 引用；它们让你引用某个值而不取得它的所有权,我们将创建一个引用的行为称为 **借用（borrowing）**。正如现实生活中，如果一个人拥有某样东西，你可以从他那里借来。当你使用完后，必须还回去。因为我们并不拥有它的所有权。

![指针图](PixPin_2026-07-31_10-00-07.webp)

既然是借用,那么我们自然不能损坏它,所以引用变量均无法修改:
```rs
fn main() {
    let s = String::from("hello");

    change(&s);
}

fn change(some_string: &String) {
    some_string.push_str(", world");
    // failed!
}
```

如果要想修改借用的值,就要加上`mut`关键字,这被称为可变引用:
```rs
fn main() {
    let mut s = String::from("hello");

    change(&mut s);
}

fn change(some_string: &mut String) {
    some_string.push_str(", world");
}
```
可变引用有一个很大的限制：在同一个作用域内,如果你有一个对该变量的可变引用，你就不能再创建对该变量的引用。这些尝试创建两个 s 的可变引用的代码会失败：
```rs
    let mut s = String::from("hello");

    let r1 = &mut s;
    let r2 = &mut s;

    println!("{r1}, {r2}");
```

我们也不能在拥有不可变引用的同时拥有可变引用,因为不可变引用的借用者可不希望在借用时值会突然发生改变！
```rs
    let mut s = String::from("hello");

    let r1 = &s; // 没问题
    let r2 = &s; // 没问题
    let r3 = &mut s; // 大问题

    println!("{r1}, {r2}, and {r3}");
```

>在带有指针的语言中，如果释放了一块内存，却保留了指向它的指针，就很容易错误地制造出一个悬垂指针（dangling pointer）：这个指针指向的内存位置可能已经被分配作其他用途。相比之下，在 Rust 中，编译器保证引用永远不会变成悬垂引用：如果你持有某些数据的引用，编译器会确保这些数据不会在它们的引用之前离开作用域。


### Slice
```rs
    let s = String::from("hello world");

    let hello = &s[0..5];
    let world = &s[6..11];
```
![示意图](PixPin_2026-08-03_10-57-34.webp)

下面这段函数会编译错误,因为 clear 需要清空 String，它尝试获取一个可变引用,但在调用 clear 之后的 println! 使用了 word 中的引用，所以这个不可变的引用在此时必须仍然有效:
```rs
fn main() {
    let mut s = String::from("hello world");

    let word = first_word(&s);

    s.clear(); // 错误！

    println!("the first word is: {word}");
}
```


```rs
String：拥有字符串数据的“容器”
str：字符串中的“文字内容”
&String：借用整个 String 容器
&str：借用其中的文字内容
s               // String
&s              // &String
&s[..]          // &str
&s[0..5]        // &str
"hello world"   // &str
```
### 结构体
```rs
struct User {
    active: bool,
    username: String,
    email: String,
    sign_in_count: u64,
}
```
不得不说,这种结构体的写法真的是赏心悦目,非常适合我这种对Ts和Python都比较熟悉的人.

实例化的写法不太正常:
```rs
fn main() {
    let mut user1 = User {
        active: true,
        username: String::from("someusername123"),
        email: String::from("someone@example.com"),
        sign_in_count: 1,
    };

    user1.email = String::from("anotheremail@example.com");
}
```
照理说这里弄成等号显然更为合理一点,弄成`:`就不知所云了.

简写构造函数:
```rs
fn build_user(email: String, username: String) -> User {
    User {
        active: true,
        username,
        email,
        sign_in_count: 1,
    }
}
```
这一语法糖与CS中的比较相似.

```rs
fn main() {
    // --snip--

    let user2 = User {
        active: user1.active,
        username: user1.username,
        email: String::from("another@example.com"),
        sign_in_count: user1.sign_in_count,
    };
}
// 等价于下述简写版
fn main() {
    // --snip--

    let user2 = User {
        email: String::from("another@example.com"),
        ..user1
    };
}
```
这与js中的解包语法和pydantic中的解包极其相似,也确实很方便.

你也可以定义没有任何字段的结构体！它们被称为 类单元结构体（unit-like structs），因为它们的行为类似于 ()，也就是我们在“元组类型”一节中提到的 unit 类型

```rs
struct AlwaysEqual;

fn main() {
    let subject = AlwaysEqual;
}
```
### 方法
```rs
#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    fn area(&self) -> u32 {
        self.width * self.height
    }
}

fn main() {
    let rect1 = Rectangle {
        width: 30,
        height: 50,
    };

    println!(
        "The area of the rectangle is {} square pixels.",
        rect1.area()
    );
}
```
>&self 实际上是 self: &Self 的缩写。在一个 impl 块中，Self 类型是 impl 块的类型的别名。方法的第一个参数必须有一个名为 self 的Self 类型的参数，所以 Rust 让你在第一个参数位置上只用 self 这个名字来简化

这与python的语法高度相似呢.

### Enum
```rs
    enum IpAddr {
        V4(String),
        V6(String),
    }

    let home = IpAddr::V4(String::from("127.0.0.1"));

    let loopback = IpAddr::V6(String::from("::1"));
```
任何类型都可以放入enum中,例如元组,结构体,甚至是另一个枚举.
```rs
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}
```
结构体和枚举还有另一个相似点：就像可以使用 impl 来为结构体定义方法那样，也可以在枚举上定义方法
```rs
    impl Message {
        fn call(&self) {
            // 在这里定义方法体
        }
    }

    let m = Message::Write(String::from("hello"));
    m.call();
```

>我称之为我十亿美元的错误。当时，我在为一个面向对象语言设计第一个综合性的面向引用的类型系统。我的目标是通过编译器的自动检查来保证所有引用的使用都应该是绝对安全的。不过我未能抵抗住引入一个空引用的诱惑，仅仅是因为它是这么的容易实现。这引发了无数错误、漏洞和系统崩溃，在过去四十年里可能造成了价值十亿美元的痛苦和损失。

问题不在于概念而在于具体的实现。为此，Rust 并没有空值，不过它确实拥有一个可以编码存在或不存在概念的枚举。这个枚举是 Option<T>，而且它定义于标准库中，如下：
```rs
enum Option<T> {
    None,
    Some(T),
}
```
实际应用:
```rs
    let some_number = Some(5);
    let some_char = Some('e');

    let absent_number: Option<i32> = None;

```
简而言之，因为 Option<T> 和 T（这里的 T 可以是任何类型）是不同的类型，所以编译器不允许我们把 Option<T> 当成一个肯定有效的值来使用。例如，这段代码不能编译，因为它试图把 Option<i8> 和 i8 相加：

```rs
    let x: i8 = 5;
    let y: Option<i8> = Some(5);

    let sum = x + y;
```
>除了错误地假设一个非空值的风险，会让你对代码更加有信心。为了拥有一个可能为空的值，你必须要显式的将其放入对应类型的 Option<T> 中。接着，当使用这个值时，必须明确的处理值为空的情况。只要一个值不是 Option<T> 类型，你就可以安全的认定它的值不为空。这是 Rust 的一个经过深思熟虑的设计决策，来限制空值的泛滥以增加 Rust 代码的安全性。

这一考量确实很不错.
### 模式匹配: match
```rs
enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter,
}

fn value_in_cents(coin: Coin) -> u8 {
    match coin {
        Coin::Penny => 1,
        Coin::Nickel => 5,
        Coin::Dime => 10,
        Coin::Quarter => 25,
    }
}
```
当 match 表达式执行时，它将结果值按顺序与每一个分支的模式相比较。如果模式匹配了这个值，这个模式相关联的代码将被执行。如果模式并不匹配这个值，将继续执行下一个分支，非常类似一个硬币分类器

match 还有另一方面需要讨论：这些分支必须覆盖了所有的可能性。考虑一下 plus_one 函数的这个版本，它有一个 bug 并不能编译：
```rs
    fn plus_one(x: Option<i32>) -> Option<i32> {
        match x {
            Some(i) => Some(i + 1),
        }
    }
```

rust还支持通过变量来实现通配:
```rs
    let dice_roll = 9;
    match dice_roll {
        3 => add_fancy_hat(),
        7 => remove_fancy_hat(),
        other => move_player(other),
    }

    fn add_fancy_hat() {}
    fn remove_fancy_hat() {}
    fn move_player(num_spaces: u8) {}
```
如果我们不想使用通配变量来处理所有的边缘情况,而是打算直接忽略它或者做其他处理,就可以用到`_`这一特殊模式:
```rs
    let dice_roll = 9;
    match dice_roll {
        3 => add_fancy_hat(),
        7 => remove_fancy_hat(),
        _ => reroll(),
    }

    fn add_fancy_hat() {}
    fn remove_fancy_hat() {}
    fn reroll() {}
```
### 简洁控制流
```rs
    let config_max = Some(3u8);
    match config_max {
        Some(max) => println!("The maximum is configured to be {max}"),
        _ => (),
    }
    // 简化写法
    let config_max = Some(3u8);
    if let Some(max) = config_max {
        println!("The maximum is configured to be {max}");
    }

```
>可以认为 if let 是 match 的一个语法糖，它当值匹配某一模式时执行代码而忽略所有其他值。

不过这个语法糖确实很抽象,让人看的很迷糊:
```rs
fn describe_state_quarter(coin: Coin) -> Option<String> {
    let state = if let Coin::Quarter(state) = coin {
        state
    } else {
        return None;
    };

    if state.existed_in(1900) {
        Some(format!("{state:?} is pretty old, for America!"))
    } else {
        Some(format!("{state:?} is relatively new."))
    }
}
```

### 包、Crates 与模块
- 包（Packages）：Cargo 的一个功能，它允许你构建、测试和分享 crate。
- Crates：一个模块树，可以产生一个库或可执行文件。
- 模块（Modules）和 use：允许你控制作用域和路径的私有性。
- 路径（path）：一个为例如结构体、函数或模块等项命名的方式。

crate 是 Rust 编译器每次处理的最小代码单位。即使你用 rustc 而不是 cargo 来编译单个源代码文件，编译器也会把那个文件视为一个 crate.

crate 有两种形式：二进制 crate 和库 crate。二进制 crate（Binary crates）可以被编译为可执行程序，比如命令行程序或者服务端。它们必须有一个名为 main 函数来定义当程序被执行的时候所需要做的事情。目前我们所创建的 crate 都是二进制 crate。

库 crate（Library crates）并没有 main 函数，它们也不会编译为可执行程序。相反它们定义了可供多个项目复用的功能模块

块让我们可以将一个 crate 中的代码进行分组，以提高可读性与重用性。因为一个模块中的代码默认是私有的，所以还可以利用模块控制项的私有性（privacy）。

## 总结
暂时弃坑,写的不如我想象中的好.
# System Performance,2nd edition(待补充)
非常好的书,待我工作后再来看
## 介绍
第一章的情景演练很有看头,可以明白运维平常都在干什么活儿.

系统性能的量度有以下几点:
1. 延迟: 如I/O用时
2. 可观测性: 运维使用不同工具来观测系统的运行情况

# Fundamentals of Data Engineering(待补充)
## ch1
这一章的数据工程历史介绍很有看头.

>“Big data is like teenage sex: everyone talks about it, nobody really knows how to do it, everyone thinks everyone else is doing it, so everyone claims they are doing it.”

>尽管许多数据科学家热衷于构建和调优机器学习模型，但现实是，据估计，他们70%到80%的时间都耗费在数据层次结构的底层三个部分——数据收集、数据清理、数据处理——而只有极少时间用于分析和机器学习。

- 确实很对,大部分时间都是花在摆弄数据表格上了.

![图示](PixPin_2026-08-09_14-08-51.webp)
# Responsive Web Design with HTML5 and CSS,Fourth Edition(待补充)
# The Design of Web APIs, Second Edition(待补充)
## 介绍
### 前言
1. **“I can’t list friends of friends!”**

2. **“What contains the `sts` property?”**

3. **“Why don’t `createdAt` and `fromDate` use the same date-time format?”**

4. **“Identifying friends requires a `userId`, but storing a message requires a username! Can’t we use the same user ID in all operations?”**

5. **“The ‘List friends’ operation is useless; to get useful data, I must call the ‘Read friend’ operation for each friend!”**

6. **“The HTTP response indicates a success, but its data contains an error!”**

7. **“How can I know what’s wrong with my API call if I only get an ‘Invalid request’ error message?”**

8. **“Are you sure about the mobile and web applications taking care of friend identification with the Face Detection API before sharing a message with photos?”**

API设计确实非常重要,否则不但是开发起来麻烦,用户的体验也会大打折扣

>不是每个人都能有幸从白纸一张开始设计API。现有的API可能存在并且设计得不够理想。我们的目的并非指责过去的设计，而是要防止API设计的技术债务继续增加
# THE GHIDRA BOOK(待补充)
## 介绍
Ghidra 是一款免费开源的软件逆向工程（SRE）工具套件。它最初是美国国家安全局（NSA）的一个项目，如今得到了日益壮大的 Ghidra爱好者社区的支持。
# Go Web Scraping Quick Start Guide
## A simple request example
```go
package main

import (
	"log"
	"net/http"
	"os"
)

func main(){
	var r *http.Response
	var err error
	r,err=http.Get("https://www.example.com")
	if err!=nil{
		panic(err)
	}
	if r.StatusCode==200{
		var Content []byte
		var bodyLength int=1270
		Content=make([]byte, bodyLength)

		r.Body.Read((Content))
		var out *os.File
		out,err=os.OpenFile("index.html",os.O_CREATE|os.O_WRONLY,0664)
		if err!=nil{
			panic(err)
		}
		out.Write(Content)
		out.Close()
	}else{
		log.Fatal("Failed",
	r.StatusCode)
	}
}
```
不得不承认,Go的语法确实很简洁,但远不如Python形象
## 总结
一开始以为Go与Python的爬虫实现会有什么太大的不同,后来发现并没有什么区别,只不过Go的语法上要相对简洁一些.



# gRPC: Up and Running
## 介绍
- 江山代有才人出,各领风骚一两年

>在构建现代云原生应用和微服务的同步请求-响应式通信时，最常用且传统的方法是将其构建为RESTful服务，即将应用或服务建模为可通过HTTP协议上的网络调用访问和更改状态的资源集合。然而，对于大多数用例而言，RESTful服务在构建进程间通信时往往较为笨重、效率低下且易出错。通常需要一种高度可扩展、松散耦合且比RESTful服务更高效的进程间通信技术。这正是gRPC——一种用于构建分布式应用和微服务的现代进程间通信方式——发挥作用的地方

gRPC（“g”在每个gRPC版本中代表不同的含义）是一种进程间通信技术，它使您能够像进行本地函数调用一样轻松地连接、调用、操作和调试分布式异构应用程序。

![本书示例](PixPin_2026-08-06_13-41-46.webp)

作为有线传输协议，gRPC使用HTTP/2，这是一种高性能的二进制消息协议，支持双向消息传递。

RPC是构建客户端-服务应用程序的一种流行的进程间通信技术。通过RPC，客户端可以像调用本地方法一样远程调用某个函数或方法。早期有几种流行的RPC实现，如公共对象请求代理架构（CORBA）和Java远程方法调用（RMI），它们用于构建和连接服务或应用程序。然而，这类传统RPC实现大多极其复杂，因为它们构建在像TCP这样的通信协议之上，这阻碍了互操作性，并且基于臃肿的规范。

由于传统RPC实现（如CORBA）的局限性，Simple Object Access Protocol（SOAP）被设计并由微软、IBM等大型企业大力推广。SOAP是 service-oriented architecture（SOA）中的标准通信技术，用于在服务（在SOA上下文中通常称为Web服务）之间交换基于XML的结构化数据，并通过任何底层通信协议（如HTTP，最常用）进行通信。

SOAP曾是一种相当流行的技术，但消息格式的复杂性以及围绕SOAP构建的规范复杂性，阻碍了分布式应用开发的敏捷性。因此，在现代分布式应用开发的背景下，SOAP web服务被视为一种遗留技术。相较于使用SOAP，当前大多数现有的分布式应用正采用REST架构风格进行开发。

REST的事实标准实现是HTTP，而在HTTP中，你可以将RESTful Web应用建模为一系列资源，这些资源通过唯一标识符（URL）进行访问。状态变更操作以HTTP动词（如GET、POST、PUT、DELETE、PATCH等）的形式应用于这些资源之上。资源的状态以文本格式（如JSON、XML、HTML、YAML等）表示。

使用REST架构风格配合HTTP和JSON构建应用程序已成为构建微服务的事实标准方法。然而，随着微服务数量及其网络交互的激增，RESTful服务已无法满足预期的现代需求。RESTful服务存在几个关键限制，阻碍了其作为基于微服务的现代应用程序的消息传递协议的能力。

本质上，RESTful服务建立在基于文本的传输协议（如HTTP 1.x）之上，并利用可读的文本格式（如JSON）。在服务到服务的通信中，使用JSON这类文本格式效率并不高，因为通信双方无需采用这种面向人类的可读文本格式。

作为一种架构风格，REST 包含许多“良好实践”，遵循这些实践才能构建出真正的 RESTful 服务。然而，这些实践并未作为实现协议（如HTTP）的强制部分，使得在实现阶段难以强制执行。因此，在实践中，大多数自称为 RESTful 的服务并未 properly 遵循 REST 风格的基础。由此，所谓的 RESTful 服务大多仅仅是通过网络暴露的 HTTP 服务。因此，开发团队不得不花费大量时间维护 RESTful 服务的一致性和纯粹性。

Google一直使用一个名为Stubby的通用RPC框架，来连接数千个运行在多个数据中心、采用不同技术构建的微服务。其核心RPC层旨在处理每秒数百亿次请求的互联网规模。Stubby拥有众多优秀特性，但它并未被标准化为通用框架，因为它与Google的内部基础设施耦合过紧。2015年，谷歌发布了gRPC作为开源RPC框架；它是一种标准化、通用且跨平台的RPC基础设施。gRPC旨在向广大社区提供与Stubby相同的可扩展性、性能和功能。

gRPC并非使用JSON或XML这类文本格式，而是采用基于协议缓冲区的二进制协议来与gRPC服务和客户端进行通信。此外，gRPC在HTTP/2之上实现了协议缓冲区，这使得它在进程间通信中更加高效。

随着采用gRPC，Netflix在开发者生产力方面获得了巨大提升。例如，对于每个客户端，数百行自定义代码被替换为proto中仅需两到三行的配置。创建一个原本可能需要两到三周的客户端，如今使用gRPC只需几分钟即可完成。平台的整体稳定性也大为改善，因为大多数常规功能不再需要手写代码，并且有一种全面且安全的方式来定义服务接口.

```ts
// 指定Protobuf版本语法（Proto3）
syntax = "proto3";

// 从其他包导入消息类型
import "google/protobuf/wrappers.proto";

// 声明包名，用于避免消息类型命名冲突，并决定生成的代码命名空间
package ecommerce;

// 定义RPC服务接口
service ProductInfo {
    // 添加商品：接收Product消息，返回ProductID消息
    rpc addProduct(Product) returns (ProductID);
    // 获取商品：接收ProductID消息，返回Product消息
    rpc getProduct(ProductID) returns (Product);
}

// 定义商品实体结构体
message Product {
    string id = 1;          // 商品唯一标识符（字段编号 1）
    string name = 2;        // 商品名称（字段编号 2）
    string description = 3; // 商品描述（字段编号 3）
}

// 定义商品ID结构体
message ProductID {
    string value = 1;       // 商品ID值（字段编号 1）
}
```
可以看到,protobuf的格式相当清晰,比起OpenAPI规范的可读性要高了许多,不再需要强调路由,方法这些让人心累的无关参数.
## 原理
gRPC的通信过程很简单,以客户端调用getProduct函数为例:
1. 客户端进程调用生成存根中的 `getProduct` 函数。
2. 客户端存根会创建一个携带编码后消息的 HTTP POST 请求。在 gRPC 中，所有请求都是 HTTP POST 请求，其 `content-type` 以 `application/grpc` 为前缀。所调用的远程函数（`/ProductInfo/getProduct`）作为单独的 HTTP 头发送。
3. HTTP 请求消息通过网络发送到服务器机器。
4. 当消息到达服务器时，服务器会检查消息头以确定需要调用哪个服务功能，并将消息交给服务存根处理。
5. 服务存根将消息字节解析为特定于语言的数据结构。
6. 然后，服务使用解析后的消息，对 `getProduct` 函数进行本地调用。
7. 服务函数的返回被编码后发送回客户端。响应消息遵循我们在客户端观察到的相同流程（响应→编码→线上的 HTTP 响应）；消息被解包，其值返回给等待的客户端进程。

这些步骤与大多数RPC系统（如CORBA、Java RMI等）非常相似。这里gRPC的主要区别在于它对消息的编码方式--Protocol Buffers,这是一种语言无关的机制.

事实上来讲,gRPC确实没什么革命的地方,只不过把以前要共同维护的OpenAPI文档换成了proto文档而已,但它简化了HTTP方法,路径依赖等比较边角料的参数,从而让程序员能够只专注于简单的函数调用即可.
## 总结
可以看的出来目前gRPC还不是那么的成熟,不然这本书的实战部分就不会讲的这么云山雾罩了.
# Becoming SRE 
## 介绍
>**Site reliability engineering** is an engineering discipline devoted to helping organizations sustainably achieve the appropriate level of **reliability in their systems, services, and products**.

>每当我与那些努力理解网站可靠性工程的人交谈时，几乎可以保证讨论迟早会涉及类似这样的问题：DevOps与SRE相比有何异同？它们之间有何关系？在同一个公司同时拥有这两种角色是否合理？

1. SRE Implements Class DevOps
2. SRE Is to Reliability as DevOps Is to Delivery
3. It’s All About the Direction of Attention

总的来说,SRE的职责更大,所以可以说是高级运维.
## SRE思维
![小测验](PixPin_2026-08-11_11-07-17.webp)

![答案](PixPin_2026-08-11_11-08-06.webp)

It was suggested that both the work was well suited to people with ADHD and that people with ADHD were some of the best at this work.

- 说的确实很对,如果你愿意每天折腾各种各样的故障,甚至有在大半夜被叫起来去恢复系统的癖好,那你绝对有ADHD.

`SREs can be prone to yak shaving.`,意思是为了解决一个问题你要解决一连串的连带问题,永远都搞不定.
## 总结
前三章看看就得了,后面还翻来覆去的讲这些经验就没看头了.
# THE MISSING README
很一般...
# Building Evolutionary Architectures,2nd edition
## 介绍
>当我们于2017年撰写《构建演进式架构》第一版时，软件架构可演进的想法仍显得有些激进。在一次关于该主题的早期演讲中，丽贝卡在结束后被某人指责，称她提出软件架构能随时间演进是职业上不负责任的表现——毕竟，架构是永远不变的东西。然而，正如现实所教导我们的，系统必须不断演变以满足用户的新需求，并反映不断变化的软件开发生态系统的变化。

> **为什么我们在2000年没有微服务**
> 考虑一位拥有时间机器的架构师，乘时光机回到2000年，向运营负责人提出一个新想法。
> “我有一个很棒的新架构概念，它可以让各项能力之间实现极佳的隔离——这叫做**微服务**；我们将围绕业务能力设计每个服务，并保持高度解耦。”
> “太好了，”运营负责人说道，“你需要什么？”
> “嗯，我需要大约50台新电脑，当然还有50个新的操作系统许可证，另外还需要20台电脑用作独立数据库，并为它们配备许可证。你认为我什么时候能全部拿到这些？”
> “请离开我的办公室。”
> ---
> 
> 
> *尽管微服务在当时看起来可能是个好主意，但生态系统还无法支持它。*

>无论软件开发涉及的具体方面如何——编程平台、语言、运行环境、持久化技术、云服务等——我们都预期不断变化。尽管无法预测技术或领域环境中的变化何时发生，或哪些变化会持续，但我们知道变化是不可避免的。因此，我们应该在架构系统时认识到技术环境将会改变。


## 总结
尽管标题是这个,而第一章也的确很雄心壮志,可惜的是后面的内容都是毫无意义的扯淡了.
# Python for DevOps by Noah Gift
唯一的收获是告诉我第一章讲python语法的都不是好书.
# Python for DevOps by Chacko
与同名书的收获相同.
# Python for Algorithmic Trading
## 前置知识
1. Beta trading: 通过投资于例如复制标普500指数表现的交易所交易基金（ETFs）来赚取市场风险溢价
2. Alpha generation: 以独立于市场的方式获取风险溢价，例如做空标普500指数成分股或标普500指数ETF即可实现。
3. Static hedging: ，通过买入标准普尔500指数价外看跌期权来对冲市场风险
4. Dynamic hedging: 通过对标普500指数期权产生影响的市场风险进行对冲，例如动态交易标普500指数期货以及相应的现金、货币市场或利率工具

本书聚焦于Alpha generation策略.

## 总结
基本是代码的罗列,原理讲的一点都不清晰,所以看的很迷糊
# Redis in action
## 介绍
Redis有5种基础数据类型:
1. string: 支持字符串,整数和浮点数
2. list: 链表,每个节点包含一个元素,元素可重复
3. set: 无序的字符串集合,元素不可重复
4. hash: 哈希表,存储键值对
5. zset: 有序字典,存储键值对


string类型支持get,set,del三种方法:
![使用示例](PixPin_2026-07-13_10-06-47.webp)

list类型支持以下命令:
| 命令     | 行为                                     |
| -------- | ---------------------------------------- |
| `RPUSH`  | 将给定值推入列表的右端                   |
| `LRANGE` | 获取列表在给定范围上的所有值             |
| `LINDEX` | 获取列表在给定位置上的单个元素           |
| `LPOP`   | 从列表的左端弹出一个值，并返回被弹出的值 |

- 左右端都可以进行操作,前缀分别是`L`,`R`.

set类型支持`sadd`,`srem`等命令

![示例](PixPin_2026-07-13_10-14-46.webp)

![hash](PixPin_2026-07-13_10-16-55.webp)

![zset](PixPin_2026-07-13_10-16-41.webp)


## 数据存储
Redis有两种数据存储方式:
1. snapshot(快照): 将某一时刻内存中保存的所有数据写入硬盘
2. append-only file(AOF): 执行某条写入命令时,将指令复制到硬盘里.
### 复制(replication)
单个Redis节点无法应对高并发,所以我们需要用到主从服务器的配置,从服务器在连接主服务器的时候会发生以下过程:

| 步骤 | 主服务器操作                                                                            | 从服务器操作                                                                                               |
| ---- | --------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| 1    | （等待命令进入）                                                                        | 连接（或者重连接）主服务器，发送 `SYNC` 命令                                                               |
| 2    | 开始执行 `BGSAVE`，并使用缓冲区记录 `BGSAVE` 之后执行的所有写命令                       | 根据配置选项来决定是继续使用现有的数据（如果有的话）来处理客户端的命令请求，还是向发送请求的客户端返回错误 |
| 3    | `BGSAVE` 执行完毕，向从服务器发送快照文件，并在发送期间继续使用缓冲区记录被执行的写命令 | 丢弃所有旧数据（如果有的话），开始载入主服务器发来的快照文件                                               |
| 4    | 快照文件发送完毕，开始向从服务器发送存储在缓冲区里面的写命令                            | 完成对快照文件的解释操作，像往常一样开始接受命令请求                                                       |
| 5    | 缓冲区存储的写命令发送完毕；从现在开始，每执行一个写命令，就向从服务器发送相同的写命令  | 执行主服务器发来的所有存储在缓冲区里面的写命令；并从现在开始，接收并执行主服务器传来的每个写命令           |

![主从链](PixPin_2026-07-31_11-33-18.webp)

主从复制只有复制和冗余,并没有实现扩容,要想扩容就必须用到多个主服务器.

## 总结
剩下的内容就都是一些不太实用的扯淡了,可以直接跳过
# Mastering API Architecture
## 前言
>One of the hardest things to track during the life of a project is the motivation behind certain decisions. A new person coming on to a project may be perplexed, baffled, delighted, or infuriated by some past decision.

因此,我们需要通过ADR（Architecture Decision Record，架构决策记录）来保存架构设计时的各种考量
## Designing, Building, and Testing APIs
### gRPC与Rest
Rest基于HTTP1.1规范,而gRPC基于HTTP2.0,二者之间的一个关键区别在于状态,Rest是无状态的,而RPC的底层是持续连接,有状态的
## 总结
非常搞笑,标题叫掌握API架构,但只有前两章稍微有一点关系,后面都是运维相关的知识,很扯淡了.
# HTML5 WebSocket权威指南
## 前置知识
在HTTP/1.0和HTTP/1.1中，低效的根源主要是：
1. HTTP用于文档共享，而不是丰富的交互性应用程序，我们在桌面上习以为常的这种应用程序现在已经进入Web
2. 随着客户端和服务器之间交互的增加，HTTP协议在客户端和服务器之间通信所需要的信息量快速增加。

而WebSocket是基于HTTP1.1的框架,能够将HTTP请求变成全双工的.
## 总结
内容太老了,所以没什么可读性.不过WebSocket也逐渐式微了,在可预见的未来我想不是很需要学习这方面的知识.
# Elasticsearch in Action, Second Edition(待补充)
- [为什么不用Solr](https://learnku.com/articles/43880)
## 概述
传统的数据库仅能返回普通的查询结果,而若是要实现智能提示和多样化搜索,就需要搜索引擎这些经过了优化处理的数据库来解决了.

Es的底层引擎为使用Java编写的Lucene,再在外面套了一层符合Rest规范的API,然后还有一个配套的前端管理程序Kibana.

![示意图](PixPin_2026-07-29_10-55-57.webp)

![创建过程](PixPin_2026-07-29_11-01-18.webp)

![查询过程](PixPin_2026-07-29_11-06-37.webp)

到这里我们也看明白了,Es的使用方法就是通过Restful API来传输Json文档而已,这种方法非常高效,而且掩盖了背后的复杂优化过程.

- 不过,也只有搜索引擎才能这么干,毕竟搜索请求都是幂等的,所以不会受到并发的困扰.而对于普通的数据库来说,只好老老实实地通过底层驱动连接了,如果有人能够想到更美妙的解决方法,诺奖不说,图灵奖是绝对有的.

>Elasticsearch has an algorithm called **Okapi Best Match 25** (BM25), which is an **enhanced** term frequency/inverse document frequency (**TF/IDF**) similarity algorithm that calculates the relevancy scores for the results and sorts them in that order when presenting them to the client.

而在执行搜索时,我们也可以手动给关键字分配对应的权重,来返回自己想要的搜索结果,而在我们平常的搜索时,这一过程都是自动进行的.

## 架构
Elasticsearch按节点和数据类型对数据进行分类。每个节点都有一个专用文件夹，其中包含若干存储相关数据的桶。Elasticsearch会根据每种数据类型创建一组桶（在Elasticsearch术语中称为索引）

分片是 Apache Lucene 的物理实例，是幕后将数据存入和取出存储的关键载体。换言之，分片负责数据的物理存储与检索工作。从 7.x 版本起，默认情况下新创建的每个索引仅配备一个主分片和一个副本

主分片负责存储文档，而副本分片（简称副本）顾名思义是主分片的副本。每个分片可以有多个副本，也可不设置副本，但这种方式不推荐用于生产环境——在实际生产环境中，通常会为每个分片创建多个副本。副本存储着数据副本，既能提升系统冗余度，又能帮助加速搜索查询。
# Rootkit和Bootkit：现代恶意软件逆向分析和下一代威胁(待补充)
- Rootkit: 针对操作系统内核
- Bootkit: 针对MBR等引导扇区
## Rootkit
### TDL3
为了在系统重新启动时幸存下来，TDL3通过在驱动程序的二进制文件中注入恶意代码来感染加载操作系统所必需的一个引导启动驱动程序.

一旦选择了一个目标驱动程序，TDL3感染程序就会用一个恶意加载程序覆盖它的资源部分.rsrc的前几百个字节，从而修改驱动程序在内存中的映像。这个加载程序非常简单：它只是在启动时从硬盘上加载它需要的其余恶意软件代码。

这种方式只能针对x32位系统起作用,因为x64位系统需要对内核代码进行完整性的检查,通过数字签名即可阻止TDL3的运行.

![目标](PixPin_2026-07-30_12-23-56.webp)

>TDL3是第一个将配置文件和有效负载存储在目标系统隐藏的加密存储区域的恶意软件系统，不依赖于操作系统提供的文件系统服务。

### Festi
>本章专门讨论发现的最先进的垃圾邮件和分布式拒绝服务
（DDoS）僵尸网络之一—Win32/Festi僵尸网络，我们将其简称为Festi。Festi拥有强大的垃圾邮件发送和DDoS功能，以及有趣的Rootkit功能，这使得它可以连接到文件系统和系统注册表而不被人发现。Festi还通过使用调试器和沙箱规避技术来对抗动态分析，以隐藏自己的存在。

Festi的Dropper（植入程序）有一个相当简单的功能—在系统中安装一个内核模式驱动程序，该驱动程序实现了恶意软件的主要逻辑。内核模式组件注册为“系统启动”内核模式驱动程序，并随机生成名称，这意味着在初始化期间，恶意驱动程序将在系统启动时加载和执行。

内核模式驱动程序有两个主要职责：从命令和控制（C&C）服务器请求配置信
息，以及以插件的形式下载和执行恶意模块（见图2-2）。每个插件专用于特定的任
务，例如对指定的网络资源执行DDoS攻击，或向C&C服务器提供的电子邮件列表发送
垃圾邮件。

有趣的是，插件并不存储在系统硬盘驱动器上，而是存储在易失性内存中，这意
味着当受感染的计算机被关闭或重新启动时，插件就会从系统内存中消失。这使得恶
意软件的取证分析变得非常困难，因为存储在硬盘上的唯一文件是主内核模式驱动程
序，它既不包含有效负载，也不包含攻击目标的任何信息。

## Bootkit
可以看到,由于操作系统的安全性能不断提高,Rootkit已经式微,随之而来的是更加深入底层的Bootkit类型软件.

![示意图](PixPin_2026-08-03_10-18-49.webp)
### ch5
这一章很有看头,讲述了从BIOS启动操作系统的一般过程
# Security Chaos Engineering
很好奇这种丝毫不涉及现实,而是空泛提及理论的书是如何出版的.
# Tailwind CSS
## ch1
```html
  <body>
    <div class="container mx-auto">
      <header
        class="flex justify-between items-center sticky top-0 z-10 py-4 bg-blue-900"
      >
        <div class="flex-shrink-0 ml-6 cursor-pointer">
          <i class="fas fa-wind fa-2x text-yellow-500"></i>
          <span class="text-3xl font-semibold text-blue- 200"
            >Tailwind School</span
          >
        </div>
        <ul class="flex mr-10 font-semibold">
          <li class="mr-6 p-1 border-b-2 border-yellow-500">
            <a class="cursor-default text-blue-200" href="#">Home</a>
          </li>
          <li class="mr-6 p-1">
            <a class="text-white hover:text-blue-300" href="#">News</a>
          </li>
          <li class="mr-6 p-1">
            <a class="text-white hover:text-blue-300" href="#">Tutorials</a>
          </li>
          <li class="mr-6 p-1">
            <a class="text-white hover:text-blue-300" href="#">Videos</a>
          </li>
        </ul>
      </header>
    </div>
  </body>
```
1. container作为容器,限制页面与网页边框的间距
2. mx-auto作用于div,section,或者设置了flex的元素,使得这些元素在父容器中水平居中,`m=margin`,`x=横向`,若为`my-auto`则表示纵向
3. justify-between (justify-content: space-between)：将子元素沿水平方向向两端推开
4. items-center (align-items: center)：让不同高度的子元素在垂直方向居中对齐。
5. sticky: 固定该元素,会随着页面滚动
6. `z-10`,z轴优先级,设置高优先级保证始终位于页面最上层.
7. `py-4`: padding-y为4*4px
8. `bg-blue-900`: 背景为蓝色,强度为900,色调的默认范围为50到950

```html
<div class="flex-shrink-0 ml-6 cursor-pointer">
  <i class="fas fa-wind fa-2x text-yellow-500"></i>
  <span class="text-3xl font-semibold text-blue-200">Tailwind
  School</span>
</div>
```
1. `fas fa-wind`: 风图标,属于Font Awesome库
2. `fa-2x`: 放大为2倍.
3. `ml-6`: margin-left,6*4px
4. `cursor-pointer`: 悬停时光标变成pointer(手),自然还有`cursor-wait`等其他的光标形状
5. `text-2xl`: 2倍字号大小
6. `font-semibold`: 半粗体
7. `flex-shrink-0`: 控制当 Flex 容器空间不足时，元素是否以及如何按比例缩小,若为0则表示不缩小.

```html
<ul class="flex mr-10 font-semibold">
          <li class="mr-6 p-1 border-b-2 border-yellow-500">
            <a class="cursor-default text-blue-200" href="#">Home</a>
          </li>
          <li class="mr-6 p-1">
            <a class="text-white hover:text-blue-300" href="#">News</a>
          </li>
          <li class="mr-6 p-1">
            <a class="text-white hover:text-blue-300" href="#">Tutorials</a>
          </li>
          <li class="mr-6 p-1">
            <a class="text-white hover:text-blue-300" href="#">Videos</a>
          </li>
        </ul>
```
- `text-white hover:text-blue-300`:很好看懂

## 补充学习
遗憾的是,这篇教程剩下的内容用的是vue,而且还是tailwind v3版本,不具备任何的实用性,所以只好做点个人的补充了.

在某个文件夹运行下述命令:
```bash
npx create-next-app@latest . --src-dir --ts --no-agents-md
```
如果用pnpm的话则这样写:
```bash
pnpm dlx create-next-app@latest . --src-dir --ts --no-agents-md
```

之所以不要额外干什么活儿,是因为nextjs已经将tailwindcss全部内置统一安装了,还是非常不错的.

好在ch1学的东西已经够用了,现在再来看`page.tsx`就不觉得是鬼画符了:
```tsx
// 省略了几个图像
export default function Home() {
  return (
    <div className="flex flex-col flex-1 items-center justify-center bg-zinc-50 font-sans dark:bg-black">
      <main className="flex flex-1 w-full max-w-3xl flex-col items-center justify-between py-32 px-16 bg-white dark:bg-black sm:items-start">
        <div className="flex flex-col items-center gap-6 text-center sm:items-start sm:text-left">
          <h1 className="max-w-xs text-3xl font-semibold leading-10 tracking-tight text-black dark:text-zinc-50">
            To get started, edit the page.tsx file.
          </h1>
          <p className="max-w-md text-lg leading-8 text-zinc-600 dark:text-zinc-400">
            Looking for a starting point or more instructions? Head over to{" "}
            <a
              href="https://vercel.com/templates?framework=next.js&utm_source=create-next-app&utm_medium=appdir-template-tw&utm_campaign=create-next-app"
              className="font-medium text-zinc-950 dark:text-zinc-50"
            >
              Templates
            </a>{" "}
            or the{" "}
            <a
              href="https://nextjs.org/learn?utm_source=create-next-app&utm_medium=appdir-template-tw&utm_campaign=create-next-app"
              className="font-medium text-zinc-950 dark:text-zinc-50"
            >
              Learning
            </a>{" "}
            center.
          </p>
        </div>
      </main>
    </div>
  );
}
```
1. `flex-1`,等价于下述代码:

```css
flex: 1 1 0%;
/* 等价拆解：
   flex-grow: 1;   (允许拉伸放大以填满剩余空间)
   flex-shrink: 1; (允许在空间不足时按比例缩小)
   flex-basis: 0%; (初始基准尺寸忽略内容固有宽度)
*/
```

2. `max-w-md`: 最大宽度为medium尺寸
3. `dark:bg-black`: 当主题被设置为dark时,背景变成black
4. `leading-8`: line-height为8*4px大小

必须承认,tailwind确实很好记,怪不得这么火.
# GraphQL in Action
## 介绍
>REST API最大的相关问题是客户端需要与多个数据API端点通信。因此，当客户端需要多个资源的数据时，它必须向该REST API发起多个网络请求，然后通过组合接收到的多个响应来整合数据。REST API客户端可用的语言极其有限。例如，`READ` REST API端点要么是GET /ResourceName以获取该资源的所有记录列表，要么是GET /ResourceName/ ResourceID以获取由ID标识的单一记录。
### 补充: strawberry库
strawberry库是python的GraphQL实现,在22年就有issue提出要整合Pydantic进去,可惜直到现在都还是实验性的,等到真正整合进去之后,我想才有必要去学这个库.

![示意图](PixPin_2026-08-04_11-58-43.webp)
## 总结
尽管GraphQL很不错,但可惜这本书讲的太烂了,不如直接看文档.
# Web Automation Testing Using Playwright
## 介绍
人工编写测试用例并逐一运行过于繁琐,这也是测试工具不断演进不断发展的原因,而在其中名气处于第一梯队的就是Playwright了,而它这么火爆的另一个原因是还可以被用于爬虫.谁能想到,Playwright的正式发布时间也才在2020年呢,至于老牌的Selenium由于更差性能和更复杂的调用方式则逐渐落伍.有力的竞争者之一则是Cypress,由于它运行在浏览器内部,不需要额外安装驱动,所以也占有了一席之地.


## 安装Playwright
- 每次安装都麻烦的过头了好不好
![示意图](PixPin_2026-07-29_12-03-37.webp)

```bash
pnpm create playwright@latest
```
## locators
playwright中的定位器都很朴素,调用方法如下:
```ts
import { test, expect } from '@playwright/test';

test('has title', async ({ page }) => {
  await page.goto('https://playwright.dev/');

  // Expect a title "to contain" a substring.
  await expect(page).toHaveTitle(/Playwright/);
});

test('get started link', async ({ page }) => {
  await page.goto('https://playwright.dev/');

  // Click the get started link.
  await page.getByRole('link', { name: 'Get started' }).click();

  // Expects page to have a heading with the name of Installation.
  await expect(page.getByRole('heading', { name: 'Installation' })).toBeVisible();
});
```
如果用于css的话,则是这样写:
```ts
await page.locator('#sum1’);
```
显然,对于爬虫来说,这一功能确实很不错,至少能够保证
## 总结
必须承认,这本书写的很烂,也没什么系统性,不过基本能够了解playwright是什么,而且它远远没有达到所谓的自动化的程度.
# Fluent Python ,second edition
比较一般,讲的不够深入,尽管名气很大,但不推荐阅读.
# Full Stack Testing,2rd edition
- July/9 2026: Second Edition
  - 我读这本书的日期为7/19,而zlib上就已经有资源了,确实离谱

## ch1
>Starting testing early in the delivery cycle to provide faster feedback is referred to as **shift-left testing**, and it’s a key principle of full stack testing.

![图示](PixPin_2026-07-21_17-39-07.webp)
## 总结
基本都是概念,没多少实战,还教我用AI写测试,跟我原来想的差距有点大.
# Node.js Cookbook
## 介绍
>Node.js 创建于2009年，是一个跨平台的开源JavaScript运行时，允许你在浏览器环境之外执行JavaScript。它封装了谷歌浏览器的JavaScript引擎——V8引擎，使JavaScript能够在脱离浏览器的情况下运行

Node的执行环境为单线程,通过异步I/O来实现高并发,这与Python的GIL极为相似,不过也正是因为这样,后端通常不会让Node来负责,否则就会受到性能上的限制.
## 总结
忽然想到,我不太需要知道node.js的api用法,毕竟框架都帮我做好了,而且我即便学习好了,或许日后也会被其他框架取代,只是现在还看不出这个趋势而已.
# Metasploit
讲Metasploit渗透测试框架的,写的挺烂.
# Flutter实战 第二版
## 入门
### 起步
| 技术类型              | UI渲染方式      | 性能 | 开发效率        | 动态化     | 框架代表       |
| --------------------- | --------------- | ---- | --------------- | ---------- | -------------- |
| H5 + 原生             | WebView渲染     | 一般 | 高              | 支持       | Cordova、Ionic |
| JavaScript + 原生渲染 | 原生控件渲染    | 好   | 中              | 支持       | RN、Weex       |
| 自绘UI + 原生         | 调用系统API渲染 | 好   | Flutter高, Qt低 | 默认不支持 | Qt、Flutter    |

#### Dart基础
>Dart 在静态语法方面和 Java 非常相似，如类型定义、函数声明、泛型等，而在动态特性方面又和 JavaScript 很像，如函数式特性、异步支持等

- 变量声明

```dart
var t = "hello";
// 报错,Dart是静态类型语言
t = 1000; 
```

- 常量声明

```dart
//可以省略String这个类型声明
final str = "hi world";
//final String str = "hi world"; 
const str1 = "hi world";
//const String str1 = "hi world";
```
>final变量在第一次使用时才会被初始化,而const是一个编译时的常量,会被直接替换成常量值.

- 函数声明

Dart中的函数也是对象,有一个类型Function,但可以不指定返回类型(你要么全都指定,要么全都默认推断,这样在中间卡着也太不利索了)

>Dart函数声明如果没有显式声明返回值类型时会默认当做dynamic处理，注意，函数返回值没有类型推断：
```dart
typedef bool CALLBACK();

//不指定返回类型，此时默认为dynamic，不是bool
isNoble(int atomicNumber) {
  return _nobleGases[atomicNumber] != null;
}

void test(CALLBACK cb){
   print(cb()); 
}
//报错，isNoble不是bool类型
test(isNoble);
```

- 我受不了了,直接跳过吧,太乱了
#### 官方示例
看一下官方给的代码样例来速通一下:
```dart
import 'package:flutter/material.dart';
// 类似Js的导入语法

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
// extends类似Java的写法
  const MyApp({super.key});
// super调用父类也是java的写法
  @override
// override装饰器也是java写法
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
    // 这种用:来声明参数变量的方式就是C#写法
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
// const和final傻傻分不清,这是Dart的一个很大败笔
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          // .前缀符,如果类型可以自动推导,则直接省略
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```
对于学过Java和Js的人来说,Dart语法确实很容易掌握,但这种乱糟糟的写法开发效率显然弗如JSX远甚.
## 总结
越看越头痛呢,虽然知道这种跨平台框架到头来还是写前端样式,但是静态类型和杂糅的语法让Dart的样式函数变得面目可憎:
```dart
import 'package:flutter/material.dart';

class ClipTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 头像  
    Widget avatar = Image.asset("imgs/avatar.png", width: 60.0);
    return Center(
      child: Column(
        children: <Widget>[
          avatar, //不剪裁
          ClipOval(child: avatar), //剪裁为圆形
          ClipRRect( //剪裁为圆角矩形
            borderRadius: BorderRadius.circular(5.0),
            child: avatar,
          ), 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                widthFactor: .5,//宽度设为原来宽度一半，另一半会溢出
                child: avatar,
              ),
              Text("你好世界", style: TextStyle(color: Colors.green),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRect(//将溢出部分剪裁
                child: Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5,//宽度设为原来宽度一半
                  child: avatar,
                ),
              ),
              Text("你好世界",style: TextStyle(color: Colors.green))
            ],
          ),
        ],
      ),
    );
  }
}
```

如果以后有机会的话,我会再来学习的...
# React in Depth
## 介绍
![图示](PixPin_2026-07-18_10-27-51.webp)

前端的技术栈比起后端要可怕的多,这也是为什么资深前端这么少的原因.
## 总结
不推荐,看来前端还是要以文档和实战为主,因为技术栈的变化太快了,几年前的经验到现在就根本不适用了.
## Advanced component patterns

### The Provider pattern

# Node.js in Action, Second Edition
- 十年前写的,用的还是CommonJS的写法
不推荐,太老了,涉及的技术栈也都非常老旧,基本都死透了.
# Powerful Python
尽管是24年出版的书,但内容都很老套,也都讲的很简单.
# High Performance Python 3rd edition
- 25年5月出版的,新鲜的很

讲的一般般,大多数内容我都已经学过了.
# Effective Software Testing(待补充)
## 软件测试介绍
>软件工程中的实证研究一再表明，简洁无味的代码比复杂代码更不易出现缺陷（参见 Shatnawi 和 Li 2006年的论文）。
然而，仅有简洁远远不够。
认为测试可以完全被简洁取代是天真的看法。"通过设计保证正确性"同样如此：设计好代码并不意味着能避免所有可能的错误。

![金字塔](PixPin_2026-07-27_12-01-45.webp)
# Kafka: The Definitive Guide,2rd edition
## 介绍
- Kafka由Linkedin在09年研发出来,并在11年捐献给Apache基金会,所以又叫Apache Kafka.

>I thought that since Kafka was a system optimized for writing, 
using a writer’s name would make sense. 
I had taken a lot of lit classes in college and liked Franz Kafka. 
Plus the name sounded cool for an open source project.

Kafka中的数据单位称为消息(messages)。如果你有数据库背景，可以将此视为类似行或记录的概念。对Kafka而言，消息本质上就是一个字节数组，因此其中包含的数据对Kafka没有特定格式或含义。消息可以附带一个可选的元数据片段，称为键,可以辅助消息写入kafka中.

- Kafka传输的消息格式一般为紧凑的Apache Avro而不是可读性强的Json
- Kafka中的消息按照topic进行分类(类似于文件系统中的文件夹),每个topic可以有多个partition(分区),消息以追加形式写入分区中,按照顺序从头到尾读取.
- 不同服务器可以存储一个分区的多个副本,从而保障数据安全.
- stream表示消息传输时的数据流.

Kafka clients是Kafka server的使用者,有两种基本类型: producers and consumers.

- 单个Kafka server被称为Broker(代理),它从生产者处接受消息并存储,并响应消费者的服务请求.
- 多个Broker组成一个cluster(代理集群),Broker中自动选举一个Controller作为管理员.

消息保留了一定时间(例如7天)或者分区达到特定的容量大小就会自动进行删除,这是Kafka的独特之处,简化了其他消息队列系统中复杂的数据库管理方式.

## 补充: docker启动kafka
由于这本书出版于2021年,当时kafka版本为2.8.0,底层用的还是ZooKeeper,而现在Kafka更新到了4.3.1版本,底层全面换成了KRaft,所以书中的安装指南基本没有任何作用了.

- [原因](https://spoud-io.medium.com/embracing-the-future-of-kafka-why-its-time-to-migrate-from-zookeeper-to-kraft-f1a5225ac48a)

要想跨平台使用Kafka,显然只能让Docker来干活儿了,自然,我是不知道怎么写kafka的compose文档的,看一下
[官方](https://hub.docker.com/r/apache/kafka)推荐的单节点写法:

```yml
services:
  broker:
    image: apache/kafka:latest
    container_name: broker
    ports:
      - 9092:9092
    environment:
      KAFKA_NODE_ID: 1
      KAFKA_PROCESS_ROLES: broker,controller
      KAFKA_LISTENERS: PLAINTEXT://localhost:9092,CONTROLLER://localhost:9093
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://localhost:9092
      KAFKA_CONTROLLER_LISTENER_NAMES: CONTROLLER
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT
      KAFKA_CONTROLLER_QUORUM_VOTERS: 1@localhost:9093
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
      KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR: 1
      KAFKA_TRANSACTION_STATE_LOG_MIN_ISR: 1
      KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS: 0
      KAFKA_NUM_PARTITIONS: 3
```
考虑到我们只是测试使用,所以就不需要绑定到数据卷上了,kafka,启动!

```bash
docker compose up -d 
```
启动成功后,首先运行以下命令创建topic:
```bash
docker exec -it kafka /opt/kafka/bin/kafka-topics.sh --create --topic test-topic --partitions 1 --replication-factor 1 --bootstrap-server localhost:9092
```
在该终端启动producer:
```bash
docker exec -it kafka /opt/kafka/bin/kafka-console-producer.sh --topic test-topic --bootstrap-server localhost:9092
```

另开一个终端启动consumer:
```bash
docker exec -it kafka /opt/kafka/bin/kafka-console-consumer.sh --topic test-topic --from-beginning --bootstrap-server localhost:9092
```

在producer这边随意发送消息,都可以在consumer那边接收到并输出:

![效果图](PixPin_2026-07-27_10-52-43.webp)

效果很不错!

- 上述命令中的第一行完全相同,因为都要用到kafka随安装自带的CLI工具.
## 生产者
首先配置`bootstrap.servers`等参数来初始化Producer,接着构建一个ProducerRecord对象,该对象对应所有kafka能发送的信息(纯文本,Json字符串,key-value对,数据表),最终由producer发送给kafka的client.
## 消费者
>消费者数量超过topic中的分区数量是毫无意义的——部分消费者将处于空闲状态

![示意图](PixPin_2026-07-29_10-10-08.webp)

创建消费者的过程与创建生产者没有太大的区别,同样需要先配置servers等属性,并分配特定的消费者组id,再通过订阅(subscribe)方法来接受特定的topic下的消息.

## 总结
了解到这里就基本足够了,后面就是一些琐碎的配置环节了.

# Python3网络爬虫开发实战
## 爬虫基础
讲的还不错,基本涉及了爬虫所需的所有知识,尤其是关于session,cookie的地方讲的很好,帮我扫清了一点疑惑


## 数据的存储
### Elasticsearch
- 这部分的简短介绍比官网讲的好得多

Elasticsearch是使用Lucene作为底层引擎的开源搜索引擎.
- Es本质上是一个分布式数据库,每台服务器可以运行多个Es实例,一个实例被称为一个节点(Node),一组节点构成一个集群
- Es会索引所有的字段,根据索引来查找数据,所以Es管理的顶层单位就是索引,对应MySQL中数据库的概念,索引的名字必须小写
- 索引中的单条记录称为文档(document)
- ~~文档可以进行分组,这种分组被称为类型(type),用于过滤文档,~~,已在8.x版本后被废除
- 每个文档都类似一个Json结构,与MongoDB中的结构非常相似.

这么来看,Es展现出来的确实就是一个数据库而已.
### RabbitMQ
>爬取数据时,我们需要用到一些进程间的通信机制,例如一个进程负责构造爬取请求,另一个负责执行爬取请求,或者一个进程爬取完毕后通知另一个进程来处理数据,尽管yield,async,await等关键字能够解决部分的问题,但用起来还是不太顺手

这就是我们要用到消息队列的地方了,RabbitMQ则是其中的代表框架.



## 异步爬虫
- 前面的概念辨析很有看头
## 总结
尽管确实很全面,奈何讲解都简单的过分了,不够深入,基本都是依靠框架来实现爬虫的.但还是为数不多的爬虫好书.

# RabbitMQ in Depth
该说是太老了还是怎么呢,讲的一点都不清晰,看了两章都没看明白RabbitMQ的基本原理

# Learning Go
## ch1: 搭建环境
```bash
# 创建go模块
go mod init hello_word
# 编译go程序
go build hello.go
# 格式化go程序,应用于当前目录及所有子目录
go fmt ./...
```
### 使用make
```makefile
.DEFAULT_GOAL := build
.PHONY:fmt vet build
fmt:
	go fmt ./...
vet: fmt 
	go vet ./...
build: vet
	go build
```
在终端敲上`make`这个单词就可以自动运行build命令了.

## ch2: 类型和声明
### 字符串
>Go 语言中的字符串是不可变的；你可以重新赋值给一个字符串变量，但你不能改变赋值给它的字符串的值。
### 变量声明

如果有初始化值,Go中的var声明都可以省略类型:
```go
var x = 10
var x, y int = 10, 20
var x, y = 10, "hello"
var x int
// 如果不写初始化值则构造为零值
```


另一个则是只能写在函数中作为局部变量声明的`:=`,同样不用指定类型:
```go
var x, y = 10, "hello"
x, y := 10, "hello"
```

Go中的const声明如下:
```go
const x int64 = 10
const (
    idKey = "id"
    nameKey = "name"
)
const z = 20 * 10
```
其中第二种声明方式显然比较有特色

## ch3: 复合类型
### 数组
```go
var x [3]int
var x = [3]int{10, 20, 30}
var x = [...]int{10, 20, 30} //自动推断长度
```
>Go 语言中的数组很少被显式使用。这是因为它们有一个特殊的限制：Go 将数组的大小视为数组类型的一部分。这使得声明为[3]int 的数组与声明为 [4]int 的数组类型不同
### 切片
切片的用法与数组类似,但声明时不用指定数组大小:
```go
var x = []int{10, 20, 30}
```
#### make内置函数
指定切片类型,零值数量,总容量.
```go
x := make([]int, 5,10)
```
#### 从数组/切片中创建切片
```go
x := []string{"a", "b", "c", "d"}
y := x[:2]
z := x[1:]
d := x[1:3]
e := x[:]
fmt.Println("x:", x)
fmt.Println("y:", y)
fmt.Println("z:", z)
fmt.Println("d:", d)
fmt.Println("e:", e)
```
依然遵循前闭后开的准则.

切片彼此之间是相互引用的,修改一个切片会影响到其他相同位置的切片.

```go
xArray := [4]int{5, 6, 7, 8}
xSlice := xArray[:]
```
数组转换成切片.

```go
xSlice := []int{1, 2, 3, 4}
xArray := [4]int(xSlice)
smallArray := [2]int(xSlice)
xSlice[0] = 10
```
切片转换成数组.


#### copy内置函数
```go
x := []int{1, 2, 3, 4}
y := make([]int, 4)
num := copy(y, x)
fmt.Println(y, num)
```
copy函数可以创建一个独立于原始切片的切片.

### Maps
#### 声明与创建
普通的声明方式如下,`[]`中写key,后面跟着任何可映射的value类型:
```go
var nilMap map[string]int
totalWins := map[string]int{}
```

通用的make函数声明:
```go
ages := make(map[int][]string, 10)
```
#### 访问Map
```go
m := map[string]int{
    "hello": 5,
    "world": 0,
}
v, ok := m["hello"]
fmt.Println(v, ok)
v, ok = m["world"]
fmt.Println(v, ok)
v, ok = m["goodbye"]
fmt.Println(v, ok)
```
可以看到,Map访问内置了异常处理,还是很方便的.

### Structs
#### 声明
```go
type person struct {
    name string
    age int
    pet string
}
```
Go中的结构体不支持默认值,只有零值.

对于结构体来说,赋值一个空结构体字面量和完全不赋值之间没有区别,都会将所有字段初始化为零值:
```go
var fred person

bob := person{}
```

和python一样,go支持指名赋值或者按照成员声明的顺序来进行不指名赋值.


#### 匿名结构体
```go
var person struct {
	name string
	age  int
	pet  string
}

person.name = "bob"
person.age = 50
person.pet = "dog"

pet := struct {
	name string
	kind string
}{
	name: "Fido",
	kind: "dog",
}
```
pet还比较好理解,是一个经典的匿名结构体,在声明后立即使用.但person就比较神奇了,原来的`type person struct`变成了`var person struct`,然后就同时完成了类型声明和初始化变量两件事情.

匿名结构体显然是那种只会用到一两次的数据仓库.
## ch4: 逻辑结构
### if
```go
if n := rand.Intn(10); n == 0 {
    fmt.Println("That's too low")
} else if n > 5 {
    fmt.Println("That's too big:", n)
} else {
    fmt.Println("That's a good number:", n)
}
```
Go中的if语句可以定义存活到else语句结束时的变量,很容易用在那些当属性名称太长时的简写.

### for
Go中的for有四种形式:
- A complete, C-style `for`
- A condition-only `for`
- An infinite `for`
- `for-range`
```go
package main

import "fmt"

func main() {
	// 一、完整的、C 风格的 for (A complete, C-style for)
	// 包含初始化语句、条件表达式和后置语句
	fmt.Println("--- 一、完整的、C 风格的 for ---")
	for i := 0; i < 3; i++ {
		fmt.Println("C-style:", i)
	}

	// 二、仅限条件的 for (A condition-only for)
	// 只有条件表达式，相当于其他语言中的 while
	fmt.Println("--- 二、仅限条件的 for ---")
	j := 0
	for j < 3 {
		fmt.Println("Condition-only:", j)
		j++
	}

	// 三、无限的 for (An infinite for)
	// 没有条件表达式，如果不使用 break 跳出，会一直循环
	fmt.Println("--- 三、无限的 for ---")
	count := 0
	for {
		fmt.Println("Infinite:", count)
		count++
		if count >= 3 {
			break // 必须使用 break 跳出循环，否则会造成死循环
		}
	}

	// 四、for-range
	// 用于遍历数组、切片、字符串、map 或 channel
	fmt.Println("--- 四、for-range ---")
	nums := []int{10, 20, 30}
	for index, value := range nums {
		fmt.Printf("Index: %d, Value: %d\n", index, value)
	}
}
```

>需要注意的是，每次 `for-range` 循环遍历复合类型时，它都会将复合类型的值复制到 value 变量中。修改 value 变量不会修改复合类型的值

如果要修改原复合类型,就必须要通过下标来处理:
```go
for i := range nums {
    nums[i] *= 10
}


m := map[string]User{
    "tom": {"Tom", 18},
}

for key, user := range m {
    user.Age++
    m[key] = user
}
```
## ch5: 函数
### 基本形式
在Go中,你必须为函数提供所有参数,并不存在命名参数和可选参数,如果参数过多,可以包裹在一个结构体里面再传入:
```go
func DefaultConfig() Config {
    return Config{
        Host:    "localhost",
        Port:    8080,
        Timeout: 30,
    }
}

func NewServer(cfg Config) *Server {
    // ...
}
```

但Go支持可变参数,也就是说可以传入任意数量的参数:
```go
func addTo(base int, vals ...int) []int {
	out := make([]int, 0, len(vals))
	for _, v := range vals {
		out = append(out, base+v)
	}
	return out
}

func main() {
	fmt.Println(addTo(3))
	fmt.Println(addTo(3, 2))
	fmt.Println(addTo(3, 2, 4, 6, 8))
	a := []int{4, 3}
	fmt.Println(addTo(3, a...))
	fmt.Println(addTo(3, []int{1, 2, 3, 4, 5}...))
}
```

Go的另一个独特之处就是支持多个返回值:
```go
func divAndRemainder(num, denom int) (int, int, error) {
	if denom == 0 {
		return 0, 0, errors.New("cannot divide by zero")
	}
	return num / denom, num % denom, nil
}
```
接受变量需要与返回值的数量一一对应,如果有不需要的值,则用`_`表示,如` result, _, err := divAndRemainder(5, 2)`

Go还支持对返回值命名:
```go
func divAndRemainder(num, denom int) (result int, remainder int, err error) {
	if denom == 0 {
		err = errors.New("cannot divide by zero")
		return result, remainder, err
	}
	result, remainder = num/denom, num%denom
	return result, remainder, err
}
```
>命名的返回值在创建时会被初始化为零。这意味着你可以在任何显式使用或赋值之前直接返回它们。


### 函数也是值
我们可以声明一个函数变量:
```go
var myFuncVariable func(string) int
```

```go
func f1(a string) int {
	return len(a)
}

func f2(a string) int {
	total := 0
	for _, v := range a {
		total += int(v)
	}
	return total
}

func main() {
	var myFuncVariable func(string) int
	myFuncVariable = f1
	result := myFuncVariable("Hello")
	fmt.Println(result)

	myFuncVariable = f2
	result = myFuncVariable("Hello")
	fmt.Println(result)
}
```

我们还可以声明函数的类型:
```go
type opFuncType func(int,int) int
```

Go还支持匿名函数:

```go
func main() {
	f := func(j int) {
		fmt.Println("printing", j, "from inside of an anonymous function")
	}
	for i := 0; i < 5; i++ {
		f(i)
	}
}
```
甚至还能在声明时直接调用:
```go
func main() {
	for i := 0; i < 5; i++ {
		func(j int) {
			fmt.Println("printing", j, "from inside of an anonymous function")
		}(i)
	}
}
```
- 非常不推荐好吧,太不清晰了

### 闭包
在函数内部声明的函数被称为闭包:
```go
func main() {
	a := 20
	f := func() {
		fmt.Println(a)
		a = 30
	}
	f()
	fmt.Println(a)
}
// 20
// 30
```

甚至还能将函数作为返回值:
```go
func makeMult(base int) func(int) int {
	return func(factor int) int {
		return base * factor
	}
}

func main() {
	twoBase := makeMult(2)
	threeBase := makeMult(3)
	for i := 0; i < 3; i++ {
		fmt.Println(twoBase(i), threeBase(i))
	}
}
```
### defer
```go
f, err := os.Open(os.Args[1])
if err != nil {
    log.Fatal(err)
}

defer f.Close() // 现在不关闭，只登记：main 退出前关闭

data := make([]byte, 2048)

for {
    count, err := f.Read(data) // 此时文件仍然是打开的
    os.Stdout.Write(data[:count])

    if err != nil {
        if err != io.EOF {
            log.Fatal(err)
        }
        break
    }
}

// 到这里 main 准备结束
// 才自动执行 f.Close()
```
defer的函数直到作用域结束时才开始执行,是按照栈的顺序推入的,遵循先进先出的规则.

尽管可以用在方法调用中,但defer最常用的方式是写成匿名函数的形式:
```go
defer func() {
    f.Close()
    fmt.Println("file closed")
}()
```
### 按值传递
Go中的函数参数在一般情况下都是复制进去的,也就是说不会改变原变量的值,除非是指针类型.如Map和Slice.
## ch6: 指针
### 介绍
```go
var x int32 = 10
var y bool = true
pointerX := &x
pointerY := &y
var pointerZ *string
```
>虽然不同类型的变量占用的内存空间数量可能不同，但每个指针，无论指向什么类型，始终占用相同数量的内存空间。

>指针的零值是 nil 。你之前已经见过 nil 几次了，它代表切片、映射和函数的零值。所有这些类型都是用指针实现的

内置函数 new 创建一个指针变量。它返回指向所提供类型的零值实例的指针：
```go
var x = new(int)
fmt.Println(x == nil) // prints false
fmt.Println(*x)
 // prints 0
```

在 Java、Python、JavaScript 和 Ruby 中,int,string等普通的变量类型在使用`y=x`复制时是直接拷贝的,二者互不相关,而类的传参是通过指针进行的,在函数内部写`student.score=100`是真的会影响到原`student`类的,当你重新给这个类初始化,只会改变函数内部的参数变量,外部的类不受影响.

```go
func failedUpdate(px *int) {
	x2 := 20
	px = &x2
}

func update(px *int) {
	*px = 20
}

func main() {
	x := 10
	failedUpdate(&x)
	fmt.Println(x) // prints 10
	update(&x)
	fmt.Println(x) // prints 20
}
```
问题在于,当你直接传入指针时,是直接复制地址进去的,想要修改该地址对应的变量,就要通过解引用符明确指向它,否则就只是在函数内部修改而已.
### 糟糕的设计
```go
func MakeFoo(f *Foo) error {
    f.Field1 = "val"
    f.Field2 = 20
    return nil
}
```
由于Go会自动解引用,上述代码等价于:
```go
func MakeFoo(f *Foo) error {
    (*f).Field1 = "val"
    (*f).Field2 = 20
    return nil
}
```
要我说,不如把`->`还回来算了,自动解引用反而让我看的很难受.

### slice和map
![切片传值](PixPin_2026-09-22_08-45-47.webp)

切片同样是指针传值,但对副本所做以下操作不会对原切片造成更改:
1. append追加数据
2. append追加数据导致副本扩容,此时副本的指针将会与原切片分离:

![示意图](PixPin_2026-09-22_08-49-11.webp)


而将map传递给函数实际上就是复制一个指针,但由于我们不知道map的具体key有哪些,所以唯一了解键值的方法就是追踪代码,这样来看,远不如直接传入一个结构体.

### Go的设计
>要在栈上存储数据，必须在编译时精确知道它的大小。Go 语言中的值类型（基本类型、数组和结构体）都有一个共同点：它们在编译时占用的内存大小是已知的。这就是为什么数组的大小被视为类型的一部分。由于数组的大小已知，因此可以将其分配到栈上而不是堆上。指针类型的大小也是已知的，并且也存储在栈上。

而对于指针指向的堆类型数据,必须要经过垃圾回收处理,所以会降低不少性能.

在 Java 中，局部变量和参数都存储在栈上，就像 Go 一样。然而，正如前面讨论的，Java 中的对象是以指针的形式实现的。对于每个对象变量实例，只有指向它的指针会被分配到栈上；对象内部的数据则被分配到堆上。只有基本类型（数字、布尔值和字符）才会完全存储在栈上。这意味着 Java 中的垃圾回收器需要执行大量的工作

## ch7: 类型,方法与接口
### Type
Go支持在任何代码块级别声明自定义的类型:
```go
type Score int
type Converter func(string)Score
type TeamScores map[string]Score
```
### Methods
方法声明在函数名之前多了一个receiver specification,用于标明这是该类型的方法:
```go
type Person struct {
	FirstName string
	LastName  string
	Age       int
}

func (p Person) String() string {
	return fmt.Sprintf("%s %s, age %d",
p.FirstName, p.LastName, p.Age)
}

p := Person{
	FirstName: "Fred",
	LastName:  "Fredson",
	Age:       52,
}
output := p.String()
```
>声明方法和声明函数之间有一个关键区别：方法只能在包块级别定义，而函数可以在任何块内定义。


如果要修改结构体内部,就必须通过指针传值:
```go
type Counter struct {
	total       int
	lastUpdated time.Time
}

func (c *Counter) Increment() {
	c.total++
	c.lastUpdated = time.Now()
}

func (c Counter) String() string {
	return fmt.Sprintf("total: %d, last updated: %v", c.total, c.lastUpdated)
}

var c Counter
fmt.Println(c.String())
c.Increment()
fmt.Println(c.String())
```
在本例中， c.Increment() 被转换为 (&c).Increment() 。

而在下面这个例子中, c.String() 被静默地转换为 (*c).String() 。:
```go
c := &Counter{}
fmt.Println(c.String())
c.Increment()
fmt.Println(c.String())
```

也就是说不用像Cpp那样总要显式写明了,但对于习惯Cpp写法的人来说终归是比较别扭的.




### 方法也是值
```go
myAdder := Adder{start: 10}
fmt.Println(myAdder.AddTo(5)) // prints 15
f1 := myAdder.AddTo
fmt.Println(f1(10))
 // prints 20
```
还可以从类型本身创建函数,这被称为方法表达式:
```go
f2 := Adder.AddTo
fmt.Println(f2(myAdder, 15))
// prints 25
```

### iota Is for Enumerations—Sometimes
许多编程语言都有枚举的概念，允许你指定某种类型只能拥有有限的值。Go 语言没有枚举类型，而是使用了 iota ，允许你为一组常量赋值，且值递增。

```go
type MailCategory int

const (
    Uncategorized MailCategory = iota
    Personal
    Spam
    Social
    Advertisements
)
```
> iota 的值会随着 const 代码块中定义的每个常量递增，从0 开始。这意味着 0 被赋值给第一个常量 (Uncategorized )，1 被赋值给第二个常量 (Personal)，依此类推

### Embedding(嵌入)
Go中没有继承机制,只能通过嵌入(将要"继承"的结构体直接放进内部字段)来间接实现:
```go
package main

import "fmt"

type Animal struct {
	Name string
}

func (a Animal) Eat() {
	fmt.Println(a.Name, "is eating")
}

type Dog struct {
	Animal // 嵌入 Animal
	Breed string
}

func main() {
	dog := Dog{
		Animal: Animal{Name: "旺财"},
		Breed:  "柴犬",
	}

	fmt.Println(dog.Name) // 可以直接访问 Animal.Name
	dog.Eat()             // 可以直接调用 Animal.Eat()
}
```
### Interfaces


# Redis设计与实现
- 本书基于Redis 2.9(Redis 3.0开发版)编写,而现在已经更新到8.10版本了,不过仍然值得一读
## 数据结构与对象
### simple dynamic string，SDS
>Redis没有直接使用C语言传统的字符串表示（以空字符结尾的字符数组，以下简称C字符串），而是自己构建了一种名为简单动态字符串（simple dynamic string，SDS）的抽象类型，并将SDS用作Redis的默认字符串表示。

主要原因自然是C字符串本身的问题,如字符串拼接函数`strcat`不会自动扩容,C字符串默认以`./0`结尾,并不会记录自身的长度,而是需要程序员自己控制.

格式如下:
![格式图](PixPin_2026-09-13_12-38-08.webp)

- len记载占用空间,free记载剩余空间,通过结构体实现
### 链表
Redis中的链表设计如下:
* 双端：链表节点带有 `prev` 和 `next` 指针，获取某个节点的前置节点和后置节点的复杂度都是 O(1)。

* 无环：表头节点的 `prev` 指针和表尾节点的 `next` 指针都指向 `NULL`，对链表的访问以 `NULL` 为终点。

* 带表头指针和表尾指针：通过 `list` 结构的 `head` 指针和 `tail` 指针，程序获取链表的表头节点和表尾节点的复杂度为 O(1)。

* 带链表长度计数器：程序使用 `list` 结构的 `len` 属性来对 `list` 持有的链表节点进行计数，程序获取链表中节点数量的复杂度为 O(1)。

* 多态：链表节点使用 `void*` 指针来保存节点值，并且可以通过 `list` 结构的 `dup`、`free`、`match` 三个属性为节点值设置类型特定函数，所以链表可以用于保存各种不同类型的值。

### 字典
>字典在Redis中的应用相当广泛，比如Redis的数据库就是使用字典来作为底层实现的，对数据库的增、删、查、改操作也是构建在对字典的操作之上的。
#### 哈希表
Redis的字典使用哈希表实现:
```c
typedef struct dictht {
    // 哈希表数组
    dictEntry **table;//指针数组

    // 哈希表大小
    unsigned long size;

    // 哈希表大小掩码，用于计算索引值
    // 总是等于 size - 1
    unsigned long sizemask;

    // 该哈希表已有节点的数量
    unsigned long used;
} dictht;
```
具体的单节点结构如下:
```c
typedef struct dictEntry {
    // 键
    void *key;

    // 值
    union {
        void *val;
        uint64_t u64;
        int64_t s64;
    } v;

    // 指向下一个哈希表节点，形成链表
    struct dictEntry *next;
} dictEntry;
```
- 这里的union非常有意思,完美解决了节点的替换问题.

#### 哈希算法
Redis计算哈希值和索引值的方法如下：
```c
// 使用字典设置的哈希函数，计算键 key 的哈希值
hash = dict->type->hashFunction(key);

// 使用哈希表的 sizemask 属性和哈希值，计算出索引值
// 根据情况不同，ht[x] 可以是 ht[0] 或者 ht[1]
index = hash & dict->ht[x].sizemask;
```
hashFunction用的算法是MurmurHash2算法,而现在用的则是SipHash算法
#### 哈希冲突
发生哈希冲突时,由于没有指向尾部的指针,所以Redis会将新节点放在链表的头部
#### rehash
当哈希冲突过多/加入节点过多时,Redis会自动执行Rehash来渐进式地扩展哈希表,详细步骤如下:
1. 为 `ht[1]` 分配空间，让字典同时持有 `ht[0]` 和 `ht[1]` 两个哈希表。

2. 在字典中维持一个索引计数器变量 `rehashidx`，并将它的值设置为 `0`，表示 rehash 工作正式开始。

3. 在 rehash 进行期间，每次对字典执行添加、删除、查找或者更新操作时，程序除了执行指定的操作以外，还会顺带将 `ht[0]` 哈希表在 `rehashidx` 索引上的所有键值对 rehash 到 `ht[1]`。当 rehash 工作完成之后，程序将 `rehashidx` 属性的值增一。

4. 随着字典操作的不断执行，最终在某个时间点上，`ht[0]` 的所有键值对都会被 rehash 至 `ht[1]`。这时程序将 `rehashidx` 属性的值设为 `-1`，表示 rehash 操作已完成。

设计上确实很简单,但不是那么容易想得到的.
### 跳表
>和链表、字典等数据结构被广泛地应用在Redis内部不同，Redis只在两个地方用到了跳跃表，一个是实现有序集合键，另一个是在集群节点中用作内部数据结构，除此之外，跳跃表在Redis里面没有其他用途

- 我以前还以为Redis主要靠跳表呢,结果并没有我想的那么简单
### 整数集合
>整数集合（intset）是集合键的底层实现之一，当一个集合只包含整数值元素，并且这个集合的元素数量不多时，Redis就会使用整数集合作为集合键的底层实现。

基本原理就是把整数按照顺序放进一块连续内存中,所有元素的类型统一,有三种类型:
```text
INTSET_ENC_INT16
INTSET_ENC_INT32
INTSET_ENC_INT64
```
### 压缩列表
>压缩列表（ziplist）是列表键和哈希键的底层实现之一。当一个列表键只包含少量列表项，并且每个列表项要么就是小整数值，要么就是长度比较短的字符串，那么Redis就会使用压缩列表来做列表键的底层实现。

可以说只是一个优化过的链表而已.

### 对象
>在前面的数个章节里，我们陆续介绍了Redis用到的所有主要数据结构，比如简单动态字符串（SDS）、双端链表、字典、压缩列表、整数集合等等。
>
>Redis并没有直接使用这些数据结构来实现键值对数据库，而是基于这些数据结构创建了一个对象系统，这个系统包含字符串对象、列表对象、哈希对象、集合对象和有序集合对象这五种类型的对象，每种对象都用到了至少一种我们前面所介绍的数据结构。
#### 对象类型
Redis使用对象来表示数据库中的键和值，每次当我们在Redis的数据库中新创建一个键值对时，我们至少会创建两个对象，一个对象用作键值对的键（键对象），另一个对象用作键值对的值（值对象）。

经典的5个对象类型如下:

| 类型常量       | 对象的名称   |
| -------------- | ------------ |
| `REDIS_STRING` | 字符串对象   |
| `REDIS_LIST`   | 列表对象     |
| `REDIS_HASH`   | 哈希对象     |
| `REDIS_SET`    | 集合对象     |
| `REDIS_ZSET`   | 有序集合对象 |

>对于Redis数据库保存的键值对来说，键总是一个字符串对象，而值则可以是字符串对象、列表对象、哈希对象、集合对象或者有序集合对象的其中一种，
#### 字符串对象
字符串对象的编码可以是int、raw或者embstr,分别对应整数,长字符串,短于32字节的字符串
#### 列表对象
列表对象的编码可以是ziplist或者linkedlist,当列表中所有字符串元素的长度都小于64字节,且保存元素少于512个时,使用zpilist,否则就用linkedlist,二者的实现方式上有一点不同:

linkedlist是一个真正的双端列表,而ziplist中所有元素紧凑排列在一段连续内存中.



|     命令      | ziplist 编码的实现方法                                                                                                     | linkedlist 编码的实现方法                                                                                          |
| :-----------: | :------------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------------------------------- |
|  **`LPUSH`**  | 调用 `ziplistPush` 函数，将新元素推入到压缩列表的表头                                                                      | 调用 `listAddNodeHead` 函数，将新元素推入到双端链表的表头                                                          |
|  **`RPUSH`**  | 调用 `ziplistPush` 函数，将新元素推入到压缩列表的表尾                                                                      | 调用 `listAddNodeTail` 函数，将新元素推入到双端链表的表尾                                                          |
|  **`LPOP`**   | 调用 `ziplistIndex` 函数定位压缩列表的表头节点，在向用户返回节点所保存的元素之后，调用 `ziplistDelete` 函数删除表头节点    | 调用 `listFirst` 函数定位双端链表的表头节点，在向用户返回节点所保存的元素之后，调用 `listDelNode` 函数删除表头节点 |
|  **`RPOP`**   | 调用 `ziplistIndex` 函数定位压缩列表的表尾节点，在向用户返回节点所保存的元素之后，调用 `ziplistDelete` 函数删除表尾节点    | 调用 `listLast` 函数定位双端链表的表尾节点，在向用户返回节点所保存的元素之后，调用 `listDelNode` 函数删除表尾节点  |
| **`LINDEX`**  | 调用 `ziplistIndex` 函数定位压缩列表中的指定节点，然后返回节点所保存的元素                                                 | 调用 `listIndex` 函数定位双端链表中的指定节点，然后返回节点所保存的元素                                            |
|  **`LLEN`**   | 调用 `ziplistLen` 函数返回压缩列表的长度                                                                                   | 调用 `listLength` 函数返回双端链表的长度                                                                           |
| **`LINSERT`** | 插入新节点到压缩列表的表头或者表尾时，使用 `ziplistPush` 函数；插入新节点到压缩列表的其他位置时，使用 `ziplistInsert` 函数 | 调用 `listInsertNode` 函数，将新节点插入到双端链表的指定位置                                                       |


问了一下AI,现在list的主要实现变成了`quicklist`,是一个由多个`ziplist`组成的链表,这个设计确实很不错
#### 哈希对象
哈希对象的编码可以是ziplist或者hashtable。

如果使用ziplist,那么就满足以下性质:
- **保存了同一键值对的两个节点总是紧挨在一起**，保存键的节点在前，保存值的节点在后；
- **先添加到哈希对象中的键值对**会被放在压缩列表的表头方向，而**后来添加到哈希对象中的键值对**会被放在压缩列表的表尾方向。

这与列表其实没有任何区别,只不过存储的量多了一倍而已,同样,当所有元素的字符串长度小于64字节,键值对数量小于512时才会启用ziplist,否则使用hashtable.

hashtable使用前面所说的字典实现.
#### 集合对象
集合对象的编码可以是intset或者hashtable。同样也是根据元素数量来进行转换的.
#### 有序集合对象
有序集合的编码可以是ziplist或者skiplist。

如果是ziplist,每次插入都要重新排序,显然很地狱,所以只在元素数量小于128个,且所有成员长度小于64字节时才启用.

而skiplist编码的zset结构同时包含了一个字典和一个跳表,跳表负责将元素从小到大排列,用于存放数据,而哈希字典用于记录元素和分值(score)的映射,从而实现O(1)的查找.二者通过指针共享地址,所以不会浪费内存.

### 内存回收
由于C没有垃圾回收,所以Redis构建了一个引用计数的垃圾回收机制
## 单机数据库
### 数据库
Redis Server负责创建和管理Redis数据库,初始化Server时,默认会创建16个数据库.

Redis是一个键值对（key-value pair）数据库服务器，服务器中的每个数据库都由一个redis.h/redisDb结构表示，其中，redisDb结构的dict字典保存了数据库中的所有键值对，我们将这个字典称为键空间（key space）:

![结构图](PixPin_2026-09-21_10-12-01.webp)

我们还可以对key设置过期时间,如下方结构所示:
```text
dict
┌────────┬──────────────────┐
│ key    │ value            │
├────────┼──────────────────┤
│ user:1 │ HashObject       │
│ msg:1  │ StringObject     │
│ list:1 │ ListObject       │
└────────┴──────────────────┘

expires
┌────────┬──────────────────┐
│ key    │ expire time      │
├────────┼──────────────────┤
│ user:1 │ 1760000000000    │
│ msg:1  │ 1760000500000    │
└────────┴──────────────────┘
```
#### 删除机制
现在剩下的问题是：**如果一个键过期了，那么它什么时候会被删除呢？**

*   **定时删除**：在设置键的过期时间的同时，创建一个定时器（timer），让定时器在键的过期时间来临时，立即执行对键的删除操作。
*   **惰性删除**：放任键过期不管，但是每次从键空间中获取键时，都检查取得的键是否过期，如果过期的话，就删除该键；如果没有过期，就返回该键。
*   **定期删除**：每隔一段时间，程序就对数据库进行一次检查，删除里面的过期键。至于要删除多少过期键，以及要检查多少个数据库，则由算法决定。

在这三种策略中，第一种和第三种为**主动删除策略**，而第二种则为**被动删除策略**。

而Redis服务器实际使用的是惰性删除和定期删除两种策略

当服务器运行在复制模式下时，从服务器的过期键删除动作由主服务器控制：

*   主服务器在删除一个过期键之后，会显式地向所有从服务器发送一个DEL命令，告知从服务器删除这个过期键。
*   从服务器在执行客户端发送的读命令时，即使碰到过期键也不会将过期键删除，而是继续像处理未过期的键一样来处理过期键。
*   从服务器只有在接到主服务器发来的DEL命令之后，才会删除过期键。

通过由主服务器来控制从服务器统一地删除过期键，可以保证主从服务器数据的一致性，也正是因为这个原因，当一个过期键仍然存在于主服务器的数据库时，这个过期键在从服务器里的复制品也会继续存在。

### RDB(Redis DataBase)持久化
因为Redis是内存数据库，它将自己的数据库状态储存在内存里面，所以如果不想办法将储存在内存中的数据库状态保存到磁盘里面，那么一旦服务器进程退出，服务器中的数据库状态也会消失不见。

为了解决这个问题，Redis提供了RDB持久化功能，这个功能可以将Redis在内存中的数据库状态保存到磁盘里面，避免数据意外丢失,RDB持久化既可以手动执行，也可以根据服务器配置选项定期执行，该功能可以将某个时间点上的数据库状态保存到一个RDB文件中,这是一个经过压缩的二进制文件,可以还原生成RDB文件时的数据库状态
#### 创建与载入RDB文件
有两个Redis命令可以用于生成RDB文件，一个是SAVE，另一个是BGSAVE。

SAVE命令会阻塞Redis服务器进程，直到RDB文件创建完毕为止，在服务器进程阻塞期间，服务器不能处理任何命令请求,即便是主从服务器部署,这么做也是不太合理的.

而BGSAVE命令会派生出一个子进程,由子进程负责创建RDB文件,服务器进程继续处理请求.

而RDB文件的载入是在服务器启动时自动执行的,不需要我们额外输入命令:
```bash
$ redis-server
[7379] 30 Aug 21:07:01.270 # Server started, Redis version 2.9.11
[7379] 30 Aug 21:07:01.289 * DB loaded from disk: 0.018 seconds
[7379] 30 Aug 21:07:01.289 * The server is now ready to accept connections on port 6379
```

另外值得一提的是，因为AOF文件的更新频率通常比RDB文件的更新频率高，所以：
- 如果服务器开启了AOF持久化功能，那么服务器会优先使用AOF文件来还原数据库状态。
- 只有在AOF持久化功能处于关闭状态时，服务器才会使用RDB文件来还原数据库状态。

因为BGSAVE命令可以在不阻塞服务器进程的情况下执行，所以Redis允许用户通过设置服务器配置的save选项，让服务器每隔一段时间自动执行一次BGSAVE命令。

举个例子，如果我们向服务器提供以下配置：
```bash
save 900 1
save 300 10
save 60 10000
```

那么只要满足以下三个条件中的任意一个，BGSAVE命令就会被执行：
-  服务器在900秒之内，对数据库进行了至少1次修改。
-  服务器在300秒之内，对数据库进行了至少10次修改。
-  服务器在60秒之内，对数据库进行了至少10000次修改。

#### RDB文件结构
![文件结构](PixPin_2026-09-22_09-23-40.webp)

**databases 部分**包含着零个或任意多个数据库，以及各个数据库中的键值对数据：

- 如果服务器的数据库状态为空（所有数据库都是空的），那么这个部分也为空，长度为 0 字节。
- 如果服务器的数据库状态为非空（有至少一个数据库非空），那么这个部分也为非空，根据数据库所保存键值对的数量、类型和内容不同，这个部分的长度也会有所不同。

**EOF 常量**的长度为 1 字节，这个常量标志着 RDB 文件正文内容的结束，当读入程序遇到这个值的时候，它知道所有数据库的所有键值对都已经载入完毕了。

**check_sum** 是一个 8 字节长的无符号整数，保存着一个校验和，这个校验和是程序通过对 `REDIS`、`db_version`、`databases`、`EOF` 四个部分的内容进行计算得出的。服务器在载入 RDB 文件时，会将载入数据所计算出的校验和与 `check_sum` 所记录的校验和进行对比，以此来检查 RDB 文件是否有出错或者损坏的情况出现。

每个非空数据库在RDB文件中都可以保存为SELECTDB、db_number、key_value_pairs三个部分:

![示意图](PixPin_2026-09-22_09-25-45.webp)

**SELECTDB 常量**的长度为 1 字节，当读入程序遇到这个值的时候，它知道接下来要读入的将是一个数据库号码。

**db_number** 保存着一个数据库号码，根据号码的大小不同，这个部分的长度可以是 1 字节、2 字节或者 5 字节。当程序读入 `db_number` 部分之后，服务器会调用 `SELECT` 命令，根据读入的数据库号码进行数据库切换，使得之后读入的键值对可以载入到正确的数据库中。

**key_value_pairs** 部分保存了数据库中的**所有**键值对数据，如果键值对带有过期时间，那么过期时间也会和键值对保存在一起。根据键值对的数量、类型、内容以及是否有过期时间等条件的不同，`key_value_pairs` 部分的长度也会有所不同。

由此来看,Redis只适合存放那种比较小和短的数据,否则RDB文件的大小会非常惊人.而且在现代生产环境里，只使用 DB 0 是非常常见、也通常更推荐的做法,所以不用担心多个数据库的RDB叠加起来的超大内存占用.
### AOF(Append Only File)持久化
>与RDB持久化通过保存数据库中的键值对来记录数
据库状态不同，AOF持久化是通过保存Redis服务器所执行的写命令来记录数据库状态的:
![示意图](PixPin_2026-09-23_10-15-37.webp)

因为Redis的命令请求协议是纯文本格式，所以我们可以直接打开一个AOF文件，观察里面的内容,例如先执行这三个命令:
```bash
redis> SET msg "hello"
OK
redis> SADD fruits "apple" "banana" "cherry"
(integer) 3
redis> RPUSH numbers 128 256 512
(integer) 3
```
然后查看AOF:
```bash
*2\r\n$6\r\nSELECT\r\n$1\r\n0\r\n
*3\r\n$3\r\nSET\r\n$3\r\nmsg\r\n$5\r\nhello\r\n
*5\r\n$4\r\nSADD\r\n$6\r\nfruits\r\n$5\r\napple\r\n$6\r\nbanana\r\n$6\r\ncherry\r\n
*5\r\n$5\r\nRPUSH\r\n$7\r\nnumbers\r\n$3\r\n128\r\n$3\r\n256\r\n$3\r\n512\r\n
```

>Redis的服务器进程就是一个事件循环（loop），这个循环中的文件事件负责接收客户端的命令请求，以及向客户端发送命令回复，而时间事件则负责执行像serverCron函数这样需要定时运行的函数,如此一来,每次loop结束后,都需要调用AOF相关的函数,考虑是否将缓冲区中的命令写入和保存到AOF文件中

### 事件
# RAG with Python Cookbook
- 原来学不会RAG不是我的问题,只是其他的教材太烂了
## RAG介绍
| RAG 拟合度 | 用例                                              | 适配理由                                                                                                                         |
| ---------: | ------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
|      **1** | 我想和我的季度报告聊聊                            | 只有单份文档，数据量较小。直接阅读或使用 ChatGPT、Claude 等通用大模型即可完成，自建 RAG 的收益很低。                             |
|      **2** | 请帮我总结这一份文档                              | 通用大模型已经能够较好地完成单文档总结任务，引入 RAG 通常不会带来明显额外价值。                                                  |
|      **2** | 自动执行需要作出高风险决策的任务                  | 技术上可以实现，但大模型仍可能出错。若缺少人工审核、审计机制和故障保护等措施，风险较高，因此不适合单纯依赖 RAG 自动完成。        |
|      **4** | 大量会议录音不断积累，但其中的信息无法进入知识库  | RAG 可以将音频、视频、长篇非结构化笔记等难以检索的信息转化为可搜索、可查询的知识，具有持续价值；最终效果会受到语音转录质量影响。 |
|      **4** | 将技术图纸与规格文档进行核对                      | 适合利用多模态模型结合 RAG 进行跨材料比对，可以减少大量人工核查工作；但需要完善的评估机制和异常处理流程。                        |
|      **5** | 有 1 万份合同，需要找出其中包含自动续约条款的合同 | 文档规模很大，人工逐份检查成本过高；任务目标明确，可以通过检索和信息提取定位相关合同，结果也容易人工验证。                       |
|      **5** | 客户支持工单中包含大量产品问题，但无法有效汇总    | RAG 适合跨大量文档检索、聚合和发现重复模式，可以从大量工单中识别共同问题及趋势，这是人工难以大规模完成的任务。                   |
|      **5** | 每天收到数百条客户咨询，需要自动分配给合适的团队  | 属于高频、重复的分类与路由任务，任务标准清晰，结果容易评估，并且可以通过自动化显著降低人工成本。                                 |

**核心判断原则：**RAG 的价值通常随着**数据量、跨文档检索需求、信息更新频率和人工处理成本**的增加而提高。对于单份、短小且可以直接放入大模型上下文的文档，通常没有必要专门构建 RAG 系统。

>当数据结构不规则且变化多端时，这种能力尤为重要。当每个输入略有不同但处理方式类似时，例如客户电子邮件、合同条款或事件报告，可以使用 RAG。不要将 RAG 用于简单的查找、固定格式的数据提取或基于不变规则的任务。如果您可以编写正则表达式（regex）或 SQL 查询来处理 95% 的情况，那么 RAG 只会增加不必要的复杂性和成本。

RAG常用的库和框架如下:
| 类别                              | 示例库                                                                          | 主要作用                                                                                                                        |
| --------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| **RAG 与代理式 RAG 编排**         | LangChain、LangGraph、LlamaIndex                                                | 将检索器、生成器、提示词、记忆等常见 RAG 组件封装为统一抽象，并负责连接向量数据库、LLM 和传统数据库，使开发者更专注于业务逻辑。 |
| **大语言模型与嵌入模型**          | OpenAI、Anthropic、Transformers、Sentence Transformers                          | 为 RAG 系统提供核心智能能力，用于理解用户查询、生成向量嵌入以及生成最终回答。                                                   |
| **向量存储**                      | Chroma、FAISS、Pinecone、Milvus、Weaviate                                       | 存储和检索向量嵌入，通过相似度搜索快速找到与用户查询相关的内容。                                                                |
| **数据处理**                      | pandas、NumPy、PyPDF2、pypdf、python-docx、Unstructured、openpyxl、scikit-learn | 用于数据处理、文件读取、清洗和预处理，在文档进入 RAG 系统之前将原始数据转换为可处理的形式。                                     |
| **多模态与媒体处理**              | Pillow、Pytesseract、MoviePy、pdf2image、OpenCV                                 | 用于加载和处理图片、视频、播客、PDF、Word、PowerPoint 等不同媒体和文件格式。                                                    |
| **文本处理与自然语言处理（NLP）** | NLTK、Transformers、Rank-BM25、Beautiful Soup 4                                 | 用于文本清洗、分词、关键词检索、传统 NLP 分析等任务，避免所有文本处理步骤都依赖大语言模型。                                     |
| **评估与监控**                    | Ragas、Phoenix、LangSmith、Prometheus-Eval                                      | 提供预定义的评估指标，用于衡量检索器、生成器以及整个 RAG 应用的准确性、质量和运行表现。                                         |
| **Web 框架与部署**                | Streamlit、Gradio、Flask、Django                                                | 用于构建 RAG 应用的用户界面和 Web 服务。其中 Streamlit、Gradio 更适合快速原型，Flask、Django 更适合完整应用开发。               |
| **数据库与存储**                  | SQLAlchemy、Psycopg 2、SQLite3                                                  | 用于连接传统 SQL 数据库，并通过数据库连接器或 ORM 将关系型数据作为 RAG 系统的数据来源。                                         |
## 基础模型
### Ollama
>Ollama 在http://localhost:11434/v1 公开了一个与 OpenAI 兼容的端点，因此您现有的代码几乎无需更改。

```py
from openai import OpenAI

# Point the client to your local Ollama server
client = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama",  # Ollama does not require a real key,
                       # but the SDK expects one
)

response = client.chat.completions.create(
    model="qwen3:4b",
    messages=[
        {"role": "system", "content": "You are a helpful assistant."},
        {
            "role": "user",
            "content": "What is retrieval augmented generation?"
        },
    ],
)

print(response.choices[0].message.content)
```
还可以试试选用多个模型:
```py
from openai import OpenAI

models = ["llama2", "mistral", "codellama"]

client = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama"
)

for model in models:
    print(f"\n--- Testing {model} ---")

    response = client.chat.completions.create(
        model=model,
        messages=[
            {"role": "user", "content": "Explain RAG in one sentence."}
        ]
    )

    print(response.choices[0].message.content)
```


> **将公开排行榜视为筛选工具，而非最终决策标准。常见的局限性包括以下几点：**
>
> **基准泄漏或数据污染**
> 一些基准测试题及答案是公开的，可能已被直接或间接包含在训练数据中，从而抬高模型分数。
>
> **古德哈特定律或过度优化**
> 一旦某个基准成为目标，模型开发者可能会专门针对该基准进行调整，从而提高分数，但并不会相应提高模型的通用能力。
>
> **与实际使用情况不符**
> 生产环境中的具体配置——包括提示模板、检索质量、工具使用、长上下文、多语言内容、量化方式以及延迟限制——都会显著影响最终结果。
> 因此，即使某个模型在公开排行榜上“胜出”，在你自己的 RAG 查询或真实业务场景中，也可能表现得更差。


### 图片解析
```py
from pydantic import BaseModel
from openai import OpenAI
import base64


class Invoice(BaseModel):
    invoice_number: str
    vendor: str
    total: float
    currency: str


client = OpenAI()

with open("invoice.png", "rb") as f:
    image_base64 = base64.b64encode(f.read()).decode("utf-8")

result = client.responses.parse(
    model="gpt-5-mini",
    input=[
        {
            "role": "user",
            "content": [
                {
                    "type": "input_text",
                    "text": "Extract the invoice data."
                },
                {
                    "type": "input_image",
                    "image_url": f"data:image/png;base64,{image_base64}"
                },
            ],
        }
    ],
    text_format=Invoice,
)
```

第一次知道API还可以定制返回模型,不过对话中是不需要的,工具调用时却很有必要
## 加载数据
![数据分布](PixPin_2026-09-19_13-31-13.webp)

大多数RAG 检索器都使用文本嵌入，因此，一个切实可行的第一步是将不同的格式转换为一致的文本表示形式

![架构图](PixPin_2026-09-19_13-31-57.webp)

>本书从零开始构建核心组件，以阐明其基本概念。在生产环境中，诸如 LangChain 或LlamaIndex 之类的编排框架可以加速开发，但它们也引入了频繁的破坏性变更、快速演进的 API 和额外的抽象等问题。

- 找了这么多书终于有个愿意认真做RAG的了.

### 加载Word
>当您不需要区分元素类型时，可以使用 python-docx 进行简单的文本提取。当您需要保留文档结构（标题、段落、列表、图像）以便对元素进行针对性处理时，请使用 Unstructured。

![基本流程](PixPin_2026-09-19_13-38-00.webp)

首先安装所需的库:
```bash
pip install python-docx unstructured pandas
```
#### python-docx
**示例代码**
```py
import os
from docx import Document

file_path = "./test.docx"

doc = Document(file_path)

text = []
for paragraph in doc.paragraphs:
    text.append(paragraph.text)

full_text = "\n".join(text)

print(full_text)
```
运行代码,效果确实可以:
![效果图](PixPin_2026-09-19_13-42-08.webp)

尽管代码中将所有的结构信息都被除去,只剩下了文本信息,但是原本的`python-docx`库肯定不止这点功能.

看一下[官网](https://python-docx.readthedocs.io/en/latest/user/quickstart.html),发现这个库反而主要是用来生成和加工docx的,单纯提取docx反而是一个比较边角料的功能.

>`.docx` 不是一个二进制 Word 文件，而本质上是一个 ZIP 压缩包，内部包含大量 XML、图片和关系文件。

如:
```text
test.docx
│
├── [Content_Types].xml
├── _rels/
├── docProps/
│   ├── core.xml
│   └── app.xml
│
└── word/
    ├── document.xml 放置正文
    ├── styles.xml
    ├── settings.xml
    ├── numbering.xml
    ├── comments.xml
    ├── header1.xml
    ├── footer1.xml
    ├── media/
    │   ├── image1.png
    │   └── image2.jpeg
    └── _rels/
```

不过对于做RAG来说,确实文本信息就已经足够了...


#### unstructured
unstructured库更多的像是一个集成库,可以支持多种文档,先看看示例代码:

```py
from unstructured.partition.docx import partition_docx

file_path = "./test.docx"
elements = partition_docx(filename=file_path)

list_of_elements = []

for element in elements:
    element_dict = {
        "element_id": element.id,
        "file_path": file_path,
        "category": element.category,
        # e.g., "Title", "NarrativeText", "ListItem"
        "text": element.text,
        "last_modified": element.metadata.last_modified,
    }

    list_of_elements.append(element_dict)


for v in list_of_elements:
    print(v, "\n")
```
![效果图](PixPin_2026-09-19_13-59-38.webp)

简单来说就是`python-docx`库的粒度太细了,毕竟RAG完全不需要docx的样式信息,像这样就刚刚好.

### 加载PDF
```py
from pathlib import Path

import pandas as pd
import PyPDF2

file_path = Path("./Vector Databases.pdf")
list_of_pages = []

with file_path.open("rb") as file:
    reader = PyPDF2.PdfReader(file)
    metadata = reader.metadata or {}

    for page_number, page in enumerate(reader.pages, start=1):
        page_dict = {
            "file_name": metadata.get("/Title") or file_path.name,
            "producer": metadata.get("/Producer"),
            "page_number": page_number,
            "text": page.extract_text() or "",
            "images": list(page.images),
        }

        list_of_pages.append(page_dict)

pages_df = pd.DataFrame(list_of_pages)

print(pages_df)
```
>PyPDF2 可以从包含可选择字符的文本的数字生成的 PDF 文件中提取文本。该库无法处理扫描的 PDF 文件或基于图像的文档，因为这些文档中的文本以像素而非字符的形式存在,那就只能用OCR了.
### 加载csv和excel
我们有三种方案:
1. 用openpyxl 库打开和加载 Excel 文件
2. 将表格转换成md并直接粘贴给AI,适用于数据量小的表格
3. 将表格转换成数据库存储,并使用SQL查询来实现RAG
### 加载音频
有了Whisper模型后,我们可以直接将音频转写为文本,如果需要质量更高的转写,就要用到一些API了.
### OCR
本教程使用的是开源OCR引擎Tesseract,不过也有其他替代品:

| 文档类型                                           | 体积           | 推荐方法                                                                            |
| :------------------------------------------------- | :------------- | :---------------------------------------------------------------------------------- |
| **纯文本 PDF**<br>普通文档、合同、书籍、文章       | < 1,000 份/月  | **OCR (Tesseract)**<br>快速、免费、本地运行                                         |
| **纯文本 PDF**<br>普通文档、合同、书籍、文章       | > 10,000 份/月 | **OCR (Tesseract 或 EasyOCR)**<br>大规模应用时具有成本效益                          |
| **混合内容**<br>文本 + 表格 + 图像                 | < 500 份/月    | **多模态模型** (GPT-5 mini, Claude Haiku, Gemini Flash)<br>单次处理，结果稳健       |
| **混合内容**<br>文本 + 表格 + 图像                 | > 5,000 份/月  | **混合方法**<br>首先对文档进行分类，对简单页面使用 OCR，对复杂页面使用多模态方法    |
| **复杂的版面设计**<br>技术图表、手写笔记、混合字体 | 任何体积       | **多模态模型** (GPT-5.2, Claude Sonnet, Gemini Pro)<br>在复杂文档上具有更高的准确率 |
| **敏感数据**<br>不能离开基础设施                   | 任何体积       | **OCR (开源)**<br>Tesseract, PaddleOCR, EasyOCR：完全控制，本地部署                 |
### 直接用API
调用多模态模型的API来直接处理图片和文档
## 嵌入(Embeddings)
### 相似度计算
余弦相似度衡量的是两个向量之间的角度，而不是它们的绝对距离。对于 RAG 系统而言，余弦相似度是首选的距离度量方法，因为它侧重于语义方向而非向量的大小.

这种对长度差异的鲁棒性至关重要，因为用户查询通常比检索到的文档短得多。如果没有进行归一化处理，较长的文档会因为篇幅较长而非相关性较高而主导排名。

### 嵌入模型选择
![大量模型](PixPin_2026-09-22_10-03-20.webp)

近年来，嵌入模型的发展速度不如语言学习模型（LLM）那么快。许多多年前构建的随机抽取（RAG）系统仍然使用 OpenAI 的 text-embedding-ada-002 模型，因为其精度对于检索任务来说仍然足够。这种稳定性意味着模型选择只需一次决策，很少需要重新调整


## 向量数据库
## Agentic RAG

## Graph RAG
![示意图](PixPin_2026-09-23_11-06-45.webp)

最常用的图数据库自然是Neo4j
### 补充: docker启动neo4j
```yml
services:
  neo4j:
    image: neo4j:5
    container_name: neo4j
    ports:
      - "7474:7474" # Web 管理界面
      - "7687:7687" # Bolt 协议，程序连接用
    environment:
      NEO4J_AUTH: neo4j/your_password
    volumes:
      - neo4j_data:/data
      - neo4j_logs:/logs

volumes:
  neo4j_data:
  neo4j_logs:
```
`NEO4J_AUTH: neo4j/your_password`字段分别对应账户名和密码

非常遗憾的是,这部分的叙述非常草率,所以只好我自己去看文档学习了
## 评估RAG系统
给了一些比较实用的判断RAG效果的方案
## 总结
干活确实很多,尤其是前几章,读起来很有收获.
# Vector Databases
## 介绍
### 相似性搜索
想象一下，你正在搜索一家公司的知识库，然后你输入“如何才能拿回我的钱？”接下来会发生什么？

1. keyword search: 系统对你的查询进行分词后直接搜索文档,但如果文档使用诸如`Refund policy`等相近的词则找不到答案
2. Semantic search: 系统会尝试理解用户输入,并匹配多种语义相近的结果

传统的关系型数据库和NoSQL数据库都无法很好的适应向量处理,而单纯的向量数据库(只存储向量)又丢失了查询的灵活性和存储效率,也不再具备索引功能,所以一个折衷的方式就是混合架构,将向量功能作为扩展插入到关系型数据库和NoSQL数据库中

## 嵌入

# AI Agents in Action,Second Edition
## 介绍
### 背景
| 模式                                     | 审批机制                                                                                                                 | 自主程度 | 典型用途                                               | 示例平台                                                     |
| ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------ | -------: | ------------------------------------------------------ | ------------------------------------------------------------ |
| **直接式 LLM 对话**（Direct LLM Chat）   | **无需工具调用。** 模型仅根据用户输入直接生成文本回复。                                                                  |   **无** | 问答、文本起草、头脑风暴、知识学习                     | 原版 **ChatGPT（2022）**；早期 **Claude（2023）**            |
| **工具增强型 LLM**（Tool-Augmented LLM） | **单次调用级的隐式授权。** 用户的一次提示可触发模型调用一个工具，通常无需逐步确认。                                      |   **低** | 图像生成、联网搜索、简单信息查询                       | 集成 **DALL·E** 的 ChatGPT；集成 **Google Search** 的 Gemini |
| **AI 助手**（Assistant）                 | **任务级审批。** 系统执行具体操作时，通常需要用户对关键步骤或每项操作进行确认。                                          |   **中** | 结对编程、带引用的资料研究、文档编辑                   | **GitHub Copilot Chat**、**Cursor**、Excel 中的 **Claude**   |
| **AI 智能体**（Agent）                   | **目标级授权 + 高风险操作审批。** 用户设定总体目标，智能体自主规划并执行多个步骤；涉及高风险或敏感操作时再请求用户确认。 |   **高** | 多步骤研究、代码仓库级重构、浏览器自动化、复杂任务执行 | **Claude Code**、**OpenAI Operator**、**Devin**              |

实现一个目标很有可能需要调用多个工具:

| 目标（Goals）           | 任务（Tasks）        | 工具（Tools）         |
| ----------------------- | -------------------- | --------------------- |
| **创建图像**            | 创建图像             | `create_image`        |
| **前往卡尔加里（YYC）** | 搜索航班             | `search_flights`      |
| **前往卡尔加里（YYC）** | 预订航班             | `book_flights`        |
| **前往卡尔加里（YYC）** | 预订酒店             | `book_hotels`         |
| **前往卡尔加里（YYC）** | 预订交通             | `book_transportation` |
| **购买一台电脑**        | 搜索符合需求的电脑   | `web_search`          |
| **购买一台电脑**        | 比较配置、功能与价格 | `web_search`          |
| **购买一台电脑**        | 下单购买电脑         | `order`               |
### MCP
>传统上，智能体和生命周期管理（LLM）只能使用代码库中现有的工具。这种限制很快就成了问题，因为智能体开发者往往花费更多时间构建工具，而不是开发智能体本身。试想一下，一个智能体需要读取你的日历、发送 Slack 消息、查询 Postgres 数据库并创建 Jira 工单。如果没有共享协议，开发者就必须编写和维护四个独立的工具封装器，跟进四套不同的 API 变更，并且每次都要重新实现相同的身份验证、重试和模式处理逻辑。如果一个团队要开发多个智能体，那么大部分工程时间都将耗费在工具底层架构上，而不是智能体的行为本身。

这种情况如今已有所改变。诸如`Model Context Protocol` (MCP) 之类的协议允许智能体与自身代码库之外的工具进行交互。智能体无需在内部重新构建每个集成，而是可以调用由服务提供商或社区维护的专用工具服务器。MCP 的出现标志着智能体构建方式的转变，从嵌入在每个智能体代码库中的定制工具库，转向标准化的、可发现的外部工具服务器生态系统。

- 这确实是我现在做Agent项目的痛点,想要将联网搜索接入Agent里,没有经验的话根本无从下手


MCP 由 Anthropic 开发，将于 2024 年 11 月发布，它是一种基于JSON-RPC 2.0 的开放标准。其设计目标是使人工智能系统能够以一致、安全且高效的方式连接到外部服务.
# Grokking Concurrency
## 介绍
### 并发与并行
* An application can be concurrent but not parallel. It processes more than one task over a given period (i.e., juggling more than one task even if no two tasks are executing at the same instant—this is described in more detail in Chapter 6).

单核多任务。系统通过时间片轮转交替执行多个任务。一段时间内多个任务都有进展，但同一时刻只有一个任务在占用 CPU 执行。

* An application can be parallel but not concurrent, which means it processes multiple subtasks of a single task simultaneously.

多核加速同一任务。将单个大任务拆分成多个子任务，在多核 CPU 上同时执行。

* An application can be neither parallel nor concurrent, which means it processes one task at a time sequentially, and the task is never broken into subtasks.

纯串行。单线程，按顺序从头到尾执行一个任务，不拆分任务。

* An application can be both parallel and concurrent, which means it processes multiple tasks or subtasks of a single task concurrently at the same time (executing them in parallel).

最理想状态。系统既能同时调度多个独立任务，又能把这些任务或单个大任务的子任务分配给多个 CPU 核心同时执行。

# Hugging Face in Action
- 有了一定数量的论文打底之后看起来终于不像是天书了
## 简介
HuggingFace有Transformers库和各种pipeline,大量的预训练模型(通过huggingface_hub下载),构建网页UI的Gradio库(21年被Hugging Face收购).
## 使用Transformer和pipeline
很遗憾,我不太用得到,所以也不想去背API了
## 数据集介绍
![页面](PixPin_2026-09-20_11-19-24.webp)

从hugging face上下载数据集后即可直接调用,数据集的内部结构一般如下:
```python
DatasetDict({
    train: Dataset({
        features: ['text', 'label'],
        num_rows: 25000
    })
    test: Dataset({
        features: ['text', 'label'],
        num_rows: 25000
    })
    unsupervised: Dataset({
        features: ['text', 'label'],
        num_rows: 50000
    })
})
```

*   **训练集**：用于训练模型的训练数据集。
*   **测试集**：用于评估模型性能的测试数据集。
*   **无监督数据集**：通常包含未标记数据的子集，可用于无监督或半监督学习任务。
*   

使用方法也很简单:
```py
dataset['train'][0]
```

>Hugging Face Datasets服务会自动将所有公开数据集转换为Parquet格式，这能显著提升性能

## 分词(tokenization)介绍
分词方法有以下几种类型:
*   **词级（Word-level）**——将文本拆分为单个词语
*   **子词级别（Subword-level）**——将单词切分为更小的有意义单元或子词
*   **字符级（Character-level）**——将文本拆分为单个字符；通常用于中文和日语等语言，这些语言中词边界不那么明显。


![词级](PixPin_2026-09-21_10-33-45.webp)
![子词](PixPin_2026-09-21_10-32-34.webp)
![字符](PixPin_2026-09-21_10-34-10.webp)

>词级分词虽然简单直接，但在处理词汇表外的单词时会遇到困难，因此对于多样化语言需要很大的词汇量。此外，它无法捕捉单词的内部结构，这限制了模型的泛化能力。使用此方法的一些模型包括Word2Vec和GloVe。

>大多数新型模型，特别是基于Transformer的模型（如BERT和GPT），倾向于采用子词或字节对编码（BPE）的分词方式，以克服这些问题，从而在跨语言和词形变化方面提供更好的灵活性和泛化能力

>字符级分词通常用于汉语和日语等语言,俗称CJK,基本都是一个token对应一个汉字.

对数据集进行分词时,会有以下三个结果: input_ids、token_type_ids和attention_mask


input_ids的结构如下,每个数字代表一个token的ID,末尾的0则是填充的token,用于维持所有训练集批次中的序列长度保持一致,方便统一处理
```py
[101, 1045, 12524, 1045, 2572, 8025, 1011, 3756, 2013, 2026,
2678, 3573, 2138, 1997, 2035, 1996, 6704, 2008, 5129, 2009,
2043, 2009, 2001, 2034, 2207, 1999, 3476, 1012, 1045, 2036,
...
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
```
根据token的ID我们能找到原来的Token:
```py
['[CLS]', 'i', 'rented', 'i', 'am', 'curious', '-',
'yellow', 'from', 'my', 'video', 'store', 'because',
'of', 'all', 'the', 'controversy', 'that', 'surrounded',
...
...
'##men', 'mind', 'find', 'it', 'shocking'
...
'[PAD]', '[PAD]', '[PAD]', '[PAD]', '[PAD]', '[PAD]',
'[PAD]', '[PAD]', '[PAD]', '[PAD]', '[PAD]', '[PAD]',
'[PAD]', '[PAD]', '[PAD]', '[PAD]', '[PAD]', '[PAD]']
```
>第一个token是 `[CLS]`，它标志着字符串的开始。某些token前面的 `##` 符号表示该token是一个子词单元，它是较大词的延续或后缀。简而言之，它表示该token不是一个独立词，而是一个片段，与前一个token结合形成完整的词。`[PAD]` token表示token化序列中的填充。它用于通过向较短的序列填充填充token，确保模型的所有输入序列长度相同。这种填充过程是必要的，因为许多基于变换器的模型（如BERT）期望输入张量具有统一大小，以便在训练或推理期间进行高效的批量处理。

第二个属性，token_type_ids，用于区分单个输入中的多个段,也就是说,帮助Bert确定对话的顺序.但对于GPT等LLM来说,用assitant,user来标注就足够了.


第三个属性，attention_mask，用于告知模型哪些标记应当被关注（处理），哪些不应当。当输入中存在填充标记时，这一点尤为重要，因为模型在计算过程中应忽略这些填充:
```py
print(tokenized_dataset['train'][0]['attention_mask'])

[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
...
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
```

![总结构](PixPin_2026-09-21_10-45-20.webp)

## 搜索集成
文中推荐的是smolagent,但我觉得差了点意思,然后AI推荐的是ddgs:
```py
from ddgs import DDGS

def web_search(query: str):
    return DDGS().text(
        query,
        max_results=8,
    )

results = web_search("Redis 8 new features")

for r in results:
    print(r["title"])
    print(r["href"])
    print(r["body"])
```
效果如下:
```json
h2 connection driver error: peer closed connection without sending TLS close_notify: https://docs.rs/rustls/latest/rustls/manual/_03_howto/index.html#unexpected-eof
Redis 8.0 | Docs
https://redis.io/docs/latest/develop/whats-new/8-0/
July 30, 2026 - Redis 8.0 introduces powerful new capabilities, including the beta release of the Vector Set data structure, designed for AI use cases such as semantic search and recommendation systems.
Redis 8 GA: Fast, scalable, and feature-rich
https://redis.io/blog/redis-8-ga/
June 1, 2026 - These are some of the features and capabilities that come packaged in Redis 8 in Redis Open Source. Vector set data structure [beta] We are excited to announce vector set, a new data type for vector similarity search.
Redis 8.8 | Docs
https://redis.io/docs/latest/develop/whats-new/8-8/
July 30, 2026 - Redis 8.8 adds subkey notifications for hash fields, enabling field-level keyspace notifications for hash data. The new INCREX command (#15045) is a window counter rate limiter that combines INCR, INCRBY, INCRBYFLOAT, bounds, and expiration into a single atomic operation.
Redis Open Source 8.0 release notes | Docs
https://redis.io/docs/latest/operate/oss_and_stack/stack-with-enterprise/release-notes/redisce/redisos-8.0-release-notes/
August 10, 2026 - A new I/O threading implementation, which enables throughput increase on multi-core environments (set with the io-threads configuration parameter). An improved replication mechanism that is more performantand robust. ... For more details, see the release notes for the 8.0-M01, 8.0-M02, 8.0-M03, ...
Redis 8.8: New array data structure & open source features
https://redis.io/blog/announcing-redis-8-8/
June 2, 2026 - Highlights include array - a new general-purpose data structure, a window counter rate limiter, streams message NACKing, subkey notifications for hash fields, explicit control over JSON numeric array storage,multiple aggregators in a single time series query, and a new COUNT aggregator for sorted sets union and intersection. Redis 8.8 introduces significant end-to-end throughput improvements:
Redis 8.2 | Docs
https://redis.io/docs/latest/develop/whats-new/8-2/
1 week ago - Redis 8.2 builds on the foundation ... tools. This release delivers major improvements across multiple areas: Enhanced Redis Streams with new commands for better consumer group management...
Redis 8.0-M03 is out. Even more performance & new features. | Redis
https://redis.io/blog/redis-8-0-m03-is-out-even-more-performance-new-features/
February 11, 2025 - Now, in CE 8.0 M03 (Milestone 3 ... single-core and multi-core environments by using a new asynchronous I/O threading implementation along with an improved replication mechanism, delivering better performance and robustness than ...
Redis 8.10: New Compact Hash & open-source features
https://redis.io/blog/announcing-redis-810-compact-hash-jsonpath-extensions-performance-improvements-and-more/
1 week ago - Redis 8.10 is now available in Open Source. Explore Compact Hash, JSONPath extensions, Streams, Sets, Lists, Time Series improvements, and incremental backup and restore.
```

比我想的要好很多呢.
## 总结
干货有不少,但废话也很多.

# Prometheus: Up & Running(待补充)
## 介绍
- Prometheus是一个开源的、基于指标的监控系统.

监控(monitor)可以定义如下:
* **告警（Alerting）**：知道事情何时出错，通常是监控最重要的用途。监控系统应能够在出现异常时通知人工介入检查。

* **调试（Debugging）**：当人工介入后，需要进一步调查问题，确定根本原因，并最终解决已经出现的故障。

* **热门趋势（Trending）**：告警和调试通常发生在几分钟到几小时的时间尺度上。虽然趋势分析没有那么紧急，但了解系统如何被使用、如何随时间变化同样重要。趋势信息可以为设计决策、容量规划等工作提供依据。

* **水管工程（Plumbing）**：监控系统本质上也是一套数据处理管道。在实践中，有时可以复用监控系统的部分能力去完成其他任务，而不必重新构建专门的解决方案。严格来说这不完全属于监控，但实际工程中很常见。


![架构图](PixPin_2026-09-17_11-37-00.webp)

## 入门
### 补充: 使用docker运行Prometheus
新建一个文件夹,放三个文件:

**prometheus.yml**
```yml
global:
  scrape_interval: 15s
  evaluation_interval: 15s

scrape_configs:
  # 监控 Prometheus 自身
  - job_name: "prometheus"

    static_configs:
      - targets:
          - "localhost:9090"
```
**dockerfile**
```dockerfile
FROM prom/prometheus:latest

COPY prometheus.yml /etc/prometheus/prometheus.yml

EXPOSE 9090
```

**compose.yml**
```yml
services:
  prometheus:
    build:
      context: .
      dockerfile: Dockerfile

    container_name: prometheus

    ports:
      - "9090:9090"

    volumes:
      # 持久化 Prometheus 时序数据
      - prometheus_data:/prometheus

      # 开发时推荐挂载配置文件，
      # 修改配置后不需要重新 build 镜像
      - ./prometheus.yml:/etc/prometheus/prometheus.yml:ro

    command:
      - "--config.file=/etc/prometheus/prometheus.yml"
      - "--storage.tsdb.path=/prometheus"
      - "--storage.tsdb.retention.time=15d"
      - "--web.enable-lifecycle"

    restart: unless-stopped

volumes:
  prometheus_data:
```

然后用`docker compose up -d`运行,成功打开页面:

![网页](PixPin_2026-09-17_11-54-18.webp)
### 表达式浏览器(Expression Browser)
![查询执行](PixPin_2026-09-19_18-50-22.webp)

>我们的Prometheus大约使用了73 MB内存。你可能会好奇，为什么这个指标用字节而非兆字节或千兆字节来展示，那样可能更易读。答案是，可读性很大程度上取决于上下文，即使在不同环境中使用同一二进制，其数值也可能相差多个数量级：一个内部RPC可能只需微秒级完成，而轮询一个长期运行的进程则可能耗时数小时甚至数天。因此，Prometheus的惯例是采用基础单位，如字节和秒，并将美化显示的职责交给像Grafana这样的前端工具。

![图标查看](PixPin_2026-09-19_18-52-47.webp)
### Alert(告警)
运行目标:
```yml
global:
  scrape_interval: 10s
  evaluation_interval: 10s
rule_files:
  - rules.yml
alerting:
  alertmanagers:
    - static_configs:
        - targets:
            - localhost:9093
scrape_configs:
  - job_name: prometheus
    static_configs:
      - targets:
          - localhost:9090
  - job_name: node
    static_configs:
      - targets:
          - localhost:9100
```
要想设定报警规则,就要写一个`rules.yml`出来:
```yml
groups:
  - name: example
    rules:
      - alert: InstanceDown
        expr: up == 0
        for: 1m
```
除此之外,我们还需要将alert发送到我们指定的alertmanager上,所以还需要编写一个`alertmanager.yml`:
```yml
global:
  smtp_smarthost: 'localhost:25'
  smtp_from: 'yourprometheus@example.org'
route:
  receiver: example-email
  group_by: [alertname]
receivers:
  - name: example-email
    email_configs:
      - to: 'youraddress@example.org'
```
## Application Monitoring
### Instrumentation
#### 简单程序
```py
import http.server
from prometheus_client import start_http_server


class MyHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"Hello,World!")


start_http_server(8000)
server = http.server.HTTPServer(("localhost", 8001), MyHandler)
server.serve_forever()
```
访问http://localhost:8000/会看到如下界面:
![示意图](PixPin_2026-09-20_10-03-35.webp)

再访问 http://localhost:8001/ 即可看到`Hello,World!"

修改之前的Prometheus.yml:
```yml
global:
  scrape_interval: 10s
scrape_configs:
  - job_name: example
    static_configs:
      - targets: ["host.docker.internal:8000"]

```
然后运行Prometheus来监听:

![界面](PixPin_2026-09-20_10-14-30.webp)

#### Counter
```py

import http.server
from prometheus_client import start_http_server, Counter

REQUESTS = Counter("hello_worlds_total", "Hello Worlds requested.")


class MyHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        REQUESTS.inc()
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"Hello,World!")


start_http_server(8000)
server = http.server.HTTPServer(("localhost", 8001), MyHandler)
server.serve_forever()
```
Count用于统计程序的各种自定义指标
## 
暂时弃坑,毕竟目前根本用不到好吧
# Rust 中文学习教程
由于另一本书太难啃了,所以换这本书来试试咸淡.

- 即便这个文档已经相当有耐心了,但看着依然很累,由此可见Rust是真的很难
## 基础
### 语句
```rs
fn add_with_extra(x: i32, y: i32) -> i32 {
    let x = x + 1; // 语句
    let y = y + 5; // 语句
    x + y // 表达式
}
```
语句会执行一些操作但是不会返回一个值，而表达式会在求值后返回一个值，因此在上述函数体的三行代码中，前两行是语句，最后一行是表达式。
### 函数
单元类型 ()，是一个零长度的元组。它没啥作用，但是可以用来表达一个函数没有返回值:
```rs
use std::fmt::Debug;

// 隐式返回
fn report<T: Debug>(item: T) {
  println!("{:?}", item);

}

// 显式返回
fn clear(text: &mut String) -> () {
  *text = String::from("");
}
```
### 所有权和引用
Rust引入了所有权之后,我们写函数时就要尽量地通过引用来处理数据,不然一不小心就会发生所有权转移问题.

- 正如变量默认不可变一样，引用指向的值默认也是不可变的,如果变量没写mut,自然无法修改引用的值,如果引用没写mut,也无法修改引用的值.

### 复合类型
#### 字符串
>Rust 在语言级别，只有一种字符串类型： str，它通常是以引用类型出现 &str，也就是上文提到的字符串切片。虽然语言级别只有上述的 str 类型，但是在标准库里，还有多种不同用途的字符串类型，其中使用最广的即是 String 类型。

str 类型是硬编码进可执行文件，也无法被修改，但是 String 则是一个可增长、可改变且具有所有权的 UTF-8 编码字符串

- 这一段话太关键了,之前那本rust书都没有清楚的指出这一点,导致我之前都懵懵懂懂的

简单来说,`String`可以自动被编译器转换成`&str`:
```rs
fn print_text(s: &str) {
    println!("{}", s);
}

let s = String::from("hello");

print_text(&s);
// 自动解引用
```
而`&str`想要转换成`&String`,则需要用到转换函数,并发生新的内存分配:
```rs
let s: &str = "hello";

let owned: String = s.to_string();
```

##### 切片
切片的写法如下:
```rs
let s = String::from("hello");

let slice = &s[0..2];
let slice = &s[..2];
```
由于切片是引用,所以必须通过`&`来标明借用
##### 索引
Rust不允许字符串索引,因为要避免其他语言中常见的UTF-8字符报错(中文常常要占用3个或者4个字节),所以我们只能用切片来分割字符串,但如果分割不当,rust也会报错:
```rs
let hello = "中国人";

let s = &hello[0..2];

// thread 'main' panicked at 'byte index 2 is not a char boundary; it is inside '中' (bytes 0..3) of `中国人`', src/main.rs:4:14
// note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```

- 这管的也太宽了...

#### 元组
```rs
fn main() {
    let x: (i32, f64, u8) = (500, 6.4, 1);

    let five_hundred = x.0;

    let six_point_four = x.1;

    let one = x.2;
}
```
#### 结构体
```rs
struct User {
    active: bool,
    username: String,
    email: String,
    sign_in_count: u64,
}

let user1 = User {
    email: String::from("someone@example.com"),
    username: String::from("someusername123"),
    active: true,
    sign_in_count: 1,
};
```
如果要修改结构体,就必须将结构体实例声明为可变的:
```rs
    let mut user1 = User {
        email: String::from("someone@example.com"),
        username: String::from("someusername123"),
        active: true,
        sign_in_count: 1,
    };

    user1.email = String::from("anotheremail@example.com");
```

```rs
fn build_user(email: String, username: String) -> User {
    User {
        email,
        username,
        active: true,
        sign_in_count: 1,
    }
}
```
如上所示，当函数参数和结构体字段同名时，可以直接使用缩略的方式进行初始化，跟 TypeScript 中一模一样。

```rs
  let user2 = User {
        active: user1.active,
        username: user1.username,
        email: String::from("another@example.com"),
        sign_in_count: user1.sign_in_count,
    };
  let user2 = User {
    email: String::from("another@example.com"),
    ..user1
  };
```
可能是为了表示这并非对象展开,而是原样继承,才用的两个点吧.


把结构体中具有所有权的字段转移出去后，将无法再访问该字段，但是可以正常访问其它的字段。
```rs
# #[derive(Debug)]
# struct User {
#     active: bool,
#     username: String,
#     email: String,
#     sign_in_count: u64,
# }
# fn main() {
let user1 = User {
    email: String::from("someone@example.com"),
    username: String::from("someusername123"),
    active: true,
    sign_in_count: 1,
};
let user2 = User {
    active: user1.active,
    username: user1.username,
    email: String::from("another@example.com"),
    sign_in_count: user1.sign_in_count,
};
println!("{}", user1.active);
// 下面这行会报错
println!("{:?}", user1);
# }
```
#### Enum
```rs
enum PokerSuit {
  Clubs,
  Spades,
  Diamonds,
  Hearts,
}

let heart = PokerSuit::Hearts;
let diamond = PokerSuit::Diamonds;
```
可以看到rust使用`::`来访问枚举成员,这一点是继承了Cpp的写法的.

枚举自然可以赋值:
```rs
enum PokerCard {
    Clubs(u8),
    Spades(u8),
    Diamonds(u8),
    Hearts(u8),
}

fn main() {
   let c1 = PokerCard::Spades(5);
   let c2 = PokerCard::Diamonds(13);
}
```
#### 数组
>在 Rust 中，最常用的数组有两种，第一种是速度很快但是长度固定的 array，第二种是可动态增长的但是有性能损耗的 Vector，在本书中，我们称 array 为数组，Vector 为动态数组。

```rs
use std::io;

fn main() {
    let a = [1, 2, 3, 4, 5];

    println!("Please enter an array index.");

    let mut index = String::new();
    // 读取控制台的输出
    io::stdin()
        .read_line(&mut index)
        .expect("Failed to read line");

    let index: usize = index
        .trim()
        .parse()
        .expect("Index entered was not a number");

    let element = a[index];

    println!(
        "The value of the element at index {} is: {}",
        index, element
    );
}
```
与Go一样,[u8; 3]和[u8; 4]是不同的类型，数组的长度也是类型的一部分.


### 流程控制
```rs
fn main() {
    let condition = true;
    let number = if condition {
        5
    } else {
        6
    };

    println!("The value of number is: {}", number);
}
```
Rust中的流程控制可以返回语句,但也可以普通的执行:
```rs
fn main() {
    let n = 6;

    if n % 4 == 0 {
        println!("number is divisible by 4");
    } else if n % 3 == 0 {
        println!("number is divisible by 3");
    } else if n % 2 == 0 {
        println!("number is divisible by 2");
    } else {
        println!("number is not divisible by 4, 3, or 2");
    }
}
```

for-in循环:
```rs
// 第一种
let collection = [1, 2, 3, 4, 5];
for i in 0..collection.len() {
  let item = collection[i];
  // ...
}

// 第二种
for item in collection {

}
```
普通循环while:

```rs
fn main() {
    let mut n = 0;

    while n <= 5  {
        println!("{}!", n);

        n = n + 1;
    }

    println!("我出来了！");
}
```
无条件循环loop:
```rs
fn main() {
    let mut n = 0;

    loop {
        if n > 5 {
            break
        }
        println!("{}", n);
        n+=1;
    }

    println!("我出来了！");
}
```
### 模式匹配
#### match
```rs
enum Direction {
    East,
    West,
    North,
    South,
}

fn main() {
    let dire = Direction::South;
    match dire {
        Direction::East => println!("East"),
        Direction::North | Direction::South => {
            println!("South or North");
        },
        _ => println!("West"),
    };
}
```
- match 的匹配必须要穷举出所有可能，因此这里用 _ 来代表未列出的所有可能性
- match 的每一个分支都必须是一个表达式，且所有分支的表达式最终返回值的类型必须相同

- 这种简单的`=>`标记过于粗暴了

复杂一些的模式匹配:
```rs
enum Action {
    Say(String),
    MoveTo(i32, i32),
    ChangeColorRGB(u16, u16, u16),
}

fn main() {
    let actions = [
        Action::Say("Hello Rust".to_string()),
        Action::MoveTo(1,2),
        Action::ChangeColorRGB(255,255,0),
    ];
    for action in actions {
        match action {
            Action::Say(s) => {
                println!("{}", s);
            },
            Action::MoveTo(x, y) => {
                println!("point from (0, 0) move to ({}, {})", x, y);
            },
            Action::ChangeColorRGB(r, g, _) => {
                println!("change color into '(r:{}, g:{}, b:0)', 'b' has been ignored",
                    r, g,
                );
            }
        }
    }
}
```


#### if let
有时会遇到只有一个模式的值需要被处理，其它值直接忽略的场景，如果用 match 来处理就要写成下面这样：
```rs
let v = Some(3u8);
match v {
    Some(3) => println!("three"),
    _ => (),
}
```
简单的写法如下:
```rs
if let Some(3) = v {
    println!("three");
}
```
不管怎么看都很难看懂这个写法,不过这种情况使用if判断就足够了,不过可能之后有更高级的用法,所以就先放着.

#### Option
rust使用Option枚举来解决空指针问题
```rs
enum Option<T> {
    None,
    Some(T),
}
```

匹配:
```rs
fn plus_one(x: Option<i32>) -> Option<i32> {
    match x {
        None => None,
        Some(i) => Some(i + 1),
    }
}

let five = Some(5);
let six = plus_one(five);
let none = plus_one(None);
```
### 方法
Rust 使用 impl 来定义方法，例如以下代码：
```rs
struct Circle {
    x: f64,
    y: f64,
    radius: f64,
}

impl Circle {
    // new是Circle的关联函数，因为它的第一个参数不是self，且new并不是关键字
    // 这种方法往往用于初始化当前结构体的实例
    fn new(x: f64, y: f64, radius: f64) -> Circle {
        Circle {
            x: x,
            y: y,
            radius: radius,
        }
    }

    // Circle的方法，&self表示借用当前的Circle结构体
    fn area(&self) -> f64 {
        std::f64::consts::PI * (self.radius * self.radius)
    }
}
```
因为是函数，所以不能用 . 的方式来调用，我们需要用 :: 来调用，例如 `let sq = Rectangle::new(3, 3);。`

Rust中的self是需要显式声明的,如果用不到self,就说明这个函数与该结构体的内部没有关系,而是与结构体的构造有关系,这被称为关联函数.

`&self`参数表示不获取所有权的指针,而`self`参数则会转移该结构体的所有权.所以一般都用`&self`的形式.
### 泛型Generics
```rs
struct Point<T> {
    x: T,
    y: T,
}

impl<T> Point<T> {
    fn x(&self) -> &T {
        &self.x
    }
}

fn main() {
    let p = Point { x: 5, y: 10 };

    println!("p.x = {}", p.x());
}
```

Rust中的泛型在很多情况下都要加上特征的限制才可以正常运行,因为Rust不主动猜测,只有你的泛型可以在所有约束下都成立时才能编译成功:
```rs
use std::fmt::Display;

fn create_and_print<T>() where T: From<i32> + Display {
    let a: T = 100.into(); // 创建了类型为 T 的变量 a，它的初始值由 100 转换而来
    println!("a is: {}", a);
}

fn main() {
    create_and_print::<i64>();
}
```

### 特征Trait
如文中所说,Trait和其他语言中的Interface其实很相似,它定义了一组可以被共享的行为，只要实现了特征，你就能使用这组行为。

一个自定义特征Summary的实现方式如下:
```rs
pub trait Summary {
    fn summarize(&self) -> String;
}
pub struct Post {
    pub title: String, // 标题
    pub author: String, // 作者
    pub content: String, // 内容
}

impl Summary for Post {
    fn summarize(&self) -> String {
        format!("文章{}, 作者是{}", self.title, self.author)
    }
}

pub struct Weibo {
    pub username: String,
    pub content: String
}

impl Summary for Weibo {
    fn summarize(&self) -> String {
        format!("{}发表了微博{}", self.username, self.content)
    }
}

fn main() {
    let post = Post{title: "Rust语言简介".to_string(),author: "Sunface".to_string(), content: "Rust棒极了!".to_string()};
    let weibo = Weibo{username: "sunface".to_string(),content: "好像微博没Tweet好用".to_string()};

    println!("{}",post.summarize());
    println!("{}",weibo.summarize());
}

```
当然,我们可以直接给特征定义一个默认实现的方法,这样其他的类型只要象征性地实现一下就可以了:
```rs
pub trait Summary {
    fn summarize(&self) -> String {
        String::from("(Read more...)")
    }
}

impl Summary for Post {}

impl Summary for Weibo {
    fn summarize(&self) -> String {
        format!("{}发表了微博{}", self.username, self.content)
    }
}
```

#### 使用特征作为函数参数
```rs
pub fn notify(item: &impl Summary) {
    println!("Breaking news! {}", item.summarize());
}
```
`impl Summary`表示实现了该特征的任何数据类型,然后就可以在函数中调用该特征的任何方法

上述写法只是语法糖,它的完整版本如下:
```rs
pub fn notify<T: Summary>(item: &T) {
    println!("Breaking news! {}", item.summarize());
}
```
形如 T: Summary 被称为特征约束。

当特征约束很多时,函数的签名就会非常复杂,这时候可以用where关键字来改进:
```rs
fn some_function<T: Display + Clone, U: Clone + Debug>(t: &T, u: &U) -> i32 {}

fn some_function<T, U>(t: &T, u: &U) -> i32
    where T: Display + Clone,
          U: Clone + Debug
{}
```
#### 派生特征
>在本书中，形如 #[derive(Debug)] 的代码已经出现了很多次，这种是一种特征派生语法，被 derive 标记的对象会自动实现对应的默认特征代码，继承相应的功能。
#### 特征对象
#### 特征的进阶

### 动态数组Vector
Vector只支持存放相同类型的元素.
#### 创建方法
1. new方法创建:
```rs
let v: Vec<i32> = Vec::new();
```
2. `vec!`宏创建,可以指定初始化值,如此就不用标注类型:

```rs
let v = vec![1, 2, 3];
```
#### 更新
```rs
let mut v = Vec::new();
v.push(1);
```
#### 访问Vector
```rs
let v = vec![1, 2, 3, 4, 5];

let third: &i32 = &v[2];
println!("第三个元素是 {}", third);

match v.get(2) {
    // 新版本的格式化输出下显然好看得多
    Some(third) => println!("第三个元素是 {third}"),
    None => println!("去你的第三个元素，根本没有！"),
}
```
>和其它语言一样，集合类型的索引下标都是从 0 开始，&v[2] 表示借用 v 中的第三个元素，最终会获得该元素的引用。而 v.get(2) 也是访问第三个元素，但是有所不同的是，它返回了 Option<&T>，因此还需要额外的 match 来匹配解构出具体的值。

```rs
let v = vec![1, 2, 3, 4, 5];

let does_not_exist = &v[100];
let does_not_exist = v.get(100);
```
>运行以上代码，&v[100] 的访问方式会导致程序无情报错退出，因为发生了数组越界访问。 但是 v.get 就不会，它在内部做了处理，有值的时候返回 Some(T)，无值的时候返回 None，因此 v.get 的使用方式非常安全。


### KV存储HashMap
- HashMap没有包含在Rust的Prelude中

#### 创建方法
- new方法
```rs
use std::collections::HashMap;

// 创建一个HashMap，用于存储宝石种类和对应的数量
let mut my_gems = HashMap::new();

// 将宝石类型和对应的数量写入表中
my_gems.insert("红宝石", 1);
my_gems.insert("蓝宝石", 2);
my_gems.insert("河边捡的误以为是宝石的破石头", 18);
```

- Vector转换:
```rs
fn main() {
    use std::collections::HashMap;

    let teams_list = vec![
        ("中国队".to_string(), 100),
        ("美国队".to_string(), 10),
        ("日本队".to_string(), 50),
    ];

    let teams_map: HashMap<_,_> = teams_list.into_iter().collect();
    
    println!("{:?}",teams_map)
}
```
#### 获取元素
```rs
use std::collections::HashMap;

let mut scores = HashMap::new();

scores.insert(String::from("Blue"), 10);
scores.insert(String::from("Yellow"), 50);

let team_name = String::from("Blue");
let score: Option<&i32> = scores.get(&team_name);
```
查询到的是一个枚举类型,要想直接获得值,我们需要这么写:
```rs
let score: i32 = scores.get(&team_name).copied().unwrap_or(0);
```
其中,`copied`函数把枚举中的`&`去掉,即`&i32`变成了`i32`,然后`unwrap_or`负责从枚举中获得值

如果想要简单的获取,只能通过遍历来处理:
```rs
use std::collections::HashMap;

let mut scores = HashMap::new();

scores.insert(String::from("Blue"), 10);
scores.insert(String::from("Yellow"), 50);

for (key, value) in &scores {
    println!("{}: {}", key, value);
}
```
### 认识生命周期
```rs
{
    let r;                // ---------+-- 'a
                          //          |
    {                     //          |
        let x = 5;        // -+-- 'b  |
        r = &x;           //  |       |
    }                     // -+       |
                          //          |
    println!("r: {}", r); //          |
}                         // ---------+
```
上述的`'a`和`'b`表示生命周期,即变量的存活时间.为了使得程序正常运行,生命周期更长的变量不能借用生命周期更短的变量,否则容易引发悬垂指针等问题.

```rs
fn main() {
    let string1 = String::from("abcd");
    let string2 = "xyz";

    let result = longest(string1.as_str(), string2);
    println!("The longest string is {}", result);
}

fn longest(x: &str, y: &str) -> &str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```
![报错信息](PixPin_2026-09-14_09-45-55.webp)

尽管确实无法提前得知这个返回值是引用的哪个变量,但直接报错也太过分了吧.

为了让编译器听话,我们需要加上生命周期的注释,跟Java中的注解作用类似,只不过我们的目的是为了不报错而已.

生命周期的语法也颇为与众不同，以 ' 开头，名称往往是一个单独的小写字母，大多数人都用 'a 来作为生命周期的名称。 如果是引用类型的参数，那么生命周期会位于引用符号 & 之后，并用一个空格来将生命周期和引用参数分隔开:
```rs
&i32        // 一个引用
&'a i32     // 具有显式生命周期的引用
&'a mut i32 // 具有显式生命周期的可变引用
```

上述的代码我们可以这么改:
```rs
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```
此处生命周期标注仅仅说明，这两个参数至少活得和'a 一样久，至于到底活多久或者哪个活得更久，抱歉我们都无法得知.

实际上，在 Rust 1.0 版本之前， Rust 要求必须显式的为所有引用标注生命周期：
```rs
fn first_word<'a>(s: &'a str) -> &'a str {}
```
>在写了大量的类似代码后，Rust 社区抱怨声四起，包括开发者自己都忍不了了，最终揭锅而起，这才有了我们今日的幸福。
#### 编译规则

编译器使用三条消除规则来确定哪些场景不需要显式地去标注生命周期。其中第一条规则应用在输入生命周期上，第二、三条应用在输出生命周期上。若编译器发现三条规则都不适用时，就会报错，提示你需要手动标注生命周期。

1. 每一个引用参数都会获得独自的生命周期

例如一个引用参数的函数就有一个生命周期标注：

```rust
fn foo<'a>(x: &'a i32)
````

两个引用参数的有两个生命周期标注：

```rust
fn foo<'a, 'b>(x: &'a i32, y: &'b i32)
```

依此类推。

1. 若只有一个输入生命周期（函数参数中只有一个引用类型），那么该生命周期会被赋给所有的输出生命周期

也就是所有返回值的生命周期都等于该输入生命周期。

例如函数：

```rust
fn foo(x: &i32) -> &i32
```

`x` 参数的生命周期会被自动赋给返回值 `&i32`，因此该函数等同于：

```rust
fn foo<'a>(x: &'a i32) -> &'a i32
```

1. 若存在多个输入生命周期，且其中一个是 `&self` 或 `&mut self`，则 `&self` 的生命周期被赋给所有的输出生命周期

拥有 `&self` 形式的参数，说明该函数是一个方法，该规则让方法的使用便利度大幅提升。



#### 方法中的生命周期
```rs
struct Point<T> {
    x: T,
    y: T,
}

impl<T> Point<T> {
    fn x(&self) -> &T {
        &self.x
    }
}
```
生命周期的语法和泛型相同:
```rs
struct ImportantExcerpt<'a> {
    part: &'a str,
}

impl<'a> ImportantExcerpt<'a> {
    fn level(&self) -> i32 {
        3
    }
}
```
- impl 中必须使用结构体的完整名称，包括 <'a>，因为生命周期标注也是结构体类型的一部分！
- 方法签名中，往往不需要标注生命周期，得益于生命周期消除的第一和第三规则

#### 静态生命周期
在 Rust 中有一个非常特殊的生命周期，那就是 'static，拥有该生命周期的引用可以和整个程序活得一样久。

>这时候，有些聪明的小脑瓜就开始开动了：当生命周期不知道怎么标时，对类型施加一个静态生命周期的约束 T: 'static 是不是很爽？这样我和编译器再也不用操心它到底活多久了。

### 返回值和错误处理
#### panic 深入剖析
在某些特殊场景中，开发者想要主动抛出一个异常，例如开头提到的在系统启动阶段读取文件失败。

对此，Rust 为我们提供了 panic! 宏，当调用执行该宏时，程序会打印出一个错误信息，展开报错点往前的函数调用堆栈，最后退出程序。
```rs
fn main() {
    panic!("crash and burn");
}

thread 'main' panicked at 'crash and burn', src/main.rs:2:5
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```

>长话短说，如果是 main 线程，则程序会终止，如果是其它子线程，该线程会终止，但是不会影响 main 线程。因此，尽量不要在 main 线程中做太多任务，将这些任务交由子线程去做，就算子线程 panic 也不会导致整个程序的结束。

显然,panic是一个大杀器,只适合于抛出那些一定有严重影响的异常,如果仅仅是用户的输入错误,那用普通的异常处理就够了.

#### 异常枚举Result
Result的定义如下:
```rs
enum Result<T, E> {
    Ok(T),
    Err(E),
}
```
用法如下:
```rs
use std::fs::File;

fn main() {
    // open返回一个Result枚举类型
    let f = File::open("hello.txt");

    let f = match f {
        Ok(file) => file,
        Err(error) => {
            panic!("Problem opening the file: {:?}", error)
        },
    };
}
```
直接panic有点过了,还可以这样写:
```rs
use std::fs::File;
use std::io::ErrorKind;

fn main() {
    let f = File::open("hello.txt");

    let f = match f {
        Ok(file) => file,
        Err(error) => match error.kind() {
            ErrorKind::NotFound => match File::create("hello.txt") {
                Ok(fc) => fc,
                Err(e) => panic!("Problem creating the file: {:?}", e),
            },
            other_error => panic!("Problem opening the file: {:?}", other_error),
        },
    };
}
```
#### 失败就 panic: unwrap 和 expect
expect 跟 unwrap 很像，也是遇到错误直接 panic, 但是会带上自定义的错误提示信息，相当于重载了错误打印的函数：
```rs
use std::fs::File;

fn main() {
    let f = File::open("hello.txt").unwrap();
}

use std::fs::File;

fn main() {
    let f = File::open("hello.txt").expect("Failed to open hello.txt");
}
```
#### 大杀器?
```rs
use std::fs::File;
use std::io;
use std::io::Read;

fn read_username_from_file() -> Result<String, io::Error> {
    let mut f = File::open("hello.txt")?;
    let mut s = String::new();
    f.read_to_string(&mut s)?;
    Ok(s)
}
```
其实 ? 就是一个宏，它的作用跟 match 几乎一模一样：
```rs
let mut f = match f {
    // 打开文件成功，将file句柄赋值给f
    Ok(file) => file,
    // 打开文件失败，将错误返回(向上传播)
    Err(e) => return Err(e),
};
```

甚至还有调用链:
```rs
use std::fs::File;
use std::io;
use std::io::Read;

fn read_username_from_file() -> Result<String, io::Error> {
    let mut s = String::new();

    File::open("hello.txt")?.read_to_string(&mut s)?;

    Ok(s)
}
```
看着很吓人,但联想一下Ts中的`?.`可选链,其实还是挺好看懂的.
### 包和模块
#### Package与Crate
Package可以视作一个完整的Rust项目,通过`cargo.toml`管理,分为可直接执行的二进制Package和只能作为第三方库被其他项目引用的库类型Package.

而Crate则被包含在Package之中,是一个编译单元,编译后会得到一个可执行文件或者一个库.

- 这种不清不白的边界迟早会改掉吧.

#### Module(待补充)
一个Crate对应一个或者多个Module,可以是由多个文件组成,也可以只有一个文件.

模块的声明方式如下:
```rs
mod front_of_house {
    pub mod hosting {
        pub fn add_to_waitlist() {}
    }
}

pub fn eat_at_restaurant() {
    // 绝对路径
    crate::front_of_house::hosting::add_to_waitlist();

    // 相对路径
    front_of_house::hosting::add_to_waitlist();
}
```
>Rust 出于安全的考虑，默认情况下，所有的类型都是私有化的，包括函数、方法、结构体、枚举、常量，是的，就连模块本身也是私有化的


### 注释和文档
Rust的代码注释和Cpp完全相同,但它额外有一个文档注释的神奇功能

当查看一个 crates.io 上的包时，往往需要通过它提供的文档来浏览相关的功能特性、使用方式，这种文档就是通过文档注释实现的。

Rust 提供了 cargo doc 的命令，可以用于把这些文档注释转换成 HTML 网页文件，最终展示给用户浏览，这样用户就知道这个包是做什么的以及该如何使用。

格式如下:
```rs
/// `add_one` 将指定值加1
///
/// # Examples
///
/// ```
/// let arg = 5;
/// let answer = my_crate::add_one(arg);
///
/// assert_eq!(6, answer);
/// ```
pub fn add_one(x: i32) -> i32 {
    x + 1
}
```
使用单行的`///`或者多行的`/** ... */`标明文档注释,并可以使用md语法

除了给函数加注释,还可以给包和模块加注释,包级别的注释也分为两种：行注释 `//!` 和块注释 `/*! ... */`。只要放在文件内部的最上方就可以:
```rs
/*! lib包是world_hello二进制包的依赖包，
 里面包含了compute等有用模块 */

pub mod compute;
```
### 格式化输出
```rs
println!("Hello");                 // => "Hello"
println!("Hello, {}!", "world");   // => "Hello, world!"
println!("The number is {}", 1);   // => "The number is 1"
println!("{:?}", (3, 4));          // => "(3, 4)"
println!("{value}", value=4);      // => "4"
println!("{} {}", 1, 2);           // => "1 2"
println!("{:04}", 42);             // => "0042" with leading zeros
```
rust别具一格的使用`{}`作为占位符,并通过`"?`这样的简洁语法实现不同的格式化输出.


## 高级
### 生命周期
看力竭了,速度跳过
### 函数式编程
#### 闭包
闭包是一种匿名函数，它可以赋值给变量也可以作为参数传递给其它函数，不同于函数的是，它允许捕获调用者作用域中的值，例如：
```rs
fn main() {
   let x = 1;
   let sum = |y| x + y;

    assert_eq!(3, sum(2));
}
```

如果不用闭包,我们需要这么写代码:
```rs
use std::thread;
use std::time::Duration;

// 开始健身，好累，我得发出声音：muuuu...
fn muuuuu(intensity: u32) -> u32 {
    println!("muuuu.....");
    thread::sleep(Duration::from_secs(2));
    intensity
}

fn workout(intensity: u32, random_number: u32) {
    let action = muuuuu;
    if intensity < 25 {
        println!(
            "今天活力满满, 先做 {} 个俯卧撑!",
            action(intensity)
        );
        println!(
            "旁边有妹子在看，俯卧撑太low, 再来 {} 组卧推!",
            action(intensity)
        );
    } else if random_number == 3 {
        println!("昨天练过度了，今天还是休息下吧！");
    } else {
        println!(
            "昨天练过度了，今天干干有氧, 跑步 {} 分钟!",
            action(intensity)
        );
    }
}

fn main() {
    // 强度
    let intensity = 10;
    // 随机值用来决定某个选择
    let random_number = 7;

    // 开始健身
    workout(intensity, random_number);
}
```
但如果用闭包,就可以省略掉参数的传递:
```rs
use std::thread;
use std::time::Duration;

fn workout(intensity: u32, random_number: u32) {
    let action = || {
        println!("muuuu.....");
        thread::sleep(Duration::from_secs(2));
        intensity
    };

    if intensity < 25 {
        println!(
            "今天活力满满，先做 {} 个俯卧撑!",
            action()
        );
        println!(
            "旁边有妹子在看，俯卧撑太low，再来 {} 组卧推!",
            action()
        );
    } else if random_number == 3 {
        println!("昨天练过度了，今天还是休息下吧！");
    } else {
        println!(
            "昨天练过度了，今天干干有氧，跑步 {} 分钟!",
            action()
        );
    }
}

fn main() {
    // 动作次数
    let intensity = 10;
    // 随机值用来决定某个选择
    let random_number = 7;

    // 开始健身
    workout(intensity, random_number);
}
```

闭包可以由编译器自己进行类型推导,但是必须在声明后使用,否则编译器是无从下手的.

```rs
fn  add_one_v1   (x: u32) -> u32 { x + 1 }
let add_one_v2 = |x: u32| -> u32 { x + 1 };
let add_one_v3 = |x|             { x + 1 };
let add_one_v4 = |x|               x + 1  ;
```
在rust中,即使是两个签名一摸一样的闭包的,它们的类型也是不同的:
```rs
let a = |x: i32| x + 1;
let b = |x: i32| x + 1;
```
- 这太反直觉了

因此,要在结构体中声明闭包就必须要通过泛型来解决,并用特征来说明闭包:
```rs
struct Cacher<T>
where
    T: Fn(u32) -> u32,
{
    query: T,
    value: Option<u32>,
}

impl<T> Cacher<T>
where
    T: Fn(u32) -> u32,
{
    fn new(query: T) -> Cacher<T> {
        Cacher {
            query,
            value: None,
        }
    }

    // 先查询缓存值 `self.value`，若不存在，则调用 `query` 加载
    fn value(&mut self, arg: u32) -> u32 {
        match self.value {
            Some(v) => v,
            None => {
                let v = (self.query)(arg);
                self.value = Some(v);
                v
            }
        }
    }
}
```

### 异步
```rs
use futures::executor::block_on;

struct Song {
    author: String,
    name: String,
}

async fn learn_song() -> Song {
    Song {
        author: "曲婉婷".to_string(),
        name: String::from("《我的歌声里》"),
    }
}

async fn sing_song(song: Song) {
    println!(
        "给大家献上一首{}的{} ~ {}",
        song.author, song.name, "你存在我深深的脑海里~ ~"
    );
}

async fn dance() {
    println!("唱到情深处，身体不由自主的动了起来~ ~");
}

async fn learn_and_sing() {
    // 这里使用`.await`来等待学歌的完成，但是并不会阻塞当前线程，该线程在学歌的任务`.await`后，完全可以去执行跳舞的任务
    let song = learn_song().await;

    // 唱歌必须要在学歌之后
    sing_song(song).await;
}

async fn async_main() {
    let f1 = learn_and_sing();
    let f2 = dance();

    // `join!`可以并发的处理和等待多个`Future`，若`learn_and_sing Future`被阻塞，那`dance Future`可以拿过线程的所有权继续执行。若`dance`也变成阻塞状态，那`learn_and_sing`又可以再次拿回线程所有权，继续执行。
    // 若两个都被阻塞，那么`async main`会变成阻塞状态，然后让出线程所有权，并将其交给`main`函数中的`block_on`执行器
    futures::join!(f1, f2);
}

fn main() {
    block_on(async_main());
}
```
## 总结
弃坑了弃坑了,尽管看得出来教程已经很想教会我了,奈何Rust的特性实在太超出常规了.只好靠项目来一点点学Rust了
# Hugo in Action(待补充)
## 引言
>2013 年 7 月，我将博客迁移到 Hugo，并向世界发布了我的第一个Go 项目。当时，我完全没有想到，这个最初只是为了个人博客而编写的项目，竟会彻底改变我的人生，乃至整个世界

## 基础
### Jamstack 
**Jamstack** 一词由 Netlify 的联合创始人兼首席执行官 **Matt Biilmann** 于 2016 年提出,是一种架构思想,最初来自:
```text
J = JavaScript
A = APIs
M = Markup
```

**Jamstack** 摒弃了数据库，将所有内容存储在部署期间编译的文件中，然后通过**内容分发网络（CDN）**进行分发。**应用程序编程接口（API）** 提供动态的、基于服务器的内容，这些内容由第三方维护或由云服务提供商托管，网站所有者只需极少的日常参与。这样，开发人员就无需处理安全更新、**拒绝服务（DoS）**攻击以及持续监控以抵御黑客攻击等任务。


Hugo 是目前最流行的 Jamstack 框架之一，拥有最快的构建速度。它让我们摆脱了设置、维护和日常维护的烦恼

## 总结
仔细一想,我目前根本用不到里面的任何知识好不好...
# System Design Interview: An Insider’s Guide
你就读吧,很久没见过这么干净利落的技术书籍了,对我的感触远比DDIA要震撼的多.
## ch1: 网络扩展
一个非常好的网络服务进阶流程概览

## ch10: 通知系统设计
![示意图](PixPin_2026-09-13_10-29-30.webp)

尽管TCP的重传机制保证了我们的消息一定能够发送到用户设备里,但是这只是到了传输层为止,而在应用层,完全可能出现断连(如手机突然关机)等情况,这个时候由于我们收不到用户的通知反馈,只能选择重传,并通过`通知ID`来去重.

## ch12: 聊天系统
聊天系统中,尽管发送端发送消息是实时的,但接收端接收消息却不可能是这样的,一个简单的方法是通过长时的轮询(polling),每过一段时间就重新连接消息系统,查看有没有新消息.

而官方的解决方案是WebSocket,这是一个由客户端发起的双向且持续的HTTP连接,从而保证用户能够实时地接收到消息.

![应用架构](PixPin_2026-09-14_13-06-42.webp)

### 用户连接断开

>我们都希望互联网连接是稳定可靠的，但实际上并非总是如此，因此我们在设计中必须为这个问题给出应对方法。当用户与互联网断开连接时，客户端和服务器之间的持久连接就丢失了。处理用户断开连接的一个简单方法是，把用户状态标记为离线，然后当连接被重新建立时再将用户状态改为在线。但是，这个方法有个大缺陷。用户在短时间内频繁地断开连接和重新连接互联网是很常见的。举个例子，当用户正在穿越隧道时，网络连接会时有时无。在每次断开连接/重新连接时都更新在线状态，会让在线状态指示器变化太频繁，导致用户体验很差。


这个问题可以通过心跳机制解决,客户端定期向服务器发送一次心跳,如果服务器在x秒内收到了信号,那么就认为用户是在线的.
## ch13: Google补全
一般的字典树每个节点存储一个前缀符或者单词,但这样一来在自动补全时就要经过大量的查询,一个非常合理的方法是在每个节点保留最高频的几个查询词,结构如下:

![改良图](PixPin_2026-09-15_09-37-19.webp)

![架构](PixPin_2026-09-15_09-45-01.webp)



# The Architecture of Open Source Applications(待补充)
## 引言
>建筑架构和软件架构有很多共同之处，但有一个关键区别。建筑师在培训和职业生涯中会研究成千上万座建筑，而大多数软件开发人员一生中真正熟悉的却寥寥无几的大型程序。而且，这些程序往往是他们自己编写的。他们从未有机会接触历史上那些伟大的程序，也从未阅读过经验丰富的从业者对这些程序设计的评论。结果，他们往往是在重复彼此的错误，而不是借鉴彼此的成功经验。


# Effective Python,3rd edition
尽管东西很多,但不到真正要用的时候也根本记不住呢
# SQL Antipatterns: Avoiding the Pitfalls of Database Programming
- 原版出版于2010年,中文版是2011年的,不过后来在22年出了一个重制版,并在今年3月出了第二卷,叫做`More SQL Antipatterns`(很惊人的是在网上找不到资源),不过既然有中文版就先看中文版吧.

## 引言
- 什么是“反模式”？反模式是一种试图解决问题的方法，但通常会同时引发别的问题。

换句话说,这本书通过不当使用SQL的例子来告诉读者如何正确使用SQL,每一章都有一个具体的例子,所以只看有需要的几章就可以了.
## 乱穿马路
程序员通常使用逗号分隔的列表来避免在多对多的关系中创建交叉表，我将这种设计方式定义为一种反模式，称为**乱穿马路（Jaywalking）**，因为乱穿马路也是避免过十字路口的一种方式。

也就是说,本来是这样的:

| product_id | product_name | account_id |
| ---------: | ------------ | ---------: |
|          1 | iPhone       |        101 |
|          2 | MacBook      |        102 |


结果魔改成这样了:

| product_id | product_name | account_id    |
| ---------: | ------------ | ------------- |
|          1 | iPhone       | `101,102,108` |
|          2 | MacBook      | `102,205`     |
|          3 | iPad         | `101`         |

本来加一个关联表就能解决的事情被折腾的一塌糊涂

## 单纯的树
```sql
CREATE TABLE Comments (
    comment_id SERIAL PRIMARY KEY,
    parent_id BIGINT UNSIGNED,
    comment TEXT NOT NULL,
    FOREIGN KEY (parent_id) REFERENCES Comments(comment_id)
);
```
如果评论允许多级嵌套(如Reddit中所做的那样),那么就可能出现一个深度过高的评论树,大幅度降低查询性能.

![情景](PixPin_2026-09-11_10-07-38.webp)

容易想到的嵌套查询方法如下:
```sql
SELECT c1.*, c2.*, c3.*, c4.*
FROM Comments c1                     -- 1st level
LEFT OUTER JOIN Comments c2
    ON c2.parent_id = c1.comment_id   -- 2nd level
LEFT OUTER JOIN Comments c3
    ON c3.parent_id = c2.comment_id   -- 3rd level
LEFT OUTER JOIN Comments c4
    ON c4.parent_id = c3.comment_id;  -- 4th level
```
如果对树高有一定限制的话(这是大多数网站的做法,到了2级评论就结束了),这个做法还是可行的.

>之所以使用左外连接,是因为无论 c1 有没有子评论，都必须保留 c1。
### 解决方案
1. 使用动态数组来存储路径:

| comment_id | path     | author | comment             |
| ---------: | :------- | :----- | :------------------ |
|          1 | 1/       | Fran   | 这个Bug的成因是什么 |
|          2 | 1/2/     | Ollie  | 我觉得是一个空指针  |
|          3 | 1/2/3/   | Fran   | 不，我查过了        |
|          4 | 1/4/     | Kukla  | 我们需要查无效输入  |
|          5 | 1/4/5/   | Ollie  | 是的，那是个问题    |
|          6 | 1/4/6/   | Fran   | 好，查一下吧        |
|          7 | 1/4/6/7/ | Kukla  | 解决了              |

2. 使用嵌套集,即反过来,存储子节点的id,而不是存储父节点的id

3. 闭包表(Closure Table),将任何具有祖先-后代关系的节点都记录在一张表中,如图所示:

![示意图](PixPin_2026-09-11_10-21-56.webp)
### 补充说明
不过,如果是社交平台的话,我们可以通过好友找到好友的好友,再通过好友的好友,找到好友的好友的好友,不断迭代下去,永远不会有一个尽头.这就是图数据库大展神威的地方了,这本书出版的时候显然还没有这个概念吧.

## 需要ID
>这章的目标就是要确认那些使用了主键，却混淆了主键的本质而造成的一种反模式。

很多的书、文章以及程序框架都会告诉你，每个数据库的表都需要一个主键，且具有如下三个特性：
- 主键的列名叫做 id ；
- 数据类型是 32 位或者 64 位整型；
- 主键的值是自动生成来确保唯一的。

但为了让数据库更加清晰,简洁,我们应该做到如下几点:
1. 尽量详细说明id的类型,如Bugs表的主键叫做bug_id
2. 通过关联关系定位主键,这样就可以不用给关联表加上id了.
## 不用钥匙的入口
说明外键约束是很有必要的.
## 实体-属性-值(Entity-Attribute-Value,EAV)
![示意图](PixPin_2026-09-13_17-03-42.webp)

EAV或许看着很美观,插入起来也更简单,但却让查询操作变得痛苦无比,所以不要轻易把列变成行,而是老老实实写关系型数据库.

## 幽灵文件
>当一个理论看上去像是唯一可能的理论时，那意味着你既不理解这个理论，也不理解它所要解决的问题。

理论上来说，图片是一张表中的一个字段，在 Accounts 表中可能会有一个 portrait_image 列。

```sql
CREATE TABLE Accounts (
    account_id     SERIAL PRIMARY KEY,
    account_name   VARCHAR(20),
    portrait_image BLOB
);
```
我们可以选择BLOB类型存储,也可以选择存在文件系统中,并通过VARCHAR记录对应的文件系统路径.

但对于后一种方法,有以下缺点:
1. 删除路径属性并不能自动删除路径所在的文件,然后图片就会堆积在那里,除非自己再写一个后端处理函数
2. 不支持事务隔离,其他客户端也可以找到图片文件
3. 不支持数据库备份和访问权限设置

如果我们简单直接一点,可以把图片直接存储在数据库之外,与数据库管理分离,显然也是一个不错的选择.
# Vision Language Models(待补充)
## 导论
### Brief Introduction to Computer Vision
# PROFESSIONAL C++(待补充)
# A Tour of C++,Third Edition
事实证明,任何由Bjarne Stroustrup亲自动笔的C++书都不具备任何的可读性.
# C++ CRASH COURSE(待补充)
>本书面向已经熟悉基本编程概念的中级到高级程序员。若您没有特定的系统编程经验也没关系，欢迎有经验的应用程序程序员阅读。

## C++基础
过于Crash了,讲的不够详细.只好摘抄重点了.
### 异常处理
先在try代码中抛出异常,再在catch代码中处理异常:
```cpp
#include <stdexcept>
#include <cstdio>

struct Groucho {
    void forget(int x) {
        if (x == 0xFACE) {
            throw std::runtime_error{"I'd be glad to make an exception."};
        }
        printf("Forgot 0x%x\n", x);
    }
};

int main() {
    Groucho groucho;

    try {
        groucho.forget(0xC0DE);
        groucho.forget(0xFACE);
        groucho.forget(0xC0FFEE);
    } catch (const std::runtime_error& e) {
        printf("exception caught with message: %s\n", e.what());
    }
}
```

我们可以给那些不可能抛出异常的函数加上`noexcept`标记,但如果发生了异常,程序会被强行终止:
```cpp
bool is_odd(int x) noexcept {
    return 1 == (x % 2);
}
```
### 构造与析构
构造和析构的顺序和栈相同,遵循后构造先析构的顺序.

成员的构造顺序由声明顺序决定:
```cpp
class Test {
    A a;
    B b;

public:
    Test()
        : b(),
          a()
    {
    }
};
```
上述代码中,会先构造A,再构造B.
### Copy Semantics
>Copy semantics is “the meaning of copy.” 

也就是说,x被复制到y后,二者是相互独立的,对x的修改不会影响到y.
### Move Semantics
移动语义是拷贝语义在移动操作上的对应概念，它要求将对象 y 移入对象x后，x等价于 y原先的值。移动完成后，y 处于一种特殊状态，称为 “ 已移动状态 ” 。对于已移动状态的对象，你只能执行两种操作：（重新）赋值或销毁它们


# Hadoop: The Definitive Guide(4th)(待补充)
## 基础
### 起源
Hadoop这个名字并不是一个首字母缩略词；它是一个杜撰出来的名字。该项目的创建者Doug Cutting解释了这个名字的由来：

>The name my kid gave a stuffed yellow elephant. Short, relatively easy to spell and pronounce, meaningless, and not used elsewhere

Hadoop起源于Lucene的研发过程,结合了04年Google公开的MapReduce算法,并在08年成为Apache的顶级项目,在之后被主流企业广泛使用
### MapReduce
#### 简单例子
1. 首先我们有一个数据集,想要从中找出每一年的最大数
```text
(0,   0067011990999991950051507004...9999999N9+00001+99999999999...)
(106, 0043011990999991950051512004...9999999N9+00221+99999999999...)
(212, 0043011990999991950051518004...9999999N9-00111+99999999999...)
(318, 0043012650999991949032412004...0500001N9+01111+99999999999...)
(424, 0043012650999991949032418004...0500001N9+00781+99999999999...)
```
2. 设置一个Map函数,从中过滤后并提取出标准格式的信息:
```text
(1950, 0)
(1950, 22)
(1950, -11)
(1949, 111)
(1949, 78)
```
整理得到:
```text
(1949, [111, 78])
(1950, [0, 22, -11])
```
3. 设置一个Reduce函数,遍历Map函数的结果得到最终值:
```text
(1949, 111)
(1950, 22)
```

流程图如下:

![示意图](PixPin_2026-09-11_11-28-10.webp)

Map函数:
```java
import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class MaxTemperatureMapper
        extends Mapper<LongWritable, Text, Text, IntWritable> {

    private static final int MISSING = 9999;

    @Override
    public void map(LongWritable key, Text value, Context context)
            throws IOException, InterruptedException {

        String line = value.toString();
        String year = line.substring(15, 19);

        int airTemperature;

        if (line.charAt(87) == '+') { // parseInt doesn't like leading plus signs
            airTemperature = Integer.parseInt(line.substring(88, 92));
        } else {
            airTemperature = Integer.parseInt(line.substring(87, 92));
        }

        String quality = line.substring(92, 93);

        if (airTemperature != MISSING && quality.matches("[01459]")) {
            context.write(new Text(year), new IntWritable(airTemperature));
        }
    }
}
```
Reduce函数:
```java
import java.io.IOException;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class MaxTemperatureReducer
        extends Reducer<Text, IntWritable, Text, IntWritable> {

    @Override
    public void reduce(Text key, Iterable<IntWritable> values, Context context)
            throws IOException, InterruptedException {

        int maxValue = Integer.MIN_VALUE;

        for (IntWritable value : values) {
            maxValue = Math.max(maxValue, value.get());
        }

        context.write(key, new IntWritable(maxValue));
    }
}
```


在实现了Map和Reduce方法后,调用方法如下:
```java
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class MaxTemperature {

    public static void main(String[] args) throws Exception {
        if (args.length != 2) {
            System.err.println("Usage: MaxTemperature <input path> <output path>");
            System.exit(-1);
        }

        Job job = new Job();
        job.setJarByClass(MaxTemperature.class);
        job.setJobName("Max temperature");

        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));

        job.setMapperClass(MaxTemperatureMapper.class);
        job.setReducerClass(MaxTemperatureReducer.class);

        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);

        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}
```
### The Hadoop Distributed Filesystem(HDFS)
# Beginning C,From Beginner to Pro
确实很适合入门,可惜的是当初没看到这本书
## 指针与内存分配
当你使用malloc()函数时，你需要在程序中包含stdlib.h头文件。，你将希望分配的内存字节数作为参数指定。该函数返回它根据你的请求分配的内存中第一个字节的地址。因为你得到一个返回的地址，所以指针是唯一能存放它的地方。
```c
int *pNumber = (int*)malloc(100);
```
由于malloc返回的是`void*`,会自动转换,所以右边那个强制转换可以不用写,而在cpp中,我们推荐直接用new,从而避开万恶的空指针问题:
```cpp
int* pNumber = new int[100];

// 使用 pNumber[0] 到 pNumber[99]

delete[] pNumber;
pNumber = nullptr;
```

更多的还有calloc,realloc等方法,但我真切的希望这些函数我之后再也碰不到比较好.
## 属性语法
很惊讶的是这本书引入了不少C23的内容,其中属性语法是我觉得很不错的一个功能,该语法于C++11引入,而C语言直到C23才开始使用.

一个最简单的属性写法如下:
```c
[[ noreturn ]] void f(){ exit(0); }
```
属性使用两个`[]`来标识,里面的属性名用于告诉编译器这是什么类型的函数,我们还可以额外提供调试输出语句,用`()`包裹:
```c
[[deprecated("Use mobile_phone() instead.")]]
void payphones()
{
printf("Payphones are deprecated.\n");
}
```
可以发现,这和Java5中的注解极其相似,而实现难度其实并不大,但仍旧过了这么久才正式推出,足以说明C的陈旧.

## 基本输入与输出
>Each serial input source and output destination in C is called a stream.

流独立于所涉及的物理设备，如显示器或键盘。程序使用的每个设备都可以关联一个或多个流，这取决于它是单向设备（如键盘）还是能代表多个数据源或目标的设备（如磁盘驱动器）。
## 结构体
```c
struct Horse
{
    int age;
    int height;
    char name[20];
    char father[20];
    char mother[20];
};

struct Horse dobbin = {
    24, 17, "Dobbim", "Trigger", "Flossie"
};
```
## Union
```c
union U_example
{
    float decval;
    int *pnum;
    double my_value;
} ul;

union U_example u2, u3;
u1.decval = 2.5;
u2.decval = 3.5*u1.decval;
```
Union与结构体的不同之处在于,所有成员都共享最长变量的内存空间,赋值时会覆盖之前的变量值,同一时刻只有最后一次被赋值的成员是有效的,总的来说我们不会这么缺内存,所以Struct几乎永远是Union的上位替代.

## 处理文件
简单涉及了几个文件操作函数的使用方法
## The Preprocessor and Debugging
直到这里才开始讲头文件和static关键字,完美诠释了真正的循序渐进是怎样的.

避免头文件被包含多次:
```c
// MyHeader.h
#if !defined MYHEADER_H
#define MYHEADER_H
// All the statements in the file...
#endif
```

预处理中的选择语句:
```c
#if CPU == Intel_i7
printf_s("Performance should be good.\n" );
#else
printf_s("Performance may not be so good.\n" );
#endif
```
# EFFECTIVE C
非常一般,实际上就是讲一遍C语言基础,远不如上面那本书
# Fluent C
结构比较清晰,先给一个上下文(context),再指出其中的问题(problem),最后给出推荐的解决方案(Solution),重复个几十遍.

也正因为如此,不是精通C的程序员看了也记不住,精通C的程序员遇到了问题来看才差不多.

# MySQL是怎样运行的(待补充)
## 基本
### 架构
![原理图](PixPin_2026-08-24_12-10-56.webp)

- MySQL的查询缓存过于低效,需要查询语句完全相同才可以生效,所以在8.0版本后被彻底废除


>在客户端程序发起连接的时候，需要携带主机信息、用户名、密码，服务器程序会对客户端程序提供的这些信息进行认证，如果认证失败，服务器程序会拒绝连接

MySQL中的存储引擎列举:
| 存储引擎  | 描述                                 |
| --------- | ------------------------------------ |
| ARCHIVE   | 用于数据存档（行被插入后不能再修改） |
| BLACKHOLE | 丢弃写操作，读操作会返回空内容       |
| CSV       | 在存储数据时，以逗号分隔各个数据项   |
| FEDERATED | 用来访问远程表                       |
| InnoDB    | 具备外键支持功能的事务存储引擎       |
| MEMORY    | 置于内存的表                         |
| MERGE     | 用来管理多个MyISAM表构成的表集合     |
| MyISAM    | 主要的非事务处理存储引擎             |
| NDB       | MySQL集群专用存储引擎                |

我们最常用的就是InnoDB(默认引擎)和MyISAM(旧系统),有时候会用Memory(临时数据),用法如下:
```sql
CREATE TABLE users (
    id BIGINT PRIMARY KEY,
    name VARCHAR(100)
) ENGINE = InnoDB;

CREATE TABLE cache_data (
    id INT PRIMARY KEY,
    value VARCHAR(255)
) ENGINE = MEMORY;
```
这被称为“可插拔存储引擎架构”

### 记录
>真实数据在不同存储引擎中存放的格式一般是不同的，甚至有的存储引擎比如 Memory 都不用磁盘来存储数据，也就是说关闭服务器后表中的数据就消失了。

>设计 InnoDB 存储引擎的大叔们到现在为止设计了4种不同类型的 行格式 ，分别是 Compact 、 Redundant 、Dynamic 和 Compressed 行格式

![图示](PixPin_2026-09-03_16-36-58.webp)

### 索引
MySQL采用B+树索引,叶子节点中存储了页号,行号等定位信息,InnoDB中一个B+树节点就是一个Page.

>InnoDB 内节点记录存“索引键 + 子页号”；聚簇索引叶子存完整行；二级索引叶子存“二级键 + 主键”，不存聚簇数据页号。
### 数据存储
因为 MySQL 的数据都是存在文件系统中的，就不得不受到文件系统的一些制约，这在数据库和表的命名、表的大小和性能方面体现的比较明显，比如下边这些方面：
- 数据库名称和表名称不得超过文件系统所允许的最大长度。
- 每个数据库都对应 数据目录 的一个子目录，数据库名称就是这个子目录的名称
- 文件长度受文件系统最大长度限制

总的来说,MySQL使用frm格式(frame)的文件来描述表结构,使用ibd文件来标记表的具体数据存放位置,这被称为表空间(table space),一个表空间可以对应多个区(extent),每个区由连续的64页组成(默认为1MB大小),我们的数据就存储在页中.

具体的文件结构就没必要去看了,看了也看不懂...
## 进阶
等工作了再来看吧,目前这些知识也够用了.

# 深入理解 AI Agent(待补充)
# Linkers and Loaders
本来以为这么有名的书内容一定很充实吧,结果发现完全比不上修养那本书,白期待一场.
# Data Storage Architectures and Technologies
## 简介
一开始是从Zlib上看到了英文版,觉得可能很适合我,随意地翻阅了一下,发现果然是本比较优秀的教材,后来发现原来这书是先出的中文版嘛,叫做`数据存储架构与技术 (第2版)`
## 简要介绍
>数据存储性能通常以**吞吐量和延迟**来衡量。吞吐量指单位时间内存储系统能处理的操作数量，而延迟则是完成单次操作所需的时间

数据存储的另一个目标是高可用性(high usability)，这能提升上层应用与存储系统之间的交互效率，包括更快速的数据写入和更高效的读取操作,也就是说要能设计出一个良好的接口供其他人使用

![示意图](PixPin_2026-09-06_11-02-22.webp)

高可靠性(High Reliability)存储能够在系统异常（包括磁盘、服务器和网络故障以及人为错误）时防止数据丢失和服务中断,实现高可靠性最基础的方法之一是利用数据冗余,最著名的就是RAID了,通过多副本和纠错码,能够大幅度降低出错的概率.
## 存储介质
>**磁存储介质**利用磁性粒子的磁极来记录数据，两种磁化方向分别代表数据“0”和“1”。采用磁存储介质的常见存储盘有**磁盘和磁带**。**电存储介质**利用存储单元中存储的电子数量来记录数据，电子数量影响位线的电平，表示数据“0”或“1”。采用电存储介质的常见存储盘包括**闪存和动态随机存取存储器**。对于**光存储介质**，使用激光照射介质，使介质发生物理或化学变化来表示“0”和“1”。采用光存储介质的常见存储盘有**CD光盘、DVD光盘、蓝光光盘和归档光盘**。
### HDD(hard disk drives)-硬盘驱动器,也被称为机械硬盘
机械硬盘由于需要等待盘片的旋转和磁头的定位时间,所以在性能上并没有多好,但由于价格便宜,所以仍然在不断发展和改进中.
### SSD(solid-state drives)-固态硬盘
目前，固态硬盘主要使用闪存或其他非易失性内存芯片，如相变存储器。

![示意图](PixPin_2026-09-08_11-37-27.webp)

- 可以发现SSD的结构比起HDD来相当复杂.

由于闪存是一种electrically erasable programmable read-only memory,所以每次写入新数据时都要进行擦写,而一个存储单元的擦写次数是有上限的,一旦达到这个上限,SSD也就等于失效了.为延长SSD寿命，闪存转换层采用磨损均衡策略，尽可能将擦写次数均匀分配给所有页面

### Main Memory
目前，主存储器普遍使用DRAM介质,如名字所说,是Random Access的,所以存取速度极快.
### 剩余部分
介绍了PCM,RRAM,MRAM等新型结构,不太需要关注.

## Storage Arrays
简单介绍了一下RAID等阵列结构
## 存储协议
>目前，计算机存储架构主要采用存储块协议，按照固定数据块大小的倍数对存储设备进行数据访问。典型的存储块协议包括SCSI(Small Computer System Interface)协议和专门为SSD设计的NVMe(non-volatile memory express)协议

而具体原理可以说是相当的复杂,所以不深入了.
## 键-值存储
简单介绍了B+树,LSM树
## 文件系统
有一个非常好的引入!
## 网络存储架构
### DAS: direct-attached storage
DAS这一概念是在网络存储技术出现后才被提出的。与网络存储不同，DAS不涉及网络或网络设备。任何将硬盘驱动器（HDD）或固态硬盘（SSD）直接连接至计算机的存储架构，均可称为DAS。

### NAS: network-attached storage
![结构图](PixPin_2026-09-10_10-37-28.webp)

客户可以通过各种基于网络的文件访问协议（如NFS和CIFS）在NAS系统上操作文件

NFS协议由SUN公司于1984年提出，允许用户如同访问本地文件一样访问远程服务器上的文件。该协议采用基于远程过程调用（RPC）机制的客户端/服务器模型。由于具有高性能和高灵活性，NFS已成为UNIX和Linux系统中最流行的网络文件访问协议。

CIFS 由微软提出，通常用于 Windows 主机之间的网络文件共享。与 NFS 协议不同，CIFS 协议是面向网络连接的，要求网络可靠性较高。此外，CIFS 是一种有状态协议，对故障非常敏感。


### SAN:  storage area network
广义而言，任何能够实现计算机、专用存储网络与存储设备互联的存储形式均可称为SAN。不过，由于光纤通道（FC）协议在商业上的成功，SAN这一术语已逐渐成为基于FC的网络存储架构的代名词。

## 总结
总的来说还是比较全面详细的.值得一读

# Designing Data-Intensive Applications, Second Edition(待补充)
## 前言
- 第一版于2017年出版,第二版于2026年出版,中间间隔了十年,所以章节内容上有了大幅度的改动.
- 第一版出版后就被很多人奉为神书,那么再版后想必更厉害了吧.

>There are hundreds of databases to choose from. Which one should you use for your application? The short answer is, “It depends.” The long answer is…​this book.

这才是软件工程最美丽的地方,技术的变迁和环境的动荡迫使着程序员们殚精竭虑,设计出符合当前情况的最好架构.
## 背景
先看看两位作者的title: Martin Kleppmann and Chris Riccomini

>Martin Kleppmann（马丁·克莱普曼）目前是英国剑桥大学计算机科学与技术系副教授（Associate Professor），主要研究去中心化系统、Local-first 协作软件和安全协议，并教授分布式系统和密码协议相关课程。此前曾在慕尼黑工业大学从事研究，并在剑桥大学获得博士学位。
>
>Kleppmann 在进入学术界以前做过多年互联网工程和创业。他曾共同创办并出售两家创业公司，也曾在 LinkedIn 等互联网公司从事大规模数据基础设施工作；其中还包括创业公司 Rapportive。

第一版的作者只有他一个人,还是很厉害的,他甚至还有一个[博客](https://martin.kleppmann.com)

Chris Riccomini,O'Reilly 对他的介绍是：拥有 15年以上软件工程经验，先后在 PayPal、LinkedIn、WePay 工作，目前经营 Materialized View Capital，投资基础设施类创业公司
## 基本
>如果一个应用程序开发过程中的主要挑战之一是数据管理，我们便称之为**数据密集型应用**.
>在计算密集型系统中，挑战在于将极其庞大的计算任务并行化；而在数据密集型应用中，我们通常更关注存储和处理海量数据、管理数据变更、在面临故障和并发时确保一致性，以及保证服务的高可用性等问题。

前两章基本都是经验之谈,可看的地方不多.
## 数据模型
对常见数据库的一个总结,稍微有一点看头
## 存储
>实际上，哈希表在数据库索引中的使用并不普遍。更常见的做法是按照键的顺序来组织数据

>本章目前为止讨论的数据结构都是为了解决磁盘的限制问题。与主存相比，磁盘操作起来更为不便。无论是机械硬盘还是固态硬盘，若要实现良好的读写性能，都需要精心安排数据布局。我们容忍这种不便，是因为磁盘拥有两大显著优势：持久性（断电时内容不会丢失）以及每吉字节成本低于RAM。

## 编码
介绍了Avro,Protobuf,Json Schema等主流编码方式
### Json Schema
不看不知道,原来Json Schema这么出名,MCP,OpenAPI,OAuth都用的是它,格式如下:
```json
{
  "type": "object",
  "properties": {
    "first_name": { "type": "string" },
    "last_name": { "type": "string" },
    "birthday": { "type": "string", "format": "date" },
    "address": {
       "type": "object",
       "properties": {
         "street_address": { "type": "string" },
         "city": { "type": "string" },
         "state": { "type": "string" },
         "country": { "type" : "string" }
       }
    }
  }
}
```

### RPC介绍
>本地函数调用是可预测的，其成功与否仅取决于你控制的参数。而网络请求则不可预测，原因完全不受你控制。例如，请求或响应可能因网络问题丢失，远程机器可能响应缓慢或不可用。网络问题很常见，因此应用程序必须预见这些问题（例如，通过重试失败的请求）。
>
>一个本地函数调用要么返回结果、抛出异常，要么永不返回（例如进入无限循环或进程崩溃）。而网络请求则有另一种可能的结果：可能因超时而无结果返回

- 这也是网络游戏制作的一个难点之一


## Replication
>如果你复制的数据不随时间变化，复制操作就很简单：只需将数据一次性复制到所有节点即可完成任务。复制的所有难点在于处理被复制数据的变更

复制最大的难点在于如何保持同步,即便通过发送日志的方式来保持主从一致性,但如果SQL指令中有`Now,Rand`等结果未知的语句,或者具有无法预知的副作用如`trigger`,就会破坏这个一致性.

更为特殊的地方是,由于我们不可避免地要使用异步复制,那么很容易就出现读写不一致的问题,为了保证用户体验,我们需要通过单调读(Monotonic reads)来解决用户读取到更老版本的问题.

复制一共有三种方式: Single-leader,Multi-leader,Leaderless,各有千秋,只好看情况使用了.

# Coding Video,A Practical Guide to HEVC and Beyond(待补充)
## 介绍
>一秒标准的未压缩SD(576p)视频，每秒25帧，大约占用15.5 MB存储空间。这意味着，通过网络或广播频道实时传输这段视频，即每秒发送一秒可播放的视频内容，需要124 Mbit/s的带宽。而一秒未压缩的UHD/4K视频、每秒50帧捕捉，则大约占用620 MB存储空间，实时传输将需要高达5 Gbit/s的传输带宽。

- 由此可知,我们在电子产品中存储的视频都是压缩形式的,只在播放时进行实时的解码.

![说明图](PixPin_2026-08-09_10-23-28.webp)

尽管我们拥有的存储容量和网络带宽比以往任何时候都要多，但存储和传输视频的需求仍在不断超出可用容量。到2023年，约三分之二的消费级电视机已达到4K分辨率或更高。将高性能视频编解码器集成到智能手机和电视等消费设备中，以及对高分辨率视频的期望，使得在存储或传输前压缩或编码视频，并在显示前解码视频成为常态
# Building Microservices(待补充)
## 基础

