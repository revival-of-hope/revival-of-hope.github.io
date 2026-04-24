---
title: dom详解
tags:
  - 前端
date: 2026-04-18 08:00:00
image: 22566017_p0-ランクエクリア記念.webp
---


html和js中广泛应用的dom到底是什么,我向来没有一个明确的认识,因此写了这篇文章来学习一下.

## dom的概念
- [wiki](https://en.wikipedia.org/wiki/Document_Object_Model)
>dom(Document Object Model) is a cross-platform and language-independent API that **treats an HTML or XML document as a tree structure** wherein each **node** is an object representing a part of the document.
**Nodes** can have **event handlers** (also known as event listeners) attached to them. Once an event is triggered, the **event handlers** get executed.
- 也就是说,**dom将网页文档看作是由一个个节点组成的树**,每个节点都可以被各种各样的事件触发,并执行触发函数.
  - 这样看来,dom并没有什么神秘的地方,但却没有多少人把这个讲清楚.
In HTML DOM (Document Object Model), every element is a node:
- A document is a document node.
- All HTML elements are element nodes.
- All HTML attributes are attribute nodes.
- Text inserted into HTML elements are text nodes.
- Comments are comment nodes.


## dom的历史
- 1995年：Netscape 发布 JavaScript (Navigator 2.0)，诞生 **DOM Level 0**（Legacy DOM）。支持简单的表单/链接访问（如 `document.forms[0]`），主要用于基础交互和表单验证。
- 1996年：微软发布 Internet Explorer 3.0，推出兼容 JavaScript 的 **JScript**。
- 1997年：Netscape 和微软分别发布 4.0 版本浏览器。引入 **DHTML**（动态 HTML），形成 **Intermediate DOM**。由于两家厂商各自开发扩展，导致该阶段的 DOM 实现严重不兼容。
- 1998年：在 ECMAScript 标准化后，W3C 发布 **DOM Level 1** 推荐标准。这是首个尝试统一各平台操作接口的独立标准。
- 2005年：随着 IE6、Firefox (Gecko)、Safari 等浏览器的普及，W3C DOM 标准获得主流引擎的广泛支持，浏览器战争引发的碎片化问题趋于解决。

## dom的原理
浏览器内核(chrome,firefox等)将网页中的dom节点转换成cpp对象,例如,当你在 JS 中操作 document.getElementById 时,引擎会通过映射来操作内存里的 C++ 对象,这也是你为什么能够在网页中进行键盘和鼠标交互的原因.
## dom的应用

### 查找元素 (Select)
操作 DOM 的起点，将 HTML 标签映射为 JS 对象。

* **按 ID 查找：** 返回唯一的单个元素。
    ```javascript
    const header = document.getElementById('main-header');
    ```
* **按 CSS 选择器查找：** 最灵活的方式。
    ```javascript
    const navItem = document.querySelector('.nav-item'); // 找第一个匹配的
    const allButtons = document.querySelectorAll('button'); // 找所有匹配的（返回 NodeList）
    ```

### 修改内容与属性 (Modify)
一旦拿到对象，就可以直接通过操作 C++ 对象的映射属性来改变网页。

* **修改文本内容：**
    ```javascript
    el.textContent = '新内容'; // 纯文本，更安全
    el.innerHTML = '<span>加粗内容</span>'; // 会解析 HTML 标签
    ```
* **修改 CSS 样式：**
    ```javascript
    el.style.color = 'red';
    el.classList.add('active'); // 推荐做法：通过切换类名控制样式
    ```
* **修改属性：**
    ```javascript
    el.setAttribute('src', 'logo.png');
    console.log(el.id); // 直接访问属性
    ```

### 创建与插入元素 (Create & Append)
动态生成网页内容。

```javascript
// 1. 创建元素（此时仅在内存中，未挂载到树上）
const newDiv = document.createElement('div');
newDiv.textContent = '我是新来的';

// 2. 挂载到 DOM 树中（挂载后用户才可见）
const container = document.body;
container.appendChild(newDiv); 

// 3. 删除元素
// newDiv.remove(); 
```

### 事件监听 (Events)
让静态页面具有交互能力。

```javascript
const btn = document.querySelector('#submit-btn');

// 监听点击事件
btn.addEventListener('click', (event) => {
    alert('按钮被点击了！');
    console.log(event.target); // 触发事件的元素
});
```

