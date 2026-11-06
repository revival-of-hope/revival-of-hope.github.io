---
title: "IM项目"
date: 2026-11-06T09:20:50+08:00
description: 
image: 122308550_p0-无题.webp
tags: 
    - 调研
math: 
draft: true
---
>[!NOTE]
>
>目标: 结合WebSocket的FastAPI+Postgres+SQLModel+Redis+Kafka+Kubernetes+Prometheus+Grafana+pytest,做一个即时通讯(Instant Messaging)软件出来,前端采用普通的Zustand+React+TanStack Query(根据情况考虑是否用AI写前端).

## ch0: 前言
1. 为什么做这个项目?
   1. 锻炼学习自己,有很多我不熟悉的领域,最多看过相关的书籍,但没有深入实践过
2. 你跟其他IM软件的区别?
   1. 比较独特,至少Github上没找到技术栈选型完全一样的项目(即使是一些AI项目也只是部分重合)
## ch1: redis-py学习
### 初印象
docker启动redis:
```bash
docker run -d --name redis -p 6379:6379 redis:8-alpine
```

使用redis-cli与刚刚启动的redis交互:
```bash
docker exec -it redis redis-cli
```
若出现`127.0.0.1:6379>`交互提示则说明Redis运行正常

使用uv启用python示例项目:
```python
import redis

r = redis.Redis(host="localhost", port=6379, decode_responses=True)

r.set("bike:1", "Process 134")
print(r.get("bike:1"))
```

运行后成功打印值`Process 134`.


- 连接到Redis的另一个方式则是使用DSN的url格式:
```python
r = redis.from_url("redis://default:<password>@<host>:<port>")
```

存取字符串:
```python
r.set('foo', 'bar')
# True
r.get('foo')
# bar
```

存储dict:
```py
r.hset(
    "user:123",
    mapping={
        "name": "john",
        "age": 29,
        "company": "Redis",
    },
)

print(r.hget("user:123", "name"))
print(r.hgetall("user:123"))
```

关闭连接:
```py
r.close()
```
### 基础知识
#### 连接方式
redis.Redis初始化方法默认使用`localhost:6379`,且使用数据库0,所以我们只需要配置`decode_responses=True`即可,写成`r=redis.Redis(decode_responses=True)`即可,如果不配置的话,则会默认返回字节格式(bytes),可读性是一方面,数据处理上影响就大了.
#### 异步配置
Redis支持Async配置:
```py
import redis.asyncio as redis
import asyncio


async def basic_example():
    r = redis.Redis(host="localhost", port=6379, decode_responses=True)
    await r.set("foo", "bar")
    value = await r.get("foo")
    print(value)
    # bar
    await r.aclose()


asyncio.run(basic_example())
```
更推荐的写法是使用`async with`来自动关闭连接:
```py
async def context_example():
    async with redis.Redis(
        host='localhost', port=6379, decode_responses=True
    ) as r:
        await r.set('foo', 'bar')
        value = await r.get('foo')
        print(value)
        # bar

asyncio.run(context_example())
```
都开异步了,自然需要支持连接池,否则开了个寂寞:
```py
async def shared_client_example():
    # Create one client at startup. It owns its own internal pool,
    # which is sized by max_connections.
    r = redis.Redis(
        host='localhost', port=6379, decode_responses=True,
        max_connections=10,
    )
    try:
        # Share `r` across every request and task for the app's lifetime.
        await r.set('foo', 'bar')
        value = await r.get('foo')
        print(value)
        # bar
    finally:
        # Close the client at shutdown to release pooled connections.
        await r.aclose()

asyncio.run(shared_client_example())
```

Redis的事务管理长这样:
```py
async def pipeline_example():
    async with redis.Redis(
        host='localhost', port=6379, decode_responses=True
    ) as r:
        async with r.pipeline(transaction=True) as pipe:
            pipe.set('a', '1')
            pipe.set('b', '2')
            pipe.get('a')
            pipe.get('b')
            results = await pipe.execute()
            print(results)
            # [True, True, '1', '2']

asyncio.run(pipeline_example())
```

### 进阶知识

#### Client-side caching
这里的客户端指的是连接数据库的后端,无论是字符串的值,还是hash表的值,都可以在第一次存取后缓存在客户端中,从而极大地降低延迟
![架构](PixPin_2026-11-06_10-07-00.webp)

