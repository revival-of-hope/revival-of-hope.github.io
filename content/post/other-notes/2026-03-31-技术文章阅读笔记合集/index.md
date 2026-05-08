---
title: 技术文章阅读笔记合集-1

math: true
date: 2026-03-31 08:00:00
image: 123579977_p0-『stroll』.webp
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
![alt text](PixPin_2026-04-15_14-04-30.webp)
- 可以看到,这里的数学原理是非常简单的,并不怎么难懂
>即使是使用三元、四元甚至是更高阶的语言模型，依然无法覆盖所有的语言现象。在自然语言中，上下文之间的关联性可能跨度非常大，例如从一个段落跨到另一个段落，这是马尔可夫假设解决不了的。此时就需要使用 LSTM、Transformer 等模型来捕获词语之间的远距离依赖（Long Distance Dependency）了。
### 神经语言模型
#### NNLM模型
![alt text](PixPin_2026-04-15_14-11-19.webp)
>具体来说，NNLM 模型首先从词表C中查询得到前面N个词语对应的词向量,然后将这些词向量拼接后输入到带有激活函数的隐藏层中，通过Softmax函数预测当前词语的概率,它不仅能够能够根据上文预测当前词语，同时还能够给出所有词语的词向量
#### Word2Vec模型
Word2Vec 的模型结构和 NNLM 基本一致，只是训练方法有所不同，分为 CBOW (Continuous Bag-of-Words) 和 Skip-gram 两种:
![alt text](PixPin_2026-04-15_14-15-26.webp)
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
![alt text](PixPin_2026-04-17_11-43-43.webp)
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
![alt text](PixPin_2026-04-04_11-48-15.webp)

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
- 讲的很深,可惜的是逻辑比较混乱,如果能再版后重构一下就真的是神书了
[GitHub下载链接](https://github.com/anzhihe/learning/blob/master/program/book/%E7%A8%8B%E5%BA%8F%E5%91%98%E7%9A%84%E8%87%AA%E6%88%91%E4%BF%AE%E5%85%BB--%E9%93%BE%E6%8E%A5%E3%80%81%E8%A3%85%E8%BD%BD%E4%B8%8E%E5%BA%93(%E9%AB%98%E6%B8%85%E5%B8%A6%E5%AE%8C%E6%95%B4%E4%B9%A6%E7%AD%BE%E7%89%88).pdf)
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
![alt text](PixPin_2026-03-27_12-43-31.webp)
#### 语义分析
语义分析器(Semantic Analyzer)对表达式进行**静态**的语义分析,标识各个表达式的类型;动态语义则只能在运行期确定.
![alt text](PixPin_2026-03-27_12-44-40.webp)
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
![alt text](PixPin_2026-03-31_13-09-29.webp)
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
![alt text](PixPin_2026-04-09_14-02-28.webp)

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
![alt text](PixPin_2026-04-10_15-06-33.webp)

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
![alt text](PixPin_2026-04-19_15-13-29.webp)
当我们运行`gcc -c a.c b.c`后,得到两个目标文件`a.o`和`b.o`,如何将他们链接起来,形成一个可执行文件?这个过程中发生了什么?
### 链接方法
对于多个目标文件,链接器有以下两种方法,将他们的各个段(section)合并到一个可执行文件中:
1. 按序叠加
2. 相似段合并
#### 按序叠加
这种方法将输入的目标文件按照次序叠加起来:
![alt text](PixPin_2026-04-19_15-18-14.webp)
显然,这种做法非常浪费空间,会堆积一大堆冗余数据

#### 相似段合并
将相同性质的段合并到一起是一个更为实际的方法,也是主流的链接器空间分配策略:
![alt text](PixPin_2026-04-19_15-22-42.webp)
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

![alt text](Gemini_Generated_Image_t4pwmgt4pwmgt4pw.png)
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

![alt text](image.png)

##### 类型一: 模块内部调用或跳转
由于被调用的函数与调用者位于同一个文件中,相对位置是固定的,所以不需要重定位.
##### 类型二: 模块内部数据访问
由于文件被分页之后的相对位置是固定的,数据部分和指令部分往往是在相邻的页中,因此我们可以通过相对寻址来访问内部数据,通常也不需要重定位.
##### 类型三: 模块间数据访问
不同模块间的访问地址需要到装载时才能确定,为了保证代码是地址无关的,我们需要建立一个指向这些外部全局变量的指针数组,也被称为**全局偏移表**(Global Offset Table),当代码需要引用外部全局变量时,可以根据GOT来查找并间接引用该变量.

详细过程如下:

1. 动态链接器在装载时会查找每个变量所在的地址来填充GOT,将其存放在数据段
2. 需要访问外部变量时,程序根据GOT查找到该变量的目标地址

![alt text](image-1.png)
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

如图所示:
![alt text](PixPin_2026-05-08_08-03-55.webp)
- 可以看到,栈向低地址增长,而堆向高地址增长

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


# Deep Learning from Scratch
- [pdf链接](https://github.com/qiaohaoforever/DeepLearningFromScratch/blob/master/%E3%80%8A%E6%B7%B1%E5%BA%A6%E5%AD%A6%E4%B9%A0%E5%85%A5%E9%97%A8%EF%BC%9A%E5%9F%BA%E4%BA%8EPython%E7%9A%84%E7%90%86%E8%AE%BA%E4%B8%8E%E5%AE%9E%E7%8E%B0%E3%80%8B%E9%AB%98%E6%B8%85%E4%B8%AD%E6%96%87%E7%89%88.pdf)
如前所说,阅读<< Transformers快速入门 >>的前提是要搞懂神经网络是什么,于是我辗转找到了这本享有盛名的书,希望能够彻底理解神经网络的概念
## 感知机(perceptron)
感知机是一个类似于电路节点的模型,它接收多个输入信号,输出一个信号,该信号只有两个值: 0和1,**0对应不传递信号**,**1对应传递信号**.
![alt text](PixPin_2026-04-28_10-49-37.webp)

如图:x1和x2是输入信号,被送往y节点时会分别乘以权重(weight),w1和w2,y节点会计算w1x1+w2x2的结果,当总和超过某个界限值时,才会输出1,这也被称为**神经元激活**.我们将这个界限值称为**阈值**,用`θ`表示.

数学公式表示:
![alt text](PixPin_2026-04-28_10-52-25.webp)

但我们可以把阈值与总和移到同一侧:
![alt text](PixPin_2026-04-28_11-01-59.webp)

这里的b就是`-θ`,被称为偏置(bias),决定了神经元被激活的容易程度.

显然,单层感知机是一个线性数学模型,它无法处理非线性空间:

![alt text](PixPin_2026-04-28_11-05-20.webp)

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

![alt text](PixPin_2026-04-28_11-17-18.webp)

我们将最左边的一列称为第0层,中间一列称为第1层,最右边一列称为第2层,这也就是**多层感知机**(multi-layered perceptron).
## 神经网络
### 从感知机到神经网络
我们之前的多层感知机结构可以再优化一下,将偏置b也作为输入参数:
![alt text](PixPin_2026-04-30_13-04-20.webp)

$$y = \begin{cases} 0 & (b + w_1x_1 + w_2x_2 \le 0) \\ 1 & (b + w_1x_1 + w_2x_2 > 0) \end{cases}$$
并且,由于分段函数不太好看,我们可以将上述式子,改写成下面的两个式子:
$$y = h(b + w_1x_1 + w_2x_2)$$

$$h(x) = \begin{cases} 0 & (x \le 0) \\ 1 & (x > 0) \end{cases}$$

这个h(x)函数会将输入信号的总和转换成输出信号,它被称为**激活函数(activation function)**.

如果我们把总和(add)称为a的话,就可以这样画图:
![alt text](PixPin_2026-04-30_13-11-10.webp)


这就得到了我们的神经网络，我们把最左边的一列称为
输入层，最右边的一列称为输出层，中间列全部称为中间层:
![alt text](PixPin_2026-04-30_12-59-58.webp)


### 激活函数
$$h(x) = \begin{cases} 0 & (x \le 0) \\ 1 & (x > 0) \end{cases}$$
由于上述的阶跃函数太过单调,不具有可操控性,在神经网络中我们通常采用一些非线性的,更复杂的激活函数.

- 之所以不用线性的,是因为多层的线性函数叠加总可以被单层的线性函数所替代.(例如a^3=a * a * a)
#### sigmoid函数
该函数是神经网络的常用激活函数:

$$h(x) = \frac{1}{1 + e^{-x}}$$

效果如下,非常平滑:
![alt text](PixPin_2026-04-30_13-19-50.webp)

#### ReLU函数
ReLU,全称为**Rectified Linear Unit**,比起sigmoid函数更为简单:

$$h(x) = \max(0, x)$$

写成分段函数形式更为清晰一点：
$$h(x) = \begin{cases} x & (x > 0) \\ 0 & (x \le 0) \end{cases}$$

它有以下特性:

*   **线性增长**：当输入 $x$ 大于 0 时，直接输出 $x$，没有任何梯度消失问题。
*   **单侧抑制**：当输入 $x$ 小于等于 0 时，输出硬性截断为 0，使神经元进入“休眠”状态


### 用矩阵来表示神经网络
![alt text](PixPin_2026-04-30_13-40-24.webp)
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
#### softmax函数
其公式如下:

$$y_k = \frac{\exp(a_k)}{\sum_{i=1}^{n} \exp(a_i)}$$

- 可以看到,对于每一个输出信号,softmax函数都考虑了所有的输入信号,并通过指数函数进行平滑化处理
- softmax函数的**输出值总和为1**,所以我们可以将softmax函数的输出解释为**概率**

由于当输入信号过大时会导致指数爆炸,使用计算机程序计算softmax函数的结果时会发生数据溢出,所以我们需要对上式做一些加工:

$$y_k = \frac{\exp(a_k)}{\sum_{i=1}^{n} \exp(a_i)} = \frac{C \exp(a_k)}{C \sum_{i=1}^{n} \exp(a_i)}$$

$$= \frac{\exp(a_k + \log C)}{\sum_{i=1}^{n} \exp(a_i + \log C)}$$

$$= \frac{\exp(a_k + C')}{\sum_{i=1}^{n} \exp(a_i + C')}$$

>上述的推导有一个奇怪的地方,本来应该是lnC,却被写成了logC,我四处搜寻答案找到一条比较合理的解答:
>![alt text](PixPin_2026-05-01_10-42-09.webp)

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
![alt text](PixPin_2026-05-05_15-50-09.webp)
上图即为计算图: 通过节点和箭头表示计算过程,节点用⚪表示,⚪中是计算的内容,计算的中间结果写在箭头上方.

我们可以只把运算符写在⚪中,将具体的变量数提出来放在外面:
![alt text](PixPin_2026-05-05_15-52-14.webp)


一个更为复杂的问题求解,但还是很好理解:
![alt text](PixPin_2026-05-05_15-52-42.webp)

### 链式法则与反向传播
反向传播的通俗理解:

>将对损失函数的贡献度通过输出层一步步回传至输入层,计算出各层的权重参数对该次训练结果误差的贡献,并让权重参数针对自身的贡献进行大小上的调整.

- 具体原理则是通过导数的乘积和加减实现.


**加法原样传递参数**
![alt text](PixPin_2026-05-06_13-02-09.webp)
**乘法交叉传递导数**
![alt text](PixPin_2026-05-06_13-03-39.webp)
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


![alt text](PixPin_2026-05-07_08-34-15.webp)
由于梯度的方向未必是最小值的方向,所以SGD很多时候的效率比较低,因此我们又有Momentum,AdaGrad,Adam三种方法来代替SGD.
#### Momentum(动量法)
$$\begin{aligned} \boldsymbol{v} & \leftarrow \alpha \boldsymbol{v}-\eta \frac{\partial L}{\partial \boldsymbol{W}} \\ \boldsymbol{W} & \leftarrow \boldsymbol{W}+\boldsymbol{v} \end{aligned}$$

通过α我们能够更精细的调整增量的大小,效果如下:
![alt text](PixPin_2026-05-07_08-34-28.webp)

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
![alt text](PixPin_2026-05-07_08-54-19.webp)

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

![alt text](PixPin_2026-05-08_09-16-33.webp)
### batch normalization
![alt text](PixPin_2026-05-08_09-21-17.webp)

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

自然,我们在反向传播的时候在损失函数中加上$\lambda W$即可实现权值衰减,但在求梯度偏导的时候,对于某一层而言,只有该层的参数会被计入计算,而其他层的参数都被视为常数,因此异常的权重参数不会将影响扩大至其他层.

#### Dropout
