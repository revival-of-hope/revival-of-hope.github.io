---
title: 从零开始的cpp与算法
tags:
  - 算法
date: 2026-04-23 08:00:00
image: 45243652_p0-楽園の素敵な巫女.webp
categories:
  - 动态更新
---

# cpp学习
学习cpp的难点有二:
1. 特性多
2. 系统化资料少,垃圾资料多

正是因为特性多,所以系统化讲述cpp特性的资料特别少,就算有也都讲的不深.需要到处搜集二手/三手信息,从而导致大多数人对于cpp的理解都是破碎不堪的.

接下来我会尽量通过[cpp官网](https://cppreference.com/)的文档来学习.
## cpp历史
>学习一门语言之前,我们必须要去了解它的历史,如果你连它的重要性都不知道的话,那又为什么要去学呢
- [wiki](https://en.wikipedia.org/wiki/C%2B%2B)

### 1. 诞生背景与“带类的 C”（1979 - 1982）
Bjarne Stroustrup 在贝尔实验室工作期间，因分析 UNIX 内核需要，试图结合 **Simula** 的抽象能力与 **C** 的高效性能。
* **1979年**：开始研发 **“C with Classes”**（C++ 的前身）。
* **核心特性**：引入类（Classes）、继承（Derived Classes）、强类型检查、内联函数（Inlining）和默认参数。

### 2. C++ 奠基时代（1983 - 1991）
* **1983年**：正式更名为 **C++**（利用 C 语言的自增运算符 `++`，寓意 C 的进化）。
* **1984年**：实现首个 **流输入/输出库（Stream I/O）**。
* **1985年**：
    * 发布经典著作 **《The C++ Programming Language》** 第一版。
    * 首个商业化 C++ 编译器正式面世。
* **1989年 (C++ 2.0)**：引入多重继承、抽象类、静态成员函数、`const` 成员函数以及 `protected` 访问权限。
* **1990年**：发布《The Annotated C++ Reference Manual》，为后续标准化工作奠定逻辑框架。

### 3. 标准化与工业成熟期（1998 - 2003）
* **1998年 (C++98)**：第一个国际标准 ISO/IEC 14882:1998 发布。
    * **里程碑特性**：**模板（Templates）**、异常处理、命名空间（Namespaces）、布尔类型、STL（标准模板库）正式入标。
* **2003年 (C++03)**：一个主要针对 C++98 的技术修正版本，修复了大量编译器实现层面的细节问题，稳定性提升。

### 4. 现代 C++ 复兴（2011 - 2020）
在经历了长达 8 年的停滞后，C++ 进入了高频迭代周期：
* **2011年 (C++11)**：**具有划时代意义的“新 C++”**。
    * **核心特性**：自动类型推导（`auto`）、Lambda 表达式、右值引用（Rvalue references）与移动语义、智能指针、基于范围的 `for` 循环。
* **2014年 (C++14)**：对 C++11 的微调与完善，增强了泛型 Lambda 和 `constexpr` 的能力。
* **2017年 (C++17)**：引入结构化绑定、`std::optional`、`std::variant`、文件系统库（Filesystem API）以及对并行的原生支持。
* **2020年 (C++20)**：被称为继 C++11 后最大的变革。
    * **四大支柱**：**概念（Concepts）**、**范围（Ranges）**、**协程（Coroutines）**、**模块（Modules）**。


## 环境配置
市面上有三大主流编译器,分别是微软的MSVC(Microsoft Visual C++),被集成在VS中;开源的GCC(GNU Compiler Collection),主要在Linux中使用;基于GCC和LLVM(通用编译链)的Clang,由苹果公司赞助,是macOS唯一官方支持的编译器,集成在Xcode中.
- 另外一个在Windows系统常用的MinGW编译器则是GCC的物理移植版
当然现在的电脑性能这么好,用哪个编译器都可以,下载后将对应的bin目录添加到环境变量即可.
## 基础语法
### 变量类型



# archive
### 关键字
#### const与volatile
- [参考](https://eel.is/c++draft/dcl.type.cv)
使用const修饰`int x`的时候,与单纯的写`int x`在内存区域上的表现没有什么不同,也就是说,const是一个编译时关键字,保证在运行时没有任何指令可以修改这块内存区域.

>Any attempt to modify a const object during its lifetime results in undefined behavior.

而**volatile**强制编译器取消对这个变量的运行期优化,要求每次对这个变量的操作都实际发生在内存,但现在基本很难看见这个关键字了.
#### static
- [来源](https://www.runoob.com/w3cnote/cpp-static-usage.html)

>我们知道在函数内部定义的变量，当程序执行到它的定义处时，编译器为它在栈上分配空间，函数在栈上分配的空间在此函数执行结束时会释放掉，这样就产生了一个问题: 如果想将函数中此变量的值保存至下一次调用时，如何实现？ 最容易想到的方法是定义为全局的变量，但定义一个全局变量有许多缺点，最明显的缺点是破坏了此变量的访问范围（使得在此函数中定义的变量，不仅仅只受此函数控制）。static 关键字则可以很好的解决这个问题。
>
>另外，在 C++ 中，需要一个数据对象为整个类而非某个对象服务,同时又力求不破坏类的封装性,即要求此成员隐藏在类的内部，对外不可见时，可将其定义为静态数据。

**TL;DR**:
（1）在修饰变量的时候，static 修饰的静态局部变量只执行初始化一次，而且延长了局部变量的生命周期，直到程序运行结束以后才释放。
（2）static 修饰全局变量的时候，这个全局变量只能在本文件中访问，不能在其它文件中访问，即便是 extern 外部声明也不可以。
（3）static 修饰一个函数，则这个函数的只能在本文件中调用，不能被其他文件调用。static 修饰的变量存放在全局数据区的静态变量区，包括全局静态变量和局部静态变量，都在全局数据区分配内存。初始化的时候自动初始化为 0。


#### static_cast与其他的类型转换
- [参考](https://www.cnblogs.com/wanghongyang/p/15054880.html)
- [StackOverflow上的解答](https://stackoverflow.com/questions/332030/when-should-static-cast-dynamic-cast-const-cast-and-reinterpret-cast-be-used)

当我们需要强制更改变量类型的时候,应该考虑到一点:
- 如果直接在内存对应地址增加或者减小它的占用空间大小,显然会导致各种各样的内存问题.
因此,类型转换一般是不更改内存的,而是在编译时告诉编译器这个变量的类型改变了,请你按照改变后的类型来处理这个变量.

>隐式类型转换是安全的，显式类型转换是有风险的，C语言之所以增加强制类型转换的语法，就是为了强调风险，让程序员意识到自己在做什么。
>
>但是，这种强调风险的方式还是比较粗放，粒度比较大，它并没有表明存在什么风险，风险程度如何。
>
>为了使潜在风险更加细化，使问题追溯更加方便，使书写格式更加规范，C++ 对类型转换进行了分类，并新增了四个关键字来予以支持，它们分别是：
| 关键字                 | 说明                                                                                                                          |
| :--------------------- | :---------------------------------------------------------------------------------------------------------------------------- |
| **`static_cast`**      | 用于良性转换，一般不会导致意外发生，风险很低。                                                                                |
| **`const_cast`**       | 用于 `const` 与非 `const`、`volatile` 与非 `volatile` 之间的转换。                                                            |
| **`reinterpret_cast`** | 高度危险的转换，这种转换仅仅是对二进制位的重新解释，不会借助已有的转换规则对数据进行调整，但是可以实现最灵活的 C++ 类型转换。 |
| **`dynamic_cast`**     | 用于多态和向下转型                                                                                                            |


#### constexpr

#### decltype



### 指针与引用
#### 指针实质
事实上,接触了差不多一年cpp,我还是没有彻底搞懂指针,教材上,网上讲的基本都是怎么用指针,简单的告诉你指针就是取地址,调用的时候就是解引用取得引用对象,但并没有告诉我,为什么这么写就能行.
试着阅读<< C++ Programming Language >>的第七章,里面是这么讲的:
>对于类型T来说,T*是`指向T的指针`的类型,换句话说,T*类型的变量能够存放T类型对象的地址.
>
>对指针的一个基本操作是解引用(dereferencing),即引用指针所指的对象,也被称为间接取值(indirection),解引用运算符为`*`.
比如:
```cpp
char c = 'a';
char* p = &c;
char c2 = *p;
```
但书上到这里就戛然而止了,相当于啥都没讲,并没有触及底层的设计理念.不过话说回来,指针是从c传下来的,不关cpp设计的事.🙂

那么,为什么要这样写呢,也就是说,为什么不能直接写`char p = &c;`来存储地址,然后再把这个解引用运算符用来根据地址p来找到原来的c变量呢?

思考一下,`char p = &c`只是定义了一个char变量而已,也就是规定死了为1字节长,这里由于没用unsigned char,故只能取到0-127的地址值,因为地址的绝对值显然不会为负值.

显然,与其用char,我们不如用`long long int`类型来存储高达8字节的地址值,从而保证能存取足够多的地址,也就是这样写:
```cpp
char c = 'a';
long long p =&c;
```

那么,取到地址之后我们又要怎么根据这个地址取到应该取的值呢?

>要知道,变量值是分布在一块连续内存上的,你并不知道这个地址的前后是什么,可能是程序的核心部分,也可能是上次运行后尚未清除的缓存垃圾.当然,我们可以根据p所引用的变量c的类型来判断要读取的连续字节数,比如在我们的例子中p对应的是`char c`,也就是说我们只需要在这个地址往后取一个字节,就可以找回这个变量c存储的值了.

可是,上述的论述中有一个问题,那就是p只是存储了c的地址而已,**它并不知道c的类型**!那么,显然我们需要一种标识来取代单纯的**long long p**声明,这个标识还需要能够表明我所引用地址对应变量的类型.
比如,为了满足上述的要求,它可以写成类似`long long char **mark**`的形式,但显然这太长了,也太丑了...

但我们又可以想到,既然指针需要使用long long类型来保证取到尽可能多的地址,那么`long long`这个部分就可以省略了,上述例子从而简化成了`char **mark**`,让编译器根据这个**mark**来了解这是一个需要用long long来存储的指针变量.

那么,问题就简化到了这个**mark**用什么符号来表示比较好.

非常可惜的是,c语言的设计者们并没有想过将解引用符号`*`和取指针符号**mark**分开来表示,而是直接把**mark**定为了`*`,从而导致了学习c语言的无穷痛苦...

所以,回到这一句:
```cpp
char* p = &c;
```
我们现在可以很清楚的知道, 这个p是一个long long大小的变量,存储了char类型变量c的地址,尽管美中不足的是,这个标记`*`偏偏和解引用的`*`是同一个符号!

#### void*,NULL与nullptr
`void*`是一个指向void类型的指针,由于不存在有一个void类型的变量,故这个指针自然没有任何指向对象,也就无法进行解引用去取对象,无法进行算术运算.在使用时必须显式地转换成某一特定类型的指针.
- 在实际生产中很少被用在上层设计中,多用于底层的资源调度

现在我们根据**__stddef_null.h**来看一看NULL
```cpp
#ifdef __cplusplus
#if !defined(__MINGW32__) && !defined(_MSC_VER)
#define NULL __null
#else
#define NULL 0
#endif
#else
#define NULL ((void*)0)
#endif
```
可以清楚的发现NULL事实上是一个宏,有时候是0,有时候是一个...,`(void*)0`,这是什么东西?
还是从一个简单代码起步好了,我们知道,有时候需要将一个高位类型比如int,塞入一个低位类型比如char中,由于直接塞进去的话编译器会警告可能会丢失值,所以我们可以这样写:
- 注意: static_cast我会在后面涉及,而且在C语言中我们只能这样强制转换.
```cpp
int s = 999999999;
char c = (char)s;
```
我们可以更进一步,加入指针试试:
```cpp
int* p = (int*)100;   // 把数字 100 强制转换成 int* 类型
// 现在 p 指向的“地址”是 100
// 这是一个非常危险的操作，实际程序几乎永远不应该这么写
```
你可能会很好奇,这怎么就取到地址100了呢,真正取地址100,应该写成以下形式:
```cpp
int* p = &100;
```
但事实上这段代码会报错,因为&无法作用于100这样一个纯右值(可以理解为临时值).
当然你会说: 就算这样,我也不能接受`(int*)100`怎么就直接简单的变成地址100了!
我们可以这样理解,`(int*)100`必须得指向一个东西,因为如果不指向某个东西的话,说明它是一个类似于`int* p`这样没有赋值的野指针,但是`(int*)100`并不是这样,它是一个指向int类型的"右值100",那么我不能随便让它指向某块区域,否则就会导致内存混乱,最好指向一个与它的内容"100"有关系的区域,那么在设计者的角度来看,自然是指向地址100比较好了,实际应用中的编译器也是这么处理的.(当然我的这段分析可能是错误的,甚至整个都错了,但是我们需要牢牢记住: `(int*)100`就是地址100!)


经过上面的一大段分析,那么`(void*)0`就比较好理解了:将int类型的0强制转换成指向void类型的地址0,而地址0由于受到保护,故不能被解引用和运算,从而将NULL变成一个受保护的空指针.

很显然,void*和NULL并不够直观和好用,所以c++11引入了nullptr这个关键字用来表示空指针,这里我没有给源码,是因为这个nullptr与int,double这些类型一样,是一个编译器硬编码的运行期对象,不存在用一个库来定义nullptr.
既然nullptr叫做空指针,那么自然无法给int,double这些普通类型变量赋值,而是只能给指针变量赋值:
```cpp
struct Node {
    int data;
    Node* left;
    Node* right;

    Node(int val)
        : data(val)
        , left(nullptr)
        , right(nullptr)
    {}
};
```
如果不赋与nullptr这个初始值,就会产生野指针,从而导致各种各样的内存问题.


#### 数组中的指针
当我们需要处理一个分组的数据比如{1,2,3,4,5}时,我们可以这样写:
```cpp
//{1,2,3,4,5}
int s =12345; //将s作为存储变量
int s1=s/10000;
int s2=s/1000%10;
int s3=s/100%10;
int s4=s/10%10;
int s5=s%10;
```
自然,当数据量过大时这么写就有点过分了,显然不应该用某一个普通的int型或者long long型变量来存数据,而是应该转换思路,用一块连续内存来存数据,从而保证能够容纳足够大的数据量.

因此可以引入一个新的符号,姑且称为x,我们希望这个x可以实现以下几个要求:
1. 初始值为这个存储变量s的首地址,对应的是存储对象列表的第一个元素
2. 根据存储对象的类型(这里是int)得到相邻元素之间的内存距离
3. 可以经过简单的数学运算获取任意一个元素的位置,这被称为**随机存取**

你有可能会想,怎么能有这么好的事可以一下子解决三个问题呢?

但根据前面的讨论,我们知道:指针可以用来映射到一块特定的内存上,也就是说我们可以将指针对准这个存储变量的首地址,并且可以简单的对指针进行加减操作,从而取到下一个元素的地址甚至是任意一个元素的地址!所以,问题解决了.

于是,我们应该可以这么写:
```cpp
int *s =mark(1,2,3,4,5);
```
很显然,这个mark应该能够做到以下事情:
1. 告诉编译器这是一个数据列表,而不是别的什么
2. 为*s提供这个数据列表的首地址

尽管我们可以设计成类似`$(1,2,3,4,5)`或者`#(1,2,3,4,5)`这种比较正常的标记方式,但遗憾的是设计者想起来还有`{}`这个大括号没用过,于是将`mark()`变成了`{}`.(另一个好处是,在早期一个字符的开销也很重要的时候,可以减少表达式所用的字符).

于是,我们或许可以这样写:
```cpp
int *s={1,2,3,4,5};

int s1 = *s;
int s2 = *(s+1);
int s3 = *(s+2);
int s4 = *(s+3);
int s5 = *(s+4);
```
但如果你试着去运行的话,这串代码一定会报错!因为设计者并没有让这个mark成功做到上述的两个事情,上述的一系列设想都是我们的**一厢情愿**.

相反,`{}`只是一个构造器,没有任何返回值,必须需要等号左边部分的配合才可以填入值,而不能单独存在.

如果你好奇为什么的话,我们可以这样想,当你写 {1,2,3,4,5} 时，这五个整数总得找个地方落脚:
- 如果存放在栈（Stack）上，那么当函数执行完毕，这块内存就会被回收。此时你的指针 s 将变成一个恐怖的野指针。
- 如果存放在静态区（Data Segment），那么这块内存就是只读的，你无法在运行时修改它。
- 如果存放在**堆（Heap）**上，谁来负责 delete 它？C++ 的设计哲学是“不为不使用的东西付费”，这种隐式的内存分配违背了确定性。

因此,在将指针指向这个数据列表之前,我们需要先为这个数据列表分配一个合适的地址.
换句话说,我们还需要引入一个新类型变量来存储这个数据列表的地址,因为现有的变量类型是无法存入列表的.

同时,我们应该让这个新类型能够规范数据列表内部的类型为单一的一种,因为如果这个列表内又有int,又有long long,在用指针访问元素时必然出现混乱.

我们不妨写成这样:
```cpp
int mark(t) = {1,2,3,4,5};
int *s = t;
```
这个mark()出色的完成了以下两个任务:
1. 通知编译器划出该数据列表的空间
2. 为*s提供这个数据列表的首地址

更加遗憾的是,设计者又想起来还有`[]`这个中括号没用过...于是整个代码变成了我们熟悉的样子:
```cpp
int t[] = {1,2,3,4,5};
int *s = t;

int s1 = *s;
int s2 = *(s+1);
int s3 = *(s+2);
int s4 = *(s+3);
int s5 = *(s+4);
```
当然,本着物尽其用的原则,`[]`空在那里显然不太好看,于是设计者动了点巧思,让它在初次定义的时候可以规定划定的空间大小,并且在定义之后,能作为解引用符号来访问特定元素:
```cpp
int t[5] = {1,2,3,4,5};

int s1 = t[0]; //t[0] 等价于 *(t+0)
int s2 = t[1];
int s3 = t[2];
int s4 = t[3];
int s5 = t[4];
```
尽管这个设计很精妙,但我的意见是,与其让一个符号承担多个责任,不如清楚的用不同符号区分责任,(我的意见自然是不重要的).

值得一提的是**数组退化**问题:
```cpp
// 虽然形参写成 int arr[]，但在编译器眼里它就是 int* arr
void process(int arr[]) {
    // 这里的 sizeof(arr) 返回的是指针的大小（通常是 8 字节），而不是数组的总大小
    std::cout << "函数内部 sizeof(arr): " << sizeof(arr) << " bytes" << std::endl;

    // 通过指针偏移修改内存，会直接影响原数组
    arr[0] = 99; 
}

int main() {
    int my_array[5] = {1, 2, 3, 4, 5};
    
    std::cout << "函数外部 sizeof(my_array): " << sizeof(my_array) << " bytes" << std::endl;
    
    // 传递数组名，触发退化：int[5] -> int*
    process(my_array);

    std::cout << "修改后的首元素: " << my_array[0] << std::endl;
    return 0;
}
```
当经过上述一系列讨论后,这个问题的答案就显然易见了,process()函数传入的是数组的首地址,那么就应该用指针`int *arr`来处理了,至于为什么形参可以写成`int arr[]`或者`int arr[5]`,那可以理解为设计者还想让这个`[]`继续发光发热,既可以在形参中表示这是一个数组的首地址,还可以填入这个数组的预想空间大小-尽管实际运行时是不起作用的.


>综上所述,本来我们可以通过各种各样的标识来区分`[]`一个符号干的不同活儿,但遗憾的是cpp已经被设计成了这个样子了,那么只好随它去了.

#### const指针
```cpp
void f(char* p){
    char s[]="Gorm";

    const char* pc = s; //指向常量的指针
    pc[3] = 'g'; //错误,pc指向常量
    pc = p; //OK

    char* const cp = s; //指向char的常量指针
    cp[3] = 'a'; //OK
    cp = p; //错误,cp是一个常量

    const char* const cpc = s; //指向常量的常量指针
    cpc[3] = 'a' //错误,cpc指向常量
    cpc = p; //错误,cpc是一个常量
}
```
我们可以根据这段代码得出以下结论:
1. 当指针指向的变量使用const修饰时,无论指向的变量是否是常量,通过指针访问这个变量时都不允许做任何修改;但是,指针可以更改它指向的变量,也就是更改存储的地址内容
2. 当指针被设定为常量时,其存储的地址内容不允许再被修改,也就是固定与初始化的变量绑定,但是可以通过指针修改绑定变量的内容
3. 当常量指针指向常量时,既不能修改绑定变量,又不可以修改被绑定的变量的内容,怎么用都很安全



#### 引用实质
由于指针过于复杂和难懂,我们希望找到另外一种简单的方式,解决跨越函数和文件更改变量值的问题,因此,我们引入了引用(`&`)这个概念.
当我们写出以下代码时:
```cpp
int a = 123;
int &b = a;
```
应该有一个疑问: 变量b是什么?

由于这里没有取地址符号,故b不是指针;它也不是一个新变量,因为当我们改变b的值的时候,a的值也会同步改变.

那么,我们可以这样想:既然这个变量既不是一个指针,也不是一个变量,那么他就只能是一个临时值,换句话说,b是一个只存在于编译器的变量,作为绑定变量的别名,不会被存入内存中.
- 尽管从底层来看的话,引用还是一个指针,因为你终归是要将这个别名指向原变量的


### struct,union,enum
#### struct
- struct是一个可以存放不同类型变量,甚至可以存放函数的数组,在内存中按照变量的声明顺序依次存储,按字节对齐

当结构体尚未完成声明时,我们可以直接使用这个结构体的指针,因为指针的内存空间是已知的,固定为8字节;但是你不能声明结构体本身,因为结构体的内存还是未知的.
```cpp
struct Link{
    Link* previous;
    Link* successor;
};

struct Failed_Link{
    Failed_Link s;
};
```


### class
#### 类的特性
#### 类中的关键字与运算符
#### 继承与多态


#### this指针
- [菜鸟教程](https://www.runoob.com/cplusplus/cpp-this-pointer.html)
- [官方文档](https://en.cppreference.com/w/cpp/language/this.html)

this指针是类具有的隐藏指针,指向当前对象的实例,可以被直接调用:
```cpp
#include <iostream>
 
class MyClass {
private:
    int value;
 
public:
    void setValue(int value) {
        this->value = value;
    }
 
    void printValue() {
        std::cout << "Value: " << this->value << std::endl;
    }
};
 
int main() {
    MyClass obj;
    obj.setValue(42);
    obj.printValue();
 
    return 0;
}
```

换句话说
对于搞不懂指针的小白来说,`this->value`的出现有点莫名其妙了,让我们换成正常的形式:`*this.value`,`*this`相当于取得了当前这个对象后,再通过成员运算符`.`访问私有变量value.
#### 一个完整的类的示例
```cpp
// class.cpp
// compile with: /EHsc
// Example of the class keyword
// Exhibits polymorphism/virtual functions.

#include <iostream>
#include <string>
using namespace std;

class dog
{
public:
   dog()
   {
      _legs = 4;
      _bark = true;
   }

   void setDogSize(string dogSize)
   {
      _dogSize = dogSize;
   }
   virtual void setEars(string type)      // virtual function
   {
      _earType = type;
   }

private:
   string _dogSize, _earType;
   int _legs;
   bool _bark;

};

class breed : public dog
{
public:
   breed( string color, string size)
   {
      _color = color;
      setDogSize(size);
   }

   string getColor()
   {
      return _color;
   }

   // virtual function redefined
   void setEars(string length, string type)
   {
      _earLength = length;
      _earType = type;
   }

protected:
   string _color, _earLength, _earType;
};

int main()
{
   dog mongrel;
   breed labrador("yellow", "large");
   mongrel.setEars("pointy");
   labrador.setEars("long", "floppy");
   cout << "Cody is a " << labrador.getColor() << " labrador" << endl;
}
```

### 宏替换与别名
```cpp
//别名,只用于类型替换
using NewType = OldType;
//示例
using ll =long long;
using vec = std::vector<int>;

//文本替换
#define NAME replacement

//示例

#define PI 3.1415926
#define MAX 100

/*
但也可以带入参数
*/
#define SQR(x) ((x)*(x))
#define LOOP(i,n) for(int i=0;i<n;i++)

//typedef -using的下位替代,基本没用
typedef OldType NewType;
//示例
typedef long long ll;
```
### io
#### 读入多行
`cin>>`遇到空格或换行符会停止输入,想要读取一整行需要使用`getline(cin,s1) 这样的格式
#### scanf和printf
```c
int age;
char name[20];

// 1. 缓冲区残留坑：读取字符/字符串前，若上方有残余换行符，需手动处理
printf("Enter age: ");
if (scanf("%d", &age) != 1) return 1; // 2. 返回值坑：必须检查返回值以确认物理输入成功

printf("Enter name: ");
// 3. 溢出与空格坑：使用 %s 无法读取空格且易越界。限制长度并注意数组名本身是地址
scanf("%19s", name); 

// 4. 格式化输出：printf 严格对应类型，%d 对应整型，%s 对应字符串
printf("Data: Name=%s, Age=%d\n", name, age);
```

## 进阶特性
### cpp的内存分配与执行过程
#### 误区剖析
- [来源](https://whatbeg.com/2019/04/16/cppmemory.html)
通常一个由 C/C++ 编译的程序占用的内存分为以下 5 个部分:

1) 栈区（stack）: 由编译器自动分配释放，存放函数的参数值，局部变量的值等。其操作方式类似于数据结构中的栈。
2) 堆区（heap）: 一般由程序员分配释放，若程序员不释放，程序结束时可能由OS回收。注意它与数据结构中的堆是两回事，分配方式倒是类似于链表。
3) 全局区（静态区）（static）: 全局变量和静态变量的存储是放在一块的，初始化的全局变量和静态变量在一块区域，未初始化的全局变量和未初始化的静态变量在相邻的另一块区域。程序结束后由系统释放。
   1) 全局区又可分为DATA段(全局初始化区):用来存放初始化的全局和静态变量,和BSS段(全局未初始化区):用来存放未初始化的全局和静态变量.在程序运行结束时这两类内存均会自动释放
4) 文字常量区: 常量字符串等只读数据放在这里的。程序结束后由系统释放。
5) 程序代码区: 存放函数体的二进制代码。

#### 真实内存分配
事实上,上面这类常见的说法把目标文件和可执行文件弄混了,要想说清楚的话,我们可以这么说:
cpp程序经过预处理后被编译器和汇编器处理得到二进制化的目标文件,目标文件里有三个常用区:
1. .text段: 存放函数体
2. .data段: 存放初始化了的静态变量和全局变量
3. .bss段: 存放未初始化的静态变量和全局变量,存储时不占用内存空间,执行时占用空间

目标文件再被链接器处理后得到可执行文件,可执行文件装载时再有栈区和堆区的函数调用.

- 说真的**很多面试官**都喜欢问上面那个错误的版本,可见他们的水平也不怎么样

### 左值引用和右值引用
- [参考1](https://blog.csdn.net/m0_59938453/article/details/125858335)
- [参考2](https://nettee.github.io/posts/2018/Understanding-lvalues-and-rvalues-in-C-and-C/)

上述的两个链接写的都非常好,我这里稍微总结一下:


### 智能指针
### 为什么类和结构体定义时结尾要加一个分号
- [问题讨论](https://www.zhihu.com/question/441151329)

一种看法是将结构体的定义看作是类似与`int a = 1;`这样的变量声明,自然要加分号,而class源自struct,自然也保留了分号.
- 不过java成功的去掉了这个烦人的分号,加一分.

## STL(Standard Template Library )
在vscode里右键对应的头文件或方法,选择查找定义,则可以找到对应的stl源代码.
### 通用
- .size()方法是STL里通用的求容器长度的方法
- `memset(a, 0, sizeof(a));`or`memset(a, -1, sizeof(a));`是好用的重置大法

#### iterator(迭代器)详解

#### memset()详解
```h
void* __cdecl memset(
    _Out_writes_bytes_all_(_Size) void*  _Dst,
    _In_                          int    _Val,
    _In_                          size_t _Size
    );
```
- __cdecl,_Out_writes_bytes_all_(_Size), _In_: 这三个都是Microsoft专用的修饰用宏,由于太过底层所以不用去关注
- `void*  _Dst`: 空指针,指向对象内存区
- `int    _Val`: 填充内容,实际上函数底层会将int强制转换为unsigned char,故只有低8位有效.而且,由于memset的内部机制是逐字节将这低8位填入目标内存区域,如果传入1,则会导致填入内容为(0x01010101),无法做到将填入对象置为1的效果,故只能传入(-1和0),从而一致归0或者一致归1.
- `size_t _Size`: 传入单位为字节,而非直觉上以为的元素个数,这也是为什么不能直接写`memset(a,-1,n)`的原因.
  - 正确的写法为`memset(a,-1,sizeof(a))`,sizeof是一个编译时运算符,用于获取对象占用的字节空间,并非是一个库函数.




#### sort()详解
**MSVC-algorithm部分源码**
```cpp

template <class _RanIt, class _Pr>
_CONSTEXPR20 void _Sort_unchecked(_RanIt _First, _RanIt _Last, _Iter_diff_t<_RanIt> _Ideal, _Pr _Pred) {
    // order [_First, _Last)
    for (;;) {
        if (_Last - _First <= _ISORT_MAX) { // small
            _STD _Insertion_sort_unchecked(_First, _Last, _Pred);
            return;
        }

        if (_Ideal <= 0) { // heap sort if too many divisions
            _STD _Make_heap_unchecked(_First, _Last, _Pred);
            _STD _Sort_heap_unchecked(_First, _Last, _Pred);
            return;
        }

        // divide and conquer by quicksort
        auto _Mid = _STD _Partition_by_median_guess_unchecked(_First, _Last, _Pred);

        _Ideal = (_Ideal >> 1) + (_Ideal >> 2); // allow 1.5 log2(N) divisions

        if (_Mid.first - _First < _Last - _Mid.second) { // loop on second half
            _STD _Sort_unchecked(_First, _Mid.first, _Ideal, _Pred);
            _First = _Mid.second;
        } else { // loop on first half
            _STD _Sort_unchecked(_Mid.second, _Last, _Ideal, _Pred);
            _Last = _Mid.first;
        }
    }
}

_EXPORT_STD template <class _RanIt, class _Pr>
_CONSTEXPR20 void sort(const _RanIt _First, const _RanIt _Last, _Pr _Pred) { // order [_First, _Last)
    _STD _Adl_verify_range(_First, _Last);
    const auto _UFirst = _STD _Get_unwrapped(_First);
    const auto _ULast  = _STD _Get_unwrapped(_Last);
    _STD _Sort_unchecked(_UFirst, _ULast, _ULast - _UFirst, _STD _Pass_fn(_Pred));
}

_EXPORT_STD template <class _RanIt>
_CONSTEXPR20 void sort(const _RanIt _First, const _RanIt _Last) { // order [_First, _Last)
    _STD sort(_First, _Last, less<>{});
}
```
先解释一下难看懂的地方:
1. _RanIt: Random Access Iterator,可用[]进行定向访问的迭代器
2. _Iter_diff_t<_RanIt>:迭代器之间的差,可以用来体现容器长度
3. `constexpr int _ISORT_MAX = 32`
4. _Pred: cmp函数,排序规则,根据最下方函数可知默认使用`less<>{}`,即从小到大排
5. `for (;;) `: 编译速度与`while(1)`没有任何区别,只是个人习惯或者历史遗留问题而已

可以看到sort函数内部对于不同的容器有三种处理方式:
1. 当容器大小不大于32时,使用插入排序;
2. 当递归深度太大时,转而使用堆排序
3. 默认使用快速排序

现在,仔细看一下快速排序的代码:
```cpp
// divide and conquer by quicksort
        auto _Mid = _STD _Partition_by_median_guess_unchecked(_First, _Last, _Pred);

        _Ideal = (_Ideal >> 1) + (_Ideal >> 2); // allow 1.5 log2(N) divisions

        if (_Mid.first - _First < _Last - _Mid.second) { // loop on second half
            _STD _Sort_unchecked(_First, _Mid.first, _Ideal, _Pred);
            _First = _Mid.second;
        } else { // loop on first half
            _STD _Sort_unchecked(_Mid.second, _Last, _Ideal, _Pred);
            _Last = _Mid.first;
        }
```
大致结构与平常io写的快排没有任何区别,只是专业化了一点而已

### deque<T>
为什么先讲deque再讲queue呢,是因为queue是用deque写的,这确实出乎我的意料.
由于deque部分洋洋洒洒有1800多行,故我先讲大致结构,再深入每个文件来讲
### queue<T>



# 数据结构与算法
这里小提一嘴,真正的算法思维,不是说你通过刷题知道了这类题型要用这种算法和数据结构来做,而是根据要求能够自己选择合适的算法和数据结构,即便用的是最基础的数据结构和算法,也能做到整体的思维缜密和逻辑正确.
可惜的是,当你去翻luogu的题解时,大多数的代码都写的混乱不堪,充斥着各种奇技淫巧,仅仅是为了通过而通过.可以说我是形式主义吧,但我觉得算法的美丽在于通过自己的思考写出一段优美的,别人也能轻易看懂的代码,而不是这种小孩子的涂鸦.
## 数据结构
### 栈
### 队列
### 哈希表
## 基础算法
### 复杂度分析

### 二分大法
二分法本身的思想不难,最难的是写`<=`还是`<`的时候.
事实上,二分法总共只有两种写法,一个是左闭右闭,一个是左闭右开,但如果两种方法混着用,很容易就记混了,现场推导或许也可以,但总归是要想一下子的.
故我认为只使用下面一种逻辑算法就行了,因为两端均为闭区间最符合正常人直觉.
```cpp
 while (l <= r) {
      int mid = (l + r) / 2;
      res = findsum(mid);
      if (res >= k)
        l = mid + 1;
      else
        r = mid - 1;
    }
```



### 排序算法
#### 冒泡排序

### 搜索
事实上,翻遍全网,找不到一个真正详尽的入门教程,基本都是丢给你几道算法题的解答就结束了,却从来没有真正的讲明白为什么要这样写
#### 到底是用dfs还是bfs?(3/14)
- [参考文章](https://cuijiahua.com/blog/2018/01/alogrithm_10.html)
问ai或者上网查,很容易就知道bfs用来求最短路径,而dfs用来求路径条数,那么,为什么是这样呢?
先概览一下代码:
**dfs**
```cpp
#include <bits/stdc++.h>
using namespace std;

const int MAX = 105;

int n,m;
char g[MAX][MAX];
int vis[MAX][MAX];

int dx[4]={-1,1,0,0};
int dy[4]={0,0,-1,1};

void dfs(int x,int y)
{
    vis[x][y]=1;

    for(int i=0;i<4;i++)
    {
        int nx=x+dx[i];
        int ny=y+dy[i];

        if(nx<1||nx>n||ny<1||ny>m)
            continue;

        if(vis[nx][ny])
            continue;

        if(g[nx][ny]=='#')
            continue;

        dfs(nx,ny);
    }
}

int main()
{
    int sx,sy;

    cin>>n>>m;

    for(int i=1;i<=n;i++)
        for(int j=1;j<=m;j++)
        {
            cin>>g[i][j];
            if(g[i][j]=='S')
                sx=i,sy=j;
        }

    dfs(sx,sy);
}
```
可以看到dfs使用的是层层递归的方式,会一条路走到底,直到没有路可走或者找到答案才返回上一级,处理完后再返回上一级.
换句话说也就是**先进后出**,后来新出现的路径优先处理,这也是栈的工作原理.
所以,dfs的数据结构注定了它不能处理太大深度的复杂搜索,否则栈就很容易溢出.
比如下面这题:
```md
乔治有一些同样长的小木棍，他把这些木棍随意砍成几段，直到每段的长都不超过 50。

现在，他想把小木棍拼接成原来的样子，但是却忘记了自己开始时有多少根木棍和它们的长度。

给出每段小木棍的长度，编程帮他找出原始木棍的最小可能长度。

对于全部测试点，1≤n≤65，1≤a[i]≤50
```


**bfs**
```cpp
#include <bits/stdc++.h>
using namespace std;

const int MAX = 105;

int n,m;
char g[MAX][MAX];
int vis[MAX][MAX];

int dx[4]={-1,1,0,0};
int dy[4]={0,0,-1,1};

struct Node{
    int x;
    int y;
    int step;
};

int bfs(int sx,int sy)
{
    queue<Node> q;

    q.push({sx,sy,0});
    vis[sx][sy]=1;

    while(!q.empty())
    {
        Node cur=q.front();
        q.pop();

        int x=cur.x;
        int y=cur.y;
        int step=cur.step;

        if(g[x][y]=='E')  //终点
            return step;

        for(int i=0;i<4;i++)
        {
            int nx=x+dx[i];
            int ny=y+dy[i];

            if(nx<1||nx>n||ny<1||ny>m)
                continue;

            if(vis[nx][ny])
                continue;

            if(g[nx][ny]=='#') //墙
                continue;

            vis[nx][ny]=1;
            q.push({nx,ny,step+1});
        }
    }

    return -1;
}

int main()
{
    int sx,sy;

    cin>>n>>m;

    for(int i=1;i<=n;i++)
        for(int j=1;j<=m;j++)
        {
            cin>>g[i][j];
            if(g[i][j]=='S')
                sx=i,sy=j;
        }

    cout<<bfs(sx,sy);
}
```
最值得关注的便是bfs使用的是队列来存储要处理的节点,而队列的特点便是先进先出,如果遍历四个方向,那么bfs会依次处理这四个方向之后,再处理下一层的节点,这样依次扩展,直到找到终点.
那么bfs之所以能够找到最短路的原因就很明显了,如果当前层找不到终点,说明终点在下一层,如果找到了终点,说明当前路径就是最好的结果,不用继续找了.

事实上,下面才是更为常见的写法,由于OI选手一般能不写函数就不写,所以刚入门时看到这样的代码是比较难理解bfs的.
```cpp
#include <bits/stdc++.h>
using namespace std;

int main()
{
    const int MAX=105;

    int n,m;
    char g[MAX][MAX];
    int vis[MAX][MAX]={0};

    int dx[4]={-1,1,0,0};
    int dy[4]={0,0,-1,1};

    cin>>n>>m;

    int sx,sy;

    for(int i=1;i<=n;i++)
        for(int j=1;j<=m;j++)
        {
            cin>>g[i][j];
            if(g[i][j]=='S')
                sx=i,sy=j;
        }

    struct Node{
        int x,y,step;
    };

    queue<Node> q;

    q.push({sx,sy,0});
    vis[sx][sy]=1;

    while(!q.empty())
    {
        Node cur=q.front();
        q.pop();

        int x=cur.x;
        int y=cur.y;
        int step=cur.step;

        if(g[x][y]=='E')
        {
            cout<<step;
            break;
        }

        for(int i=0;i<4;i++)
        {
            int nx=x+dx[i];
            int ny=y+dy[i];

            if(nx<1||nx>n||ny<1||ny>m)
                continue;

            if(vis[nx][ny])
                continue;

            if(g[nx][ny]=='#')
                continue;

            vis[nx][ny]=1;
            q.push({nx,ny,step+1});
        }
    }
}
```

#### 为什么要写vis数组来标记访问路径?
{% raw %}
<div id="dfs-root" style="position: relative; overflow: hidden; background: #ffffff; border: 1px solid #eee; border-radius: 12px; margin: 2rem 0; padding: 1.5rem; color: #333; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;">
    
    <style>
        /* 针对 Butterfly 的局部隔离样式 */
        #dfs-root button { 
            cursor: pointer; padding: 6px 14px; border-radius: 6px; font-size: 13px; font-weight: 600; 
            margin: 4px; border: 1px solid #e2e8f0; transition: all 0.2s; background: #fff; color: #475569;
        }
        #dfs-root button:hover { border-color: #3b82f6; color: #3b82f6; }
        #dfs-root .active-btn { background: #3b82f6 !important; color: #fff !important; border-color: #2563eb !important; }
        
        #dfs-root .grid-container { 
            display: grid; grid-template-columns: repeat(3, minmax(50px, 70px)); gap: 8px; 
            background-color: #f1f5f9; padding: 10px; border-radius: 8px; width: fit-content; margin: 20px auto;
        }
        #dfs-root .cell { 
            aspect-ratio: 1/1; display: flex; align-items: center; justify-content: center; 
            font-size: 14px; font-weight: bold; border-radius: 4px; border: 1px solid #e2e8f0;
            background: #fff; transition: background 0.1s; 
        }
        #dfs-root .v { background-color: #cbd5e1; color: #64748b; } /* visited */
        #dfs-root .c { background-color: #3b82f6; color: #fff; transform: scale(0.95); } /* current */
        #dfs-root .s { outline: 3px solid #22c55e; outline-offset: -2px; } /* start */
        #dfs-root .e { outline: 3px solid #ef4444; outline-offset: -2px; } /* end */
        
        #dfs-root .console { 
            background: #f8fafc; padding: 12px; border-radius: 6px; font-family: 'Fira Code', monospace;
            font-size: 13px; border-left: 4px solid #3b82f6; min-height: 50px;
        }
    </style>

    <div style="display: flex; flex-wrap: wrap; justify-content: center; margin-bottom: 10px;">
        <button onclick="dfsApp.run('no_mark', this)">1. 无标记 (死循环)</button>
        <button onclick="dfsApp.run('no_unmark', this)">2. 无释放 (遗漏)</button>
        <button onclick="dfsApp.run('correct', this)">3. 标准回溯 (全空间)</button>
    </div>

    <div class="grid-container" id="dfs-grid"></div>

    <div style="display: flex; justify-content: center; gap: 10px; margin-bottom: 15px;">
        <button id="dfs-pause" onclick="dfsApp.togglePause()">暂停</button>
        <button id="dfs-speed" onclick="dfsApp.toggleSpeed()">速度: 常速</button>
    </div>

    <div class="console">
        <div id="dfs-log">系统状态：准备就绪</div>
    </div>
</div>

<script>
var dfsApp = {
    N: 3, vis: [], ans: 0, steps: 0, isRunning: false, isPaused: false, delayMs: 200,
    dx: [0, 1, 0, -1], dy: [1, 0, -1, 0],
    
    sleep: async function() {
        await new Promise(r => setTimeout(r, this.delayMs));
        while (this.isPaused) await new Promise(r => setTimeout(r, 100));
    },

    render: function(cx, cy) {
        const g = document.getElementById('dfs-grid');
        g.innerHTML = '';
        for(let i=0; i<this.N; i++) {
            for(let j=0; j<this.N; j++) {
                const d = document.createElement('div');
                d.className = 'cell';
                if (i === cx && j === cy) d.className += ' c';
                else if (this.vis[i][j]) d.className += ' v';
                if (i === 0 && j === 0) d.className += ' s';
                if (i === this.N-1 && j === this.N-1) d.className += ' e';
                d.innerText = i + ',' + j;
                g.appendChild(d);
            }
        }
        document.getElementById('dfs-log').innerText = "方案数: " + this.ans + " | 当前步数: " + this.steps;
    },

    dfs: async function(x, y, mode) {
        if (!this.isRunning) return;
        this.steps++;
        if (this.steps > 150 && mode === 'no_mark') {
            document.getElementById('dfs-log').innerText = "[崩溃] 检测到死循环，栈已溢出！";
            throw new Error('Stop');
        }
        this.render(x, y);
        await this.sleep();
        if (x === this.N-1 && y === this.N-1) { this.ans++; return; }
        
        for (let i = 0; i < 4; i++) {
            let nx = x + this.dx[i], ny = y + this.dy[i];
            if (nx >= 0 && nx < this.N && ny >= 0 && ny < this.N) {
                if (mode === 'no_mark' || !this.vis[nx][ny]) {
                    if (mode !== 'no_mark') this.vis[nx][ny] = 1;
                    try { await this.dfs(nx, ny, mode); } catch(e) { if(mode==='no_mark') return; }
                    if (mode === 'correct') this.vis[nx][ny] = 0;
                    if (this.isRunning) { this.render(x, y); await this.sleep(); }
                }
            }
        }
    },

    run: async function(mode, btn) {
        this.isRunning = false; this.isPaused = false;
        document.querySelectorAll('#dfs-root button').forEach(b => b.classList.remove('active-btn'));
        btn.classList.add('active-btn');
        await new Promise(r => setTimeout(r, 100));
        this.isRunning = true;
        this.vis = Array(this.N).fill(0).map(() => Array(this.N).fill(0));
        this.ans = 0; this.steps = 0;
        if (mode !== 'no_mark') this.vis[0][0] = 1;
        await this.dfs(0, 0, mode);
        this.render(-1, -1);
        this.isRunning = false;
    },

    togglePause: function() { this.isPaused = !this.isPaused; document.getElementById('dfs-pause').innerText = this.isPaused ? '继续' : '暂停'; },
    toggleSpeed: function() {
        const b = document.getElementById('dfs-speed');
        if (this.delayMs === 200) { this.delayMs = 800; b.innerText = '速度: 慢速'; }
        
        else { this.delayMs = 200; b.innerText = '速度: 常速'; }
    }
};
dfsApp.render(-1, -1);
</script>
{% endraw %}

```cpp
if (nx >= 1 && nx <= n && ny >= 1 && ny <= m && a[nx][ny] != -1 &&
        !vis[nx][ny]) {
      vis[nx][ny] = 1; // 【标记】占领这个点
      dfs(nx, ny);     // 【递归】继续深入
      vis[nx][ny] = 0; // 【回溯】释放这个点，让别的路径也能经过它
    }
```
以此代码为例,如果不写`vis[nx][ny] = 1;`,则会导致搜索时反复回到已经走过的路径,造成死循环;如果不在递归后写`vis[nx][ny] = 0;`,会导致一个已经遍历过的路径中的方格无法被其他其他路径使用.
- 再解释一下为什么不写vis就会死循环:
  - 从方格1到方格2后,方格2会遍历上下左右四个方向,因为方格1对于2来说是可达的,因此会回到方格1,以此往复.
因此,如果题目要求找到所有路径,或者所写算法中有往回走的可能,就需要使用vis数组,无论是dfs还是bfs.

## 图论



