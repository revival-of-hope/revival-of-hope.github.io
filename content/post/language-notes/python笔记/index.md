---
title: "Python笔记"
date: 2026-04-25T09:56:06+08:00
description: 
image: 12904418_p0-夏の日の昼下がり.webp
weight: 1
---
Python在目前是最值得学的语言,没有之一,它依靠简单好用的语法和各种各样的第三方库,被广泛用于以下领域:
1. 数据挖掘: Python爬虫库
2. 数据处理: Numpy,Matplotlib和各类文档处理库
3. 计算机视觉/图像识别: OpenCV,前沿的OCR库
4. 机器学习: pytorch与transformers库
5. Web后端: Django框架,Fastapi与flask库

可以说,自编程语言诞生以来,没有哪个语言能够像Python一样有着如此广阔的应用领域,它实质上成为了各个领域的程序员的必备技能.
# Python历史
## 诞生与起步 (1980s - 1990s)
*   **1980 年代末**：Guido van Rossum 在荷兰 CWI 开始构思 Python，作为 ABC 语言的继承者。
*   **1989 年 12 月**：Python 的实现工作正式开始。
*   **1991 年**：发布首个公开版本 **Python 0.9.0**，具备异常处理和 Amoeba 操作系统接口能力。

## Python 2.x 时代 (2000 - 2020)
*   **2000 年 10 月 16 日**：**Python 2.0** 发布，引入列表推导式、循环检测垃圾回收、引用计数和 Unicode 支持。
*   **2020 年**：发布 **Python 2.7.18**，这是 2.x 系列的最后一个版本。
*   **2020 年 1 月 1 日**：Python 2.7 正式结束寿命（EOL），不再接收官方安全补丁或更新。

## 3. Python 3.x 时代 (2008 - 至今)
*   **2008 年 12 月 3 日：Python 3.0 发布**。作为重大修订版，它彻底解决了 2.x 时代的字符编码混乱等底层痛点，但由于**不完全向下兼容**，导致了长达十年的生态分裂与社区摩擦。
*   **2018 年 7 月 12 日：Guido van Rossum 宣布离任**。这一突然举动的直接诱因是 **PEP 572（海象运算符 `:=`）** 引起的激烈争执。部分核心开发者与用户极力反对该语法，认为其破坏了 Python 的简洁性。面对社区前所未有的质疑声和言论攻击，Guido 宣布进入“永久假期”，正式卸任“终身仁慈独裁者”（BDFL）。
*   **2019 年 1 月：管理架构转型**。为填补权力真空，核心开发者选举产生首届**五人指导委员会（Steering Council）**。Python 从个人决策制转向集体协商制，标志着其社区治理进入了现代组织阶段。
*   **2020 年 4 月：Python 2.x 彻底终结**。随着 **Python 2.7.18** 的发布，2.x 系列正式停止所有安全补丁更新，社区重心全面转向 3.x 分支。
*   **2021 年 - 2024 年：性能驱动与架构革新**。在微软等大公司资助下，“Faster CPython” 计划启动；同时，针对长期争议的 **GIL（全局解释器锁）**，社区通过了 **PEP 703**（使其成为可选），尝试解决多核并行执行的瓶颈问题。


可以看的出来,Python语言的演进脉络是相当清晰的,没有直接的大公司把控,没有多个创始人之间的争执,没有乏味的专业委员会,也正是因为如此,python成为了最自由最有活力的语言.

