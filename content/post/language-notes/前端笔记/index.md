---
title: 前端笔记
draft: true
tags:
image:
---
# 前端概览
- [wiki](https://en.wikipedia.org/wiki/Front_end_and_back_end)

>前端与后端是一对概念,前端用于指代用户交互层,后端用于指代数据处理层

前端最令人遗憾的地方在于,早期的浏览器大战使得网络生态混乱不堪,不同企业之间高筑护城河,诞生了各种各样的框架和新特性,让新入门的程序员一筹莫展,不知道学什么好.

不管怎样,我还是按照前端三件套到JSX,TSX的步骤来学习,从而更深入的理解前端的方方面面.
# HTML
**Hypertext Markup Language**(HTML)是一门用来处理网页文档内容的标记语言,通过dom(Document Object Model)将HTML中的元素映射到引擎中,从而展示出你现在看到的所有网页.
## HTML历史
- [wiki](https://en.wikipedia.org/wiki/HTML)

* **1980年 - 1989年：概念原型**
    * **1980年**：Tim Berners-Lee 在 CERN 开发 ENQUIRE 系统，用于共享文档。
    * **1989年**：Berners-Lee 编写备忘录，提议建立基于互联网的超文本系统。
* **1990年 - 1991年：诞生与初步公开**
    * **1990年**：Berners-Lee 编写了首个浏览器和服务器软件。
    * **1991年10月**：首次公开提及“HTML Tags”，包含 18 个元素，设计深受 CERN SGML（标准通用标记语言）影响。
* **1993年 - 1995年：标准化尝试**
    * **1993年6月**：IETF 发布首个 HTML 规范草案。
    * **1993年末**：HTML+ 草案提出支持表格和表单。
    * **1995年11月**：**HTML 2.0** 发布（RFC 1866），成为首个正式标准。
* **1997年 - 1999年：W3C 主导时期**
    * **1997年1月**：**HTML 3.2** 发布，W3C 接手标准化工作，吸收了大量浏览器厂商的专有标签。
    * **1997年12月**：**HTML 4.0** 发布，开始推行结构与样式分离（引入 CSS），并分为 Strict、Transitional、Frameset 三种变体。
    * **1999年12月**：**HTML 4.01** 发布，成为长期稳定的 Web 基础。
* **2000年 - 2009年：XHTML 转向与停滞**
    * **2000年**：XHTML 1.0 发布，将 HTML 4.01 重新表述为 XML。
    * **2004年**：由于 W3C 坚持 XHTML 2.0 方向（不向下兼容），部分成员成立 **WHATWG**，开始研发 HTML5。
    * **2009年**：W3C 停止 XHTML 2.0 工作，转向 HTML5。
* **2014年至今：HTML5 与活标准**
    * **2014年10月**：**HTML5** 正式成为 W3C 推荐标准。
    * **2019年5月**：W3C 与 WHATWG 达成协议，HTML 与 DOM 标准的发布权交由 WHATWG。
    * **现状**：HTML 采取“Living Standard”（活标准）模式，由 WHATWG 持续更新。
      * 换句话说就是不再用版本号来标识了,很长一段时间会一直定格在HTML5.


- [参考教程](https://www.w3schools.com/html/html_intro.asp)
## 学习html的前提
首先,我们需要知道诸如`<p><p/>`这样的独特标签语法的来源: **SGML(Standard Generalized Markup Language)**,它诞生于1986年,使用`<`和`>`定义标签,通过重叠的标签来展示层次化的内容.

由于SGML的语法过于繁琐,XML与HTML均对其进行了简化和处理,但保留了**标签语法**.

其次,我们时常可以看到两种html文件格式: `.html`与`.htm`,显然这个`htm`是简化版本,但它为什么会存在呢?
>由于早期Windows的文件系统均采用“8.3 格式”。即：文件名最长 8 个字符，扩展名最长 3 个字符,所以无法表示html,为了兼容Windows系统,不得不将`html`后缀变成`htm`.
>但现在就没有这个问题了,所以都统一用html后缀了.

- `yaml`与`yml`也是同样的道理.

接着我们要知道的是,html元素内部是**不存在逗号**的,**只能通过空白**来区分两个属性或者属性的内部值,而且,属性值可以写引号但也可以不写,但如果不写引号的话,当有多个属性时就非常混乱,所以官方推荐全部加上引号,而且是双引号.

```html
<button type="submit" id="main-auth-btn" class="ui-button primary-style large-size" name="login-action" value="execute" title="点击进行登录" aria-label="登录账户" data-api-endpoint="/v1/auth" data-loading="false" disabled>立即登录</button>
```

由于下面的属性中style本质上是**css代码**,遵循css语法,故可以出现分号:
```html
<button class="btn btn-primary btn-large" style="color: white; background-color: blue; padding: 10px 20px;">
  Click Me
</button>
```
最后,特别要注意的是,html里的标签是**大小写不敏感**的,官方推荐**全都小写**


## 主体架构
一个简化的html文档如下所示:
```html
<!DOCTYPE html>

<html>

<head>
<title>Page Title</title>
</head>

<body>
<h1>My First Heading</h1>
<p>My first paragraph.</p>
</body>

</html>
```
我做了相应的缩进以让层次划分更加明显:

1. 首行的`<!DOCTYPE html>`声明: 历史遗留语法,供浏览器识别这个文档为html类型,无论如何都必须写,而且写在第一行.
2. 整个网页内容由`<html><html/>`包裹,尽管大家都知道这是html文档了,但还是需要用html标签来声明.
3. 整个网页内容分成两部分: **head与body**,head部分包括了网页的各种属性,供搜索引擎和浏览器识别;body部分包括了整个网页的内容,决定了渲染的用户界面

## 文本表示
**标题**
```html
<h1>This is heading 1</h1>
<h2>This is heading 2</h2>
<h3>This is heading 3</h3>
```
- h对应的英文全称为Heading


**段落**
```html
<p>This is a paragraph.</p>
<p>This is another paragraph.</p>
```
- p对应的英文全称为paragraph

需要注意的是,p标签会自动过滤多余的空格和换行,根据窗口大小自动渲染文本:
![alt text](PixPin_2026-04-26_23-38-28.webp)


## html常用属性
### style
```html
<p style="color:red;">This is a red paragraph.</p>
```
- 一般都通过css来操纵样式,没必要用这个属性

### lang
```html
<!DOCTYPE html>
<html lang="zh-CN">
<body>
...
</body>
</html>
```
帮助搜索引擎和爬虫了解该文章所用的语言,我们平常浏览页面时弹出的是否翻译此页面,就是根据这个属性来判断,当前页面语言和浏览器默认语言是否相同的.
### class
为css提供一个访问入口,css通过`.`前缀来绑定dom中的class属性:
```html
<!DOCTYPE html>
<html>
<head>
<style>
.city {
  background-color: tomato;
  color: white;
  border: 2px solid black;
  margin: 20px;
  padding: 20px;
}
</style>
</head>
<body>

<div class="city">
  <h2>London</h2>
  <p>London is the capital of England.</p>
</div>

<div class="city">
  <h2>Paris</h2>
  <p>Paris is the capital of France.</p>
</div>

<div class="city">
  <h2>Tokyo</h2>
  <p>Tokyo is the capital of Japan.</p>
</div>

</body>
</html>
```

**效果**

![alt text](PixPin_2026-04-28_16-16-45.webp)

class有以下特点:

1. **一个元素可以有多个class,一个class也可以被多个元素使用**.
2. **后定义的class会覆盖先定义的class**

### id
显然,如果只有class的话,当两个标签的排版只有些微的不同时,我们是不希望重新写一个只有些微不同的class的,所以,html引入了**id**属性,用于额外标识标签元素,从而实现元素的精细化操控.

在同一个HTML页面中,ID必须是唯一的(类似身份证号),并且可被css通过`#`前缀来绑定:

![alt text](PixPin_2026-04-28_16-23-03.webp)

如前所说,我们引入id属性是为了对标签进行独特的修改,那么当一个元素同时拥有 id 和 class，且两者定义了同一个属性时,**id 的样式会覆盖 class 的样式**,这与它们在代码中出现的先后顺序无关.
## 中断符
### hr
`<hr>`表示界面的中断,会在文本中间划一道分割线.通常用它来分割内容:
![alt text](PixPin_2026-04-26_23-41-12.webp)
- hr: Horizontal Rule,水平分割线
### br
`<br>`表示换行,在文本中强制插入一个换行符,但不会开启新的段落:
![alt text](PixPin_2026-04-26_23-44-10.webp)

- br: Line Break,换行
## 排版元素表示
主要涉及: 表格/列表/容器/按钮
### 表格
![alt text](PixPin_2026-04-28_15-44-56.webp)
在table标签中`tr`意思是**table row**,`td`意思是**table data**,`td`意思是`table head`,都很好理解
### 列表
看首字母即可知道这几个元素的意思:

- ul: **unordered list**
- ol: **ordered list**
- dl: **description list**
- li: **list item**
- dt: **description term**(不用description item的原因可能是怕与div标签搞混)
- dd: **description details**

**分点列表(没有序号)**

```html
<ul>
  <li>Coffee</li>
  <li>Tea</li>
  <li>Milk</li>
</ul>
```
![alt text](PixPin_2026-04-28_15-58-13.webp)

**数字列表**

```html
<ol>
  <li>Coffee</li>
  <li>Tea</li>
  <li>Milk</li>
</ol>
```
![alt text](PixPin_2026-04-28_15-59-29.webp)

**加入描述的列表**

```html
<dl>
  <dt>Coffee</dt>
  <dd>- black hot drink</dd>
  <dt>Milk</dt>
  <dd>- white cold drink</dd>
</dl>
```

![alt text](PixPin_2026-04-28_16-00-12.webp)
#### 嵌套列表
![alt text](PixPin_2026-04-28_16-03-20.webp)
### 容器(div)
>The <div> element is by default a **block element**, meaning that **it takes all available width**, and comes with line breaks before and after.

![alt text](PixPin_2026-04-28_16-05-30.webp)

之所以div叫做容器,因为它可以装载html元素成一个单独的分块,方便被css和js处理并渲染:

![alt text](PixPin_2026-04-28_16-07-00.webp)

### span
该标签没有任何实质作用,仅仅是将一部分文本标记起来,方便通过设定class属性来供css和js操控:

![alt text](PixPin_2026-04-28_16-14-35.webp)

### 按钮
```html
<button>Click Me</button>
```

- 不太懂html制定者的标准是什么,image五个字母要变成img,button六个字母却不变成btn甚至bt...

button最强大的地方在于可以通过onclick属性绑定js:
```html
<button onclick="alert('Hello!')">Click Me</button>
```


## 链接表示
**超文本链接**
```html
<a href="https://www.w3schools.com">This is a link</a>
```
- href: Hypertext Reference,意为跳转链接

>**a标签的详细说明**
>
>a对应的全称为anchor(锚点),指代互联网海洋中相互勾连的节点,你可以从一个锚点跳转到另一个锚点.

**图像链接**
```html
<img src="w3schools.jpg" alt="W3Schools.com" width="104" height="142">
```
这是我们目前为止看到的第一个不需要闭合的标签,因为我们无法用文本来指代图像.

- **src**: source,图片路径,可以是文件路径也可以是网页路径
- **alt**: **Alternate Text**,备用文本,以防图片无法正常显示时出现的占用文字,同时可以帮助盲人和爬虫理解.
- 宽高比通常由css设置,没必要在html中指定




## 嵌入文本文件/音视频
### iframe
>**iframe**用于在html内部展示另一个html文件或者其他文本文件.

- iframe: **inline frame**,行内框架
**基本结构**
```html
<iframe src="url" title="description"></iframe>
```

![alt text](PixPin_2026-04-29_14-22-25.webp)

#### 流媒体展示
由于可以直接展示html网页,自然也就可以展示流媒体(B站,Youtube)中的音视频:
```html
<iframe 
    src="//player.bilibili.com/player.html?bvid=BV1yVQFBNEPn&page=1&high_quality=1&danmaku=0" 
    allow="autoplay; fullscreen; encrypted-media" 
    allowfullscreen="true" 
    width="100%" 
    height="500" 
    frameborder="0">
</iframe>
```

<iframe 
    src="//player.bilibili.com/player.html?bvid=BV1yVQFBNEPn&page=1&high_quality=1&danmaku=0" 
    allow="autoplay; fullscreen; encrypted-media" 
    allowfullscreen="true" 
    width="100%" 
    height="500" 
    frameborder="0">
</iframe>


### video
video的用法与image别无二致
```html
<video 
    src="https://www.w3schools.com/html/mov_bbb.mp4" 
    controls 
    width="640">
    您的浏览器不支持 video 标签。
</video>
```

<video 
    src="https://www.w3schools.com/html/mov_bbb.mp4" 
    controls 
    width="640">
    您的浏览器不支持 video 标签。
</video>

### audio
用法别无二致:

```html
<audio controls>
  <source src="horse.ogg" type="audio/ogg">
  <source src="horse.mp3" type="audio/mpeg">
Your browser does not support the audio element.
</audio>
```
值得注意的是,我们这里使用了source内部标签而没有将src作为父标签`audio`的属性,source标签用于为浏览器提供多样的选择,自上而下扫描第一个可用的源.
## 表单(form)
>早期不使用js的时候我们只能通过html中的表单(form)元素来提交用户输入,所以还是有必要了解的.
## Head部分的标签
### 概览
| Tag        | Description                                                           |
| :--------- | :-------------------------------------------------------------------- |
| `<head>`   | Defines information about the document                                |
| `<title>`  | Defines the title of a document                                       |
| `<base>`   | Defines a default address or a default target for all links on a page |
| `<link>`   | Defines the relationship between a document and an external resource  |
| `<meta>`   | Defines metadata about an HTML document                               |
| `<script>` | Defines a client-side script                                          |
| `<style>`  | Defines style information for a document                              |

下面开始逐个解释这些标签:

### **title**
功能:
1. defines a title in the browser toolbar
2. provides a title for the page when it is added to favorites
3. displays a title **for the page in search engine-results**

```html
<!DOCTYPE html>
<html>
<head>
  <title>A Meaningful Page Title</title>
</head>
<body>

The content of the document......

</body>
</html>
```

### **style**
功能:

- 写入内嵌css

```html
<style>
  body {background-color: powderblue;}
  h1 {color: red;}
  p {color: blue;}
</style>
```

### **link**
功能:

1. 引入外部静态文件

说明:

1. rel: relationship,点名这个文件的格式和功能
2. type: 对于图像等格式众多的文件,需要额外说明它的具体格式

引入外部css文件
```html
<link rel="stylesheet" href="mystyle.css">
```
引入标题栏的图标:
```html
<!DOCTYPE html>
<html>
<head>
  <title>My Page Title</title>
  <link rel="icon" type="image/x-icon" href="/images/favicon.ico">
</head>
<body>
<!-- omitted -->
</body>
</html>
```

### **meta**

功能:

1. pecify the character set, page description, keywords, author of the document, and viewport settings.
2. 不会展示在页面上,仅供浏览器/搜索引擎识别和处理

Define the character set used:

```html
<meta charset="UTF-8">
```

Define keywords for search engines:

```html
<meta name="keywords" content="HTML, CSS, JavaScript">
```

Define a description of your web page:

```html
<meta name="description" content="Free Web tutorials">
```

Define the author of a page:

```html
<meta name="author" content="John Doe">
```

Refresh document every 30 seconds:

```html
<meta http-equiv="refresh" content="30">
```

Setting the viewport to make your website look good on all devices:

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

### script
由于html的某些设计问题,js代码没有像css一样用link进行导入,而是单独引入了一个标签script:

```html
<script>
function myFunction() {
  document.getElementById("demo").innerHTML = "Hello JavaScript!";
}
</script>
```
## body部分的其他标签
## 总结
常用的html元素就这些了,但我们一直没有深入探讨html元素的原生style修饰,那是因为在html中指明样式太麻烦了,所以在html诞生不久之后,又一个划时代的标记语言: CSS,产生了.

# CSS
>[wiki](https://en.wikipedia.org/wiki/CSS)
**Cascading Style Sheets** (CSS) is a style sheet language used for specifying the presentation and styling of a document written in a markup language, such as **HTML or XML**.

- **css是因为html中的style写法很麻烦才发明出来的**
## CSS历史
### 单体版本阶段 (1994 - 2011)
此阶段 CSS 作为一个整体规范进行线性迭代。

* **1994 - 1996：诞生与 CSS1**
    * **1994**：Håkon Wium Lie 提出 CSS 构想。
    * **1996**：**CSS 1.0** 正式发布。定义了基础的文字颜色、字体和盒模型。
* **1998：功能扩张与 CSS2**
    * 发布 **CSS 2.0**。引入了 `absolute/relative` 定位、`z-index` 及媒体类型（如打印样式）。
* **2011：基石奠定与 CSS 2.1**
    * 经过 13 年的浏览器兼容性博弈与修正，**CSS 2.1** 发布。它删除了未被实现的特性，成为现代 CSS 的核心基石。


### 模块化演进阶段 (1999 - 至今)
自 CSS3 起，W3C 废弃了整体版本号，将规范拆分为数十个独立的**模块 (Modules)**。

* **1999 - 2011：CSS3 模块化开启**
    * 规范被拆分为“选择器”、“颜色”、“盒模型”等模块。
    * **版本逻辑**：在 CSS2.1 已有的功能基础上，新版本编号从 **Level 3** 开始（即常说的 CSS3）。
* **2012 - 2020：高版本模块迭代 (CSS4/5 概念)**
    * 不存在整体的“CSS4”文件。
    * **Level 4 演进**：当 Level 3 模块开发完成后，自动进入 **Level 4**（如 `Selectors Level 4` 引入了 `:has()` 选择器）。
    * **Level 1 起步**：对于全新特性（如 Flexbox、Grid），版本号从 **Level 1** 开始。
* **2021 - 2026：年度快照 (Snapshots)**
    * W3C 定期发布 **CSS Snapshot**，定义当前已稳定并被主流浏览器广泛支持的模块集合，作为开发者的实践参考。

看得出来CSS本身的生态比起HTML来更加混乱,甚至没有一个统一的版本号.
# JavaScript
>[wiki](https://en.wikipedia.org/wiki/JavaScript)
JS是一门让静态网页`动起来`的脚本语言,CSS和HTML只用于展示内容,而JS用于真正的**用户交互**.

## JS历史
### 1. 诞生与混乱期 (1995 - 1996)
* **1995年5月**：Brendan Eich 在 Netscape 仅用 10 天设计出原型，初名 **Mocha**。
* **1995年9月**：更名为 **LiveScript** 随 Navigator 2.0 beta 发布。
* **1995年12月**：Netscape 与 Sun 联手，将其正式定名为 **JavaScript**（纯粹的营销策略，与 Java 无关）。
* **1996年**：微软发布 **JScript**（IE3.0），浏览器战争爆发，兼容性碎片化开始。



### 2. 标准化初期 (1997 - 1999)
* **1997年6月**：**ECMAScript 1 (ES1)** 发布，确立了语言的标准核心。
* **1998年6月**：**ES2** 发布，主要与 ISO 国际标准对齐。
* **1999年12月**：**ES3** 发布。引入正则表达式、try/catch、`switch` 等现代语法，成为此后十年网页脚本的基石。



### 3. 停滞与再生期 (2000 - 2009)
* **2000 - 2008年**：由于微软 IE 占据 95% 市场份额，标准制定陷入僵局，激进的 **ES4** 提案因过于复杂被废弃。
* **2005年**：**AJAX** 概念提出，JS 从“弹窗小工具”转型为开发 Web 应用的核心。
* **2008年**：Google 发布 **Chrome (V8 引擎)**，引入 JIT 编译技术，JS 运行速度实现量级跨越。
* **2009年**：**Node.js** 诞生，JS 脱离浏览器进入服务器端领域。
* **2009年12月**：**ES5** 正式发布。增加“严格模式”、JSON 支持及数组原型方法（如 `map`, `filter`）。



### 4. 现代爆发期 (2015 - 至今)
* **2015年6月**：**ES6 (ECMAScript 2015)** 发布。这是历史上最大的更新，引入了类 (Class)、箭头函数、模块化 (Modules)、Promise 等现代编程特性。
* **年度迭代机制**：自 ES6 后，TC39 委员会改为每年发布一个小版本，不再通过版本号（如 ES7/8）而是通过年份命名。
    * **ES2016 - ES2023**：持续引入 `async/await`、可选链 (`?.`)、空值合并 (`??`) 等特性。

## JS语法
JS的设计一开始非常糟糕,现在的良好架构都是在后来加上的,所以我们只学习最新的语法即可.
### 基础语法

### 函数

### OOP
### 模块
# 浏览器引擎介绍
>三件套是如何被渲染的?我们常说的浏览器内核是什么?运行时又是什么?这几个问题是这一章节的核心要点.

# JavaScript XML

# Typescript

# TypeScript XML