配置方法如下:
```py
import redis
from redis.cache import CacheConfig

r = redis.Redis(
    protocol=3,
    cache_config=CacheConfig(),
    decode_responses=True
)

r.set("city", "New York")
cityNameAttempt1 = r.get("city")    # Retrieved from Redis server and cached
cityNameAttempt2 = r.get("city")    # Retrieved from cache
```

## ch2: confluent-kafka学习

## ch3: 相关项目学习
当我们想要从零开始搭建一个新领域项目时,往往是无从下手的,原因很简单,你见都没见过相关代码,怎么可能突然就会写了呢,所以,我们需要先找一下相关的领域项目,学习前人的设计经验.

### 小型项目1
- [仓库](https://github.com/notarious2/fastapi-chat)

技术栈选型:
* FastAPI, Websockets, Pydantic 2
* Postgres (asyncpg), async Redis (PubSub and Cache)
* SQLAlchemy 2

技术选型是非常对我胃口的,现在来具体分析一下.

一般来说,看一个python后端项目,我倾向于先看`main.py`,再看models,再看api,再看crud,最后看测试和配置,让我们按照这个流程来走一遍.
#### main.py
```py
import logging

import redis.asyncio as aioredis
import sentry_sdk
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from fastapi_limiter import FastAPILimiter
from fastapi_pagination import add_pagination
from sqladmin import Admin

from src.admin.admin import admin_models
from src.admin.authentication_backend import authentication_backend
from src.config import LOGGING_CONFIG, settings
from src.database import engine, redis_pool
from src.routers import routers


logger = logging.getLogger(__name__)


app = FastAPI()
app.mount("/static", StaticFiles(directory="src/static"), name="static")

admin = Admin(app, engine, authentication_backend=authentication_backend)

for router in routers:
    app.include_router(router)


allowed_origins = settings.ALLOWED_ORIGINS.split(",")


app.add_middleware(
    CORSMiddleware,
    allow_origins=allowed_origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

add_pagination(app)


@app.on_event("startup")
async def startup():
    logger.info("Application is started")
    redis = aioredis.Redis(connection_pool=redis_pool)
    await FastAPILimiter.init(redis)


# Error displayed on shutdown (will be fixed in later versions): https://github.com/python/cpython/issues/109538
@app.on_event("shutdown")
async def shutdown_event():
    logger.info("Application is closed")


# register admin models
for model in admin_models:
    admin.add_view(model)
```
看到了好几个没见过的库和fastapi方法:
1. `app.mount("/static")`: 挂载静态文件,从`static`路由访问,如`src/static/logo.png`对应`http://localhost:8000/static/logo.png`
   1. 不过只要有前端的话,这个方法就没必要用了
2. `from sqladmin import Admin`: 在FastAPI项目中快速创建一个Web管理后台,支持CRUD,直接通过ORM和session创建,绕过Service层
   1. 顶多用到小项目中,这完全是代码架构的破坏利器
3. `from fastapi_limiter import FastAPILimiter`: fastapi限流器,毕竟官方不支持限流,所以只好用第三方库了
   1. 不过现在这库的api改了,所以原代码中的写法也需要改
4. `@app.on_event("startup")`: `on_event`方法已经启用,现在统一用lifespan了.lifespan是fastapi应用的生命周期管理器,负责应用启动和关闭时需要执行的操作,基本用法如下:

```py
from contextlib import asynccontextmanager
from fastapi import FastAPI


@asynccontextmanager
async def lifespan(app: FastAPI):
    # 应用启动时执行
    print("Application starting...")

    yield

    # 应用关闭时执行
    print("Application shutting down...")


app = FastAPI(lifespan=lifespan)
```

这非常适合于需要显式关闭数据库连接的情况:
```py
@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup
    redis = Redis.from_url(REDIS_URL)
    app.state.redis = redis

    try:
        await redis.ping()
        yield
    finally:
        # Shutdown
        await redis.aclose()
        await engine.dispose()
```

#### models.py

```py
import enum
import uuid
from datetime import datetime
from typing import Any, List

from sqlalchemy import Boolean, Column, DateTime, Enum, ForeignKey, Index, String, Table
from sqlalchemy.dialects.postgresql import JSONB, UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship

from src.database import BaseModel, RemoveBaseFieldsMixin, metadata


class ChatType(enum.Enum):
    DIRECT = "direct"
    GROUP = "group"


chat_participant = Table(
    "chat_participant",
    metadata,
    Column("user_id", ForeignKey("user.id"), primary_key=True),
    Column("chat_id", ForeignKey("chat.id"), primary_key=True),
)


class User(BaseModel):
    __tablename__ = "user"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    guid: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), unique=True, default=uuid.uuid4)
    password: Mapped[str] = mapped_column(String(128))
    username: Mapped[str] = mapped_column(String(150), unique=True)
    first_name: Mapped[str] = mapped_column(String(150), default="")
    last_name: Mapped[str] = mapped_column(String(150), default="")
    email: Mapped[str] = mapped_column(String(254), unique=True)
    last_login: Mapped[datetime] = mapped_column(DateTime(timezone=True), nullable=True)
    is_superuser: Mapped[bool] = mapped_column(Boolean, default=False)
    user_image: Mapped[str] = mapped_column(String(1048), nullable=True)
    settings: Mapped[dict[str, Any]] = mapped_column(JSONB, server_default="{}")
    is_deleted: Mapped[bool] = mapped_column(Boolean, default=False)  # redefine is_deleted column for index

    chats: Mapped[List["Chat"]] = relationship(secondary=chat_participant, back_populates="users")
    messages: Mapped[List["Message"]] = relationship(back_populates="user")
    read_statuses: Mapped[List["ReadStatus"]] = relationship(back_populates="user")

    def __str__(self):
        return f"{self.username}"

    # Indexes

    __table_args__ = (
        Index("idx_user_on_email_username", "email", "username", postgresql_concurrently=True),
        Index(
            "idx_user_partial_on_email_not_deleted",
            "email",
            "is_deleted",
            postgresql_concurrently=True,
            postgresql_where=(is_deleted.is_(False)),
        ),
    )


class Chat(BaseModel):
    __tablename__ = "chat"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    guid: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), default=uuid.uuid4)
    chat_type: Mapped[str] = mapped_column(Enum(ChatType, inherit_schema=True))

    users: Mapped[List["User"]] = relationship(secondary=chat_participant, back_populates="chats")
    messages: Mapped[List["Message"]] = relationship(back_populates="chat", cascade="all,delete")
    read_statuses: Mapped[List["ReadStatus"]] = relationship(back_populates="chat", cascade="all,delete")

    def __str__(self):
        return f"{self.chat_type.value.title()} {self.guid}"

    __table_args__ = (
        Index("idx_chat_on_is_deleted_chat_type", "is_deleted", "chat_type", postgresql_concurrently=True),
        Index("idx_chat_on_guid", "guid", postgresql_concurrently=True),
    )


class MessageType(enum.Enum):
    TEXT = "text"
    FILE = "file"


class Message(BaseModel):
    __tablename__ = "message"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    guid: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), default=uuid.uuid4)
    message_type: Mapped[str] = mapped_column(Enum(MessageType, inherit_schema=True), default=MessageType.TEXT)
    content: Mapped[str] = mapped_column(String(5000))
    user_id: Mapped[int] = mapped_column(ForeignKey("user.id"))
    chat_id: Mapped[int] = mapped_column(ForeignKey("chat.id"))

    file_name: Mapped[str] = mapped_column(String(50), nullable=True)
    file_path: Mapped[str] = mapped_column(String(1000), nullable=True)

    chat: Mapped["Chat"] = relationship(back_populates="messages")
    user: Mapped["User"] = relationship(back_populates="messages")

    def __str__(self):
        return f"{self.content}"

    __table_args__ = (
        Index("idx_message_on_chat_id", "chat_id", postgresql_concurrently=True),
        Index("idx_message_on_user_id", "user_id", postgresql_concurrently=True),
        Index("idx_message_on_user_id_chat_id", "chat_id", "user_id", postgresql_concurrently=True),
    )


class ReadStatus(RemoveBaseFieldsMixin, BaseModel):
    __tablename__ = "read_status"

    id: Mapped[int] = mapped_column(primary_key=True, autoincrement=True)
    last_read_message_id: Mapped[int] = mapped_column(nullable=True)
    user_id: Mapped[int] = mapped_column(ForeignKey("user.id"))
    chat_id: Mapped[int] = mapped_column(ForeignKey("chat.id"))

    # to display unread messages for a user in different chats
    chat: Mapped["Chat"] = relationship(back_populates="read_statuses")
    user: Mapped["User"] = relationship(back_populates="read_statuses")

    def __str__(self):
        return f"User: {self.user_id}, Message: {self.last_read_message_id}"

    __table_args__ = (
        Index("idx_read_status_on_chat_id", "chat_id", postgresql_concurrently=True),
        Index("idx_read_status_on_user_id", "user_id", postgresql_concurrently=True),
    )
```
>用sqlalchemy写的,我看着不太习惯,但由于老项目都是用的它,所以还是勉强自己看下去.



