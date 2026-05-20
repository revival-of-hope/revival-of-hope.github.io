---
title: 2026-03-15 react-learn
tags:
  - 前端
date: 2026-03-15 08:00:00
image: 42340231_p0-金剛デース.jpg
---
基础React使用的是自创的jsx,在实际运行时需要经过编译器转译变成js.
实际上,jsx与原生js的最大区别在于可以将html元素作为组件,也就是说,**React组件是一段可以使用标签进行扩展的JavaScript 函数**.
## UI描绘
### 组件概念
```js
function Profile() {
  return (
    <img
      src="https://i.imgur.com/MK3eW3As.jpg"
      alt="Katherine Johnson"
    />
  );
}

export default function Gallery() {
  return (
    <section>
      <h1>Amazing scientists</h1>
      <Profile />
      <Profile />
      <Profile />
    </section>
  );
}
```
profile()函数返回的是img元素,并可以在Gallery()函数中使用<Profile />的形式直接调用.

### 组件的导入导出
```js
import Gallery from './Gallery.js';
//import Gallery from './Gallery'; 这种写法在React中也可以,但不够符合原生ES规范
export default function App() {
  return (
    <Gallery />
  );
}

```


#### 两种导出方式

| 类型                       | 导出语句                              | 导入语句                                |
| -------------------------- | ------------------------------------- | --------------------------------------- |
| 默认导出（default export） | `export default function Button() {}` | `import Button from './Button.js';`     |
| 具名导出（named export）   | `export function Button() {}`         | `import { Button } from './Button.js';` |

默认导入时名称可以任意命名,而具名导入时名称需要完全一致并用{}标识

### jsx基础语法
#### 如何将网页元素作为返回值
```js
export default function TodoList() {
  return (
    // 这不起作用！
    <h1>海蒂·拉玛的待办事项</h1>
    <img 
      src="https://i.imgur.com/yXOvdOSs.jpg" 
      alt="Hedy Lamarr" 
      class="photo"
    >
    <ul>
      <li>发明一种新式交通信号灯
      <li>排练一个电影场景
      <li>改进频谱技术
    </ul>
  );
}
```
返回值实际上应该先写成以下形式:
```js
<>
  <h1>海蒂·拉玛的待办事项</h1>
  <img 
    src="https://i.imgur.com/yXOvdOSs.jpg" 
    alt="Hedy Lamarr" 
    class="photo"
  >
  <ul>
    ...
  </ul>
</>
```
这个空标签被称作 Fragment。React Fragment 允许你将子元素分组，而不会在 HTML 结构中添加额外节点。

**为什么多个 JSX 标签需要被一个父元素包裹?**
JSX 虽然看起来很像 HTML，但在底层其实被转化为了 JavaScript 对象，你不能在一个函数中返回多个对象，除非用一个数组把他们包装起来。这就是为什么多个 JSX 标签必须要用一个父元素或者 Fragment 来包裹。

上述写法其实还不够正确,因为JSX 要求标签必须正确闭合。像 <img> 这样的自闭合标签必须书写成 <img />,而像 <li>oranges 这样只有开始标签的元素必须带有闭合标签，需要改为 <li>oranges</li>。
```js
<>
  <img 
    src="https://i.imgur.com/yXOvdOSs.jpg" 
    alt="Hedy Lamarr" 
    class="photo"
   />
  <ul>
      <li>发明一种新式交通信号灯</li>
      <li>排练一个电影场景</li>
      <li>改进频谱技术</li>
  </ul>
</>
```
由于class是js保留字,故这里还需要将class改为className,使用的是驼峰命名法.

```js
<img 
  src="https://i.imgur.com/yXOvdOSs.jpg" 
  alt="Hedy Lamarr" 
  className="photo"
/>
```

