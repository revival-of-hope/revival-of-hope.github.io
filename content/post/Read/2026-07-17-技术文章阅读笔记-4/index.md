---
title: "技术文章阅读笔记-4"
date: 2026-07-17T11:07:48+08:00
description: 
image: 62549331_p0-フランちゃんとチェス.webp
math: 
---

# Web Automation Testing Using Playwright
## 介绍
人工编写测试用例并逐一运行过于繁琐,这也是测试工具不断演进不断发展的原因,而在其中名气处于第一梯队的就是Playwright了,而它这么火爆的另一个原因是还可以被用于爬虫.谁能想到,Playwright的正式发布时间也才在2020年呢,至于老牌的Selenium由于更差性能和更复杂的调用方式则逐渐落伍.有力的竞争者之一则是Cypress,由于它运行在浏览器内部,不需要额外安装驱动,所以也占有了一席之地.


## 安装Playwright
- 每次安装都麻烦的过头了好不好
![示意图](PixPin_2026-07-29_12-03-37.webp)


# Rust程序设计语言
- 由浅入深,这才是正常的教科书,不吊打Go圣经几条街.

## 基础
### 变量与常量
1. rust中变量用`let`声明,可以隐式推导类型,但默认为不可变的,即初始化后就不可改变,如果想要让它可变,则要加上mut修饰符,如:

```rs
fn main() {
    let x = 5;
    println!("The value of x is: {x}");
    x = 6;
    println!("The value of x is: {x}");
}
```
>Rust 编译器保证，如果声明一个值不会变，它就真的不会变，所以你不必自己跟踪它。这意味着你的代码更易于推导。

rust中有一个神奇的语法叫做遮蔽(shadowing),当你第二次用`let`声明同一个变量时,就可以覆盖该变量,这可以在同一个作用域中进行,因此与cpp的规则不太一样.


2. 常量用`const`声明,不可加上`mut`修饰,永远不可变,声明时必须要有类型注释(这比隐式推导的Go要好上不少).

```rs
const THREE_HOURS_IN_SECONDS: u32 = 60 * 60 * 3;
```
### 复合类型
1. 元组(tuple): 大致与python中tuple没有什么区别,一旦声明，它的大小就不能增长或缩小:

```rs
fn main() {
    let tup: (i32, f64, u8) = (500, 6.4, 1);
}
// another file
fn main() {
    let tup = (500, 6.4, 1);

    let (x, y, z) = tup;

    println!("The value of y is: {y}");
}
```

2. 数组(array): rust的数组长度是固定的,每个元素必须有相同类型.另一个支持的数组类型则是vector,可变长度,与cpp的vector相似.

```rs
let a: [i32; 5] = [1, 2, 3, 4, 5];
```

### 函数
>Rust 代码中的函数名和变量名通常使用 snake case 风格。在 snake case 中，所有字母都使用小写，并用下划线分隔单词

rust中**语句**是一类没有分号的表达式.

函数可以把值返回给调用它的代码。我们不会给返回值命名，但必须在箭头（->）后面声明它的类型。在 Rust 中，函数的返回值等同于函数体中最后一个表达式的值。你也可以使用 return 关键字并指定一个值，从函数中提前返回；不过大多数函数都会隐式返回最后一个表达式的值。下面是一个带有返回值的函数示例：
```rs
fn five() -> i32 {
    5
}

fn main() {
    let x = five();

    println!("The value of x is: {x}");
}
```
### 控制流
>与Go一样,rust中的if表达式中的条件必须是bool值,不允许隐式的类型转换,否则会报错,使用的仍然是C系的`else if`写法.

Rust 有三种循环：loop、while 和 for:
1. loop 关键字告诉 Rust 反复执行一段代码，要么永远执行下去，要么直到你明确要求它停止。

rust一个比较神奇的地方是可以把控制流赋值给变量:

```rs
fn main() {
    let mut counter = 0;

    let result = loop {
        counter += 1;

        if counter == 10 {
            break counter * 2;
        }
    };

    println!("The result is {result}");
}
```

