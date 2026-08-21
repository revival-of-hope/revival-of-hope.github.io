---
title: "智能体构建教程-fastapi与nextjs强强联手!"
date: 2026-07-27T16:41:18+08:00
description: 封面图片也很适配呢~
image: 67189487_p0-最凶最悪.webp
tags: 
    - AI
math: 
---
## ch0: 前言
- 星星之火,可以燎原

最近两年的AI浪潮对普通的程序员来说根本算不上是好事,究其根本,还是因为开源的精神丢失掉了,在AI爆发之前,尽管大公司高筑壁垒,但总会或多或少的发布开源产品或者参与开源软件的开发,而随着GPT4.0的轰动出世,所有人都意识到,这并不是能够轻易开源的东西.

头部公司花费大量资金投入AI研发,最终得到的无非是用于训练的PB级数据和训练得到的万亿级参数,即便是一些大公司发布的所谓开源模型,也仅仅是开源了参数而已,而对于训练数据集他们向来都是遮遮掩掩的.毕竟这才是核心的地方,即便拿到了标准的架构,如果没有数据,又何谈进行训练呢?

不过,就算拿到了数据集,现在也没用了,因为参数规模已经到了一个可怕的程度,即便是Deepseek-V3,参数量就有671B了,而近两年的模型,参数量都是在万亿级别的.

