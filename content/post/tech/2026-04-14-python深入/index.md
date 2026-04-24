---
title: python深入
tags:
  - python
date: 2026-04-14 08:00:00
categories:
  - 动态更新
image: 88252299_p0-私服.webp
---
python最大的魅力在于各种各样的第三方库让它能够适配几乎所有的应用场景

- [官方文档](https://docs.python.org/zh-cn/3.11/tutorial/classes.html)
  - 学习python的各种疑难问题都是因为没有去阅读第一手资料

# python类
>如果用 C++ 术语来描述的话，类成员（包括数据成员）通常为 public,所有成员函数都为 virtual
## super()详解
## self详解
由于python没有指针,自然也没有this指针,但又需要像cpp一样,提供一个直接访问类内函数或者变量的方法,所以python引入了关键字self.

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


# 关键字与内置函数

## with
## is和is not
## yield
## try finally catch throw
## async与await
- 于2015年的python3.5引入


## assert
- [官方文档](https://docs.python.org/3/reference/simple_stmts.html)
- [菜鸟教程](https://www.runoob.com/python3/python3-assert.html)
**基础用法**
```py
assert expression
# 等价于:
if __debug__:
    if not expression:
        raise AssertionError
```
**报错后输出提示**
```py
import sys
assert ('linux' in sys.platform), "该代码只能在 Linux 下执行"
```
# 常用语法糖
- [官方文档](https://docs.python.org/3/library/functions.html#classmethod)
## @classmethod
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
## @property
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
## @dataclass
- [官方文档](https://docs.python.org/zh-cn/3/library/dataclasses.html)
- [参考教程](https://www.cnblogs.com/wang_yb/p/18077397)
### 是什么,怎么用
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
自然,python打印类的时候默认是打印类的内存地址的,这需要我们去单独实现一个打印函数返回类中的各种信息.

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


# 类型注释
类型注释在PEP484中引入,也就是2015年的python3.5,从而在很大程度上解决了python动态类型带来的混乱.
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
- [官方文档](https://docs.python.org/zh-cn/3/library/typing.html)

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

在现代python项目中,有三种情况会用到它:
1. 某一个变量支持不同类型的值
2. 你不知道它应该是什么值
3. 无论它是什么值都无所谓

显然,如果你全用Any的话也可以通过类型检查,但这样就没有意义了.


# 格式检查
## ruff
### 是什么,怎么用
ruff是用rust编写的python格式检查库,可以迅速将py文件规范化,速度比一版的格式检查库都要快很多.


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

# 测试
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
pytest在python测试库中占据了统治地位,而python系统库自带的unittest就显得逊色很多了,故测试库里我只介绍pytest.

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
python app/tests_pre_start.py
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

![alt text](PixPin_2026-04-01_18-37-20.webp)
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
# Cpython
# rst文件
有时候会在一些古老的python项目中看到`README.rst`文件,由于rst的语法跟md比起来差别比较大,因此需要在这里介绍一下.

## 历史
- [wiki](https://en.wikipedia.org/wiki/ReStructuredText)
rst的全称是reStructuredText,是一个于2001年发布的文档语言,而更为常用的md则于2004年发布,由于存在一定空窗期,故语法更为繁琐的rst仍然占据了一定的文档语言市场,并在早期的python项目中大量使用.

## 用法
- [官方网站](https://docutils.sourceforge.io/rst.html)
真想深入了解的话还是自己上网站查吧,因为尽管rst文件比较繁琐,但是层次还是清晰分明的:
```rst
backtrader
==========

.. image:: https://img.shields.io/pypi/v/backtrader.svg
   :alt: PyPi Version
   :scale: 100%
   :target: https://pypi.python.org/pypi/backtrader/

..  .. image:: https://img.shields.io/pypi/dm/backtrader.svg
       :alt: PyPi Monthly Donwloads
       :scale: 100%
       :target: https://pypi.python.org/pypi/backtrader/

.. image:: https://img.shields.io/pypi/l/backtrader.svg
   :alt: License
   :scale: 100%
   :target: https://github.com/backtrader/backtrader/blob/master/LICENSE
.. image:: https://travis-ci.org/backtrader/backtrader.png?branch=master
   :alt: Travis-ci Build Status
   :scale: 100%
   :target: https://travis-ci.org/backtrader/backtrader
.. image:: https://img.shields.io/pypi/pyversions/backtrader.svg
   :alt: Python versions
   :scale: 100%
   :target: https://pypi.python.org/pypi/backtrader/

**Yahoo API Note**:

  [2018-11-16] After some testing it would seem that data downloads can be
  again relied upon over the web interface (or API ``v7``)

**Tickets**

  The ticket system is (was, actually) more often than not abused to ask for
  advice about samples.

For **feedback/questions/...** use the `Community <https://community.backtrader.com>`_

Here a snippet of a Simple Moving Average CrossOver. It can be done in several
different ways. Use the docs (and examples) Luke!
::

  from datetime import datetime
  import backtrader as bt

  class SmaCross(bt.SignalStrategy):
      def __init__(self):
          sma1, sma2 = bt.ind.SMA(period=10), bt.ind.SMA(period=30)
          crossover = bt.ind.CrossOver(sma1, sma2)
          self.signal_add(bt.SIGNAL_LONG, crossover)

  cerebro = bt.Cerebro()
  cerebro.addstrategy(SmaCross)

  data0 = bt.feeds.YahooFinanceData(dataname='MSFT', fromdate=datetime(2011, 1, 1),
                                    todate=datetime(2012, 12, 31))
  cerebro.adddata(data0)

  cerebro.run()
  cerebro.plot()

Including a full featured chart. Give it a try! This is included in the samples
as ``sigsmacross/sigsmacross2.py``. Along it is ``sigsmacross.py`` which can be
parametrized from the command line.

Features:
=========

Live Trading and backtesting platform written in Python.

  - Live Data Feed and Trading with

    - Interactive Brokers (needs ``IbPy`` and benefits greatly from an
      installed ``pytz``)
    - *Visual Chart* (needs a fork of ``comtypes`` until a pull request is
      integrated in the release and benefits from ``pytz``)
    - *Oanda* (needs ``oandapy``) (REST API Only - v20 did not support
      streaming when implemented)

  - Data feeds from csv/files, online sources or from *pandas* and *blaze*
  - Filters for datas, like breaking a daily bar into chunks to simulate
    intraday or working with Renko bricks
  - Multiple data feeds and multiple strategies supported
  - Multiple timeframes at once
  - Integrated Resampling and Replaying
  - Step by Step backtesting or at once (except in the evaluation of the Strategy)
  - Integrated battery of indicators
  - *TA-Lib* indicator support (needs python *ta-lib* / check the docs)
  - Easy development of custom indicators
  - Analyzers (for example: TimeReturn, Sharpe Ratio, SQN) and ``pyfolio``
    integration (**deprecated**)
  - Flexible definition of commission schemes
  - Integrated broker simulation with *Market*, *Close*, *Limit*, *Stop*,
    *StopLimit*, *StopTrail*, *StopTrailLimit*and *OCO* orders, bracket order,
    slippage, volume filling strategies and continuous cash adjustmet for
    future-like instruments
  - Sizers for automated staking
  - Cheat-on-Close and Cheat-on-Open modes
  - Schedulers
  - Trading Calendars
  - Plotting (requires matplotlib)
```

- 不过看到一个库用的是README.rst而不是通用的README.md的时候还是建议尽早绕道,因为这个库一定用的都是老掉牙的实践方式和相关库.


