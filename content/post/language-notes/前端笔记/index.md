---
title: 前端笔记
date: 2026-04-30T09:56:06+08:00
tags: 
- 前端
image: 60155475_p0-ゆき.webp
math: true
---
# 前端概览
- [W3schools](https://www.w3schools.com/css/css_intro.asp)
  - 本文的主要参考教程
- [wiki](https://en.wikipedia.org/wiki/Front_end_and_back_end)

>前端与后端是一对概念,前端用于指代用户交互层,后端用于指代数据处理层

前端最令人遗憾的地方在于,早期的浏览器大战使得网络生态混乱不堪,不同企业之间高筑护城河,诞生了各种各样的框架和新特性,让新入门的程序员一筹莫展,不知道学什么好.

不管怎样,我还是按照前端三件套到JSX,TSX的步骤来学习,从而更深入的理解前端的方方面面.
# HTML
**Hypertext Markup Language**(HTML)是一门用来处理网页文档内容的标记语言,通过dom(Document Object Model)将HTML中的元素映射到引擎中,从而展示出你现在看到的网页.
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
video的用法与image标签别无二致
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

### form标签
该标签作为所有输入标签的容器,不会单独出现
### input标签
最常用的输入标签,根据内部的type属性来决定输入的内容,下面是一些常用的type属性值:
| Type                      | Description                                                      |
| :------------------------ | :--------------------------------------------------------------- |
| `<input type="text">`     | Displays a single-line text input field                          |
| `<input type="radio">`    | Displays a radio button (for selecting one of many choices)      |
| `<input type="checkbox">` | Displays a checkbox (for selecting zero or more of many choices) |
| `<input type="submit">`   | Displays a submit button (for submitting the form)               |
| `<input type="button">`   | Displays a clickable button                                      |
### name属性
除了submit类型外,每个input标签都需要有一个**name属性**才可以被发送到服务器并被识别:
```html
<form action="/action_page.php">
  <label for="fname">First name:</label><br>
  <input type="text" id="fname" value="John"><br><br>
  <input type="submit" value="Submit">
</form>
```
### label标签
该标签用于显示输入提示,因为**input标签是无闭合的**,所以需要额外的信息来提示用户输入:
```html
<form>
  <label for="fname">First name:</label><br>
  <input type="text" id="fname" name="fname"><br>
  <label for="lname">Last name:</label><br>
  <input type="text" id="lname" name="lname">
</form>
```

**渲染出来的界面如下:**

<form>
  <label for="fname">First name:</label><br>
  <input type="text" id="fname" name="fname"><br>
  <label for="lname">Last name:</label><br>
  <input type="text" id="lname" name="lname">
</form>


我们可以看到label标签中有个for属性,可以看到它与input标签中的id属性值相同.它主要用于将label和input标签绑定起来,当点击标签文素时,**浏览器可以自动帮你将光标聚焦到输入框内**.

事实上,尽管form有很多功能还没提及,但了解到这里就够了,能够看懂JSX中的输入标签即可.

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
## body部分的语义标签(semantic elements)
这一部分主要是谈一下一些常用的语义标签,它们基本都可以在JSX中找到对应的元素

### section标签
将文档分节,一般用在以下位置:

1. Chapters
2. Introduction
3. News items
4. Contact information

```html
<section>
<h1>WWF</h1>
<p>The World Wide Fund for Nature (WWF) is an international organization working on issues regarding the conservation, research and restoration of the environment, formerly named the World Wildlife Fund. WWF was founded in 1961.</p>
</section>

<section>
<h1>WWF's Panda symbol</h1>
<p>The Panda has become the symbol of WWF. The well-known panda logo of WWF originated from a panda named Chi Chi that was transferred from the Beijing Zoo to the London Zoo in the same year of the establishment of WWF.</p>
</section>
```

- 没什么难懂的

### article标签
用于展示文章和评论:

```html
<article>
<h2>Google Chrome</h2>
<p>Google Chrome is a web browser developed by Google, released in 2008. Chrome is the world's most popular web browser today!</p>
</article>

<article>
<h2>Mozilla Firefox</h2>
<p>Mozilla Firefox is an open-source web browser developed by Mozilla. Firefox has been the second most popular web browser since January, 2018.</p>
</article>

<article>
<h2>Microsoft Edge</h2>
<p>Microsoft Edge is a web browser developed by Microsoft, released in 2015. Microsoft Edge replaced Internet Explorer.</p>
</article>
```
### header标签
展示引言:
```html
<article>
  <header>
    <h1>What Does WWF Do?</h1>
    <p>WWF's mission:</p>
  </header>
  <p>WWF's mission is to stop the degradation of our planet's natural environment,
  and build a future in which humans live in harmony with nature.</p>
</article>
```
### footer标签
展示脚注:
```html
<footer>
  <p>Author: Hege Refsnes</p>
  <p><a href="mailto:hege@example.com">hege@example.com</a></p>
</footer>
```
### nav标签
展示导航链接:

```html
<nav>
  <a href="/html/">HTML</a> |
  <a href="/css/">CSS</a> |
  <a href="/js/">JavaScript</a> |
  <a href="/jquery/">jQuery</a>
</nav>
```
### figure与figcaption标签
由于img,video等标签无法展示说明文字或者标题,只能通过div容器的包装实现假标题,所以HTML5中引入了这figure和figcaption标签,用于更好地展示图表:

```html
<figure>
  <img src="pic_trulli.jpg" alt="Trulli">
  <figcaption>Fig1. - Trulli, Puglia, Italy.</figcaption>
</figure>
```

![alt text](PixPin_2026-04-30_12-35-25.webp)


## 总结
首先我们需要知道的是,大多数html标签都是闭合的,需要写成类似`<p> </p>`的格式,少数标签如img,input,meta和换行符才不需要闭合.

其次,我们一直没有深入探讨html元素的原生style修饰,那是因为在html中指明样式太麻烦了,所以在html诞生不久之后,又一个划时代的标记语言: CSS,产生了.

# CSS
- [wiki](https://en.wikipedia.org/wiki/CSS)

>**Cascading Style Sheets** (CSS) is a style sheet language used for specifying the presentation and styling of a document written in a markup language, such as **HTML or XML**.

- 总结一下就是,**css是因为html中的style写法很麻烦才发明出来的**

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

## CSS语法与CSS选择器
一个常见的css写法如下:
![alt text](PixPin_2026-04-30_12-38-22.webp)

- selector: 选择器,指向被修饰的元素
- declaration: 修饰语句
- property: 修饰所用的属性
- value: 属性值

可以看到css用分号将多个修饰语句隔开,用`{}`隔离不同的修饰段,比起html语义更加清晰了:

```css
p {
  color: red;
  text-align: center;
}
```
### 选择器
#### 标签元素的修饰
该方法通常用于全局样式的处理,例如下面的代码会将所有的p标签变红:
```css
p {
  text-align: center;
  color: red;
}
```
#### id和class属性的修饰
id选择器只会处理单个标签:
```css
#para1 {
  text-align: center;
  color: red;
}
```
而class选择器处理一类标签:
```css
/* In this example all HTML elements with class="center" will be red and center-aligned:  */
.center {
  text-align: center;
  color: red;
}
```
#### 多个元素的选择
通配符`*`会影响**html中的所有元素**:
```css
* {
  text-align: center;
  color: blue;
}
```

而有时候如果多个元素的处理方法相同的话:
```css
h1 {
  text-align: center;
  color: red;
}

h2 {
  text-align: center;
  color: red;
}

p {
  text-align: center;
  color: red;
}
```
显然这么写太麻烦了,我们可以合并一下变成下面这样:
```css
h1, h2, p {
  text-align: center;
  color: red;
}
```

### 层叠的css
之所以CSS叫做**Cascading Style Sheets**,是因为当一个html中含有多个css时,它按照以下顺序解读:
1. Inline style (inside an HTML element)
2. External and internal style sheets (in the head section)
   1. 后定义的样式表属性会覆盖先定义的样式表中的相同属性
3. Browser default
## CSS调色
### 颜色属性名
**color**,调整标签中文本的颜色:
```html
<h1 style="color:Tomato;">Hello World</h1>
<p style="color:DodgerBlue;">Lorem ipsum...</p>
<p style="color:MediumSeaGreen;">Ut wisi enim...</p>
```

**border**,调整标签的边框颜色:
![alt text](PixPin_2026-05-01_22-40-11.webp)

**background-color**,调整标签背景颜色:

```html
<h1 style="background-color:rgb(255, 99, 71);">...</h1>
<h1 style="background-color:#ff6347;">...</h1>
<h1 style="background-color:hsl(9, 100%, 64%);">...</h1>

<h1 style="background-color:rgba(255, 99, 71, 0.5);">...</h1>
<h1 style="background-color:hsla(9, 100%, 64%, 0.5);">...</h1>
```

效果:
![alt text](PixPin_2026-05-01_23-07-42.webp)


### 调色方法
#### 通过颜色名调色
```html
<h1 style="color:Tomato;">Hello World</h1>
<p style="color:DodgerBlue;">Lorem ipsum...</p>
<p style="color:MediumSeaGreen;">Ut wisi enim...</p>
```
![alt text](PixPin_2026-05-01_21-58-26.webp)
#### 通过RGB调色
**RGB**: red,green,blue,通过调整三原色的数值(取值为0-255),我们可以展示所有的颜色.
```html
<!DOCTYPE html>
<html>
<body>

<h1>Specify colors using RGB values</h1>

<h2 style="background-color:rgb(255, 0, 0);">rgb(255, 0, 0)</h2>
<h2 style="background-color:rgb(0, 0, 255);">rgb(0, 0, 255)</h2>
<h2 style="background-color:rgb(60, 179, 113);">rgb(60, 179, 113)</h2>
<h2 style="background-color:rgb(238, 130, 238);">rgb(238, 130, 238)</h2>
<h2 style="background-color:rgb(255, 165, 0);">rgb(255, 165, 0)</h2>
<h2 style="background-color:rgb(106, 90, 205);">rgb(106, 90, 205)</h2>

</body>
</html>
```
**效果**
![alt text](PixPin_2026-05-01_23-13-42.webp)

**RGBA**: red,green,blue,alpha,其中,alpha用于调整背景颜色的**不透明度**,取值为0-1.

![alt text](PixPin_2026-05-01_23-24-22.webp)

RGBA本质上是线性插值运算:

$$C_o = \alpha C_f + (1 - \alpha) C_b$$
其中：
*   $C_o$：输出颜色（Output）
*   $C_f$：前景颜色（Foreground）
*   $C_b$：背景颜色（Background）
*   $\alpha$：[0, 1] 之间的取值

#### 通过HEX调色
HEX: **hexadecimal**,用十六进制来表示之前的RGB,那么每种原色就需要两位数字,相当于`#rrggbb`:
![alt text](PixPin_2026-05-02_13-00-52.webp)

由于个位数上的差别不会对颜色有多大的影响,故我们可以使用三位数的缩写:
```css
body {
  background-color: #fc9; /* same as #ffcc99 */
}

h1 {
  color: #f0f; /* same as #ff00ff */
}

p {
  color: #b58; /* same as #bb5588 */
}
```
#### 通过HSL调色
hsl,**(hue, saturation, lightness)**:

- Hue is **a degree on the color wheel** (from 0 to 360):
  - 0 (or 360) is red
  - 120 is green
  - 240 is blue
- Saturation is a percentage value: 0% means a shade of gray, and 100% is the full color.
  - 灰度层,相当于调整颜色的鲜艳度
- Lightness is also a percentage; 0% is black, 50% is neither light or dark, 100% is white.
  - 亮度层,相当于调整颜色的打光度

![alt text](PixPin_2026-05-02_13-06-02.webp)
## CSS调整背景
### 调整背景颜色
**background-color**可以对所有的html元素生效:

```css
h1 {
  background-color: green;
}

div {
  background-color: lightblue;
}

p {
  background-color: yellow;
}
```

还可以在background-color的基础上调整背景颜色的透明度:
```css
div {
  background-color: green;
  opacity: 0.3;
}
```

![alt text](PixPin_2026-05-03_10-06-49.webp)

### 设置背景图像

我们需要通过url参数来定位图像
```css
body {
  background-image: url("paper.gif");
}
/* 这里的引号不是必须的,但可以提升兼容性 */
```

By default, the image is repeated so it covers the entire element:
![alt text](PixPin_2026-05-03_10-10-43.webp)

因此,我们需要对图像的默认重复做出调整,比如调整为只在水平方向/垂直方向重复,或者调整为不重复:
```css
body {
  background-image: url("gradient_bg.png");
  background-repeat: repeat-x;
}
```

```css
body {
  background-image: url("img_tree.png");
  background-repeat: no-repeat;
}
```
![alt text](PixPin_2026-05-03_10-13-10.webp)

我们还可以设置图像的位置:
```css
body {
  background-image: url("img_tree.png");
  background-repeat: no-repeat;
  background-position: right top;
}
```
![alt text](PixPin_2026-05-03_10-14-16.webp)

还可以让图像随着页面一起滚动:
```css
body {
  background-image: url("img_tree.png");
  background-repeat: no-repeat;
  background-position: right top;
  background-attachment: fixed;
}
```

四个参数一个个写太麻烦了,所以我们可以全都合并到background参数里面:
```css
body {
  background: #ffffff url("img_tree.png") no-repeat right top;
}
```

The `background` property is a shorthand property for the following properties:

*   **background-color**
*   **background-image**
*   **background-position**
*   **background-size**
*   **background-repeat**
*   **background-attachment**
*   **background-origin**
*   **background-clip**

If some of the property values are missing, they will be set to their initial (default) values.
## CSS调整边界/页边距/空白(待补充)
## 高级CSS选择器
### 选择符
- [简单有效的知乎专栏](https://zhuanlan.zhihu.com/p/180011240)
#### 空格
选择某元素内的所有子元素
```css
<style type="text/css">
	h1 strong {
		color: red;
	}
</style>

<body>
	<h1>
		<strong>一代子元素</strong>
	</h1>
	<h1>
		<span>
			<strong>二代子元素</strong>
		</span>
	</h1>
</body>
```
- 上述的两个strong标签都会被选中

#### 大于号
选择某元素后的一代子元素
```css
<style type="text/css">
	h1>strong {
		color: red;
	}
</style>

<body>
	<h1>
		<strong>一代子元素</strong>
	</h1>
	<h1>
		<span>
			<strong>二代子元素</strong>
		</span>
	</h1>
</body>
```
- 只有一代的strong标签会被选中


### 合并选择
我们可以将普通的选择和类选择合并,变成这样:
```css
p.dotted {outline-style: dotted;}
```
- 上述代码只会选择具有dotted类的p标签.
### 伪类
css中有一类关键词被称为**伪类(Pseudo-classes)**,它可以加在选择器的后面,达成一些特殊的目的,如:
1. Style an element when a user moves the mouse over it
2. Style visited and unvisited links differently
3. Style an element when it gets focus
4. Style valid/invalid/required/optional form elements
5. Style an element that is the first child of its parent

语法如下,使用了冒号:
```css
selector:pseudo-class-name {
  CSS properties
}
```

常用的一些伪类如下:
*   `:hover`：鼠标指针悬停在元素上时。
*   `:active`：元素被激活时（如鼠标按下未释放）。
*   `:focus`：元素获得焦点时（如通过 Tab 键选中输入框）。
*   `:visited`：链接已被访问过。
*   
*   `:disabled`：匹配禁用的表单元素。
*   `:enabled`：匹配可用的表单元素。
*   `:checked`：匹配选中的复选框（checkbox）或单选按钮（radio）。
*   
*   `:first-child`：匹配其父元素的第一个子元素。
*   `:last-child`：匹配其父元素的最后一个子元素。
*   `:nth-child(n)`：匹配其父元素的第 n 个子元素（可用 `2n` 表示偶数，`odd` 表示奇数）。
*   `:only-child`：匹配父元素中唯一的子元素。

例如,我们可以这样调整a标签:
```css
/* unvisited link */
a:link {
  color: #FF0000;
}

/* visited link */
a:visited {
  color: #00FF00;
}

/* mouse over link */
a:hover {
  color: #FF00FF;
}

/* selected link */
a:active {
  color: #0000FF;
}
```

例如,选择特定的子元素:
![alt text](PixPin_2026-05-05_16-47-43.webp)

### 伪元素
另一类更少见的关键词是**伪元素（Pseudo-Elements）**,它主要用来更改一段文本的特定部分,例如:
1. Style the first letter or first line, of an element
2. Style the user-selected portion of an element
3. Style the viewbox behind a dialog box

语法如下:
```css
selector::pseudo-element-name {
  CSS properties
}
```

例如,我们可以只渲染一个段落的第一行:
```css
p::first-line {
  color: red;
  font-variant: small-caps;
  font-size: 19px;  
}
```
![alt text](PixPin_2026-05-05_16-53-44.webp)


我们偶尔会看到CSS代码中出现`@`这个符号,它的作用十分广大,属于CSS的高级语法
## @规则


# JavaScript
- [wiki](https://en.wikipedia.org/wiki/JavaScript)

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
- [js.info教程](https://zh.javascript.info/)
  - 很全面,但会谈到很多不必要的琐碎知识点,建议该跳过的就跳过,不然看的很累
JS的设计一开始非常糟糕,现在的良好架构都是在后来加上的,所以我们只学习最新的语法即可,而不用管哪些琐碎的老旧知识点.

### 基础语法
- 学js前建议先入门一个后端语言如cpp和python,不然js的混乱语法会把你搞得很懵
#### 变量声明与定义
普通变量的定义如下:
```js
// 先声明再赋值

let message;
message = 'Hello'; // 将字符串 'Hello' 保存在名为 message 的变量中

// 定义多个变量的两种方法

let user = 'John', age = 25, message = 'Hello';

let user = 'John';
let age = 25;
let message = 'Hello';
```

常量定义如下:
```js
const myBirthday = '18.04.1982';

myBirthday = '01.01.2001'; // 错误，不能对常量重新赋值
```
#### 变量类型
由于JS和python一样本身是动态类型的,所以一个变量可以被赋不同类型的值多次,需要重点理解的是null和undefined类型,它们是一类特殊的值,也是js的一大难点.
##### null与undefined
- undefined: 未被赋值,表示该值未初始化.
- null: 空值,通常用在占位符和函数的返回值中.
#### 严格相等: ===运算符
普通的相等性检查存在一个问题,它不能区分0和false,也不能区分空字符串和flase,原因是`==`会在进行比较时先进行类型转换.

最值得诟病的就是以下这个特性:

```js
null == undefined //true
null == 0;           // false
undefined == false;  // false
```

- 而当使用其他数学式(<,>,<=,>=)时,null被转换成0,undefined被转换成`NaN`,`NaN`值与任何值进行大小比较都会返回false


因此,js又设计了`===`运算符,在比较时不进行转换,而是直接进行比较.

所以下面这个结果就比较正常:
```js
alert( null === undefined ); // false
```

因此,我们需要在恰当的时机使用`===`,从而规避`undefined`和`null`带来的麻烦.
#### 问号运算符的新特性
ECMAScript 2020 引入了`?.`和`??`运算符,由于这两个运算符特别强大,不久便被广泛用在前端代码中,所以需要特别了解.

##### 可选链运算符: ?.
- 功能: 如果`?.`左侧的值为`null`或者`undefined`,表达式将短路并返回`undefined`,而不会报错

**使用.会导致报错**
```js
let user = {}; // 一个没有 "address" 属性的 user 对象

alert(user.address.street); // Error!
```

**而使用?.就不会**
```js
let user = {}; // user 没有 address 属性

alert( user?.address?.street ); // undefined（不报错）
```

##### 空值合并运算符: ??
- 功能: 当左侧的操作数为null或者undefined时,返回右侧操作数,否则返回左侧操作数

至于为什么在有`||`的情况下还要推出`??`,是因为`|| `会在左侧为任何“虚值”（如 0, "", false和 null/undefined）时返回右侧，而 `??` 只针对 null 和 undefined。
```js
const count = 0;
const result1 = count || 10; // 结果为 10，因为 0 是虚值
const result2 = count ?? 10; // 结果为 0，因为 0 不是 null 或 undefined
```

如此一来,即便我们对于某个变量的值赋为0和空字符串,也可以正常运作,而不是在使用`||`的时候被替换成默认值.
#### 反引号
js中的单双引号都不支持跨行字符串,也不支持变量嵌入,而反引号可以做到上述两点,并在JSX和TSX中发挥出非常大的威力:

```js
function sum(a, b) {
  return a + b;
}

alert(`1 + 2 = ${sum(1, 2)}.`); // 1 + 2 = 3.

let guestList = `Guests:
 * John
 * Pete
 * Mary
`;

alert(guestList); // 客人清单，多行
```
### 函数
#### 函数的创建
有三种语法可以创建函数:
1. 函数声明
2. 函数表达式
3. 箭头函数(ES6引入)
**函数声明**
```js
function sayHi() {
  alert( "Hello" );
}
// 函数声明没有分号
```

**函数表达式**
```js
let sayHi = function() {
  alert( "Hello" );
};
// 写成表达式要有分号
```
**箭头函数**
```js
let sum = (a, b) => a + b;

/* 这个箭头函数是下面这个函数的更短的版本：

let sum = function(a, b) {
  return a + b;
};
*/

alert( sum(1, 2) ); // 3
```

如果只有一个参数,我们还可以省略参数外的圆括号:
```js
let double = n => n * 2;
// 差不多等同于：let double = function(n) { return n * 2 }

alert( double(3) ); // 6
```

但如果是多行函数,我们需要在函数体外加上花括号,并使用return来返回值:
```js
let sum = (a, b) => {  // 花括号表示开始一个多行函数
  let result = a + b;
  return result; // 如果我们使用了花括号，那么我们需要一个显式的 “return”
};

alert( sum(1, 2) ); // 3
```
#### 将函数作为参数
js的一大特性就是可以**将函数作为参数**:
```js
function ask(question, yes, no) {
  if (confirm(question)) yes()
  else no();
}

function showOk() {
  alert( "You agreed." );
}

function showCancel() {
  alert( "You canceled the execution." );
}

// 用法：函数 showOk 和 showCancel 被作为参数传入到 ask
ask("Do you agree?", showOk, showCancel);
```
- 函数 showOk 和 showCancel被称为**回调(callback)函数**

我们可以在调用时定义函数,不需要再写函数名字,这被称为**匿名函数**:
```js
function ask(question, yes, no) {
  if (confirm(question)) yes()
  else no();
}

ask(
  "Do you agree?",
  function() { alert("You agreed."); },
  function() { alert("You canceled the execution."); }
);
```


### 对象
#### 创建对象
有两种方法来创建对象:
```js
let user = new Object(); // “构造函数” 的语法
let user = {};  // “字面量” 的语法
```
>第一种写法一看就知道是为了取悦Java,标榜自己是JavaScipt才诞生的,而下面一种写法与c语言的结构体很像,事实上也确实如此.

一个常见的js对象如下:
```js
let user = {     // 一个对象
  name: "John",  // 键 "name"，值 "John"
  age: 30        // 键 "age"，值 30
};

// 读取文件的属性：
alert( user.name ); // John
alert( user.age ); // 30
```
- 可以看到这就是普通的json字典或者说python字典而已,实际使用时我们也可以将对象作为字典来存储数据.

#### 遍历对象
js使用`for in`遍历字典对象,而非Java使用的`for :`:
```js
let user = {
  name: "John",
  age: 30,
  isAdmin: true
};

for (let key in user) {
  // keys
  alert( key );  // name, age, isAdmin
  // 属性键的值
  alert( user[key] ); // John, 30, true
}
```

#### 将函数加入对象中
```js
// 完整版本
user = {
  sayHi: function() {
    alert("Hello");
  }
};

// 简写版本
let user = {
  sayHi() { // 与 "sayHi: function(){...}" 一样
    alert("Hello");
  }
};
```

上述的两种方法都可以将函数写入对象里,一个采用了`key: value`的正式写法,另一个采用了简写语法糖,尽管简写版本才更符合平常写c结构体的直觉.
#### this关键字
与python一样,js引入了this引用符,用于指向实例化的对象,当然目前的对象都是实例化了的,我们可以直接使用,来访问对象内部定义的变量:
```js
let user = {
  name: "John",
  age: 30,

  sayHi() {
    // "this" 指的是“当前的对象”
    alert(this.name);
  }

};

user.sayHi(); // John
```

#### 构造函数
前面的对象都是使用{}构造符直接进行构造的,要想使用new关键字进行构造,我们需要先写一个**构造函数**:
```js
function User(name) {
  this.name = name;
  this.isAdmin = false;
}

let user = new User("Jack");

alert(user.name); // Jack
alert(user.isAdmin); // false
```

可以看到构造函数使用this引用符指向了某个对象,只在对象初始化的时候才会真正实现.

除此之外,构造函数有两个特点:
1. 首字母大写
2. 只能由new操作符执行

##### 向构造函数中加入方法
```js
function User(name) {
  this.name = name;

  this.sayHi = function() {
    alert( "My name is: " + this.name );
  };
}

let john = new User("John");

john.sayHi(); // My name is: John

/*
john = {
   name: "John",
   sayHi: function() { ... }
}
*/
```
### 解构赋值
- 这个语法会被经常用在React中,所以需要特别关注

**解构赋值**: 将对象或者数组拆开,将其中的元素复制给一个或多个变量,而不修改原先的对象或数组.

- 有时候我们可以对任何可迭代对象使用解构赋值:

```js
let [a, b, c] = "abc"; // ["a", "b", "c"]
let [one, two, three] = new Set([1, 2, 3]);
```
#### 数组解构
一个简单的解构如下:

```js
let [firstName, surname] = "John Smith".split(' ');
alert(firstName); // John
alert(surname);  // Smith
```

但如果数组比左边的列表长,那么其余的数组将被忽略,这点与python还是有所不同的:
```js
let [name1, name2] = ["Julius", "Caesar", "Consul", "of the Roman Republic"];

alert(name1); // Julius
alert(name2); // Caesar
// 其余数组项未被分配到任何地方
```

如果你想一个不漏地接收,可以在最后一个变量名前加上`...`:
```js
let [name1, name2, ...rest] = ["Julius", "Caesar", "Consul", "of the Roman Republic"];

// rest 是包含从第三项开始的其余数组项的数组
alert(rest[0]); // Consul
alert(rest[1]); // of the Roman Republic
alert(rest.length); // 2
```

如果数组比左边的列表短,缺少对应值的变量都会被赋值undefined:
```js
let [firstName, surname] = [];

alert(firstName); // undefined
alert(surname); // undefined
```
如果想要给没有对应值的变量赋给默认值,可以用`=`提供,这在JSX中特别常见:
```js
// 默认值
let [name = "Guest", surname = "Anonymous"] = ["Julius"];

alert(name);    // Julius（来自数组的值）
alert(surname); // Anonymous（默认值被使用了）
```
#### 对象解构
很多时候我们需要将对象中的各个键值对拆分出来,这时候就可以使用对象解构:
```js
let options = {
  title: "Menu",
  width: 100,
  height: 200
};

let {title, width, height} = options;
// 均与对象中的键名字对应

alert(title);  // Menu
alert(width);  // 100
alert(height); // 200
```
但键的顺序并不重要:
```js
// 改变 let {...} 中元素的顺序也是等价的
let {height, width, title} = { title: "Menu", height: 200, width: 100 }
```

如果我们想自己给键起个新名字,可以这样写:
```js
let options = {
  title: "Menu",
  width: 100,
  height: 200
};

// { sourceProperty: targetVariable }
let {width: w, height: h, title} = options;

// width -> w
// height -> h
// title -> title

alert(title);  // Menu
alert(w);      // 100
alert(h);      // 200
```

同样,对于可能缺失的值,我们使用`=`赋予默认值:
```js
let options = {
  title: "Menu"
};

let {width = 100, height = 200, title} = options;

alert(title);  // Menu
alert(width);  // 100
alert(height); // 200
```
与数组解构一样,多余的变量会被忽略:
```js
let options = {
  title: "Menu",
  width: 100,
  height: 200
};

// 仅提取 title 作为变量
let { title } = options;

alert(title); // Menu
```

一个复杂的例子如下:
```js
let options = {
  size: {
    width: 100,
    height: 200
  },
  items: ["Cake", "Donut"],
  extra: true
};

// 为了清晰起见，解构赋值语句被写成多行的形式
let {
  size: { // 把 size 赋值到这里
    width,
    height
  },
  items: [item1, item2], // 把 items 赋值到这里
  title = "Menu" // 在对象中不存在（使用默认值）
} = options;

alert(title);  // Menu
alert(width);  // 100
alert(height); // 200
alert(item1);  // Cake
alert(item2);  // Donut
```
#### 真实应用
很多时候我们会写出这种难看的函数:
```js
function showMenu(title = "Untitled", width = 200, height = 100, items = []) {
  // ...
}
```
但更为实际的方法是将这些参数通通装入对象中,再在函数参数中解构:
```js
// 我们传递一个对象给函数
let options = {
  title: "My menu",
  items: ["Item1", "Item2"]
};

// ……然后函数马上把对象解构成变量
function showMenu({title = "Untitled", width = 200, height = 100, items = []}) {
  // title, items – 提取于 options，
  // width, height – 使用默认值
  alert( `${title} ${width} ${height}` ); // My Menu 200 100
  alert( items ); // Item1, Item2
}

showMenu(options);
```

要想使用函数的默认参数,我们必须传入一个空对象才可以:
```js
showMenu({}); // 不错，所有值都取默认值

showMenu(); // 这样会导致错误
```
因此我们可以在函数里就写明默认值为空对象:
```js
function showMenu({ title = "Menu", width = 100, height = 200 } = {}) {
  alert( `${title} ${width} ${height}` );
}

showMenu(); // Menu 100 200
```
#### 对象展开
- 由于对象展开与解构赋值干的事情差不多,所以就放在这里了.

如前所说,我们有时候会使用`...`来接收多余或者多出的变量:
```js
function showName(firstName, lastName, ...titles) {
  alert( firstName + ' ' + lastName ); // Julius Caesar

  // 剩余的参数被放入 titles 数组中
  // i.e. titles = ["Consul", "Imperator"]
  alert( titles[0] ); // Consul
  alert( titles[1] ); // Imperator
  alert( titles.length ); // 2
}

showName("Julius", "Caesar", "Consul", "Imperator");
```

但是js开发者显然很喜欢这个`...`,在**对象展开**的时候也要用它来干活,这被称为**Spread语法**:
```js
let arr = [3, 5, 1];

alert( Math.max(...arr) ); // 5（spread 语法把数组转换为参数列表）
```

一个更为复杂的应用如下:
```js
let obj = { a: 1, b: 2, c: 3 };

let objCopy = { ...obj }; // 将对象 spread 到参数列表中
                          // 然后将结果返回到一个新对象

// 两个对象中的内容相同吗？
alert(JSON.stringify(obj) === JSON.stringify(objCopy)); // true

// 两个对象相等吗？
alert(obj === objCopy); // false (not same reference)

// 修改我们初始的对象不会修改副本：
obj.d = 4;
alert(JSON.stringify(obj)); // {"a":1,"b":2,"c":3,"d":4}
alert(JSON.stringify(objCopy)); // {"a":1,"b":2,"c":3}
```

显然,对象展开与解构赋值干的活儿差不多,但是对象展开没必要知道对象内部有什么,而解构赋值是必须要一个个重新赋值或者确认的.因此,当我们仅仅是要跨越函数传递参数时,一般都使用**对象展开**,直到最后的执行函数才使用解构赋值.
### OOP
js直到ES6才引入了class,大致的结构和python中的类没有区别.

#### 构造函数
class中的构造函数是`constructor`:
```js
class User {

  constructor(name) {
    this.name = name;
  }

  sayHi() {
    alert(this.name);
  }

}

// 用法：
let user = new User("John");
user.sayHi();
```
#### 继承与多态
js中的继承和java中一样使用关键字`extends`:
```js
class Rabbit extends Animal {
  hide() {
    alert(`${this.name} hides!`);
  }
}
```
与python中一样,JavaScript的所有方法都是默认可被重载的,在子类中重写方法会覆盖父类的方法,但可以通过super指向父类,调用父类的方法:
```js
class Rabbit extends Animal {
  stop() {
    // ……现在这个将会被用作 rabbit.stop()
    // 而不是来自于 class Animal 的 stop()
  }
}
```
与java一样,js可以用super关键字来指向父类:
```js
class Rabbit extends Animal {
  hide() {
    alert(`${this.name} hides!`);
  }

  stop() {
    super.stop(); // 调用父类的 stop
    this.hide(); // 然后 hide
  }
}
```
#### static关键字
尽管没有引入其他的修饰符,但js引入了static关键字,用于修饰静态方法和静态属性:
```js
class User {
  static staticMethod() {
    alert(this === User);
  }
}

User.staticMethod(); // true
```
### 异常处理
### 模块
### 迭代器,生成器与异步调用

# 浏览器引擎介绍
>三件套是如何被渲染的?我们常说的浏览器内核是什么?运行时又是什么?这几个问题是这一章节的核心要点.

# JavaScript XML

# Typescript

# TypeScript XML

# Tailwind学习