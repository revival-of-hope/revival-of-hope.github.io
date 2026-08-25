---
title: "技术文章阅读笔记-5"
date: 2026-08-19T14:14:44+08:00
description: 新笔记,新气象~
image: 53656198_p0-必殺。.webp 
---
# Designing Data-Intensive Applications, Second Edition
## 前言
- 第一版于2017年出版,第二版于2026年出版,中间间隔了十年,所以章节内容上有了大幅度的改动.
- 第一版出版后就被很多人奉为神书,那么再版后想必更厉害了吧.

>There are hundreds of databases to choose from. Which one should you use for your application? The short answer is, “It depends.” The long answer is…​this book.

这才是软件工程最美丽的地方,技术的变迁和环境的动荡迫使着程序员们殚精竭虑,设计出符合当前情况的最好架构.
## 背景
先看看两位作者的title: Martin Kleppmann and Chris Riccomini

>Martin Kleppmann（马丁·克莱普曼）目前是英国剑桥大学计算机科学与技术系副教授（Associate Professor），主要研究去中心化系统、Local-first 协作软件和安全协议，并教授分布式系统和密码协议相关课程。此前曾在慕尼黑工业大学从事研究，并在剑桥大学获得博士学位。
>
>Kleppmann 在进入学术界以前做过多年互联网工程和创业。他曾共同创办并出售两家创业公司，也曾在 LinkedIn 等互联网公司从事大规模数据基础设施工作；其中还包括创业公司 Rapportive。

