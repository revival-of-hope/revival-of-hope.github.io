---
title: java笔记
draft: true
tags: 
    - java
    - 后端
image:
---

# Java历史
- [wiki](https://en.wikipedia.org/wiki/Java_(programming_language))

之所以把Java历史摆在最前面,是因为我们需要知道Java的生态为何如此混乱.
* **1991年06月：项目启动**
    James Gosling、Mike Sheridan 与 Patrick Naughton 发起 Java 语言项目，最初命名为 **Oak**，随后曾更名为 **Green**，最终定名为 **Java**。
* **1996年：正式发布**
    Sun Microsystems 发布 **Java 1.0** 实现。该版本确立了“一次编写，到处运行”（WORA）的核心理念，并因其安全特性和浏览器对 Java Applet 的支持迅速普及。
* **1997年：标准化博弈**
    Sun 曾尝试通过 ISO/IEC JTC 1 和 Ecma International 推动 Java 标准化，但随后撤出，转而通过 **Java Community Process (JCP)** 维持事实上的标准控制。
* **1998年12月：架构分化**
    **Java 2 (J2SE 1.2)** 发布。Java 体系被正式划分为三个方向：面向企业级的 **J2EE**、面向桌面的 **J2SE** 以及面向移动设备的 **J2ME**。
* **2006年：更名与开源启动**
    出于市场营销考虑，Sun 将版本重新命名为 **Java EE**、**Java SE** 和 **Java ME**。同年 11 月，Sun 开始基于 **GPL-2.0** 协议发布 JVM 开源软件。
* **2007年：完成开源**
    除了极少数不持有版权的代码外，Sun 完成了 JVM 核心代码的开源分发。
* **2009年-2010年：所有权更迭**
    **Oracle 收购 Sun Microsystems**。随后不久，Oracle 就 Android SDK 中使用 Java 的问题对 Google 发起诉讼。
* **2010年04月：核心人物离职**
    Java 之父 James Gosling 从 Oracle 辞职。
* **2016年01月：淘汰过时技术**
    Oracle 宣布从 JDK 9 开始，Java 运行时环境将停止支持浏览器插件。


# 环境配置
## 编译器下载
与Cpp运行需要MSVC等编译器,python运行需要python虚拟环境一样,Java运行需要的是JDK(Java Development Kit).
如前面所说,尽管Java版权归Oracle公司所有,但也有开源的社区版本和基于开源版本制作的第三方JDK,性能上的差别非常小.
为了省事,我们直接上[微软官网](https://www.oracle.com/java/technologies/downloads/#java21)下载JDK21即可,这样可以**跳过烦人的环境变量配置环节**.
- 至于为什么不选最新的25版本是因为体积更大也没必要.

## 配置环境变量(可跳过)
与cpp类似,如果不配置编译器的环境变量的话,系统是无法识别你的命令的:
```bash
java --version
java : 无法将“java”项识别为 cmdlet、函数、脚本文件或可运行程序的名称。请检查名称的拼写，如果包括路径，请确保路径正确
，然后再试一次。
所在位置 行:1 字符: 1
+ java --version
+ ~~~~
    + CategoryInfo          : ObjectNotFound: (java:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
```
但是,如果你用的是微软的OpenJDK,就可以在安装的时候勾选配置环境变量直接跳过这一步:
```bash
java --version
openjdk 21.0.10 2026-01-20 LTS
OpenJDK Runtime Environment Microsoft-13106404 (build 21.0.10+7-LTS)
OpenJDK 64-Bit Server VM Microsoft-13106404 (build 21.0.10+7-LTS, mixed mode, sharing)
```

但如果你铁着头选择了Oracle官方版本的话,那么还是需要自己配置的...**预先警告这很麻烦**


## VScode配置Java环境
当你第一次创建`.java`文件时,VScode会自动为你推荐所需的扩展并配置好环境,所以无需额外操作.

# Java学习
- [W3schools](https://www.w3schools.com/java/)
  - 不要看廖雪峰教程...写的并不是很好,而且很枯燥,搞不懂为什么流量这么大.

## 基础语法
### 学习前的要点
我们首先需要知道JAVA的面向对象特性:
1. 所有函数和变量都写在类里面
2. 如果源文件中包含public类,则文件名必须与该类名完全一致
3. 所有的类名都需要大写,仅是一种规范,但最好大写.

例如:
```java
public class Main {
  public static void main(String[] args) {
    System.out.println("Hello World");
  }
}
```
包含了这个代码的文件必须叫做Main.java,区分大小写.

### 主函数
上述代码中的main函数是Java程序的入口,其作用与c/cpp中的main函数别无二致:
```java
public static void main(String[] args) {
    System.out.println("Hello World");
  }
```
如果你不觉得main函数里的`String[] args`参数很奇怪的话,那我就觉得你很奇怪了.

>这个参数作为命令行交互的接收器,尽管你未必会显式用到这个参数,但是必须要写上.
尽管从Java21开始允许不写这个参数了,但是很多企业内部的数据库交互用的依然是Java8...所以还是写上比较好
- 很难想象这么一个简单的修改需要经过将近三十年的考量...Java生态的陈旧性可见一斑
### 变量类型
```java
// 常用变量类型
int myNum = 5;
float myFloatNum = 5.99f;
double myDoubleNum = 3.14159;
char myLetter = 'D';
boolean myBool = true;
String myText = "Hello";
```
值得注意的是唯独String这个变量类型是大写的,因为它是一个类,如前面所说,Java中的类名都需要大写,所以这里就大写了.


# Java构建工具
与Cpp有Make,ninja,CMake类似,Java也有自己的构建工具,早期的构建工具为Ant,目前由Maven和Gradle两款工具统治,它俩也同时承担了包管理器的责任.
## Maven
### Maven历史
#### 1. 概念起源与孵化 (2002 - 2003)
* **2002年**：由 Jason van Zyl 创建，最初作为 Apache Turbine 的子项目，旨在解决该项目极其复杂的构建过程。
* **2003年**：正式被接纳为 Apache 软件基金会的顶级项目。

#### 2. 标准确立与快速普及 (2004 - 2005)
* **2004年7月 (Version 1.0)**：第一个里程碑版本发布。确立了“约定优于配置”的核心理念。
* **2005年10月 (Version 2.0)**：重大架构升级版本。
    * **核心贡献**：确立了 **Maven 中央仓库** (Central Repository) 机制，支持动态下载依赖。
    * **插件架构**：采用基于插件的架构，使其具备了跨语言构建（如 C/C++）的潜力。

#### 3. 架构优化与并行化 (2010)
* **2010年10月 (Version 3.0)**：
    * **解耦与兼容**：在保持与 2.x 项目兼容的同时，重构了核心项目构建器。
    * **性能提升**：引入**并行构建**特性，能够利用多核 CPU 处理大型多模块项目。
    * **非 XML 尝试**：开始支持非 XML 的项目定义文件（如 Ruby、YAML、Groovy），解耦了内存表示与文件格式。

### 使用方法
## Gradle
### Gradle历史
#### 1. 概念孵化与 Groovy 基因 (2007 - 2008)
* **2007年**：Hans Dockter 开始构思一种结合 Ant 的灵活性与 Maven 的依赖管理能力的新工具。
* **2008年4月 (Version 0.1)**：首个版本发布。创始人最初想命名为“Cradle”，但为了使其更具独特性，取 **Groovy** 语言的首字母 **G**，更名为 **Gradle**。其核心特征是使用基于 Groovy 的 DSL 取代繁琐的 XML 配置。

#### 2. 核心架构确立 (2012 - 2014)
* **2012年6月 (Version 1.0)**：历经四年迭代，首个正式稳定版发布。确立了有向无环图 (DAG) 任务模型，解决了复杂构建流程的编排问题。
* **2013年**：**Google 宣布 Android Studio 采用 Gradle 作为官方构建系统**。这一决策直接将 Gradle 推向了顶级构建工具的地位。
* **2014年7月 (Version 2.0)**：提升了构建性能，并正式引入了对原生语言（C/C++）构建的初步支持，展示了其跨语言构建的野心。

#### 3. 性能突破与 Kotlin 引入 (2016 - 2018)
* **2016年8月 (Version 3.0)**：引入 **Gradle Daemon**（守护进程）并默认开启，极大地缩短了短周期任务的启动时间。
* **2017年6月 (Version 4.0)**：引入 **Build Cache**（构建缓存）技术，允许跨机器共享编译产物，大幅减少了大型项目的重复编译时间。
* **2018年11月 (Version 5.0)**：正式支持 **Kotlin DSL**。开发者可以使用类型安全的 Kotlin 编写构建脚本，解决了 Groovy 脚本缺乏 IDE 智能补全和编译时检查的痛点。

#### 4. 现代化与大规模构建优化 (2019 - 2025)
* **2021年4月 (Version 7.0)**：引入 **Version Catalogs**（版本目录），实现了多项目之间依赖版本的集中管理，正式统一了大型项目的依赖规范。
* **2023年2月 (Version 8.0)**：针对配置阶段进行了深度优化，支持 **Configuration Cache**，使得复杂项目的构建配置速度提升数倍。
* **2025年7月 (Version 9.0)**：最新里程碑版本。进一步强化了云端构建能力和对现代 JDK 特性的深度适配，确立了其在高复杂度、高性能要求构建场景下的统治地位。

# 使用Docker开发Java