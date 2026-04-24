---
title: 2026-01-19 python语法
tags:
  - python
date: 2026-01-19 08:00:00
image: 68936009_p0-日向の幽霊.webp
---

## 基础语法
### 变量
>所有变量都无需指明类型,统一作为一个可变指针对象,可以随时改变值和内存大小
### 顺序结构

#### list

```python
# Python list

a = [1, 2, 3, 4, 5]

# 访问 / 修改
x = a[0]
a[1] = 10

# 长度
n = len(a)

# 遍历
for v in a:
    pass

for i in range(len(a)):
    pass

# 追加
a.append(6)

# 插入
a.insert(1, 99)

# 删除
a.pop()
a.pop(1)
a.remove(3)

# 切片 list[start:end:step]
b = a[1:4]
c = a[:3]
d = a[::2]

# 查找
flag = 3 in a
idx = a.index(3)

# 排序 / 反转
a.sort()
a.reverse()
```

```cpp
// C++ array + vector

#include <vector>
#include <algorithm>
using namespace std;

int main() {
    int arr[5] = {1, 2, 3, 4, 5};

    // 访问 / 修改
    int x = arr[0];
    arr[1] = 10;

    // 长度
    int n_arr = sizeof(arr) / sizeof(arr[0]);

    // 遍历
    for (int i = 0; i < n_arr; i++) {}

    for (int v : arr) {}

    // vector
    vector<int> v = {1, 2, 3, 4, 5};

    // 访问 / 修改
    int y = v[0];
    v[1] = 10;

    // 长度
    int n_vec = v.size();

    // 遍历
    for (int i = 0; i < v.size(); i++) {}

    for (int x : v) {}

    // 追加
    v.push_back(6);

    // 插入
    v.insert(v.begin() + 1, 99);

    // 删除
    v.pop_back();
    v.erase(v.begin() + 1);

    // 查找
    bool found = find(v.begin(), v.end(), 3) != v.end();

    // 排序 / 反转
    sort(v.begin(), v.end());
    reverse(v.begin(), v.end());

    return 0;
}
```
>很显然两个语言都是T.method,function(T)这样混着用的,真的不好记啊
当然也可以解释说function是作为外部函数,并非单独一个数据结构的对象

>看得出来python的index也是左闭右开的
#### tuple

```python
tup1=(1,2,3,4,5)
tup2=(6,7,8,9,10)
tup3=tup1+tup3
```
>没什么好解释的,就是不可变的列表而已,相当于加了const,但是可以转换成list,元组之间也能连接
#### dict

```python
# Python dict（字典）示例

# 创建
d = {"apple": 3, "banana": 5, "cherry": 2}
d2 = dict(a=1, b=2, c=3)

# 访问
x = d["apple"]      # 3
y = d.get("banana") # 5
z = d.get("orange", 0) # 指定默认值

# 修改 / 添加
d["apple"] = 10
d["orange"] = 7

# 删除
del d["banana"]
val = d.pop("cherry")     # 删除并返回值
val2 = d.pop("pear", 0)   # 指定默认返回值

# 遍历
for key in d:
    print(key, d[key])

for key, value in d.items():
    print(key, value)

# 检查键是否存在
if "apple" in d:
    print("exists")

# 获取所有键 / 值 / 项
keys = d.keys()
values = d.values()
items = d.items()

# 合并字典
d3 = {**d, **d2}  # Python 3.5+ 支持
```

```cpp
#include <map>
#include <iostream>
using namespace std;

int main() {
    // 1. 创建 map
    map<string, int> m;

    // 2. 插入元素
    m["apple"] = 3;
    m["banana"] = 5;
    m.insert({"cherry", 2});  // 另一种插入方式

    // 3. 访问元素
    int x = m["apple"];      // 如果 key 不存在，会自动创建默认值 0
    int y = m.at("banana");  // 如果 key 不存在，会抛出 out_of_range 异常

    // 4. 修改元素
    m["apple"] = 10;

    // 5. 删除元素
    m.erase("banana");       // 删除指定 key
    // m.clear();            // 删除所有元素

    // 6. 遍历 map
    for (auto &pair : m) {
        cout << pair.first << ": " << pair.second << endl;
    }

    // 7. 查找元素
    auto it = m.find("cherry");  // 返回迭代器
    if (it != m.end()) {
        cout << "Found cherry: " << it->second << endl;
    }

    return 0;
}
```
>dict 用hash table实现,故具有随机性,而map是用红黑树实现的,可以做到有序
#### set

```python
# Python set（集合）示例

# 1. 创建
s = {1, 2, 3, 4, 5}
s2 = set([3, 4, 5, 6, 7])
s3 = set()  # 空集合，不能写 {}，会被当作 dict

# 2. 添加元素
s.add(6)
s.update([7, 8])  # 批量添加

# 3. 删除元素
s.remove(2)   # key 不存在会报 KeyError
s.discard(10) # key 不存在也不会报错
val = s.pop() # 随机删除一个元素并返回
s.clear()     # 删除所有元素

# 4. 遍历
for x in s:
    print(x)

# 5. 集合运算
a = {1,2,3}
b = {3,4,5}

union_set = a | b       # 并集
intersection_set = a & b # 交集
diff_set = a - b         # 差集
symmetric_diff = a ^ b   # 对称差集

# 6. 判断成员
if 3 in a:
    print("exists")
if 10 not in a:
    print("not exists")
```