```js
export default function TodoList() {
  return (
    <>
      <h1>海蒂·拉玛的待办事项</h1>
      <img 
        src="https://i.imgur.com/yXOvdOSs.jpg" 
        alt="Hedy Lamarr" 
        className="photo" 
      />
      <ul>
        <li>发明一种新式交通信号灯</li>
        <li>排练一个电影场景</li>
        <li>改进频谱技术</li>
      </ul>
    </>
  );
}
```
这是最终成果.
#### 如何在网页元素或者组件中写入js变量
```js
export default function TodoList() {
  const name = 'Zara';
  return (
    <h1>{name}的待办事项列表</h1>
  );
}
```
在 JSX 中，只能在以下两种场景中使用大括号：
1. 用作 JSX 标签内的文本：`<h1>{name}'s To Do List</h1>` 是有效的，但是 `<{tag}>Gregorio Y. Zara's To Do List</{tag}>` 无效
2. 用作紧跟在 = 符号后的 属性：`src={avatar}` 会读取 `avatar` 变量，但是 `src="{avatar}"` 只会传一个字符串 `{avatar}`

```js
export default function TodoList() {
  return (
    <ul style={{
      backgroundColor: 'black',
      color: 'pink'
    }}>
      <li>Improve the videophone</li>
      <li>Prepare aeronautics lectures</li>
      <li>Work on the alcohol-fuelled engine</li>
    </ul>
  );
}
```
上述代码通过双大括号传入了一个css对象.

### 在组件间传递props
```js
export default function Profile() {
  return (
    <Avatar />
  );
}
```
这个代码没有向子组件转递任何props.
```jsx
export default function Profile() {
  return (
    <Avatar
      person={{ name: 'Lin Lanying', imageId: '1bX5QH6' }}
      size={100}
    />
  );

function Avatar({ person, size }) {
  // 在这里 person 和 size 是可访问的
  return (
    <img
      className="avatar"
      src={getImageUrl(person)}
      alt={person.name}
      width={size}
      height={size}
    />
  );
}
```
你可以将 props 想象成可以调整的“旋钮”。它们的作用与函数的参数相同 —— 事实上，props 正是 组件的唯一参数！ React 组件函数接受一个参数，一个 props 对象：
```js
function Avatar(props) {
  let person = props.person;
  let size = props.size;
  // ...
}
```
通常你不需要整个 props 对象，所以可以将它解构为单独的 props,也就是说,下面两段代码是等价的:
```jsx
function Avatar({ person, size }) {
  // ...
}
```

```jsx
function Avatar(props) {
  let person = props.person;
  let size = props.size;
  // ...
}
```
同时,还可以写入默认值,如:
```jsx
function Avatar({ person, size = 100 }) {
  // ...
}
```

还可以使用展开语法,将传入的props展开为对象后再传入:
```jsx
function Profile(props) {
  return (
    <div className="card">
      <Avatar {...props} />
    </div>
  );
}
```
#### 字符串变量与普通变量的传入
```js
function AlertButton({ message, children }) {
  return (
    <button onClick={() => alert(message)}>
      {children}
    </button>
  );
}

export default function Toolbar() {
  return (
    <div>
      <AlertButton message="正在播放！">
        播放电影
      </AlertButton>
      <AlertButton message="正在上传！">
        上传图片
      </AlertButton>
    </div>
  );
}
```
注意到这里的AlertButton组件在调用时直接传入message字符串,而不是写`message={"正在播放！"}`这种普通的传入变量方式,是因为字符串变量默认是可以直接传入的.
### 条件渲染
在一些情况下，你不想有任何东西进行渲染。比如，你不想显示已经打包好的物品。但一个组件必须返回一些东西。这种情况下，你可以直接返回 null。
```js
if (isPacked) {
  return null;
}
return <li className="item">{name}</li>;
```
但事实上还可以这么写:
```js
return (
  <li className="item">
    {name} {isPacked && '✅'}
  </li>
);
```
也就是说将js变量直接与字符串绑定,仅在isPacked为true时渲染勾选符号.