loop还可以带有标签,这类似于c中的label关键字:
```rs
fn main() {
    let mut count = 0;
    'counting_up: loop {
        println!("count = {count}");
        let mut remaining = 10;

        loop {
            println!("remaining = {remaining}");
            if remaining == 9 {
                break;
            }
            if count == 2 {
                break 'counting_up;
            }
            remaining -= 1;
        }

        count += 1;
    }
    println!("End count = {count}");
}
```
- 与label的待遇一样,正常的代码里是不应该有loop出现的

2. while关键字则为正常的写法:
```rs
fn main() {
    let a = [10, 20, 30, 40, 50];
    let mut index = 0;

    while index < 5 {
        println!("the value is: {}", a[index]);

        index += 1;
    }
}
```
3. for用于遍历容器:
```rs
fn main() {
    let a = [10, 20, 30, 40, 50];

    for element in a {
        println!("the value is: {element}");
    }
}
```
### 所有权（ownership）


# Web Scraping with Python,3rd edition
# Node.js Cookbook
## 介绍
>Node.js 创建于2009年，是一个跨平台的开源JavaScript运行时，允许你在浏览器环境之外执行JavaScript。它封装了谷歌浏览器的JavaScript引擎——V8引擎，使JavaScript能够在脱离浏览器的情况下运行

