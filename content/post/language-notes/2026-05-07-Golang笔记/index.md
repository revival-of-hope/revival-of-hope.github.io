---
title: "Golang笔记"
date: 2026-05-23T19:09:06+08:00
description: 
image: 
math: 
---

# Go基础
- 鉴于Go是从多个前辈语言中吸收了各种精华后诞生的,学习Go之前最好有一门甚至两门主流后端语言的基础.
## Go的历史
- [wiki](https://en.wikipedia.org/wiki/Go_(programming_language))

>Go语言由Google的Robert Griesemer、Rob Pike和Ken Thompson于2007年开始设计，其初衷是因不满C++的复杂性，旨在解决多核、网络化机器及大规模代码库带来的开发效率、静态类型安全与并发性能问题；该语言于2009年11月正式开源发布，并在2012年3月推出1.0稳定版本，凭借结合了C语言的运行效率与Python般的易读性，以及内置的CSP并发模型和围绕软件工程流程（如包管理、构建、测试）的生态优化，现已在Google及全球开源项目与生产环境中得到广泛应用。

## w3schools
- [w3schools](https://www.w3schools.com/go/go_getting_started.php)
  - 很多地方都没有展开讲,但了解Go的基础语法已经足够了

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
3. Go中不需要使用`;`来划分语句,直接换行即可
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
Go中的数组有两种声明方式.
1. 使用var关键字:
```go
var array_name = [length]datatype{values} // here length is defined

// or

var array_name = [...]datatype{values} // here length is inferred
```
2. 使用`:=`符号:
```go
array_name := [length]datatype {values} // here length is defined
q := [...]int{1, 2, 3}

```
>数组的长度是固定的,不可改变,不同长度的数组是不同的类型,要使用长度动态变化的数组,就要用到切片(slice)

 
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

### 切片
>切片与数组的最大区别就是**没有固定的长度**

声明时,切片与数组的区别就在于没有指定长度:
```go
// 局部变量声明
slice_name := []datatype{values}

// 完整声明
var slice_nums = []int{1, 2, 3}
```

slice支持两种方法:
1. len: 返回切片的实际长度(实际元素个数)
2. cap: 返回切片的总容量(可容纳的元素个数)

之所以slice被叫做切片,是因为它可以用来从数组中截取一段数据:
```go
package main
import ("fmt")

func main() {
  arr1 := [6]int{10, 11, 12, 13, 14,15}
  myslice := arr1[2:4]

  fmt.Printf("myslice = %v\n", myslice)
  fmt.Printf("length = %d\n", len(myslice))
  fmt.Printf("capacity = %d\n", cap(myslice))
}

// myslice = [12 13]
// length = 2
// capacity = 4
```
- 值得注意的是,slice在从数组切片时,会将容量设置为起始下标到数组末端的总长度,无论将结束下标设置在哪里都是这样,这也是为什么length为2,capacity却是4的原因


### 条件语句
- Go和python一样,不需要在条件判断部分加上括号,所以为了语义清晰,条件判断中只能是bool表达式(结果是bool),不能出现算术式子
```go
package main
import ("fmt")

func main() {
  time := 22
  if time < 10 {
    fmt.Println("Good morning.")
  } else if time < 20 {
    fmt.Println("Good day.")
  } else {
    fmt.Println("Good evening.")
  }
}
```

for循环:
```go
package main
import ("fmt")

func main() {
  for i:=0; i < 5; i++ {
    if i == 3 {
      break
    }
   fmt.Println(i)
  }
}
```
range循环的基本框架:
```go
for index, value := range array|slice|map {
   // code to be executed for each iteration
}
```
基本例子:
```go
package main
import ("fmt")

func main() {
  fruits := [3]string{"apple", "orange", "banana"}
  for idx, val := range fruits {
     fmt.Printf("%v\t%v\n", idx, val)
  }
}
```

不用到索引或者值:
```go
package main
import ("fmt")

func main() {
  fruits := [3]string{"apple", "orange", "banana"}
  for _, val := range fruits {
     fmt.Printf("%v\n", val)
  }
  for idx, _ := range fruits {
     fmt.Printf("%v\n", idx)
  }
}
```

### 函数
如果不返回任何值,基本框架是这样的:
```go
func FunctionName(param1 type, param2 type, param3 type) {
  // code to be executed
}
```

例子:
```go
package main
import ("fmt")

func familyName(fname string, age int) {
  fmt.Println("Hello", age, "year old", fname, "Refsnes")
}

func main() {
  familyName("Liam", 3)
  familyName("Jenny", 14)
  familyName("Anja", 30)
}
```

而如果要返回值的话,返回类型写在函数声明的最后:
```go
func FunctionName(param1 type, param2 type) type {
  // code to be executed
  return output
}
```
go还支持提前指定返回值:
```go
package main
import ("fmt")

func myFunction(x int, y int) (result int) {
  result = x + y
  return result
  // 也可以写成下面这样
  // result = x + y
  // return 
}

func main() {
  fmt.Println(myFunction(1, 2))
}
```
因此,go可以实现一次返回多个值:
```go
package main
import ("fmt")

func myFunction(x int, y string) (result int, txt1 string) {
  result = x + x
  txt1 = y + " World!"
  return
}

func main() {
  a, b := myFunction(5, "Hello")
  fmt.Println(a, b)
}
```
### 结构体
Go最令人惊讶的地方就是彻底抛弃了class,转而使用struct来组织对象:
```go
type Person struct {
  name string
  age int
  job string
  salary int
}
```
使用时仍然使用对象访问符`.`:
```go
package main
import ("fmt")

type Person struct {
  name string
  age int
  job string
  salary int
}

func main() {
  var pers1 Person
  var pers2 Person

  // Pers1 specification
  pers1.name = "Hege"
  pers1.age = 45
  pers1.job = "Teacher"
  pers1.salary = 6000

  // Pers2 specification
  pers2.name = "Cecilie"
  pers2.age = 24
  pers2.job = "Marketing"
  pers2.salary = 4500

  // Access and print Pers1 info
  fmt.Println("Name: ", pers1.name)
  fmt.Println("Age: ", pers1.age)
  fmt.Println("Job: ", pers1.job)
  fmt.Println("Salary: ", pers1.salary)

  // Access and print Pers2 info
  fmt.Println("Name: ", pers2.name)
  fmt.Println("Age: ", pers2.age)
  fmt.Println("Job: ", pers2.job)
  fmt.Println("Salary: ", pers2.salary)
}
```
### map

Go提供了map来存储字典,有两种声明方法:
```go
var a = map[KeyType]ValueType{key1:value1, key2:value2,...}
b := map[KeyType]ValueType{key1:value1, key2:value2,...}
```
还可以使用`make`创建map:
```go
package main
import ("fmt")

func main() {
  var a = make(map[string]string) // The map is empty now
  a["brand"] = "Ford"
  a["model"] = "Mustang"
  a["year"] = "1964"

  b := make(map[string]int)
  b["Oslo"] = 1
  b["Bergen"] = 2
  b["Trondheim"] = 3
  b["Stavanger"] = 4

  fmt.Printf("a\t%v\n", a)
  fmt.Printf("b\t%v\n", b)
}
```

## A Tour of Go
- [官网](https://go.dev/tour)
  - 意外发现官网有这个教程,在有了上面的简单基础后看起来出奇的舒服.

### 基本语法
1. Go中没有while,所以我们可以把for写成while的形式,属于是一种语法糖,不会报错:
```go
package main

import "fmt"

func main() {
	sum := 1
	for sum < 1000 {
		sum += sum
	}
	fmt.Println(sum)
}

```
2. Go的if语句中还允许变量声明和多个短句,但我认为没必要,否则维护起来会很难受:

```go
package main

import (
	"fmt"
	"math"
)

func pow(x, n, lim float64) float64 {
	if v := math.Pow(x, n); v < lim {
		return v
	}
	return lim
}

func main() {
	fmt.Println(
		pow(3, 2, 10),
		pow(3, 3, 20),
	)
}
```
3. defer关键字用于把一个函数调用推迟到当前函数即将返回时再执行:

```go
func main() {
    fmt.Println("A")

    defer fmt.Println("B")

    fmt.Println("C")
}
// A
// C
// B
```

defer实质上是通过栈来实现的,如果我们重叠多个defer就能看出效果:
```go
package main

import "fmt"

func main() {
	fmt.Println("counting")

	for i := 0; i < 10; i++ {
		defer fmt.Println(i)
	}

	fmt.Println("done")
}
​
// counting
// done
// 9
// 8
// 7
// 6
// 5
// 4
// 3
// 2
// 1
// 0
```

4. 可以使用const/var关键字一次声明一大堆变量:
```go
package main

import "fmt"

type Vertex struct {
	X, Y int
}

var (
	v1 = Vertex{1, 2}  // has type Vertex
	v2 = Vertex{X: 1}  // Y:0 is implicit
	v3 = Vertex{}      // X:0 and Y:0
	p  = &Vertex{1, 2} // has type *Vertex
)

func main() {
	fmt.Println(v1, p, v2, v3)
}

```
编译器会根据初始值推断类型,所以最后一个p被推断成了指针变量.

5. 切片是对数组的引用,更改切片会对数组同时生效:

```go
package main

import "fmt"

func main() {
	names := [4]string{
		"John",
		"Paul",
		"George",
		"Ringo",
	}
	fmt.Println(names)

	a := names[0:2]
	b := names[1:3]
	fmt.Println(a, b)

	b[0] = "XXX"
	fmt.Println(a, b)
	fmt.Println(names)
}
// [John Paul George Ringo]
// [John Paul] [Paul George]
// [John XXX] [XXX George]
// [John XXX George Ringo]
```

6. Go中的切片还支持将结构体内嵌在其中的写法:
```go
package main

import "fmt"

func main() {
	q := []int{2, 3, 5, 7, 11, 13}
	fmt.Println(q)

	r := []bool{true, false, true, true, false, true}
	fmt.Println(r)

	s := []struct {
		i int
		b bool
	}{
		{2, true},
		{3, false},
		{5, true},
		{7, true},
		{11, false},
		{13, true},
	}
	fmt.Println(s)
}
```
7. 切片支持多种多样的省略写法:
```go
For the array
var a [10]int
these slice expressions are equivalent:

a[0:10]
a[:10]
a[0:]
a[:]
```
>The default is zero for the low bound and the length of the underlying slice or array for the high bound.

8. 切片的空值为nil:
```go
package main

import "fmt"

func main() {
	var s []int
	fmt.Println(s, len(s), cap(s))
	if s == nil {
		fmt.Println("nil!")
	}
}
// [] 0 0
// nil!
```
### 高级语法
#### map
使用make来初始化map:
```go
package main

import "fmt"

type Vertex struct {
	Lat, Long float64
}

var m map[string]Vertex

func main() {
	m = make(map[string]Vertex)
	m["Bell Labs"] = Vertex{
		40.68433, -74.39967,
	}
	fmt.Println(m["Bell Labs"])
}
```
还可以带上初始值进行初始化,这比较类似于python中dict的写法:
```go
package main

import "fmt"

type Vertex struct {
	Lat, Long float64
}

var m = map[string]Vertex{
	"Bell Labs": Vertex{
		40.68433, -74.39967,
	},
	"Google": Vertex{
		37.42202, -122.08408,
	},
}

func main() {
	fmt.Println(m)
}
```
当然,还可以简写,省略掉值的类型声明:
```go
package main

import "fmt"

type Vertex struct {
	Lat, Long float64
}

var m = map[string]Vertex{
	"Bell Labs": {40.68433, -74.39967},
	"Google":    {37.42202, -122.08408},
}

func main() {
	fmt.Println(m)
}
```
#### 函数
Go非常有意思的地方就是可以像Javascript一样将函数作为参数:
```go
package main

import (
	"fmt"
	"math"
)

func compute(fn func(float64, float64) float64) float64 {
	return fn(3, 4)
}

func main() {
	hypot := func(x, y float64) float64 {
		return math.Sqrt(x*x + y*y)
	}
	fmt.Println(hypot(5, 12))

	fmt.Println(compute(hypot))
	fmt.Println(compute(math.Pow))
}

```
更有意思的地方在于Go可以将函数作为返回值,这被称为**函数闭包**,这一写法与Javascript中的匿名函数非常相像:
```go
package main

import "fmt"

func adder() func(int) int {
	sum := 0
	return func(x int) int {
		sum += x
		return sum
	}
}

func main() {
	pos, neg := adder(), adder()
	for i := 0; i < 10; i++ {
		fmt.Println(
			pos(i),
			neg(-2*i),
		)
	}
}
```

- adder相当于一个中转站,用于传递参数x.
- 尽管sum是一个局部变量,但只要pos和neg这两个局部函数变量还在,由于他俩引用了sum,所以sum一直都不会被回收,直到main函数执行完毕,sum的值都会一直保留.
#### 方法
鉴于Go没有class,只能用结构体来存储方法,写法上也非常奇特,需要在函数名字前加上结构体的参数说明,既不写在最开头,也不写在参数里,调用方法则使用成员运算符`.`:
```go
package main

import (
	"fmt"
	"math"
)

type Vertex struct {
	X, Y float64
}

func (v Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func main() {
	v := Vertex{3, 4}
	fmt.Println(v.Abs())
}
```
- 这种写法比较清晰的说明了方法与属性不是存放在一起的,而是以类似指针的方式指向结构体.

如果我们把结构体参数放入参数变量中,就变成了普通的函数:
```go
package main

import (
	"fmt"
	"math"
)

type Vertex struct {
	X, Y float64
}

func Abs(v Vertex) float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func main() {
	v := Vertex{3, 4}
	fmt.Println(Abs(v))
}
```

不过,即便是使用`type`关键字自定义的类型,也可以有自己的方法:

```go
package main

import (
	"fmt"
	"math"
)

type MyFloat float64

func (f MyFloat) Abs() float64 {
	if f < 0 {
		return float64(-f)
	}
	return float64(f)
}

func main() {
	f := MyFloat(-math.Sqrt2)
	fmt.Println(f.Abs())
}
```
##### 指针方法
Go去掉了C++中的`->`运算符,即使是指针变量也同样使用`.`运算符来访问成员属性/方法:
```go
package main

import (
	"fmt"
	"math"
)

type Vertex struct {
	X, Y float64
}

func (v Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func (v *Vertex) Scale(f float64) {
	v.X = v.X * f
	v.Y = v.Y * f
}

func main() {
	v := Vertex{3, 4}
	v.Scale(10)
	fmt.Println(v.Abs())
}
```
值得注意的是,方法既可以传入结构体指针也可以传入结构体变量,Go编译器会自动进行转换:
```go
package main

import (
	"fmt"
	"math"
)

type Vertex struct {
	X, Y float64
}

func (v Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func AbsFunc(v Vertex) float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

func main() {
	v := Vertex{3, 4}
	fmt.Println(v.Abs())
	fmt.Println(AbsFunc(v))

	p := &Vertex{4, 3}
	fmt.Println(p.Abs())
	fmt.Println(AbsFunc(*p))
}
```
- 这让代码报错的可能性大幅度下降了
#### 接口
Go中的接口是隐式完成的,不需要类似Java中的`implements`关键字,一个类型只要实现了接口要求的方法,就实现了这个接口:
```go
package main

import "fmt"

type I interface {
	M()
}

type T struct {
	S string
}

// This method means type T implements the interface I,
// but we don't need to explicitly declare that it does so.
func (t T) M() {
	fmt.Println(t.S)
}

func main() {
	var i I = T{"hello"}
	i.M()
}
```
而被实现的接口也可以被后续的实现直接覆盖,这同样与Java不一样:
```go
package main

import (
	"fmt"
	"math"
)

type I interface {
	M()
}

type T struct {
	S string
}

func (t *T) M() {
	fmt.Println(t.S)
}

type F float64

func (f F) M() {
	fmt.Println(f)
}

func main() {
	var i I

	i = &T{"Hello"}
	describe(i)
	i.M()

	i = F(math.Pi)
	describe(i)
	i.M()
}

func describe(i I) {
	fmt.Printf("(%v, %T)\n", i, i)
}
```

如果接口内留空,那么就可以用来存储属性,这个属性同样可以被重载,从而在Go真正提出泛型前实现非正式的泛型:
```go
package main

import "fmt"

func do(i interface{}) {
	switch v := i.(type) {
	case int:
		fmt.Printf("Twice %v is %v\n", v, v*2)
	case string:
		fmt.Printf("%q is %v bytes long\n", v, len(v))
	default:
		fmt.Printf("I don't know about type %T!\n", v)
	}
}

func main() {
	do(21)
	do("hello")
	do(true)
}

```
#### 异常
Go中的很多函数都会在程序出错时返回异常,但这需要我们显式用一个多出来的err字段接收,而非其他语言通常使用的隐式接收.
```go
i, err := strconv.Atoi("42")
if err != nil {
    fmt.Printf("couldn't convert number: %v\n", err)
    return
}
fmt.Println("Converted integer:", i)
```
#### 泛型
Go加入泛型经过了长达十年的考量,所以实现得很不错.

首先,Go支持对泛型进行约束,也就是限制可以在该泛型函数中使用的类型,常用的约束只有两个:
1. any: 可以是任何类型
2. comparable: 该类型需要能够用`==`或`!=`操作,也就是可进行比较.

```go
package main

import "fmt"

type List[T any] struct {
	next *List[T]
	val  T
}

// Index returns the index of x in s, or -1 if not found.
func Index[T comparable](s []T, x T) int {
	for i, v := range s {
		// v and x are type T, which has the comparable
		// constraint, so we can use == here.
		if v == x {
			return i
		}
	}
	return -1
}

func main() {
	// Index works on a slice of ints
	si := []int{10, 20, 15, -10}
	fmt.Println(Index(si, 15))

	// Index also works on a slice of strings
	ss := []string{"foo", "bar", "baz"}
	fmt.Println(Index(ss, "hello"))
}
```
- 写法上也扔掉了Cpp中的`<>`符号,转而使用`[]`,体现了Go尽量减少内置符号种类的思想
- 而且,泛型写在了函数/类型声明之后,这实际上让代码变得更清晰了

## the way to go
- [中文版仓库](https://github.com/unknwon/the-way-to-go_ZH_CN)
### 语法要点
1. const和var在声明时如果有初始值就可以忽略类型,但都不可以隐式更改类型:

```go
const Pi = 3.14159
var s = 114514
```
### 总结
后面实在是找不到什么值得做笔记的地方了...总的来说的话,只看前两个教程就足够了,这本书过于宽泛,而且讲的不是很好.


## 总结
Go是一个非常有特点的语言,一方面,他继承了多门语言的精华,综合了前辈语言的特性,使用严格的语法规则来避免绝大部分的误区;另一方面,他非常的灵活,提供了各种各样的语法糖和简写版本,为程序员提供不同的实现方法.