>JavaScript 会自动将左侧的值转换成布尔类型以判断条件成立与否。然而，如果左侧是 0，整个表达式将变成左侧的值（0），React 此时则会渲染 0 而不是不进行渲染。
例如，一个常见的错误是 messageCount && <p>New messages</p>。其原本是想当 messageCount 为 0 的时候不进行渲染，但实际上却渲染了 0。
为了更正，可以将左侧的值改成布尔类型：messageCount > 0 && <p>New messages</p>。

### 渲染列表
```js
import { people } from './data.js';
import { getImageUrl } from './utils.js';

export default function List() {
  const chemists = people.filter(person =>
    person.profession === '化学家'
  );
  const listItems = chemists.map(person =>
    <li key={person.id}>
      <img
        src={getImageUrl(person)}
        alt={person.name}
      />
      <p>
        <b>{person.name}:</b>
        {' ' + person.profession + ' '}
        因{person.accomplishment}而闻名世界
      </p>
    </li>
  );
  return <ul>{listItems}</ul>;
}
```
这个代码是这一小节的核心内容,filter()和map()经常被用在react元素中用来渲染数据库的数据

## 添加交互
### 事件处理
```js 
export default function Button() {
  return (
    <button>
      未绑定任何事件
    </button>
  );
}
```
=>
```js
export default function Button() {
  function handleClick() {
    alert('你点击了我！');
  }

  return (
    <button onClick={handleClick}>
      点我
    </button>
  );
}
//在button组件中传入了handleClick函数

//或者可以直接写为内联箭头函数
<button onClick={() => {
  alert('你点击了我！');
}}>
```
=>
```js
function AlertButton({ message, children }) {
  return (
    <button onClick={() => alert(message)}>
      {children}
    </button>
  );
}

export default function Toolbar() {
  return (
    <div>
      <AlertButton message="正在播放！">
        播放电影
      </AlertButton>
      <AlertButton message="正在上传！">
        上传图片
      </AlertButton>
    </div>
  );
}
```
非常值得注意的是这一串代码:
` <button onClick={() => alert(message)}>`
这里的message并没有用{}包裹,是因为外面已经有一层{}了,而react默认{}里就可以直接写入js变量了,如果再把message用{}包裹,就是把message当成对象来处理了.

```js
<AlertButton message="正在播放！">
        播放电影
</AlertButton>
```
同时,这里明面上只传入了message一个prop,但children作为react的约定变量,可以直接隐式传入组件内部包裹的字符串,故还是传入了两个变量.

### state使用
```js
import { sculptureList } from './data.js';

export default function Gallery() {
  let index = 0;

  function handleClick() {
    index = index + 1;
  }

  let sculpture = sculptureList[index];
  return (
    <>
      <button onClick={handleClick}>
        Next
      </button>
      <h2>
        <i>{sculpture.name} </i> 
        by {sculpture.artist}
      </h2>
      <h3>  
        ({index + 1} of {sculptureList.length})
      </h3>
      <img 
        src={sculpture.url} 
        alt={sculpture.alt}
      />
      <p>
        {sculpture.description}
      </p>
    </>
  );
}
```
由于index是局部变量,而react函数保证每次执行函数时都是从头开始渲染从而得到相同的结果,故每次执行时index都被初始化为0.

为了保留渲染之前的数据,并触发react使用新数据重新渲染,需要引入useState组件.
- `const [state,setState]=useState(0)`
```js
import { useState } from 'react';
import { sculptureList } from './data.js';

export default function Gallery() {
  const [index, setIndex] = useState(0);

  function handleClick() {
    setIndex(index + 1);
  }

  let sculpture = sculptureList[index];
  return (
    <>
      <button onClick={handleClick}>
        Next
      </button>
      <h2>
        <i>{sculpture.name} </i> 
        by {sculpture.artist}
      </h2>
      <h3>  
        ({index + 1} of {sculptureList.length})
      </h3>
      <img 
        src={sculpture.url} 
        alt={sculpture.alt}
      />
      <p>
        {sculpture.description}
      </p>
    </>
  );
}
```