第一版的作者只有他一个人,还是很厉害的,他甚至还有一个[博客](https://martin.kleppmann.com)

Chris Riccomini,O'Reilly 对他的介绍是：拥有 15年以上软件工程经验，先后在 PayPal、LinkedIn、WePay 工作，目前经营 Materialized View Capital，投资基础设施类创业公司
## 基本
>如果一个应用程序开发过程中的主要挑战之一是数据管理，我们便称之为**数据密集型应用**.
>在计算密集型系统中，挑战在于将极其庞大的计算任务并行化；而在数据密集型应用中，我们通常更关注存储和处理海量数据、管理数据变更、在面临故障和并发时确保一致性，以及保证服务的高可用性等问题。

前两章基本都是经验之谈,可看的地方不多.
## 数据模型
对常见数据库的一个总结,稍微有一点看头
## 存储
>实际上，哈希表在数据库索引中的使用并不普遍。更常见的做法是按照键的顺序来组织数据

>本章目前为止讨论的数据结构都是为了解决磁盘的限制问题。与主存相比，磁盘操作起来更为不便。无论是机械硬盘还是固态硬盘，若要实现良好的读写性能，都需要精心安排数据布局。我们容忍这种不便，是因为磁盘拥有两大显著优势：持久性（断电时内容不会丢失）以及每吉字节成本低于RAM。

## 编码
介绍了Avro,Protobuf,Json Schema等主流编码方式
### Json Schema
不看不知道,原来Json Schema这么出名,MCP,OpenAPI,OAuth都用的是它,格式如下:
```json
{
  "type": "object",
  "properties": {
    "first_name": { "type": "string" },
    "last_name": { "type": "string" },
    "birthday": { "type": "string", "format": "date" },
    "address": {
       "type": "object",
       "properties": {
         "street_address": { "type": "string" },
         "city": { "type": "string" },
         "state": { "type": "string" },
         "country": { "type" : "string" }
       }
    }
  }
}
```

### RPC介绍
>本地函数调用是可预测的，其成功与否仅取决于你控制的参数。而网络请求则不可预测，原因完全不受你控制。例如，请求或响应可能因网络问题丢失，远程机器可能响应缓慢或不可用。网络问题很常见，因此应用程序必须预见这些问题（例如，通过重试失败的请求）。
>
>一个本地函数调用要么返回结果、抛出异常，要么永不返回（例如进入无限循环或进程崩溃）。而网络请求则有另一种可能的结果：可能因超时而无结果返回

- 这也是网络游戏制作的一个难点之一



# Building Microservices
## 基础
# Rust 中文学习教程
由于另一本书太难啃了,所以换这本书来试试咸淡.
## 基础
### 语句
```rs
fn add_with_extra(x: i32, y: i32) -> i32 {
    let x = x + 1; // 语句
    let y = y + 5; // 语句
    x + y // 表达式
}
```
语句会执行一些操作但是不会返回一个值，而表达式会在求值后返回一个值，因此在上述函数体的三行代码中，前两行是语句，最后一行是表达式。
### 函数
单元类型 ()，是一个零长度的元组。它没啥作用，但是可以用来表达一个函数没有返回值:
```rs
use std::fmt::Debug;

// 隐式返回
fn report<T: Debug>(item: T) {
  println!("{:?}", item);

}

// 显式返回
fn clear(text: &mut String) -> () {
  *text = String::from("");
}
```
### 所有权


# MySQL是怎样运行的
## 基本
![原理图](PixPin_2026-08-24_12-10-56.webp)

- MySQL的查询缓存过于低效,需要查询语句完全相同才可以生效,所以在8.0版本后被彻底废除


>在客户端程序发起连接的时候，需要携带主机信息、用户名、密码，服务器程序会对客户端程序提供的这些信息进行认证，如果认证失败，服务器程序会拒绝连接

MySQL中的存储引擎列举:
| 存储引擎  | 描述                                 |
| --------- | ------------------------------------ |
| ARCHIVE   | 用于数据存档（行被插入后不能再修改） |
| BLACKHOLE | 丢弃写操作，读操作会返回空内容       |
| CSV       | 在存储数据时，以逗号分隔各个数据项   |
| FEDERATED | 用来访问远程表                       |
| InnoDB    | 具备外键支持功能的事务存储引擎       |
| MEMORY    | 置于内存的表                         |
| MERGE     | 用来管理多个MyISAM表构成的表集合     |
| MyISAM    | 主要的非事务处理存储引擎             |
| NDB       | MySQL集群专用存储引擎                |

我们最常用的就是InnoDB(默认引擎)和MyISAM(旧系统),有时候会用Memory(临时数据),用法如下:
```sql
CREATE TABLE users (
    id BIGINT PRIMARY KEY,
    name VARCHAR(100)
) ENGINE = InnoDB;

CREATE TABLE cache_data (
    id INT PRIMARY KEY,
    value VARCHAR(255)
) ENGINE = MEMORY;
```
这被称为称为“可插拔存储引擎架构”
# Data Storage Architectures and Technologies
# Beginning C,From Beginner to Pro
# EFFECTIVE C
# Fluent C
# C++ CRASH COURSE
# PROFESSIONAL C++
# Linkers and Loaders
## 链接和加载
# 深入理解 AI Agent


# Coding Video,A Practical Guide to HEVC and Beyond(待补充)
## 介绍
>一秒标准的未压缩SD(576p)视频，每秒25帧，大约占用15.5 MB存储空间。这意味着，通过网络或广播频道实时传输这段视频，即每秒发送一秒可播放的视频内容，需要124 Mbit/s的带宽。而一秒未压缩的UHD/4K视频、每秒50帧捕捉，则大约占用620 MB存储空间，实时传输将需要高达5 Gbit/s的传输带宽。

- 由此可知,我们在电子产品中存储的视频都是压缩形式的,只在播放时进行实时的解码.

![说明图](PixPin_2026-08-09_10-23-28.webp)

尽管我们拥有的存储容量和网络带宽比以往任何时候都要多，但存储和传输视频的需求仍在不断超出可用容量。到2023年，约三分之二的消费级电视机已达到4K分辨率或更高。将高性能视频编解码器集成到智能手机和电视等消费设备中，以及对高分辨率视频的期望，使得在存储或传输前压缩或编码视频，并在显示前解码视频成为常态