```cpp
#include <set>
#include <unordered_set>
#include <iostream>
using namespace std;

int main() {
    // std::set：有序集合
    set<int> s = {1,2,3,4,5};
    s.insert(6);       // 添加元素
    s.erase(2);        // 删除元素
    for(int x : s)
        cout << x << " "; // 输出有序: 1 3 4 5 6
    cout << endl;

    // std::unordered_set：无序集合
    unordered_set<int> us = {3,4,5,6,7};
    us.insert(8);
    us.erase(5);
    for(int x : us)
        cout << x << " "; // 输出顺序不定
    cout << endl;

    // 查找
    if(s.find(3) != s.end())
        cout << "3 exists in set" << endl;

    return 0;
}
```
>只是比dict和map少了一个值的存储,因此数据结构仍然不变
### 控制语句
#### 选择语句
```python
x = 10

if x > 0:
    y = 1
elif x == 0:
    y = 0
else:
    y = -1
```
>看得出来`else if`还是太长了,而`switch case`大多数时候是真的没有用
#### 循环结构

```python
# for 循环
for i in range(5):
    pass

# 遍历容器
a = [1, 2, 3]
for v in a:
    pass

# while 循环
i = 0
while i < 5:
    i += 1

# break / continue
for i in range(10):
    if i == 3:
        continue
    if i == 7:
        break
```

### 函数与模块
- python函数不需要指定返回类型,return也是可选的
- 如果没写return或者return后没有东西,则返回None
- 其余的函数语法和cpp差不多
```python
def printHello():
    print('hello')
    
def add(a, b=0):
    return a + b

x = add(3, 4)
y = add(5)
```

#### 模块

```python
# math_utils.py
def square(x):
    return x * x
# 1.py
import math_utils

v = math_utils.square(5)
# 2.py
from math_utils import square

result = square(10)
# 3.py 
from math_utils import square  as sq
result=sq(10)
# 4.py
from math_utils import *

result=square(10)
# 5.py
import math_utils as math

v = math.square(5)
```
### oop
>最值得一提的特征就是python没有public,protected,private这样的限定符,而是通过下划线来区分,
#### 概览
**python**
```python
# my_class.py

class MyClass:
    def __init__(self, value: int):
        self.__value = value  # 私有成员

    def get(self) -> int:
        return self._value

    def set(self, value: int) -> None:
        self._value = value


# main.py
from my_class import MyClass

obj = MyClass(10)
print(obj.get())   # 10
obj.set(20)
print(obj.get())   # 20
```
- python不使用隐式的this指针,而是要显式写明self,调用的时候则可以忽略self
- 对象也和变量一样直接用'='赋值即可
**cpp**
```cpp
// MyClass.h
#ifndef MYCLASS_H
#define MYCLASS_H

class MyClass {
public:
    MyClass(int v);        // 构造函数（类内声明）
    ~MyClass();            // 析构函数（类内声明）

    int get() const;       // 成员函数（类内声明）
    void set(int v);

private:
    int value;
};

#endif
```

```cpp
// MyClass.cpp
#include "MyClass.h"

MyClass::MyClass(int v) : value(v) {}

MyClass::~MyClass() {}

int MyClass::get() const {
    return value;
}

void MyClass::set(int v) {
    value = v;
}
```

```cpp
// main.cpp
#include <iostream>
#include "MyClass.h"

int main() {
    MyClass obj(10);
    std::cout << obj.get() << std::endl;
    obj.set(20);
    std::cout << obj.get() << std::endl;
}
```
>python做不到像cpp一样的类内声明和类外实现,只能用下面的例子所述直接添加方法和成员,但这样或许还方便一点,就不需要用到难用的cmake了
```python
from my_class import MyClass

def add_double():
    def double(self):
        return self.x * 2
    MyClass.double = double
```

#### 构造函数
>如果不指定__init__就只有一个默认为空的实现
```python
class MyClass:
    def __init__(self, value):
        self.value = value  # 初始化成员变量

obj = MyClass(10)
print(obj.value)  # 10
```
#### 析构函数
>基本用不上,因为python内部就能实现垃圾回收
```python
class MyClass:
    def __init__(self, value):
        self.value = value

    def __del__(self):
        print(f"MyClass({self.value}) 被销毁")

obj = MyClass(5)
del obj  # 手动删除会立即调用 __del__

```