- 在 React 中，useState 以及任何其他以“use”开头的函数都被称为 **Hook**,是一类特殊的函数,只在React渲染时有效.
- useState 的唯一参数是 state 变量的初始值,在本例中被设置为0.
- 同时,state是组件实例内部的状态,如果渲染一个组件两次,每个组件都有完全隔离的state状态

```js
import { useState } from 'react';

export default function Counter() {
  const [number, setNumber] = useState(0);

  return (
    <>
      <h1>{number}</h1>
      <button onClick={() => {
        setNumber(number + 5);
        alert(number);
      }}>+5</button>
    </>
  )
}
```
第一次点击button时,alert的内容为0,因为**useState只会为下一次渲染更改state的值**,永远不会在一次渲染的过程中改变state变量.

```js
import { useState } from 'react';

export default function Counter() {
  const [number, setNumber] = useState(0);

  return (
    <>
      <h1>{number}</h1>
      <button onClick={() => {
        setNumber(n => n + 1);
        setNumber(n => n + 1);
        setNumber(n => n + 1);
      }}>+3</button>
    </>
  )
}
```
但是,上述代码会真正执行+3,因为`n => n + 1`在这里作为更新函数,会被加入更新队列,react只有在执行完更新队列后才会开始渲染,因此,下述代码的结果是每次加6.
```js
import { useState } from 'react';

export default function Counter() {
  const [number, setNumber] = useState(0);

  return (
    <>
      <h1>{number}</h1>
      <button onClick={() => {
        setNumber(number + 5);
        setNumber(n => n + 1);
      }}>增加数字</button>
    </>
  )
}
```
## state进阶(待补充)

## 与外部系统交互
### useRef
>当你希望组件“记住”某些信息，但又不想让这些信息 触发新的渲染 时，你可以使用 ref

```js
import { useRef } from 'react';
const ref = useRef(0);

//useRef 返回一个这样的对象:
// { 
//   current: 0 // 你向 useRef 传入的值
// }
```
>像 state 一样，你可以让它指向任何东西：字符串、对象，甚至是函数。与 state 不同的是，ref 是一个普通的 JavaScript 对象，具有可以被读取和修改的 current 属性。


### useEffect
首先我们需要明白Events和Effect这两个概念的区别:
1. Events: 用户交互产生的效果
2. Effect: 组件本身产生的效果

```js
import { useState, useRef, useEffect } from 'react';

function VideoPlayer({ src, isPlaying }) {
  const ref = useRef(null);

  useEffect(() => {
    if (isPlaying) {
      ref.current.play();
    } else {
      ref.current.pause();
    }
  });

  return <video ref={ref} src={src} loop playsInline />;
}

export default function App() {
  const [isPlaying, setIsPlaying] = useState(false);
  return (
    <>
      <button onClick={() => setIsPlaying(!isPlaying)}>
        {isPlaying ? '暂停' : '播放'}
      </button>
      <VideoPlayer
        isPlaying={isPlaying}
        src="https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4"
      />
    </>
  );
}
```
- useEffect会在每次渲染后运行

## createContext
上下文使得组件能够无需通过显式传递参数的方式 将信息逐层传递,使用格式如下:
```ts
const SomeContext = createContext(defaultValue);
```
**用例**
```ts
import { createContext } from 'react';
const ThemeContext = createContext('light');
function App() {
  const [theme, setTheme] = useState('light');
  // ……
  return (
    <ThemeContext value={theme}>
      <Page />
    </ThemeContext>
  );
}
```
老版本会出现类似Provider这样的东西,但从React 19开始可以直接这样写了.
## createRoot

```js
import { createRoot } from 'react-dom/client';

const domNode = document.getElementById('root');
const root = createRoot(domNode);
//createRoot返回一个带有两个方法的对象,这两个方法是：render 和 unmount,一个是渲染节点,一个是销毁节点

//root.render(<App />);
//root.unmount();
```