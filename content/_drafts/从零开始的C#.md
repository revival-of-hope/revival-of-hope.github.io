---
title: 从零开始的C#
draft: true
tags:
image:
---
本文的最终目标是使用C#实现一个完整的零售系统,使用oracle数据库作为后端.
- 至于为什么用这么古老的数据库是因为项目要求

# 环境配置

## .NET编译器介绍
- [wiki](https://en.wikipedia.org/wiki/.NET)
### 是什么,有什么用
.NET是微软发布的开源编译器,支持C#,F#和Visual Basic开发,类似于Java中的JDK和Cpp中的MSVC,至于为什么叫.NET,只不过是微软糟糕的命名品味(.net=>.NET)而已.
- Windows的PowerShell,Visual Studio均基于.NET构建,Unity也需要.NET环境来解释C#脚本
### .NET历史
* **2000年 - 2002年：诞生与标准化**
    微软在 PDC 2000 会议上公布 C# 语言，并随后将 **CLI (公共语言基础设施)** 提交 ECMA 进行标准化。2002 年，**.NET Framework 1.0** 正式发布，确立了基于虚拟运行时的受控代码开发模式。

* **2014年：开源与跨平台转型**
    11 月 12 日，微软宣布启动 **.NET Core** 项目。这是一个完全重构的开源、跨平台版本，旨在摆脱对 Windows 操作系统的绑定，并成立了 **.NET Foundation** 负责社区化运营。

* **2016年 - 2017年：.NET Core 初期**
    2016 年 6 月，**.NET Core 1.0** 发布，正式实现 Linux 和 macOS 运行能力。2017 年发布的 **.NET Core 2.0** 引入了 **.NET Standard 2.0**，统一了 API 规范，解决了新旧平台间的代码兼容难题。

* **2019年：桌面支持与成熟**
    **.NET Core 3.0** 发布。该版本最显著的变化是支持 WPF 和 WinForms 桌面应用在 Core 环境下运行，性能相比旧版 Framework 大幅提升。

* **2020年：架构大统一 (.NET 5)**
    微软跳过版本号 4.0 并移除了 "Core" 后缀，发布 **.NET 5**。此举标志着 .NET Framework（旧版）和 .NET Core（新版）合二为一，成为未来唯一的 .NET 演进路径。

* **2021年 - 2023年：LTS 演进 (.NET 6 - .NET 8)**
    **.NET 6** (2021) 确立了 3 年期的长期支持 (LTS) 模式。**.NET 8** (2023) 作为目前的核心 LTS 版本，引入了 **Native AOT** 编译技术，极大优化了云原生场景下的启动速度。

* **2024年 - 2026年：现代版本与 AI 集成**
    **.NET 9** (2024) 重点增强了 AI 扩展能力和运行时效率。目前最新的 **.NET 10 (LTS)** 已于 2025 年 11 月发布，其支持周期将持续至 2028 年，成为当前企业级开发的基础版本。
### Nuget
- [wiki](https://en.wikipedia.org/wiki/NuGet)
.NET的包管理器,被集成在.NET中,不需要单独下载即可直接调用
- 至于为什么叫Nuget,则又是微软的糟糕命名品味(new get=>nuget)了
### .NET命令行使用
* **`dotnet new`**：项目初始化。
    * `dotnet new console`：创建一个控制台程序。
    * `dotnet new webapi`：创建一个 ASP.NET Core Web API 项目。
* **`dotnet restore`**：依赖恢复。
    * 调用 NuGet 引擎，根据项目文件（.csproj）下载并安装所有缺失的第三方包。
* **`dotnet build`**：项目编译。
    * 将源代码编译为中间语言（IL）文件（.dll）。
* **`dotnet run`**：一键运行。
    * 自动执行编译并启动当前项目。
* **`dotnet watch`**：热重载开发。
    * 监控文件更改，保存代码后自动重新编译并刷新程序（常用于 Web 开发）。
* **`dotnet add package <PackageName>`**：添加依赖。
    * 从 NuGet 仓库下载并引用指定的包（如 `dotnet add package Newtonsoft.Json`）。
* **`dotnet publish`**：发布部署。
    * 将应用及其运行所需的全部依赖打包到文件夹中。
    * `dotnet publish -c Release -r win-x64 --self-contained`：发布为 Windows 平台下的自包含（不依赖环境）程序。
* **`dotnet tool install`**：安装全局工具。
    * 类似于 npm install -g，用于安装诸如实体框架工具（ef）等扩展功能。

## Oracle开发环境配置


- [Reddit教程](https://www.reddit.com/r/csharp/comments/16q2ess/crud_operations_with_net_on_oracle_database/?tl=zh-hans)

- [下载最新版本](https://www.oracle.com/database/technologies/xe-downloads.html)的Oracle数据库免费版本,由于有1.5个G,所以先下载后再往下看比较好

由于Oracle要标榜自己面向AI,把数据库名字改成了`Oracle AI Database 26ai`这样的逆天名字,还特意在主页里隐藏了老版本的数据库,只能通过特意的搜索才能找到正常的21c XE版本.

当然,由于需要面对不同开发平台进行各种各样的环境配置,光下这个还是不够的,让我重新列出需要的所有东西:
1. 上述的Oracle数据库版本
2. 安装了.NET桌面开发扩展的VS2022 community,因为Oracle目前还不充分支持VS2026,故只能使用VS2022进行开发.
3. `Oracle Data Provider for .NET (ODP.NET)`: 点开[这个链接](https://www.oracle.com/database/technologies/net-downloads.html),下载第一行的`Oracle.ManagedDataAccess.Core`即可,需要注意的是,这是一个Oracle扩展,只会在你安装包的这个vs项目中生效.
   1. `.NET (Core)`列的Nuget包面向的是.NET,`.NET Framework`列的Nuget包面向的是.NET framework
   2. 当然,我们这里的安装方式是通过命令行安装的,实际上也可以使用图形化的安装方式,但是就麻烦很多了
   3. `dotnet add package Oracle.ManagedDataAccess.Core --version 23.26.200`: 方便起见直接在这里贴出了命令行通过.NET进行安装的链接
4. 可选: 安装免费的[sqldeveloper](https://www.oracle.com/database/sqldeveloper/technologies/download/),用来直接连接和操作数据库
5. 可选: 安装`[Oracle Developer Tools for Visual Studio 2022](https://marketplace.visualstudio.com/items?itemName=OracleCorporation.OracleDeveloperToolsForVisualStudio2022)`扩展,用来在VS内部可视化数据库
6. 可选: 安装DBeaver,通用的数据库管理工具,尽管对Oracle数据库的支持程度没有SQLdeveloper好,但胜在轻量好用
## 使用VS运行项目
1. 在创建新项目中选择语言为C#,找到被标记的这一栏

![alt text](../images/2026-04-03/PixPin_2026-04-13_20-56-53.webp)
- 可以看到有两种C#窗体应用,第一种是我们要选择的.NET平台,第二个则是古老的.NET framework平台

2. 随便起个名字比如说test,选择默认的.NET 8.0(长期支持版本)
3. 在终端输入`cd test`: VS非常神奇的地方在于当你创建.NET项目时,VS会创建一个同名子文件夹来存放项目...
   1. 也就是说,所有的东西和.NET依赖并不在根目录,而是会在test子文件夹中,所以这里我们需要`cd test`
4. 再输入上述的命令行安装链接,安装之后按一下f5,成功弹出来一个空白的窗口
5. 但是现在我们打开解决方案资源管理器后,点击里面的Form1.cs,弹出来的是一个空白窗口,右键该界面的空白处或者右键Form1.cs即可查看代码...
![alt text](../images/2026-04-03/PixPin_2026-04-13_21-09-50.webp)


## 使用VScode运行项目
没有人喜欢用VS来开发,所以我们可以通过终端来初始化和运行C#项目:
1. 创建一个项目后在终端输入`dotnet new`,提示你可以创建以下项目,这正好对应了之前VS中的创建项目方式:
```bash
“dotnet new”命令基于模板创建 .NET 项目。

常用模板包括:
模板名            短名称    语言        标记
----------------  --------  ----------  ----------------------
Blazor Web 应用   blazor    [C#]        Web/Blazor/WebAssembly
Windows 窗体应用  winforms  [C#],VB     Common/WinForms
WPF 应用程序      wpf       [C#],VB     Common/WPF
控制台应用        console   [C#],F#,VB  Common/Console
类库              classlib  [C#],F#,VB  Common/Library
```
2. 再输入`dotnet run`即可运行项目,实现与VS中相同的效果
3. 但要在VScode中进行C#和Oracle开发的话我们还需要下载.NET相关的插件以及`Oracle SQL Developer Extension for VSCode`,然后就可以用VScode开始开发了...

# C#学习
- 根据[w3schools](https://www.w3schools.com/cs/)速览
## C#历史
- [wiki](https://en.wikipedia.org/wiki/C_Sharp_(programming_language))
- [面向cpp开发者的c#教程](https://learn.microsoft.com/en-us/previous-versions/visualstudio/visual-studio-2008/yyaad03b(v=vs.90)?redirectedfrom=MSDN)

C#（C-Sharp）由微软于 2002 年正式发布,借鉴了Java和cpp的语法.(真实原因在当时Java被Sun公司控制,而且使用了繁琐的授权协议,微软不得不重新开发一门语言用于.NET构建,直到06年Sun公司才将Java开源,但为时已晚,而Unity之所以选择C#为官方语言也或多或少是由于上述的原因)

>为什么叫C#:
The name "C sharp" was inspired by the musical notation whereby a sharp symbol indicates that the written note should be made a semitone higher in pitch.This is similar to the language name of C++, where "++" indicates that a variable should be incremented by 1 after being evaluated. The sharp symbol also resembles a ligature of four "+" symbols (in a two-by-two grid), **further implying that the language is an increment of C++**.



## 基础语法
以cpp为参照的话,除了函数和OOP之外,基础语法都差不多,除了以下几个例外:
### 浮点数
float型变量需要在数字后面加F,double型变量需要在数字后面加D:
```c#
double myNum = 19.99D;
float myNum = 5.75F;
```
### 数组
数组的语法上c#与Java类似:

**基本声明方式**
```cs
string[] cars = {"Volvo", "BMW", "Ford", "Mazda"};
int[] myNum = {10, 20, 30, 40};

cars[0] = "Opel";
Console.WriteLine(cars[0]);
// Now outputs Opel instead of Volvo
```

**使用new操作符的声明方式**
```cs
// Create an array of four elements, and add values later
string[] cars = new string[4];

// Create an array of four elements and add values right away 
string[] cars = new string[4] {"Volvo", "BMW", "Ford", "Mazda"};

// Create an array of four elements without specifying the size 
string[] cars = new string[] {"Volvo", "BMW", "Ford", "Mazda"};

// Create an array of four elements, omitting the new keyword, and without specifying the size
string[] cars = {"Volvo", "BMW", "Ford", "Mazda"};
```
#### 二维数组
C#的二维数组声明特别奇怪:
>To create a 2D array, add each array within its own set of curly braces, and insert a comma (,) inside the square brackets:

```cs
int[,] numbers = { {1, 4, 2}, {3, 6, 8} };
```

> The single comma **[,]** specifies that the array is two-dimensional. A three-dimensional array would have two commas: **int[,,]**.

自然,访问的时候也需要用到逗号:
```cs
int[,] numbers = { {1, 4, 2}, {3, 6, 8} };

for (int i = 0; i < numbers.GetLength(0); i++) 
{ 
  for (int j = 0; j < numbers.GetLength(1); j++) 
  { 
    Console.WriteLine(numbers[i, j]); 
  } 
}  
```

### 字符串打印
C#支持与python相同的插入字符串语法
```c#
string firstName = "John";
string lastName = "Doe";
string name = $"My full name is: {firstName} {lastName}";
Console.WriteLine(name);
```
### foreach遍历
C#比cpp多了一个foreach遍历,基础格式如下:
```cs
foreach (type variableName in arrayName) 
{
  // code block to be executed
}
```
**具体例子**
```cs
string[] cars = {"Volvo", "BMW", "Ford", "Mazda"};
foreach (string i in cars) 
{
  Console.WriteLine(i);
}
```

## 方法
与java相同,在`C#9.0`(2020年)之前,都是不支持函数独立于类出现的,换句话说,所有的函数都被封装在类里面,称为**方法(method)**
### Main方法
C#毫无道理的沿用了Java的扭曲main函数声明方式:
```cs
static void MyMethod(string fname) 
{
  Console.WriteLine(fname + " Refsnes");
}

static void Main(string[] args)
{
  MyMethod("Liam");
  MyMethod("Jenny");
  MyMethod("Anja");
}
```
- 真的没考虑过优美一点的把这个参数`string[] args`去掉吗


### 具名调用
java和cpp都不支持,类似python的函数调用方式,不同的是python使用等于号而非冒号.

```cs
static void MyMethod(string child1, string child2, string child3) 
{
  Console.WriteLine("The youngest child is: " + child3);
}

static void Main(string[] args)
{
  MyMethod(child3: "John", child1: "Liam", child2: "Liam");
}

// The youngest child is: John
```
### 方法修饰符

#### 访问修饰符 (Access Modifiers)
决定方法在何处可见。
* **`public`**：无限制访问。
* **`private`**：仅限当前类内部访问（默认）。
* **`protected`**：仅限当前类及子类访问。


#### 继承修饰符 (Inheritance Modifiers)
控制方法在派生类中的行为。
* **`virtual`**：虚方法。允许子类通过 `override` 重写。
* **`abstract`**：抽象方法。不包含实现，必须在非抽象子类中重写。
* **`override`**：重写。显式声明覆盖父类的 `virtual` 或 `abstract` 方法。
* **`sealed`**：密封。禁止子类进一步重写该方法。
* **`new`**：隐藏。显式声明隐藏父类的同名成员，不参与多态。



#### 生命周期与状态修饰符
* **`static`**：静态方法。属于类本身，而非类的实例，通过类名直接调用。
* **`async`**：异步方法。标记方法包含异步操作，允许使用 `await`。
* **`unsafe`**：不安全代码。允许在该方法内部使用指针。



## OOP
大部分语法与Java高度相似.
### constructor(构造器)
由于C#没有this指针,所以可以直接这么写:
```cs
class Car
{
  public string model;
  public string color;
  public int year;

  // Create a class constructor with multiple parameters
  public Car(string modelName, string modelColor, int modelYear)
  {
    model = modelName;
    color = modelColor;
    year = modelYear;
  }

  static void Main(string[] args)
  {
    Car Ford = new Car("Mustang", "Red", 1969);
    Console.WriteLine(Ford.color + " " + Ford.year + " " + Ford.model);
  }
}
```
### 类外访问私有属性
这部分的语法非常奇怪,这种语法糖过于跳脱了:
```cs
class Person
{
  private string name; // field
  public string Name   // property
  {
    get { return name; }
    set { name = value; }
  }
}

class Program
{
  static void Main(string[] args)
  {
    Person myObj = new Person();
    myObj.Name = "Liam";
    Console.WriteLine(myObj.Name);
  }
}
```
甚至还有简写版本:
```cs
class Person
{
  public string Name  // property
  { get; set; }
}

class Program
{
  static void Main(string[] args)
  {
    Person myObj = new Person();
    myObj.Name = "Liam";
    Console.WriteLine(myObj.Name);
  }
}
```

### 继承
这部分的语法又蹦回了C++,不知道设计者是怎么想的...
```cs
class Vehicle  // base class (parent) 
{
  public string brand = "Ford";  // Vehicle field
  public void honk()             // Vehicle method 
  {                    
    Console.WriteLine("Tuut, tuut!");
  }
}

class Car : Vehicle  // derived class (child)
{
  public string modelName = "Mustang";  // Car field
}

class Program
{
  static void Main(string[] args)
  {
    // Create a myCar object
    Car myCar = new Car();

    // Call the honk() method (From the Vehicle class) on the myCar object
    myCar.honk();

    // Display the value of the brand field (from the Vehicle class) and the value of the modelName from the Car class
    Console.WriteLine(myCar.brand + " " + myCar.modelName);
  }
}
```
### 多态
总算把Cpp那奇怪的重载前缀顺序调整过来了.

```cs
class Animal  // Base class (parent) 
{
  public virtual void animalSound() 
  {
    Console.WriteLine("The animal makes a sound");
  }
}

class Pig : Animal  // Derived class (child) 
{
  public override void animalSound() 
  {
    Console.WriteLine("The pig says: wee wee");
  }
}

class Dog : Animal  // Derived class (child) 
{
  public override void animalSound() 
  {
    Console.WriteLine("The dog says: bow wow");
  }
}

class Program 
{
  static void Main(string[] args) 
  {
    Animal myAnimal = new Animal();  // Create a Animal object
    Animal myPig = new Pig();  // Create a Pig object
    Animal myDog = new Dog();  // Create a Dog object

    myAnimal.animalSound();
    myPig.animalSound();
    myDog.animalSound();
  }
}
```
### 抽象(Abstraction)
类似Java,但写法上有点差异:
```cs
// Abstract class
abstract class Animal
{
  // Abstract method (does not have a body)
  public abstract void animalSound();
  // Regular method
  public void sleep()
  {
    Console.WriteLine("Zzz");
  }
}

// Derived class (inherit from Animal)
class Pig : Animal
{
  public override void animalSound()
  {
    // The body of animalSound() is provided here
    Console.WriteLine("The pig says: wee wee");
  }
}

class Program
{
  static void Main(string[] args)
  {
    Pig myPig = new Pig(); // Create a Pig object
    myPig.animalSound();  // Call the abstract method
    myPig.sleep();  // Call the regular method
  }
} 
```
### Interface(接口)
接口也使用普通的继承符号`:`
```cs
// Interface
interface IAnimal 
{
  void animalSound(); // interface method (does not have a body)
}

// Pig "implements" the IAnimal interface
class Pig : IAnimal 
{
  public void animalSound() 
  {
    // The body of animalSound() is provided here
    Console.WriteLine("The pig says: wee wee");
  }
}

class Program 
{
  static void Main(string[] args) 
  {
    Pig myPig = new Pig();  // Create a Pig object
    myPig.animalSound();
  }
}
```
#### 多重接口
```cs
interface IFirstInterface 
{
  void myMethod(); // interface method
}

interface ISecondInterface 
{
  void myOtherMethod(); // interface method
}

// Implement multiple interfaces
class DemoClass : IFirstInterface, ISecondInterface 
{
  public void myMethod() 
  {
    Console.WriteLine("Some text..");
  }
  public void myOtherMethod() 
  {
    Console.WriteLine("Some other text...");
  }
}

class Program 
{
  static void Main(string[] args)
  {
    DemoClass myObj = new DemoClass();
    myObj.myMethod();
    myObj.myOtherMethod();
  }
} 
```
### Enum
这部分语法朝向Cpp,但又有一点细微的差异: 是强类型的,需要显示转换成int等类型;可以写在类外面,也可以写在类里面.
```cs
enum Months
{
  January,    // 0
  February,   // 1
  March,      // 2
  April,      // 3
  May,        // 4
  June,       // 5
  July        // 6
}

static void Main(string[] args)
{
  int myNum = (int) Months.April;
  Console.WriteLine(myNum);
}
```

>You can also assign your own enum values, and the next items will **update their numbers accordingly**:
```cs
enum Months
{
  January,    // 0
  February,   // 1
  March=6,    // 6
  April,      // 7
  May,        // 8
  June,       // 9
  July        // 10
}

static void Main(string[] args)
{
  int myNum = (int) Months.April;
  Console.WriteLine(myNum);
}
```
### 异常处理
这部分朝向Java,使用了try-catch-finally体系.

```cs
try
{
  int[] myNumbers = {1, 2, 3};
  Console.WriteLine(myNumbers[10]);
}
catch (Exception e)
{
  Console.WriteLine("Something went wrong.");
}
finally
{
  Console.WriteLine("The 'try catch' is finished.");
}
```

## 命名空间和包导入
```cs
using System.ComponentModel.DataAnnotations;
using RetailSystem.API.Models;

namespace RetailSystem.API.DTOs;

```
## 总结
C#本质就是Cpp和Java的结合版,但是自己又做了很多魔改,主要是C#的定位比较奇怪,身为强类型的语言,只能作为脚本语言存在于一些不是那么广泛的应用领域上,所以如果不是必须要用的话没必要去学.

# .NET开发学习
类似python有很多库一样, C#也有很多库和框架:
1. `ASP.NET Core`: 用于构建 Web 接口 (API) 和 Web 应用程序
2. `Dapper`: 轻量级的ORM(对象关系映射)框架
3. `Entity Framework Core` (EF Core): 官方推荐的全功能ORM框架
4. `Unity`: 游戏开发框架
5. `ADO.NET`: .NET应用程序与数据库的通信框架

不管怎样,本项目主要用到的库是`Entity Framework Core`和`ASP.NET Core`,分别对应数据库处理和网页接口处理

## ASP.NET Core
### 历史
ASP.NET Core这个奇怪的名字是有来头的:
1. Active Server Pages (ASP) : 微软于1996年发布的服务端框架
2. ASP.NET: 基于ASP重新构建的.NET framework中的框架
3. ASP.NET Core: 微软于2016年基于ASP.NET重新构建的.NET框架

微软的开发人员真的从来没想过起一个更好记的名字吗...
#### 经典 ASP 阶段 (1996 - 2000)
这是技术的起点，基于组件对象模型 (COM) 和脚本语言（如 VBScript）。
* **1996年**：ASP 1.0 随 IIS 3.0 发布，标志着服务器端动态网页生成的开始。
* **1997年**：ASP 2.0 发布，引入了 Session 和 Application 等核心内置对象。
* **2000年**：ASP 3.0 优化了执行性能并默认开启缓冲，成为该时代的稳定标准。

#### .NET Framework 与 ASP.NET 阶段 (2002 - 2015)
架构发生根本性重写，从解释型脚本转向编译型语言，建立在公共语言运行时 (CLR) 之上。
* **2002年**：ASP.NET 1.0 正式发布，引入 Web Forms 模式，试图让 Web 开发像桌面开发一样拖拽控件。
* **2008年**：受 Ruby on Rails 影响，微软推出 **ASP.NET MVC**，解决了 Web Forms 生成代码臃肿、难以测试的问题。
* **2012年**：推出 **ASP.NET Web API**，专门用于构建满足移动端和单页应用 (SPA) 需求的 RESTful 服务。

#### ASP.NET Core 转型与演进 (2016 - 至今)
为了解决跨平台和模块化问题，架构再次推倒重建，摆脱了对 Windows 和 IIS 的强耦合。
* **2016年**：**ASP.NET Core 1.0** 发布。这是一个完全开源、跨平台的重新实现。它统一了 MVC 和 Web API 的编程模型，不再依赖庞大的 System.Web.dll。
* **2019年**：**ASP.NET Core 3.0** 发布。这是一个分水岭，框架停止支持 Windows-only 的 .NET Framework，强制迁移至跨平台的 .NET Core 运行时。
* **2020年及以后**：随着 .NET 5.0 的统一命名，**Blazor** 成为核心组件，实现了利用 WebAssembly 在浏览器端运行 C#。框架进入稳定迭代期，支持 side-by-side 多版本并存，彻底解决了旧版 ASP.NET 全局版本冲突的问题。

### 基本用法


## Entity Framework Core
- [wiki](https://en.wikipedia.org/wiki/Entity_Framework)

### 历史
与ASP.NET Core相同,叫这么奇怪的名字也是有来头的:
1. Entity Framework: 由微软在2008年发布,依靠.NET framework
2. Entity Framework Core: 重写了Entity Framework底层代码,由微软在2016年发布,强调这是一个全新的代码库.

说真的,微软的命名品味真的很糟糕.
#### 诞生与初步演进 (2008 - 2010)
解决“对象-关系阻抗失配”的早期尝试。
* **2008年 (EFv1)**：随 .NET 3.5 SP1 发布。作为 ADO.NET 的一部分，初期因功能限制遭到开发者群体的大规模抵制。
* **2010年 (EFv4)**：随 .NET 4.0 发布。修复了首版的大量缺陷，确立了框架的可扩展性。

#### 功能成熟与开源期 (2011 - 2013)
引入核心开发范式并转向社区化。
* **2011年 (EF 4.1)**：引入 **Code First** 支持，开发者可以先写 C# 类再生成数据库。随后更新增加了对复杂类型的支持。
* **2012年 (EF 4.3 / 5.0)**：引入**数据库迁移 (Migrations)** 机制；EF 5.0 开始针对 .NET 4.5 运行时进行优化。
* **2013年 (EF 6.0)**：项目正式**开源** (Apache License v2)，标志着经典版本进入全盛期，具备了成熟的 Code First 改进。

#### 重构与跨平台转型 (2016 - 2019)
为配合 .NET 全面跨平台，框架经历底层完全重写。
* **2016年 (EF Core 1.0)**：原名 EF7，后更名以强调其为全新的代码库。支持 Windows、Linux 和 macOS，并开始支持非关系型数据库。
* **2017年 (EF Core 2.0)**：与 ASP.NET Core 2.0 同步发布，增强了查询效率和模型映射能力。
* **2019年 (EF Core 3.0/3.1)**：实现统一编程模型。3.1 成为长期支持 (LTS) 版本，标志着 Core 系列进入生产环境的大规模应用阶段。

#### 现代化与功能对齐 (2020 - 2023)
性能极致优化，并引入现代数据库特性。
* **2020年 (EF Core 5.0)**：移除对旧版 .NET Framework 的支持，专注于现代 .NET 运行时的性能提升。
* **2021年 (EF Core 6.0)**：目前的长期支持标准版，大幅优化了查询生成速度。
* **2022年 (EF Core 7.0)**：引入 **JSON 列映射** 和 **批量更新 (Bulk Updates)** 等开发者急需的物理层操作功能。
* **2023年 (EF Core 8.0)**：引入 **复杂类型 (Complex Types)** 和原始集合支持，进一步增强了领域建模的灵活性。

### 基本用法

## ADO.NET的历史
ADO.NET是EF Core 或 Dapper的底层通信协议,现在做项目不太需要直接用了,但是很有必要了解
### 1. 概念起源与 OLE DB 时代 (1990s)
在 .NET 诞生之前，数据访问依赖于 **DAO**、**RDO** 和后来的 **ADO (ActiveX Data Objects)**。
* **物理局限**：这些技术基于 COM（组件对象模型），且主要是为**保持连接**的状态设计的。在互联网兴起后，这种长时间占用数据库连接的模型无法应对高并发需求。

### 2. 核心架构确立 (2002 - 2005)
随着 .NET Framework 1.0 的发布，ADO.NET 正式取代 ADO，底层逻辑发生了根本性转变。
* **2002年 (ADO.NET 1.0)**：随 .NET Framework 1.0 发布。引入了**断开式数据访问**核心类：`DataSet` 和 `DataTable`。开发者通过 `DataAdapter` 将数据一次性填充到内存，随后关闭物理连接。
* **2003年 (ADO.NET 1.1)**：随 .NET 1.1 发布。增加了对 Oracle 数据库的官方支持库（System.Data.OracleClient），并强化了数据安全性。

### 3. 生产力与性能飞跃 (2005 - 2008)
* **2005年 (ADO.NET 2.0)**：随 .NET 2.0 及 SQL Server 2005 发布。这是历史上最重要的更新之一：
    * 引入了 **DbProviderFactories**，允许编写数据库无关的代码。
    * 支持 **批量复制 (SqlBulkCopy)**，极大提升了海量数据导入速度。
    * 引入异步执行指令支持，解决了长耗时查询阻塞线程的问题。

### 4. 抽象层的崛起 (2008 - 2012)
* **2008年 (ADO.NET 3.5)**：引入了 **LINQ to SQL** 和 **Entity Framework (EF)**。
    * **本质转变**：ADO.NET 开始从“开发者直接操作的工具”转变为“上层 ORM 框架的引擎”。开发者开始减少直接编写 SQL，转而使用 LINQ 语法。
* **2010 - 2012年 (ADO.NET 4.0/4.5)**：增加了对 SQL Server 新特性（如地理空间数据类型、列存储索引）的支持，并优化了连接池（Connection Pooling）的性能。

### 5. 跨平台与微服务时代 (2016 - 至今)
* **2016年 (System.Data.Common)**：随着 .NET Core 1.0 发布，ADO.NET 的核心接口被重构为跨平台的 `System.Data.Common`。
    * **物理变化**：不再依赖 Windows 系统的 MDAC/WDAC 组件，可以在 Linux 和 macOS 上原生运行。
* **2019年至今 (Microsoft.Data.SqlClient)**：
    * **重大决策**：微软将 SQL Server 的驱动程序从 .NET 运行时中剥离，独立为 **Microsoft.Data.SqlClient** 包。
    * **现状**：ADO.NET 保持极致的稳定与性能。尽管大多数人使用 EF Core 或 Dapper，但这些框架底层始终在调用 ADO.NET 的 `SqlConnection` 和 `DbCommand` 进行最纯粹的字节流通信。
