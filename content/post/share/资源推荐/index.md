---
title: 资源推荐
date:  2026-11-01T12:46:55+08:00
image: 91461486_p0-骤雨.webp

---
## 推荐书籍(26/11)
看了那么多书,自然能找到几本写的不错的.这里只放了一些核心的书籍,至于那些写的一般的书尽管有一定的阅读价值,但想了想还是不放上来,虽然说"人要从错误中学习",但能少走弯路就别走吧.
### 基础
#### 操作系统
`Operating Systems: Three Easy Pieces`我想是每个程序员的必读书了吧,如果要作为补充的话,`操作系统设计与实现`(讲解MINIX)和`Linux内核设计与实现`都是不错的书籍,其他的书就没什么好推荐的了.
#### 计算机网络
除了`计算机网络:自顶向下方法`外,我更推荐的反而是`计算机网络: 自底向上方法`,原书是Andrew S. Tanenbaum主笔的`computer networks`,但由于它是从物理层向上讲的,所以就这么称呼了.

**自顶向下**更偏向应用,对于底层的原理讲的都不是很透彻,我读的时候就有不少解释不清的地方;而**自底向上**更偏向理论,对于技术的原理都讲的很清晰,能够让人更深入的了解某一层的具体设计.

自底向上在21年出了第六版,而自顶向下在25年出了第九版.

另外还有两本值得关注的计算机网络书,一本叫做`Computer Networks: A Systems Approach`,由Larry L. Peterson编写,21年出了第六版,目前(26/10)第七版还在撰写中;另一本叫做`Data Communications and Networking`,21年出了第六版.

由于计算机网络的相关知识确实很多很杂,所以多读几本绝非坏事.


#### 处理器架构
`计算机组成与设计: 硬件/软件接口`(有多个架构版本,推荐RISC-V的)和`计算机体系结构: 量化研究方法`是姊妹书,第一本打基础,第二本作为进阶,如果与国内课程对应的话,那就是计算机组成原理和计算机系统结构的关系.

在读完上面两本书后,再看`The Elements of Computing Systems`,我想会有非常大的收获,有种把所有处理器架构的知识点都串联起来的感觉.

另一本值得关注的就是`x86汇编语言：从实模式到保护模式`,这本书能够让你知道,中文技术书籍未必就不能成为经典,未必就是诘屈聱牙的代名词.