# Python基础
## 参考文档说明
- [官方文档](https://docs.Python.org/zh-cn/3.11/tutorial/classes.html)
  - 学习Python的很多疑难问题都是因为没有去阅读第一手资料,尽管如此,有时候二手博客比起官方文档更能解释清楚某个难点.
- [w3schools](https://www.w3schools.com/python/python_intro.asp)
  - 一个非常详尽的python教程
有了这两个文档珠玉在前,所以我只会讲一点难点和重点.

>我最搞不懂的就是市面上很多Python相关的书,即使触及的是机器学习/爬虫/计算机视觉这些很高深的领域,也非要在前一两章讲一下Python的基础语法.要我说,如果读者从来没学过Python,光看这些破碎的教程是不可能理解好Python的;而对于学过的读者来说,你讲这些又没必要.不管怎样,确实无法理解...

## 多行注释的实质
我们经常能够看到这样的多行注释:
```py
"""
这是一个
多行内容
"""
```

但是Python实质上没有专门的多行注释,它实质上是一个没有变量名字的字符串.

因为在python中允许匿名变量的存在,你只写一个值并不会报错,但会被编译器略过:
```py
123
"hello world"
[1, 2, 3]
```

而`"""xxx"""`在python中是可换行字符串的写法,由于被编译器直接略过了,所以不会产生任何副作用,自然就被拿来当多行注释使用了.

## 函数
### 返回值
Python原生支持多个返回值,既不需要像cpp那样用数组指针来迂回处理,也不需要像JS那样用数组解构处理.
### 参数
#### 函数调用
我们在调用函数时可以通过两种方式:
1. Positional argument: 使用`key = value`的语法
2. Keyword argument: 只使用值而不使用关键字名字

具体代码如下:
```py
# keyword
def my_function(animal, name):
  print("I have a", animal)
  print("My", animal + "'s name is", name)

my_function(animal = "dog", name = "Buddy")

# positional
def my_function(animal, name):
  print("I have a", animal)
  print("My", animal + "'s name is", name)

my_function("dog", "Buddy")
```

当然,还可以混着用,但Positional argument必须放在后面:

```py
def my_function(animal, name, age):
  print("I have a", age, "year old", animal, "named", name)

my_function("dog", name = "Buddy", age = 5)
```

有时候,我们不希望其他代码的维护者使用Positional argument方式调用函数,就可以在函数参数的末端加上`,/`:
```py
def my_function(name, /):
  print("Hello", name)

my_function(name = "Emil") 
# 报错
```

但更多的时候,我们希望代码的维护者只用Positional argument而不是Keyword argument,从而让代码更好阅读,就可以在参数的最前面加上`*,`:
```py
def my_function(*, name):
  print("Hello", name)

my_function("Emil")
# 报错
```

一个更为眼花缭乱的例子如下:
```py
def my_function(a, b, /, *, c, d):
  return a + b + c + d

result = my_function(5, 10, c = 15, d = 20)
print(result)
```
#### 接收任意数量的参数
如果你不知道你的函数会接收多少个参数,你可以在参数名前加上一个*号,那么我们就可以在函数内部通过下标来访问所需的变量:
```py
def my_function(*kids):
  print("The youngest child is " + kids[2])

my_function("Emil", "Tobias", "Linus")
```

出于习惯,我们都将这种可接收多个参数的参数写成`*args`,对应`arguments`:
```py
def my_function(*args):
  print("Type:", type(args))
  print("First argument:", args[0])
  print("Second argument:", args[1])
  print("All arguments:", args)

my_function("Emil", "Tobias", "Linus")
# Type: <class 'tuple'>
# First argument: Emil
# Second argument: Tobias
# All arguments: ('Emil', 'Tobias', 'Linus')
```
- 根据上述代码的输出可以看到,`*args`实际上就是元组.

如果你还希望调用者就算使用了多个参数,也需要一个个指明参数名的话,就可以加上两个`*`号:
```py
def my_function(**kid):
  print("His last name is " + kid["lname"])

my_function(fname = "Tobias", lname = "Refsnes")
```

出于习惯,我们将这类参数写成`**kwargs`,对应`keyword arguments`:

```py
def my_function(username, **details):
  print("Username:", username)
  print("Additional details:")
  for key, value in details.items():
    print(" ", key + ":", value)

my_function("emil123", age = 25, city = "Oslo", hobby = "coding")
```

自然,`**kwargs`能够接收多个`key=value`的参数,那么它就是字典了:

```py
def my_function(**myvar):
  print("Type:", type(myvar))
  print("Name:", myvar["name"])
  print("Age:", myvar["age"])
  print("All data:", myvar)

my_function(name = "Tobias", age = 30, city = "Bergen")

# Type: <class 'dict'>
# Name: Tobias
# Age: 30
# All data: {'name': 'Tobias', 'age': 30, 'city': 'Bergen'}
```

混着用也可以:
```py
def my_function(title, *args, **kwargs):
  print("Title:", title)
  print("Positional arguments:", args)
  print("Keyword arguments:", kwargs)

my_function("User Info", "Emil", "Tobias", age = 25, city = "Oslo")
```
#### 参数解包
python的设计者仿佛觉得`*`这个符号太好看还是怎么着,在函数调用的时候也引入了`*`和`**`.

`*`用于解包列表:
```py
def my_function(a, b, c):
  return a + b + c

numbers = [1, 2, 3]
result = my_function(*numbers) # Same as: my_function(1, 2, 3)
print(result)
```
`**`用于解包字典:
```py
def my_function(fname, lname):
  print("Hello", fname, lname)

person = {"fname": "Emil", "lname": "Refsnes"}
my_function(**person) # Same as: my_function(fname="Emil", lname="Refsnes")
```
### 生成器(Generator)
>Generators are functions that can **pause** and **resume** their execution.

When a generator function is called, it returns a generator object, which is an **iterator**(迭代器).

>The code inside the function is not executed yet, it is only compiled. The function only executes when you iterate over the generator.

- 上述文字的大致意思就是: 生成器不是一次返回所有值的,它的真正返回值是一个迭代器,只会在你遍历它的时候才会开始真正执行,.

生成器函数使用`yield`关键字来代替`return`,体现出"产生"的效果:
```py
def my_generator():
  yield 1
  yield 2
  yield 3

for value in my_generator():
  print(value)
# 1
# 2
# 3
```
迭代器是有记忆力的,明白自己这次遍历到了哪一步:
```py
def count_up_to(n):
  count = 1
  while count <= n:
    yield count
    count += 1

for num in count_up_to(5):
  print(num)

# 1
# 2
# 3
# 4
# 5
```

除了使用`for in`遍历外,还可以调用生成器专用的`next()`系统函数进行迭代:
```py
def simple_gen():
  yield "Emil"
  yield "Tobias"
  yield "Linus"

gen = simple_gen()
print(next(gen))
print(next(gen))
print(next(gen))

# Emil
# Tobias
# Linus
```
- 如果生成器的yield个数不够迭代了,则会报错.

#### 总结与实战
如此看来,生成器本身是同步的(按顺序执行的),只不过会在`yield`关键字处停止,直到你遍历它时才会一次执行一个yield,直到执行完毕.

那么,我们之所以要用yield,显然是为了**节省内存**,如果我们需要获取大量数据,不使用生成器的话就需要单独创建一个数组或者字典,把数据全部存进去,很有可能会导致**内存溢出**.

但如果使用yield的话,我们可以一次执行一步,慢慢将数据写入文件中,从而避免了内存溢出的问题.

下面是一个实战的爬虫代码,可以很好的看出yield的优点:
```py
import requests
import time

def fetch_data_generator(base_url, total_pages):
    """
    数据抓取生成器：负责分页逻辑与请求执行
    """
    for page in range(1, total_pages + 1):
        params = {'page': page, 'size': 10}
        try:
            # 模拟网络请求
            response = requests.get(base_url, params=params, timeout=5)
            response.raise_for_status()
            data = response.json()
            
            # 物理机制：执行到此处暂停，将数据交给外层消费
            # 外部处理完前，生成器不占据下一页的请求资源和内存
            yield data.get('items', [])
            
            # 简单的频率控制
            time.sleep(1)
        except Exception as e:
            print(f"Error fetching page {page}: {e}")
            break

# 使用场景：
if __name__ == "__main__":
    target_url = "https://api.example.com/posts"
    
    # 物理执行过程：
    # 1. 调用生成器函数，不执行函数体，返回一个生成器对象
    crawler = fetch_data_generator(target_url, 100)
    
    # 2. 外部循环触发 .next()，生成器开始运行
    for page_items in crawler:
        for item in page_items:
            # 实时处理数据（如存入数据库）
            print(f"Processing: {item.get('title')}")
```

## OOP
>如果用 C++ 术语来描述的话，类成员（包括数据成员）通常为 public,所有成员函数都为 virtual


### self详解
由于Python没有指针,自然也没有this指针,但又需要像cpp一样,提供一个**访问当前类实例的入口**,所以Python引入了关键字self.

>事实上,上述的说法是不严谨的:
>>方法的第一个参数常常被命名为 self。 这也不过就是一个约定: **self 这一名称在 Python 中绝对没有特殊含义**。 但是要注意，不遵循此约定会使得你的代码对其他 Python 程序员来说缺乏可读性，而且也可以想像一个 类浏览器 程序的编写可能会依赖于这样的约定。
>也就是说,我们可以起名叫this,apple,但别人不一定看得懂就是了.


我们可以看到,大多数类中的函数都需要至少给出一个参数,也就是self,即使函数中并没有用到self,原因如下:

- Python 的类实例方法在调用时，解释器会自动将实例对象作为第一个位置参数传入,如果你没有写self参数,那么由于该函数没有参数,但却传入了一个参数,就会报错
  - 至于为什么会这样,那就是设计上的问题了,只能被动接受.
  - 这也解释了为什么我们从来没有手动处理self参数过

```py
class Dog:

    tricks = []             # mistaken use of a class variable

    def __init__(self, name):
        self.name = name

    def add_trick(self, trick):
        self.tricks.append(trick)

>>> d = Dog('Fido')
>>> e = Dog('Buddy')
>>> d.add_trick('roll over')
>>> e.add_trick('play dead')
>>> d.tricks                # unexpectedly shared by all dogs
['roll over', 'play dead']
```

### 类属性
在python中,所有写在函数之外的变量都被视为该类所具有的属性,被所有实例和子类共享:
```py
class Person:
  species = "Human" # Class property

  def __init__(self, name):
    self.name = name # Instance property

p1 = Person("Emil")
p2 = Person("Tobias")

print(p1.name)
print(p2.name)
print(p1.species)
print(p2.species)
print(Person.species)
```

### 继承与多态
Python的继承比起Cpp来更为简单,写一个括号就行了:
```py
class Student(Person):
  pass
```
#### 多态代码示例
```py
class Vehicle:
  def __init__(self, brand, model):
    self.brand = brand
    self.model = model

  def move(self):
    print("Move!")

class Car(Vehicle):
  pass

class Boat(Vehicle):
  def move(self):
    print("Sail!")

class Plane(Vehicle):
  def move(self):
    print("Fly!")

car1 = Car("Ford", "Mustang")       #Create a Car object
boat1 = Boat("Ibiza", "Touring 20") #Create a Boat object
plane1 = Plane("Boeing", "747")     #Create a Plane object

for x in (car1, boat1, plane1):
  print(x.brand)
  print(x.model)
  x.move()
```
如前所说,python的所有方法默认是可以重载的,所以很好书写和理解.
#### 使用父类的构造函数
有时候我们会希望子类的初始化方式与父类略有不同,Python的做法比较粗暴,再写一个构造函数的话会直接覆盖父类的构造函数,而不像Java/Cpp那样会逐个从最顶层的父类开始执行构造函数.

- 也就是说,python不支持在一个类中写多个构造函数,那么也就无法直接保留父类的构造函数了.

为了保留父类的构造函数,我们可以这么写:
```py
class Student(Person):
  def __init__(self, fname, lname):
    Person.__init__(self, fname, lname)
```
#### super关键字
当然,写父类名字还是太麻烦了,而且多重继承的时候会出现一些意想不到的[问题](https://www.reddit.com/r/learnpython/comments/ndyce5/a_question_about_super_and_multiple_inheritance/?tl=zh-hans),所以Python引入了关键字`super()`,用来指向最终被调用的父类:
```py
class A:
    def __init__(self, a, **kwargs):
        print(a)

class B(A):
    def __init__(self, b, **kwargs):
        super().__init__(**kwargs)
        print(b)

class C(A):
    def __init__(self, c, **kwargs):
        super().__init__(**kwargs)
        print(c)

class D(B, C):
    def __init__(self, d, **kwargs):
        super().__init__(**kwargs)
        print(d)

D(a='a', b='b', c='c', d='d')

# 输出结果
# a
# c
# b
# d
```
- `**kwargs`用于传递各种各样没在当前函数中用到的参数,如果去掉的话很容易出错.因此在python的大型项目中,你几乎能够在每个子类中看见它,很多时候你自己根本看不明白哪些参数被用到了,而哪些参数没被用到.

每个`super()`都会指向自己继承的父类,通过不断的向上寻找,直到找到最终被调用的父类和构造函数,至于具体的调用链我看没必要去理解,太容易绕晕了.

当然,`super()`除了调用构造函数之外,还可以调用父类的方法和属性,但一般在工程中很少这么做,而是选择拆分出一个新函数后再将父类函数和新函数组合在一起,以免过于混乱.
### 类封装(Encapsulation)
Python没有类似Cpp/Java的访问控制符,只能通过下划线前缀来对属性做一定的约束:
1. `_`单下划线: 标记该属性为**protected**,只能被自身和子类调用.
   - 本身不具有任何约束,从外部通过`obj._name`调用该属性也**不会报错**
2. `__`双下划线: 标记该属性为私有类,只供内部函数使用.
   - Python解释器会在内部对其进行重命名,比如Person类中的`__name`会变成`_Person__name`,所以你直接访问`person.__name`会**报错**,但是访问`person._Person__name`就**不会有问题**.

- 换句话说,在python中,你坚持要访问私有属性的话也可以,只不过没有必要罢了.

方法也是同理:
```py
class Calculator:
  def __init__(self):
    self.result = 0

  def __validate(self, num):
    if not isinstance(num, (int, float)):
      return False
    return True

  def add(self, num):
    if self.__validate(num):
      self.result += num
    else:
      print("Invalid number")

calc = Calculator()
calc.add(10)
calc.add(5)
print(calc.result)
# calc.__validate(5) # This would cause an error
```
### 内部类
Python和Java一样支持内部类,只有在你确认这个类不需要开放给其他类的时候才用得上:
```py
class Car:
  def __init__(self, brand, model):
    self.brand = brand
    self.model = model
    self.engine = self.Engine()

  class Engine:
    def __init__(self):
      self.status = "Off"

    def start(self):
      self.status = "Running"
      print("Engine started")

    def stop(self):
      self.status = "Off"
      print("Engine stopped")

  def drive(self):
    if self.engine.status == "Running":
      print(f"Driving the {self.brand} {self.model}")
    else:
      print("Start the engine first!")

car = Car("Toyota", "Corolla")
car.drive()
car.engine.start()
car.drive()
```

## Python关键字与内置函数

### with
- [官方文档](https://docs.python.org/zh-cn/3.12/reference/compound_stmts.html#index-16)

with是一个非常好用的语法糖,将文件读写等容易出问题的操作封装成一个非常简单的语法:
```py
with EXPRESSION as TARGET:
    SUITE
```
上述代码等价于:
```py
manager = (EXPRESSION)
enter = type(manager).__enter__
exit = type(manager).__exit__
value = enter(manager)
hit_except = False

try:
    TARGET = value
    SUITE
except:
    hit_except = True
    if not exit(manager, *sys.exc_info()):
        raise
finally:
    if not hit_except:
        exit(manager, None, None, None)
```

**实战代码**
```py
import json

# 1. 生产者：准备一个名为 'config.json' 的文件
# 2. 消费者：使用 with 语句读取并解析
try:
    with open('config.json', 'r', encoding='utf-8') as f:
        # json.load() 直接将文件对象转换为 Python 字典或列表
        data = json.load(f)
    
    # 此时文件已自动关闭，可以直接操作变量 data
    print(data)
    print(type(data)) 

except FileNotFoundError:
    print("错误：未找到 json 文件")
except json.JSONDecodeError:
    print("错误：文件内容不是有效的 JSON 格式")
```

### range
The range() function can be called with 1, 2, or 3 arguments, using this syntax:

- range的返回值本质上是一个不可变的有序数组,是前闭后开的.
```py
range(start, stop, step)
```

只用一个参数的话默认指明终点(stop),起点为0:
```py
x = range(10)
```
用两个参数的话默认步长(step)为1:
```py
x = range(3, 10)
```
### in和not in
- [菜鸟教程](https://www.runoob.com/python/python-operators.html)

| 运算符     | 描述                                                            | 实例                                              |
| ---------- | --------------------------------------------------------------- | ------------------------------------------------- |
| **in**     | 如果在指定的序列中找到值返回 **True**，否则返回 **False**。     | `x in y`：如果 x 在 y 序列中，则返回 True。       |
| **not in** | 如果在指定的序列中没有找到值返回 **True**，否则返回 **False**。 | `x not in y`：如果 x 不在 y 序列中，则返回 True。 |

```py
a = 10
list = [1, 2, 3, 4, 5 ];
 
if ( a in list ):
   print "1 - 变量 a 在给定的列表中 list 中"
else:
   print "1 - 变量 a 不在给定的列表中 list 中"
 
# 修改变量 a 的值
a = 2
if ( a in list ):
   print "3 - 变量 a 在给定的列表中 list 中"
else:
   print "3 - 变量 a 不在给定的列表中 list 中"
```
### is和is not
| 运算符     | 描述                                 | 实例                                                                       |
| ---------- | ------------------------------------ | -------------------------------------------------------------------------- |
| **is**     | 判断两个标识符是否引用自同一个对象。 | `x is y`：类似 `id(x) == id(y)`，若引用同一对象则返回 **True**。           |
| **is not** | 判断两个标识符是否引用自不同对象。   | `x is not y`：类似 `id(x) != id(y)`，若引用的不是同一对象则返回 **True**。 |

```py
#!/usr/bin/python
# -*- coding: UTF-8 -*-
 
a = 20
b = 20
 
if ( a is b ):
   print "1 - a 和 b 有相同的标识"
else:
   print "1 - a 和 b 没有相同的标识"
 
if ( a is not b ):
   print "2 - a 和 b 没有相同的标识"
else:
   print "2 - a 和 b 有相同的标识"
 
# 修改变量 b 的值
b = 30
if ( a is b ):
   print "3 - a 和 b 有相同的标识"
else:
   print "3 - a 和 b 没有相同的标识"
 
if ( a is not b ):
   print "4 - a 和 b 没有相同的标识"
else:
   print "4 - a 和 b 有相同的标识"

# 输出结果
# 1 - a 和 b 有相同的标识
# 2 - a 和 b 有相同的标识
# 3 - a 和 b 没有相同的标识
# 4 - a 和 b 没有相同的标识
```
### yield
- 前面的生成器部分已经提过了
### 异常处理
一个基本的代码如下:
```py
print(sys.exception())
# None
try:
    raise TypeError
except:
    print(repr(sys.exception()))
    try:
         raise ValueError
    except:
        print(repr(sys.exception()))
    print(repr(sys.exception()))

# TypeError()
# ValueError()
# TypeError()
# print(sys.exception())
# None
```

**实战代码**
```py
import json

def read_config(file_path):
    try:
        # 1. try: 放置可能报错的代码
        print(f"正在尝试打开文件: {file_path}")
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)

    except FileNotFoundError as e:
        # 2. except: 捕获特定错误并处理
        print(f"错误：找不到文件。详情: {e}")
        data = {}

    except json.JSONDecodeError:
        # 可以捕获多个不同的异常
        print("错误：JSON 格式不正确")
        data = {}

    except Exception as e:
        # 兜底：捕获所有其他未预料到的异常
        print(f"发生了未知错误: {e}")
        data = {}

    else:
        # 3. else: 如果 try 块没有发生任何异常，则执行此处
        # 适用于那些只有在成功获取资源后才执行的逻辑
        print("文件读取成功，未发生异常")

    finally:
        # 4. finally: 无论是否发生异常，都一定会执行
        # 通常用于关闭数据库连接、释放锁或记录日志
        print("操作尝试结束，正在清理环境...")
        
    return data

# 实战调用
config = read_config('settings.json')
```
### async与await
于2015年的Python3.5引入,用于执行异步任务,最常见的应用场景就是网络通信和爬虫

- [fastapi教程](https://fastapi.tiangolo.com/zh/async/)


### assert
- [官方文档](https://docs.Python.org/3/reference/simple_stmts.html)
- [菜鸟教程](https://www.runoob.com/Python3/Python3-assert.html)
**基础用法**
```py
assert expression
# 等价于下述代码:
if __debug__:
    if not expression:
        raise AssertionError
```
**报错后输出提示**
```py
import sys
assert ('linux' in sys.platform), "该代码只能在 Linux 下执行"
```
## Python常用语法糖
- [官方文档](https://docs.Python.org/3/library/functions.html#classmethod)
### @classmethod
>Transform a method into a class method.

字面意思,将某个方法实例化到这个类中,从而可以直接调用,不需要使用self来指向实例,也不需要进行类的实例化.
但仍然需要填入参数cls(自然可以叫别的名字,cls只是一个习惯上的写法),用来指向这个类
- 因为这个类还没完成,就不能用类名.var/method来调用类内变量和函数,故需要通过cls来指向该类.
```py
class A(object):
    bar = 1
    def func1(self):  
        print ('foo') 
    @classmethod
    def func2(cls):
        print ('func2')
        print (cls.bar)
        cls().func1()   # 调用 foo 方法
 
A.func2()               # 不需要实例化
```
### @property
>Return a **property attribute**.


A property object has **getter, setter, and deleter** methods usable as decorators that create a copy of the property with the corresponding accessor function set to the decorated function. This is best explained with an example:
```py
class C:
    def __init__(self):
        self._x = None

    @property
    def x(self):
        """I'm the 'x' property."""
        return self._x

    @x.setter
    def x(self, value):
        self._x = value

    @x.deleter
    def x(self):
        del self._x
```

```py
class Parrot:
    def __init__(self):
        self._voltage = 100000

    @property
    def voltage(self):
        """Get the current voltage."""
        return self._voltage
```
- The @property decorator **turns the voltage() method into a “getter” for a read-only attribute with the same name**, and it sets the docstring for voltage to “Get the current voltage.”

如果还是看不懂的话,就把property看成是一个将方法转换成类内只读属性的语法糖(可以少写一对括号,并且不可修改),但可以通过setter和deleter来修改.
### @dataclass
- [官方文档](https://docs.Python.org/zh-cn/3/library/dataclasses.html)
- [参考教程](https://www.cnblogs.com/wang_yb/p/18077397)
#### 是什么,怎么用
一般来说,我们定义类时需要这么写来初始化:
```py
class CoinTrans:
    def __init__(
        self,
        id: str,
        symbol: str,
        price: float,
        is_success: bool,
        addrs: list,
    ) -> None:
        self.id = id
        self.symbol = symbol
        self.price = price
        self.addrs = addrs
        self.is_success = is_success

if __name__ == "__main__":
    coin_trans = CoinTrans("id01", "BTC/USDT", "71000", True, ["0x1111", "0x2222"])
    print(coin_trans)
# <__main__.CoinTrans object at 0x0000022A891FADD0>
```
自然,Python打印类的时候默认是打印类的内存地址的,这需要我们去单独实现一个打印函数返回类中的各种信息.

但如果使用dataclass装饰器的话,可以这样写:

```py
from dataclasses import dataclass

@dataclass
class CoinTrans:
    id: str
    symbol: str
    price: float
    is_success: bool
    addrs: list

if __name__ == "__main__":
    coin_trans = CoinTrans("id01", "BTC/USDT", "71000", True, ["0x1111", "0x2222"])
    print(coin_trans)
# CoinTrans(id='id01', symbol='BTC/USDT', price='71000', is_success=True, addrs=['0x1111', '0x2222'])
```
不需要写`__init__`,也不需要写打印函数,就可以直接实现上述的效果.

# 包管理器: uv
uv将虚拟环境和包管理两个功能集成在了一起,从而彻底解决了Python的环境问题.
## 管理Python版本
>如果系统上已经安装了 Python，uv 将无需配置即可检测并使用它。但是，uv 也可以安装和管理 Python 版本。uv 会根据需要自动安装缺失的 Python 版本——你无需为了开始使用而预先安装 Python。

- `uv Python install`：安装最新 Python 版本。
  - eg: `uv Python install 3.12 `
- `uv Python list`：查看可用的 Python 版本。



## 运行Python脚本
如果脚本没有依赖模块或者依赖标准库中的模块,可以直接使用 `uv run` 来执行它,例如:`uv run example.py`.

uv可以使用特定的Python版本运行脚本
```bash
$ # 使用特定的 Python 版本
$ uv run --Python 3.10 example.py
3.10.15
```

## 包的使用
uvx 命令可以在不安装工具的情况下调用它:
```bash
uvx ruff
```
使用 uvx 时，工具会安装到临时的、隔离的环境中.

如果一个工具经常使用，最好将其安装到持久环境中并添加到 PATH，而不是重复调用 uvx.
```bash
uv tool install ruff
```
安装工具后，其可执行文件会放在 PATH 中的 bin 目录中，这样就可以在没有 uv 的情况下运行该工具.

## 项目中的包管理
uv通过`pyproject.toml`文件来定义依赖项.

使用 `uv init` 命令创建一个新的 Python 项目:
```bash
uv init hello-world
cd hello-world
```
或者在工作目录中初始化uv
```bash
$ mkdir hello-world
$ cd hello-world
$ uv init
```
### 项目结构
>一个项目由几个协同工作的重要部分组成，这些部分允许 uv 管理你的项目。除了 uv init 创建的文件外，当你第一次运行项目命令（即 uv run、uv sync 或 uv lock）时，uv 将在你的项目根目录中创建一个虚拟环境和 uv.lock 文件。
```bash
.
├── .venv
│   ├── bin
│   ├── lib
│   └── pyvenv.cfg
├── .Python-version
├── README.md
├── main.py
├── pyproject.toml
└── uv.lock
```

- 直接震惊了好吧,终于不用输入`Python -m venv venv`这种东西了

**pyproject.toml**
```toml
[project]
name = "uv"
version = "0.1.0"
description = "Add your description here"
readme = "README.md"
requires-Python = ">=3.13"
dependencies = []

```

**.Python-version**
.Python-version 文件包含项目的Python 版本。此文件告诉 uv 在创建项目的虚拟环境时使用哪个 Python 版本。

>我相信应该不只有我一个人好奇:就这一条信息为什么不合并到toml文件中呢?
经过[浏览](https://github.com/astral-sh/uv/issues/8247)我推测: requires-Python配置项要求了在特定Python版本下才能运行项目,如果把当前使用的不合规Python版本写入toml,那么uv编译的时候要听谁的呢?
因此,单独分出这一个文件既是为了保证Python版本管理的方便,也为了防止错误的Python版本被用来执行.

**uv.lock**
uv.lock 是一个人类可读的 TOML 文件，但由 uv 管理，不应手动编辑,包含有关你的项目依赖项的精确信息.

### 包管理和从pip迁移
你可以使用 uv add 命令将依赖项添加到你的 pyproject.toml 中。这也将更新锁文件和项目环境：
```bash
$ # 指定版本约束
$ uv add 'requests==2.31.0'

$ # 添加一个 git 依赖
$ uv add git+https://github.com/psf/requests
```

```bash
$ # 从 `requirements.txt` 添加所有依赖项。
$ uv add -r requirements.txt -c constraints.txt
```

```bash
# --upgrade-package 标志将尝试将指定的包更新到最新的兼容版本，同时保持锁文件的其余部分不变
$ uv lock --upgrade-package requests
```

### 运行和同步
>在每次调用 uv run 之前，uv 将验证锁文件是否与 pyproject.toml 同步，以及环境是否与锁文件同步，从而使你的项目保持同步，无需手动干预。uv run 保证你的命令在一致、锁定的环境中运行。

当接手一个使用了uv的项目时,建议先运行uv sync命令以创建虚拟环境并下载库进行同步,尽管使用uv run **随便一个Python文件** 会默认使用uv sync,但就不够优雅了.
### 构建分发包
```bash
$ uv build
$ ls dist/
hello-world-0.1.0-py3-none-any.whl
hello-world-0.1.0.tar.gz
```

## TL;DR
如果是自己新建Python项目,则运行:
```bash
uv init hello-world
# 这会在创建子文件夹并填入初始内容
uv init 
# 在当前文件夹填入初始内容
uv add ...
# 本地加入自己需要的依赖
# 或者自己在toml里填入包,如果这样的话需要使用uv sync

uv run main.py
# 使用uv运行某个脚本
```
如果是接手某个项目:
```bash
uv sync
uv run main.py
# 使用uv运行某个脚本
```

## 实战:Using uv with PyTorch
- [参考](https://docs.astral.sh/uv/guides/integration/pytorch/)

```toml
[project]
name = "project"
version = "0.1.0"
requires-Python = ">=3.14"
dependencies = [
  "torch>=2.9.1",
  "torchvision>=0.24.1",
]
```
>This is a valid configuration for projects that want to use **CPU** builds on Windows and macOS, and CUDA-enabled builds on Linux. However, if you need to support different platforms or accelerators, you'll need to configure the project accordingly.

**使用CUDA13.0**
```toml
[[tool.uv.index]]
name = "pytorch-cu130"
url = "https://download.pytorch.org/whl/cu130"
explicit = true
```
**TL;DR**:
先在nvidia官网下载cuda13.0,然后根据这个toml运行uv sync即可.
- 提示:要下载差不多2个G.
```toml
[project]
name = "ml"
version = "0.1.0"
description = "Add your description here"
readme = "README.md"
requires-Python = ">=3.13"
dependencies = [
    "torch",
    "torchvision",
    "torchaudio",
]

[tool.uv]
# 1. 物理定义 PyTorch 的专用硬件加速索引库
[tool.uv.index]
name = "pytorch-cu130"
url = "https://download.pytorch.org/whl/cu130"
explicit = true # 强制：只有在 sources 中明确指定的包才去这里找，防止污染其他依赖

[tool.uv.sources]
# 2. 将核心组件物理绑定到上述索引
torch = { index = "pytorch-cu130" }
torchvision = { index = "pytorch-cu130" }
torchaudio = { index = "pytorch-cu130" }
```
解释一下:
1. tool.uv: 告诉uv编译器,下面是我要你遵循的规则
2. tool.uv.index: 提供自定义组件源,而不是到官方库下载
3. tool.uv.sources: 将组件与index绑定,只有与index绑定的组件才会去自定义组件源下载

运行一下代码,很成功:
```py
import torch
print(f"CUDA status: {torch.cuda.is_available()}")
print(f"CUDA version: {torch.version.cuda}")
```

```bash
uv run ch1.py
CUDA status: True
CUDA version: 13.0
```



# Python编译(待补充)
- python是如何编译的?Cpython是什么?pyc文件又是什么?这几个问题会在这一章得到解决


# Python类型注释
类型注释在PEP484也就是2015年的Python3.5中引入,从而在很大程度上解决了Python动态类型带来的混乱.
## 简单的类型注释
如下方代码所示,类型注释有两种格式:
1. `变量名: 类型`: 用于提示参数的类型
2. `函数末尾 -> 类型:`: 用于提示函数的返回值类型
```py
def surface_area_of_cube(edge_length: float) -> str:
    return f"The surface area of the cube is {6 * edge_length ** 2}."
```
大多数类型注释都不需要导入任何库即可使用,下面是一个常用的系统直接支持的类型注释表格:
| 分类            | 语法示例                                                        | 说明                                                  | 适用版本 |
| :-------------- | :-------------------------------------------------------------- | :---------------------------------------------------- | :------- |
| **基础标量**    | `var: int`, `var: float`, `var: bool`, `var: str`, `var: bytes` | 整数、浮点、布尔、字符串、字节流                      | 全版本   |
| **空值/无返回** | `def fn() -> None:`                                             | 表示函数没有返回值                                    | 全版本   |
| **列表**        | `var: list[int]`                                                | 元素全为整数的列表                                    | 3.9+     |
| **字典**        | `var: dict[str, int]`                                           | 键为字符串、值为整数的字典                            | 3.9+     |
| **元组 (定长)** | `var: tuple[int, str]`                                          | 包含一个整数和一个字符串的二元组                      | 3.9+     |
| **元组 (变长)** | `var: tuple[int, ...]`                                          | 包含任意数量整数的元组                                | 3.9+     |
| **集合**        | `var: set[str]`                                                 | 元素全为字符串的集合                                  | 3.9+     |
| **联合类型**    | `var: int \| str`                                               | 变量可以是整数或字符串 (Union)                        | 3.10+    |
| **可选类型**    | `var: str \| None`                                              | 变量可以是字符串或为空 (Optional)                     | 3.10+    |
| **类对象**      | `var: type[MyClass]`                                            | 变量是类本身，而不是类的实例                          | 3.9+     |
| **自定义类**    | `var: MyClass`                                                  | 变量是该类的实例                                      | 全版本   |
| **双向队列**    | `var: collections.deque[int]`                                   | 需 Python 3.9+，虽在 collections 但无需 import typing | 3.9+     |
| **切片**        | `var: slice`                                                    | 内存索引切片对象                                      | 全版本   |
| **范围**        | `var: range`                                                    | 迭代范围对象                                          | 全版本   |
| **枚举迭代**    | `var: enumerate`                                                | 枚举对象                                              | 全版本   |

这些简单类型已经可以涵盖大多数应用场景了,如果需要使用更高级的类型注释功能,就需要导入typing库来使用.
## typing系统库
- [官方文档](https://docs.Python.org/zh-cn/3/library/typing.html)

### 类型别名: type
类型别名是使用 `type 简写 = 复杂类型` 语句来定义的，它将创建一个 `TypeAliasType` 的实例.
```py
type Vector = list[float]

def scale(scalar: float, vector: Vector) -> Vector:
    return [scalar * num for num in vector]

# 通过类型检查；浮点数列表是合格的 Vector。
new_vector = scale(2.0, [1.0, -4.2, 5.4])
```

### Any: 支持任何类型
不使用类型注释时,所有的变量和返回值都被视为Any,用Any类型注解的变量不会在类型检查时报错.

在现代Python项目中,有三种情况会用到它:
1. 某一个变量支持不同类型的值
2. 你不知道它应该是什么值
3. 无论它是什么值都无所谓

显然,如果你全用Any的话也可以通过类型检查,但这样就没有意义了.


### Annotated: 给类型添加额外的注释说明
- [官方文档](https://docs.python.org/zh-cn/3/library/typing.html)
  - 讲的不像人话
- [stackoverflow](https://stackoverflow.com/questions/71898644/how-to-use-typing-annotated)

>Annotated in python allows developers to declare the type of a reference and **provide additional information related to it**.

- 毕竟Annotation本身就是**注释**的意思
```py
# 简单的注释说明
name: Annotated[str, "first letter is capital"]

# 框架的语法糖说明
def read_items(q: Annotated[str, Query(max_length=50)])
```
### Optional,Union及其简易写法
>Union[X, Y] 等价于 X | Y ，意味着满足 X 或 Y 之一,而 Optional[X] 等价于 X | None

- 还是很好理解的.
## annotated-types库
- [官网](https://pypi.org/project/annotated-types/)


鉴于Annotated本身提供的注释功能比较乏善,这个第三方库部分解决了这个问题,引入了一些比较实用的功能,这里只简单介绍四个注释函数: Gt,Ge,Lt,Le.

- **Gt(x)** - value must be "Greater Than" x - equivalent to exclusive minimum
- **Ge(x)** - value must be "Greater than or Equal" to x - equivalent to inclusive minimum
- **Lt(x)** - value must be "Less Than" x - equivalent to exclusive maximum
- **Le(x)** - value must be "Less than or Equal" to x - equivalent to inclusive maximum

**示例代码**
```py
from typing import Annotated
from annotated_types import Gt, Len, Predicate

class MyClass:
    age: Annotated[int, Gt(18)]                         # Valid: 19, 20, ...
                                                        # Invalid: 17, 18, "19", 19.0, ...
    factors: list[Annotated[int, Predicate(is_prime)]]  # Valid: 2, 3, 5, 7, 11, ...
                                                        # Invalid: 4, 8, -2, 5.0, "prime", ...

    my_list: Annotated[list[int], Len(0, 10)]           # Valid: [], [10, 20, 30, 40, 50]
                                                        # Invalid: (1, 2), ["abc"], [0] * 20
```

# Python测试
## 如何写测试
- [pytest文档](https://docs.pytest.org/en/stable/explanation/anatomy.html#test-anatomy)
  - 写的很好,所以全文摘录
>In the simplest terms, a test is meant to look at the result of a particular behavior, and make sure that result aligns with what you would expect. Behavior is not something that can be empirically measured, which is why writing tests can be challenging.

“Behavior” is the way in which some system acts in response to a particular situation and/or stimuli. But exactly how or why something is done is not quite as important as what was done.

You can think of a test as being broken down into four steps:
1. Arrange
2. Act
3. Assert
4. Cleanup

Arrange is where we prepare everything for our test. This means pretty much everything except for the “act”. It’s lining up the dominoes so that the act can do its thing in one, state-changing step. This can mean preparing objects, starting/killing services, entering records into a database, or even things like defining a URL to query, generating some credentials for a user that doesn’t exist yet, or just waiting for some process to finish.

Act is the singular, state-changing action that kicks off the behavior we want to test. This behavior is what carries out the changing of the state of the system under test (SUT), and it’s the resulting changed state that we can look at to make a judgement about the behavior. This typically takes the form of a function/method call.

Assert is where we look at that resulting state and check if it looks how we’d expect after the dust has settled. It’s where we gather evidence to say the behavior does or does not align with what we expect. The assert in our test is where we take that measurement/observation and apply our judgement to it. If something should be green, we’d say `assert thing == "green"`.

Cleanup is where the test picks up after itself, so other tests aren’t being accidentally influenced by it.

At its core, the test is ultimately the act and assert steps, with the arrange step only providing the context. Behavior exists between act and assert.

也就是说,在写测试之前,我们需要设计一些能够体现代码功能或者bug的操作,放入测试函数中,然后执行函数并检测输出是否与预期的一致,并保证测试结果彼此之间互不影响.
## pytest
### Intro
pytest在Python测试库中占据了统治地位,而Python系统库自带的unittest就显得逊色很多了,故测试库里我只介绍pytest.

我们先创建一个`test_parts.py`文件,填入以下代码:
```py
def func(x):
    return x + 1


def test_answer():
    assert func(3) == 5
```
1. 如果是全局安装过,或者在虚拟环境安装了的话,只要在终端输入`pytest`即可
2. 如果使用uv管理的话,只需输入以下命令:
```bash
uv run pytest
```
该命令将运行当前目录并递归运行子目录中所有形式为 test_*.py 或 *_test.py 的文件.
- 如果文件中的代码块不是全局的而是位于函数中,则需要函数名带有类似的`test_*()`格式
- 如果把函数放在类里面,则需要在类名前面加上`Test`,否则该类被整个跳过
来看看输出结果:
```bash
================================= test session starts ==================================
platform win32 -- Python 3.13.7, pytest-9.0.2, pluggy-1.6.0
rootdir: xxx
configfile: pyproject.toml
plugins: anyio-4.12.1
collected 1 item                                                                        

test_parts.py F                                                                   [100%]

======================================= FAILURES ======================================= 
_____________________________________ test_answer ______________________________________ 

    def test_answer():
>       assert func(3) == 5
E       assert 4 == 5
E        +  where 4 = func(3)

test_parts.py:7: AssertionError
=============================== short test summary info ================================ 
FAILED test_parts.py::test_answer - assert 4 == 5
================================== 1 failed in 0.10s =================================== 
```
- [100%] 指的是运行所有测试用例的总体进度

### 使用pytest语法糖
- [官方教程](https://docs.pytest.org/en/stable/explanation/fixtures.html)
- [参考教程](https://www.cnblogs.com/hiyong/p/14163280.html)

用`@pytest.fixture()`修饰的函数在文件内部可以直接被其他函数调用名字并获取返回值,具体如下所示:
```py
import pytest

@pytest.fixture()
def login():
    print("登录")
    return 8

class Test_Demo():
    def test_case1(self):
        print("\n开始执行测试用例1")
        assert 1 + 1 == 2

    def test_case2(self, login):
        print("\n开始执行测试用例2")
        print(login)
        assert 2 + login == 10

    def test_case3(self):
        print("\n开始执行测试用例3")
        assert 99 + 1 == 100

if __name__ == '__main__':
    pytest.main()
```
- login()在这里相当于一个测试工具函数
  
### 语法糖参数: autouse
默认情况下,被`@pytest.fixture()`修饰的工具函数只在被请求时才被加载,如果没有任何一个测试用例用到这个函数,它就永远不会运行,也就是懒加载(lazy loading).

乍一看挺好的,但是如果测试中有大量的测试用例更改了数据库,我们不希望一个个去撤销数据库更改后还原,不仅让代码变得臃肿,而且很累.

所以,我们使用`autouse=True`来让被修饰的函数强制生效,而不管测试用例有没有调用这个函数.

```py
import pytest

@pytest.fixture(autouse=True)
def login():
    print("登录...")

class Test_Demo():
    def test_case1(self):
        print("\n开始执行测试用例1")
        assert 1 + 1 == 2

    def test_case2(self):
        print("\n开始执行测试用例2")
        assert 2 + 8 == 10

    def test_case3(self):
        print("\n开始执行测试用例3")
        assert 99 + 1 == 100


if __name__ == '__main__':
    pytest.main()
```
**终端输出**
```bash
登录...
PASSED                    [ 33%]
开始执行测试用例1
登录...
PASSED                    [ 66%]
开始执行测试用例2
登录...
PASSED                    [100%]
开始执行测试用例3
```
### 语法糖参数: scope
>fixture作用范围可以为module、class、session和function，默认作用域为function。

其核心逻辑是：**在指定作用域内，只执行一次初始化，然后所有人共享这个缓存的对象。**

#### function（函数级）
* **频率**：最高。
* **含义**：每个测试函数执行前，都会重新运行一遍 Fixture。
* **场景**：你需要每个测试用例都拥有一个全新的、干净的数据副本，防止 A 用例的操作影响到 B 用例。

#### class（类级）
* **频率**：中。
* **含义**：如果一个测试类（`class TestXXX`）里有 10 个测试方法，这个 Fixture 只会在进入该类时运行一次，10 个方法共用同一个对象。
* **场景**：测试类中的所有方法都需要同一个昂贵的对象（如一个已经打开的浏览器窗口）。

#### module（模块级）
* **频率**：低。
* **含义**：在一个 `.py` 文件中，无论有多少个类或函数，Fixture 只在该文件开始时运行一次。
* **场景**：同一个文件内的测试都依赖于同一个外部配置函数。

#### session（会话级）
* **频率**：最低。
* **含义**：当你运行 `pytest` 命令开始，到所有测试结束，Fixture 只运行一次。
* **场景**：启动整个项目的测试数据库、初始化大型算法模型或全局 API 客户端。



### yield关键字在pytest中的使用
在yield关键字之前的代码在测试函数开始运行之前执行，yield之后的代码在函数运行结束后执行
```py
import pytest

@pytest.fixture()
def login():
    print("登录")
    yield
    print("退出登录")

class Test_Demo():
    def test_case1(self):
        print("\n开始执行测试用例1")
        assert 1 + 1 == 2

    def test_case2(self, login):
        print("\n开始执行测试用例2")
        assert 2 + 8 == 10

    def test_case3(self):
        print("\n开始执行测试用例3")
        assert 99 + 1 == 100


if __name__ == '__main__':
    pytest.main()
```
**终端输出**
```bash
PASSED                      [ 33%]
开始执行测试用例1
登录
PASSED                      [ 66%]
开始执行测试用例2
退出登录
PASSED                      [100%]
开始执行测试用例3
```

### conftest.py文件

#### 自动识别机制
只要文件名为 `conftest.py`，pytest 会在启动时自动扫描并加载它。你**不需要**在测试文件中显式 `import` 它。

#### 作用范围（层级继承）
`conftest.py` 的作用范围遵循**目录树结构**：
* **根目录**：如果放在项目根目录，其定义的配置对整个项目生效。
* **子目录**：如果放在某个子目录（如 `tests/unit/conftest.py`），则仅对该目录及其子目录下的测试文件生效。
* **优先级**：子目录中的 `conftest.py` 会重写或扩展父目录中的同名配置。

#### 核心用途
它本质上是一个**本地插件库**，主要处理以下三类任务：

* **Fixtures（固件）共享**：
    在 `conftest.py` 中定义的 `@pytest.fixture` 可以被该目录下的所有测试用例直接通过参数名调用,不用再进行导入
* **Hook函数自定义**：
    可以修改 pytest 的内部行为。例如 `pytest_runtest_setup`（在测试开始前执行）或 `pytest_addoption`（添加自定义命令行参数）。
* **外部插件加载**：
    通过 `pytest_plugins = ["plugin1", "plugin2"]` 在特定目录下引入额外的插件。

#### 关键限制
* **不可跨目录手动导入**：永远不要尝试 `from conftest import ...`。如果这样做，会破坏 pytest 的加载机制，可能导致配置冲突或重复初始化。
* **文件命名固定**：必须严格命名为 `conftest.py`，否则 pytest 会将其视为普通的 Python 模块



### 实战
事实上,上述的内容基本涵盖了我们所需的pytest知识了,我们现在拿fastapi模板项目中的test部分来做例子,深入探讨一下pytest的实际应用
- 看来我这个博客可以靠着fastapi啃很久了

先翻到后端的Readme:
>If your stack is already up and you just want to run the tests, you can use:
```bash
docker compose exec backend bash scripts/tests-start.sh
```

看来这就是测试脚本了,让我们看看**tests-start.sh**的内容:

```bash
#! /usr/bin/env bash
set -e 
# 立即退出模式,脚本中任何一条命令执行失败将停止脚本继续执行
set -x
# 调试模式: 执行每条命令前先将命令打印到终端
Python app/tests_pre_start.py
# 执行预启动脚本
bash scripts/test.sh "$@"
# 执行test.sh脚本
# "$@": 将当前脚本用到的参数传给test.sh脚本
# 如果我执行./tests-start.sh --verbose --fail-fast
# 那么执行test.sh时也会带有--verbose --fail-fast参数

```

那我们再看看**test.sh**脚本
```bash
#!/usr/bin/env bash

set -e
set -x

coverage run -m pytest tests/
# 执行tests文件夹下的测试
coverage report
# 在终端输出测试信息
coverage html --title "${@-coverage}"
# 生成可视化html报告,通常位于 htmlcov/ 目录
```

也就是说,到头来还是用pytest执行了tests文件夹里的测试,只不过多了一些其他的包装而已.

![示意图](PixPin_2026-04-01_18-37-20.webp)
- 这就是全部的测试文件了,还是很多的,这说明测试并非是无关轻重的代码部分

先来看看最外层的conftest.py文件:
**conftest.py**
```py
from collections.abc import Generator

import pytest
from fastapi.testclient import TestClient
from sqlmodel import Session, delete

from app.core.config import settings
from app.core.db import engine, init_db
from app.main import app
from app.models import Item, User
from tests.utils.user import authentication_token_from_email
from tests.utils.utils import get_superuser_token_headers


@pytest.fixture(scope="session", autouse=True)
def db() -> Generator[Session, None, None]:
    with Session(engine) as session:
        init_db(session)
        yield session
        statement = delete(Item)
        session.execute(statement)
        statement = delete(User)
        session.execute(statement)
        session.commit()


# @pytest.fixture(scope="module")
# def client() -> Generator[TestClient, None, None]:
#     with TestClient(app) as c:
#         yield c


# @pytest.fixture(scope="module")
# def superuser_token_headers(client: TestClient) -> dict[str, str]:
#     return get_superuser_token_headers(client)


# @pytest.fixture(scope="module")
# def normal_user_token_headers(client: TestClient, db: Session) -> dict[str, str]:
#     return authentication_token_from_email(
#         client=client, email=settings.EMAIL_TEST_USER, db=db
#     )

```

第一个函数`db`在整个测试开始时启动一次,将数据库初始化,并删除Item和User关系表,从而清空所有数据;至于其他被注释掉的函数都是给其他测试模块用的工具函数

- 换句话说,这个测试只能在开发环境做,一旦部署好了就不要再搞测试了

除了utils文件夹下的文件都是工具函数外,其余的文件基本都是以test_前缀打头的pytest文件了.我们只挑一个最精华的文件来看:
**test_items.py**
```py
import uuid

from fastapi.testclient import TestClient
from sqlmodel import Session

from app.core.config import settings
from tests.utils.item import create_random_item


def test_create_item(
    client: TestClient, superuser_token_headers: dict[str, str]
) -> None:
    data = {"title": "Foo", "description": "Fighters"}
    response = client.post(
        f"{settings.API_V1_STR}/items/",
        headers=superuser_token_headers,
        json=data,
    )
    assert response.status_code == 200
    content = response.json()
    assert content["title"] == data["title"]
    assert content["description"] == data["description"]
    assert "id" in content
    assert "owner_id" in content


def test_read_item(
    client: TestClient, superuser_token_headers: dict[str, str], db: Session
) -> None:
    item = create_random_item(db)
    response = client.get(
        f"{settings.API_V1_STR}/items/{item.id}",
        headers=superuser_token_headers,
    )
    assert response.status_code == 200
    content = response.json()
    assert content["title"] == item.title
    assert content["description"] == item.description
    assert content["id"] == str(item.id)
    assert content["owner_id"] == str(item.owner_id)


def test_read_item_not_found(
    client: TestClient, superuser_token_headers: dict[str, str]
) -> None:
    response = client.get(
        f"{settings.API_V1_STR}/items/{uuid.uuid4()}",
        headers=superuser_token_headers,
    )
    assert response.status_code == 404
    content = response.json()
    assert content["detail"] == "Item not found"
```

- 第一个函数`test_create_item`模拟管理员创建一个测试数据,并判断收到的响应报文中的数据是否相同.
- 第二个函数`test_read_item`模拟管理员在创建一个随机物品后,判断使用get请求是否正常.
- 第三个函数`test_read_item_not_found`模拟管理员直接访问一个不存在的物品,需要注意的是,这里的uuid4方法有可能产生恰好与之前测试生成相同的物品id,而我们的数据库清空是只在开始运行时执行,而不是每次执行测试函数都执行,因此有极低的概率会返回200状态码导致测试失败

后面的函数都大差不差了,基本就是构造测试数据,使用client模拟前端进行访问,并判断响应是否正常,但是有一个问题:既然要模拟前端访问,自然需要后端能够响应,才能执行测试,但根据前面的脚本分析,我们仅仅是用了pytest启动test文件夹中的测试而已,并没有真正的启动后端,那么测试是如何执行的呢?

答案在最开始的`conftest.py`中,我们的测试函数中都引入了`client: TestClient`这个工具函数,而这个函数在`conftest.py`中早就定义好了:
```py
from app.main import app
from fastapi.testclient import TestClient
@pytest.fixture(scope="module")
def client() -> Generator[TestClient, None, None]:
    with TestClient(app) as c:
        yield c
```
这里的TestClient方法的作用域为模块级,即只在该文件的测试开始执行时调用一次,使用了main.py中的app对象:

```py
# 真实后端里的main.py

app = FastAPI(
    title=settings.PROJECT_NAME,
    openapi_url=f"{settings.API_V1_STR}/openapi.json",
    generate_unique_id_function=custom_generate_unique_id,
)
```
也就是说,我们启动了后端中的关键部分,从而实现对后端的整体调用,测试整个应用的运行是否正常.
# Python格式检查与数据规范
就算测试通过了,我们的代码仍然可能是混乱的和不好维护的,通过ruff库我们可以保证程序不出现冗余的代码和意义不明的变量.通过Pydantic库我们可以保证程序运行时不会出现意外的错误.
## ruff
### 是什么,怎么用
ruff是用rust编写的Python格式检查库,可以迅速将py文件规范化,速度比一版的格式检查库都要快很多.


要使用ruff,我们需要先将它加入到当前项目中:
```bash
uv add --dev ruff
```
之后再运行以下命令就可以检查该项目是否规范
```bash
uv run ruff check
```

### 基本用法
**ruff check**
```bash
ruff check                  # Lint files in the current directory.
ruff check --fix            # Lint files in the current directory and fix any fixable errors.
ruff check --watch          # Lint files in the current directory and re-lint on change.
ruff check path/to/code/    # Lint files in `path/to/code`.
```
## Pydantic
- [中文官网](https://pydantic.com.cn/)
  - 内容很杂很多,只看必要的部分即可
### 概览
#### 一段入门代码
```py
from datetime import datetime
from typing import Tuple

from pydantic import BaseModel


class Delivery(BaseModel):
    timestamp: datetime
    dimensions: Tuple[int, int]


m = Delivery(timestamp='2020-01-02T03:04:05Z', dimensions=['10', '20'])
print(repr(m.timestamp))
#> datetime.datetime(2020, 1, 2, 3, 4, 5, tzinfo=TzInfo(UTC))
print(m.dimensions)
#> (10, 20)
```

>“为什么 Pydantic 是这样命名的？”
“Pydantic”这个名字是“Py”和“pedantic”的混合词。“Py”部分表示该库与 Python 相关，而“pedantic”指的是该库在数据验证和类型强制方面的细致方法。
综合这些元素，“Pydantic”描述了我们的 Python 库，它提供了注重细节、严格的数据验证。

#### 一段更为复杂的代码
继承BaseModel的初始化方法后,我们不再需要手动写一个巨长无比的`__init__`函数了:
```py
from datetime import datetime

from pydantic import BaseModel, PositiveInt


class User(BaseModel):
    id: int  
    name: str = 'John Doe'  
    signup_ts: datetime | None  
    tastes: dict[str, PositiveInt]  


external_data = {
    'id': 123,
    'signup_ts': '2019-06-01 12:22',  
    'tastes': {
        'wine': 9,
        b'cheese': 7,  
        'cabbage': '1',  
    },
}

user = User(**external_data)  

print(user.id)  
#> 123
print(user.model_dump())  
"""
{
    'id': 123,
    'name': 'John Doe',
    'signup_ts': datetime.datetime(2019, 6, 1, 12, 22),
    'tastes': {'wine': 9, 'cheese': 7, 'cabbage': 1},
}
"""
```

当你的初始化字典有问题时,pydantic会提供详细的报错说明:
```py
# continuing the above example...

from pydantic import ValidationError


class User(BaseModel):
    id: int
    name: str = 'John Doe'
    signup_ts: datetime | None
    tastes: dict[str, PositiveInt]


external_data = {'id': 'not an int', 'tastes': {}}  

try:
    User(**external_data)  
except ValidationError as e:
    print(e.errors())
    """
    [
        {
            'type': 'int_parsing',
            'loc': ('id',),
            'msg': 'Input should be a valid integer, unable to parse string as an integer',
            'input': 'not an int',
            'url': 'https://pydantic.com.cn/errors/validation_errors#int_parsing',
        },
        {
            'type': 'missing',
            'loc': ('signup_ts',),
            'msg': 'Field required',
            'input': {'id': 'not an int', 'tastes': {}},
            'url': 'https://pydantic.com.cn/errors/validation_errors#missing',
        },
    ]
    """
```
### Basemodel
#### model_dump方法
类似于对字典,列表进行解包,`model_dump`可以对BaseModel的类实例进行解包,这一方法在fastapi项目中非常常见:
```py
from pydantic import BaseModel, Field
from typing import List, Optional
from datetime import datetime

class SubModel(BaseModel):
    id: int
    name: str

class MainModel(BaseModel):
    title: str
    timestamp: datetime = Field(default_factory=datetime.now)
    tags: List[str]
    optional_field: Optional[str] = None
    sub_item: SubModel

# 1. 实例化模型
data = {
    "title": "Pydantic Guide",
    "tags": ["python", "pydantic"],
    "sub_item": {"id": 1, "name": "Deep Dive"}
}
model = MainModel(**data)

# 2. 基础导出：转换为 Python dict
standard_dump = model.model_dump()

# 3. 常用过滤参数说明
filtered_dump = model.model_dump(
    # 仅导出显式赋值过的字段，忽略默认值
    exclude_unset=True,
    # 排除指定的字段
    exclude={'timestamp'},
    # 仅包含指定的字段
    include={'title', 'sub_item'},
    # 导出时排除值为 None 的字段
    exclude_none=True,
    # 递归导出时，将子模型也处理为字典（默认即为 True）
    by_alias=False 
)

# 4. 结果展示
print("Standard Dump:", standard_dump)
print("Filtered Dump:", filtered_dump)
```
#### model_validate方法
>model_validate() 方法从另一个具有属性（或字典）的对象读取数据，并创建该类的新实例

例如,在数据库的CRUD中,为了安全起见,我们会这么写:
```py
def create_user(*, session: Session, user_create: UserCreate) -> User:
    db_obj = User.model_validate(
        user_create, update={"hashed_password": get_password_hash(user_create.password)}
    )
    session.add(db_obj)
    session.commit()
    session.refresh(db_obj)
    return db_obj
```
上述代码会核实新传入的数据是否和User类中的字段对的上,如果对不上会立刻报错,额外定义的字段会被过滤掉,而如果对的上则会保存对应字段的值,哪些没有涉及的字段通通保留默认值,并通过update参数更新自己的其他字段.

#### 错误处理
>无论Pydantic 在验证数据时发现多少个错误，都会引发一个类型为 ValidationError 的单个异常，而 ValidationError 将包含有关所有错误及其发生方式的信息。

```py
from typing import List

from pydantic import BaseModel, ValidationError


class Model(BaseModel):
    list_of_ints: List[int]
    a_float: float


data = dict(
    list_of_ints=['1', 2, 'bad'],
    a_float='not a float',
)

try:
    Model(**data)
except ValidationError as e:
    print(e)
    """
    2 validation errors for Model
    list_of_ints.2
      Input should be a valid integer, unable to parse string as an integer [type=int_parsing, input_value='bad', input_type=str]
    a_float
      Input should be a valid number, unable to parse string as a number [type=float_parsing, input_value='not a float', input_type=str]
    """
```
### Field函数
Field函数最简单的写法就是单纯赋予默认值:
```py
from pydantic import BaseModel, Field
class User(BaseModel):
    name: str = Field(default='John Doe')
```
但上述代码与下面的代码没有任何区别:
```py
from pydantic import BaseModel
class User(BaseModel):
    name: str = 'John Doe'
```

但Field可以有很多高阶用法:

1. **说明该项为必填项,设置别名**
```py
from pydantic import BaseModel, Field


class User(BaseModel):
    name: str = Field(..., alias='username')


user = User(username='johndoe')  # (1)!
print(user)
#> name='johndoe'
print(user.model_dump(by_alias=True))  # (2)!
#> {'username': 'johndoe'}
```
- by_alias: 用于将变量名转换成别名

2. **数值约束**
   1. gt - 大于
   2. lt - 小于
   3. ge - 大于或等于
   4. le - 小于或等于
   5. multiple_of - 给定数字的倍数
   6. allow_inf_nan - 允许 'inf' 、 '-inf' 、 'nan' 值
```py
from pydantic import BaseModel, Field


class Foo(BaseModel):
    positive: int = Field(gt=0)
    non_negative: int = Field(ge=0)
    negative: int = Field(lt=0)
    non_positive: int = Field(le=0)
    even: int = Field(multiple_of=2)
    love_for_pydantic: float = Field(allow_inf_nan=True)
```

3. **约束字符串**
   1. min_length ：字符串的最小长度
   2. max_length ：字符串的最大长度
   3. pattern ：字符串必须匹配的正则表达式
```py
from pydantic import BaseModel, Field


class Foo(BaseModel):
    short: str = Field(min_length=3)
    long: str = Field(max_length=10)
    regex: str = Field(pattern=r'^\d*$')  # (1)!


foo = Foo(short='foo', long='foobarbaz', regex='123')
print(foo)
#> short='foo' long='foobarbaz' regex='123'
```

4. **验证默认值**: 默认情况下不会验证这个属性的默认值是否符合类型注释约束,但我们可以通过**validate_default**字段来实现.
```py
from pydantic import BaseModel, Field, ValidationError


class User(BaseModel):
    age: int = Field(default='twelve', validate_default=True)


try:
    user = User()
except ValidationError as e:
    print(e)
    """
    1 validation error for User
    age
      Input should be a valid integer, unable to parse string as an integer [type=int_parsing, input_value='twelve', input_type=str]
    """
```

5. **防止初始数据被覆写**: 设置`frozen=True`即可
```py
from pydantic import BaseModel, Field, ValidationError


class User(BaseModel):
    name: str = Field(frozen=True)
    age: int


user = User(name='John', age=42)

try:
    user.name = 'Jane'  # (1)!
except ValidationError as e:
    print(e)
    """
    1 validation error for User
    name
      Field is frozen [type=frozen_field, input_value='Jane', input_type=str]
    """
```

6. **标记某字段被弃用**:使用deprecated字段
```py
from typing_extensions import Annotated

from pydantic import BaseModel, Field


class Model(BaseModel):
    deprecated_field: Annotated[int, Field(deprecated='This is deprecated')]


print(Model.model_json_schema()['properties']['deprecated_field'])
#> {'deprecated': True, 'title': 'Deprecated Field', 'type': 'integer'}
```
#### computed_field装饰器
- 鉴于原文档不像人话,所以让AI补充了一下
##### 核心概念：让“方法”表现得像“字段”

在标准 Pydantic 模型中，只有定义了类型注解的变量（如 `name: str`）才会被包含在 `model_dump()`（序列化后的字典）中。普通的 `@property` 虽然可以访问，但序列化时会被忽略。

`@computed_field` 的作用就是**强制将一个属性（Property）的结果包含在序列化输出中**。


##### 1. 解决“字段派生”问题

假设你有一个长方形模型，你有长和宽，但你也希望在导出数据时直接包含“面积”。

```python
from pydantic import BaseModel, computed_field

class Rectangle(BaseModel):
    width: float
    height: float

    @computed_field
    @property
    def area(self) -> float:
        return self.width * self.height

rect = Rectangle(width=10, height=5)
print(rect.model_dump())
# 输出包含 rect: {'width': 10.0, 'height': 5.0, 'area': 50.0}

```

如果没有 `@computed_field`，输出里只有 `width` 和 `height`。


##### 2. 解决“昂贵计算”的缓存问题

有些数据计算非常耗时（例如复杂的数学运算或模型推理）。通过结合 `@cached_property`，你可以确保：

1. **只计算一次**：结果会被缓存。
2. **自动序列化**：结果会被包含在导出的 JSON/字典中。

```python
from functools import cached_property
from pydantic import BaseModel, computed_field

class ComplexModel(BaseModel):
    raw_data: list[int]

    @computed_field
    @cached_property
    def processed_result(self) -> int:
        print("开始耗时计算...")
        return sum(self.raw_data) * 42  # 假设这是耗时操作

model = ComplexModel(raw_data=[1, 2, 3])
# 第一次访问或 model_dump() 时执行计算并缓存
print(model.model_dump()) 

```
### 验证函数
>当你初始化一个数据类时，可以借助`@model_validator`修饰符和mode参数，在验证之前或之后执行该函数。
```py
from typing import Any, Dict

from typing_extensions import Self

from pydantic import model_validator
from pydantic.dataclasses import dataclass


@dataclass
class Birth:
    year: int
    month: int
    day: int


@dataclass
class User:
    birth: Birth

    @model_validator(mode='before')
    @classmethod
    def pre_root(cls, values: Dict[str, Any]) -> Dict[str, Any]:
        print(f'First: {values}')
        """
        First: ArgsKwargs((), {'birth': {'year': 1995, 'month': 3, 'day': 2}})
        """
        return values

    @model_validator(mode='after')
    def post_root(self) -> Self:
        print(f'Third: {self}')
        #> Third: User(birth=Birth(year=1995, month=3, day=2))
        return self

    def __post_init__(self):
        print(f'Second: {self.birth}')
        #> Second: Birth(year=1995, month=3, day=2)


user = User(**{'birth': {'year': 1995, 'month': 3, 'day': 2}})
```
- 如果mode的值为`after`的话,必须要返回`self`,供pydantic处理,如果mode的值为`before`的话,需要返回初始化用的数据.
### 基础配置

我们可以在继承`BaseModel`类的时候指定一些额外的限制:
```py
from pydantic import BaseModel, ValidationError


class Model(BaseModel, extra='forbid'):  
    a: str


try:
    Model(a='spam', b='oh no')
except ValidationError as e:
    print(e)
    """
    1 validation error for Model
    b
      Extra inputs are not permitted [type=extra_forbidden, input_value='oh no', input_type=str]
    """
```

但这样既不够美观,也不能将配置通过继承传递给其他子类,因此,我们可以通过model_config属性来控制整个BaseModel实例:
```py
from pydantic import BaseModel, ConfigDict, ValidationError


class Model(BaseModel):
    model_config = ConfigDict(str_max_length=10)

    v: str


try:
    m = Model(v='x' * 20)
except ValidationError as e:
    print(e)
    """
    1 validation error for Model
    v
      String should have at most 10 characters [type=string_too_long, input_value='xxxxxxxxxxxxxxxxxxxx', input_type=str]
    """
```

- model_config最强大的地方是在`pydantic_settings`库中,而不是这里,在下一章会做详细介绍

# Python读取文件
本部分所用的weekly_hiring_comments.json示例的结构如下:
```json
[
  {
    "issue": 692,
    "author": "ruanyf",
    "created_at": "2019-07-18T07:00:46Z",
    "text": "### **高级 Web 前端工程师**\r\n  \r\n[深圳追一科技](https://zhuiyi.ai/)，人工智能创业公司。工作地点：深圳市南山区。\r\n\r\n公司主打 NLP 方向的 B 端 AI 产品落地，诚求英才。要求4年以上实际前端项目的开发经验，熟练掌握 Vue 或 React 生态，查看[详细信息](https://www.zhipin.com/job_detail/79ca9be7fb736e4d03Nz3924FVA~.html)。\r\n\r\nEmail 联系：[winchang@wezhuiyi.com](mailto:winchang@wezhuiyi.com)",
    "url": "https://github.com/ruanyf/weekly/issues/692#issuecomment-512691467"
  },
//   ...
]
```
## open方法
读写文件一般都通过open方法来进行操作,基本用法看下面的代码就很容易理解了:
```py
with open("weekly_hiring_comments.json", "r", encoding="utf-8") as f:
    posts = json.load(f)

with open("本科及以上.json", "w", encoding="utf-8") as f:
    json.dump(bachelor_posts, f, ensure_ascii=False, indent=2)
```
三个参数分别为:
1. file(文件路径)
2. mode(操作方式)
3. encoding(解码方式)

**mode** 的值包括以下几种:
- 'r' ，表示读取文件
- 'w' 表示写入文件（现有同名文件会被覆盖）
- 'a' 表示打开文件并追加内容，任何写入的数据会自动添加到文件末尾
- 'r+' 表示打开文件进行读写
- **mode 实参是可选的，省略时的默认值为 'r'**


当然,如果看源码的话还能看到一堆参数,但我们一般只用得到上述的三个参数:
```py
def open(
    file: FileDescriptorOrPath,
    mode: OpenTextMode = "r",
    buffering: int = -1,
    encoding: str | None = None,
    errors: str | None = None,
    newline: str | None = None,
    closefd: bool = True,
    opener: _Opener | None = None,
) -> TextIOWrapper: ...
```

现在的问题是这个读写的文件会有很多种格式(.pdf,.txt,.json,.html,.js, ...),我们来看看open是怎么处理的:
1. `text mode` - 默认格式: 通常情况下,文件以该模式打开,一般使用utf-8进行编码,该模式主要用于处理文本文件
2. `binary mode` - 以二进制模式读取文件,需要在mode词尾加上一个'b',如`wb`,`ab`等,在二进制模式下无法指定encoding(也没有必要指定),该模式主要用于读取.png,.mp3,.pdf这样的二进制文件

换句话说,open函数根本不会对每种文件进行特殊处理,只是有两种读取方式而已了,对于一些特殊的文件格式,我们都需要额外用其他库去处理.

但是对于一般的文件格式,open函数读取文件名后会返回一个TextIOWrapper对象,它有两种常用的方法:
1. .read()方法: 将全文读入一个字符串变量
   1. 例子: `content = f.read()`
2. .write()方法: 写入字符串
   1. 例子: `f.write(f"## 招聘 \n\n")`


### json系统库:处理json文件
既然是系统库,那自然要先导入后使用,事实上只有两个常用函数: json.load()和json.dump().

**示例**
```py
with open("weekly_hiring_comments.json", "r", encoding="utf-8") as f:
    posts = json.load(f)

bachelor_posts = []

with open(out_dir / "本科及以上.json", "w", encoding="utf-8") as f:
    json.dump(bachelor_posts, f, ensure_ascii=False, indent=2)
```
看看源码和参数:
```py
# load()
(function) def load(
    fp: SupportsRead[str | bytes],
    *,
    cls: type[JSONDecoder] | None = None,
    object_hook: ((dict[Any, Any]) -> Any) | None = None,
    parse_float: ((str) -> Any) | None = None,
    parse_int: ((str) -> Any) | None = None,
    parse_constant: ((str) -> Any) | None = None,
    object_pairs_hook: ((list[tuple[Any, Any]]) -> Any) | None = None,
    **kwds: Any
) -> Any

# dump()
(function) def dump(
    obj: Any,
    fp: SupportsWrite[str],
    *,
    skipkeys: bool = False,
    ensure_ascii: bool = True,
    check_circular: bool = True,
    allow_nan: bool = True,
    cls: type[JSONEncoder] | None = None,
    indent: int | str | None = None,
    separators: tuple[str, str] | None = None,
    default: ((Any) -> Any) | None = None,
    sort_keys: bool = False,
    **kwds: Any
) -> None
```
速览一下就知道用法了,读json文件时指定文件名,写json文件时指定写入内容和写入文件名就可以了
### 处理md文件
md文件没有专门的库,直接读写就可以了
```py
with open("weekly_hiring_comments.json", "r", encoding="utf-8") as f:
    posts = json.load(f)

out = Path("weekly_hiring_comments.md")

with out.open("w", encoding="utf-8") as f:
    for i, p in enumerate(posts, 1):
        f.write(f"## 招聘 {i}\n\n")
        f.write(f"- Issue: #{p['issue']}\n")
        f.write(f"- 作者: {p['author']}\n")
        f.write(f"- 时间: {p['created_at']}\n")
        f.write(f"- 来源: {p['url']}\n\n")
        f.write(p["text"])
        f.write("\n\n---\n\n")
```

## pathlib库
**该库在不同平台下都能轻松读取文件路径**,而不需要操心系统问题或者字符串问题.

- [官方文档](https://docs.Python.org/zh-cn/3/library/pathlib.html)

>如果以前从未用过此模块，或不确定哪个类适合完成任务，那要用的可能就是 Path。它在运行代码的平台上实例化为具体路径.

接下来我们来详细介绍Path库
### Path对象的创建
```py
from pathlib import Path

# 基础用法
out_file: Path = Path("a.md")

# 拼接路径的两种写法

# 简写
out_file: Path = Path("modules") / "a.py"

# 分开写
out_dir: Path = Path("modules")
out_file: Path = out_dir / "issues.md"

```
上述的代码由于没有指定绝对路径,故都是相对于Python运行目录的路径,但我们也可以指定绝对路径,如下文所示:
```py
from pathlib import Path

# Windows 风格
abs_path_win = Path("C:/Users/Admin/Desktop/a.md")

# Linux/macOS 风格
abs_path_unix = Path("/home/user/project/a.md")
```
也就是说,我们不需要再去折腾不同操作系统的路径问题了,统一用`/`就可以确定相对的路径.
### 使用Path来创建文件夹
只需要调用mkdir方法即可:
```py
out_dir: Path = Path("issues_md")
out_dir.mkdir(exist_ok=True)
```
- exist_ok参数的作用: 默认为False,设置为True时,即便当前路径下有这个文件夹,也不会报错
### Path对象的open方法
事实上,这个open方法与Python内置的open方法基本没有区别,只是把文件路径提到外面来了而已:
```py
out_dir: Path = Path("issues_md")
out_dir.mkdir(exist_ok=True)

for issue, items in by_issue.items():
    path = out_dir / f"issue_{issue}.md"
    with path.open("w", encoding="utf-8") as f:
        f.write(f"# Issue #{issue} 招聘汇总\n\n")
```

### Path对象的glob方法(待补充)

### 实战
```py
import json
from pathlib import Path
from collections import defaultdict

with open("weekly_hiring_comments.json", "r", encoding="utf-8") as f:
    posts = json.load(f)
# 读取json列表
by_issue = defaultdict(list)
for p in posts:
    by_issue[p["issue"]].append(p)
# 处理为一个有序字典,这在json列表本身是无序的时候比较好用
out_dir: Path = Path("issues_md")
out_dir.mkdir(exist_ok=True)

for issue, items in by_issue.items():
    path = out_dir / f"issue_{issue}.md"
    with path.open("w", encoding="utf-8") as f:
        f.write(f"# Issue #{issue} 招聘汇总\n\n")

        for i, p in enumerate(items, 1):
            f.write(f"## 招聘 {i}\n\n")
            f.write(f"- 作者: {p['author']}\n")
            f.write(f"- 时间: {p['created_at']}\n")
            f.write(f"- 来源: {p['url']}\n\n")
            f.write(p["text"])
            f.write("\n\n---\n\n")
```

## re系统库
- [官方文档](https://docs.Python.org/zh-tw/3.8/library/re.html)

该库是对正则表达式(regular expression)的封装,所以叫re.

### compile方法
compile是一个实例化pattern对象的方法,pattern一词在re中指的是正则表达式字符串
```py
prog = re.compile(pattern)
result = prog.match(string)
# 上述代码等价于下面的这个
result = re.match(pattern, string)
# 为了规范化和复用,我们还是多用compile方法来指明pattern对象
```

>事实上,re库中的大多数常用方法都有两种写法,一种是`模式.方法(参数)`,另一种是`方法.(模式,参数)`.为了规范起见,我们后面都采用`模式.方法(参数)`写法,就不再次说明了



### search方法与match方法
- [菜鸟教程](https://www.runoob.com/Python/Python-reg-expressions.html)

>re.match只匹配字符串的开始，如果字符串开始不符合正则表达式，则匹配失败，函数返回None；而re.search匹配整个字符串，直到找到一个匹配。

```py
#!/usr/bin/Python
import re
 
line = "Cats are smarter than dogs";
 
matchObj = re.match( r'dogs', line, re.M|re.I)
if matchObj:
   print "match --> matchObj.group() : ", matchObj.group()
else:
   print "No match!!"
 
matchObj = re.search( r'dogs', line, re.M|re.I)
if matchObj:
   print "search --> searchObj.group() : ", matchObj.group()
else:
   print "No match!!"
```
**运行结果**
```bash
No match!!
search --> searchObj.group() :  dogs
```

### 实战
下面的整个代码流程为:
1. 载入json文件为列表posts
2. 使用compile方法组织匹配模式
3. 将posts里对应学历要求的帖子中的text字段里的值插入列表中
4. 导出json文件
```py
with open("weekly_hiring_comments.json", "r", encoding="utf-8") as f:
    posts = json.load(f)

bachelor_patterns = [
    r"本科及以上",
    r"本科以上",
]

master_patterns = [
    r"硕士及以上",
    r"硕士以上",
]
# 这里的r是为了禁用`\`转义符,但这里都是中文,不写也可以,为了规范所以加上了

bachelor_re = re.compile("|".join(bachelor_patterns))
master_re = re.compile("|".join(master_patterns))
# 拼接了两个匹配字符串

bachelor_posts = []
master_posts = []

for p in posts:
    # 这个p是列表的子元素,在这里为字典
    text = p.get("text", "")
    # get方法的第一个参数是,查找该字典中的对应字段并返回值,第二个参数是,若查找不到返回的默认值
    if master_re.search(text):
        master_posts.append(p)
    elif bachelor_re.search(text):
        bachelor_posts.append(p)

# === 输出目录 ===
out_dir = Path("degree_split")
out_dir.mkdir(exist_ok=True)

# === 写文件 ===
with open(out_dir / "本科及以上.json", "w", encoding="utf-8") as f:
    json.dump(bachelor_posts, f, ensure_ascii=False, indent=2)

with open(out_dir / "硕士及以上.json", "w", encoding="utf-8") as f:
    json.dump(master_posts, f, ensure_ascii=False, indent=2)

```

## dotenv库: 简单读取.env文件
对于密码,API密钥这些文件,用json文件存取不够方便也不够安全,因此我们有了.env文件,样式如下:
```toml
# github token
token="ghp_xxxxxxxxxxxx"
```
当我们想要读取这个.env文件中的token字段时,我们可以导入dotenv库和os库来进行简单的读取:
```py
from dotenv import load_dotenv
import os

load_dotenv()
TOKEN = os.getenv("token")
```
`load_dotenv()`函数会递归寻找.env文件并返回内容供os库读取,从而避免了写路径的麻烦.
## pydantic_settings库: 优雅处理.env文件
- [官方文档](https://pydantic.dev/docs/validation/latest/concepts/pydantic_settings/)

显然,上述的简单方法一点都不美观,而且会有以下问题:
1. 如果所请求的环境变量不存在如何处理?
2. 如果环境变量的格式错误怎么办?

因此,我们需要使用pydantic_settings库来用现代的类封装方式处理.env文件,但鉴于前面的pydantic库和pydantic_settings的基本功能没有任何区别,所以贴一个实战代码就可以快速了解了.

### 一个非常长的实战代码
- `Basesettings`: 对应了pydantic中的`BaseModel`,没有太多特殊的地方
- `SettingsConfigDict`: 对应了pydantic中的`ConfigDict`,只不过里面可以填写针对环境文件的各类要求.
- `# type: ignore[prop-decorator]`: 该注释针对mypy等类型检查库,防止报错
- 
```py
from pydantic import (
    AnyUrl,
    BeforeValidator,
    EmailStr,
    HttpUrl,
    PostgresDsn,
    computed_field,
    model_validator,
)
from pydantic_settings import BaseSettings, SettingsConfigDict
class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        # Use top level .env file (one level above ./backend/)
        env_file="../.env",
        env_ignore_empty=True,
        extra="ignore",
    )
    API_V1_STR: str = "/api/v1"
    SECRET_KEY: str = secrets.token_urlsafe(32)
    # 60 minutes * 24 hours * 8 days = 8 days
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 8
    FRONTEND_HOST: str = "http://localhost:5173"
    ENVIRONMENT: Literal["local", "staging", "production"] = "local"

    BACKEND_CORS_ORIGINS: Annotated[
        list[AnyUrl] | str, BeforeValidator(parse_cors)
    ] = []

    @computed_field  # type: ignore[prop-decorator]
    @property
    def all_cors_origins(self) -> list[str]:
        return [str(origin).rstrip("/") for origin in self.BACKEND_CORS_ORIGINS] + [
            self.FRONTEND_HOST
        ]

    PROJECT_NAME: str
    SENTRY_DSN: HttpUrl | None = None
    POSTGRES_SERVER: str
    POSTGRES_PORT: int = 5432
    POSTGRES_USER: str
    POSTGRES_PASSWORD: str = ""
    POSTGRES_DB: str = ""

    @computed_field  # type: ignore[prop-decorator]
    @property
    def SQLALCHEMY_DATABASE_URI(self) -> PostgresDsn:
        return PostgresDsn.build(
            scheme="postgresql+psycopg",
            username=self.POSTGRES_USER,
            password=self.POSTGRES_PASSWORD,
            host=self.POSTGRES_SERVER,
            port=self.POSTGRES_PORT,
            path=self.POSTGRES_DB,
        )

    SMTP_TLS: bool = True
    SMTP_SSL: bool = False
    SMTP_PORT: int = 587
    SMTP_HOST: str | None = None
    SMTP_USER: str | None = None
    SMTP_PASSWORD: str | None = None
    EMAILS_FROM_EMAIL: EmailStr | None = None
    EMAILS_FROM_NAME: str | None = None

    @model_validator(mode="after")
    def _set_default_emails_from(self) -> Self:
        if not self.EMAILS_FROM_NAME:
            self.EMAILS_FROM_NAME = self.PROJECT_NAME
        return self

    EMAIL_RESET_TOKEN_EXPIRE_HOURS: int = 48

    @computed_field  # type: ignore[prop-decorator]
    @property
    def emails_enabled(self) -> bool:
        return bool(self.SMTP_HOST and self.EMAILS_FROM_EMAIL)

    EMAIL_TEST_USER: EmailStr = "test@example.com"
    FIRST_SUPERUSER: EmailStr
    FIRST_SUPERUSER_PASSWORD: str

    def _check_default_secret(self, var_name: str, value: str | None) -> None:
        if value == "changethis":
            message = (
                f'The value of {var_name} is "changethis", '
                "for security, please change it, at least for deployments."
            )
            if self.ENVIRONMENT == "local":
                warnings.warn(message, stacklevel=1)
            else:
                raise ValueError(message)

    @model_validator(mode="after")
    def _enforce_non_default_secrets(self) -> Self:
        self._check_default_secret("SECRET_KEY", self.SECRET_KEY)
        self._check_default_secret("POSTGRES_PASSWORD", self.POSTGRES_PASSWORD)
        self._check_default_secret(
            "FIRST_SUPERUSER_PASSWORD", self.FIRST_SUPERUSER_PASSWORD
        )

        return self
```
# Python爬虫(待补充)
- 写的不好,日后有机会来重构

和机器学习一样,我第一次学习Python爬虫是没有任何成果的,一开始是听说有这么个东西,就去zlib上随便下了本参考书,由于参考书是十年前的,因此使用了很多老掉牙的库和奇奇怪怪的语法,再加上当时水平有限,根本无法复现,于是就浅尝辄止了.

但现在,我想要试着用爬虫找到合适的招聘数据用来为以后的暑期实习和秋招服务,所以又把这门技术捡起来从零开始学了.

- 参考文章: 官方文档以及菜鸟教程
## 爬虫概念
>[wiki](https://en.wikipedia.org/wiki/Web_crawler)
>
>Web crawler, sometimes called a spider or spiderbot and often shortened to crawler, is an Internet bot that systematically browses the World Wide Web and that is typically operated by **search engines** for the purpose of Web indexing (web spidering)
实际上,只要一个自动化程序做了下列的某一件事情,就可以认定为爬虫:
- 获取web资源
- 模拟浏览器/用户行为
- 批量获取数据

这几个操作基本涵盖了抢票脚本,pdf下载,训练数据爬取等一系列常见的爬虫情景.

最常见的爬虫无疑就是搜索引擎了,这些巨无霸爬虫不间断的访问数以千万计的网站,并给数据做好归类和索引.


## 爬虫历史
翻遍全网,我确实找不到一个能够好好讲讲从爬虫概念的诞生到最新爬虫框架应用的博客文章(难道谈这个是犯法吗!)

遗憾的是,我目前没有做这方面梳理的打算,等我真正闲下来再写吧,毕竟随便一想就知道这需要大量的检索和查证.

## Python爬虫工具时间线
- 04年: [BeautifulSoup](https://www.crummy.com/software/BeautifulSoup/bs4/doc/),绝对的老资历,爬虫入门书十本有十本会谈到它
- 08年: [Scrapy](https://docs.scrapy.org/en/latest/),工业级别的异步爬虫框架,也是推荐的爬虫入门库
- 08年: [Selenium](https://www.selenium.dev/documentation/),浏览器自动化鼻祖, 物理驱动 WebDriver 模拟真实用户操作
- 12年: [Requests](https://requests.readthedocs.io/en/latest/),物理简化 HTTP 请求逻辑
- 20年: [Playwright](https://github.com/microsoft/playwright),微软出品,物理支持多驱动与自动等待,现代爬虫框架

- 但我不打算按照时间顺序来,而是按照难易程度来讲解😊
## requests库学习
- [官方文档](https://requests.readthedocs.io/en/latest/)
  - 质量比较高,深入浅出
### 是什么,怎么用
>Requests is an **elegant and simple HTTP library** for Python, built for human beings.
- 官方的宣言非常简单明了

```py
import requests

r = requests.get('https://api.github.com/events')
r = requests.post('https://httpbin.org/post', data={'key': 'value'})
r = requests.put('https://httpbin.org/put', data={'key': 'value'})
r = requests.delete('https://httpbin.org/delete')
r = requests.head('https://httpbin.org/get')
r = requests.options('https://httpbin.org/get')
```
自然,当我们使用爬虫时,只需要使用get请求就足够了,因为一般来说你不需要去更新或者删除网页上的资源,而是获取网页资源.

### 给get请求带上参数
>If you were constructing the URL by hand, this data would be given as key/value pairs in the URL after a question mark, e.g. `httpbin.org/get?key=val`. Requests allows you to provide these arguments as a dictionary of strings, using the params keyword argument.
```py
payload = {'key1': 'value1', 'key2': 'value2'}
r = requests.get('https://httpbin.org/get', params=payload)
print(r.url)
# https://httpbin.org/get?key2=value2&key1=value1

# another file
payload = {'key1': 'value1', 'key2': ['value2', 'value3']}

r = requests.get('https://httpbin.org/get', params=payload)
print(r.url)
# https://httpbin.org/get?key1=value1&key2=value2&key2=value3
```
- 通过在对应地址后面加参数可以实现按页数/分类爬取
### 给get请求设置超时时限
```py
requests.get('https://github.com/', timeout=0.001)
```
当get请求用时超过timeout值时自动报错
### 定制头部(Headers)
>If you’d like to add HTTP headers to a request, simply pass in a **dict** to the headers parameter.

```py
url = 'https://api.github.com/some/endpoint'
headers = {'user-agent': 'my-app/0.0.1'}

r = requests.get(url, headers=headers)
```
### 处理get请求获取的内容
```py
import requests

r = requests.get('https://api.github.com/events')
# 我们可以以多种文本形式来处理这个r对象,requests库会自动帮我们返回所需的文本形式

r.text  # 纯文本形式   '[{"repository":{"open_issues":0,"url":"https://github.com/...

r.content  # 二进制形式  b'[{"repository":{"open_issues":0,"url":"https://github.com/...

r.json()   # json形式   [{'repository': {'open_issues': 0, 'url': 'https://github.com/...
```
#### 处理返回的状态码
```py
r = requests.get('https://httpbin.org/get')
r.status_code
# 200
```
- 状态码在判断是否正常爬取内容的时候非常重要
#### 处理返回的头部
```py
r.headers
# {
#     'content-encoding': 'gzip',
#     'transfer-encoding': 'chunked',
#     'connection': 'close',
#     'server': 'nginx/1.0.4',
#     'x-runtime': '148ms',
#     'etag': '"e1ca502697e5c9317743dc078f67693f"',
#     'content-type': 'application/json'
# }

# we can access the headers using any capitalization we want
r.headers['Content-Type']
'application/json'

r.headers.get('content-type')
'application/json'
```
### 实战
爬取仓库的issues
```py
SEARCH_URL="https://api.github.com/search/issues"
# 爬虫专用的GitHub api网址
HEADERS: dict = {
    "Authorization": f"token {TOKEN}", 
    "Accept": "application/vnd.github+json",
}
# 带有TOKEN认证的请求头部可以扩大爬虫的权限
# Accept字段表明希望获取json格式的数据
def fetch_issues(start, end):
    page = 1
    issues = []

    while True:
        r = requests.get(
            SEARCH_URL, 
            headers=HEADERS,
            params={
                "q": f"repo:ruanyf/weekly 谁在招人 created:{start}..{end}",
                # start..end 为时间范围筛选
                "per_page": 100,
                # 单次请求返回的数据条数,100为最大值
                "page": page,
                # 当前页码
                "sort": "created",
                # 按照创建时间排序
                "order": "asc",
                # asc-ascend(升序),另外有desc-descend(降序)
            },
        )

        data = r.json() 
        # 用json格式读取数据
        items = data.get("items", [])
        # 用get方法获取data的items键对应的列表,若不存在该键则返回空列表
        if not items:
            break
        # 若为空则说明全部爬取完了
        issues.extend(items)
        # 将新列表连接到issues列表的末尾
        page += 1
        # 爬取下一页
        time.sleep(1)
        # 等一秒再请求,避免被封
    return issues
    # 返回issues列表
```
items中元素的结构示例
```json
{
  "url": "https://api.github.com/repos/ruanyf/weekly/issues/737",
  "repository_url": "https://api.github.com/repos/ruanyf/weekly",
  "labels_url": "https://api.github.com/repos/ruanyf/weekly/issues/737/labels{/name}",
  "comments_url": "https://api.github.com/repos/ruanyf/weekly/issues/737/comments",
  "events_url": "https://api.github.com/repos/ruanyf/weekly/issues/737/events",
  "html_url": "https://github.com/ruanyf/weekly/issues/737",
  "id": 474420491,
  "node_id": "MDU6SXNzdWU0NzQ0MjA0OTE=",
  "number": 737,
  "title": "谁在招人？",
  "user": {
    "login": "hobo-tt",
    "id": 53465562,
    "node_id": "MDQ6VXNlcjUzNDY1NTYy",
    "avatar_url": "https://avatars.githubusercontent.com/u/53465562?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/hobo-tt",
    "html_url": "https://github.com/hobo-tt",
    "followers_url": "https://api.github.com/users/hobo-tt/followers",
    "following_url": "https://api.github.com/users/hobo-tt/following{/other_user}",
    "gists_url": "https://api.github.com/users/hobo-tt/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/hobo-tt/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/hobo-tt/subscriptions",
    "organizations_url": "https://api.github.com/users/hobo-tt/orgs",
    "repos_url": "https://api.github.com/users/hobo-tt/repos",
    "events_url": "https://api.github.com/users/hobo-tt/events{/privacy}",
    "received_events_url": "https://api.github.com/users/hobo-tt/received_events",
    "type": "User",
    "user_view_type": "public",
    "site_admin": false
  },
  "labels": [],
  "state": "closed",
  "locked": false,
  "assignees": [],
  "milestone": null,
  "comments": 0,
  "created_at": "2019-07-30T07:28:48Z",
  "updated_at": "2019-07-30T07:29:41Z",
  "closed_at": "2019-07-30T07:29:41Z",
  "assignee": null,
  "author_association": "NONE",
  "active_lock_reason": null,
  "sub_issues_summary": {
    "total": 0,
    "completed": 0,
    "percent_completed": 0
  },
  "issue_dependencies_summary": {
    "blocked_by": 0,
    "total_blocked_by": 0,
    "blocking": 0,
    "total_blocking": 0
  },
  "body": "北京国际音乐节文化传播有限公司\r\n地点：北京市朝阳区三间房南里4号院第96栋综合办公楼\r\n简历投递Email：[](url)yuanweitong@bmfbj.com\r\n\r\n### 前端工程师\r\n**岗位职责：**\r\n1、负责项目前端架构设计及研发工作；\r\n3、参与复杂业务系统技术选型，架构设计实现，新兴技术研究职责要求；\r\n4、负责前端界面的开发工作；\r\n5、根据产品和需求，依照当前技术架构进行前端开发；\r\n6、负责页面布局优化和调整。\r\n7、对接API数据、并可协调整体数据对接\r\n**任职条件：**\r\n1、本科及以上学历，三年以上web前端开发工作经验；\r\n2、精通HTML，CSS，了解W3C标准，能够熟练配合美工完成兼容主流浏览器的前端页面精通JavaScript，Ajax，DOM等前端技术，精通Vue前端框架；\r\n3、熟悉HTML5/CSS3de.js/Less/Scss等技术能持续优化前端页面的兼 容性和执行效率了解前端页面组件化；\r\n4、对单页WEB应用开发有极强的学习能力，对新技术有浓厚的研究兴趣；\r\n5、熟悉一门非JavaScript语言，如Java、Python、Ruby等\r\n6、熟悉小程序、VUE\r\n\r\n职位详情见[招聘网](https://www.lagou.com/jobs/6077252.html?source=pl&i=pl-1&show=b0079c35e8a042c49b24a6018cec2bac)",
  "reactions": {
    "url": "https://api.github.com/repos/ruanyf/weekly/issues/737/reactions",
    "total_count": 0,
    "+1": 0,
    "-1": 0,
    "laugh": 0,
    "hooray": 0,
    "confused": 0,
    "heart": 0,
    "rocket": 0,
    "eyes": 0
  },
  "timeline_url": "https://api.github.com/repos/ruanyf/weekly/issues/737/timeline",
  "performed_via_github_app": null,
  "state_reason": "completed",
  "pinned_comment": null,
  "score": 1.0
}
``` 
## bs4学习
- [官方文档](https://www.crummy.com/software/BeautifulSoup/)
  - 一般只用得上其中的一小部分功能,所以翻翻就好了

Beautiful Soup现在的版本为4.13.3,且第四版从12年就已经发布,故一般称为bs4.

**名字来源**
>It takes its name from the poem Beautiful Soup from *Alice's Adventures in Wonderland* and is a reference to the term "tag soup" meaning poorly-structured HTML code.

### 是什么,怎么用

bs4主要用于解析HTML和XML文档,但是它本身不负责解析,而是需要你配合解析库如"lxml"或者Python内置的html.parser来进行解析,但是你没有单独在文件里导入,只要虚拟环境中有这个lxml库就可以了
```py
from bs4 import BeautifulSoup
import requests
# 使用 requests 获取网页内容
url = 'https://cn.bing.com/' # 抓取bing搜索引擎的网页内容
response = requests.get(url)

# 使用 BeautifulSoup 解析网页
soup = BeautifulSoup(response.text, 'lxml')  # 使用 lxml 解析器
# 解析网页内容 html.parser 解析器
# soup = BeautifulSoup(response.text, 'html.parser')
```


### find与find_all
**基础用法**
```py
from bs4 import BeautifulSoup
import requests

# 指定你想要获取标题的网站
url = 'https://www.baidu.com/' # 抓取bing搜索引擎的网页内容

# 发送HTTP请求获取网页内容
response = requests.get(url)

soup = BeautifulSoup(response.text, 'lxml')

# 查找第一个 <a> 标签
first_link = soup.find('a')
print(first_link)
print("----------------------------")

# 获取第一个 <a> 标签的 href 属性
first_link_url = first_link.get('href')
print(first_link_url)
print("----------------------------")

# 查找所有 <a> 标签
all_links = soup.find_all('a')
print(all_links)


# 获取第一个 <p> 标签中的文本内容
paragraph_text = soup.find("p").get_text()

# 获取页面中所有文本内容
all_text = soup.get_text()
print(all_text)
```
**加入标签或属性**
```py
# 查找所有 class="example-class" 的 <div> 标签
divs_with_class = soup.find_all('div', class_='example-class')

# 查找具有 id="unique-id" 的 <p> 标签
unique_paragraph = soup.find('p', id='unique-id')
```


非常显然的是,bs4仅支持获取静态网页内容,在现在很多网页都是用js渲染的情况下不太实用了,但作为新手入门库还是很不错的,可以一下子感受到爬虫的威力,没有任何学习难度.

### bs4源码概览

>如果你闲的蛋疼,可以像我一样下载bs4的源码:
```bash
git clone https://git.launchpad.net/beautifulsoup
```

![示意图](image.png)
事实上,当我们翻阅源码时,会惊讶的发现这个有着20年悠久历史的Python库竟然只有这么一点文件!
- 而且还能看到**dammit.py**这么一个神奇的名字

## 小结
结合requests,bs4和文件处理库,我们现在基本可以爬取所有的静态网页资源,并在处理后进行存储了.
## Selenium学习

- [官方教程](https://www.selenium.dev/zh-cn/documentation/webdriver/getting_started/)
  - 非常遗憾的是,官方的文档写的很烂
- [geeksforgeeks](https://www.geeksforgeeks.org/Python/selenium-Python-tutorial/)
  - 翻来翻去能找到的唯一质量比较好的教程,反过来说明selenium本身的用户生态太差了

### 是什么,怎么用
>Selenium 通过使用 WebDriver 支持市场上所有主流浏览器的自动化。 WebDriver 是一个 API 和协议，它定义了一个语言中立的接口，用于控制 web 浏览器的行为。 每个浏览器都有一个特定的 WebDriver 实现，称为驱动程序。 驱动程序是负责委派给浏览器的组件，并处理与 Selenium 和浏览器之间的通信。

换句话说,没有WebDriver就用不了selenium,所以我们需要下载自己浏览器版本对应的驱动器.

当然,去官方慢慢翻驱动器版本还是太琐碎了,现在的selenium支持**自动下载**对应的驱动器,就没必要如过时的教程所说去配置驱动器的环境变量了.
```py
from selenium import webdriver

driver = webdriver.Chrome()
driver.get("https://www.google.com")
# 只写这三行代码也会自动下载对应的驱动器到本地缓存目录中
```
运行上方代码,我们成功用chrome打开了google网站
- 至于为什么会自动退出,是因为我们后面没有其他代码了,webdriver会自动关闭


如果你还是没明白selenium的用法的话,你可以想一下,如果有一个实验要你去找一百个人填问卷,你可以将问卷设定为允许多次填写,安排一些合理的选择题,就可以很轻松的用selenium模拟真实用户登录问卷星网站,用预先设定的随机值去逐个填写问卷,这样一下来,就算要填一千份你一个小时也能搞定了.
- 注意!这是严重的学术不端行为!请大家千万不要模仿!
#### 可能的vpn问题
我用的clash设定了系统代理,在终端配置了代理端口,还在bypass列表里设定了排除系统端口,但selenium还是会被拦截...

**~~我~~AI的解决方案**

```py
import os
os.environ["HTTP_PROXY"] = ""
os.environ["HTTPS_PROXY"] = ""
os.environ["no_proxy"] = "localhost,127.0.0.1"
# 在代码上方加上这个,但更推荐单独放入一个文件后再导入
```

### 基础用法一览
**进入网页并输入**
- 注意用chrome的话容易被拦截,反正我被拦截了
```py
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
import time

# Launch browser and open Google
drv = webdriver.Chrome()
drv.get("https://www.google.com//")

# Search "GeeksforGeeks"
box = drv.find_element(By.NAME, "q")
# 寻找第一个name="q"的元素,也就是搜索框
box.send_keys("GeeksforGeeks", Keys.RETURN)
# Keys.RETURN模拟回车键

# Wait and close browser
time.sleep(5)
drv.quit()
```
#### find_element与find_elements方法
该方法的第一个参数为要查找的属性名,第二个参数为属性值
```py
element = driver.find_element(By.ID, "passwd-id")
element = driver.find_element(By.NAME, "passwd")
element = driver.find_element(By.XPATH, "//input[@id='passwd-id']")

# If you need to find multiple elements, use:
elements = driver.find_elements(By.NAME, "passwd")
```
#### 模拟键盘交互
```py
# If you want to input text into a field, you can use:
element.send_keys("some text")
# You can also simulate pressing arrow keys or other keys using the Keys class:

element.send_keys(" and some", Keys.ARROW_DOWN)

# To clear the contents of a text field or textarea, use the clear method:

element.clear()
```
#### 实战
```py
# Import the necessary modules from Selenium
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys  # Added import for Keys
from selenium.webdriver.support.ui import WebDriverWait  # To wait for elements
from selenium.webdriver.support import (
    expected_conditions as EC,
)  # For expected conditions
import time


def test():
    # you can choose other browsers like Chrome, Firefox, etc.
    driver = webdriver.Edge()

    # Navigate to the GeeksforGeeks website
    driver.get("https://www.geeksforgeeks.org/")

    # Maximize the browser window
    driver.maximize_window()

    # Wait for 3 seconds to ensure the page is loaded
    time.sleep(3)

    # Handle iframe if one exists (e.g., an overlay)
    iframe_element = driver.find_element(
        By.XPATH, "//iframe[contains(@src,'accounts.google.com')]"
    )
    driver.switch_to.frame(iframe_element)

    # Close the overlay (e.g., Google sign-in iframe)
    closeele = driver.find_element(By.XPATH, "//*[@id='close']")
    closeele.click()

    # Wait for the iframe action to complete
    time.sleep(3)

    # Switch back to the main content
    driver.switch_to.default_content()

    # Locate the search icon element using XPath
    searchIcon = driver.find_element(By.XPATH, "//span[@class='flexR gs-toggle-icon']")

    # Wait for 3 seconds before interacting with the search input
    time.sleep(3)

    # Locate the input field for search text using XPath
    enterText = driver.find_element(By.XPATH, "//input[@class='gs-input']")

    # Enter the search query "Data Structure" into the input field
    enterText.send_keys("Data Structure")

    # Send the RETURN key to submit the search query
    enterText.send_keys(Keys.RETURN)
```

### 实战
```py
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import time
import random

wjx_url = ""
# wjx问卷网址


def generate_one_response():
    return {
        "div1": random.choice(["男", "女"]),
        "div2": random.choice(
            ["理工类", "文史哲类", "社会科学类（法学、管理学等）", "艺术类", "其他"]
        ),
        "div3": random.choice(["非常重要", "重要", "一般", "不重要"]),
        "div4": random.choice(
            ["深入学习过", "了解过部分内容", "听说过但不了解", "完全不了解"]
        ),
        "div5": random.choice(["是，应该加强", "不需要，当前已足够", "无所谓"]),
        "div6": random.choice(["总是", "经常", "偶尔", "很少"]),
        "div7": random.choice(
            [
                "先转发再说",
                "只分享来自官方渠道的信息",
                "自己查证后再决定是否转发",
                "看到也不管，不会转发",
            ]
        ),
        "div8": random.choice(["从不", "偶尔", "经常"]),
        "div9": random.choice(["从不", "偶尔", "经常"]),
        "div10": random.choice(["经常", "偶尔", "很少", "从不"]),
        "div11": random.choice(["是，经常", "偶尔", "有过一次", "没有遇到过"]),
        "div12": random.sample(
            [
                "网络暴力（如恶意攻击、辱骂）",
                "网络诈骗（如假兼职、中奖信息）",
                "虚假信息或网络谣言",
                "侵犯隐私（如曝光个人信息）",
                "不良言论或低俗内容",
                "网络沉迷（如过度使用短视频/游戏）",
            ],
            random.randint(2, 4),
        ),
    }


def fill_and_submit():
    # options.add_argument("--headless")  # 可取消注释用于无头运行
    driver = webdriver.Chrome()

    driver.get(wjx_url)
    time.sleep(2)

    # 点击“开始作答”按钮
    try:
        start_button = driver.find_element(By.CLASS_NAME, "startbtn")
        start_button.click()
        print("已点击开始作答按钮")
    except Exception as e:
        print("未找到开始按钮，可能已跳转页面")

    time.sleep(3)  # 等待问卷加载

    answers = generate_one_response()

    for div_id, value in answers.items():
        try:
            div = driver.find_element(By.ID, div_id)
            if isinstance(value, list):
                for val in value:
                    labels = div.find_elements(By.CLASS_NAME, "label")
                    for label in labels:
                        if val in label.text:
                            label.click()
                            break
            else:
                labels = div.find_elements(By.CLASS_NAME, "label")
                for label in labels:
                    if value in label.text:
                        label.click()
                        break
        except Exception as e:
            print(f"{div_id} 填写失败: {e}")

        time.sleep(0.3)

    # 点击提交按钮
    try:
        submit_btn = driver.find_element(By.ID, "ctlNext")
        submit_btn.click()
        print("问卷提交成功！")
    except Exception as e:
        print(f"提交失败: {e}")

    time.sleep(2)
    driver.quit()


fill_and_submit()
# 我们可以加上一个while循环...
```
- 整个代码并没有任何难懂的地方,只需要我们亲自去查html元素对应的名字就可以实现自动化答题了

## PlayWright学习
- [官方文档](https://playwright.dev/Python/docs/intro)
  - 看似内容很多,其实有用的东西很少...
### 是什么,怎么用
>Playwright was created specifically to accommodate the needs of end-to-end testing. Playwright **supports all modern rendering engines including Chromium, WebKit, and Firefox**. Test on Windows, Linux, and macOS, locally or on CI, headless or headed with native mobile emulation.

这段文字把playwright介绍为一个测试工具,乍一看与爬虫没有任何关系,但黑体部分不正是selenium支持的功能吗,那它自然也可以实现selenium的爬虫功能了.

playwright的历史并不很长,最开始是以js版本推出的,不知为何又引入到了Python里,并制作了两个Python库,一个是我们常用的playwright库,还有一个是pytest-playwright,试图取代常规的pytest库,并在官方文档里反复提及...,在我看来完全没有必要.

以下代码是一个playwright功能展示的简单示例,光是学习的话,我们可以使用自己电脑里的浏览器内核,不必像官网或者其他博客所说先运行`playwright install`命令,那会默认在**全局**安装多种浏览器内核,占用体积还不小😇.
- 由于playwright与selenium不同,不能在代码中默认安装,而是需要提前下载好驱动.因此在生产环境下还是得老老实实装的,当然也只要装自己所需的那一款内核就行了
```py
from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    browser = p.chromium.launch(
        executable_path="C:/Program Files/Google/Chrome/Application/chrome.exe",
        headless=True,
    )
    # 如果chrome.exe路径不对你就改成自己的路径
    page = browser.new_page()
    page.goto("https://playwright.dev")
    print(page.title())
    page.goto("https://google.com")
    print(page.title())
    browser.close()
```

### 基本语法
#### 同步/异步API
- [参考](https://devtest-notes.readthedocs.io/zh/latest/web/web-testing-with-playwright-introduction.html)
![示意图](PixPin_2026-04-03_21-42-39.webp)
看上图就知道playwright中有两个主要的模块:sync_api和async_api,分别对应着同步和异步的请求,我们先来看同步请求的用法:
```py
from playwright.sync_api import sync_playwright
def testcase1():
    print("testcase1 start")
    with sync_playwright() as p:
        browser = p.chromium.launch(
            executable_path="C:/Program Files/Google/Chrome/Application/chrome.exe",
            headless=False,
        )
        page = browser.new_page()
        page.goto("https://www.baidu.com/")
        print(page.title())
        page.fill("#chat-textarea", "test")
        # 文本框输入test
        page.click("#chat-submit-button")
        # 提交
        browser.close()
    print("testcase1 done")


def testcase2():
    print("testcase2 start")
    with sync_playwright() as p:
        browser2 = p.chromium.launch(
            executable_path="C:/Program Files/Google/Chrome/Application/chrome.exe",
            headless=False,
        )
        page2 = browser2.new_page()
        page2.goto("https://www.sogou.com/")
        print(page2.title())
        page2.fill('input[name="query"]', "test")
        page2.click("text=搜索")
        browser2.close()
    print("testcase2 done")
```
显然,同步的用法和selenium几乎没有差别,那我们再来看看异步:
```py
import asyncio
from playwright.async_api import async_playwright


async def testcase1():
    print("testcase1 start")
    async with async_playwright() as p:
        browser = await p.chromium.launch(
            executable_path="C:/Program Files/Google/Chrome/Application/chrome.exe",
            headless=False,
        )
        page = await browser.new_page()
        await page.goto("https://www.baidu.com/")
        print(await page.title())
        await page.fill("#chat-textarea", "test")
        # 文本框输入test
        await page.click("#chat-submit-button")
        # 提交
        await browser.close()
    print("testcase1 done")


async def testcase2():
    print("testcase2 start")
    async with async_playwright() as p:
        browser2 = await p.chromium.launch(
            executable_path="C:/Program Files/Google/Chrome/Application/chrome.exe",
            headless=False,
        )
        page2 = await browser2.new_page()
        await page2.goto("https://www.sogou.com/")
        print(await page2.title())
        await page2.fill('input[name="query"]', "test")
        await page2.click("text=搜索")
        await browser2.close()
    print("testcase2 done")


async def main():
    await testcase2()
    await testcase1()


if __name__ == "__main__":
    asyncio.run(main())
```
其实异步版本只是给关键的函数调用加上了异步的修饰而已,但这样就可以显著提升爬取速度了;而selenium并不支持异步爬取,因此逐渐被playwright取代.

## Scrapy学习

- [官方文档](https://docs.scrapy.org/en/latest/intro/overview.html#walk-through-of-an-example-spider)
  - 比较详尽

### 是什么,怎么用
scrapy是一个一体化爬虫框架,request的上位替代,支持异步处理和终端交互

**test.py**
```py
import scrapy


class QuotesSpider(scrapy.Spider):
    name = "quotes"
    start_urls = [
        "https://quotes.toscrape.com/tag/humor/",
    ]

    def parse(self, response):
        for quote in response.css("div.quote"):
            yield {
                "author": quote.xpath("span/small/text()").get(),
                "text": quote.css("span.text::text").get(),
            }

        next_page = response.css('li.next a::attr("href")').get()
        if next_page is not None:
            yield response.follow(next_page, self.parse)
```
运行方式:
`scrapy runspider test.py -o quotes.jsonl`
运行之后将得到这样这样的内容:
```jsonl
{"author": "Jane Austen", "text": "\u201cThe person, be it gentleman or lady, who has not pleasure in a good novel, must be intolerably stupid.\u201d"}
{"author": "Steve Martin", "text": "\u201cA day without sunshine is like, you know, night.\u201d"}
{"author": "Garrison Keillor", "text": "\u201cAnyone who thinks sitting in church can make you a Christian must also think that sitting in a garage can make you a car.\u201d"}
// ...
```
可以看出来,scrapy通过类来封装爬虫(这类似于pytest中对测试的封装),并且不需要我们再进行额外的库导入,而是在后台包办一切.

### scrapy命令行
虽然可以修改，但默认情况下所有 Scrapy 项目都具有相同的文件结构，类似于：
```txt
scrapy.cfg
tutorial/
    __init__.py
    items.py
    middlewares.py
    pipelines.py
    settings.py
    spiders/
        __init__.py
        spider1.py
        spider2.py
        ...
```

>scrapy.cfg 文件所在的目录被称为 *项目根目录*。该文件包含定义项目设置的 Python 模块名称。示例如下：

```toml
[settings]
default = tutorial.settings

[deploy]
project = tutorial
```

#### 创建和运行项目
```bash
scrapy startproject myproject [project_dir]
```
这将在当前目录下创建一个project_dir文件夹,里面有一个Scrapy 项目,名字为myproject.
- 如果未指定 project_dir，project_dir的名字将与 myproject 相同

#### 命令行参数一览
**全局命令**

- `startproject`: 创建项目
- `genspider`: 在当前项目的spiders文件夹中创建一个新爬虫文件
  - 示例: `uv run scrapy genspider hello_world www.bing.com`将在文件夹中创建hello_world.py文件.
- `settings`: 过
- `runspider`: 不创建项目直接运行Python文件中的独立爬虫
- `shell`: 过
- `fetch`: 使用scrapy下载器访问给定的网页
- `view`: 过
- `version`: 过

**仅限项目的命令**

- `crawl`: 运行某一个爬虫文件
- `check`: 自动化测试
- `list`: 列出该项目中可用的爬虫文件
- `edit`: 编辑某个爬虫文件
- `parse`: 过
- `bench`: 过

显然,大多数命令都没什么用,还是需要自己去写爬虫文件和测试.

### Spider类
**基本调用方法**
```py
import scrapy
class HelloWorldSpider(scrapy.Spider):
    name = "hello_world"
    allowed_domains = ["www.bing.com"]
    start_urls = ["https://www.bing.com"]

    def parse(self, response):
        pass
```

#### Spider源码剖析

```py
 """Base class that any spider must subclass.

    It provides a default :meth:`start` implementation that sends
    requests based on the :attr:`start_urls` class attribute and calls the
    :meth:`parse` method for each response.
    """
```
上述代码为Spider类的注释,也就是说这个类会自动调用start()方法并爬取目标网址后使用parse()方法解析.
让我们看看具体的实现:
```py
class Spider(object_ref):
# 三个默认参数
    name: str
    custom_settings: dict[_SettingsKey, Any] | None = None

    #: Start URLs. See :meth:`start`.
    start_urls: list[str]

# 实例化三个参数
    def __init__(self, name: str | None = None, **kwargs: Any):
        if name is not None:
            self.name: str = name
        elif not getattr(self, "name", None):
            raise ValueError(f"{type(self).__name__} must have a name")
        self.__dict__.update(kwargs)
        if not hasattr(self, "start_urls"):
            self.start_urls: list[str] = []
# 启用调试函数log
    @property
    def logger(self) -> SpiderLoggerAdapter:
        # circular import
        from scrapy.utils.log import SpiderLoggerAdapter  # noqa: PLC0415

        logger = logging.getLogger(self.name)
        return SpiderLoggerAdapter(logger, {"spider": self})

    def log(self, message: Any, level: int = logging.DEBUG, **kw: Any) -> None:

        self.logger.log(level, message, **kw)
# 初始化爬虫
    @classmethod
    def from_crawler(cls, crawler: Crawler, *args: Any, **kwargs: Any) -> Self:
        spider = cls(*args, **kwargs)
        spider._set_crawler(crawler)
        return spider

    def _set_crawler(self, crawler: Crawler) -> None:
        self.crawler: Crawler = crawler
        self.settings: BaseSettings = crawler.settings
        crawler.signals.connect(self.close, signals.spider_closed)
# 核心函数start,使用start_requests()函数
    async def start(self) -> AsyncIterator[Any]:

        with warnings.catch_warnings():
            warnings.filterwarnings(
                "ignore", category=ScrapyDeprecationWarning, module=r"^scrapy\.spiders$"
            )
            for item_or_request in self.start_requests():
                yield item_or_request
# 默认会使用start_urls变量进行爬取
    def start_requests(self) -> Iterable[Any]:
        warnings.warn(
            (
                "The Spider.start_requests() method is deprecated, use "
                "Spider.start() instead. If you are calling "
                "super().start_requests() from a Spider.start() override, "
                "iterate super().start() instead."
            ),
            ScrapyDeprecationWarning,
            stacklevel=2,
        )
        if not self.start_urls and hasattr(self, "start_url"):
            raise AttributeError(
                "Crawling could not start: 'start_urls' not found "
                "or empty (but found 'start_url' attribute instead, "
                "did you miss an 's'?)"
            )
# 这里的Request并非是request库
        for url in self.start_urls:
            yield Request(url, dont_filter=True)

    def _parse(self, response: Response, **kwargs: Any) -> Any:
        return self.parse(response, **kwargs)
# 省略其他部分代码
```

看了源码就可以知道,start,parse两个方法并不会自动调用,换句话说,使用scrapy命令行的时候,其内部是通过调用了这两个方法来进行爬取的.


# Python数据库框架
- 前置知识: 基本的SQL语法

## 前置概念: ORM与数据库连接
### ORM
- [wiki](https://en.wikipedia.org/wiki/Object%E2%80%93relational_mapping)

在实际生产中,我们总是需要在后端的数据库中存储用户的数据,一开始,我们需要使用SQL手动插入新数据,就算有各种各样的数据库优化,但操作起来还是很麻烦,不过,早期互联网的使用人数少,问题还不是太大.在2000s年代,ORM(对象关系映射)框架诞生了,它使得后端开发人员可以使用面向对象的语言(Java,C#等)来操作数据库.

### 数据库连接
当然,就像使用SQL前我们需要先打开数据库一样,使用ORM的前提是建立起与数据库的连接.现代的ORM框架会通过该语言的**数据库驱动**(如Java中的JDBC),与要**映射到的数据库**(SQLite,MySQL等数据库)进行连接,将我们的面向对象语言翻译成SQL语句,并通过网络通道发送给数据库,数据库执行SQL语句并存储结果.

## sqlite3
- [官网](https://docs.python.org/zh-cn/3/library/sqlite3.html)

由于是官方库,所以教程文档很枯燥,不过基本功能还是很简单的.由于太过古老,所以不太推荐学,最多会在那种AI生成的作业项目中看到.

## SQLAlchemy
- [官网教程](https://docs.sqlalchemy.org/en/20/orm/quickstart.html)
  - 对新人不太友好.
鉴于SQLModel是对SQLAlchemy的封装,并且面向对象上做的比SQLAlchemy更好,所以直接学SQLModel就行了.
## SQLModel
- [官网](https://sqlmodel.tiangolo.com/)

### 概览
>SQLModel is based on Python type annotations, and powered by Pydantic and SQLAlchemy
>
>SQLModel **can only help you with SQL Databases**.

如官网所说,SQLModel只支持关系型数据库,类似Redis和MongoDB这种非关系型数据库得专门去找其他的库来处理.


```py
from sqlmodel import Field, SQLModel, create_engine


class Hero(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str
    secret_name: str
    age: int | None = None


sqlite_file_name = "database.db"
sqlite_url = f"sqlite:///{sqlite_file_name}"

engine = create_engine(sqlite_url, echo=True)

SQLModel.metadata.create_all(engine)
```
上述代码有几点需要说明:
1. SQLModel类其实就是对Pydantic中的BaseModel的高层封装,加入了对SQLAlchemy的支持
   1. `table=True`表示这是一个关系表,可以与数据库进行交互,而默认值`table=False`表示这只是一个普通的`BaseModel`,用于数据校验.
2. Hero中的字段基本都是Pydantic的原生语法,Field方法也是对Pydantic的封装,加入了对SQLAlchemy的抽象支持
3. `sqlite_url`即为SQLModel的目标连接数据库,由于sqlite的连接最简单,所以官方教程给的也是sqlite.

`"sqlite:///{sqlite_file_name}"`的详细解释:
>我们可以拿HTTP协议来做对比: `https://sqlmodel.tiangolo.com/`中,`https://`表示采用了HTTPS协议,之后紧跟着的是该网站的域名,最后一个`/`则代表该网站的根路径`/`.
>
>同理,`sqlite:///{sqlite_file_name}`中的第一部分是表示所连接的服务器,供底层驱动选择对应的服务器;
>而由于SQLite是一个无服务器的本地数据库,不需要IP地址来识别,那么就不再需要中间的域名,但是`/`根路径还是需要保留,代表连接的是当前文件夹下的sqlite数据库,也就是`sqlite:// /database.db`,去掉无意义的空格后就变成了`sqlite:///database.db`.

如果拿其他的数据库来举例,其实更好理解,比如说连接的是PostgreSQL数据库,我们就要这么写:
```py
# 1. 使用新一代 psycopg 驱动（即 psycopg3，原生支持异步）
pg_url = "postgresql+psycopg://postgres:password123@127.0.0.1:5432/my_database"
```
尽管看上去与之前的sqlite写法完全不同,但大致结构是相同的,目前先不用管它了.

- 要进一步了解的话可以看[这个](https://docs.sqlalchemy.org/en/14/core/engines.html).

4. `create_engine`函数根据`sqlite_url`创建了一个引擎,这个引擎负责与数据库进行连接.
   1. `echo=True`表示会打印所以执行的SQL语句,用于调试.
5. `SQLModel.metadata.create_all(engine)`,最后一行代码需要好好解释:
   1. 当我们创建了`table=True`的SQLModel时,它会自动注册在SQLModel的metadata对象中
   2. 这个metadata对象有一个create_all方法,会根据数据库的地址和注册了的SQLModel类,自动创建数据库并填充表进去

6. 如果不指定表名的话,SQLModel会将类名转换为小写格式后存入数据库,也就是`hero`

如果你还记得一点SQL知识的话,就会知道在数据库中主键是**非空的**!但是上面的代码却将id这个主键的默认值设定为了None,这是为什么呢?

>SQLModel会在数据保存的时候,自动按顺序设定主键,所以我们不要手动填写值,但是如果不填默认值的话,在填入数据的时候还要加上`id=None`这样的参数,这显然很麻烦,所以我们会直接给主键填上默认值`None`
### CRUD操作
#### 插入新行
```py

def create_heroes():
    hero_1 = Hero(name="Deadpond", secret_name="Dive Wilson")
    hero_2 = Hero(name="Spider-Boy", secret_name="Pedro Parqueador")
    hero_3 = Hero(name="Rusty-Man", secret_name="Tommy Sharp", age=48)

    with Session(engine) as session:
        session.add(hero_1)
        session.add(hero_2)
        session.add(hero_3)

        session.commit()
```
首先我们创建了用Hero类创建了三个实例,并通过`with`关键字打开了与数据库之间的连接(session),通过add方法添加这三个实例后,通过commit方法提交更改,大功告成!

- Session类接收当前创建的引擎实例作为参数
- 向数据库提交更改的方式非常类似Git中的操作.

用VScode的SQLITE VIEWER插件打开创建的数据库,发现确实成功插入了:
![示意图](PixPin_2026-05-22_13-06-28.webp)

如果我们再运行一遍代码,可以看到会重复插入数据,这也告诉我们不要在多个地方进行数据操作,否则很容易出问题:
![示意图](PixPin_2026-05-22_13-07-35.webp)

#### 读取数据
**只使用select**
```py
from sqlmodel import Field, Session, SQLModel, create_engine, select

class Hero(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str
    secret_name: str
    age: int | None = None

# 省略一大段代码

def select_heroes():
    with Session(engine) as session:
        statement = select(Hero)
        results = session.exec(statement)
        for hero in results:
            print(hero)

# id=1 name='Deadpond' age=None secret_name='Dive Wilson'
# id=2 name='Spider-Boy' age=None secret_name='Pedro Parqueador'
# id=3 name='Rusty-Man' age=48 secret_name='Tommy Sharp'
```
在读取数据前,我们同样需要打开与数据库的连接,但这次我们只需要写一个查询语句即可,然后通过exec方法执行查询,并得到返回结果.

需要注意的是,results的类型相当复杂:
![示意图](PixPin_2026-05-22_14-19-52.webp)

我们没必要去管它的内部是怎么实现的,一般来说我们用以下几种方法处理exec得到的数据:
1. 直接用`for ... in results`遍历,这会返回其中的每一行数据
2. 使用results.all()一次获取所有行的数据
3. 使用results.first()获取第一行数据,或者使用results.one()获取第一行非空数据

只有select的SQL是不完整的,SQLModel还支持在select的基础上进行各种各样的过滤:
1. where方法:
```py
def select_heroes():
    with Session(engine) as session:
        statement = select(Hero).where(Hero.name != "Deadpond")
        results = session.exec(statement)
        for hero in results:
            print(hero)
```
2. limit方法,只获取特定的前几个结果:
```py
def select_heroes():
    with Session(engine) as session:
        statement = select(Hero).limit(3)
        results = session.exec(statement)
        heroes = results.all()
        print(heroes)
```
3. offset方法,跳过特定的前几个结果:
```py
def select_heroes():
    with Session(engine) as session:
        statement = select(Hero).offset(3).limit(3)
        results = session.exec(statement)
        heroes = results.all()
        print(heroes)
```

##### col方法
你的编辑器在使用这些比较时可能会给你一个错误，例如
```py
Hero.age > 35
```
这将是一个错误，告诉你:
>Hero.age 可能为 None，你不能将 None 与 > 进行比较

当我们使用这些特殊的类属性在 .where() 中时，在程序执行期间，特殊的类属性会知道该比较仅适用于数据库中非 NULL 的值，并且它将正确工作。

但编辑器不知道它是一个特殊的类属性，所以它试图帮助我们防止错误（在这种情况下是误报）。

为此，我们可以导入 col()（“column”的缩写）
```py
def select_heroes():
    with Session(engine) as session:
        statement = select(Hero).where(col(Hero.age) >= 35)
        results = session.exec(statement)
        for hero in results:
            print(hero)
```
这样，编辑器就知道这段代码实际上是正确的，因为这是一个特殊的 SQLModel 列。
##### get方法
有时候我们会通过主键的id直接选择到某一行,这时候就可以用get方法:
```py
def select_heroes():
    with Session(engine) as session:
        hero = session.get(Hero, 1)
        print("Hero:", hero)
```
这在用户验证时相当有用.
#### 更新数据
```py
def update_heroes():
    with Session(engine) as session:
        statement = select(Hero).where(Hero.name == "Spider-Boy")
        results = session.exec(statement)
        hero = results.one()
        print("Hero:", hero)

        hero.age = 16
        session.add(hero)
        session.commit()
        session.refresh(hero)
```
更新数据的步骤如下:
1. 选取要更改的数据
2. 直接修改对应的属性
3. 提交更改

#### 删除数据
```py
def delete_heroes():
    with Session(engine) as session:
        statement = select(Hero).where(Hero.name == "Spider-Youngster")
        results = session.exec(statement)
        hero = results.one()
        print("Hero: ", hero)

        session.delete(hero)
        session.commit()
```
删除数据的步骤如下:
1. 选取要删除的数据
2. 运用delete函数删除该行
3. 提交更改
#### 刷新数据
在更改数据后,如果我们想立刻看到数据的更改,就需要用到session.refresh函数:
```py
# 1. 你创建了一个新用户，此时你只给内存传了名字
new_user = User(name="张三") 
session.add(new_user)
session.commit() # 提交到了数据库

# 2. 此时如果你打印 id，可能会是 None 或者旧值
print(new_user.id) 

# 3. 刷新一下，强迫程序去数据库把数据库刚生成的 id 拿回来
session.refresh(new_user) 

# 4. 现在能正确拿到数据库生成的 id 了（比如 1）
print(new_user.id)
```
#### 创建索引
在SQLModel中创建索引相当简单:
```py
from sqlmodel import Field, Session, SQLModel, create_engine, select


class Hero(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str = Field(index=True)
    secret_name: str
    age: int | None = Field(default=None, index=True)
```
只要这样就行了,我们不用做任何额外的工作,数据库在用到该索引时会自动进行优化,我们不用考虑任何事情.

- 当然只为关键列创建索引就够了,否则会浪费数据库的内存.
### 进阶操作
#### 使用UUID作为主键
- [官网文档](https://docs.pythonlang.cn/3/library/uuid.html)
- [wiki](https://en.wikipedia.org/wiki/Universally_unique_identifier)

UUID由128位数字组成,两个UUID相同的可能性几乎为零.由于UUID是系统随机生成的,将UUID作为主键不会向用户暴露数据库中的任何额外信息.

为了在SQLModel中使用uuid,我们需要导入系统库uuid和sqlmodel中的工具库:
```py
import uuid

from sqlmodel import Field, Session, SQLModel, create_engine, select

class Hero(SQLModel, table=True):
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    name: str = Field(index=True)
    secret_name: str
    age: int | None = Field(default=None, index=True)
```
`default_factory`参数接收一个函数,这个函数将在实例创建时给被修饰的属性赋予初始值,也就是说,在数据发送到数据库之前我们就已经为数据生成id了.

之后就可以忽略这个属性的存在了,我们可以跟平常一样从数据库中获取特定uuid对应的数据.

#### 多表关联
>如同数据库中经常要用到外键引用外表一样,我们在SQLModel中也可以直接实现多个表的关联.
##### 引用外键
```py
class Team(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str = Field(index=True)
    headquarters: str


class Hero(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str = Field(index=True)
    secret_name: str
    age: int | None = Field(default=None, index=True)

    team_id: int | None = Field(default=None, foreign_key="team.id")
```
之后我们就可以在创建新行时指定Hero所属的team:
```py

def create_heroes():
    with Session(engine) as session:
        team_preventers = Team(name="Preventers", headquarters="Sharp Tower")
        team_z_force = Team(name="Z-Force", headquarters="Sister Margaret's Bar")
        session.add(team_preventers)
        session.add(team_z_force)
        session.commit()

        hero_deadpond = Hero(
            name="Deadpond", secret_name="Dive Wilson", team_id=team_z_force.id
        )
        hero_rusty_man = Hero(
            name="Rusty-Man",
            secret_name="Tommy Sharp",
            age=48,
            team_id=team_preventers.id,
        )
        hero_spider_boy = Hero(name="Spider-Boy", secret_name="Pedro Parqueador")
        session.add(hero_deadpond)
        session.add(hero_rusty_man)
        session.add(hero_spider_boy)
        session.commit()

        session.refresh(hero_deadpond)
        session.refresh(hero_rusty_man)
        session.refresh(hero_spider_boy)

        print("Created hero:", hero_deadpond)
        print("Created hero:", hero_rusty_man)
        print("Created hero:", hero_spider_boy)
```
##### 读取多个表
SQLModel支持选取多个表:
```py
def select_heroes():
    with Session(engine) as session:
        statement = select(Hero, Team).where(Hero.team_id == Team.id)
        results = session.exec(statement)
        for hero, team in results:
            print("Hero:", hero, "Team:", team)
```
更好的方法是使用join:
```py
def select_heroes():
    with Session(engine) as session:
        statement = select(Hero, Team).join(Team)
        results = session.exec(statement)
        for hero, team in results:
            print("Hero:", hero, "Team:", team)
```
- `select(Hero, Team).join(Team)`可能比较难看懂,SQLModel会自动识别出Team是要`join`的表,而Hero是`from`对应的原表.

SQLModel甚至还支持`left outer join`这种比较高级的SQL语法:
```py
def select_heroes():
    with Session(engine) as session:
        statement = select(Hero, Team).join(Team, isouter=True)
        results = session.exec(statement)
        for hero, team in results:
            print("Hero:", hero, "Team:", team)
```
- 我们只需要在join方法中加上`isouter`字段就行了,如果要实现`right outer join`,把Hero放进join方法中替换即可.

#### 关系属性
SQLModel中还支持设置关系属性:
```py
from sqlmodel import Field, Relationship, Session, SQLModel

class Team(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str = Field(index=True)
    headquarters: str

    heroes: list["Hero"] = Relationship(back_populates="team")


class Hero(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str = Field(index=True)
    secret_name: str
    age: int | None = Field(default=None, index=True)

    team_id: int | None = Field(default=None, foreign_key="team.id")
    team: Team | None = Relationship(back_populates="heroes")
```
- 可以看到,这是一个一对多关系

上述的关系属性声明可以帮助我们简化查询,这两段代码是等价的:
```py
def select_heroes():
    with Session(engine) as session:
        statement = select(Hero).where(Hero.name == "Spider-Boy")
        result = session.exec(statement)
        hero_spider_boy = result.one()

# Code here omitted 👈

        print("Spider-Boy's team again:", hero_spider_boy.team)
```

而`back_populates`属性的作用是将两个关系属性连接起来,只要有一边发生变化了,另一边同时也会变化并进行相应的数据库修改.

##### 级联删除
![示意图](PixPin_2026-05-23_17-16-58.webp)
如图所示,当删除某个角色时,我们希望相关的表也自动删除,这就需要用到`cascade_delete`参数,我们应该也只能把这个属性用在被关联的,没有外键的模型上:
```py
class Team(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str = Field(index=True)
    headquarters: str

    heroes: list["Hero"] = Relationship(back_populates="team", cascade_delete=True)

class Hero(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str = Field(index=True)
    secret_name: str
    age: int | None = Field(default=None, index=True)

    team_id: int | None = Field(default=None, foreign_key="team.id")
    team: Team | None = Relationship(back_populates="heroes")
```
#### 多对多关系(待补充)
### 总结
整体来看,SQLModel是个非常优秀的ORM框架,没有什么学习负担,基本概念都很简单,非常适合用来学习后端与数据库的交互.
## Alembic
- [中文文档](https://hellowac.github.io/alembic-doc-zh)
>单纯使用ORM框架的话很难实现数据库的迁移和安全的CRUD,这个时候我们就可以用到alembic库.

### 基本用法
1. 导入alembic:
```bash
uv add alembic
uv run alembic init (希望的文件夹名)
```
- 文件夹名可以随便填,一般推荐填写为alembic让它的语义更清晰

2. 根目录下会出现`alembic.ini`文件和alembic文件夹,我们可以将`alembic`文件夹放在任何文件夹下,只需要修改`alembic.ini`文件中的`script_location`参数即可
   1. 例如: `script_location = app/alembic`表示alembic脚本在根目录下的app/alembic中.

3. 修改alembic文件夹中的env.py,只用导入自己创建的sqlalchemy/sqlmodel表即可:


原内容:
```py
# add your model's MetaData object here
# for 'autogenerate' support
# from myapp import mymodel
# target_metadata = mymodel.Base.metadata
target_metadata = None
```
修改后:
```py
from app.models import SQLModel 
# 由于from语句会实际扫描并执行文件中的所有内容,所以models文件中的表其实就全部导入了.
from app.core.config import settings 

target_metadata = SQLModel.metadata
```

4. 最后一步,指定数据库的位置,有两种写法,第一种是直接在`alembic.ini`中写明:

```ini
# database URL.  This is consumed by the user-maintained env.py script only.
# other means of configuring database URLs may be customized within the env.py
# file.
sqlalchemy.url = driver://user:pass@localhost/dbname
```
这个配置文件会被`env.py`读取并自动处理:
```py
def run_migrations_offline() -> None:
    """Run migrations in 'offline' mode.

    This configures the context with just a URL
    and not an Engine, though an Engine is acceptable
    here as well.  By skipping the Engine creation
    we don't even need a DBAPI to be available.

    Calls to context.execute() here emit the given string to the
    script output.

    """
    url = config.get_main_option("sqlalchemy.url")
    context.configure(
        url=url,
        target_metadata=target_metadata,
        literal_binds=True,
        dialect_opts={"paramstyle": "named"},
    )

    with context.begin_transaction():
        context.run_migrations()


def run_migrations_online() -> None:
    """Run migrations in 'online' mode.

    In this scenario we need to create an Engine
    and associate a connection with the context.

    """
    connectable = engine_from_config(
        config.get_section(config.config_ini_section, {}),
        prefix="sqlalchemy.",
        poolclass=pool.NullPool,
    )

    with connectable.connect() as connection:
        context.configure(
            connection=connection, target_metadata=target_metadata
        )

        with context.begin_transaction():
            context.run_migrations()


if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()
```

第二种方法是修改env.py,自动读取setting.py中配置的url,这种方法更加推荐,避免要在多个地方同时修改环境变量,fastapi模板项目中是这么做的:

```py
from app.core.config import settings

def get_url():
    return str(settings.SQLALCHEMY_DATABASE_URI)


def run_migrations_offline():

    url = get_url()
    context.configure(
        url=url, target_metadata=target_metadata, literal_binds=True, compare_type=True
    )

    with context.begin_transaction():
        context.run_migrations()


def run_migrations_online():

    configuration = config.get_section(config.config_ini_section)
    configuration["sqlalchemy.url"] = get_url()
    connectable = engine_from_config(
        configuration,
        prefix="sqlalchemy.",
        poolclass=pool.NullPool,
    )

    with connectable.connect() as connection:
        context.configure(
            connection=connection, target_metadata=target_metadata, compare_type=True
        )

        with context.begin_transaction():
            context.run_migrations()


if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()

```
上述代码直接修改了两个函数的默认内容,将url的读取局限在python文件之间,显然更加规范一点.

# Python网络框架
- 前置知识: Restful Web API规范,基本的网络通信概念,初级的网络安全/身份认证概念.

>尽管大家都说Python无法很好的处理高并发,但在绝大多数网络通信环境下,它都比其他语言好用的多


## 前置概念: WSGI与ASGI
- [ASGI doc](https://asgi.readthedocs.io/en/latest/specs/main.html#overview)
- [wiki](https://en.wikipedia.org/wiki/Web_Server_Gateway_Interface)

### WSGI详解
WSGI的全称为**Web Server Gateway Interface**,是Python官方提出的Python后端通信接口约定,换句话说,它与**Restful Web API**一样,是一个社区普遍遵循的规范,而不是一个具体到代码怎么写的条例.

>PEP 333:
>
>Python 目前拥有种类繁多的 Web 应用框架，例如 Zope、Quixote、Webware、SkunkWeb、PSO 和 Twisted Web 等等。如此之多的选择对 Python 新手来说可能是一个问题，因为一般来说，他们选择的 Web 框架会限制他们可用的 Web 服务器的选择，反之亦然……相比之下，尽管 Java 也拥有同样多的 Web 应用框架，但 Java 的“Servlet”API 使得使用任何 Java Web 应用框架编写的应用程序都可以在任何支持 Servlet API 的 Web 服务器上运行。

>WSGI **does not specify** how the Python interpreter should be started, nor how the application object should be loaded or configured, and **different frameworks and webservers achieve this in different ways**.

#### WSGI结构
WSGI由两部分组成:
1. 服务器/网关: 例如nignx/Apache等反向代理服务器
2. Python应用程序: 如fastapi/flask等Python框架

在服务器和应用程序之间,还可以加入WSGI中间件(middleware),它同样也是一个Python应用程序,具有以下功能:
1. 将不同的请求导向对应的URL路径
2. 均衡负载
3. 加工处理网络请求的内容

#### 简单示例
```py
import time

# ==========================================
# 1. WSGI 应用程序 (Application)
# 核心逻辑：接收 environ 字典，返回迭代器
# ==========================================
def simple_app(environ, start_response):
    """一个符合 PEP 3333 规范的原始 WSGI 应用"""
    status = '200 OK'
    # 响应头必须是包含元组的列表
    headers = [('Content-Type', 'text/plain; charset=utf-8')]
    
    start_response(status, headers)
    
    # 路径分发逻辑
    path = environ.get('PATH_INFO', '/')
    response_body = f"Hello WSGI! You requested: {path}\n"
    
    # 必须返回字节流的可迭代对象
    return [response_body.encode('utf-8')]


# ==========================================
# 2. WSGI 中间件 (Middleware)
# 核心逻辑：同时扮演 Server 和 App 的角色
# 它拦截请求，处理后传递给下游 App
# ==========================================
class ExecutionTimeMiddleware:
    """计算响应耗时的中间件"""
    def __init__(self, app):
        self.app = app

    def __call__(self, environ, start_response):
        start_tick = time.time()
        
        # 包装原有的 start_response 来获取执行时机
        def wrapped_start_response(status, headers, exc_info=None):
            duration = time.time() - start_tick
            headers.append(('X-Execution-Time', f"{duration:.4f}s"))
            return start_response(status, headers, exc_info)

        # 调用下游应用
        return self.app(environ, wrapped_start_response)


# ==========================================
# 3. 运行环境配置 (Infrastructure)
# 结构：Gunicorn(WSGI Server) -> Middleware -> App
# ==========================================

# 组装中间件链
app = ExecutionTimeMiddleware(simple_app)

"""
4. 反向代理 (Reverse Proxy) 配置示例 (Nginx)
物理机制：Nginx 并不直接运行 Python 代码，它通过 TCP/Unix Socket 将请求转发给 WSGI Server。



nginx.conf 片段:
server {
    listen 80;
    server_name example.com;

    location / {
        # 转发请求给 Gunicorn 绑定的端口
        proxy_pass http://127.0.0.1:8000;
        
        # 传递原始请求信息，WSGI 服务器会将这些填入 environ 字典
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
"""

# 5. 如何启动 (以 Gunicorn 为例)
# 在终端执行: gunicorn -w 4 module_name:app
```

### ASGI详解
ASGI的全称为**Asynchronous Server Gateway Interface**,在WSGI的基础上加入了对异步的支持.ASGI协议的最新版本为3.0,于2019年修订.
#### 为什么要引入ASGI
>The WSGI specification has worked well since it was introduced, and allowed for great flexibility in Python framework and web server choice. However, **its design is irrevocably tied to the HTTP-style request/response cycle**, and more and more protocols that do not follow this pattern are becoming a standard part of web programming (most notably, WebSocket).

### 总结
至于为什么要谈及这两个规范,是因为接下来我们要谈到的两个库: flask和fastapi,分别遵循了WSGI规范和ASGI规范,从而对这两个库会有更好的初步理解.

## Flask
- [官方中文文档](https://flask.palletsprojects.com/zh-cn/stable/quickstart/)
### 概览
flask是一个轻量的wsgi网络框架,于2004年推出,鉴于语法简单,扩展容易,被广泛用在早期的python通信项目中.

**一个最小的flask程序**
```py
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"
```
如果是用uv管理的话,将这个文件命名为`app.py`,使用`uv add flask`后运行`uv run flask run`即可访问`Hello,World`网页.

1. flask框架使用类似**Flask(__name__)**的语法来初始化,帮助flask定位其他文件的位置
2. 我们能够像写jsx一样在函数内部传入html元素,并简单的通过语法糖来实现不同路由的网页展示.
3. 要想定制不同网页的话,加上路由就可以了:
```py
from flask import url_for

@app.route('/')
def index():
    return 'index'

@app.route('/login')
def login():
    return 'login'

@app.route('/user/<username>')
def profile(username):
    return f'{username}\'s profile'
```

### 使用不同的http请求方法
有两种写法,一种是通过methods属性指明,不写则默认支持GET方法:
```py
from flask import request

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        return do_the_login()
    else:
        return show_the_login_form()
```
另一种是直接写明,把route换成请求方法:
```py
@app.get('/login')
def login_get():
    return show_the_login_form()

@app.post('/login')
def login_post():
    return do_the_login()
```
### 总结
鉴于flask不支持异步,所以没必要了解太深,到这种程度就可以了.
## Uvicorn
- [官方文档](https://uvicorn.dev/)
### 概览
uvicorn可以看作是一个asgi框架的启动器,是python异步框架的底层.

一个简单的代码如下:
```py
async def app(scope, receive, send):
    assert scope['type'] == 'http'

    await send({
        'type': 'http.response.start',
        'status': 200,
        'headers': [
            (b'content-type', b'text/plain'),
            (b'content-length', b'13'),
        ],
    })
    await send({
        'type': 'http.response.body',
        'body': b'Hello, world!',
    })
```
如果使用uv的话,命名为main.py后,运行`uv run uvicorn main:app`即可以出现这个页面:
![示意图](PixPin_2026-05-13_14-12-28.webp)

- main表示找到main.py文件,app表示main里面的app函数,也就是说uvicorn会自动启动一个叫做app的异步函数作为服务器.

1. `scope` - A dictionary containing information about the incoming connection.
2. `receive` - A channel on which to receive incoming messages from the server.
3. `send` - A channel on which to send outgoing messages to the server.

### 用法
我们不太有必要深入了解uvicorn在背后做了什么,只需要知道它是一个启动器,可以直接在后端项目中启动服务器就行了.

很多AI课程作业都是靠它糊弄过来的:
```py
import uvicorn

if __name__ == "__main__":
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)
```

直接写在代码中还是不够合理,每次修改端口或者域名时都要重新进入代码修改,生产环境中最好放到dockerfile中一并运行,例如:
```dockerfile
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "1"]
```

`-- workers`表示启动的服务器进程数.


### 总结
上面一共出现了三种uvicorn的用法,一个是定制异步项目后使用uvicorn启动服务器,一个是导入uvicorn库后用代码启动服务器,一个是使用docker命令行来用uvicorn启动服务器,我们根据需要选择要用的方法即可.

## Starlette
### 概览
- [官方文档](https://starlette.dev/)

Starlette是一个轻量的asgi框架,也是fastapi框架的基石,很多fastapi的功能都是对starlette库的封装.

**官方示例**
```py
# main.py
from starlette.applications import Starlette
from starlette.responses import JSONResponse
from starlette.routing import Route


async def homepage(request):
    return JSONResponse({'hello': 'world'})


app = Starlette(debug=True, routes=[
    Route('/', homepage),
])
```
使用uvicorn即可运行:
```bash
uvicorn main:app
```

一般来说有了这个框架不就挺好的吗,为什么fastapi还要重新造轮子呢,因为starlette框架没能继承flask框架的优秀语法糖语法,用起来有一定的难度,也不够清晰.因此我们没必要深入学习,直接跳进fastapi即可.
## Fastapi
### 概览
fastapi是上述这些通信框架的集大成者,它糅合了无数前人的心血,让python这种通常被视为"运行速度慢"的语言实现了质的飞跃.

鉴于机器学习/Agent项目都使用python语言进行开发,该类项目的部署使用原生的python也更为合理,在未来一定会有非常广阔的应用情景.

从fastapi的star数就可以看出来它有多受欢迎:

![star数](PixPin_2026-05-14_16-24-14.webp)

大厂比如字节对于这方面的人才需求目前还很少:

![招聘官网](PixPin_2026-05-14_16-33-46.webp)

fastapi官方有一个非常优秀的[模板项目](https://github.com/fastapi/full-stack-fastapi-template),截止目前(26/5/14)已经有了43k个star,说明还是很受欢迎的,前端使用最新的react框架,后端则使用了fastapi框架进行后端服务和sqlmodel进行ORM映射,采用了docker compose进行微服务部署.速览一遍这个项目你可以很快发现fastapi的魅力和强大.

当然,要看懂这个项目,你需要懂这些技术:

![技术一览](PixPin_2026-05-14_18-19-49.webp)

这些技术显然不是一个小白可以轻松在短时间内掌握的,即便是Claude Code也不能架构出这么完美的代码,这种精品的前后端项目在Github上也是非常稀少的,非常推荐跟着这个项目的技术栈学习.

- 鉴于fastapi的[官方教程](https://fastapi.tiangolo.com/)结构比较混乱,有很多不必要的内容,所以我对教程进行了大规模的重构,但还是推荐优先阅读官方文档而非我的二手总结.


由于fastapi是asgi框架,那么在使用时自然要加上async/await异步修饰符,一个非常简单的代码如下:
```py
from fastapi import FastAPI

app = FastAPI()


@app.get("/items/{item_id}")
async def read_item(item_id):
    return {"item_id": item_id}
```

1. fastapi继承了flask中`app = Flask(__name__)`的写法,并进行了优化,将`__name__`除去了,看上去更顺眼了
2. 请求沿袭了flask的写法,将请求方法和请求路由都写在语法糖里,相当直观
3. 与flask最大的区别就是多了一个async修饰,表明这是一个异步函数.

好了,接下来开始正式学习fastapi.
### ch1: 使用fastapi响应普通的网络请求
#### 一个非常长的前提(如果对前端很了解的话可以直接跳过)
为了更好的理解前后端通信的过程,我推荐自己写一个或者拿AI写一个网页,通过这个页面来访问fastapi端口,而非直接通过命令行触发默认的前端页面,可以有一个更好的学习效果.

比如我拿AI生成了一个网页代码:
```html
<!doctype html>
<html lang="zh">
  <head>
    <meta charset="UTF-8" />
    <title>FastAPI Test</title>
  </head>
  <body>
    <button onclick="testFastAPI()">访问 FastAPI 8000 端口</button>
    <div id="output">等待请求...</div>

    <script>
      async function testFastAPI() {
        const output = document.getElementById("output");
        output.innerText = "请求中...";

        try {
          const response = await fetch("http://127.0.0.1:8000/");
          const data = await response.json();
          output.innerText = JSON.stringify(data, null, 2);
        } catch (error) {
          output.innerText = "错误: " + error.message;
          console.error("无法连接到 FastAPI:", error);
        }
      }
    </script>
  </body>
</html>
```

使用Live Server插件打开后的效果如下:
![示意图](PixPin_2026-05-14_19-31-51.webp)

然后我再写一个python代码:
```py
# main.py
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def helloword() -> dict:
    return {"data": "hello,world"}
```
- 如果使用`uv init`的话,将这个文件复制到main.py里就行了.
- **uvicorn**默认在`127.0.0.1:8000`启动服务器

使用`uvicorn main:app`运行这个代码后访问前端页面:
![示意图](PixPin_2026-05-14_19-22-19.webp)
无论你点了按钮多少次,都是访问失败,但当我们看一下服务器终端时,却没有任何问题:
![示意图](PixPin_2026-05-14_19-22-38.webp)

这是怎么回事?

在前端页面敲一下f12键调出控制台,看到这个报错:
![示意图](PixPin_2026-05-14_19-24-56.webp)

原来是我们触发了浏览器的CORS安全机制,它是什么?
##### CORS
- [wiki](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)

CORS的全称为**Cross-origin resource sharing**,翻译成中文就是跨域资源共享,**它允许一个前端页面通过一个不同的域名/端口来访问服务器端口提供的页面**.

而浏览器不能保证另一个端口/域名的网页是善意的,如果允许它直接访问服务器端口页面,可能造成非常恶劣的影响,因此需要跨域请求带上`Access-Control-Allow-Origin`请求头,如果请求头里的信息合规,就放行这次请求,返回正常页面.

##### 跨域中间件
鉴于一个网络服务只能占用一个端口,我们不可能将前端页面也放到后端页面的同一个端口上,为了让前端页面能够正常跨域访问后端端口,**跨域中间件**(CORSMiddleware)这一工具就派上用场了.

>当你配置了 CORSMiddleware 后，每当一个请求进入 FastAPI 并准备返回时，中间件会根据你的配置自动在返回的 HTTP Header 中插入以下字段：

1. `Access-Control-Allow-Origin`: 告诉浏览器哪些域（Origin）可以访问数据。如果你设为 ["*"]，它就会加上 `Access-Control-Allow-Origin: *`。
2. `Access-Control-Allow-Methods`: 告诉浏览器允许哪些请求方法（如 GET, POST, PUT）。
3. `Access-Control-Allow-Headers`: 告诉浏览器允许哪些自定义请求头。
##### 回到主题
在fastapi中配置跨域中间件非常简单,我们只需要在前面的python代码中加入以下字段即可,我们基本上也只用得到这些字段:
```py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware  # 导入中间件

app = FastAPI()

# 配置 CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],      # 允许所有来源
    allow_credentials=True,
    allow_methods=["*"],      # 允许所有方法（GET, POST 等）
    allow_headers=["*"],      # 允许所有请求头
)

@app.get("/")
async def helloword() -> dict:
    return {"data": "hello,world"}
```

由于修改了跨域策略,我们需要重启python服务器后再访问前端:
![示意图](PixPin_2026-05-14_19-50-59.webp)
- 非常有效!

总而言之,配合前端代码我们可以更好地理解Fastapi.
#### 路由编写
一个简单的路由写法如下:
```py
from fastapi import FastAPI

app = FastAPI()


@app.get("/items/{item_id}")
async def read_item(item_id):
    return {"item_id": item_id}
```
当用户访问`/items/newitem`时,fastapi会自动将`newitem`传入`read_item`函数中并返回对应的值.

##### 查询参数
在Google里键入google进行搜索,你就会跳转到`https://www.google.com/search?q=google`页面,Google服务器从而向你返回搜索结果,这里的`?q=google`就是**查询参数.**

尽管搜素引擎是查询参数的主要运用场景,但有时候我们需要让用户根据它的查询参数返回对应的值,而fastapi中的写法特别简单:
```py
from fastapi import FastAPI

app = FastAPI()


@app.get("/users/{user_id}/items/{item_id}")
async def read_user_item(
    user_id: int, item_id: str, q: str | None = None, short: bool = False
):
    item = {"item_id": item_id, "owner_id": user_id}
    if q:
        item.update({"q": q})
    if not short:
        item.update(
            {"description": "This is an amazing item that has a long description"}
        )
    return item
```
fastapi将查询参数**直接写在函数参数**中,这里的`q`参数默认值为None,代表用户可以不带上这个参数,而`short`的默认值为False,代表用户如果不加short参数的话就会默认返回False.

##### 查询参数的校验
fastapi中有一个Query库,可以配合typing库中的Annotated进行数据校验,一个简单的用法如下:
```py
from typing import Annotated

from fastapi import FastAPI, Query

app = FastAPI()


@app.get("/items/")
async def read_items(q: Annotated[str | None, Query(max_length=50)] = None):
    results = {"items": [{"item_id": "Foo"}, {"item_id": "Bar"}]}
    if q:
        results.update({"q": q})
    return results
```
上述代码要求: 如果你写了q参数,那么它的长度就不能超过50.

>至于更复杂的用法,建议碰到再学,不然也记不住.
##### 路径参数的校验
同样,我们可以校验路径参数,fastapi同样封装了一个Path库供我们调用:
```py
from typing import Annotated

from fastapi import FastAPI, Path

app = FastAPI()


@app.get("/items/{item_id}")
async def read_items(
    item_id: Annotated[int, Path(title="The ID of the item to get", ge=1)], q: str
):
    results = {"item_id": item_id}
    if q:
        results.update({"q": q})
    return results
```

#### 请求体与不同的网络请求方法
上述的代码其实是很有问题的,它使用`results.update`对数据进行了修改,按照Rest规范,get请求不应该对数据做任何修改,只能原样返回数据!

Rest规范的一个简单概述如下:
1. **如果用户要创建新的数据,他应该使用post请求**
2. **如果用户要部分修改旧数据,他应该使用patch请求**
3. **如果用户要全盘替换旧数据,他应该使用put请求**
4. **如果用户要删除某个旧数据,他应该使用delete请求**
5. 如果用户仅仅是访问某个页面,使用get请求就行了.

上述的第四点和第五点一般不用用户携带任何信息,只在请求头(request header)里说明即可.但前三点都需要用户在请求体(request body)里给出自己的数据,来修改服务器中的对应路由数据.

自然,我们希望用户提交的数据是足够规范的,不然后端根本无法处理.fastapi紧密结合了pydantic库,用它来约束请求体的格式,一个简单的代码如下:
```py
from fastapi import FastAPI
from pydantic import BaseModel


class Item(BaseModel):
    name: str
    description: str | None = None
    price: float
    tax: float | None = None


app = FastAPI()


@app.post("/items/")
async def create_item(item: Item):
    return item
```
get请求中的函数参数一般都是路由变量和查询参数变量,而post等处理数据的请求中的函数参数可以是用户传来的请求体.具体规则如下,优先级从高到低:
1. 如果该参数也在路径中声明了，它就是路径参数。
2. 如果该参数是（int、float、str、bool 等）单一类型，它会被当作查询参数。
3. 如果该参数的类型声明为 Pydantic 模型，它会被当作请求体。

**一个比较完整的示例**
```py
from fastapi import FastAPI
from pydantic import BaseModel


class Item(BaseModel):
    name: str
    description: str | None = None
    price: float
    tax: float | None = None


app = FastAPI()


@app.put("/items/{item_id}")
async def update_item(item_id: int, item: Item, q: str | None = None):
    result = {"item_id": item_id, **item.model_dump()}
    if q:
        result.update({"q": q})
    return result
```
>我们现在进行的数据处理都是伪处理,数据都没有存储在数据库里,甚至都没有创建一个临时的全局变量来存放数据.

##### 请求体的进阶写法
1. 我们可以用另外一个BaseModel类来注释一个BaseModel类中的变量:
```py
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()


class Image(BaseModel):
    url: str
    name: str


class Item(BaseModel):
    name: str
    description: str | None = None
    price: float
    tax: float | None = None
    tags: set[str] = set()
    image: Image | None = None


@app.put("/items/{item_id}")
async def update_item(item_id: int, item: Item):
    results = {"item_id": item_id, "item": item}
    return results
```

甚至可以把image字段变成列表:
```py
images: list[Image] | None = None
```
那么我们就期望接受到这样的请求体:
```py
{
    "name": "Foo",
    "description": "The pretender",
    "price": 42.0,
    "tax": 3.2,
    "tags": [
        "rock",
        "metal",
        "bar"
    ],
    "images": [
        {
            "url": "http://example.com/baz.jpg",
            "name": "The Foo live"
        },
        {
            "url": "http://example.com/dave.jpg",
            "name": "The Baz"
        }
    ]
}
```
#### 定制响应体
fastapi通过函数的返回值类型注解来指明响应体的格式,它会将输出数据限制并过滤为返回类型中定义的内容:
```py
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()


class Item(BaseModel):
    name: str
    description: str | None = None
    price: float
    tax: float | None = None
    tags: list[str] = []


@app.post("/items/")
async def create_item(item: Item) -> Item:
    return item


@app.get("/items/")
async def read_items() -> list[Item]:
    return [
        Item(name="Portal Gun", price=42.0),
        Item(name="Plumbus", price=32.0),
    ]
```

如果还需要在返回值约束的基础上对响应体做出进一步约束,就需要使用response参数,非常特别的是,由于没有地方可以放这个参数了,只好放在语法糖中,所以也不用进行导入:
```py
from typing import Any

from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()


class Item(BaseModel):
    name: str
    description: str | None = None
    price: float
    tax: float | None = None
    tags: list[str] = []


@app.post("/items/", response_model=Item)
async def create_item(item: Item) -> Any:
    return item


@app.get("/items/", response_model=list[Item])
async def read_items() -> Any:
    return [
        {"name": "Portal Gun", "price": 42.0},
        {"name": "Plumbus", "price": 32.0},
    ]
```
>FastAPI 会使用这个 response_model 来完成数据文档、校验等，并且还会将输出数据转换并过滤为其类型声明。

>如果你的编辑器、mypy 等进行严格类型检查，你可以将函数返回类型声明为 Any。
>
>这样你告诉编辑器你是有意返回任意类型。但 FastAPI 仍会使用 response_model 做数据文档、校验、过滤等工作。
>
>如果你同时声明了返回类型和 response_model，response_model 会具有优先级并由 FastAPI 使用。

为什么需要引入response_model呢,因为如果我们需要将用户数据进行处理后再进行输出,比如说过滤掉密码等敏感信息,我们可以这么写:
```py
from typing import Any

from fastapi import FastAPI
from pydantic import BaseModel, EmailStr

app = FastAPI()


class UserIn(BaseModel):
    username: str
    password: str
    email: EmailStr
    full_name: str | None = None


class UserOut(BaseModel):
    username: str
    email: EmailStr
    full_name: str | None = None


@app.post("/user/", response_model=UserOut)
async def create_user(user: UserIn) -> Any:
    return user
```
但是,如果我们去掉`response_model`参数,把UserOut作为函数的返回类型,由于同一个变量有了两个不同的类型注释,这显然会在类型检查工具中报错.

当然,上述方法是在老式的fastapi项目中使用的,现在我们有一种更好的处理方法,那就是通过类继承:
```py
from fastapi import FastAPI
from pydantic import BaseModel, EmailStr

app = FastAPI()


class BaseUser(BaseModel):
    username: str
    email: EmailStr
    full_name: str | None = None


class UserIn(BaseUser):
    password: str


@app.post("/user/")
async def create_user(user: UserIn) -> BaseUser:
    return user
```
user变量虽然是UserIn类型,但它同样也是BaseUser的子类,因此类型检查工具不会报错.

更值得令人惊叹的是,fastapi对这种情况做了很多优化,不会把类继承规则用于返回数据中,而是严格按照声明的返回类型进行处理和过滤.

有时候,我们不知道前端会返回什么东西,这在测试和编写demo代码的时候可能会出现,这个时候我们不需要使用Pydantic模型,而是使用普通的字典或者其他类型注解就可以了:
```py
from fastapi import FastAPI

app = FastAPI()


@app.get("/keyword-weights/", response_model=dict[str, float])
async def read_keyword_weights():
    return {"foo": 2.3, "bar": 3.4}
```
- 话又说回来,上述代码完全可以将类型注解放进返回值注解中

#### 响应状态码
fastapi的语法糖中还可以放置响应状态码:
```py
from fastapi import FastAPI

app = FastAPI()


@app.post("/items/", status_code=201)
async def create_item(name: str):
    return {"name": name}
```
由于数字太难记了,fastapi还内置了智能的类型补全:

![示意图](PixPin_2026-05-17_10-35-55.webp)

导入status库后即可使用这种更为清晰的状态码.
#### 返回错误
有时候用户的请求有问题,或者服务器本身出了问题(比如数据库无法正常连接上),这个时候可以导入HTTPException来作为响应:

```py
from fastapi import FastAPI, HTTPException

app = FastAPI()

items = {"foo": "The Foo Wrestlers"}


@app.get("/items/{item_id}")
async def read_item(item_id: str):
    if item_id not in items:
        raise HTTPException(status_code=404, detail="Item not found")
    return {"item": items[item_id]}
```

由于`HTTPException`是一个异常类,所以不能使用`return`,只能使用`raise`关键字来抛出,但它依旧会由fastapi传给客户端.
### ch2: 使用fastapi处理网络安全
#### 实战代码
先用实战代码建立一点初步的印象:
```py
from collections.abc import Generator
from typing import Annotated

import jwt
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jwt.exceptions import InvalidTokenError
from pydantic import ValidationError
from sqlmodel import Session

from app.core import security
from app.core.config import settings
from app.core.db import engine
from app.models import TokenPayload, User

reusable_oauth2 = OAuth2PasswordBearer(
    tokenUrl=f"{settings.API_V1_STR}/login/access-token"
)
# API_V1_STR: str = "/api/v1"


def get_db() -> Generator[Session, None, None]:
    with Session(engine) as session:
        yield session
    # engine = create_engine(str(settings.SQLALCHEMY_DATABASE_URI))

# @computed_field  # type: ignore[prop-decorator]
#     @property
#     def SQLALCHEMY_DATABASE_URI(self) -> PostgresDsn:
#         return PostgresDsn.build(
#             scheme="postgresql+psycopg",
#             username=self.POSTGRES_USER,
#             password=self.POSTGRES_PASSWORD,
#             host=self.POSTGRES_SERVER,
#             port=self.POSTGRES_PORT,
#             path=self.POSTGRES_DB,
#         )

SessionDep = Annotated[Session, Depends(get_db)]
TokenDep = Annotated[str, Depends(reusable_oauth2)]


def get_current_user(session: SessionDep, token: TokenDep) -> User:
    try:
        payload = jwt.decode(
            token, settings.SECRET_KEY, algorithms=[security.ALGORITHM]
        )
        # ALGORITHM = "HS256"
        # SECRET_KEY: str = secrets.token_urlsafe(32)
        token_data = TokenPayload(**payload)
    except (InvalidTokenError, ValidationError):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Could not validate credentials",
        )
    user = session.get(User, token_data.sub)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    if not user.is_active:
        raise HTTPException(status_code=400, detail="Inactive user")
    return user


CurrentUser = Annotated[User, Depends(get_current_user)]


def get_current_active_superuser(current_user: CurrentUser) -> User:
    if not current_user.is_superuser:
        raise HTTPException(
            status_code=403, detail="The user doesn't have enough privileges"
        )
    return current_user
```
看的头疼吗,那就对了,我将逐步解释比较难懂的地方.

#### fastapi中的依赖
- 依赖: 某个变量初始化所用的可调用对象(函数,生成器,类等),

fastapi通过在Annotated中使用Depends库来导入依赖:
```py
from typing import Annotated

from fastapi import Depends, FastAPI

app = FastAPI()


async def common_parameters(q: str | None = None, skip: int = 0, limit: int = 100):
    return {"q": q, "skip": skip, "limit": limit}


@app.get("/items/")
async def read_items(commons: Annotated[dict, Depends(common_parameters)]):
    return commons


@app.get("/users/")
async def read_users(commons: Annotated[dict, Depends(common_parameters)]):
    return commons
```
这样一来,变量commons就被`common_parameters`函数初始化了,而不需要我们显式在代码中写明初始化函数.

Python中允许为类型注释设置别名,所以我们可以将`Annotated[dict, Depends(common_parameters)`提出来进行代码复用:
```py
from typing import Annotated

from fastapi import Depends, FastAPI

app = FastAPI()


async def common_parameters(q: str | None = None, skip: int = 0, limit: int = 100):
    return {"q": q, "skip": skip, "limit": limit}


CommonsDep = Annotated[dict, Depends(common_parameters)]


@app.get("/items/")
async def read_items(commons: CommonsDep):
    return commons


@app.get("/users/")
async def read_users(commons: CommonsDep):
    return commons
```

除了函数之外,类也可以作为依赖,但很少用到:
```py
from typing import Annotated

from fastapi import Depends, FastAPI

app = FastAPI()


fake_items_db = [{"item_name": "Foo"}, {"item_name": "Bar"}, {"item_name": "Baz"}]


class CommonQueryParams:
    def __init__(self, q: str | None = None, skip: int = 0, limit: int = 100):
        self.q = q
        self.skip = skip
        self.limit = limit


@app.get("/items/")
async def read_items(commons: Annotated[CommonQueryParams, Depends()]):
    response = {}
    if commons.q:
        response.update({"q": commons.q})
    items = fake_items_db[commons.skip : commons.skip + commons.limit]
    response.update({"items": items})
    return response
```
而上面的实战代码中,就是使用了生成器作为依赖:
```py
def get_db() -> Generator[Session, None, None]:
    with Session(engine) as session:
        yield session
    # engine = create_engine(str(settings.SQLALCHEMY_DATABASE_URI))

SessionDep = Annotated[Session, Depends(get_db)]
```
这里的生成器用法很简单,就是打开数据库连接后,将session实例注入到依赖中,处理完毕后就会自动关闭数据库连接.

#### 网络安全规范: OAuth2
- [阮一峰教程](https://www.ruanyifeng.com/blog/2019/04/oauth_design.html)

>简单说，OAuth 就是一种授权机制。数据的所有者告诉系统，同意授权第三方应用进入系统，获取这些数据。系统从而产生一个短期的进入令牌（token），用来代替密码，供第三方应用使用。

令牌（token）与密码（password）的作用是一样的，都可以进入系统，但是有三点差异。

（1）令牌是短期的，到期会自动失效，用户自己无法修改。密码一般长期有效，用户不修改，就不会发生变化。

（2）令牌可以被数据所有者撤销，会立即失效。以上例而言，屋主可以随时取消快递员的令牌。密码一般不允许被他人撤销。

（3）令牌有权限范围（scope），比如只能进小区的二号门。对于网络服务来说，只读令牌就比读写令牌更安全。密码一般是完整权限。


总结一下就是,当服务器将token(令牌)返回给客户端后,用户之后访问页面时,只需要使用令牌进行验证就行了,不再需要每次都输入用户名和密码了.
#### OAuth2PasswordBearer库
**示例代码**
```py
from typing import Annotated

from fastapi import Depends, FastAPI
from fastapi.security import OAuth2PasswordBearer

app = FastAPI()

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

TokenDep = Annotated[str, Depends(oauth2_scheme)]

@app.get("/items/")
async def read_items(token: TokenDep):
    return {"token": token}
```
- 上述的代码只是一个异常简化的流程,我们没有对token进行任何特殊处理,也没有在发放token时对用户进行核验(比如要求用户输入用户名和密码)

我们从fastapi调用了OAuth2PasswordBearer库,并用参数`tokenUrl="token"`初始化`oauth2_scheme`,但这个参数是可有可无的,只不过是帮助Swagger UI来生成文档而已,不写也没有任何影响.

>fastapi高度集成了对Swagger UI的支持,`Swagger UI`本身是一个可视化的路由界面,帮助开发者更好地看懂路由操作.

而OAuth2PasswordBearer类主要的功能就是在接受用户请求时,提取出该用户使用的token,并校验请求的格式是否正常,如果用户的请求头中没有`Authorization`字段或者其值不包含`Bearer`的格式说明,就会抛出`HTTP 401 Unauthorized`异常.


**更长的示例代码**
```py
from typing import Annotated

from fastapi import Depends, FastAPI
from fastapi.security import OAuth2PasswordBearer
from pydantic import BaseModel

app = FastAPI()

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


class User(BaseModel):
    username: str
    email: str | None = None
    full_name: str | None = None
    disabled: bool | None = None


def fake_decode_token(token):
    return User(
        username=token + "fakedecoded", email="john@example.com", full_name="John Doe"
    )


async def get_current_user(token: Annotated[str, Depends(oauth2_scheme)]):
    user = fake_decode_token(token)
    return user


@app.get("/users/me")
async def read_users_me(current_user: Annotated[User, Depends(get_current_user)]):
    return current_user
```
可以看到,我们在获取当前用户时使用了`get_current_user`依赖,这个依赖使用了从请求头中提取的token,并假装用这个token对用户的数据进行了解密,并得到了解密后的用户数据.

#### Python加密库
>本来应该单独提到第二级标题来讲的,但放到这里更能贴合实战的情景,而这些库本来也就是用来处理网络通信的.
##### 前置概念: JWT与token防伪
- [jwt官网](https://www.jwt.io/)
- [wiki](https://zh.wikipedia.org/wiki/JSON_Web_Token)

现代的前后端通信通常都通过jwt(JSON Web Tokens)来实现,它与传统的token认证方式有很大的区别:

- 传统 token 方式：用户登录成功后，服务端生成一个随机 token 给用户，并且在服务端(数据库或缓存)中保存一份 token，以后用户再来访问时需携带 token，服务端接收到 token 之后，去数据库或缓存中进行校验 token 的是否超时、是否合法
  - 显然,由于多了数据库存取的开销,是不太合算的.
- jwt 方式：用户登录成功后，服务端通过 jwt 生成一个随机 token 给用户（服务端无需保留 token），以后用户再来访问时需携带token，服务端接收到 token 之后，通过 jwt 对 token 进行校验是否超时、是否合法
  - 一切加密和解密的流程都由后端自动执行,不必过多操心.

进入jwt官网后,我们可以看到如下界面:
![示意图](PixPin_2026-05-18_18-52-48.webp)

一个JWT由三部分明文加密构成:
1. Header(头部): 声明使用的加密算法和token的种类,这里使用的算法是**HS256**,也是最通用的加密算法,它会将数据加密成一个极难被反向破解的字符串.
   1. JWT使用Base64Ur算法l编码Header部分
2. Playload(负载): 要传输的数据.
   1. JWT使用Base64Url算法编码Playload部分
3. Signature(签名): 它由如下部分组成:

```text
HMACSHA256(
  base64UrlEncode(header) + "." +
  base64UrlEncode(payload),
  secret)
```
加密后JWT会再使用Base64Url对其进行编码,变成常见的43个Base64Url字符.

**算法的简单解释**
- **secret**: 签名的最后一部分也被称为盐(salt),可以任意填写,用于增大攻击者的破解难度,详情可见[wiki](https://zh.wikipedia.org/wiki/%E7%9B%90_(%E5%AF%86%E7%A0%81%E5%AD%A6))
- **Base64**编码: 将数据转换成二进制编码后,使用64种字符对应6个二进制位进行重新映射,例如`000000`对应`A`,`111111`对应`/`.
  - 主要目的是为了解决JSON中大量的`{}`,`:`等字符与HTTP协议本身的控制字符冲突的问题,**不起到任何加密作用**.
- **Base64Url**: 由于浏览器的URL编码器会把`/`和`+`解析成形如`%xx`的格式,所以为了适配加密文本的传输,该算法将加密文本中的`+`变成`-`,`/`变成`_`,解密的时候同时做出对应的处理.
- **SHA256**算法: 将输入数据转换成对应的256位二进制数,对应32个字节,理论上无法被破解

到这里我们会发现,JWT并不是一个加密方法,而只是一个明文的通行证而已.也就是说,所有的数据本质上都是明文的,不提供任何加密渠道.

实际上,真正的加密由HTTPS本身保证,它确保JWT不会被攻击者窃取,那么当服务器接收到某个JWT时,它也可以保证这个JWT是真实的,从而验证该JWT后给用户放行.

就算攻击者知道了用户发送的数据(Payload)和使用的加密算法(Header),由于secret(盐)只存储在服务器端,攻击者无法用前两个数据组装出合法的签名,也就不能伪造真实的用户了.

总体来说就是,JWT本身是不保密的,但它通过HTTPS和哈希加盐两个机制实现了用户的防伪认证.

##### pyjwt
- [官方文档](https://pyjwt.readthedocs.io/en)
  - 不太清晰
- 导入方法: `pip install pyjwt`

懂得了jwt的原理后,就可以很轻松的使用这个库了,我们一共需要三个参数: 加密/解密的负载,使用的算法,盐

jwt的所有常用功能只用以下代码就可以展示了:
```py
import jwt
encoded_jwt = jwt.encode({"some": "payload"}, "secret", algorithm="HS256")
jwt.decode(encoded_jwt, "secret", algorithms=["HS256"])
{'some': 'payload'}
```

而在前面的实战代码中,我们确实也是这么使用它的:
```py
def get_current_user(session: SessionDep, token: TokenDep) -> User:
    try:
        payload = jwt.decode(
            token, settings.SECRET_KEY, algorithms=[security.ALGORITHM]
        )
```
既然有解密,那自然有加密,在另外一处文件的代码中,我们是这么进行加密的:
```py
def create_access_token(subject: str | Any, expires_delta: timedelta) -> str:
    expire = datetime.now(timezone.utc) + expires_delta
    to_encode = {"exp": expire, "sub": str(subject)}
    encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt
```

jwt库本身支持不少的加密算法,但我们只使用最常用的sha256就可以了:
![示意图](PixPin_2026-05-19_13-22-33.webp)
##### 前置概念: 如何加密密码
- [一个非常好的介绍文章](https://draven.co/whys-the-design-password-with-md5/)

如参考文章中所提到的那样,普通的哈希函数由于存在哈希碰撞和彩虹表破解的风险,所以完全不推荐用来加密密码,而是应该使用`Argon2`,`Brypt`等现代的专用加密算法.

至于具体原理可以去搜寻论文解决,我们只要知道目前它们是绝对安全的,可以用来加密密码就可以了.

- 以前的哈希函数都需要我们额外存储盐,而现代加密函数的盐都是内置的.
##### pwdlib
- [官网](https://frankie567.github.io/pwdlib/)
- 导入方法: `pwdlib[argon2,bcrypt]`,只使用其中的一个版本也可以.

该库是作为传统加密库passlib的后继者出现的,它的主要作用如下:
1.  Provide an easy-to-use wrapper to hash and verify passwords
2.  Support modern and secure algorithms like Argon2 or Bcrypt

这恰恰是我们所需要的加密库功能,它的基本使用方法如下:
```py
from pwdlib import PasswordHash
password_hash = PasswordHash.recommended()
```
目前该库的底层默认算法是Argon2算法,上述代码相当于激活了一个使用Argon2算法的加密类.

之后我们就可以用这个加密类来加密密码:
```py
hash = password_hash.hash("herminetincture")
```

自然,当验证用户时,我们还可以使用这个类来验证密码:
```py
valid = password_hash.verify("herminetincture", hash)
```

该库的一个进阶用法是用来处理使用过时加密算法的老数据库,首先,我们先显式创建一个加密类:
```py
from pwdlib import PasswordHash, exceptions
from pwdlib.hashers.argon2 import Argon2Hasher
from pwdlib.hashers.bcrypt import BcryptHasher

password_hash = PasswordHash((
    Argon2Hasher(),
    BcryptHasher(),
))
```
第一个参数是推荐的新算法,第二个参数是要兼容的过时算法,之后我们可以跟之前一样调用这个类来进行加密和验证,如果要创建新的密码,它会自动使用新算法,如果是要验证老的密码,它可以通过以下方式自动替换老密码:
```py
valid, updated_hash = password_hash.verify_and_update("herminetincture", hash)
```
- 还是很方便的.
#### 回到实战代码
```py
from collections.abc import Generator
from typing import Annotated

import jwt
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jwt.exceptions import InvalidTokenError
from pydantic import ValidationError
from sqlmodel import Session

from app.core import security
from app.core.config import settings
from app.core.db import engine
from app.models import TokenPayload, User

reusable_oauth2 = OAuth2PasswordBearer(
    tokenUrl=f"{settings.API_V1_STR}/login/access-token"
)
# API_V1_STR: str = "/api/v1"


def get_db() -> Generator[Session, None, None]:
    with Session(engine) as session:
        yield session
    # engine = create_engine(str(settings.SQLALCHEMY_DATABASE_URI))

# @computed_field  # type: ignore[prop-decorator]
#     @property
#     def SQLALCHEMY_DATABASE_URI(self) -> PostgresDsn:
#         return PostgresDsn.build(
#             scheme="postgresql+psycopg",
#             username=self.POSTGRES_USER,
#             password=self.POSTGRES_PASSWORD,
#             host=self.POSTGRES_SERVER,
#             port=self.POSTGRES_PORT,
#             path=self.POSTGRES_DB,
#         )

SessionDep = Annotated[Session, Depends(get_db)]
TokenDep = Annotated[str, Depends(reusable_oauth2)]


def get_current_user(session: SessionDep, token: TokenDep) -> User:
    try:
        payload = jwt.decode(
            token, settings.SECRET_KEY, algorithms=[security.ALGORITHM]
        )
        # ALGORITHM = "HS256"
        # SECRET_KEY: str = secrets.token_urlsafe(32)
        token_data = TokenPayload(**payload)
    except (InvalidTokenError, ValidationError):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Could not validate credentials",
        )
    user = session.get(User, token_data.sub)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    if not user.is_active:
        raise HTTPException(status_code=400, detail="Inactive user")
    return user


CurrentUser = Annotated[User, Depends(get_current_user)]


def get_current_active_superuser(current_user: CurrentUser) -> User:
    if not current_user.is_superuser:
        raise HTTPException(
            status_code=403, detail="The user doesn't have enough privileges"
        )
    return current_user
```
现在上面这段代码就非常好理解了:
1. 首先我们使用OAuth2PasswordBearer类创建了一个从用户请求自动提取token的依赖
2. 接着在`get_current_user`函数中,我们获取用户的token后,使用jwt库对其进行解码.
3. 如果验证失败则抛出HTTP异常,如果验证成功则从数据库返回用户的基本信息,如果不存在这个用户,或者用户被删除了,那么同样报错.

另外一处有一个用于产生token的实战代码:
```py
from datetime import datetime, timedelta, timezone
from typing import Any

import jwt
from pwdlib import PasswordHash
from pwdlib.hashers.argon2 import Argon2Hasher
from pwdlib.hashers.bcrypt import BcryptHasher

from app.core.config import settings

password_hash = PasswordHash(
    (
        Argon2Hasher(),
        BcryptHasher(),
    )
)


ALGORITHM = "HS256"


def create_access_token(subject: str | Any, expires_delta: timedelta) -> str:
    expire = datetime.now(timezone.utc) + expires_delta
    to_encode = {"exp": expire, "sub": str(subject)}
    encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


def verify_password(
    plain_password: str, hashed_password: str
) -> tuple[bool, str | None]:
    return password_hash.verify_and_update(plain_password, hashed_password)


def get_password_hash(password: str) -> str:
    return password_hash.hash(password)
```
1. `create_access_token`函数首先设定token的过期期限后将其与负载进行合并封装,这个负载则是用户的id,用于唯一标识用户,之后我们使用jwt库来加密这个合并后的负载,产生token提供给用户.
2. `verify_password`函数用于验证和升级用户的哈希密码
3. `get_password_hash`函数用于加密新的密码.



### ch3: 使用fastapi处理数据库
>FastAPI 并不要求你使用 SQL（关系型）数据库。你可以使用你想用的任何数据库。

由于SQLModel的作者与fastapi的作者是同一个人,所以这两个库是高度适配的,我接下来也会按照fastapi的官方教程来展示使用fastapi处理SQLModel.

#### 搭建初始环境
```py
from fastapi import FastAPI
from sqlmodel import Field, Session, SQLModel, create_engine, select


class Hero(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str = Field(index=True)
    secret_name: str
    age: int | None = Field(default=None, index=True)


sqlite_file_name = "database.db"
sqlite_url = f"sqlite:///{sqlite_file_name}"

connect_args = {"check_same_thread": False}

engine = create_engine(sqlite_url, echo=True, connect_args=connect_args)


def create_db_and_tables():
    SQLModel.metadata.create_all(engine)


app = FastAPI()


@app.on_event("startup")
def on_startup():
    create_db_and_tables()


@app.post("/heroes/")
def create_hero(hero: Hero):
    with Session(engine) as session:
        session.add(hero)
        session.commit()
        session.refresh(hero)
        return hero


@app.get("/heroes/")
def read_heroes():
    with Session(engine) as session:
        heroes = session.exec(select(Hero)).all()
        return heroes
```
需要分析的点如下:
1. `connect_args = {"check_same_thread": False}`: 由于sqlite是默认使用单线程的数据库,异步调用时有可能出现多个线程共用一个链接的情况,这时候sqlite就会报错,所以我们需要通过设置跳过sqlite对多线程的检查.
2. `@app.on_event("startup")`: 该语法糖修饰的函数会在后端服务启动时执行,帮助我们插入Hero表.尽管这样确实很方便,但在生产环境中我们有更加安全的做法,留待最后说明
3. `create_hero`函数会从消息体提取出用户传来的新英雄,然后插入到数据库中并返回.

#### 针对客户请求做出响应
例如.我们可以使用路由中的查询参数:
```py
from fastapi import FastAPI, HTTPException, Query
from sqlmodel import Field, Session, SQLModel, create_engine, select

# Code here omitted 👈

@app.get("/heroes/", response_model=list[HeroPublic])
def read_heroes(offset: int = 0, limit: int = Query(default=100, le=100)):
    with Session(engine) as session:
        heroes = session.exec(select(Hero).offset(offset).limit(limit)).all()
        return heroes
```
至于其他的用法基本都差不多,所以直接给出教程中的完整代码:
```py
from fastapi import Depends, FastAPI, HTTPException, Query
from sqlmodel import Field, Relationship, Session, SQLModel, create_engine, select


class TeamBase(SQLModel):
    name: str = Field(index=True)
    headquarters: str


class Team(TeamBase, table=True):
    id: int | None = Field(default=None, primary_key=True)

    heroes: list["Hero"] = Relationship(back_populates="team")


class TeamCreate(TeamBase):
    pass


class TeamPublic(TeamBase):
    id: int


class TeamUpdate(SQLModel):
    id: int | None = None
    name: str | None = None
    headquarters: str | None = None


class HeroBase(SQLModel):
    name: str = Field(index=True)
    secret_name: str
    age: int | None = Field(default=None, index=True)

    team_id: int | None = Field(default=None, foreign_key="team.id")


class Hero(HeroBase, table=True):
    id: int | None = Field(default=None, primary_key=True)

    team: Team | None = Relationship(back_populates="heroes")


class HeroPublic(HeroBase):
    id: int


class HeroCreate(HeroBase):
    pass


class HeroUpdate(SQLModel):
    name: str | None = None
    secret_name: str | None = None
    age: int | None = None
    team_id: int | None = None


class HeroPublicWithTeam(HeroPublic):
    team: TeamPublic | None = None


class TeamPublicWithHeroes(TeamPublic):
    heroes: list[HeroPublic] = []


sqlite_file_name = "database.db"
sqlite_url = f"sqlite:///{sqlite_file_name}"

connect_args = {"check_same_thread": False}
engine = create_engine(sqlite_url, echo=True, connect_args=connect_args)


def create_db_and_tables():
    SQLModel.metadata.create_all(engine)


def get_session():
    with Session(engine) as session:
        yield session


app = FastAPI()


@app.on_event("startup")
def on_startup():
    create_db_and_tables()


@app.post("/heroes/", response_model=HeroPublic)
def create_hero(*, session: Session = Depends(get_session), hero: HeroCreate):
    db_hero = Hero.model_validate(hero)
    session.add(db_hero)
    session.commit()
    session.refresh(db_hero)
    return db_hero


@app.get("/heroes/", response_model=list[HeroPublic])
def read_heroes(
    *,
    session: Session = Depends(get_session),
    offset: int = 0,
    limit: int = Query(default=100, le=100),
):
    heroes = session.exec(select(Hero).offset(offset).limit(limit)).all()
    return heroes


@app.get("/heroes/{hero_id}", response_model=HeroPublicWithTeam)
def read_hero(*, session: Session = Depends(get_session), hero_id: int):
    hero = session.get(Hero, hero_id)
    if not hero:
        raise HTTPException(status_code=404, detail="Hero not found")
    return hero


@app.patch("/heroes/{hero_id}", response_model=HeroPublic)
def update_hero(
    *, session: Session = Depends(get_session), hero_id: int, hero: HeroUpdate
):
    db_hero = session.get(Hero, hero_id)
    if not db_hero:
        raise HTTPException(status_code=404, detail="Hero not found")
    hero_data = hero.model_dump(exclude_unset=True)
    db_hero.sqlmodel_update(hero_data)
    session.add(db_hero)
    session.commit()
    session.refresh(db_hero)
    return db_hero


@app.delete("/heroes/{hero_id}")
def delete_hero(*, session: Session = Depends(get_session), hero_id: int):
    hero = session.get(Hero, hero_id)
    if not hero:
        raise HTTPException(status_code=404, detail="Hero not found")
    session.delete(hero)
    session.commit()
    return {"ok": True}


@app.post("/teams/", response_model=TeamPublic)
def create_team(*, session: Session = Depends(get_session), team: TeamCreate):
    db_team = Team.model_validate(team)
    session.add(db_team)
    session.commit()
    session.refresh(db_team)
    return db_team


@app.get("/teams/", response_model=list[TeamPublic])
def read_teams(
    *,
    session: Session = Depends(get_session),
    offset: int = 0,
    limit: int = Query(default=100, le=100),
):
    teams = session.exec(select(Team).offset(offset).limit(limit)).all()
    return teams


@app.get("/teams/{team_id}", response_model=TeamPublicWithHeroes)
def read_team(*, team_id: int, session: Session = Depends(get_session)):
    team = session.get(Team, team_id)
    if not team:
        raise HTTPException(status_code=404, detail="Team not found")
    return team


@app.patch("/teams/{team_id}", response_model=TeamPublic)
def update_team(
    *,
    session: Session = Depends(get_session),
    team_id: int,
    team: TeamUpdate,
):
    db_team = session.get(Team, team_id)
    if not db_team:
        raise HTTPException(status_code=404, detail="Team not found")
    team_data = team.model_dump(exclude_unset=True)
    db_team.sqlmodel_update(team_data)
    session.add(db_team)
    session.commit()
    session.refresh(db_team)
    return db_team


@app.delete("/teams/{team_id}")
def delete_team(*, session: Session = Depends(get_session), team_id: int):
    team = session.get(Team, team_id)
    if not team:
        raise HTTPException(status_code=404, detail="Team not found")
    session.delete(team)
    session.commit()
    return {"ok": True}
```
- 如果认真学习过fastapi和sqlmodel的话,看到这段代码应该不会有什么难点了


### ch4: 使用fastapi进行测试(待补充)
>没有测试的代码不是好代码


### ch5: 使用fastapi+nextjs搭建简单智能体
>本部分主要会使用fastapi处理deepseek api,这并不需要用到数据库来存储任何信息,所有的信息都在运行时处理.至于前端部分我会大致介绍路由操作,UI等布局细节就由组件库和AI帮我搞定了.

**最终效果:**
![示意图](PixPin_2026-05-24_23-47-49.webp)

#### 前置概念: openai库使用
- [Deepseek API文档](https://api-docs.deepseek.com/zh-cn/)
  - 由于OpenAI的官方文档拒绝我访问(??),所以只好看Deepseek的API文档了.

>现在,大部分AI api都使用OpenAI的API规范,包括所有的国产AI,尽管Claude还不支持...
##### 基本用法
**概览代码**
```py
# Please install OpenAI SDK first: `pip3 install openai`
import os
from openai import OpenAI

client = OpenAI(
    api_key=os.environ.get('DEEPSEEK_API_KEY'),
    base_url="https://api.deepseek.com")

response = client.chat.completions.create(
    model="deepseek-v4-pro",
    messages=[
        {"role": "system", "content": "You are a helpful assistant"},
        {"role": "user", "content": "Hello"},
    ],
    stream=False,
    reasoning_effort="high",
    extra_body={"thinking": {"type": "enabled"}}
)

print(response.choices[0].message.content)
```
1. 首先使用OpenAI类创建一个client实例,填入api key和该api的网址
2. 接着,我们调用该api的对话补全功能,你可能像我一样会很好奇为什么不直接写成`client.create`,而是多了两个中间层,那是因为AI api的功能确实很多:
```text
client (根客户端)
├── chat (聊天业务域)
│   └── completions (对话补全子功能) -> create()
├── images (图像业务域)
│   ├── generate() (文本生图)
│   ├── edit()     (图片编辑)
│   └── create_variation()
├── audio (音频业务域)
│   ├── transcriptions() (语音转文字)
│   └── translations()   (语音翻译)
└── embeddings (向量业务域)
    └── create() (文本向量化)
```

>而我们的智能体应用只用对话补全功能就够了,其他的功能deepseek也不支持.

3. messages里有两个键值对,标明为`system`的提示词会具有最高权重,在对话开始的时候就发送给接口,表明为`user`的则为用户输入的提示词.
4. `stream`表示流式输出,如果设定为False,则会一口气返回所有内容,用户会感受到明显的阻塞,所以实际的智能体应用都会设定为True
5. `reasoning_effort`: 推理能力,支持以下设定值,"none", "minimal", "low", "medium", "high", "xhigh".
6. `extra_body={"thinking": {"type": "enabled"}}`: 由于openai库还不支持单独使用推理能力,所以deepseek只好在api上加上额外的信息设置thinking字段为`enabled`,来启动思考模式.
7. 非流式输出的response样例如下:
```json
{
  "id": "chatcmpl-9A7bC...",
  "object": "chat.completion",
  "created": 1713876000,
  "model": "deepseek-v4-pro",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "你好！我是大语言模型。"
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 15,
    "completion_tokens": 12,
    "total_tokens": 27
  }
}
```

使用智能体时,有时候由于两个回答的权重过于相近,AI会让我们来选择自己更喜欢的回答.但api调用的话不可能这样干,但是我们可以在使用api的时候选择自己想要的回答数量n,api会返回权重最高的前n个回答.

>尽管如此,deepseek目前还只支持返回一个回答,如果你设定n>=2的话,会返回错误码说明:`'message': 'Invalid n value (currently only n = 1 is supported)'`

我们可以自己写一段代码,来测试一下效果:
```py
response = client.chat.completions.create(
    model="deepseek-v4-pro",
    messages=[
        {"role": "system", "content": "You are a helpful assistant"},
        {"role": "user", "content": "请你写一篇800字的高考励志作文"},
    ],
    stream=False,
    reasoning_effort="high",
    extra_body={"thinking": {"type": "enabled"}},
)

print(response.choices[0])
```
返回内容如下:
```json
{
  "choices": [
    {
      "index": 0,
      "finish_reason": "stop",
      "logprobs": null,
      "message": {
        "role": "assistant",
        "content": "## 花开不败\n\n百日誓师的声浪犹在耳畔，高考倒计时的数字已如秋叶般飘零。时光真是个奇妙的存在，我们拼命追逐时它步履蹒跚，我们贪恋不舍时它却如白驹过隙。\n\n...\n\n高考的意义，不仅在于那一纸红彤彤的录取通知书，更在于让我们相信，努力的价值，坚持的意义，以及梦想终会开花的奇迹。\n\n没有比脚更长的路，没有比人更高的山。今天，我们站在这里，回眸是春花秋月，是书山学海；眺望是夏云冬雪，是诗和远方。",
        "refusal": null,
        "reasoning_content": "用户需要一篇800字的高考励志作文。这是一个明确的创作任务，需要生成一篇符合高考作文要求的文章。\n\n用户的核心需求是获得一篇能激励人心、结构完整、文笔流畅的作文。深层需求可能包括：希望作文立意深刻、有文采、能体现奋斗和人生价值等主题。高考励志作文通常需要回顾备考历程，展现坚持与成长，并传递积极向上的价值观。\n\n想到了可以从几个方面来构思：开篇可以用一个生动的意象或比喻引入，比如时光的痕迹或成长的瞬间；主体部分可以分层次展开，描写备考的艰辛、坚持的意义、心态的调整，并联系更深远的生命价值；结尾要升华主题，鼓舞士气，展望未来。整体语言需要富有感染力，适当运用排比、比喻等修辞手法，保持积极昂扬的基调。\n\n可以开始创作了。",
        "annotations": null,
        "audio": null,
        "function_call": null,
        "tool_calls": null
      }
    }
  ]
}
```
##### 多轮对话
大模型是只会考虑当前输入的,要想让模型能够"记忆"之前的输入,一个非常简单的做法是在这次输入中加上上一轮对话的输入输出:
```py
# 第 1 轮请求
messages = [
    {"role": "user", "content": "你好，我是张三"}
] # 模型返回：{"role": "assistant", "content": "你好，张三！"}

# 第 2 轮请求（必须携带第 1 轮的全部内容）
messages = [
    {"role": "user", "content": "你好，我是张三"},
    {"role": "assistant", "content": "你好，张三！"},
    {"role": "user", "content": "我刚才说我叫什么？"}
]
```

显然,当对话轮数一多,由于token限制,模型就无法完整获取全部的上下文了,这种做法是完全不可接受的.

>一个比较异想天开的想法是,调用API或者另一个本地AI来处理以前的对话记录,变成一段较短的记录,当然,这确实比较好实现,但仍然不是长久之计.

实际生产中我们会通过KV cache等构建机制来实现多轮对话,但我们这个项目出于简化的目的,甚至不会用到多轮对话,就不用操心这些问题了.



##### 流式输出
- 流式输出(stream): API不断输出消息块,后端不断接收消息块,在前端展现出文字逐个输出的效果.

在openai库中,流式输出实质上是通过一个可被迭代的生成器实现的,具体原理不太有必要了解,我们看看怎么使用:

```py
from openai import OpenAI
client = OpenAI(api_key="<DeepSeek API Key>", base_url="https://api.deepseek.com")

def stream_agent():
    messages = [{"role": "user", "content": "9.11 and 9.8, which is greater?"}]
    response = client.chat.completions.create(
        model="deepseek-v4-pro",
        messages=messages,
        stream=True,
        reasoning_effort="high"
        extra_body={"thinking": {"type": "enabled"}},
    )

    for chunk in response:
        # 某些 chunk 可能没有 choices，保险起见先判断。
        if not chunk.choices:
            continue

        # delta 表示“这一次新增的内容”。
        delta = chunk.choices[0].delta

        # delta.content 可能是 None。
        # 只有真的有文本内容时，才 yield 给外部。
        if delta.content:
            yield delta.content
```
流式输出中,我们通过chunk对象来获取文本块,并使用delta对象来获取新增的内容,并通过生成器供其他函数使用,至于怎么使用,就要用到fastapi的`StreamingResponse`类了

#### StreamingResponse类
>fastapi默认返回JSON响应,也就是一次返回全部内容,如果想要流式传输纯字符串,或者传输音频或者视频,就需要用到这个类.

官方示例:
```py
from collections.abc import AsyncIterable, Iterable

from fastapi import FastAPI
from fastapi.responses import StreamingResponse

app = FastAPI()


message = """
Rick: (stumbles in drunkenly, and turns on the lights) Morty! You gotta come on. You got--... you gotta come with me.
Morty: (rubs his eyes) What, Rick? What's going on?
Rick: I got a surprise for you, Morty.
Morty: It's the middle of the night. What are you talking about?
Rick: (spills alcohol on Morty's bed) Come on, I got a surprise for you. (drags Morty by the ankle) Come on, hurry up. (pulls Morty out of his bed and into the hall)
Morty: Ow! Ow! You're tugging me too hard!
Rick: We gotta go, gotta get outta here, come on. Got a surprise for you Morty.
"""


@app.get("/story/stream", response_class=StreamingResponse)
async def stream_story() -> AsyncIterable[str]:
    for line in message.splitlines():
        yield line


@app.get("/story/stream-no-async", response_class=StreamingResponse)
def stream_story_no_async() -> Iterable[str]:
    for line in message.splitlines():
        yield line


@app.get("/story/stream-no-annotation", response_class=StreamingResponse)
async def stream_story_no_annotation():
    for line in message.splitlines():
        yield line


@app.get("/story/stream-no-async-no-annotation", response_class=StreamingResponse)
def stream_story_no_async_no_annotation():
    for line in message.splitlines():
        yield line


@app.get("/story/stream-bytes", response_class=StreamingResponse)
async def stream_story_bytes() -> AsyncIterable[bytes]:
    for line in message.splitlines():
        yield line.encode("utf-8")


@app.get("/story/stream-no-async-bytes", response_class=StreamingResponse)
def stream_story_no_async_bytes() -> Iterable[bytes]:
    for line in message.splitlines():
        yield line.encode("utf-8")


@app.get("/story/stream-no-annotation-bytes", response_class=StreamingResponse)
async def stream_story_no_annotation_bytes():
    for line in message.splitlines():
        yield line.encode("utf-8")


@app.get("/story/stream-no-async-no-annotation-bytes", response_class=StreamingResponse)
def stream_story_no_async_no_annotation_bytes():
    for line in message.splitlines():
        yield line.encode("utf-8")
```
- `response_class`: 设置响应体的种类,默认为`JSONResponse`,指定其他的响应体种类时,fastapi底层会进行相应的调整.
  - 设置为`StreamingResponse`时会自动在HTTP响应头中加入以下字段:`Content-Type: text/plain; charset=utf-8`,并逐块向前端发送数据.
- 上述的代码很长,但只是在以不同方式传输同一个长字符串而已,有的使用了类型注释,有的将字符串转换成了二进制流. 

无论怎样,底层的原理我们没必要了解,只要知道`StreamingResponse`类能够轻松实现流式输出.

我们还可以将`StreamingResponse`显式写入返回值里,可以进行自己的定制化操作:
```py
@app.post("/api/chat")
async def chat(request: ChatMessage) -> StreamingResponse:
    return StreamingResponse(
        stream_agent(request.message),
        media_type="text/plain; charset=uft-8",
    )
```
- 第一个参数为某个生成器函数,第二个参数则为我们自己定制的媒体类型


#### 路由构想
>如果不靠ai的话,初学者是很难自己设计出一个能用的路由的,建议不断阅读优秀项目的api设计来学习怎么写路由.

我最简化了项目的路由操作,只保留了两个前端路由: `auth`和`chat`,一个对应从数据库中获取用户数据并认证,另一个对应了从API调用信息并返回.前端通过调用后端的api来模拟数据库交互,并调用大模型输出流.

#### 后端编写
整个后端加起来就四个文件,去掉了数据库操作,安全验证,严格的类型检查,测试代码,从而凸显出真正重要的核心代码部分:
![示意图](PixPin_2026-05-24_23-54-46.webp)

1. `route.py`,核心中的核心,总共只写了三个路由:

```py
from fastapi import FastAPI
from fastapi.responses import StreamingResponse
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from app.core.client import stream_agent

app = FastAPI()


origins = [
    "http://localhost:3000",
    "http://127.0.0.1:3000",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


class ChatMessage(BaseModel):
    message: str


@app.get("/api/health")
async def homepage() -> dict:
    return {"message": "Hello,World!"}


@app.get("/api/auth")
async def check() -> dict:
    return {
        "message": "我懒得写验证了,你直接进来吧",
        "ok": True,
    }


@app.post("/api/chat", response_class=StreamingResponse)
async def chat(request: ChatMessage):
    return stream_agent(request.message)
```
- `/api/health`用于检查与后端是否正常连接,模拟的是实际生产中的数据库健康检查
- `/api/auth`用于验证用户,模拟的是实际生产中的用户注册和验证
- `/api/chat`用于调用deepseek API

2. `client.py`,调用deepseek API:
```py
from app.utils.config import settings
from openai import OpenAI
from typing import Generator

client = OpenAI(
    api_key=settings.DEEPSEEK_API_KEY,
    base_url=settings.DEEPSEEK_URL,
)

DEFAULT_MODEL = "deepseek-v4-pro"

DEFAULT_SYSTEM_PROMPT = """
以后的回答都要称呼我为李华,优先输出"你好,李华!"
"""


def stream_agent(
    user_message: str,
    system_prompt: str = DEFAULT_SYSTEM_PROMPT,
    model: str = DEFAULT_MODEL,
) -> Generator[str, None, None]:

    # 创建流式请求。
    stream = client.chat.completions.create(
        model=model,
        messages=[
            {
                "role": "system",
                "content": system_prompt,
            },
            {
                "role": "user",
                "content": user_message,
            },
        ],
        stream=True,
        reasoning_effort="high",
    )


    for chunk in stream:
        # 某些 chunk 可能没有 choices，保险起见先判断。
        if not chunk.choices:
            continue

        # delta 表示“这一次新增的内容”。
        delta = chunk.choices[0].delta

        # delta.content 可能是 None。
        # 只有真的有文本内容时，才 yield 给外部。
        if delta.content:
            yield delta.content
```
3. `config.py`,从根目录的环境变量文件中读取api key:
```py
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file="../.env",
        env_file_encoding="utf-8",
        extra="ignore",
    )
    DEEPSEEK_API_KEY: str = ""
    DEEPSEEK_URL: str = "https://api.deepseek.com"


settings = Settings()
```

4. `main.py`,用uvicorn启动fastapi后端:
```py
import uvicorn
from app.core.route import app


def main():
    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=8000,
        workers=1,
    )


if __name__ == "__main__":
    main()
```

之后只需运行`uv run main.py`即可.


#### 前端编写
1. 初始化nextjs框架:
```bash
pnpm create next-app@latest frontend --use-pnpm
```
2. 进入前端文件夹后单独导入自己喜欢的shadcn样式:
```bash
pnpm dlx shadcn@latest init --preset b0
```
3. 加入一些常用的组件:
```bash
pnpm dlx shadcn@latest add button card input textarea
```

之后按照这个示意图添加两个路由文件和两个工具文件`api.ts`即可,其他的文件都是上述初始化过程自带的:
![示意图](PixPin_2026-05-25_16-05-36.webp)

1. `config/api.ts`: 核心路由:
```ts
export const API_BASE_URL = "http://127.0.0.1:8000";

export const API_ROUTES = {
//   health: `${API_BASE_URL}/api/health`, 实际上没用到
  authCheck: `${API_BASE_URL}/api/auth`,
  chatStream: `${API_BASE_URL}/api/chat`,
};
```
- 可以看到,如果不使用自动化工具的话,我们实质上需要一条条在这里列出后端的路由.

2. `lib/api.ts`: 工具请求函数:
```ts
import { API_ROUTES } from "@/config/api";


// 这个函数用来请求后端的假登录检查
export async function checkAuth() {
  const response = await fetch(API_ROUTES.authCheck);

  if (!response.ok) {
    throw new Error("认证检查失败");
  }

  return response.json();
}

export async function streamChatMessage(
  message: string,
  onChunk: (chunk: string) => void,
) {
  // 发送 POST 请求给 FastAPI
  const response = await fetch(API_ROUTES.chatStream, {
    method: "POST",

    // 告诉后端：我发送的是 JSON
    headers: {
      "Content-Type": "application/json",
    },

    // 把 JS 对象转成 JSON 字符串
    // 后端的 ChatMessage 会接收这里的 message
    body: JSON.stringify({
      message,
    }),
  });

  // 如果后端返回错误，就抛出异常
  if (!response.ok) {
    const errorText = await response.text();
    throw new Error(errorText || "聊天接口请求失败");
  }

  // response.body 是浏览器提供的流式响应体
  // 如果没有 body，说明当前环境不支持流式读取
  if (!response.body) {
    throw new Error("当前浏览器不支持流式响应");
  }

  // 创建 reader，用来一段一段读取后端返回的数据
  const reader = response.body.getReader();

  // TextDecoder 用来把二进制数据转成字符串
  const decoder = new TextDecoder("utf-8");

  // 不断读取流
  while (true) {
    // reader.read() 每次读取一小块数据
    const { done, value } = await reader.read();

    // done 为 true，说明后端流式输出结束
    if (done) {
      break;
    }

    // value 是 Uint8Array，需要解码成字符串
    const chunk = decoder.decode(value, {
      stream: true,
    });

    // 把这一小段文本交给页面使用
    onChunk(chunk);
  }
}
```

3. `auth/page.tsx`:
```tsx
"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";

import { Button } from "@/components/ui/button";
import { checkAuth } from "@/lib/api";

export default function AuthPage() {
  // 用来跳转页面
  const router = useRouter();

  // 保存后端返回的信息
  const [message, setMessage] = useState("请点击按钮检查登录状态");

  async function handleCheckAuth() {
    // 点击按钮后，进入加载状态

    try {
      // 请求 FastAPI 的 /api/auth/check
      const data = await checkAuth();

      if (data.ok) {
        sessionStorage.setItem("authPassed", "true");

        // 显示后端返回的信息
        setMessage(data.message ?? "验证成功，正在跳转到首页...");

        // 验证成功后跳回根路由
        setTimeout(() => {
          router.replace("/");
        }, 1000);
      } else {
        // 如果后端返回 ok: false，就停留在 auth 页面
        setMessage("验证失败，请稍后再试");
      }
    } catch (error) {
      // 如果后端没有启动、接口写错、跨域失败，都会进入这里
      setMessage("请求认证接口失败");
    }
  }

  return (
    <main className="mx-auto flex min-h-screen max-w-2xl flex-col items-center justify-center gap-6 p-8">
      <h1 className="text-3xl font-bold">Auth Page</h1>

      <p className="rounded-lg border p-4">{message}</p>

      <Button onClick={handleCheckAuth}>{"检查登录状态"}</Button>
    </main>
  );
}
```

4. `chat/page.tsx`: 聊天界面
```tsx
"use client";

import { useState } from "react";

import { Button } from "@/components/ui/button";
import { Textarea } from "@/components/ui/textarea";

import { streamChatMessage } from "@/lib/api";

export default function ChatPage() {
  // 保存用户输入的问题
  const [message, setMessage] = useState("");

  // 保存模型返回的答案
  const [answer, setAnswer] = useState("");

  // 保存加载状态
  const [loading, setLoading] = useState(false);

  // 保存错误信息
  const [error, setError] = useState("");

  // 表单提交时执行这个函数
  async function handleSubmit(event: any) {
    // 阻止浏览器默认刷新页面
    event.preventDefault();

    // 去掉前后空格后，如果没有内容，就不发送请求
    if (!message.trim()) {
      return;
    }

    // 每次提问前，先清空旧答案和旧错误
    setAnswer("");
    setError("");

    // 进入加载状态
    setLoading(true);

    try {
      // 调用封装好的流式请求函数
      await streamChatMessage(message, (chunk) => {
        // 每收到一小段内容，就追加到 answer 后面
        setAnswer((prev) => prev + chunk);
      });
    } catch (err) {
      // 如果请求失败，就把错误显示到页面上
      if (err instanceof Error) {
        setError(err.message);
      } else {
        setError("发生未知错误");
      }
    } finally {
      // 无论成功还是失败，最后都退出加载状态
      setLoading(false);
    }
  }

  return (
    <main className="mx-auto flex min-h-screen max-w-3xl flex-col gap-6 p-8">
      <section className="space-y-2">
        <h1 className="text-3xl font-bold">AI Chat</h1>
        <p className="text-muted-foreground">
          这个页面会调用 FastAPI 的 /api/chat/stream 接口。
        </p>
      </section>

      <form onSubmit={handleSubmit} className="space-y-4">
        <Textarea
          value={message}
          onChange={(event) => setMessage(event.target.value)}
          placeholder="请输入你想问 AI 的问题"
          className="min-h-32"
        />

        <Button type="submit" disabled={loading}>
          {loading ? "生成中..." : "发送"}
        </Button>
      </form>

      {error && (
        <div className="rounded-lg border border-red-300 p-4 text-red-600">
          {error}
        </div>
      )}

      <section className="rounded-lg border p-4">
        <h2 className="mb-2 font-semibold">模型回答</h2>

        {answer ? (
          <pre className="whitespace-pre-wrap text-sm leading-7">{answer}</pre>
        ) : (
          <p className="text-sm text-muted-foreground">还没有回答。</p>
        )}
      </section>
    </main>
  );
}
```

之后运行`npm run dev`即可看到大致效果.


#### 缓存问题
如果你成功的按照上述教程编写了所有的前端和后端,与AI对话时你会发现并没有实现流式输出,相反,所有消息都是一次性吐出来的:
![效果图](PixPin_2026-05-25_16-09-23.webp)

我们可以按f12打开控制台看一下api的响应:
![示意图](PixPin_2026-05-29_16-57-59.webp)

我们需要知道一个事实:
>浏览器会默认帮我们缓存服务器传来的响应体,如果我们希望浏览器不要缓存,就需要在响应头里的`Cache-Control`字段对浏览器明确说明.
>
>幸好,fastapi支持直接定制我们想要的响应头


所以,我们需要修改之前的`route.py`中的最后一个路由,变成这个样子:
```py
@app.post("/api/chat", response_class=StreamingResponse)
async def chat(request: ChatMessage):
    # return stream_agent(request.message)

    return StreamingResponse(
        stream_agent(request.message),
        headers={
            "Cache-Control": "no-cache",
        },
    )
```
- `response_class`字段实际上现在是冗余的,但写上也没有问题

最后这个简单的智能体就大功告成了.

### ch6: 给智能体加入数据库(待补充)
# Python机器学习
