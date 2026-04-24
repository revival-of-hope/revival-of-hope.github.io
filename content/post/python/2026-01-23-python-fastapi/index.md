---
title: 2026-01-23 python-fastapi
tags:
  - python
date: 2026-01-23 08:00:00
image: 75657296_p0-我的世界是寂静无声的。.webp
---

[官方文档](https://fastapi.tiangolo.com/python-types)

## Intro

### PYTHON TYPES INTRO
```python
def get_full_name(first_name, last_name):
    full_name = first_name.title() + " " + last_name.title()
    return full_name

print(get_full_name("john", "doe"))
```

`    first_name, last_name`
->:
`    first_name: str, last_name: str`

>这就是类型注释,不仅方便自己和别人阅读代码,也方便编辑器理解并能够支持自动补全

### ASYNC/AWAIT
- **async**:asynchronous,异步的
```python
import asyncio


async def task_a():
    print("A: start")
    await asyncio.sleep(3)
    print("A: end")


async def task_b():
    print("B: start")
    await asyncio.sleep(1)
    print("B: end")


async def main():
    print("main: start")

    asyncio.create_task(task_a())
    asyncio.create_task(task_b())

    print("main: tasks created")

    await asyncio.sleep(4)

    print("main: end")


asyncio.run(main())
```
>在这段代码中,await代码块会在原地等待对应的秒数,允许同时进行其他的模块,因此整个代码总用时只有4秒

- **await** only take effect in the function decorated with **async**

## Start
### PATH PARAMETERS
```python
from fastapi import FastAPI

app = FastAPI()


@app.get("/items/{item_id}")
async def read_item(item_id: int):
    return {"item_id": item_id}
```
>app.get registers a GET operation for the path /items/{item_id}, binding the request to the function below.
- Here,the path could be viewed as the http path

### Query Parameters

```python
@app.get("/items/{item_id}")
async def read_item(item_id: str, q: str | None = None, short: bool = False):
    item = {"item_id": item_id}
    if q:
        item.update({"q": q})
    if not short:
        item.update({
            "description":
            "This is an amazing item that has a long description"
        })
    return item
```
>访问`http://127.0.0.1:8000/items/foo?short=1&q=1`可以明白,fastapi原生就支持参数的选择;而且,每次fastapi请求都是独立的,也就是会直接覆盖上次输出的json(openapi结构),而不会保存下来,这一点可以通过访问`http://127.0.0.1:8000/items/foo?short=0`后再访问`http://127.0.0.1:8000/items/foo?short=1`中看出来

### Request Body
>A request body is data sent by the client to your API. A response body is the data your API sends to the client.
>
>Your API almost always has to send a response body. But clients don't necessarily need to send request bodies all the time, sometimes they only request a path, maybe with some query parameters, but don't send a body.

### Query and Path
由于官方文档关于path和query这两个参数的部分有些破碎,彼此之间不够有体系,我看的也头晕,因此重新组织了一下
```python
from typing import Annotated

from fastapi import FastAPI, Path, Query

app = FastAPI()


@app.get("/items/{item_id}")
async def read_items(
    *,
    item_id: Annotated[int, Path(title="The ID of the item to get", ge=0, le=1000)],
    q: str,
    size: Annotated[float, Query(gt=0, lt=10.5)],
):
    results = {"item_id": item_id}
    if q:
        results.update({"q": q})
    if size:
        results.update({"size": size})
    return results
```
>根据这个代码可以明确的知道path是路径参数,对你输入的网址地址做出规范;而query是查询参数,对`http://127.0.0.1:8000/items/1546?item-query=23`中的?后部分做出规范,这么一想就非常简单了

>by default, singular values are interpreted as query parameters, you don't have to explicitly add a Query
也就是说,没写明是什么类型的变量一律视为query类型,比如这里的q
- 这里的Annotated是typing库中用于规范化type hint和参数声明的框架,规定列表第一个是type hint,后面的都是metadata,也就是参数声明

- 没绷住看到现在才发现fastapi有[中文文档](https://fastapi.org.cn/tutorial/encoder/),我寻思官网上也选不了中文啊,应该是个人用爱发电搞的



### fastapi中的OAuth2验证
1. 用户在前端输入 `username` 和 `password`，按下 Enter  
2. 前端（运行在浏览器中）将 `username` 和 `password` 发送到 API 的指定 URL  
   - 该 URL 通过 `tokenUrl="token"` 声明  
3. API 校验 `username` 和 `password`  
4. 校验通过后，API 返回一个 **token**
   - token 本质上是一个字符串
   - 用于后续标识和验证用户身份  
5. token 通常具有 **有效期**
   - 到期后用户需要重新登录
   - 即使 token 被盗，风险也有限  
6. 前端将 token **临时存储**（如内存、本地存储等）  
7. 用户在前端进入应用的其他页面  
8. 前端需要向 API 请求受保护的数据  
9. 前端在请求中携带 `Authorization` 请求头进行身份认证  
```python
from typing import Annotated

from fastapi import Depends, FastAPI
from fastapi.security import OAuth2PasswordBearer

app = FastAPI()

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


@app.get("/items/")
async def read_items(token: Annotated[str, Depends(oauth2_scheme)]):
    return {"token": token}
```
当引入Oauth组件时,只需在函数里加上一个Depends方法就可以初步实现需要验证才可以进行的访问

### Depends方法详解
Depends()可以看作是fastapi中的一个注入外部函数机制,从字面意义上来理解,Depends()中包含的函数是对应变量的依赖,也就是说,Depends告诉fastapi这个变量需要通过调用Depends中的函数得到.
如果不这么写,那么就需要显式传入用户变量,这显然是不够安全和工程化的

### 模拟用户输入
```python
from typing import Annotated

from fastapi import Depends, FastAPI, HTTPException, status
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from pydantic import BaseModel

fake_users_db = {
    "johndoe": {
        "username": "johndoe",
        "full_name": "John Doe",
        "email": "johndoe@example.com",
        "hashed_password": "fakehashedsecret",
        "disabled": False,
    },
    "alice": {
        "username": "alice",
        "full_name": "Alice Wonderson",
        "email": "alice@example.com",
        "hashed_password": "fakehashedsecret2",
        "disabled": True,
    },
}

app = FastAPI()


def fake_hash_password(password: str):
    return "fakehashed" + password


oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


class User(BaseModel):
    username: str
    email: str | None = None
    full_name: str | None = None
    disabled: bool | None = None


class UserInDB(User):
    hashed_password: str


def get_user(db, username: str):
    if username in db:
        user_dict = db[username]
        return UserInDB(**user_dict)


def fake_decode_token(token):
    # This doesn't provide any security at all
    # Check the next version
    user = get_user(fake_users_db, token)
    return user


async def get_current_user(token: Annotated[str, Depends(oauth2_scheme)]):
    user = fake_decode_token(token)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Not authenticated",
            headers={"WWW-Authenticate": "Bearer"},
        )
    return user


async def get_current_active_user(
    current_user: Annotated[User, Depends(get_current_user)],
):
    if current_user.disabled:
        raise HTTPException(status_code=400, detail="Inactive user")
    return current_user


@app.post("/token")
async def login(form_data: Annotated[OAuth2PasswordRequestForm, Depends()]):
    user_dict = fake_users_db.get(form_data.username)
    if not user_dict:
        raise HTTPException(status_code=400, detail="Incorrect username or password")
    user = UserInDB(**user_dict)
    hashed_password = fake_hash_password(form_data.password)
    if not hashed_password == user.hashed_password:
        raise HTTPException(status_code=400, detail="Incorrect username or password")

    return {"access_token": user.username, "token_type": "bearer"}


@app.get("/users/me")
async def read_users_me(
    current_user: Annotated[User, Depends(get_current_active_user)],
):
    return current_user
```

## Bigger Applications - Multiple Files(2/5)

**users.py**
```python
from fastapi import APIRouter

router = APIRouter()


@router.get("/users/", tags=["users"])
async def read_users():
    return [{"username": "Rick"}, {"username": "Morty"}]


@router.get("/users/me", tags=["users"])
async def read_user_me():
    return {"username": "fakecurrentuser"}


@router.get("/users/{username}", tags=["users"])
async def read_user(username: str):
    return {"username": username}
```
>You can think of APIRouter as a "mini FastAPI" class.

**items.py**
```python
from fastapi import APIRouter, Depends, HTTPException

from ..dependencies import get_token_header

router = APIRouter(
    prefix="/items",
    tags=["items"],
    dependencies=[Depends(get_token_header)],
    responses={404: {"description": "Not found"}},
)


fake_items_db = {"plumbus": {"name": "Plumbus"}, "gun": {"name": "Portal Gun"}}


@router.get("/")
async def read_items():
    return fake_items_db


@router.get("/{item_id}")
async def read_item(item_id: str):
    if item_id not in fake_items_db:
        raise HTTPException(status_code=404, detail="Item not found")
    return {"name": fake_items_db[item_id]["name"], "item_id": item_id}


@router.put(
    "/{item_id}",
    tags=["custom"],
    responses={403: {"description": "Operation forbidden"}},
)
async def update_item(item_id: str):
    if item_id != "plumbus":
        raise HTTPException(
            status_code=403, detail="You can only update the item: plumbus"
        )
    return {"item_id": item_id, "name": "The great Plumbus"}
```
**main.py**
```python
from fastapi import Depends, FastAPI

from .dependencies import get_query_token, get_token_header
from .internal import admin
from .routers import items, users

app = FastAPI(dependencies=[Depends(get_query_token)])


app.include_router(users.router)
app.include_router(items.router)
app.include_router(
    admin.router,
    prefix="/admin",
    tags=["admin"],
    dependencies=[Depends(get_token_header)],
    responses={418: {"description": "I'm a teapot"}},
)


@app.get("/")
async def root():
    return {"message": "Hello Bigger Applications!"}
```
重点关注下面的代码
```python
app.include_router(
    admin.router,
    prefix="/admin",
    tags=["admin"],
    dependencies=[Depends(get_token_header)],
    responses={418: {"description": "I'm a teapot"}},
)
```
>The result is that in our app, each of the path operations from the admin module will have:
1. The prefix /admin.
2. The tag admin.
3. The dependency get_token_header.
4. The response 418. 

