---
title: "技术文章阅读笔记-4"
date: 2026-07-17T11:07:48+08:00
description: 
image: 62549331_p0-フランちゃんとチェス.webp
math: 
---

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
对于学过Java和Js的人来说,Dart语法确实很容易掌握

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

## Ajax数据爬取
## 异步爬虫

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

# High Performance Python 3rd edition
- 25年5月出版的,新鲜的很

讲的一般般,大多数内容我都已经学过了.

