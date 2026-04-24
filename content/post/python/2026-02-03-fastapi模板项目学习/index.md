---
title: 2026-02-03 fastapi模板项目学习
tags:
  - 新技术
date: 2026-02-03 08:00:00
image: 85139347_p0-無題.webp
---
>如果你像我一样没怎么用过docker,不了解前后端之间具体如何工作,而只是照着模板项目的md边问ai边运行项目的话,看到这个界面肯定是懵的

![alt text](PixPin_2026-02-03_13-56-30.webp)

>当我尝试问ai时,它直接告诉我有这么多端口

![alt text](PixPin_2026-02-03_13-59-17.webp)
点进去是这些画面
![alt text](PixPin_2026-02-03_14-00-27.webp)
![alt text](PixPin_2026-02-03_14-00-51.webp)
![alt text](PixPin_2026-02-03_14-01-06.webp)

即便我大致看过了fastapi的教程,稍微了解了一点数据库知识,自以为可以开始做项目了,这些界面直接将我打回原形,显然工程上的前后端还是很难懂的,不是一个普通学生可以轻易学会的

于是我开始翻阅项目文档,并发现项目中基本没写原理,写的都是运行方法,问了问ai,给了以下回答.
>这个模板（full-stack-fastapi-template）针对生产级最佳实践设计，不是为零基础初学者写的。官方文档和 README 假设你已有 FastAPI、Docker、React 基础知识。GitHub discussion #1115 明确说：not beginner friendly，目标是给有经验开发者提供起点。

