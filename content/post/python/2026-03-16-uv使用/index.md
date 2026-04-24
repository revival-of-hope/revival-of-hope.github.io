---
title: 2026-03-16 uv使用
tags:
  - python
date: 2026-03-16 08:00:00
image: 12904418_p0-夏の日の昼下がり.webp
---



## 管理python版本
>如果系统上已经安装了 Python，uv 将无需配置即可检测并使用它。但是，uv 也可以安装和管理 Python 版本。uv 会根据需要自动安装缺失的 Python 版本——你无需为了开始使用而预先安装 Python。

- `uv python install`：安装最新 Python 版本。
  - eg: `uv python install 3.12 `
- `uv python list`：查看可用的 Python 版本。

但是:
>当 uv 安装 Python 后，它不会在全局范围内可用（即通过 python 命令）。 此功能的支持尚处于_预览_阶段
你仍然可以使用uv run 或 创建并激活虚拟环境来直接使用 python。

## 运行python脚本
如果脚本没有依赖模块或者依赖标准库中的模块,可以直接使用 uv run 来执行它,例如:`uv run example.py`.

uv可以使用特定的python版本运行脚本
```bash
$ # 使用特定的 Python 版本
$ uv run --python 3.10 example.py
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
├── .python-version
├── README.md
├── main.py
├── pyproject.toml
└── uv.lock
```

- 直接震惊了好吧,终于不用输入`python -m venv venv`这种东西了

**pyproject.toml**
```toml
[project]
name = "uv"
version = "0.1.0"
description = "Add your description here"
readme = "README.md"
requires-python = ">=3.13"
dependencies = []

```

**.python-version**
.python-version 文件包含项目的Python 版本。此文件告诉 uv 在创建项目的虚拟环境时使用哪个 Python 版本。

>我相信应该不只有我一个人好奇:就这一条信息为什么不合并到toml文件中呢?
经过[浏览](https://github.com/astral-sh/uv/issues/8247)我推测: requires-python配置项要求了在特定python版本下才能运行项目,如果把当前使用的不合规python版本写入toml,那么uv编译的时候要听谁的呢?
因此,单独分出这一个文件既是为了保证python版本管理的方便,也为了防止错误的python版本被用来执行.

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

当接手一个使用了uv的项目时,建议先运行uv sync命令以创建虚拟环境并下载库进行同步,尽管使用uv run **随便一个python文件** 会默认使用uv sync,但就不够优雅了.
### 构建分发包
```bash
$ uv build
$ ls dist/
hello-world-0.1.0-py3-none-any.whl
hello-world-0.1.0.tar.gz
```

## TL;DR
如果是自己新建python项目,则运行:
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
requires-python = ">=3.14"
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
requires-python = ">=3.13"
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