- [推测](https://en.theblockbeats.news/flash/343837)

这么大规模的模型训练,需要成百上千万张显卡的协同操作,这已经完全超出了普通人所能触及的界限了,用带了4060显卡的电脑跑了几个B的模型玩玩就可以了.

因此,AI浪潮与草根程序员并没有任何关系,就算你懂得了基本原理,又何谈去贡献自己的力量呢.

所以,唯一能让自己有点参与感的方法就是去调用大公司恩赐下来的API,并通过自己的手段来优化API的使用,帮助更多的普通人以更简单的方式接触和认识AI.这也是我写这篇教程的部分初衷.

>不敢说我的教程写的有多好,但我保证我的技术栈是最前沿的,前端用的是最新版本的next.js 16,后端用的是fastapi+sqlmodel,使用uv管理python包,加上docker compose部署,翻遍GitHub仓库都很难找到一个差不多的项目吧.
# fastapi基础
## ch1: 使用fastapi响应普通的网络请求
### CORS问题
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
#### CORS
- [wiki](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing)

CORS的全称为**Cross-origin resource sharing**,翻译成中文就是跨域资源共享,**它允许一个前端页面通过一个不同的域名/端口来访问服务器端口提供的页面**.

而浏览器不能保证另一个端口/域名的网页是善意的,如果允许它直接访问服务器端口页面,可能造成非常恶劣的影响,因此需要跨域请求带上`Access-Control-Allow-Origin`请求头,如果请求头里的信息合规,就放行这次请求,返回正常页面.

#### 跨域中间件
鉴于一个网络服务只能占用一个端口,我们不可能将前端页面也放到后端页面的同一个端口上,为了让前端页面能够正常跨域访问后端端口,**跨域中间件**(CORSMiddleware)这一工具就派上用场了.

>当你配置了 CORSMiddleware 后，每当一个请求进入 FastAPI 并准备返回时，中间件会根据你的配置自动在返回的 HTTP Header 中插入以下字段：

1. `Access-Control-Allow-Origin`: 告诉浏览器哪些域（Origin）可以访问数据。如果你设为 ["*"]，它就会加上 `Access-Control-Allow-Origin: *`。
2. `Access-Control-Allow-Methods`: 告诉浏览器允许哪些请求方法（如 GET, POST, PUT）。
3. `Access-Control-Allow-Headers`: 告诉浏览器允许哪些自定义请求头。
#### 回到主题
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
### 路由编写
一个简单的路由写法如下:
```py
from fastapi import FastAPI

app = FastAPI()


@app.get("/items/{item_id}")
async def read_item(item_id):
    return {"item_id": item_id}
```
当用户访问`/items/newitem`时,fastapi会自动将`newitem`传入`read_item`函数中并返回对应的值.

#### 查询参数
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

#### 查询参数的校验
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
#### 路径参数的校验
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

### 请求体与不同的网络请求方法
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
1. **如果该参数也在路径中声明了，它就是路径参数**。
2. 如果该参数是（int、float、str、bool 等）单一类型，它会被当作查询参数。
3. 如果该参数的类型声明为 Pydantic 模型，它会被当作请求体。
4. 如果这三点它都不满足,那么就是普通的参数了.

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

#### 请求体的进阶写法
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
### 定制响应体
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

### 响应状态码
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
### 返回错误
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
## ch2: 使用fastapi处理网络安全
### 实战代码
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

### fastapi中的依赖
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

### 网络安全规范: OAuth2
- [阮一峰教程](https://www.ruanyifeng.com/blog/2019/04/oauth_design.html)

>简单说，OAuth 就是一种授权机制。数据的所有者告诉系统，同意授权第三方应用进入系统，获取这些数据。系统从而产生一个短期的进入令牌（token），用来代替密码，供第三方应用使用。

令牌（token）与密码（password）的作用是一样的，都可以进入系统，但是有三点差异。

（1）令牌是短期的，到期会自动失效，用户自己无法修改。密码一般长期有效，用户不修改，就不会发生变化。

（2）令牌可以被数据所有者撤销，会立即失效。以上例而言，屋主可以随时取消快递员的令牌。密码一般不允许被他人撤销。

（3）令牌有权限范围（scope），比如只能进小区的二号门。对于网络服务来说，只读令牌就比读写令牌更安全。密码一般是完整权限。


总结一下就是,当服务器将token(令牌)返回给客户端后,用户之后访问页面时,只需要使用令牌进行验证就行了,不再需要每次都输入用户名和密码了.
### OAuth2PasswordBearer库
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

### Python加密库
>本来应该单独提到第二级标题来讲的,但放到这里更能贴合实战的情景,而这些库本来也就是用来处理网络通信的.
#### 前置概念: JWT与token防伪
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

#### pyjwt
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
#### 前置概念: 如何加密密码
- [一个非常好的介绍文章](https://draven.co/whys-the-design-password-with-md5/)

如参考文章中所提到的那样,普通的哈希函数由于存在哈希碰撞和彩虹表破解的风险,所以完全不推荐用来加密密码,而是应该使用`Argon2`,`Brypt`等现代的专用加密算法.

至于具体原理可以去搜寻论文解决,我们只要知道目前它们是绝对安全的,可以用来加密密码就可以了.

- 以前的哈希函数都需要我们额外存储盐,而现代加密函数的盐都是内置的.
#### pwdlib
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
### 回到实战代码
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



## ch3: 使用fastapi处理数据库
>FastAPI 并不要求你使用 SQL（关系型）数据库。你可以使用你想用的任何数据库。

由于SQLModel的作者与fastapi的作者是同一个人,所以这两个库是高度适配的,我接下来也会按照fastapi的官方教程来展示使用fastapi处理SQLModel.

### 搭建初始环境
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

### 针对客户请求做出响应
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


## ch4: 使用fastapi进行测试
- [参考文档](https://fastapi.tiangolo.com/zh/tutorial/testing/#using-testclient)
>没有测试的代码不是好代码

### 基本用法
需要先导入`httpx2`库才可以使用.
```py
from fastapi import FastAPI
from fastapi.testclient import TestClient

app = FastAPI()


@app.get("/")
async def read_main():
    return {"msg": "Hello World"}


client = TestClient(app)


def test_read_main():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"msg": "Hello World"}
```
创建一个客户端后,使用pytest的方式来测试对应的接口即可.

用法其实很简单,创建了一个client就可以跟平常的测试文件一样来写了.
# 智能体搭建
## ch5: 使用fastapi+nextjs搭建简单智能体
>本部分主要会使用fastapi处理deepseek api,这并不需要用到数据库来存储任何信息,所有的信息都在运行时处理.至于前端部分我会大致介绍路由操作,UI等布局细节就由组件库和AI帮我搞定了.

**最终效果:**
![示意图](PixPin_2026-05-24_23-47-49.webp)

### 前置概念: openai库使用
- [Deepseek API文档](https://api-docs.deepseek.com/zh-cn/)
  - 由于OpenAI的官方文档拒绝我访问(??),所以只好看Deepseek的API文档了.

>现在,大部分AI api都使用OpenAI的API规范,包括所有的国产AI,尽管Claude还不支持...
#### 基本用法
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
#### 多轮对话
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



#### 流式输出
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

### StreamingResponse类
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


### 路由构想
>如果不靠ai的话,初学者是很难自己设计出一个好看实用的路由的,建议不断阅读优秀项目的api设计来学习怎么写路由.

我最简化了项目的路由操作,只保留了两个前端路由: `auth`和`chat`,一个对应从数据库中获取用户数据并认证,另一个对应了从API调用信息并返回.前端通过调用后端的api来模拟数据库交互,并调用大模型输出流.

### 后端编写
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


### 前端编写
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


### 缓存问题
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

## ch6: 给智能体加入数据库
### 准备阶段
现在,让我们试着给上面这个智能体加入postgre数据库,我们需要先明确来两个要点.
1. 哪些路由要用到数据库?
2. 数据库中要用到几个表?表的关系如何设定?


#### 要点1: 在哪加入数据库
先看一下我们一开始写的三个路由:
```py
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
    return StreamingResponse(
        stream_agent(request.message),
        headers={
            "Cache-Control": "no-cache",
        },
    )
```

显然,health路由可以用来检查数据库是否成功启动,auth路由可以查看数据库来验证用户,chat路由在返回消息的时候还需要把聊天记录存入数据库.

第一个比较好办,启动一个空查询,如果返回true的话就说明数据库启动了;

第二个需要修改一下,改成用户登录,这需要我们创建一个用户表

第三个比较难办,怎么存储聊天记录? 非流式输出的话我们只需要一次性把消息存入数据库即可,但我们使用的是流式输出,一个简单的想法是把对话累加起来再存入,实现起来确实也很简单.

- 暂时先不加入多轮对话,我们只需保存用户的最新对话及结果,再展示在前端页面即可,不然项目就会一下子变得太复杂了

#### 要点2: 设计表格
设计数据库如果真的去一个个使用BCNF和3NF来检查表的话那就太离谱了,我们先按照上述的路由想法给出两个初始的表格,后续慢慢优化即可.

对于用户来说,我们需要以下的必要信息: 用户id(主键),用户名,密码(先明文存储,做一个伪加密):

```sql
create table User(
    user_id numeric,
    user_name varchar,
    password numeric,
    primary key id
);
```
显然,上述的设计非常糟糕,但我们先放着,等另一个表设计完了再来动它.

对于对话来说,我们实质上只要对话id和最新的对话信息就够了:
```sql
create table ChatMessage(
    chat_id numeric,
    content varchar,
    primary key chat_id,
);
```

现在回头来看User表,我们需要把User和ChatMessage一一关联起来,在只保存最新信息的情况下,这是一个一对一关系,那么我们可以在User表中存储ChatMessage的chat_id作为外键:
```sql
create table User(
    user_id numeric,
    user_name varchar,
    password numeric,
    primary key user_id,
    foreign key chat_id from ChatMessage
);
```
接着,对于加密功能,我们需要实际想象一下整个流程:
1. 用户注册时输入用户名和密码
2. 后端对密码进行哈希处理
3. 数据库存入哈希后的密码和对应的智能体
4. 当用户登录时,我们将用户输入的密码哈希后,与数据库中存储的对应哈希密码比对即可.

那么这实际上需要三张表,一个用于用户注册,一个用于用户登录,一个用于实际的数据库存储,考虑到OOP的设计,我们可以设计第四张表作为父表,方便后续的复用:

```py
class UserBase(BaseModel):
    user_name: str

class UserRegister(UserBase):
    password: str

class UserLogin(UserBase):
    password: str

class User(UserBase):
    user_id: int|None =None
    hashed_password: int
    chat_id: int
```
- 这只是一个初步的设计,所以就没具体按照语法实现了

#### 数据库的一些必要知识
postgresql的url长这样:
```toml
DATABASE_URL = postgresql+psycopg://用户名:密码@主机地址:端口号/数据库名
```
一个完整的示例是这样的:
```toml
DATABASE_URL = postgresql+psycopg://postgres:123456@localhost:5432/my_chat_db
```

非常值得称道的是,pydantic内置了对PostgreSQL的支持,书写这种长长的url也变得很简单了:
```py
from pydantic import (
    PostgresDsn,
    computed_field,
)
class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        # Use top level .env file (one level above ./backend/)
        env_file="../.env",
        env_ignore_empty=True,
        extra="ignore",
    )
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
```

- (26/6/22): 了解了这些知识后,令人痛苦的重构就要开始了,说实话,很多时候重构比全部推翻重做还要难.但这是一个菜鸟项目进阶成为工程项目的必经之路.
### 后端重构阶段
>重构的要点是,让系统不能正常运行的时间尽可能短,否则你做的就不是重构
#### 第一步: 环境变量文件和config.py
先在.env中加入以下字段:
```toml
POSTGRES_SERVER=localhost
POSTGRES_PORT=5432
POSTGRES_DB=app
POSTGRES_USER=postgres
POSTGRES_PASSWORD=123456
```
然后按照之前的示例处理Settings类即可:

**app/utils/config.py**
```py
from pydantic_settings import BaseSettings, SettingsConfigDict
from pydantic import (
    computed_field,
    PostgresDsn,
)


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file="../.env",
        env_file_encoding="utf-8",
        extra="ignore",
    )
    DEEPSEEK_API_KEY: str = ""
    DEEPSEEK_URL: str = "https://api.deepseek.com"

    POSTGRES_SERVER: str
    POSTGRES_PORT: int = 5432
    POSTGRES_DB: str
    POSTGRES_USER: str = ""
    POSTGRES_PASSWORD: str = ""

    @computed_field
    @property
    def DATABASE_URI(self) -> PostgresDsn:
        return PostgresDsn.build(
            scheme="postgresql+psycopg",
            username=self.POSTGRES_USER,
            password=self.POSTGRES_PASSWORD,
            host=self.POSTGRES_SERVER,
            port=self.POSTGRES_PORT,
            path=self.POSTGRES_DB,
        )


settings = Settings()  # type: ignore
```
#### 第二步: 设计模型

**app/models.py**
```py
from sqlmodel import Relationship, SQLModel, Field


class UserBase(SQLModel):
    name: str


class UserRegister(UserBase):
    password: str


class UserLogin(UserBase):
    password: str


class User(UserBase, table=True):
    id: int | None = Field(default=None, primary_key=True)
    hashed_password: str
    chat: list["ChatMessage"] = Relationship(
        back_populates="user",
        cascade_delete=True,
    )


class ChatMessage(SQLModel, table=True):
    chat_id: int | None = Field(default=None, primary_key=True)
    content: str | None = None
    user_id: int | None = Field(foreign_key="user.id")
    user: User | None = Relationship(back_populates="chat")

```
- 尽管UserBase只有一个属性,看上去很蠢,但这却是实现OOP的必要损失.在后面的几章或许我们可以看到为什么需要这么做.
#### 第三步: 加入数据库依赖
首先先创建一个数据库初始化函数`init_db`,由于这个函数很重要,所以单独放在db.py中:

**app/utils/db.py**
```py
from sqlmodel import (
    create_engine,
    SQLModel,
)
from app import models
from app.utils.config import settings

engine = create_engine(str(settings.DATABASE_URI))


def init_db() -> None:
    SQLModel.metadata.create_all(engine)
```
>如果你对SQLModel掌握的比较好的话,你可能会知道调用`create_all`的时候需要在当前文件导入所有的SQLModel表,不过,`from app import models`这里通过巧妙的隐式导入实现了这一点

接着,我们需要实现几个依赖函数,从而避免在每次验证用户和与数据库通信时都要反复调用.

**app/utils/deps.py**
```py
from collections.abc import Generator
from typing import Annotated

from sqlmodel import Session
from app.utils.db import engine
from fastapi import Depends, HTTPException
from app.models import User


def get_db() -> Generator[Session, None, None]:
    with Session(engine) as session:
        yield session


SessionDep = Annotated[Session, Depends(get_db)]


def fake_get_current_user(session: SessionDep) -> User:
    user = session.get(User, 114514)
    if not user:
        raise HTTPException(status_code=404, detail="User Not Found")
    return user


CurrentUser = Annotated[User, Depends(fake_get_current_user)]
```
- `get_db`,用于打开与数据库的连接,将其放进依赖可以有效避免每次显式调用get_db函数的麻烦.

>在目前这个阶段,我们只能实现**虚假的**获取当前用户,主要原因就在于如果不使用token/cookie,那么就无法知道这个用户是谁,一个容易想到的方法就是让用户在前端自己选择id并通过post请求发送给后端,但在现代的工程中不可能使用这种极其危险的方式,所以就不这么做了.

#### 第四步: 加入哈希部分
**app/utils/security.py**
```py
from pwdlib import PasswordHash

hash_method = PasswordHash.recommended()


def verify_password(plain_password: str, hashed_password: str) -> bool:
    return hash_method.verify(plain_password, hashed_password)


def hashing_password(plain_password: str):
    return hash_method.hash(plain_password)
```
两个函数,一个用于验证,一个用于加密
#### 第五步: 初步实现crud.py
先考虑一下要实现之前的三个路由我们要做些什么:
1. 用户注册: 传入`UserRegister`并加密成`User`存入数据库即可,对于这种常见的CRUD操作,pydantic提供了一个魔法: `model_validate`
2. 用户登录: 传入`UserLogin`并与数据库中存储的`User`进行比对,也就是通过id选取数据库中的特定行
   1. 等会,我们并不知道当前用户的id! 没有办法,这里也只能做一个伪装登录了,那么这样一来,创建用户也不用真的创建了,因为读取不了啊
   2. 不过,出于完整性的考虑,我们可以用名字来选取数据库,尽管并非主键,但在我们这个项目里也够用了
3. 用户验证: 如果使用token的话就没必要进行额外验证了,而不使用token的话我们也不知道他是谁,所以这一部分可以直接跳过了
4. 健康检查: 执行一次空查询,检查数据库是否正常.
5. 存储对话数据: 这一步很难想呢,我们如何才能将stream_agent这个流式输出放进数据库呢,不过我们先把这个问题放在一边,先实现上面的4个功能.

最终的代码长这样:

**app/crud.py**
```py
from app.utils.security import (
    verify_password,
    hashing_password,
)
from fastapi import HTTPException
from sqlmodel import Session, select
from app.models import User, UserLogin, UserRegister, ChatMessage


def healthchecker(session: Session):
    result = session.exec(select(1)).one()
    return result == 1


def register_user(session: Session, user_create: UserRegister) -> User:
    user_store = User.model_validate(
        user_create, update={"hashed_password": hashing_password(user_create.password)}
    )
    # 数据库存储
    session.add(user_store)
    session.commit()
    session.refresh(user_store)

    # 返回信息供路由函数处理
    return user_store


def check_user(session: Session, user_login: UserLogin, user_db: User):
    user = session.exec(select(User).where(user_login.name == user_db.name)).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    if not verify_password(UserLogin.password, User.hashed_password):
        raise HTTPException(status_code=401, detail="Invalid username or password")
    return user

```


回到上面的问题,答案很明显,放不进去,所以我们现在要把`client.py`也重构一遍,最好是设计成一个好用的工具类,不仅方便现在的重构,更方便我们以后新增功能.

#### 第六步: 重构client.py
先把原本代码搬过来:

**app/core/client.py**
```py
from app.utils.config import settings
from openai import OpenAI  # type: ignore[import]
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
        # stream=True 是流式输出的关键。
        stream=True,
        reasoning_effort="high",
    )

    # stream 是一个可迭代对象。
    # 模型每生成一点内容，就会返回一个 chunk。
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
首先我们看一下最关键的`stream_agent`函数,可以发现,stream和后面的输出部分完全可以拆分成两个函数,实际上,只要修改`model`和`messages`这两个字段,我们就可以导入各种各样的api和提示词了,因此,我们可以单独把这两个函数提出来,放在utils文件夹的`chat.py`中,并加上一个额外的工具函数`messages`.

还需要说明的是,考虑到创建client要走一遍OpenAI库,这还是不太清晰,我们可以复用一遍封装成自己的函数,也放入`chat.py`中,这样可以让代码的职责界限更加分明一点.


**app/utils/chat.py**
```py
from typing import Generator
from openai import Stream, OpenAI
from openai.types.chat import ChatCompletionChunk


def messages(user_message: str, system_prompt: str) -> list[dict]:
    return [
        {
            "role": "system",
            "content": system_prompt,
        },
        {
            "role": "user",
            "content": user_message,
        },
    ]


def create_client(api_key: str, url: str):
    return OpenAI(api_key=api_key, base_url=url)


def stream_response(
    stream: Stream[ChatCompletionChunk],
) -> Generator[str, None, None]:
    for chunk in stream:
        # 某些 chunk 可能没有 choices
        if not chunk.choices:
            continue

        # delta 表示“这一次新增的内容”。
        delta = chunk.choices[0].delta

        # delta.content 可能是 None。
        # 只有真的有文本内容时，才 yield 给外部。
        if delta.content:
            yield delta.content


def create_stream(
    client,
    model: str,
    user_message: str,
    system_prompt: str,
):
    stream = client.chat.completions.create(
        model=model,
        messages=messages(user_message, system_prompt),
        stream=True,
        reasoning_effort="high",
    )
    return stream

```


>以防你不知道,光是函数的名字我就足足想了十几分钟,或许重构最难的地方就是起一个足够恰当的名字了.

- 看到那串冗长的类型就知道我第一版为什么没有给stream参数加上类型注释吧,而我没有给client参数加上类型注释是因为它的类型注释更加的可怕,等之后项目更成熟了再加上比较好

现在我们可以回到client.把这些工具函数用上了:

```py
from app.utils.chat import stream_response, create_stream, create_client
from typing import Generator
from app.utils.config import settings

client = create_client(settings.DEEPSEEK_API_KEY, settings.DEEPSEEK_URL)

DEFAULT_MODEL = "deepseek-v4-pro"

DEFAULT_SYSTEM_PROMPT = "以后的回答都要优先输出一句话,我是deepseek-v4-pro."


def stream_agent(
    user_message: str,
    model: str = DEFAULT_MODEL,
    system_prompt: str = DEFAULT_SYSTEM_PROMPT,
) -> Generator[str, None, None]:

    # 创建流式请求。
    stream = create_stream(client, model, user_message, system_prompt)
    return stream_response(stream)
```
之前那么长的代码被压缩到这个长度还是很有成就感的.

现在我们基本实现了除了route.py之外的所有重构,却没有影响到route.py,还是很成功的,接下来就是要把消息存入数据库中.

说是存入数据库,但流式消息还是不好下手,唯一的方法就是创建一个列表来收集,所以我们可以在crud.py中这么写:

```py
from app.utils.security import (
    verify_password,
    hashing_password,
)
from fastapi import HTTPException
from sqlmodel import Session, select
from app.models import User, UserLogin, UserRegister, ChatMessage


def healthchecker(session: Session):
    result = session.exec(select(1)).one()
    return result == 1


def register_user(session: Session, user_create: UserRegister) -> User:
    user_store = User.model_validate(
        user_create, update={"hashed_password": hashing_password(user_create.password)}
    )
    # 数据库存储
    session.add(user_store)
    session.commit()
    session.refresh(user_store)

    # 返回信息供路由函数处理
    return user_store


def check_user(session: Session, user_login: UserLogin, user_db: User):
    user = session.exec(select(User).where(user_login.name == user_db.name)).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    if not verify_password(UserLogin.password, User.hashed_password):
        raise HTTPException(status_code=401, detail="Invalid username or password")
    return user


def save_chat_message(session: Session, user_id: int, content: str) -> ChatMessage:
    message = ChatMessage(
        user_id=user_id,
        content=content,
    )
    session.add(message)
    session.commit()
    session.refresh(message)

    return message


def stream_and_save(chunks, user_id: int, session: Session):
    collected_chunks: list[str] = []
    for chunk in chunks:
        if not chunk:
            continue
        collected_chunks.append(chunk)
        yield chunk
    full_content = "".join(collected_chunks)
    if full_content:
        save_chat_message(
            user_id=user_id,
            content=full_content,
            session=session,
        )
```
- 最后两个函数即为新增的函数,第一个函数将message表进行更新,第二个函数用于处理chunk并组装出完整的消息.

这样一来,client.py也要适配着做出更改:
```py
from app.utils.chat import stream_response, create_stream, create_client
from typing import Generator
from app.utils.config import settings
from app.crud import stream_and_save
from sqlmodel import Session

client = create_client(settings.DEEPSEEK_API_KEY, settings.DEEPSEEK_URL)

DEFAULT_MODEL = "deepseek-v4-pro"

DEFAULT_SYSTEM_PROMPT = "以后的回答都要优先输出一句话,我是deepseek-v4-pro."


def stream_agent(
    user_id: int,
    user_message: str,
    session: Session,
    model: str = DEFAULT_MODEL,
    system_prompt: str = DEFAULT_SYSTEM_PROMPT,
) -> Generator[str, None, None]:

    # 创建流式请求。
    stream = create_stream(client, model, user_message, system_prompt)
    chunks = stream_response(stream)
    yield from stream_and_save(
        chunks=chunks,
        user_id=user_id,
        session=session,
    )
```
唯一值得说明的就是`yield from`这个关键字了,简单来说就是将stream_agent的输出委托给stream_and_save函数来输出,例子如下:

```py
def outer():
    yield from inner()
# 等价于
def outer():
    for item in inner():
        yield item
```
这样一来,我们成功地在返回流式消息的同时,实现了消息的存储.
#### 第七步: 修改路由实现
>接下来就是最激动人心的时刻了,前面的所有更改在这里终于能够一一派上用场了


**原始文件(更名为router.py以更适配路由的语义)**
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


@app.post("/api/chat/", response_class=StreamingResponse)
async def chat(request: ChatMessage):
    # return stream_agent(request.message)

    return StreamingResponse(
        stream_agent(request.message),
        headers={
            "Cache-Control": "no-cache",
        },
    )
```
上面的路由中,第一个health很好实现,至于第二个路由,由于我们没有Token验证机制,所以实现了也没啥震撼的效果,不如就放着算了,至于第三个,才是重头戏,由于我们需要针对不同的用户返回不同的消息体,所以肯定要把路由写成`chat/[user_id]`的形式,最后实现的效果如下:




**引入router**

显然,当项目变大之后,所有的路由都写在一个route.py文件中就不太合适了,更好的方法是,使用次一级的APIrouter类,大多数用法与Fastapi类别无二致,它主要用于收集路由,我们只需要在主应用中的app中导入该路由即可,说了这么多,还是先来实战看看吧.

上述文件可以拆分成两个子文件加上一个主文件:

**app/core/routers/utils.py**
```py
from fastapi import APIRouter
from app.crud import healthchecker
from app.utils.deps import SessionDep

router = APIRouter(prefix="/utils", tags=["utils"])


@router.get("/health")
async def health_check(session: SessionDep) -> bool:
    return healthchecker(session)


@router.get("/auth")
async def check() -> dict:
    return {
        "message": "我懒得写验证了,你直接进来吧",
        "ok": True,
    }
```

**app/core/routers/user.py**
```py
from fastapi import APIRouter
from fastapi.responses import StreamingResponse

from app.utils.deps import SessionDep
from app.core.client import stream_agent

router = APIRouter(prefix="/user", tags=["user"])


@router.post("[user_id]/chat")
async def chat(
    user_message: str,
    user_id: int,
    session: SessionDep,
) -> StreamingResponse:
    # return stream_agent(request.message)

    return StreamingResponse(
        stream_agent(user_id, user_message, session),
        headers={
            "Cache-Control": "no-cache",
        },
    )
```
**app/core/main.py**
```py
from ctypes import util

from fastapi import APIRouter
from app.core.routers import user, utils

api_router = APIRouter()
api_router.include_router(user.router)
api_router.include_router(utils.router)
```

最后再在根目录的main.py中获取路由信息:
```py
import uvicorn
from fastapi import FastAPI
from app.core.main import api_router
from starlette.middleware.cors import CORSMiddleware

# 后三个参数均为openapi参数
app = FastAPI(
    title="demo",
    openapi_url="/api/openapi.json",
    docs_url="/api/docs",
    redoc_url="/api/redoc",
)

app.include_router(api_router, prefix="/api")
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
### 总结
如此一来我们就实现了所有的重构目标,只不过还没能真正地实现用户验证功能.

另一个更加严重的问题就是,由于我们还没引入docker,而本地启动postgre数据库又比较麻烦,所以这里的数据库操作也都是模拟的,无法真正实现.

置于前端界面,由于后续的路由变化太大,这一步就没必要重构了,看一下`openapi`文档即可大致了解我们的开发效果.

运行`uv run main.py`后,访问http://localhost:8000/api/docs即可看到以下界面:

![效果图](PixPin_2026-07-17_17-51-01.webp)
## ch7: docker构建和加入数据库
### 示例1
由于docker官方关于python的dockerfile构建文档还用的是`pip`,一个比较权威的参考文档就是fastapi模板项目中的dockerfile写法了:

```dockerfile
FROM python:3.10

ENV PYTHONUNBUFFERED=1

# Install uv
# Ref: https://docs.astral.sh/uv/guides/integration/docker/#installing-uv
COPY --from=ghcr.io/astral-sh/uv:0.9.26 /uv /uvx /bin/

# Compile bytecode
# Ref: https://docs.astral.sh/uv/guides/integration/docker/#compiling-bytecode
ENV UV_COMPILE_BYTECODE=1

# uv Cache
# Ref: https://docs.astral.sh/uv/guides/integration/docker/#caching
ENV UV_LINK_MODE=copy

WORKDIR /app/

# Place executables in the environment at the front of the path
# Ref: https://docs.astral.sh/uv/guides/integration/docker/#using-the-environment
ENV PATH="/app/.venv/bin:$PATH"

# Install dependencies
# Ref: https://docs.astral.sh/uv/guides/integration/docker/#intermediate-layers
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-install-workspace --package app

COPY ./backend/scripts /app/backend/scripts

COPY ./backend/pyproject.toml ./backend/alembic.ini /app/backend/

COPY ./backend/app /app/backend/app

RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --package app

WORKDIR /app/backend/

CMD ["fastapi", "run", "--workers", "4", "app/main.py"]
```
- `COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/`: 将uv和uvx下载到环境变量目录bin下.
- `ENV PYTHONUNBUFFERED=1`: python在控制台输出调试信息时会先存入缓冲区,设置该环境变量可以让Python直接输出调试信息,减少等待时间
- `ENV UV_COMPILE_BYTECODE=1`: python文件在第一次运行时会被编译为字节码,而在docker中,如果直接将纯文件包装成镜像的话,那么每一次启动镜像都要进行重新编译,非常麻烦,该配置选项会在使用uv命令时自动帮所有涉及的python文件构建字节码文件.
  - 优点是可以缩减镜像启动时间,缺点是会增大镜像体积,但还是利大于弊.
- `ENV UV_LINK_MODE=copy`: 该环境变量用于静默一些警告信息,打开就对了.
- `ENV PATH="/app/.venv/bin:$PATH"`: 一般来说,Linux系统的PATH中会有多个值,用`:`分隔,为了让uv能够直接通过命令行运行而不用带上路径,所以我们用一个新的PATH值来覆盖原来的PATH,

至于这个长长的命令,是通过三个绑定挂载来缩减构建时间和减少冗余的,因为是官方推荐的写法,所以就无脑使用即可:
```dockerfile
# Install dependencies
# Ref: https://docs.astral.sh/uv/guides/integration/docker/#intermediate-layers
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-install-workspace --package app
```


### 示例2
uv官方也给了非常详细的示例: [参考链接](https://docs.astral.sh/uv/guides/integration/docker/)

```dockerfile
# Install uv
FROM python:3.12-slim AS builder
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Use the system Python across both stages
ENV UV_PYTHON_DOWNLOADS=0

# Change the working directory to the `app` directory
WORKDIR /app

# Install dependencies
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --locked --no-install-project --no-editable

# Copy the project into the intermediate image
COPY . /app

# Sync the project
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked --no-editable

FROM python:3.12-slim

# Copy the environment, but not the source code
COPY --from=builder /app/.venv /app/.venv

# Run the application
CMD ["/app/.venv/bin/hello"]
```

该实例引入了两层构建的写法,显然比fastapi模板项目的写法更加专业.
### 将后端放入dockerfile
我们之前的`main.py`是放在根目录的,因为这样好直接从命令行操作,现在可以直接用docker,所以就把main.py放入app文件夹中,项目结构现在长这样:

![示意图](PixPin_2026-07-19_14-07-25.webp)

首先,填写`.dockerignore`,防止带入一些奇奇怪怪的东西:

```ignore
# Python
__pycache__
app.egg-info
*.pyc
.mypy_cache
.venv
```

对于dockerfile,我们采用两层构建的写法,大多数指令都是直接从上述的示例中复制而来:
```dockerfile
FROM python:3.14-slim AS builder

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

ENV UV_LINK_MODE=copy \
    UV_COMPILE_BYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-install-project

FROM python:3.14-slim

WORKDIR /app

ENV PYTHONUNBUFFERED=1 \
    PATH="/app/.venv/bin:$PATH"

COPY --from=builder /app/.venv /app/.venv

COPY . .

CMD ["fastapi", "run", "app/main.py"]
```
要直接构建镜像并运行的话,可以在backend目录中运行:
```bash
docker build -t backend .
docker run backend 
```
如果不出意外的话,镜像能够构建成功,但是运行时却会报错.原因就是缺失了环境变量文件,通过`docker run -e`参数来注入固然可以,但实在是太麻烦了.

因此,我们需要引入docker compose,用docker compose一键启动.

由于我们目前的功能很简单,所以这个compose文件写的也很简单:
```yml
services:
  backend:
    restart: always
    build:
      context: ./backend
      dockerfile: dockerfile
    env_file:
      - .env
    ports:
      - "8000:8000"
```
根目录下运行命令:
```bash
docker compose up --build -d
```

访问`http://localhost:8000/api/docs`,成功出现openapi文档,大功告成!
### 将数据库加入compose文档
有了后端,没有数据库可不行,我们这个项目用的数据库是PostgreSQL,主要原因就是fastapi模板项目用的就是它,而且性能非常好.

[官方](https://hub.docker.com/_/postgres)最新的镜像为19的beta版本,那我们用18-alpine版本就够了,写法如下:

```yml
  db:
    image: postgres:18-alpine
    restart: always
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
      interval: 10s
      retries: 5
      start_period: 30s
      timeout: 10s
    volumes:
      - db-data:/var/lib/postgresql/data/pgdata
    env_file:
      - .env

volumes:
  db-data:
```
上述的healthcheck字段是标准写法,所以无脑照抄就可以了,不过这需要预先在.env文件中声明了`{}`所包裹的两个环境变量才可以.

volume挂载的路径也是标准路径,与镜像内置的环境变量相关联,所以最好不要改.

显然,如果后端比数据库先启动,那么也无法执行任何的数据操作,所以,需要用`depends_on`关键字来强制后端滞后启动,完整的yml文件如下:
```yml
services:
  db:
    image: postgres:18-alpine
    restart: always
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
      interval: 10s
      retries: 5
      start_period: 30s
      timeout: 10s
    volumes:
      - db-data:/var/lib/postgresql/data/pgdata
    env_file:
      - .env
  backend:
    restart: always
    build:
      context: ./backend
      dockerfile: dockerfile
    depends_on:
      db:
        condition: service_healthy
        restart: true
    env_file:
      - .env
    ports:
      - "8000:8000"

volumes:
  db-data:

```
运行下述命令:
```bash
docker compose up --build -d
```
可以看到所有服务都正常启动了,非常好!

![图示](PixPin_2026-07-20_21-52-23.webp)

现在我们可以真正的对数据库进行操作了,但是,这需要我们先完善用户验证功能,不然就没办法有效的存储数据了.
## ch8: 实现Token验证
### 预处理
>现在最大的问题是,即便有了注册+登录的流程,后端还是无法记住当前用户,那么也就不可能真正的给用户传递数据库的信息,也就是说,数据库基本没被用上! 因此,我们需要加入token功能,在用户的每次数据库请求中加上token依赖,这样我们才能知道这是哪个用户,我们又应该返回哪条消息.

为了让重构更简单,我们就需要再次进行文件的重新放置和安排,确保文件彼此的职责边界清晰,最后得到的目录架构如下:

![图示](PixPin_2026-07-20_22-28-23.webp)

- 文件内容除了导入路径外没有任何改变

考虑到我们需要先启动数据库驱动再运行asgi服务器,所以最好把数据库初始化函数预先调动,因此,有必要先在app的根目录单独创建一个**db_pre_start.py**文件:

**app/db_pre_start.py**
```py
from app.core.db import init_db


def main() -> None:
    init_db()


if __name__ == "__main__":
    main()
```
- 另一个原因是后续需要在prestart中加入数据库迁移,管理员账户初始化等功能,所以需要尽早拆分.

考虑到手动启动该函数的麻烦,我们需要将这个文件放入脚本来启动,再封装在compose.yml中:

**backend/scripts/prestart.sh**
```bash
#! /usr/bin/env bash

set -e
set -x

# Let the DB start
python -m app.db_pre_start
```

现在,我们就可以把这个脚本放入compose里了:
```yml
  prestart:
    build:
      context: ./backend
      dockerfile: dockerfile
    depends_on:
      db:
        condition: service_healthy
        restart: true
    command: bash scripts/prestart.sh
    env_file:
      - .env
```
prestart服务与backend服务共用一个dockerfile进行构建,运行完command中指示的脚本后就会主动退出并终止.让位给backend服务.

最终的compose.yml格式如下:
```yml
services:
  db:
    image: postgres:18-alpine
    restart: always
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
      interval: 10s
      retries: 5
      start_period: 30s
      timeout: 10s
    volumes:
      - db-data:/var/lib/postgresql/data/pgdata
    env_file:
      - .env
  prestart:
    build:
      context: .
      dockerfile: backend/Dockerfile
    depends_on:
      db:
        condition: service_healthy
        restart: true
    command: bash scripts/prestart.sh
    env_file:
      - .env
  backend:
    restart: always
    build:
      context: ./backend
      dockerfile: dockerfile
    depends_on:
      db:
        condition: service_healthy
        restart: true
      prestart:
        condition: service_completed_successfully
    env_file:
      - .env
    ports:
      - "8000:8000"

volumes:
  db-data:
```

同时我们需要修改一下`.env`文件中的环境变量值,将`POSTGRES_SERVER=localhost`修改为`db`:
```toml
DEEPSEEK_API_KEY=123
SECRET_KEY=123456

# DATABASE_URL = postgresql+psycopg://
# postgres:123456@db:5432/my_chat_db


POSTGRES_SERVER=db
POSTGRES_PORT=5432
POSTGRES_DB=app
POSTGRES_USER=postgres
POSTGRES_PASSWORD=123456
```
主要原因是如果用localhost的话prestart就无法和db连接了.
### 生成Token与提取Token
首先,先在models.py创建关于token的两个SQLModel模型:
```py
class Token(SQLModel):
    access_token: str
    token_type: str = "bearer"


class TokenPayload(SQLModel):
    sub: str | None = None
```

一个用来存放返回给用户的token,一个用来存放用户提供的token,分别用于分发和校验token.而至于为什么放的是这三个字段,请看下面的深入解释:
#### token原理再探
在token往来中,服务器和客户端存放token的方式自然有所不同,当用户登录时,服务器的返回内容如下:

```yml
HTTP/1.1 200 OK
Content-Type: application/json


{
    "access_token":
    "xxxxx.yyyyy.zzzzz",

    "token_type":
    "bearer"
}
```

而用户在之后请求信息时,都会在头部带上这个"xxxxx.yyyyy.zzzzz"token,服务器只需要再次用密钥和对应的算法来解析token,就可以知道该token的格式是否正常,token是否过期.

而sub字段(subject)则是用于区分不同的用户,唯一具有该功能的键自然就是主键了,也就是说sub字段存储的就是用户数据库的主键id,自然,该id需要具有随机性,不然就容易被cracker攻击或者破坏,不过我们这个项目显然没这个烦恼,就依靠SQLModel的自动生成特性来实现也足够了.

而标准的设计中,数据库最起码要提供的token字段(也就是payload)如下:
```json
{
    "sub":"1001",

    "iat":1720000000,

    "exp":1720003600,

}
```
| 字段 | 用途     |
| ---- | -------- |
| sub  | 用户ID   |
| iat  | 签发时间 |
| exp  | 过期时间 |

因此,我们还需要对models.py中的原字段做一些改动,加入时间机制,先看看原来的结构:
```py
from sqlmodel import Relationship, SQLModel, Field


class UserBase(SQLModel):
    name: str


class UserRegister(UserBase):
    password: str


class UserLogin(UserBase):
    password: str


class User(UserBase, table=True):
    id: int | None = Field(default=None, primary_key=True)
    hashed_password: str
    chats: list["ChatMessage"] = Relationship(
        back_populates="user",
        cascade_delete=True,
    )


class Message(SQLModel):
    message: str


class ChatMessage(SQLModel, table=True):
    chat_id: int | None = Field(default=None, primary_key=True)
    content: str | None = None
    user_id: int | None = Field(foreign_key="user.id")
    user: User | None = Relationship(back_populates="chats")


class Token(SQLModel):
    access_token: str
    token_type: str = "bearer"


class TokenPayload(SQLModel):
    sub: str | None = None
```

加入计时功能需要导入datetime库,该库与普通的计时器time库不同,可以获取更为精确的时间,并且支持时区.
#### models.py最终版本
```py
from sqlalchemy import DateTime
from sqlmodel import Relationship, SQLModel, Field
from datetime import UTC, datetime


def get_datetime() -> datetime:
    return datetime.now(UTC)


class UserBase(SQLModel):
    name: str | None = Field(default=None, max_length=255)
    is_active: bool = True


class UserRegister(SQLModel):
    password: str
    name: str = Field(default=None, max_length=255)


class UserCreate(UserBase):
    password: str = Field(min_length=8, max_length=16)


class UserPublic(UserBase):
    id: int | None
    created_at: datetime | None = None


class User(UserBase, table=True):
    id: int | None = Field(default=None, primary_key=True)
    hashed_password: str
    created_at: datetime | None = Field(
        default_factory=get_datetime,
    )
    chats: list["ChatMessage"] = Relationship(
        back_populates="user",
        cascade_delete=True,
    )


class Message(SQLModel):
    message: str


class ChatMessage(SQLModel, table=True):
    chat_id: int | None = Field(default=None, primary_key=True)
    content: str | None = None
    created_at: datetime | None = Field(
        default_factory=get_datetime,
    )
    user_id: int | None = Field(foreign_key="user.id")
    user: User | None = Relationship(back_populates="chats")


class ChatMessagePublic(SQLModel):
    chat_id: int
    content: str | None
    created_at: datetime | None


class Token(SQLModel):
    access_token: str
    token_type: str = "bearer"


class TokenPayload(SQLModel):
    sub: str | None = None

```
#### 重构deps.py
重构完models.py后,就可以着手重构deps.py了,把之前的所有伪处理全部改成真实的处理:
```py
from collections.abc import Generator
from typing import Annotated

from sqlmodel import Session

from app.core.db import engine
from app.models import User, TokenPayload  # newline
from fastapi.security import OAuth2PasswordBearer
from fastapi import Depends, HTTPException, status  # newline

# newline
import jwt
from jwt.exceptions import InvalidTokenError
from app.core.config import settings
from pydantic import ValidationError

# newline
oauth2 = OAuth2PasswordBearer(
    tokenUrl="/api/login/access-token",
    scheme_name="Oauth2",
)

TokenDep = Annotated[str, Depends(oauth2)]

ALGORITHM = "HS256"


def get_db() -> Generator[Session, None, None]:
    with Session(engine) as session:
        yield session


SessionDep = Annotated[Session, Depends(get_db)]


def get_current_user(
    session: SessionDep,
    token: TokenDep,
) -> User:
    try:
        payload = jwt.decode(
            token,
            settings.SECRET_KEY,
            algorithms=[ALGORITHM],
        )
        token_data = TokenPayload(**payload)
    except InvalidTokenError, ValidationError:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Invalid credentials",
        )
    user = session.get(User, token_data.sub)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User Not Found",
        )
    if not user.is_active:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Inactive user",
        )
    return user


CurrentUser = Annotated[User, Depends(get_current_user)]
```
可以看到,引入验证功能之后,所有的路由处理都水到渠成了.
#### 重构security.py
原来的security.py长这样,属实有点寒酸:
```py
from pwdlib import PasswordHash

hash_method = PasswordHash.recommended()


def verify_password(plain_password: str, hashed_password: str) -> bool:
    return hash_method.verify(plain_password, hashed_password)


def hashing_password(plain_password: str):
    return hash_method.hash(plain_password)
```
加入验证功能后,我们需要创建一个构建token的函数,最终效果如下:
```py
from datetime import timedelta
from typing import Any
from datetime import datetime, UTC
import jwt

from pwdlib import PasswordHash
from app.api.deps import ALGORITHM
from app.core.config import settings

hash_method = PasswordHash.recommended()


def create_token(subject: str | Any, expires_delta: timedelta) -> str:
    expire_date = datetime.now(UTC) + expires_delta
    encode_content = {"exp": expire_date, "sub": str(subject)}
    encoded_jwt = jwt.encode(
        encode_content,
        settings.SECRET_KEY,
        algorithm=ALGORITHM,
    )
    return encoded_jwt


def verify_password(
    plain_password: str,
    hashed_password: str,
) -> bool:
    return hash_method.verify(plain_password, hashed_password)


def hashing_password(plain_password: str) -> str:
    return hash_method.hash(plain_password)
```

### crud.py重构
原版本:
```py
from app.core.security import (
    verify_password,
    hashing_password,
)
from fastapi import HTTPException
from sqlmodel import Session, select
from app.models import User, UserLogin, UserRegister, ChatMessage


def healthchecker(session: Session):
    result = session.exec(select(1)).one()
    return result == 1


def register_user(session: Session, user_create: UserRegister) -> User:
    user_store = User.model_validate(
        user_create, update={"hashed_password": hashing_password(user_create.password)}
    )
    # 数据库存储
    session.add(user_store)
    session.commit()
    session.refresh(user_store)

    # 返回信息供路由函数处理
    return user_store


def check_user(session: Session, user_login: UserLogin, user_db: User):
    user = session.exec(select(User).where(user_login.name == user_db.name)).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    if not verify_password(UserLogin.password, User.hashed_password):
        raise HTTPException(status_code=401, detail="Invalid username or password")
    return user


def save_chat_message(session: Session, user_id: int, content: str) -> ChatMessage:
    message = ChatMessage(
        user_id=user_id,
        content=content,
    )
    session.add(message)
    session.commit()
    session.refresh(message)

    return message


def stream_and_save(chunks, user_id: int, session: Session):
    collected_chunks: list[str] = []
    for chunk in chunks:
        if not chunk:
            continue
        collected_chunks.append(chunk)
        yield chunk
    full_content = "".join(collected_chunks)
    if full_content:
        save_chat_message(
            user_id=user_id,
            content=full_content,
            session=session,
        )
```
鉴于原版本的部分函数的语义有问题,所以在下面一并进行修改了,最关键的改动则是加入了验证函数:
```py
from app.core.security import (
    verify_password,
    hashing_password,
)
from fastapi import HTTPException
from sqlmodel import Session, select
from app.models import User, UserCreate, UserRegister, ChatMessage

# Dummy hash to use for timing attack prevention when user is not found
DUMMY_HASH = "$argon2id$v=19$m=65536,t=3,p=4$MjQyZWE1MzBjYjJlZTI0Yw$YTU4NGM5ZTZmYjE2NzZlZjY0ZWY3ZGRkY2U2OWFjNjk"


def check_db(*, session: Session):
    result = session.exec(select(1)).one()
    return result == 1


def register_user(*, session: Session, user_register: UserRegister) -> User:
    user_store = User.model_validate(
        user_register,
        update={"hashed_password": hashing_password(user_register.password)},
    )

    session.add(user_store)
    session.commit()
    session.refresh(user_store)

    return user_store


def get_user_by_name(*, session: Session, name: str) -> User | None:
    statement = select(User).where(User.name == name)
    user = session.exec(statement).first()
    return user


def check_user(session: Session, name: str, password: str) -> User | None:
    db_user = get_user_by_name(session=session, name=name)
    if not db_user:
        verify_password(password, DUMMY_HASH)
        return None
    verified = verify_password(password, db_user.hashed_password)
    if not verified:
        return None
    return db_user


# 工具函数
def save_chat_message(*, session: Session, user_id: int, content: str) -> ChatMessage:
    message = ChatMessage(
        user_id=user_id,
        content=content,
    )
    session.add(message)
    session.commit()
    session.refresh(message)

    return message


def stream_and_save(*, session: Session, user_id: int, chunks):
    collected_chunks: list[str] = []
    for chunk in chunks:
        if not chunk:
            continue
        collected_chunks.append(chunk)
        yield chunk
    full_content = "".join(collected_chunks)
    if full_content:
        save_chat_message(
            user_id=user_id,
            content=full_content,
            session=session,
        )
```
- 尽管根据名字来区分用户的方法有点草率,但却不需要我们做什么额外的操作,无论是邮件验证还是手机号验证,都需要去搞个云服务器过来,或者自掏腰包.之后若有空闲,或许可以引入Google登录.

### 路由重构
做完上述的准备工作后,我们所要用到的组件都已经集齐了,接下来就是将路由重构成能够真正地与数据库交互的版本.
#### 构思
原先版本的两个路由文件长这样:

**api/routers/utils.py**
```py
from fastapi import APIRouter
from app.crud import healthchecker
from app.api.deps import SessionDep

router = APIRouter(prefix="/utils", tags=["utils"])


@router.get("/health")
async def health_check(session: SessionDep) -> bool:
    return healthchecker(session)


@router.get("/auth")
async def check() -> dict:
    return {
        "message": "我懒得写验证了,你直接进来吧",
        "ok": True,
    }
```
**api/routers/user.py**
```py
from fastapi import APIRouter
from fastapi.responses import StreamingResponse

from app.api.deps import SessionDep
from app.utils.client import stream_agent

router = APIRouter(prefix="/user", tags=["user"])


@router.post("/{user_id}/chat")
async def chat(
    user_message: str,
    user_id: int,
    session: SessionDep,
) -> StreamingResponse:
    # return stream_agent(request.message)

    return StreamingResponse(
        stream_agent(user_id, user_message, session),
        headers={
            "Cache-Control": "no-cache",
        },
    )
```

加入验证功能后,我们需要引入以下路由:
1. 用于注册的register路由
2. 用于展示用户主页的`{user_id}`路由
3. 用于产生token和登录的`access-token`路由

除了最后一个需要放入utils.py中,其他的都可以放入user.py里.
#### utils.py重构
原来的auth路由就可以直接删掉了,而health路由暂时保留,可以用来在测试和初始化数据库的时候使用.
```py
from typing import Annotated
from datetime import timedelta
from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import OAuth2PasswordRequestForm
from app.crud import check_db, check_user
from app.api.deps import SessionDep
from app.models import Token
from app.core import security

router = APIRouter(tags=["utils"])

TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 8


@router.get("/utils/health")
async def health_check(session: SessionDep) -> bool:
    return check_db(session=session)


@router.post("/login/access-token")
def login_access_token(
    session: SessionDep, form_data: Annotated[OAuth2PasswordRequestForm, Depends()]
) -> Token:
    user = check_user(
        session=session,
        name=form_data.username,
        password=form_data.password,
    )
    if not user:
        raise HTTPException(status_code=400, detail="Incorrect name or password")
    elif not user.is_active:
        raise HTTPException(status_code=400, detail="Inactive user")
    token_expires = timedelta(minutes=TOKEN_EXPIRE_MINUTES)
    return Token(
        access_token=security.create_token(
            user.id,
            expires_delta=token_expires,
        )
    )
```
#### user.py重构
```py
from fastapi import APIRouter, HTTPException, Query
from fastapi.responses import StreamingResponse
from typing import Annotated, Any

from app.api.deps import SessionDep, CurrentUser
from app.utils.client import stream_agent
from app.models import ChatMessage, ChatMessagePublic, User, UserPublic, UserRegister
from app import crud
from sqlmodel import select, desc

router = APIRouter(prefix="/user", tags=["user"])


# response_model用于过滤密码
@router.post("/register", response_model=UserPublic)
def register_user(session: SessionDep, user_in: UserRegister) -> Any:
    user = crud.get_user_by_name(session=session, name=user_in.name)

    # 由于没有邮箱,所以只好通过用户名来标记是否冲突

    if user:
        raise HTTPException(status_code=400, detail="Name exists")
    user_register = UserRegister.model_validate(user_in)
    user = crud.register_user(session=session, user_register=user_register)
    return user


# 用户主页
@router.get("/me", response_model=UserPublic)
def homepage(current_user: CurrentUser) -> User:
    return current_user


# 新对话
@router.post("/me/chat")
async def chat(
    user_message: str,
    session: SessionDep,
    current_user: CurrentUser,
) -> StreamingResponse:
    if not current_user.id:
        raise HTTPException(
            status_code=401,
            detail="Invalid authenticated user",
        )

    return StreamingResponse(
        stream_agent(current_user.id, user_message, session),
        headers={
            "Cache-Control": "no-cache",
        },
    )


# 消息列表
@router.get(
    "/me/messages",
    response_model=list[ChatMessagePublic],
)
def get_chat_list(
    session: SessionDep,
    current_user: CurrentUser,
    offset: Annotated[int, Query(ge=0)] = 0,
    limit: Annotated[int, Query(ge=1, le=20)] = 10,
) -> Any:
    statement = (
        select(ChatMessage)
        .where(ChatMessage.user_id == current_user.id)
        .order_by(desc(ChatMessage.created_at))
        .offset(offset=offset)
        .limit(limit=limit)
    )
    chatlist = session.exec(statement).all()
    return chatlist

```
出于简化的考量,就没有加入删除对话等功能,但这就已经比较复杂了.

### 总结
同样用docker compose启动服务,一切正常,打开`http://localhost:8000/api/docs`进行测试:

1. 在`/api/user/register`路由注册用户:

**请求体**
```json
{
  "password": "4i",
  "name": "mike"
}
```

**响应体**
```json
{
  "name": "mike",
  "is_active": true,
  "id": 1,
  "created_at": "2026-07-27T08:08:23.138696"
}
```

2. 在`/api/login/access-token`输入用户名称和密码,获取token:

```json
access-control-allow-credentials: true 
content-length: 160 
content-type: application/json 
date: Mon,27 Jul 2026 08:09:55 GMT 
server: uvicorn 
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3ODU4MzA5OTUsInN1YiI6IjEifQ.z5-He7jM3SrPkO7YimRnD5xx0XcL6yqL9Ec6rKL3dOE",
  "token_type": "bearer"
}
```
3. 点击Swagger UI上方的Authorize按钮,输入用户名和密码:

![通过验证](PixPin_2026-07-27_16-13-54.webp)

4. 在`/api/user/me/chat`输入消息来聊天:

![完成对话](PixPin_2026-07-27_16-19-16.webp)

5. 在`/api/user/me/messages`查看消息列表:

![消息列表](PixPin_2026-07-27_16-21-46.webp)

可以看到,尽管我们还没有重构前端,但所有的基本功能我们都已经实现了,你可以自豪的跟面试官吹嘘,我自己一个人写了个智能体出来,代码都是自己写的哦!

## ch9: 重构前端的准备
### 加入dockerfile
#### 修改`next.config.ts`.

```ts
import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  /* config options here */
  output: "standalone", //new line
  reactCompiler: true,
  devIndicators: false,
};

export default nextConfig;
```

>nextjs有多种部署方式:
1. 纯静态的`export`模式,不需要node.js即可启动,输出目录为`out`
2. 默认的动态模式,输出目录为`.next`
3. standalone模式,输出目录为`.next/standalone`,在支持动态加载的情况下做到轻量化,非常适合docker部署,这也是为什么我们要单独修改配置文件的原因.

#### 编写dockerfile
- [官方推荐的standalone写法](https://github.com/vercel/next.js/blob/canary/examples/with-docker/Dockerfile)

参考官方文档,我们采用三阶段构建,并依靠AI进行了细微的调整,至于为什么要修改,那当然是因为官方文档的写法跑不起来啊!不过我懒得提issue了,毕竟这个模块的更新时间竟然是在5个月前.

```dockerfile
ARG NODE_VERSION=24.13.0-slim

# Stage 1: Dependencies Installation Stage

FROM node:${NODE_VERSION} AS dependencies

WORKDIR /app

COPY package.json  pnpm-lock.yaml* pnpm-workspace.yaml ./

RUN --mount=type=cache,id=pnpm-store,target=/pnpm/store \
    corepack enable pnpm && \
    pnpm config set store-dir /pnpm/store && \
    pnpm config set minimum-release-age 0 && \
    pnpm install --frozen-lockfile --ignore-scripts=false

# Stage 2: Build Next.js application in standalone mode

FROM node:${NODE_VERSION} AS builder

WORKDIR /app

COPY --from=dependencies /app/node_modules ./node_modules
COPY . .

ENV NODE_ENV=production

RUN ./node_modules/.bin/next build

# Stage 3: Run Next.js application

FROM node:${NODE_VERSION} AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000
ENV HOSTNAME="0.0.0.0"

COPY --from=builder --chown=node:node /app/public ./public

RUN mkdir .next
RUN chown node:node .next

COPY --from=builder --chown=node:node /app/.next/standalone ./
COPY --from=builder --chown=node:node /app/.next/static ./.next/static

USER node

EXPOSE 3000

CMD ["node", "server.js"]
```
- 照抄即可,原理不是太有必要了解
#### 编写compose.yml
官方推荐的yml写法如下:
```yml
services:
  # Node.js service (use with: docker compose up nextjs-standalone --build)
  nextjs-standalone:
    build:
      context: .
      dockerfile: Dockerfile
    image: nextjs-standalone-image
    container_name: nextjs-standalone-container
    environment:
      NODE_ENV: production
      PORT: "3000"
    ports:
      - "3000:3000"
    restart: unless-stopped
```
对于我们这个项目,稍微改动一下就适配了:

```yml
services:
  db:
    image: postgres:18-alpine
    restart: always
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
      interval: 10s
      retries: 5
      start_period: 30s
      timeout: 10s
    volumes:
      - db-data:/var/lib/postgresql/data/pgdata
    env_file:
      - .env
  prestart:
    build:
      context: ./backend
      dockerfile: dockerfile
    depends_on:
      db:
        condition: service_healthy
        restart: true
    command: bash scripts/prestart.sh
    env_file:
      - .env
  backend:
    restart: always
    build:
      context: ./backend
      dockerfile: dockerfile
    depends_on:
      db:
        condition: service_healthy
        restart: true
      prestart:
        condition: service_completed_successfully
    env_file:
      - .env
    ports:
      - "8000:8000"
  frontend:
    build:
      context: ./frontend
      dockerfile: dockerfile
    ports:
      - "3000:3000"
    restart: unless-stopped
volumes:
  db-data:

```

启动后也终于是看到了我们熟悉的古早页面:

![主页](PixPin_2026-07-27_18-51-39.webp)

### 重写前端
尽管我们前面用shadcn初始化了一个还能看的过去的项目,但现在由于我们的路由已经成熟,整个页面的逻辑完全不一样了,如果还一个个文件重构那显然有点白痴了,最好的方法就是扔掉之前的项目,重新创建一个.

我们先保留之前好不容易写出来的dockerfile和.dockerignore文件,然后在根目录文件夹中运行下述命令,选择文件夹名字为frontend,一键完成,再将dockerfile拖回去,这次我们顺便换个主题风格:
```bash
pnpm dlx shadcn@latest init --preset b2HRG489Am --base radix --template next --pointer
```
可以看到,上述命令一键指定了要用的组件框架和模板.

#### heyapi使用
我们之前的前端用的是非常拉跨的编写方式,甚至把api全部写在api.ts中一个个保存,这种写法显然不利于后期的扩展.好在我们有`heyapi`库,能够自动根据后端生成的`openapi`来生成优美的前端api调用组件.

首先,在frontend文件夹下面安装heyapi库:
```bash
pnpm add @hey-api/client-next
pnpm add -D @hey-api/openapi-ts
```


在 package.json 中加入新命令以快速生成api.
```json
{
  "scripts": {
    "api:generate": "openapi-ts"
  }
}
```

在前端根目录创建`openapi-ts.config.ts`文件,这个文件说明了我们从哪里获取openapi文档,又将输出的方法放到哪个文件夹中：
```ts
import { defineConfig } from "@hey-api/openapi-ts"

export default defineConfig({
  input: "http://localhost:8000/api/openapi.json",
  output: "lib/api/generated",
  plugins: [
    {
      name: "@hey-api/client-next",
      runtimeConfigPath: "./lib/api/hey-api",
    },
  ],
})
```

plugins字段是hey-api适配next.js的插件,不是必须要用到的,需要我们在lib文件夹中的api文件夹中新建一个`hey-api.ts`文件,内容如下:

```ts
import type { Config } from "./generated/client/types.gen"

export const createClientConfig = (config: Config): Config => ({
  ...config,

  baseUrl: "http://localhost:8000",
})

```


运行以下命令即可生成所有api:
```bash
pnpm run api:generate
```
看一下`generated/sdk.gen.ts`里的路由,简直丑陋到不可直视的地步:
```ts
// This file is auto-generated by @hey-api/openapi-ts

import { type Client, type ClientMeta, type Options as Options2, type RequestResult, type TDataShape, urlSearchParamsBodySerializer } from './client';
import { client } from './client.gen';


export type Options<TData extends TDataShape = TDataShape, ThrowOnError extends boolean = boolean, TResponse = unknown> = Options2<TData, ThrowOnError, TResponse> & {
    /**
     * You can provide a client instance returned by `createClient()` instead of
     * individual options. This might be also useful if you want to implement a
     * custom client.
     */
    client?: Client;
    /**
     * You can pass arbitrary values through the `meta` object. This can be
     * used to access values that aren't defined as part of the SDK function.
     */
    meta?: keyof ClientMeta extends never ? Record<string, unknown> : ClientMeta;
};

/**
 * Register User
 */
export const registerUserApiUserRegisterPost = <ThrowOnError extends boolean = false>(options: Options<RegisterUserApiUserRegisterPostData, ThrowOnError>): RequestResult<RegisterUserApiUserRegisterPostResponses, RegisterUserApiUserRegisterPostErrors, ThrowOnError> => (options.client ?? client).post<RegisterUserApiUserRegisterPostResponses, RegisterUserApiUserRegisterPostErrors, ThrowOnError>({
    url: '/api/user/register',
    ...options,
    headers: {
        'Content-Type': 'application/json',
        ...options.headers
    }
});

/**
 * Homepage
 */
export const homepageApiUserMeGet = <ThrowOnError extends boolean = false>(options?: Options<HomepageApiUserMeGetData, ThrowOnError>): RequestResult<HomepageApiUserMeGetResponses, unknown, ThrowOnError> => (options?.client ?? client).get<HomepageApiUserMeGetResponses, unknown, ThrowOnError>({
    security: [{ scheme: 'bearer', type: 'http' }],
    url: '/api/user/me',
    ...options
});

/**
 * Chat
 */
export const chatApiUserMeChatPost = <ThrowOnError extends boolean = false>(options: Options<ChatApiUserMeChatPostData, ThrowOnError>): RequestResult<ChatApiUserMeChatPostResponses, ChatApiUserMeChatPostErrors, ThrowOnError> => (options.client ?? client).post<ChatApiUserMeChatPostResponses, ChatApiUserMeChatPostErrors, ThrowOnError>({
    security: [{ scheme: 'bearer', type: 'http' }],
    url: '/api/user/me/chat',
    ...options
});

/**
 * Get Chat List
 */
export const getChatListApiUserMeMessagesGet = <ThrowOnError extends boolean = false>(options?: Options<GetChatListApiUserMeMessagesGetData, ThrowOnError>): RequestResult<GetChatListApiUserMeMessagesGetResponses, GetChatListApiUserMeMessagesGetErrors, ThrowOnError> => (options?.client ?? client).get<GetChatListApiUserMeMessagesGetResponses, GetChatListApiUserMeMessagesGetErrors, ThrowOnError>({
    security: [{ scheme: 'bearer', type: 'http' }],
    url: '/api/user/me/messages',
    ...options
});

/**
 * Health Check
 */
export const healthCheckApiUtilsHealthGet = <ThrowOnError extends boolean = false>(options?: Options<HealthCheckApiUtilsHealthGetData, ThrowOnError>): RequestResult<HealthCheckApiUtilsHealthGetResponses, unknown, ThrowOnError> => (options?.client ?? client).get<HealthCheckApiUtilsHealthGetResponses, unknown, ThrowOnError>({ url: '/api/utils/health', ...options });

/**
 * Login Access Token
 */
export const loginAccessTokenApiLoginAccessTokenPost = <ThrowOnError extends boolean = false>(options: Options<LoginAccessTokenApiLoginAccessTokenPostData, ThrowOnError>): RequestResult<LoginAccessTokenApiLoginAccessTokenPostResponses, LoginAccessTokenApiLoginAccessTokenPostErrors, ThrowOnError> => (options.client ?? client).post<LoginAccessTokenApiLoginAccessTokenPostResponses, LoginAccessTokenApiLoginAccessTokenPostErrors, ThrowOnError>({
    ...urlSearchParamsBodySerializer,
    url: '/api/login/access-token',
    ...options,
    headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        ...options.headers
    }
});
```
尽管是自动生成的,但这个名字也太丑了,不过仔细一看可以发现,这些路由丑陋的前缀就是所写的注释,而这个注释是什么呢,仔细一看,这不就是我们在后端所写的函数名字吗:

```py
# 消息列表
@router.get(
    "/me/messages",
    response_model=list[ChatMessagePublic],
)
def get_chat_list(
    session: SessionDep,
    current_user: CurrentUser,
    offset: Annotated[int, Query(ge=0)] = 0,
    limit: Annotated[int, Query(ge=1, le=20)] = 10,
) -> Any:
    statement = (
        select(ChatMessage)
        .where(ChatMessage.user_id == current_user.id)
        .order_by(desc(ChatMessage.created_at))
        .offset(offset=offset)
        .limit(limit=limit)
    )
    chatlist = session.exec(statement).all()
    return chatlist

```
而名字的后半部分就是路由路径,这么看来,还是很好记忆的.
#### fastapi再显神威
不过,鉴于我糟糕的起名品味,只保留后半部分的路由名字和方法就足够了,一个简单粗暴的方式是,fastapi支持在函数名中直接指定自动生成的函数名字:
```py
@router.get(
    "/api/user/me",
    operation_id="getCurrentUser"
)
```
尽管我们路由不多,一个个写也还耗得起,但日后要修改路由的时候那不又得重新搞一次,这还是太麻烦了.

好在fastapi还有[一键生成的写法](https://fastapi.tiangolo.com/advanced/generate-clients/#client-method-names):

```py
from fastapi import FastAPI
from fastapi.routing import APIRoute
from pydantic import BaseModel


def custom_generate_unique_id(route: APIRoute):
    return f"{route.tags[0]}-{route.name}"

app = FastAPI(generate_unique_id_function=custom_generate_unique_id)
```
因此,我们可以重写后端的api/main.py文件,变成以下这个样子:
```py
from fastapi import APIRouter
from fastapi.routing import APIRoute
from app.api.routers import utils
from app.api.routers import user


def generate_operation_id(route: APIRoute):
    """
    根据路由路径生成 operationId

    /api/user/me
    -> ApiUserMeGet

    /api/user/chat
    -> ApiUserChatPost
    """

    path = route.path_format

    # 去掉开头 /
    parts = [item for item in path.strip("/").split("/") if item]

    name = "".join(
        part.replace("{", "By")
        .replace("}", "")
        .replace("-", "_")
        .split("_")[0]
        .capitalize()
        for part in parts
    )

    # HTTP方法
    method = list(route.methods)[0].lower()

    return name + method.capitalize()


api_router = APIRouter(generate_unique_id_function=generate_operation_id)
api_router.include_router(user.router)
api_router.include_router(utils.router)
```

然后用docker重启前后端,再用heyapi生成一次:
```ts
// This file is auto-generated by @hey-api/openapi-ts

import { type Client, type ClientMeta, type Options as Options2, type RequestResult, type TDataShape, urlSearchParamsBodySerializer } from './client';
import { client } from './client.gen';

export type Options<TData extends TDataShape = TDataShape, ThrowOnError extends boolean = boolean, TResponse = unknown> = Options2<TData, ThrowOnError, TResponse> & {
    /**
     * You can provide a client instance returned by `createClient()` instead of
     * individual options. This might be also useful if you want to implement a
     * custom client.
     */
    client?: Client;
    /**
     * You can pass arbitrary values through the `meta` object. This can be
     * used to access values that aren't defined as part of the SDK function.
     */
    meta?: keyof ClientMeta extends never ? Record<string, unknown> : ClientMeta;
};

/**
 * Register User
 */
export const apiUserRegisterPost = <ThrowOnError extends boolean = false>(options: Options<ApiUserRegisterPostData, ThrowOnError>): RequestResult<ApiUserRegisterPostResponses, ApiUserRegisterPostErrors, ThrowOnError> => (options.client ?? client).post<ApiUserRegisterPostResponses, ApiUserRegisterPostErrors, ThrowOnError>({
    url: '/api/user/register',
    ...options,
    headers: {
        'Content-Type': 'application/json',
        ...options.headers
    }
});

/**
 * Homepage
 */
export const apiUserMeGet = <ThrowOnError extends boolean = false>(options?: Options<ApiUserMeGetData, ThrowOnError>): RequestResult<ApiUserMeGetResponses, unknown, ThrowOnError> => (options?.client ?? client).get<ApiUserMeGetResponses, unknown, ThrowOnError>({
    security: [{ scheme: 'bearer', type: 'http' }],
    url: '/api/user/me',
    ...options
});

/**
 * Chat
 */
export const apiUserMeChatPost = <ThrowOnError extends boolean = false>(options: Options<ApiUserMeChatPostData, ThrowOnError>): RequestResult<ApiUserMeChatPostResponses, ApiUserMeChatPostErrors, ThrowOnError> => (options.client ?? client).post<ApiUserMeChatPostResponses, ApiUserMeChatPostErrors, ThrowOnError>({
    security: [{ scheme: 'bearer', type: 'http' }],
    url: '/api/user/me/chat',
    ...options
});

// ...

```
可以看到,这次的函数名字就眉清目秀多了.

之后我们要调用api,也只需要从这个文件导入这些路由函数即可,至于api的真实路径我们就不需要去了解了.由此一来,前端和后端基本完全解耦了.
#### 路由构思
先看看我们的后端路由:

![路由图片](PixPin_2026-07-28_17-19-34.webp)

首先,我们这个智能体应该做成一个SPA(Single-Page Application,单页应用),然后用户第一次进入该网站根网址`/`时,点击注册按钮会被自动导引到注册界面,也就是`/user/register`,注册之后自动调用`/api/login/access-token`,获得token后转到`/user/me/chat`界面,在侧栏则可以通过`/api/user/me/messages`看到过往的聊天记录.

尽管设计确实很简单,也有很多比较草率的地方,但对于第一次设计api的新人来说,却已经比较复杂了,现在就让我们来实现它吧.
#### 插曲: AI生成项目
正如近年的新书都喜欢加入一点AI教程部分一样,这篇教程也不例外,我们可以将上述的路由想法和之前构建的前端文件夹直接丢给AI来生成,不出意料的话,AI会生成一个尽管能跑,但是架构无比丑陋的项目:

![示意图](PixPin_2026-07-29_18-38-44.webp)

不管如何,这很难让人放心大胆的用下去呢,唯一的方法就是深入学习前端知识,能够自己搭建一个基本的项目出来,而最好的例子不就是AI生成的这些垃圾项目吗,尽管丑陋,但基本原理都摆在里头了.
```tsx
"use client"

import { FormEvent, useState } from "react"
import Link from "next/link"
import { useRouter } from "next/navigation"
import { ArrowRight, Eye, EyeOff, LoaderCircle } from "lucide-react"

import { AuthFormShell } from "@/components/auth-form-shell"
import { Button } from "@/components/ui/button"
import { getApiErrorMessage } from "@/lib/api/errors"
import { saveSession } from "@/lib/api/auth"
import { apiLoginAccessPost, apiUserRegisterPost } from "@/lib/api/generated"

export default function RegisterPage() {
  const router = useRouter()
  const [name, setName] = useState("")
  const [password, setPassword] = useState("")
  const [confirmPassword, setConfirmPassword] = useState("")
  const [showPassword, setShowPassword] = useState(false)
  const [error, setError] = useState("")
  const [isSubmitting, setIsSubmitting] = useState(false)

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault()
    setError("")

    const normalizedName = name.trim()
    if (!normalizedName) {
      setError("请输入用户名。")
      return
    }

    if (password.length < 6) {
      setError("密码至少需要 6 个字符。")
      return
    }

    if (password !== confirmPassword) {
      setError("两次输入的密码不一致。")
      return
    }

    setIsSubmitting(true)

    try {
      const registration = await apiUserRegisterPost({
        body: { name: normalizedName, password },
      })

      if (registration.error) {
        throw registration.error
      }

      const login = await apiLoginAccessPost({
        body: {
          username: normalizedName,
          password,
          grant_type: "password",
          scope: "",
        },
      })

      if (login.error || !login.data?.access_token) {
        throw login.error ?? new Error("注册成功，但自动登录失败。")
      }

      saveSession(login.data.access_token, normalizedName)
      router.replace("/user/me/chat")
    } catch (requestError) {
      setError(getApiErrorMessage(requestError, "注册失败，请检查信息后重试。"))
    } finally {
      setIsSubmitting(false)
    }
  }

  return (
    <AuthFormShell
      eyebrow="Create account"
      title="创建你的账户"
      description="注册完成后系统会自动登录，并带你进入专属聊天空间。"
    >
      <form onSubmit={handleSubmit} className="space-y-5">
        <label className="block space-y-2">
          <span className="text-sm font-medium">用户名</span>
          <input
            value={name}
            onChange={(event) => setName(event.target.value)}
            autoComplete="username"
            className="h-12 w-full rounded-xl border bg-background px-4 text-sm shadow-xs transition placeholder:text-muted-foreground/70 focus:border-primary focus:ring-4 focus:ring-primary/10 focus:outline-none"
            placeholder="输入你的用户名"
          />
        </label>
// 省略一大段代码
        {error ? (
          <p role="alert" className="rounded-xl border border-destructive/20 bg-destructive/8 px-4 py-3 text-sm text-destructive">
            {error}
          </p>
        ) : null}

        <Button type="submit" size="lg" className="h-12 w-full rounded-xl text-base" disabled={isSubmitting}>
          {isSubmitting ? <LoaderCircle className="animate-spin" /> : null}
          注册并进入
          {!isSubmitting ? <ArrowRight /> : null}
        </Button>

        <p className="text-center text-sm text-muted-foreground">
          已有账户？{" "}
          <Link href="/user/login" className="font-medium text-foreground underline-offset-4 hover:underline">
            直接登录
          </Link>
        </p>
      </form>
    </AuthFormShell>
  )
}
```

不过,即便再怎么说AI写的不行,要自己来写出上面的代码也是不太可能的,这里面的状态管理和组件UI没有长期的学习经历的话,就跟看天书没有太大区别.
### 总结
尽管如此,好在前端现在已经足够自动化了,测试文件可以通过录制浏览器操作生成,构建流程可以用next命令一键完成,必要的组件都可以直接复用shadcn的,API请求函数可以用hey-api生成.

但剩下的内容才是重中之重,要想完成我们这个智能体的前端,我们还需要学习以下知识:
1. next.js的路由方法
2. React的状态管理
3. 使用tailwind css修饰shadcn带入的组件
## ch10: 重构前端?
>[!NOTE]
>(8/20): 原谅我之前的不识好歹,真要掌握上面三个知识点还是太累了,但我现在时间却不太够用了,毕竟还想拿这个项目去面试的时候混一混呢~,所以先拿AI占个坑,待日后再战

不管怎样,我先拿AI混了一版出来:

![AI版](PixPin_2026-08-21_13-10-26.webp)

尽管AI已经很努力了,但我的后端肉眼可见的有以下不足:
1. 不支持多轮对话,无法根据以前的消息来回答
2. 不支持对话组,每次对话没有一个统一的id
3. 没有保存用户的提问信息,也没能将thinking和content分开输出
4. 没有异常处理,也没有限制用户的使用量和调用额度.

## ch11: 完善不足之处,实现多轮对话
### models.py重构
首先,看一下我们之前的`models.py`文件:
```py
class UserBase(SQLModel):
    name: str | None = Field(default=None, max_length=255)
    is_active: bool = True


class UserRegister(SQLModel):
    password: str
    name: str = Field(default=None, max_length=255)


class UserCreate(UserBase):
    password: str = Field(min_length=8, max_length=16)


class UserPublic(UserBase):
    id: int | None
    created_at: datetime | None = None


class User(UserBase, table=True):
    id: int | None = Field(default=None, primary_key=True)
    hashed_password: str
    created_at: datetime | None = Field(
        default_factory=get_datetime,
    )
    chats: list["ChatMessage"] = Relationship(
        back_populates="user",
        cascade_delete=True,
    )


class Message(SQLModel):
    message: str


class ChatMessage(SQLModel, table=True):
    chat_id: int | None = Field(default=None, primary_key=True)
    content: str | None = None
    created_at: datetime | None = Field(
        default_factory=get_datetime,
    )
    user_id: int | None = Field(foreign_key="user.id")
    user: User | None = Relationship(back_populates="chats")


class ChatMessagePublic(SQLModel):
    chat_id: int
    content: str | None
    created_at: datetime | None


class Token(SQLModel):
    access_token: str
    token_type: str = "bearer"


class TokenPayload(SQLModel):
    sub: str | None = None
```
我们需要进行下述修改:
1. UserCreate实际上并没有用到,他与UserRegister实际上是冲突的,所以只用UserRegister就行了,这属于早期的决策失误,~~如果以后我能出书的话再直接去掉~~😉
## ch12: 完善CRUD和数据库管理,加入管理员用户
### 数据库管理系统选择
- adminer与dbgate.
## ch13: 加入文件上传,实现多模态和多智能体
# 智能体进阶