Node的执行环境为单线程,通过异步I/O来实现高并发,这与Python的GIL极为相似,不过也正是因为这样,后端通常不会让Node来负责,否则就会受到性能上的限制.
## 文件系统
# Elasticsearch in Action, Second Edition
- [为什么不用Solr](https://learnku.com/articles/43880)
## 概述
传统的数据库仅能返回普通的查询结果,而若是要实现智能提示和多样化搜索,就需要搜索引擎这些经过了优化处理的数据库来解决了.

Es的底层引擎为使用Java编写的Lucene,再在外面套了一层符合Rest规范的API,然后还有一个配套的前端管理程序Kibana.

![示意图](PixPin_2026-07-29_10-55-57.webp)

![创建过程](PixPin_2026-07-29_11-01-18.webp)

![查询过程](PixPin_2026-07-29_11-06-37.webp)

到这里我们也看明白了,Es的使用方法就是通过Restful API来传输Json文档而已,这种方法非常高效,而且掩盖了背后的复杂优化过程.

- 不过,也只有搜索引擎才能这么干,毕竟搜索请求都是幂等的,所以不会受到并发的困扰.而对于普通的数据库来说,只好老老实实地通过底层驱动连接了,如果有人能够想到更美妙的解决方法,诺奖不说,图灵奖是绝对有的.

>Elasticsearch has an algorithm called **Okapi Best Match 25** (BM25), which is an **enhanced** term frequency/inverse document frequency (**TF/IDF**) similarity algorithm that calculates the relevancy scores for the results and sorts them in that order when presenting them to the client.

而在执行搜索时,我们也可以手动给关键字分配对应的权重,来返回自己想要的搜索结果,而在我们平常的搜索时,这一过程都是自动进行的.

## 架构

# golang实现网络爬虫

# Redis in action(待补充)
## 介绍
Redis有5种基础数据类型:
1. string: 支持字符串,整数和浮点数
2. list: 链表,每个节点包含一个元素,元素可重复
3. set: 无序的字符串集合,元素不可重复
4. hash: 哈希表,存储键值对
5. zset: 有序字典,存储键值对


string类型支持get,set,del三种方法:
![使用示例](PixPin_2026-07-13_10-06-47.webp)

list类型支持以下命令:
| 命令     | 行为                                     |
| -------- | ---------------------------------------- |
| `RPUSH`  | 将给定值推入列表的右端                   |
| `LRANGE` | 获取列表在给定范围上的所有值             |
| `LINDEX` | 获取列表在给定位置上的单个元素           |
| `LPOP`   | 从列表的左端弹出一个值，并返回被弹出的值 |

- 左右端都可以进行操作,前缀分别是`L`,`R`.

set类型支持`sadd`,`srem`等命令

![示例](PixPin_2026-07-13_10-14-46.webp)

![hash](PixPin_2026-07-13_10-16-55.webp)

![zset](PixPin_2026-07-13_10-16-41.webp)



# Redis设计与实现(待补充)

# RabbitMQ官方python文档

# Fluent Python ,second edition
比较一般,讲的不够深入,尽管名气很大,但不推荐阅读.

# Full Stack Testing,2rd edition
- July/9 2026: Second Edition
  - 我读这本书的日期为7/19,而zlib上就已经有资源了,确实离谱

## ch1
>Starting testing early in the delivery cycle to provide faster feedback is referred to as **shift-left testing**, and it’s a key principle of full stack testing.

![图示](PixPin_2026-07-21_17-39-07.webp)
## 总结
基本都是概念,没多少实战,还教我用AI写测试,跟我原来想的差距有点大.



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
对于学过Java和Js的人来说,Dart语法确实很容易掌握,但这种乱糟糟的写法开发效率显然弗如JSX远甚.
## 总结
越看越头痛呢,虽然知道这种跨平台框架到头来还是写前端样式,但是静态类型和杂糅的语法让Dart的样式函数变得面目可憎:
```dart
import 'package:flutter/material.dart';

class ClipTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 头像  
    Widget avatar = Image.asset("imgs/avatar.png", width: 60.0);
    return Center(
      child: Column(
        children: <Widget>[
          avatar, //不剪裁
          ClipOval(child: avatar), //剪裁为圆形
          ClipRRect( //剪裁为圆角矩形
            borderRadius: BorderRadius.circular(5.0),
            child: avatar,
          ), 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                widthFactor: .5,//宽度设为原来宽度一半，另一半会溢出
                child: avatar,
              ),
              Text("你好世界", style: TextStyle(color: Colors.green),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRect(//将溢出部分剪裁
                child: Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5,//宽度设为原来宽度一半
                  child: avatar,
                ),
              ),
              Text("你好世界",style: TextStyle(color: Colors.green))
            ],
          ),
        ],
      ),
    );
  }
}
```

如果以后有机会的话,我会再来学习的...
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
# Powerful Python
尽管是24年出版的书,但内容都很老套,也都讲的很简单.
# High Performance Python 3rd edition
- 25年5月出版的,新鲜的很

讲的一般般,大多数内容我都已经学过了.
# Effective Software Testing(待补充)
## 软件测试介绍
>软件工程中的实证研究一再表明，简洁无味的代码比复杂代码更不易出现缺陷（参见 Shatnawi 和 Li 2006年的论文）。
然而，仅有简洁远远不够。
认为测试可以完全被简洁取代是天真的看法。"通过设计保证正确性"同样如此：设计好代码并不意味着能避免所有可能的错误。

![金字塔](PixPin_2026-07-27_12-01-45.webp)
# Kafka: The Definitive Guide,2rd edition
## 介绍
- Kafka由Linkedin在09年研发出来,并在11年捐献给Apache基金会,所以又叫Apache Kafka.

>I thought that since Kafka was a system optimized for writing, 
using a writer’s name would make sense. 
I had taken a lot of lit classes in college and liked Franz Kafka. 
Plus the name sounded cool for an open source project.

Kafka中的数据单位称为消息(messages)。如果你有数据库背景，可以将此视为类似行或记录的概念。对Kafka而言，消息本质上就是一个字节数组，因此其中包含的数据对Kafka没有特定格式或含义。消息可以附带一个可选的元数据片段，称为键,可以辅助消息写入kafka中.

- Kafka传输的消息格式一般为紧凑的Apache Avro而不是可读性强的Json
- Kafka中的消息按照topic进行分类(类似于文件系统中的文件夹),每个topic可以有多个partition(分区),消息以追加形式写入分区中,按照顺序从头到尾读取.
- 不同服务器可以存储一个分区的多个副本,从而保障数据安全.
- stream表示消息传输时的数据流.

Kafka clients是Kafka server的使用者,有两种基本类型: producers and consumers.

- 单个Kafka server被称为Broker(代理),它从生产者处接受消息并存储,并响应消费者的服务请求.
- 多个Broker组成一个cluster(代理集群),Broker中自动选举一个Controller作为管理员.

消息保留了一定时间(例如7天)或者分区达到特定的容量大小就会自动进行删除,这是Kafka的独特之处,简化了其他消息队列系统中复杂的数据库管理方式.

## 补充: docker启动kafka
由于这本书出版于2021年,当时kafka版本为2.8.0,底层用的还是ZooKeeper,而现在Kafka更新到了4.3.1版本,底层全面换成了KRaft,所以书中的安装指南基本没有任何作用了.

- [原因](https://spoud-io.medium.com/embracing-the-future-of-kafka-why-its-time-to-migrate-from-zookeeper-to-kraft-f1a5225ac48a)

要想跨平台使用Kafka,显然只能让Docker来干活儿了,自然,我是不知道怎么写kafka的compose文档的,看一下
[官方](https://hub.docker.com/r/apache/kafka)推荐的单节点写法:

```yml
services:
  broker:
    image: apache/kafka:latest
    container_name: broker
    ports:
      - 9092:9092
    environment:
      KAFKA_NODE_ID: 1
      KAFKA_PROCESS_ROLES: broker,controller
      KAFKA_LISTENERS: PLAINTEXT://localhost:9092,CONTROLLER://localhost:9093
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://localhost:9092
      KAFKA_CONTROLLER_LISTENER_NAMES: CONTROLLER
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT
      KAFKA_CONTROLLER_QUORUM_VOTERS: 1@localhost:9093
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1
      KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR: 1
      KAFKA_TRANSACTION_STATE_LOG_MIN_ISR: 1
      KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS: 0
      KAFKA_NUM_PARTITIONS: 3
```
考虑到我们只是测试使用,所以就不需要绑定到数据卷上了,kafka,启动!

```bash
docker compose up -d 
```
启动成功后,首先运行以下命令创建topic:
```bash
docker exec -it kafka /opt/kafka/bin/kafka-topics.sh --create --topic test-topic --partitions 1 --replication-factor 1 --bootstrap-server localhost:9092
```
在该终端启动producer:
```bash
docker exec -it kafka /opt/kafka/bin/kafka-console-producer.sh --topic test-topic --bootstrap-server localhost:9092
```

另开一个终端启动consumer:
```bash
docker exec -it kafka /opt/kafka/bin/kafka-console-consumer.sh --topic test-topic --from-beginning --bootstrap-server localhost:9092
```

在producer这边随意发送消息,都可以在consumer那边接收到并输出:

![效果图](PixPin_2026-07-27_10-52-43.webp)

效果很不错!

- 上述命令中的第一行完全相同,因为都要用到kafka随安装自带的CLI工具.
## 生产者
首先配置`bootstrap.servers`等参数来初始化Producer,接着构建一个ProducerRecord对象,该对象对应所有kafka能发送的信息(纯文本,Json字符串,key-value对,数据表),最终由producer发送给kafka的client.
## 消费者
>消费者数量超过topic中的分区数量是毫无意义的——部分消费者将处于空闲状态

![示意图](PixPin_2026-07-29_10-10-08.webp)

创建消费者的过程与创建生产者没有太大的区别,同样需要先配置servers等属性,并分配特定的消费者组id,再通过订阅(subscribe)方法来接受特定的topic下的消息.

## 总结
了解到这里就基本足够了,后面就是一些琐碎的配置环节了.
# RabbitMQ in Depth
该说是太老了还是怎么呢,讲的一点都不清晰,看了两章都没看明白RabbitMQ的基本原理
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

这就是我们要用到消息队列的地方了,RabbitMQ则是其中的代表框架.



## 异步爬虫
- 前面的概念辨析很有看头
## 总结
尽管确实很全面,奈何讲解都简单的过分了,不够深入,基本都是依靠框架来实现爬虫的.但还是为数不多的爬虫好书.