也正是如此,如果我连这个项目都可以驾驭的话,那么之后做任何前后端应该都不会有任何问题了,下面是我的学习历程
**前置知识**:了解基本的python面向对象语法,详细的研究过fastapi官方文档
## What is docker? How does it works?
**参考**
- [阮一峰教程](https://ruanyifeng.com/blog/2018/02/docker-tutorial.html)
- [官方文档](https://docs.docker.top/build/concepts/overview/index.htm)
### 简单入门
>Docker 把应用程序及其依赖，打包在 image 文件里面。只有通过这个文件，才能生成 Docker 容器。image 文件可以看作是容器的模板。Docker 根据 image 文件生成容器的实例。同一个 image 文件，可以生成多个同时运行的容器实例。

- 也就是说image是一个集成了组件和应用程序的zip,container则可以看成是解压缩,将zip解压成对应平台的适配版本
### dockerfile and docker build
>Docker通过读取Dockerfile中的指令来构建镜像。Dockerfile是一个文本文件，其中包含构建源代码的指令
```dockerfile
FROM node:8.4
COPY . /app
WORKDIR /app
RUN npm install --registry=https://registry.npm.taobao.org
EXPOSE 3000
```
>FROM node:8.4：该 image 文件继承官方的 node image，冒号表示标签，这里标签是8.4，即8.4版本的 node。
COPY . /app：将当前目录下的所有文件（除了.dockerignore排除的路径），都拷贝进入 image 文件的/app目录。
WORKDIR /app：指定接下来的工作路径为/app。
RUN npm install：在/app目录下，运行npm install命令安装依赖。注意，安装后所有的依赖，都将打包进入 image 文件。
EXPOSE 3000：将容器 3000 端口暴露出来， 允许外部连接这个端口。

>有了 Dockerfile 文件以后，就可以使用docker image build命令创建 image 文件了。
`docker image build -t koa-demo`

- docker build 实际上执行的是docker image build
- 可以看出来实际上dockerfile就是像bat一样把所有环境依赖的命令都写在一个文件里一次运行而已,而image就是用docker build构建出来的
#### What is dockerfile.playwrite
仔细一看模板项目目录下有一个dockerfile.playwrite文件,点进去一看发现和一般的dockerfile没什么区别,playwrite实际上就是一个模拟服务器的测试文件,并不会用来制作真正的镜像
```dockerfile
FROM mcr.microsoft.com/playwright:v1.58.0-noble

WORKDIR /app

RUN apt-get update && apt-get install -y unzip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:$PATH"

COPY package.json bun.lock /app/

COPY frontend/package.json /app/frontend/

WORKDIR /app/frontend

RUN bun install

COPY ./frontend /app/frontend

ARG VITE_API_URL
```

### docker run
```powershell
docker run [OPTIONS] IMAGE[:TAG|@DIGEST] [COMMAND] [ARG...]
```
- 事实上`docker run`对应的实际命令是`docker container run`
**eg1**
```bash
$ docker container run -p 8000:3000 -it koa-demo /bin/bash
# 或者
$ docker container run -p 8000:3000 -it koa-demo:0.0.1 /bin/bash
```
>上面命令的各个参数含义如下：
-p参数：容器的 3000 端口映射到本机的 8000 端口。
-it参数：容器的 Shell 映射到当前的 Shell，然后你在本机窗口输入的命令，就会传入容器。
koa-demo:0.0.1：image 文件的名字（如果有标签，还需要提供标签，默认是 latest 标签）。
/bin/bash：容器启动以后，内部第一个执行的命令。这里是启动 Bash，保证用户可以使用 Shell。

>如果一切正常，运行上面的命令以后，就会返回一个命令行提示符。
`root@66d80f4aaf1e:/app#`

- **root**：当前登录的用户标识  
  **本质**：Linux 系统中的超级管理员（Superuser）。  
  拥有对系统的绝对控制权，可修改、删除任何文件。在生产环境中直接使用 `root` 风险极高。

- **@**：连接符  
  **本质**：用于分隔 **用户名** 与 **主机名**。

- **66d80f4aaf1e**：主机名（Hostname）  
  **本质**：在 Docker 环境中，通常是 **容器 ID 的前 12 位短哈希**。  
  这表明当前并不在物理宿主机上，而是在一个隔离的 Docker 容器内部。

- **:/app**：当前工作目录（Current Working Directory）  
  **本质**：位于根目录下的 `app` 文件夹。  
  在 Docker 中，通常用于存放或挂载应用源代码。

- **#**：身份状态位  
  **本质**：  
  - `#` 表示 **root（超级用户）**  
  - `$` 表示 **普通用户**


**eg2**
```powershell
PS C:\Users\...> docker run hello-world

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.
```
>通过这个hello-world image 可以看到docker run 的执行过程
### docker compose
```yml
services:

  db:
    image: postgres:18
    restart: always
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
      interval: 10s
      retries: 5
      start_period: 30s
      timeout: 10s
    volumes:
      - app-db-data:/var/lib/postgresql/data/pgdata
    env_file:
      - .env
    environment:
      - PGDATA=/var/lib/postgresql/data/pgdata
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD?Variable not set}
      - POSTGRES_USER=${POSTGRES_USER?Variable not set}
      - POSTGRES_DB=${POSTGRES_DB?Variable not set}

```
>上面的文件就是docker compose 唯一参照的compose.yml,在cmd中输入`docker compose up`后,docker将会按照yml所写的拉取镜像,配置环境,解决依赖,启动所有项目

**eg**
```yml
mysql:
    image: mysql:5.7
    environment:
     - MYSQL_ROOT_PASSWORD=123456
     - MYSQL_DATABASE=wordpress
web:
    image: wordpress
    links:
     - mysql
    environment:
     - WORDPRESS_DB_PASSWORD=123456
    ports:
     - "127.0.0.3:8080:80"
    working_dir: /var/www/html
    volumes:
     - wordpress:/var/www/html
```
- image: 镜像依赖
- environment: 实际上就是和普通操作系统类似的环境变量
- working_dir: 在 Linux 操作系统中，任何进程运行都必须有一个关联的目录。如果你不指定，它通常默认在根目录 /。设置 working_dir 相当于在执行所有后续操作前，先在容器内部运行了一次 cd 命令。
而volume参数值得专门写一个部分来分析
#### volumes
>默认情况下容器的所有数据都是临时存储的,volumes则帮你把需要保留的数据存入了宿主机
- >A volume's contents exist outside the lifecycle of a given container. When a container is destroyed, the writable layer is destroyed with it. Using a volume ensures that the data is persisted even if the container using it is removed.
```yml
services:
  frontend:
    image: node:lts
    volumes:
      - myapp:/home/node/app
volumes:
  myapp:
```
1. `volumes: myapp:`:告诉docker engine 在宿主机的硬盘下开辟一块由docker控制的空间叫做myapp
2. `volumes: - myapp:/home/node/app`: 将myapp分给`/home/node/app`
3. 第一次运行docker compose up时,docker会将对应目录下的文件copy到myapp里,之后container读写该目录都是直接操作myapp volume,而其他目录不受任何影响
#### docker compose watch
>The watch attribute automatically updates and previews your running Compose services as you edit and save your code. For many projects, this enables a hands-off development workflow once Compose is running, as services automatically update themselves when you save your work.

- 也就是说做到了热更新,修改代码后不必重启容器,而传统的docker compose up就做不到这点

### 实战
```yml
services:

  db:
    image: postgres:18
    restart: always
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
      interval: 10s
      retries: 5
      start_period: 30s
      timeout: 10s
    volumes:
      - app-db-data:/var/lib/postgresql/data/pgdata
    env_file:
      - .env
    environment:
      - PGDATA=/var/lib/postgresql/data/pgdata
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD?Variable not set}
      - POSTGRES_USER=${POSTGRES_USER?Variable not set}
      - POSTGRES_DB=${POSTGRES_DB?Variable not set}

  adminer:
    image: adminer
    restart: always
    networks:
      - traefik-public
      - default
    depends_on:
      - db
    environment:
      - ADMINER_DESIGN=pepa-linha-dark
    labels:
      - traefik.enable=true
      - traefik.docker.network=traefik-public
      - traefik.constraint-label=traefik-public
      - traefik.http.routers.${STACK_NAME?Variable not set}-adminer-http.rule=Host(`adminer.${DOMAIN?Variable not set}`)
      - traefik.http.routers.${STACK_NAME?Variable not set}-adminer-http.entrypoints=http
      - traefik.http.routers.${STACK_NAME?Variable not set}-adminer-http.middlewares=https-redirect
      - traefik.http.routers.${STACK_NAME?Variable not set}-adminer-https.rule=Host(`adminer.${DOMAIN?Variable not set}`)
      - traefik.http.routers.${STACK_NAME?Variable not set}-adminer-https.entrypoints=https
      - traefik.http.routers.${STACK_NAME?Variable not set}-adminer-https.tls=true
      - traefik.http.routers.${STACK_NAME?Variable not set}-adminer-https.tls.certresolver=le
      - traefik.http.services.${STACK_NAME?Variable not set}-adminer.loadbalancer.server.port=8080

  prestart:
    image: '${DOCKER_IMAGE_BACKEND?Variable not set}:${TAG-latest}'
    build:
      context: .
      dockerfile: backend/Dockerfile
    networks:
      - traefik-public
      - default
    depends_on:
      db:
        condition: service_healthy
        restart: true
    command: bash scripts/prestart.sh
    env_file:
      - .env
    environment:
      - DOMAIN=${DOMAIN}
      - FRONTEND_HOST=${FRONTEND_HOST?Variable not set}
      - ENVIRONMENT=${ENVIRONMENT}
      - BACKEND_CORS_ORIGINS=${BACKEND_CORS_ORIGINS}
      - SECRET_KEY=${SECRET_KEY?Variable not set}
      - FIRST_SUPERUSER=${FIRST_SUPERUSER?Variable not set}
      - FIRST_SUPERUSER_PASSWORD=${FIRST_SUPERUSER_PASSWORD?Variable not set}
      - SMTP_HOST=${SMTP_HOST}
      - SMTP_USER=${SMTP_USER}
      - SMTP_PASSWORD=${SMTP_PASSWORD}
      - EMAILS_FROM_EMAIL=${EMAILS_FROM_EMAIL}
      - POSTGRES_SERVER=db
      - POSTGRES_PORT=${POSTGRES_PORT}
      - POSTGRES_DB=${POSTGRES_DB}
      - POSTGRES_USER=${POSTGRES_USER?Variable not set}
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD?Variable not set}
      - SENTRY_DSN=${SENTRY_DSN}

  backend:
    image: '${DOCKER_IMAGE_BACKEND?Variable not set}:${TAG-latest}'
    restart: always
    networks:
      - traefik-public
      - default
    depends_on:
      db:
        condition: service_healthy
        restart: true
      prestart:
        condition: service_completed_successfully
    env_file:
      - .env
    environment:
      - DOMAIN=${DOMAIN}
      - FRONTEND_HOST=${FRONTEND_HOST?Variable not set}
      - ENVIRONMENT=${ENVIRONMENT}
      - BACKEND_CORS_ORIGINS=${BACKEND_CORS_ORIGINS}
      - SECRET_KEY=${SECRET_KEY?Variable not set}
      - FIRST_SUPERUSER=${FIRST_SUPERUSER?Variable not set}
      - FIRST_SUPERUSER_PASSWORD=${FIRST_SUPERUSER_PASSWORD?Variable not set}
      - SMTP_HOST=${SMTP_HOST}
      - SMTP_USER=${SMTP_USER}
      - SMTP_PASSWORD=${SMTP_PASSWORD}
      - EMAILS_FROM_EMAIL=${EMAILS_FROM_EMAIL}
      - POSTGRES_SERVER=db
      - POSTGRES_PORT=${POSTGRES_PORT}
      - POSTGRES_DB=${POSTGRES_DB}
      - POSTGRES_USER=${POSTGRES_USER?Variable not set}
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD?Variable not set}
      - SENTRY_DSN=${SENTRY_DSN}

    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/api/v1/utils/health-check/"]
      interval: 10s
      timeout: 5s
      retries: 5

    build:
      context: .
      dockerfile: backend/Dockerfile
    labels:
      - traefik.enable=true
      - traefik.docker.network=traefik-public
      - traefik.constraint-label=traefik-public

      - traefik.http.services.${STACK_NAME?Variable not set}-backend.loadbalancer.server.port=8000

      - traefik.http.routers.${STACK_NAME?Variable not set}-backend-http.rule=Host(`api.${DOMAIN?Variable not set}`)
      - traefik.http.routers.${STACK_NAME?Variable not set}-backend-http.entrypoints=http

      - traefik.http.routers.${STACK_NAME?Variable not set}-backend-https.rule=Host(`api.${DOMAIN?Variable not set}`)
      - traefik.http.routers.${STACK_NAME?Variable not set}-backend-https.entrypoints=https
      - traefik.http.routers.${STACK_NAME?Variable not set}-backend-https.tls=true
      - traefik.http.routers.${STACK_NAME?Variable not set}-backend-https.tls.certresolver=le

      # Enable redirection for HTTP and HTTPS
      - traefik.http.routers.${STACK_NAME?Variable not set}-backend-http.middlewares=https-redirect

  frontend:
    image: '${DOCKER_IMAGE_FRONTEND?Variable not set}:${TAG-latest}'
    restart: always
    networks:
      - traefik-public
      - default
    build:
      context: .
      dockerfile: frontend/Dockerfile
      args:
        - VITE_API_URL=https://api.${DOMAIN?Variable not set}
        - NODE_ENV=production
    labels:
      - traefik.enable=true
      - traefik.docker.network=traefik-public
      - traefik.constraint-label=traefik-public

      - traefik.http.services.${STACK_NAME?Variable not set}-frontend.loadbalancer.server.port=80

      - traefik.http.routers.${STACK_NAME?Variable not set}-frontend-http.rule=Host(`dashboard.${DOMAIN?Variable not set}`)
      - traefik.http.routers.${STACK_NAME?Variable not set}-frontend-http.entrypoints=http

      - traefik.http.routers.${STACK_NAME?Variable not set}-frontend-https.rule=Host(`dashboard.${DOMAIN?Variable not set}`)
      - traefik.http.routers.${STACK_NAME?Variable not set}-frontend-https.entrypoints=https
      - traefik.http.routers.${STACK_NAME?Variable not set}-frontend-https.tls=true
      - traefik.http.routers.${STACK_NAME?Variable not set}-frontend-https.tls.certresolver=le

      # Enable redirection for HTTP and HTTPS
      - traefik.http.routers.${STACK_NAME?Variable not set}-frontend-http.middlewares=https-redirect
volumes:
  app-db-data:

networks:
  traefik-public:
    # Allow setting it to false for testing
    external: true
```
>这是模板项目中的compose.yml,无论怎么看都很复杂

- healthcheck: 检查容器是否正常工作
  - test: 检查工具和方法
    - pg_isready：数据库专用探测工具，检查数据库是否能接受连接。
    - curl: 模拟用户访问后端api
  - interval: 每10s检查一次
  - retries: 连续失败五次就报错
  - start_period: 容器启动30s后开始检查
- restart: 当容器停止运行时何时重启
  - no: 默认值,表示不再重启
  - always: 一旦停止docker就会尝试重启
- prestart: 使用了与backend相同的image,做一些backend启动前要完成的准备工作后就停止运行
- build: 实际上就是`docker build`,不再去pull image,而是本地构建镜像,如果与image关键字同时出现,就会先检查是否已有image,如果没有才构建新image
  - context: 构建为image的对象
  - 辨析: 之所以要将本地文件构建为image再装载到容器里再运行容器里的本地文件,实际上是为了利用docker的端口,环境设置方便进行统一管理.
- depends_on: 当depends_on下的容器运行好后才会开始运行该容器,确保了逻辑上的顺序不乱
- labels: 面向外部管理工具如traefik,提供对应的指令
- networks: 解决容器之间的相互通信
- ports: 映射到宿主机的通信端口
- Traefik: 反向代理路由
## What is sh?
- [菜鸟教程](https://www.runoob.com/linux/linux-shell.html)
>shell script是功能强大的命令行语言,可以用于Bourne Again Shell（/bin/bash）, Shell（/usr/bin/sh或/bin/sh）等linux的shell中.

>由于docker实际上是linux进程,故也可以在配置对应的sh文件并在compose.yml中写出来,相当于执行了bat脚本

**`command: bash scripts/prestart.sh`**
```sh
#! /usr/bin/env bash

set -e
set -x

# Let the DB start
python app/backend_pre_start.py

# Run migrations
alembic upgrade head

# Create initial data in DB
python app/initial_data.py
```
- #! 告诉系统其后路径所指定的程序即是解释此脚本文件的 Shell 程序。
- 在一般情况下，人们并不区分 Bourne Shell 和 Bourne Again Shell，所以，像 #!/bin/sh，它同样也可以改为 #!/bin/bash。

由于课业原因,暂时不深入了解,若还要用到sh会专门写新博客
## What is adminer and How to use .env file
![alt text](PixPin_2026-02-04_14-31-44.webp)

官网的口号如下:
`Database management in a single PHP file`
也就是说adminer是一个数据库管理的前端页面.

下面先看一下.env文件
```bash
# Domain
# This would be set to the production domain with an env var on deployment
# used by Traefik to transmit traffic and aqcuire TLS certificates
DOMAIN=localhost
# To test the local Traefik config
# DOMAIN=localhost.tiangolo.com

# Used by the backend to generate links in emails to the frontend
FRONTEND_HOST=http://localhost:5173
# In staging and production, set this env var to the frontend host, e.g.
# FRONTEND_HOST=https://dashboard.example.com

# Environment: local, staging, production
ENVIRONMENT=local

PROJECT_NAME="Full Stack FastAPI Project"
STACK_NAME=full-stack-fastapi-project

# Backend
BACKEND_CORS_ORIGINS="http://localhost,http://localhost:5173,https://localhost,https://localhost:5173,http://localhost.tiangolo.com"
SECRET_KEY=changethis
FIRST_SUPERUSER=admin@example.com
FIRST_SUPERUSER_PASSWORD=changethis

# Emails
SMTP_HOST=
SMTP_USER=
SMTP_PASSWORD=
EMAILS_FROM_EMAIL=info@example.com
SMTP_TLS=True
SMTP_SSL=False
SMTP_PORT=587

# Postgres
POSTGRES_SERVER=localhost
POSTGRES_PORT=5432
POSTGRES_DB=app
POSTGRES_USER=postgres
POSTGRES_PASSWORD=changethis

SENTRY_DSN=

# Configure these with your own Docker registry images
DOCKER_IMAGE_BACKEND=backend
DOCKER_IMAGE_FRONTEND=frontend
```
1. 前端和数据库有着不同的管理员账户,这样更加安全,隔离了不同进程
2. Emails是后端程序的邮件设置,比如要发送验证邮件和找回密码邮件
   1. SMTP_HOST：邮件服务器的物理地址
   2. SMTP_USER / SMTP_PASSWORD：对应邮件服务器那里的凭证账户
   3. SMTP_PORT (587)：通信端口
   4. SMTP_TLS=True：开启安全传输。它会在发信前先建立一个加密通道，防止你的账号密码和邮件内容在互联网上被截获。
   5. SMTP_SSL=False：这是另一种老式的加密方式
   6. EMAILS_FROM_EMAIL：用户收到邮件时，看到的“发件人”是谁。
      1. 物理限制：这个地址通常必须和你登录 SMTP_USER 的账号一致，否则邮件服务器会认为你在伪造身份（欺骗），从而拒绝发信

输入对应账户后登录adminer,可以看到就是一个普通的数据库管理界面
![alt text](PixPin_2026-02-04_14-50-38.webp)

随便做些修改
![alt text](PixPin_2026-02-04_14-59-01.webp)
## Look into frontend

![alt text](PixPin_2026-02-04_14-54-55.webp)
登录后看到这个界面
![alt text](PixPin_2026-02-04_14-56-26.webp)
随便做些修改
![alt text](PixPin_2026-02-04_14-56-55.webp)
![alt text](PixPin_2026-02-04_14-58-34.webp)

>之后关闭容器,重新运行docker compose watch,结果发现prestart失败,原来是一不小心在数据库里改了版本号.这也侧面说明数据库的修改在本地文件里存储了
```powershell
prestart-1  | INFO  [alembic.runtime.migration] Will assume transactional DDL.
prestart-1  | ERROR [alembic.util.messaging] Can't locate revision identified by '1eddcfe73d4b96aed0830bb587ece8d9'
prestart-1  | FAILED: Can't locate revision identified by '1eddcfe73d4b96aed0830bb587ece8d9'
```
重新登入adminer页面修改表,再次运行成功,看一下后端页面,发现修改都还保留着.
![alt text](PixPin_2026-02-04_15-08-38.webp)

现在再看一遍compose.yml,感觉上就亲切了许多
`volumes:- app-db-data:/var/lib/postgresql/data/pgdata`保证了只有数据库的修改会保存在本地,services中不同容器通过networks中写的`- traefik-public - default`进行通信,`environment:`写明了所需的众多环境变量并从.env文件中读取.

- 这样看来docker确实非常方便,成功的整合了这么多进程并保证彼此之间相互通信而不出错.

## Look into backend
![alt text](PixPin_2026-02-04_15-26-29.webp)

实际点进去一看文件并没有多到吓人,真正重要的只有api,core和根目录app下的py文件,下面开始逐文件分析

### backend_pre_start.py
```python
import logging

from sqlalchemy import Engine
from sqlmodel import Session, select
from tenacity import after_log, before_log, retry, stop_after_attempt, wait_fixed

from app.core.db import engine

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

max_tries = 60 * 5  # 5 minutes
wait_seconds = 1


@retry(
    stop=stop_after_attempt(max_tries),
    wait=wait_fixed(wait_seconds),
    before=before_log(logger, logging.INFO),
    after=after_log(logger, logging.WARN),
)
def init(db_engine: Engine) -> None:
    try:
        with Session(db_engine) as session:
            # Try to create session to check if DB is awake
            session.exec(select(1))
    except Exception as e:
        logger.error(e)
        raise e


def main() -> None:
    logger.info("Initializing service")
    init(engine)
    logger.info("Service finished initializing")


if __name__ == "__main__":
    main()
```
>首先有一个logging模块,看一下[菜鸟教程](https://www.runoob.com/python3/python-logging.html),大致浏览一下发现是负责日志调试的.
```python
logging.debug("这是一条调试信息")
logging.info("这是一条普通信息")
logging.warning("这是一条警告信息")
logging.error("这是一条错误信息")
logging.critical("这是一条严重错误信息")
```
了解到这个程度就可以了.

>然后是一个retry语法糖,看一下[retry教程](https://py-retry.readthedocs.io/en/latest/retry.html),东西也太少了,转到[tenacity教程](https://tenacity.readthedocs.io/en/latest/),详细多了.

不过稍微看一下代码就可以知道,这里是在时间期限之前每隔一秒钟就重新运行一遍修饰的init函数,然后init函数是负责检查数据库的.也就是说在5min内反复连接数据库,一有报错就弹出来,保证后续能正常操控数据库

- 值得一提的是从core.db导入的engine直接用来作为连接数据库的engine,也就侧面说明了sqlmodel中多个文件都共用同一个engine.

### crud.py
```python
import uuid
from typing import Any

from sqlmodel import Session, select

from app.core.security import get_password_hash, verify_password
from app.models import Item, ItemCreate, User, UserCreate, UserUpdate


def create_user(*, session: Session, user_create: UserCreate) -> User:
    db_obj = User.model_validate(
        user_create, update={"hashed_password": get_password_hash(user_create.password)}
    )
    session.add(db_obj)
    session.commit()
    session.refresh(db_obj)
    return db_obj


def update_user(*, session: Session, db_user: User, user_in: UserUpdate) -> Any:
    user_data = user_in.model_dump(exclude_unset=True)
    extra_data = {}
    if "password" in user_data:
        password = user_data["password"]
        hashed_password = get_password_hash(password)
        extra_data["hashed_password"] = hashed_password
    db_user.sqlmodel_update(user_data, update=extra_data)
    session.add(db_user)
    session.commit()
    session.refresh(db_user)
    return db_user


def get_user_by_email(*, session: Session, email: str) -> User | None:
    statement = select(User).where(User.email == email)
    session_user = session.exec(statement).first()
    return session_user


# Dummy hash to use for timing attack prevention when user is not found
# This is an Argon2 hash of a random password, used to ensure constant-time comparison
DUMMY_HASH = "$argon2id$v=19$m=65536,t=3,p=4$MjQyZWE1MzBjYjJlZTI0Yw$YTU4NGM5ZTZmYjE2NzZlZjY0ZWY3ZGRkY2U2OWFjNjk"


def authenticate(*, session: Session, email: str, password: str) -> User | None:
    db_user = get_user_by_email(session=session, email=email)
    if not db_user:
        # Prevent timing attacks by running password verification even when user doesn't exist
        # This ensures the response time is similar whether or not the email exists
        verify_password(password, DUMMY_HASH)
        return None
    verified, updated_password_hash = verify_password(password, db_user.hashed_password)
    if not verified:
        return None
    if updated_password_hash:
        db_user.hashed_password = updated_password_hash
        session.add(db_user)
        session.commit()
        session.refresh(db_user)
    return db_user


def create_item(*, session: Session, item_in: ItemCreate, owner_id: uuid.UUID) -> Item:
    db_item = Item.model_validate(item_in, update={"owner_id": owner_id})
    session.add(db_item)
    session.commit()
    session.refresh(db_item)
    return db_item
```
>wiki:In computer programming, **create, read, update, and delete** (CRUD) are the four basic operations (actions) of persistent storage.[1] CRUD is also sometimes used to describe user interface conventions that facilitate viewing, searching, and changing information using computer-based forms and reports.
- 我一直在想到底得是多离谱的人才能把这么简单的几个操作包装成一个让人看不懂的缩略词

如文件名所述,这个文件是用来操作数据库的,先看导入的uuid.
**uuid**
```python
import uuid

a = uuid.uuid4()
print(a)
# 24bca086-8c40-457b-abed-be1c8c90288f
```
简单来说uuid就是从本机中读取128位的随机数,并进行特定的改写,由于数据量极其庞大,故不太可能重复.

---
**dummy hash**
输入账户进行登录时,如果用户存在,那么就要进行一次Aragon2验证,当用户不存在时,如果直接return,骇客就可以根据响应速度来导出用户名单.
通过使用dummy_hash这一个与真实用户密码相同的Aragon2密码,在用户不存在时也进行一次验证,从而确保响应速度相同.

---

其实看一遍文件便大概清楚大多数代码都不太需要直接用fastapi,没有async def,也没有@app.post()这样的语法糖,这些用法只在routes模块中会出现,这样严格的工程划分非常优美.

- initial_data.py可以跳过,仅仅是执行了core.db中的init_db而已
### main.py
```python
import sentry_sdk
from fastapi import FastAPI
from fastapi.routing import APIRoute
from starlette.middleware.cors import CORSMiddleware

from app.api.main import api_router
from app.core.config import settings


def custom_generate_unique_id(route: APIRoute) -> str:
    return f"{route.tags[0]}-{route.name}"


if settings.SENTRY_DSN and settings.ENVIRONMENT != "local":
    sentry_sdk.init(dsn=str(settings.SENTRY_DSN), enable_tracing=True)

app = FastAPI(
    title=settings.PROJECT_NAME,
    openapi_url=f"{settings.API_V1_STR}/openapi.json",
    generate_unique_id_function=custom_generate_unique_id,
)

# Set all CORS enabled origins
if settings.all_cors_origins:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.all_cors_origins,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

app.include_router(api_router, prefix=settings.API_V1_STR)
```
>`import sentry_sdk`
#### What is sentry_sdk
- [官方文档](https://docs.sentry.io/product/)
  
简单的说,是一个远程的异常收集系统,将服务器的异常发送到sentry控制台以便远程分析
#### What's the hell
```python
if settings.all_cors_origins:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.all_cors_origins,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )
```
>这个部分很难看懂,先看一下库中的源码
```python
from starlette.middleware import Middleware, _MiddlewareFactory
# ...
    def add_middleware(
        self,
        middleware_class: _MiddlewareFactory[P],
        *args: P.args,
        **kwargs: P.kwargs,
    ) -> None:
        if self.middleware_stack is not None:  # pragma: no cover
            raise RuntimeError("Cannot add middleware after an application has started")
        self.user_middleware.insert(0, Middleware(middleware_class, *args, **kwargs))
```
>显然还是看不懂,先看一下starlette的[官方文档](https://starlette.dev/).

>介绍如下:
Starlette is a lightweight ASGI framework/toolkit, which is ideal for building async web services in Python.

>再看一下ASGI的[文档](https://asgi.readthedocs.io/en/latest/introduction.html)😅
ASGI (Asynchronous Server Gateway Interface) is a spiritual successor to WSGI, intended to provide a standard interface between async-capable Python web servers, frameworks, and applications.

>再看一下WSGI的[文档](https://wsgi.readthedocs.io/en/latest/what.html)😅
WSGI is the Web Server Gateway Interface. It is a specification that describes how a web server communicates with web applications, and how web applications can be chained together to process one request.

好吧,我之后再写一篇博客来详细分析这个asgi和wsgi🙂

---

### models.py
```python
import uuid
from datetime import datetime, timezone

from pydantic import EmailStr
from sqlalchemy import DateTime
from sqlmodel import Field, Relationship, SQLModel


def get_datetime_utc() -> datetime:
    return datetime.now(timezone.utc)


# Shared properties
class UserBase(SQLModel):
    email: EmailStr = Field(unique=True, index=True, max_length=255)
    is_active: bool = True
    is_superuser: bool = False
    full_name: str | None = Field(default=None, max_length=255)


# Properties to receive via API on creation
class UserCreate(UserBase):
    password: str = Field(min_length=8, max_length=128)


class UserRegister(SQLModel):
    email: EmailStr = Field(max_length=255)
    password: str = Field(min_length=8, max_length=128)
    full_name: str | None = Field(default=None, max_length=255)


# Properties to receive via API on update, all are optional
class UserUpdate(UserBase):
    email: EmailStr | None = Field(default=None, max_length=255)  # type: ignore
    password: str | None = Field(default=None, min_length=8, max_length=128)


class UserUpdateMe(SQLModel):
    full_name: str | None = Field(default=None, max_length=255)
    email: EmailStr | None = Field(default=None, max_length=255)


class UpdatePassword(SQLModel):
    current_password: str = Field(min_length=8, max_length=128)
    new_password: str = Field(min_length=8, max_length=128)


# Database model, database table inferred from class name
class User(UserBase, table=True):
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    hashed_password: str
    created_at: datetime | None = Field(
        default_factory=get_datetime_utc,
        sa_type=DateTime(timezone=True),  # type: ignore
    )
    items: list["Item"] = Relationship(back_populates="owner", cascade_delete=True)


# Properties to return via API, id is always required
class UserPublic(UserBase):
    id: uuid.UUID
    created_at: datetime | None = None


class UsersPublic(SQLModel):
    data: list[UserPublic]
    count: int


# Shared properties
class ItemBase(SQLModel):
    title: str = Field(min_length=1, max_length=255)
    description: str | None = Field(default=None, max_length=255)


# Properties to receive on item creation
class ItemCreate(ItemBase):
    pass


# Properties to receive on item update
class ItemUpdate(ItemBase):
    title: str | None = Field(default=None, min_length=1, max_length=255)  # type: ignore


# Database model, database table inferred from class name
class Item(ItemBase, table=True):
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    created_at: datetime | None = Field(
        default_factory=get_datetime_utc,
        sa_type=DateTime(timezone=True),  # type: ignore
    )
    owner_id: uuid.UUID = Field(
        foreign_key="user.id", nullable=False, ondelete="CASCADE"
    )
    owner: User | None = Relationship(back_populates="items")


# Properties to return via API, id is always required
class ItemPublic(ItemBase):
    id: uuid.UUID
    owner_id: uuid.UUID
    created_at: datetime | None = None


class ItemsPublic(SQLModel):
    data: list[ItemPublic]
    count: int


# Generic message
class Message(SQLModel):
    message: str


# JSON payload containing access token
class Token(SQLModel):
    access_token: str
    token_type: str = "bearer"


# Contents of JWT token
class TokenPayload(SQLModel):
    sub: str | None = None


class NewPassword(SQLModel):
    token: str
    new_password: str = Field(min_length=8, max_length=128)
```
这个类的划分看上去就很nb,没有真实开发经验的我根本不会这么划分.

- utils.py涉及主要是邮件发送相关的工具函数,暂时放一放

## Look into core(2/6)
### config.py
```python
import secrets
import warnings
from typing import Annotated, Any, Literal

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
from typing_extensions import Self


def parse_cors(v: Any) -> list[str] | str:
    if isinstance(v, str) and not v.startswith("["):
        return [i.strip() for i in v.split(",") if i.strip()]
    elif isinstance(v, list | str):
        return v
    raise ValueError(v)


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


settings = Settings()  # type: ignore
```
#### BASESETTINGS AND ENV FILE
```python
from pydantic_settings import BaseSettings, SettingsConfigDict
# ...
class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        # Use top level .env file (one level above ./backend/)
        env_file="../.env",
        env_ignore_empty=True,
        extra="ignore",
    )
# ...
```
- BaseSettings: 继承自Basemodel,可以读取外部配文件
- SettingsConfigDict
  - env_fie: 要读取的外部配置文件
  - env_ignore_empty: `API_V1_STR:    `这样的空字符变量不读取
  - extra: 'ignore'忽略配置文件中未在BaseSettings类中实例化的字符变量
  
--- 
#### SQLALCHEMY_DATABASE_URI()
```python
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
- `@computed_field`: 表示这个方法在将其他字段全都读取完之后才能进行构造

- `@property`: 让这个无参方法看上去与一个普通变量一样,可以直接写`settings.SQLALCHEMY_DATABASE_URI`而不是写`settings.SQLALCHEMY_DATABASE_URI()`
- `PostgresDsn`,拼接后得到下列字符串:
  - `postgresql+psycopg://user:password@host:port/dbname`

  - 小疑问:为什么`PostgresDsn`既是类型又是对象?
    - 因为python中的类型也是对象
明白了这几个关键字其他的也不怎么需要看了,整个文件都是环境变量的配置而已,然后`settings = Settings() `将这个类实例化并在其他文件中调用
### db.py与security.py

>一个是初始化管理员账户,另一个是设置几个密码工具,没什么可分析的

## Look into app(2/7)
### deps.py
```python
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


def get_db() -> Generator[Session, None, None]:
    with Session(engine) as session:
        yield session


SessionDep = Annotated[Session, Depends(get_db)]
TokenDep = Annotated[str, Depends(reusable_oauth2)]


def get_current_user(session: SessionDep, token: TokenDep) -> User:
    try:
        payload = jwt.decode(
            token, settings.SECRET_KEY, algorithms=[security.ALGORITHM]
        )
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
#### [What is yield](https://www.runoob.com/w3cnote/python-yield-used-analysis.html)
>这个解析非常深入浅出,yield将函数变成一个一次执行一步的iterator,从而保证不会一次执行太多步导致内存出问题
##### What is iterator
>[iterator](https://docs.python.org/3/glossary.html#term-iterator)
An object representing a stream of data. Repeated calls to the iterator’s __next__() method (or passing it to the built-in function next()) return successive items in the stream. When no more data are available a StopIteration exception is raised instead. At this point, the iterator object is exhausted and any further calls to its __next__() method just raise StopIteration again.
#### What is Generator
```python
def get_db() -> Generator[Session, None, None]:
    with Session(engine) as session:
        yield session
```
>[官方文档](https://docs.python.org/3/library/collections.abc.html#collections.abc.Generator)介绍如下:
>class collections.abc.Generator
ABC for generator classes that implement the protocol defined in PEP 342 that extends iterators with the send(), throw() and close() methods.

>A generator can be annotated using the generic type Generator[YieldType, SendType, ReturnType].
The SendType and ReturnType parameters default to None:
```python
def infinite_stream(start: int) -> Generator[int]:
    while True:
        yield start
        start += 1
```
>It is also possible to set these types explicitly:
```python
def infinite_stream(start: int) -> Generator[int, None, None]:
    while True:
        yield start
        start += 1
```

所以模板项目中这一段代码只是在表示这个函数返回的是一个iterator对象而已😅

## Look into routes in app(2/7)
### items.py

```python
import uuid
from typing import Any

from fastapi import APIRouter, HTTPException
from sqlmodel import func, select

from app.api.deps import CurrentUser, SessionDep
from app.models import Item, ItemCreate, ItemPublic, ItemsPublic, ItemUpdate, Message

router = APIRouter(prefix="/items", tags=["items"])


@router.get("/", response_model=ItemsPublic)
def read_items(
    session: SessionDep, current_user: CurrentUser, skip: int = 0, limit: int = 100
) -> Any:
    """
    Retrieve items.
    """

    if current_user.is_superuser:
        count_statement = select(func.count()).select_from(Item)
        count = session.exec(count_statement).one()
        statement = (
            select(Item).order_by(Item.created_at.desc()).offset(skip).limit(limit)
        )
        items = session.exec(statement).all()
    else:
        count_statement = (
            select(func.count())
            .select_from(Item)
            .where(Item.owner_id == current_user.id)
        )
        count = session.exec(count_statement).one()
        statement = (
            select(Item)
            .where(Item.owner_id == current_user.id)
            .order_by(Item.created_at.desc())
            .offset(skip)
            .limit(limit)
        )
        items = session.exec(statement).all()

    return ItemsPublic(data=items, count=count)


@router.get("/{id}", response_model=ItemPublic)
def read_item(session: SessionDep, current_user: CurrentUser, id: uuid.UUID) -> Any:
    """
    Get item by ID.
    """
    item = session.get(Item, id)
    if not item:
        raise HTTPException(status_code=404, detail="Item not found")
    if not current_user.is_superuser and (item.owner_id != current_user.id):
        raise HTTPException(status_code=403, detail="Not enough permissions")
    return item


@router.post("/", response_model=ItemPublic)
def create_item(
    *, session: SessionDep, current_user: CurrentUser, item_in: ItemCreate
) -> Any:
    """
    Create new item.
    """
    item = Item.model_validate(item_in, update={"owner_id": current_user.id})
    session.add(item)
    session.commit()
    session.refresh(item)
    return item


@router.put("/{id}", response_model=ItemPublic)
def update_item(
    *,
    session: SessionDep,
    current_user: CurrentUser,
    id: uuid.UUID,
    item_in: ItemUpdate,
) -> Any:
    """
    Update an item.
    """
    item = session.get(Item, id)
    if not item:
        raise HTTPException(status_code=404, detail="Item not found")
    if not current_user.is_superuser and (item.owner_id != current_user.id):
        raise HTTPException(status_code=403, detail="Not enough permissions")
    update_dict = item_in.model_dump(exclude_unset=True)
    item.sqlmodel_update(update_dict)
    session.add(item)
    session.commit()
    session.refresh(item)
    return item


@router.delete("/{id}")
def delete_item(
    session: SessionDep, current_user: CurrentUser, id: uuid.UUID
) -> Message:
    """
    Delete an item.
    """
    item = session.get(Item, id)
    if not item:
        raise HTTPException(status_code=404, detail="Item not found")
    if not current_user.is_superuser and (item.owner_id != current_user.id):
        raise HTTPException(status_code=403, detail="Not enough permissions")
    session.delete(item)
    session.commit()
    return Message(message="Item deleted successfully")
```
>处理"get /items","get /items/{id}","put /items/{id}","delete /items/{id}"四种请求

- 其余几个文件简单说一下,就不贴代码了
  
**login.py**
处理以下请求
- "post /login/access-token"
- "post /login/test-token"
- "post /password-recovery/{email}"
- "post /reset-password/"
- "post /password-recovery-html-content/{email}"

**private.py**
处理以下请求
- "post /private/users/"

**users.py**
处理以下请求
- "get /users/"
- "post /users/"
- "patch /users/me"
- "patch /users/me/password"
- "get /users/me"
- "delete /users/me"
- "post /users/signup"
- "get /users/{user_id}"
- "patch /users/{user_id}"
- "delete /users/{user_id}"

这些都是很正常,很简单的请求,看来一个普通的模板项目就够眼花缭乱了,不敢想象真正做一个app要处理多少东西.

## Conclusion

现在基本是把整个后端看了一遍,第一感觉就是,fastapi实际上并不是一个框架,我
一开始的幻想是只要把fastapi里的各种库丢进去就可以做出来一个完整后端了,但实际上远远不是这样,fastapi只能够进行数据处理,网络请求,异常处理,数据构建要依靠pydantic或者sqlmodel,类型注释要依靠typing和pydantic,安全工具要使用jwt和pwdlib,错误检测要使用sentry_sdk,中间件构建要使用starlette,这样看来,fastapi也仅仅是一个库而已,真正用起来只是作为一个插件,而非万能框架.