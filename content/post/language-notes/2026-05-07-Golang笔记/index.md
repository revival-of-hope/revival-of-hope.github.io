---
title: "Golang笔记"
date: 2026-05-23T19:09:06+08:00
description: 
image: 
math: 
draft: true
---

# Go基础
- 鉴于Go是从多个前辈语言中吸收了各种精华后诞生的,学习Go之前最好有一门甚至两门主流后端语言的基础.
## Go的历史
- [wiki](https://en.wikipedia.org/wiki/Go_(programming_language))

>Go语言由Google的Robert Griesemer、Rob Pike和Ken Thompson于2007年开始设计，其初衷是因不满C++的复杂性，旨在解决多核、网络化机器及大规模代码库带来的开发效率、静态类型安全与并发性能问题；该语言于2009年11月正式开源发布，并在2012年3月推出1.0稳定版本，凭借结合了C语言的运行效率与Python般的易读性，以及内置的CSP并发模型和围绕软件工程流程（如包管理、构建、测试）的生态优化，现已在Google及全球开源项目与生产环境中得到广泛应用。

## 基础语法
- [w3schools](https://www.w3schools.com/go/go_getting_started.php)

### 前置概念
1. Go属于C系函数,故也通过main函数启动:
```go
package main
import ("fmt")

func main() {
  fmt.Println("Hello World!")
}
```
2. Go中的所有文件都属于某个包中,需要使用package 关键字声明,并写在程序的第一行
   1. `package main`是Go程序的入口,不可重复定义,必须且只能包含一个无参数,无返回值的main函数

### 变量
#### 变量类型
Go有三种数据类型:
1. bool类: 仅接受true或false,不允许与整型进行隐式或者显式的转换,终于不会发生那种**将算术表达式放在条件判断**里的那种又难维护又难看懂的代码了.
2. Numeric类: 常用的有int,float32,float64等具体的数据类型
3. string类: 字符串类型,没什么好说的


#### 变量声明
Go中有两种方式声明一个变量:
1. 使用var关键字:
```go
var variablename type = value
```
通过将变量声明放在最前面,将变量类型放在变量名后面,代码变得更好维护了.

2. 使用`:=`符号:
```go
variablename := value
```
1. 编译器会根据值自动推导该变量的类型
2. 该声明方式只允许出现在函数中,表明这是一个局部变量.

根据下述代码可以看到各种数据类型的初始值:
```go
package main
import ("fmt")

func main() {
  var a string
  var b int
  var c bool

  fmt.Println(a)
  fmt.Println(b)
  fmt.Println(c)
}

// 
// 0
// false
```

我们还可以在一行声明多个变量,允许不同类型的值分别赋值:
```go
package main
import ("fmt")

func main() {
  var a, b = 6, "Hello"
  // 由于类型不同,所以不用写类型
  c, d := 7, "World!"

  fmt.Println(a)
  fmt.Println(b)
  fmt.Println(c)
  fmt.Println(d)
}
```

常量的声明如下:
```go
const CONSTNAME type = value
```

### IO
fmt库下有三种输出函数:
1. Print(): 不换行
2. Println(): 换行
3. Printf(): 可插入变量

```go
package main
import ("fmt")

func main() {
  var i string = "Hello"
  var j int = 15

  fmt.Printf("i has value: %v and type: %T\n", i, i)
  fmt.Printf("j has value: %v and type: %T", j, j)
}
```
具体的可插入符号如下:

| Verb | Description                            |
| ---- | -------------------------------------- |
| %v   | Prints the value in the default format |
| %#v  | Prints the value in Go-syntax format   |
| %T   | Prints the type of the value           |
| %%   | Prints the % sign                      |

- 用法还有很多,但再深入下去也没必要了

### 数组
Go中的数组也有两种声明方式.
1. 使用var关键字:
```go
var array_name = [length]datatype{values} // here length is defined

// or

var array_name = [...]datatype{values} // here length is inferred
```
2. 使用`:=`符号:
```go
array_name := [length]datatype{values} // here length is defined

// or

array_name := [...]datatype{values} // here length is inferred
```

**示例代码**
```go
package main
import ("fmt")

func main() {
  arr1 := [5]int{} //not initialized
  arr2 := [5]int{1,2} //partially initialized
  arr3 := [5]int{1,2,3,4,5} //fully initialized

  fmt.Println(arr1)
  fmt.Println(arr2)
  fmt.Println(arr3)
}

// [0 0 0 0 0]
// [1 2 0 0 0]
// [1 2 3 4 5]

```
