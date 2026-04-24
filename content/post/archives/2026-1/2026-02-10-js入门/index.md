---
title: 2026-02-10 js入门
tags:
  - 前端
date: 2026-02-10 08:00:00
image:
---
- [参考资料](https://zh.javascript.info/)
>原来我是打算看<< head first JavaScript>>的,但发现他确实是在把我当智障教,而且内容太老了,根本看不下去,于是就选了javascript.info来看.
## 基本语法
### 数据类型
>js和python一样是动态类型语言,故可以有:
```js
// 没有错误
let message = "hello";
message = 123456;
```
#### number and BigInt
int和float统一称为number.

>除了常规的数字，还包括所谓的“特殊数值（“special numeric values”）”也属于这种类型：Infinity、-Infinity 和 NaN(计算错误).

由于number类型无法安全表示大于9007199254740991的整数,故后来又发明了BigInt用来安全表示任意长度的整数,通过将 n 附加到整数字段的末尾就可以创建BigInt.
```js
// 尾部的 "n" 表示这是一个 BigInt 类型
const bigInt = 1234567890123456789012345678901234567890n;
```
#### string
三种引号:
1. 双引号：`"Hello"`.
2. 单引号：`'Hello'`.
3. 反引号：``Hello``.
反引号用于将变量嵌入字符串
**eg**
```js
let name = "John";
// 嵌入一个变量
alert( `Hello, ${name}!` ); // Hello, John!
// 嵌入一个表达式
alert( `the result is ${1 + 2}` ); // the result is 3

alert( "the result is ${1 + 2}" ); // the result is ${1 + 2}（使用双引号则不会计算 ${…} 中的内容）
```
- 只有`可以表示多行字符串,用单双引号跨行表示字符串都会直接报错
  - 主流静态语言都不允许字符串跨行,不过一般静态语言也用不上那么长的字符串
#### null and undefined
null指代未知值或空值,而undefined指代未被赋值的值.
```js
let age = null;
//another file
let age;
alert(age); // 弹出 "undefined"
```
### Interaction: alert, prompt, confirm

`alert('hello,world')`
The mini-window with the message is called a modal window. The word “modal” means that the visitor can’t interact with the rest of the page, press other buttons, etc, until they have dealt with the window. In this case – until they press “OK”.

`result = prompt(title, [default]);`
The function prompt accepts two arguments:
- title
   - The text to show the visitor.
- default
  - An optional second parameter, the initial value for the input field.

prompt 将返回用户在 input 框内输入的文本，默认为string,如果用户取消了输入，则返回 null,与python中的input()类似

`result = confirm(question);`
显示信息等待用户点击确定或取消。点击确定返回 true，点击取消或按下 Esc 键返回 false。
```js
let isBoss = confirm("Are you the boss?");

alert( isBoss ); // 如果“确定”按钮被按下，则显示 true
```
上述所有方法共有两个限制：

- 模态窗口的确切位置由浏览器决定。通常在页面中心。
- 窗口的确切外观也取决于浏览器。我们不能修改它。

### function
#### 函数声明与函数表达式
```js
function showMessage() {
  alert( 'Hello everyone!' );
}

showMessage();
```
下列方法称为函数表达式
```js
let sayHi = function() {
  alert( "Hello" );
};
```
还可以这样写
```js
function sayHi() {   // (1) 创建
  alert( "Hello" );
}

let func = sayHi;    // (2) 复制

func(); // Hello     // (3) 运行复制的值（正常运行）！
sayHi(); // Hello    //     这里也能运行（为什么不行呢）
```
也就是说可以把函数看作一个变量
#### 回调函数与匿名函数
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
这里两个函数没有名字,故称为匿名函数,同时两个函数作为传入参数,可称为回调函数(callback).
#### 箭头函数
```js
let sum = (a, b) => a + b;

/* 这个箭头函数是下面这个函数的更短的版本：

let sum = function(a, b) {
  return a + b;
};
*/

alert( sum(1, 2) ); // 3
```

```js
let sum = (a, b) => {  // 花括号表示开始一个多行函数
  let result = a + b;
  return result; // 如果我们使用了花括号，那么我们需要一个显式的 “return”
};

alert( sum(1, 2) ); // 3
```

### 注释

- 在该注释的地方注释，在不需要注释的地方则不注释，甚至写得好的自描述函数本身就是一种注释
- “如果代码不够清晰以至于需要一个注释，那么或许它应该被重写。”
### falsy and truthy
falsy只有以下几种:
```js 
0, -0, "", null, undefined, NaN, false
```
在诸如`if(i)`这样的判断句中只有i为falsy才会不执行

### 对象

#### 属性中的[]与.

js中的.与python中基本相同,可以用于在对象之外添加普通属性,访问属性,更改属性,但js中还有特殊运算符[],可以用于命名特殊属性,将普通变量变成属性.
**任意表达式**
```js
let key = "likes birds";

// 跟 user["likes birds"] = true; 一样
user[key] = true;
```
**计算属性**
```js
let fruit = prompt("Which fruit to buy?", "apple");

let bag = {
  [fruit]: 5, // 属性名是从 fruit 变量中得到的
};

alert( bag.apple ); // 5 如果 fruit="apple"
//another file
let fruit = 'apple';
let bag = {
  [fruit + 'Computers']: 5 // bag.appleComputers = 5
};
```

#### 属性值简写
```js
function makeUser(name, age) {
  return {
    name: name,
    age: age,
    // ……其他的属性
  };
}

let user = makeUser("John", 30);
alert(user.name); // John

//another file
function makeUser(name, age) {
  return {
    name, // 与 name: name 相同
    age,  // 与 age: age 相同
    // ...
  };
}
```
#### 对象方法
```js
// 这些对象作用一样

user = {
  sayHi: function() {
    alert("Hello");
  }
};

// 方法简写看起来更好，对吧？
let user = {
  sayHi() { // 与 "sayHi: function(){...}" 一样
    alert("Hello");
  }
};
```
也就是说有两种方式可以声明js对象方法
#### New的使用
```js
function User(name) {
  this.name = name;
  this.isAdmin = false;
}

let user = new User("Jack");

alert(user.name); // Jack
alert(user.isAdmin); // false
```
其中new User()做了类似以下描述的事情
```js
function User(name) {
  // this = {};（隐式创建）

  // 添加属性到 this
  this.name = name;
  this.isAdmin = false;

  // return this;（隐式返回）
}
```
### Class
js中的class是后添加的特性,实际上是一种语法糖
```js
class Person {
  // 静态属性（属于类本身）
  static species = "Homo sapiens";

  // 构造函数：new 时执行
  constructor(name, age) {
    this.name = name;   // 实例属性
    this.age = age;
  }

  // 实例方法（存在于 Person.prototype）
  introduce() {
    return `My name is ${this.name}, I am ${this.age}`;
  }

  // 静态方法（只能通过类调用）
  static describeSpecies() {
    return `Species: ${this.species}`;
  }
}

class Student extends Person {
  constructor(name, age, major) {
    super(name, age);   // 调用父类构造函数
    this.major = major;
  }

  // 方法重写
  introduce() {
    const base = super.introduce();  // 调用父类方法
    return `${base}, majoring in ${this.major}`;
  }

  study() {
    return `${this.name} is studying`;
  }
}

// 使用示例
const p = new Person("Alice", 30);
console.log(p.introduce());
console.log(Person.describeSpecies());

const s = new Student("Bob", 20, "Computer Science");
console.log(s.introduce());
console.log(s.study());
console.log(Student.species);
```
### export与import
export与import可以看作是python中的模块导入,区别是只有用export标记的函数和变量才可以在其他文件中导入,导入方式也与python类似
**eg**
/project
  ├─ math.js
  └─ main.js
---
```js
//math.js

// 命名导出（Named Export）
// 导出变量绑定
export const pi = 3.14159;

// 导出函数绑定
export function add(a, b) {
  return a + b;
}

// 默认导出（Default Export）
// 一个模块只能有一个 default
// 本质是导出一个名为 "default" 的内部绑定
export default function multiply(a, b) {
  return a * b;
}
```
---
```js
//main.js

// 同时导入 default + 命名导出

// 1. default 导入
// 不需要花括号
// 名字可以随意起（因为导入的是默认绑定）
import mul from "./math.js";

// 2. 命名导入
// 必须使用花括号
// 名字必须与导出一致（或使用 as 重命名）
import { pi, add } from "./math.js";

// 使用示例
console.log(pi);          // 3.14159
console.log(add(2, 3));   // 5
console.log(mul(2, 3));   // 6
```

## 小总结(2/20)
事实上看了这么久js.info我已经觉得很烦了,因为js的语法混乱不堪,有很多没意义的历史残留,而教程有时候讲的过于抽象和笼统,有时候又讲的十分细致和琐碎,不过通过反刍还是大概能看清楚js的基本用法的,至于其他的章节匆匆速览一遍就不想再看了,接下来我应该要直接上手next.js来试试深浅.