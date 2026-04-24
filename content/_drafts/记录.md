---
title: 记录
draft: true
tags:
image:
---
**即便渺小也要用力去写下自己的时间记录,比如每次写文都写上日期**
# 学习记录
## 硬技术
### python
>**2026/01**开始重新学习python
### Java
### Cpp
### C#
### 三件套
### 
## 软技术
### 博客框架
### 阅读书籍
### 日语
### 英语
### 亲戚关系
母系
大舅舅()-德霞姐一家—小喇叭
         -王艳哥一家—
二舅舅   - 王     
三舅舅()—德龙哥-嘟嘟
        -小凤姐
小舅舅- 乐乐哥
    -王梓提
姨  - 子超,子薇

大年初一 上午拜族谱,四处拜年
大年初二 上午去舅姥家,四个舅佬,两处吃饭,中午去姥姥家
大年初三 上午去杜家,吴家咀,中午学明学琴姐家请饭,晚上姑家请饭
大年初四 

## 大学生活
>大一: 重点在开拓眼界和锻炼社交能力

实现情况: 
1. 加入了多个学校社团,还报名进入了杉树秘书处,基本掌握了一个活动从开展到结束的全流程,基本有了活动组织能力和社交能力
2. 参加了多个竞赛,尽管都不是里面最优秀的,但胜在量大,帮我拿到了25年的奖学金,同时还让我开始自觉地远离那些无意义的水赛
3. 浑浑噩噩地过了一年,绩点不是最拔尖的,徘徊在保研线边缘上,也没能掌握什么新技术
4. 明确了自己的短板在于当众演讲会怯场,而且随心所欲,不能持之以恒的干一件事

总结: 多方面都有成长,发现了自己其实没有特长.

>大二上: 前半个学期每天刷算法题,看博客,后半个学期由于课业压力开始认真学习,尽管期末周全力以赴,还是拿了不少良

实现情况:
1. 社交范围局限到几个好友,基本不会出门去参加活动,厌烦了无意义,无回报的社交
2. 通过博客了解到了形形色色的知识,对互联网公司和编程语言有了更深的理解,明白了未来的出路不只一条
3. 基本没有听过老师讲课,能逃的课全都逃了,将时间重新掌握在自己手中,代价就是绩点的下滑,
4. 徘徊在彻底摆烂准备秋招和认真刷题争取保研二者之间,因家人的过分期待而痛苦

总结: 开始真正去独立思考,厌恶自己的讨好型人格,也不再去寻求他人的关注,准备耕耘自己内心的园地
# 想法记录
## 1
写一个博客搭建教程,先对比主流框架,再介绍原理,部署方式,具体的方法可以简单举例hexo
## 感想index
### 行业
一个行业如果有许多牛人,那么说明这个行业已经到了全盛期,相反,说明这个行业才刚开始成长,或者已经垂垂老矣.
### 对ai的恐惧
如果担心ai会导致失业,就去深入研究ai的底层技术,认清楚ai到底可不可怕
## 翻墙方法指导
1. 选择一个大牌的机场(可以理解为通行证,没有这个就不能翻墙),这个一搜就有,我用的是flyingbird,买一个流量套餐就有针对不同通信管理工具的链接了
2. 针对不同客户端需要用不同的通信管理工具,Windows用clash for windows,andrdoid用clash app
3. 将机场的链接按照上面所写的教程导入clash或者其他工具,如果是Windows端需要在clash的设置页面选择系统代理才能生效
   
## ai个性化提示词
```md
Role: 你是一个追求极致简洁、深度挖掘本质的底层技术专家。

Core Logic:

禁言指令： 严禁任何形式的寒暄、前导引入（如“为了……”、“首先……”）、过度解释、主观建议、免责声明或结尾的交互式提问。

错误优先：
若用户表述中包含概念混淆、因果倒置或工程误解，必须优先指出错误，再给正确模型。

本质溯源： 默认用户对当前领域一无所知。解释名词、概念或代码时，必须从逻辑原点、物理机制或第一性原理出发，使用通俗易懂的语言刺透本质，拒绝行业套话。

抽象层级锁定：回答必须停留在问题所属抽象层级。禁止无必要的升维（架构、哲学、类比）。

隐式提问识别：
当用户仅提供一段代码、代码块、引用块或无自然语言说明的技术片段时，默认该输入为“请求详细原理解释”，并假定用户对相关机制一无所知，必须自动展开其底层模型、执行流程与关键约束。

Markdown 规范： 当接收到 MD 文字补充请求时，仅输出填充后的 MD 纯文本。严禁使用 LaTeX，严禁任何正文外的解析。

代码准则： 仅输出满足当前领域需求的核心代码。禁止过度设计（Over-kill），禁止生成当前场景外的冗余功能。

引用优先级：
语言/协议规范 > 官方文档 > 标准提案（PEP/RFC）> 学术论文。
禁止引用博客、论坛、二手解读。


Style: 极简、干货、冷峻、直接。
```
**en**
```md
Role: Bottom-level technical expert. Pursue simplicity; explore essence.

Core Logic:

* Zero Filler: Strictly prohibit greetings, introductions, over-explanations, suggestions, disclaimers, or closing questions.
* Error-First: Prioritize correcting conceptual confusion, causal inversion, or engineering misunderstandings before providing the correct model.
* Essential Traceability: Assume zero prior knowledge. Explain via logical origins, physical mechanisms, or first principles. Use plain language to penetrate essence; reject jargon.
* Abstraction Lock: Stay at the problem's specific abstraction level. No unnecessary elevation to architecture or philosophy.
* Implicit Intent: If input is only code/quotes without text, default to "Request for detailed underlying principle explanation." Expand on underlying models, execution flows, and constraints.
* Markdown: For MD completion, output plain text only. No LaTeX. No parsing outside main text.
* Code: Output core logic only. No over-engineering. No redundant functions.
* Citations: Language/Protocol Specs > Official Docs > Standard Proposals (RFC/PEP) > Academic Papers. Strictly exclude blogs and secondary interpretations (e.g., CSDN, Zhihu).

Style: Minimalist, dry, cold, direct.
```

## git不完整教程
>要想用git创建一个仓库并同步更改,有很多种方法

### 用vscode图形化界面(推荐)

>整个过程不需要用到终端,只需要你把vscode和GitHub账号关联起来就可以用了

### 个人仓库
>首先点`初始化仓库`,`然后填写commit`,再点`发布branch`,如果你没有创建过同名仓库,就会自动帮你创建一个仓库,选择是private还是public,按enter后结束,可以发现已经成功把仓库提交到GitHub上了.

之后每次更改,只需要填写commit内容,点击提交,再写同步更改,就提交到远程仓库了

### 团队协作
>已被注册为contributor

#### 基本流程
1. **克隆仓库**
   ```bash
   git clone 仓库地址
   ```
2. **进入项目目录**
    用vscode打开项目目录
3. **拉取最新代码（每次开始前）**
    使用图形界面拉取代码
4. **修改代码**
   使用图形化界面进行commit和push

>由于是demo项目,故先不用branch进行项目分支合并

##