#### 运维与网络
1. [Pro git](https://git-scm.com/book/zh/v2): 不会git不好意思说自己是程序员吧,而官方的文档比起其他的二手资料要详细的多,但很奇怪的是,在官方文档讲的如此形象有趣的时候,还总是有人喜欢自己去写教程.
2. `Docker Deep Dive`: 相当优秀的Docker入门书籍.
3. `深入浅出密码学`: 要想写出一个安全的网站,这本书是必读的.
4. `Designing APIs with Swagger and OpenAPI`: 鉴于现在还是Rest的天下,所以学习OpenAPI还是很有必要的,而这本书讲的也很具体形象
5. `GitHub Actions in Action`: Github Action确实很好用,尽管进了公司以后用的可能是自研平台,但原理还是相通的,这也是具体学习CI/CD的一个很好的途径

#### 架构/数据库
- `Redis设计与实现`: 分量很重,做好准备去读,但收获会很大
- `数据存储架构与技术`: 就像是在写教科书,但胜在非常全面,好奇硬盘存储原理和存储架构的都可以来看一看.
- `System Design Interview – An Insider's Guide`: 别看标题是这样,实际上是以面试的问答形式剖析了常见系统架构的具体实现,难得一见的好书.

#### 杂项
1. `程序设计语言原理`: 大部分内容都比较诘屈聱牙,但这本书的第二章让它能够在这里获得一个席位,以详实的笔调记录了程序设计语言的整个发展历史,可以这么说,这是我见过的最详细的资料了,任何一个好奇我们是如何从Fortran进化到Go的程序员都应该来读这本书,当然,读第二章就可以了.
### 语言
#### C/CPP
- `Beginning C,From Beginner to Pro`: 这本书结构清晰,是真正的优秀教程,学完这个再上手Cpp包没问题的,谁再推荐`C Programming Language`入门C语言我就直接上门去骂了,当初读`C++ Primer Plus`的苦也不想再让别人尝试了.
- `程序员自我修养`: 是讲解C语言编译原理中难得的好书了,能够让你知道静态链接和动态链接到底是什么,而我目前都没能找到任何一本能够比他还全面的书了.
#### Python
- `Python源码剖析`: 非常值得一看的Python原理书籍
- 
#### Go
- `Learning Go`: 比什么Go语言圣经还有什么Go Tour好上一万倍吧🙃

### Agent/ML
#### Infra
- `Deep Learning from Scratch`是我最推荐的深度学习入门书籍,他能够让你知道,神经网络可以很简单,根本不是多复杂的东西,而我们离所谓高深莫测的AI也并没有那么遥远.
- `Hugging Face in Action`: 介绍怎么用Hugging Face的,说真的,新人第一次进网站都会被吓到劝退好不好,把你那个大头网站设计好行嘛,别总是加一堆找都找不到入口的功能了.
  - (11/1): 额没过几个礼拜就真的重构网站了,难道我有这么大的影响力😂
- `Build a Large Language Model`: 看不懂论文,那就对了,但你要连这本书都看不懂,那还是回炉重造吧

#### 应用
- `RAG with Python Cookbook`: 真真正正讲RAG的,而不是直接从langchain调用个模型来就生成embedding了,偏向实操.
- `Agentic Coding with OpenAI Codex CLI`: 不仅仅是教Codex,而是在教在Agent时代怎么用Agent,非常详细易懂
- `深入理解AI Agent`: 大佬编写的在线书籍,具有一定基础后来看简直是享受


### 高级
1. `Architecture Patterns with Python`: 通过真实代码讲DDD,分层架构和EDA,千万别去看什么`Learning Domain-Driven Design`,看了你也学不会~
## Windows端工具(2026/3)
### Magpie
强大的窗口缩放器,畅玩一切古早游戏.
### ContextMenuManager
不多解释,改注册表还是太麻烦了,用这个快速除去流氓软件的菜单项.
### okular
不多解释,薄纱其他所有的windows pdf阅读器,真正的秒天秒地,我就是想看个pdf要那么多其他功能干什么.另外提一嘴安卓端的阅读神器是readera,同样遥遥领先.
### calibre
支持的书籍格式还是很多的,可惜启动有点慢,太臃肿了,但我找到的SumatraPDF等阅读器由于支持格式少代替不了它.
### Anki(多端)
背单词神器,可以自己定制卡片这点就非常nice.

- [有史料为证](https://galgame.dev/topic/639/%E5%85%B3%E4%BA%8E%E6%88%91%E4%B8%80%E5%B9%B4%E4%B8%8D%E5%88%B0%E9%80%9F%E9%80%9An1%E8%BF%99%E4%BB%B6%E4%BA%8B-%E5%9F%BA%E4%BA%8E%E5%95%83%E7%94%9F%E8%82%89galgame%E7%9A%84%E6%97%A5%E8%AF%AD%E5%AD%A6%E4%B9%A0%E6%94%BB%E7%95%A5)

### AIMP(多端)
![界面](PixPin_2026-11-01_12-52-09.webp)

由于网易云启动太慢,加载音乐太卡,又有很多不必要的功能,因此我转而加入AIMP神教,不仅可以自定义界面,还可以下载各式各样的皮肤.运行速度飞快,而且有手机桌面双端.尽管这个软件是离线的,只能下好歌之后再导入,歌词也要自己下,但这一切都值得!

### qView
Windows自己的图片浏览器真的是拉完了,加载慢的离谱,换成qview后就舒服多了,界面简洁的异常,毕竟看个图片而已,要什么名堂.

![示意图](PixPin_2026-11-01_12-53-07.webp)
### 常见
- Everything,PotPlayer,JiJiDown,Motrix,Quicker,Pixpin

## 浏览器插件(2026/3)
### [免费看CSDN付费文章](https://github.com/Mrlimuyu/CSDN-VIP)
```js
// ==UserScript==
// @name         100%解锁CSDN文库vip文章阅读限制
// @namespace    http://tampermonkey.net/
// @version      2.2
// @description  CSDN文库阅读全文，去除VIP文章遮罩
// @author       Mrlimuyu
// @match        *://*.csdn.net/*
// @grant        none
// @license      yagiza
// @downloadURL https://update.greasyfork.org/scripts/495150/100%25%E8%A7%A3%E9%94%81CSDN%E6%96%87%E5%BA%93vip%E6%96%87%E7%AB%A0%E9%98%85%E8%AF%BB%E9%99%90%E5%88%B6.user.js
// @updateURL https://update.greasyfork.org/scripts/495150/100%25%E8%A7%A3%E9%94%81CSDN%E6%96%87%E5%BA%93vip%E6%96%87%E7%AB%A0%E9%98%85%E8%AF%BB%E9%99%90%E5%88%B6.meta.js
// ==/UserScript==

(function() {
    'use strict';

    const adjustArticle = () => {
        // 移除遮罩层和限制高度的内容
        document.querySelectorAll('.hide-article-box, .login-mark, .mask, .vip-caise').forEach(el => el.remove());

        // 展开被限制高度的内容
        const articleContainer = document.querySelector('.article_content');
        if (articleContainer) {
            articleContainer.style.maxHeight = 'none';
            articleContainer.style.height = 'auto';
        }
    };

    // 启用复制功能
    const enableCopy = () => {
        document.body.oncopy = null;
        document.oncopy = null;
        document.querySelectorAll('*').forEach(el => {
            el.style.userSelect = 'auto';
            el.style.webkitUserSelect = 'auto';
            el.style.msUserSelect = 'auto';
            el.style.mozUserSelect = 'auto';
        });
    };

    // 使用MutationObserver来监视文档的变化
    const observer = new MutationObserver((mutations) => {
        mutations.forEach((mutation) => {
            if (mutation.addedNodes.length) {
                adjustArticle();
                enableCopy();
            }
        });
    });

    observer.observe(document.body, {
        childList: true,
        subtree: true
    });

    // 页面加载时尝试执行一次
    window.addEventListener('load', () => {
        adjustArticle();
        enableCopy();
    });
})();
```
- 很难想象这么简单的代码就可以破解成功

尽管CSDN上绝大部分内容都是垃圾,但架不住多年的历史沉淀,还是有些优质的中文文章的,其中还有一部分是付费的,有了这个插件就好办多了

### Powerful Pixiv Downloader
喜欢逛Pixiv的有福了

将图片从内嵌文件夹中提取出来的脚本:
```py
import os
import shutil

src = r"F:\\archive\\pixiv"
dst = r"F:\\output"

for root, dirs, files in os.walk(src):
    for f in files:
        if f.lower().endswith((".jpg", ".jpeg", ".png", ".webp", ".bmp", ".gif")):
            src_path = os.path.join(root, f)
            dst_path = os.path.join(dst, f)
            shutil.copy(src_path, dst_path)
```


### Bypass Paywalls Clean
没钱看外刊的有福了

### uBlacklist
讨厌csdn的有福了,不过一般用Google搜索的话比bing搜索出来的垃圾就是会少很多
```yml
# CSDN
*://*.csdnimg.cn/*
/csdn\.(com|net)/
/gitcode\.(com|net|host)/
# 营销号（标题党、洗稿等低质或错误内容）
*://*.sohu.com/*
*://*.sina.cn/*
*://*.163.com/*
*://*.douyin.com/*
*://www.doubao.com/*
*://*.tiktok.com/*
*://*.toutiao.com/*
*://new.qq.com/*
*://news.qq.com/*
*://cloud.tencent.com/developer/*
*://cloud.tencent.cn/developer/*
*://www.showapi.com/news/*

# 电商平台产品
*://*.taobao.com/*
*://*.1688.com/*
*://www.jd.com/*
*://m.jd.com/*
*://so.m.jd.com/*
*://*.jd.hk/*
*://i-search.jd.com/*
# 抄袭（复制/镜像/同步搬运原创者内容）
*://*.iii80.com/*
*://*.iii80.cc/*
*://i80.free.fr/*
*://iii80.free.fr/*
*://kknews.cc/*
*://read01.com/*
*://shrimpskin.com/*
# AI 生成
*://*.jimowang.com/*
*://docs.pingcode.com/*
*://*.worktile.com/kb/*
*://*.anzhuoe.net/*
*://*.blog.51cto.com/*
*://developer.baidu.com/*
*://www.oryoy.com/*
*://cloud.tencent.com/*
*://developer.aliyun.com/*
*://zhidao.baidu.com/*
*://*.zeeklog.com/*
```
这是我结合大佬数据后弄的光荣榜
### Competitive Companion
喜欢打oi的有福了

## 翻译工具(2026/6/6)
唯一推荐的就是Calibre的翻译插件了,可以自选模型,然后翻译成中英双语版本的,至于其他的方案,要么有额度限制,要么质量很差.
