---
title: 从零开始的算法交易(量化交易)
draft: true
tags:
image:
---

炒股的人都听过**量化交易**这一个概念,但**量化交易**到底是什么,它又是怎样赚到钱的,我对此并没有一个清晰的认识,因此写了这篇文章

## 量化交易的概念

### 概念澄清
非常奇怪的是,wiki上并没有量化交易(Quantitative Trading)这个概念,相反,它有两个类似的概念: [算法交易(Algorithmic trading)](https://en.wikipedia.org/wiki/Algorithmic_trading)和[量化分析(Quantitative analysis)](https://en.wikipedia.org/wiki/Quantitative_analysis_(finance)).

- Quantitative Analysis：侧重于**确定买卖什么**。它利用数学模型、统计学和海量数据集来评估资产价值、风险和市场规律。本质是研究与决策。
- Algorithmic Trading：侧重于**如何执行买卖**。它通过预设的代码逻辑自动下达交易指令，旨在优化执行速度、降低冲击成本或捕获微小的价差。本质是工程与自动化。

显然,我们所说的量化交易一词更偏向于Algorithmic Trading这一概念,"算法"一词也比不知所云的"量化"要清晰的多.

而拿这三个概念去搜索GitHub仓库,都能得到不少的答案,而对应仓库数量最多的其实是**Algorithmic trading**.

而在google上搜索时,搜索结果数量最多的则是**Quantitative analysis**.
![alt text](.PixPin_2026-04-14_17-20-17.webp)
![alt text](.PixPin_2026-04-14_17-21-31.webp)
![alt text](.PixPin_2026-04-14_17-22-00.webp)

就算改为中文进行搜索,量化交易的结果也是最少的.所以中文股票圈一致使用量化交易这个词我就不是很理解了...

**不管怎样,本文采用算法交易这一概念而非莫名其妙的量化交易一词.**

### 算法交易的定义
The term **algorithmic trading** is often used synonymously with automated trading system. These encompass a variety of trading strategies, some of which are based on formulas and results from mathematical finance, and often rely on specialized software.
- A study in 2019 showed that around **92%** of trading in the Forex market was performed by trading algorithms rather than humans.

无论怎样,经过精确训练的算法模型通常都能比人类做出更合理的决策,这也是那些量化公司这么火爆的原因.

## 