#### 实例属性和类属性
- **实例属性**：每个对象独立，存储在实例字典中  
- **类属性**：所有实例共享，存储在类字典中
```python
class MyClass:
    class_attr = 0  # 类属性

    def __init__(self, value):
        self.instance_attr = value  # 实例属性

obj1 = MyClass(10)
obj2 = MyClass(20)

print(obj1.instance_attr)  # 10
print(obj2.instance_attr)  # 20

print(obj1.class_attr)     # 0
print(obj2.class_attr)     # 0

MyClass.class_attr = 5
print(obj1.class_attr)     # 5
print(obj2.class_attr)     # 5
```
#### 私有成员和公有成员
- Python 没有真正的私有成员，使用约定 _name 或双下划线 __name

- 公有成员无前导下划线，直接访问
```python
class MyClass:
    def __init__(self):
        self.public = 1        # 公有
        self._protected = 2    # 受保护（约定）
        self.__private = 3     # 私有（name mangling）

obj = MyClass()
print(obj.public)       # 1
print(obj._protected)   # 2
# print(obj.__private)  # ❌ 报错
print(obj._MyClass__private)  # 3，通过 name mangling 访问

```

#### 公有,私有,静态方法
- **公有方法**：默认，无下划线，任何地方可调用  
- **私有方法**：双下划线 `__name`，name mangling，限制外部访问  
- **静态方法**：`@staticmethod`，不接收 `self` 或 `cls`，独立于实例和类
```python
class MyClass:
    def public_method(self):
        print("公有方法")

    def __private_method(self):
        print("私有方法")

    @staticmethod
    def static_method(x, y):
        return x + y

obj = MyClass()
obj.public_method()          # 公有方法
# obj.__private_method()     # ❌ 报错
obj._MyClass__private_method()  # 私有方法，通过 name mangling 访问
print(MyClass.static_method(2,3))  # 静态方法，直接通过类调用
```
#### 类的继承
- 私有成员和私有方法不会被继承,需要这样调用`self._Parent__private_method()`
- 构造函数默认不继承,需要重写,但可以调用基类的构造函数
- 不过构造函数的前导双下划线说明了他是私有成员不可被继承,也可以说是设计的一个巧思

```python
class Animal:
    def speak(self):
        print("Animal speaks")

class Dog(Animal):
    def speak(self):
        print("Dog barks")  # 重写方法

dog = Dog()
dog.speak()  # Dog barks

# 多重继承
class Walker:
    def walk(self):
        print("Walking")

class SuperDog(Dog, Walker):
    pass

sd = SuperDog()
sd.speak()  # Dog barks
sd.walk()   # Walking

```

#### 多态
- 多态：**同一接口，不同对象，表现出不同行为**
```python
class Animal:
    def speak(self):
        print("Animal speaks")

class Dog(Animal):
    def speak(self):
        print("Dog barks")

class Cat(Animal):
    def speak(self):
        print("Cat meows")

def make_sound(obj):
    obj.speak()   # 只要求对象“有 speak 方法”

make_sound(Dog())  # Dog barks
make_sound(Cat())  # Cat meows
```
>也就是说同一个方法可以直接由子类继承并完成不同的实现,而cpp里必须得先写明该方法是virtual,子类中要写明override,相比起来麻烦了不少
```cpp
// C++ 多态（基于继承 + 虚函数）
#include <iostream>
using namespace std;

class Animal {
public:
    virtual void speak() {          // 必须是 virtual
        cout << "Animal speaks" << endl;
    }
    virtual ~Animal() {}             // 多态基类必须有虚析构
};

class Dog : public Animal {
public:
    void speak() override {
        cout << "Dog barks" << endl;
    }
};

class Cat : public Animal {
public:
    void speak() override {
        cout << "Cat meows" << endl;
    }
};

void make_sound(Animal* a) {          // 基类指针
    a->speak();                       // 运行时多态
}

int main() {
    Dog d;
    Cat c;
    make_sound(&d);
    make_sound(&c);
}
```
## python工程详解
>所谓工程,其实我指的只是本地各层级文件夹和文件之间python文件的相互导入而已

```python
from same_source_file import test
# 导入同级文件,不属于一个包,是单独的脚本
from .same_source_file import test
# 导入同级文件,前提是当前文件属于一个包,也就是说跟__init__.py在一起
from same_source_dir import test
# 这是将同级文件夹作为包导入
from same_source_dir import inner_file 
# 这是将同级文件夹中的特定文件导入
from same_source_dir.inner_file  import test
# 这是将同级文件夹中的特定文件中的某个方法导入
```

### 模块的导入

```python
#1.py
from fastapi import FastAPI
app = FastAPI()
#2.py
import fastapi
app=fastapi.FastAPI()
#3.py
import fastapi as fa
app=fa.FastAPI()
#4.py
from fastapi import FastAPI as fa
app =fa()
```
>看得出来各个写法各有各的好处,得看对应的工程文件的大小和规模因地制宜

## 内置函数
### enumerate()
有两个参数: 迭代对象和索引起始位置,默认从零开始
```py
# with open("weekly_hiring_comments.json", "r", encoding="utf-8") as f:
#         posts = json.load(f)

# out = Path("weekly_hiring_comments.md")

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
看代码便知道,这个i就是我们要用的索引,p就是遍历对象内的元素,这里则是一个字典
