---
title: 终端常用命令一览
tags:
  - 合集
categories:
  - 动态更新
date: 2026-04-08 08:00:00
image: 95539505_p0-無題.webp
---

本文主要聚焦于Windows系统,尽管有不少命令是和Linux通用的

# 网络连接
## ping
- 系统自带组件,基于ICMP实现的网络状态查询工具,换句话说,ping借助TCP/IP协议实现对网络状态的简单解析
```bash
用法: ping [-t] [-a] [-n count] [-l size] [-f] [-i TTL] [-v TOS]
            [-r count] [-s count] [[-j host-list] | [-k host-list]]
            [-w timeout] [-R] [-S srcaddr] [-c compartment] [-p]
            [-4] [-6] target_name

选项:
    -t             Ping 指定的主机，直到停止。
                   若要查看统计信息并继续操作，请键入 Ctrl+Break；
                   若要停止，请键入 Ctrl+C。
    -a             将地址解析为主机名。
    -n count       要发送的回显请求数。
    -l size        发送缓冲区大小。
    -f             在数据包中设置“不分段”标记(仅适用于 IPv4)。
    -i TTL         生存时间。
    -v TOS         服务类型(仅适用于 IPv4。该设置已被弃用，
                   对 IP 标头中的服务类型字段没有任何
                   影响)。
    -r count       记录计数跃点的路由(仅适用于 IPv4)。
    -s count       计数跃点的时间戳(仅适用于 IPv4)。
    -j host-list   与主机列表一起使用的松散源路由(仅适用于 IPv4)。
    -k host-list    与主机列表一起使用的严格源路由(仅适用于 IPv4)。
    -w timeout     等待每次回复的超时时间(毫秒)。
    -R             同样使用路由标头测试反向路由(仅适用于 IPv6)。
                   根据 RFC 5095，已弃用此路由标头。
                   如果使用此标头，某些系统可能丢弃
                   回显请求。
    -S srcaddr     要使用的源地址。
    -c compartment 路由隔离舱标识符。
    -p             Ping Hyper-V 网络虚拟化提供程序地址。
    -4             强制使用 IPv4。
    -6             强制使用 IPv6。
```

**用例**
```bash
ping google.com
# 判断VPN是否有效的最快方法
```

## curl
- [wiki](https://en.wikipedia.org/wiki/CURL)
curl,意为"Client for URLs",是ping的上位替代,可以对指定网页采用多种方式进行查询,支持几乎所有的主流通信协议.由于是开源项目,几乎所有的操作系统都会预先安装.

**常用参数一览**
### curl 常用参数速查表

| 参数         | 全称            | 功能描述                                                            | 典型示例                                 |
| :----------- | :-------------- | :------------------------------------------------------------------ | :--------------------------------------- |
| **`-I`**     | `--head`        | **仅获取响应头**。常用于检查服务器状态、文件大小或链接有效性。      | `curl -I https://google.com`             |
| **`-v`**     | `--verbose`     | **调试模式**。显示详细的通信过程，包括请求头、响应头及 TLS 握手。   | `curl -v https://google.com`             |
| **`-X`**     | `--request`     | **指定请求方法**。默认为 GET，可手动指定 POST, PUT, DELETE 等。     | `curl -X POST https://api.com`           |
| **`-d`**     | `--data`        | **发送数据**。用于 POST 请求向服务器提交表单数据或 JSON。           | `curl -d "id=1" https://api.com`         |
| **`-H`**     | `--header`      | **设置请求头**。常用于定义 Content-Type 或传入 API Token。          | `curl -H "Auth: 123" https://api.com`    |
| **`-L`**     | `--location`    | **跟随重定向**。当页面发生 301/302 跳转时，自动追踪到目标页。       | `curl -L http://google.com`              |
| **`-o`**     | `--output`      | **保存为文件**。将下载内容写入指定路径，而非直接打印在终端。        | `curl -o test.html https://abc.com`      |
| **`-O`**     | `--remote-name` | **远程同名保存**。使用 URL 中的文件名作为本地文件名保存。           | `curl -O https://abc.com/v1.zip`         |
| **`-u`**     | `--user`        | **身份认证**。用于输入服务器的用户名和密码（Basic Auth）。          | `curl -u user:pass https://api.com`      |
| **`-k`**     | `--insecure`    | **忽略 SSL 校验**。访问证书过期或自签名的 HTTPS 站点时使用。        | `curl -k https://expired-site.com`       |
| **`-s`**     | `--silent`      | **静默模式**。不显示进度条或错误信息，常用于脚本自动化。            | `curl -s https://api.com`                |
| **`--json`** | `--json`        | **发送 JSON**（新版本）。自动设置 Content-Type 并以 POST 方式发送。 | `curl --json '{"id":1}' https://api.com` |

**用例**
```bash
curl google.com
# 不带任何参数的curl也能返回足够多的信息
StatusCode        : 200
StatusDescription : OK
Content           : (网页内容)
ParsedHtml        : mshtml.HTMLDocumentClass
RawContentLength  : 80569
```

## route
- [wiki](https://en.wikipedia.org/wiki/Route_(command))
用于查看和修改本电脑的IP路由表, 一般用不上
## ipconfig
- [wiki](https://en.wikipedia.org/wiki/Ipconfig)

>[微软官网介绍](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/ipconfig)
Displays **all current TCP/IP network configuration values** and refreshes Dynamic Host Configuration Protocol (DHCP) and Domain Name System (DNS) settings. Used without parameters, ipconfig displays Internet Protocol version 4 (IPv4) and IPv6 addresses, subnet mask, and default gateway for all adapters.

- 即ipconfig用于查看自己电脑的TCP/IP网络配置
## nslookup
- [wiki](https://en.wikipedia.org/wiki/Nslookup)
nslookup(Name System Lookup)用于查询DNS记录,检查DNS服务器是否正常
## ssh
>[wiki](https://en.wikipedia.org/wiki/Secure_Shell)
SSH(Secure Shell)协议是一种加密网络协议，用于在不安全的网络上安全地运行网络服务.通常用于登录远程计算机的shell或命令行界面(CLI)，并在远程服务器上执行命令.

### 基础操作
```bash
ssh root@100.80.251.1
# 输入密码
# 在远程服务器中进行操作
```

### 进阶操作(待补充)

## wget
- [wiki](https://en.wikipedia.org/wiki/Wget)

>GNU Wget (or just Wget, formerly Geturl, also written as its package name, wget) is a computer program that retrieves content from web servers. It is part of the GNU Project. Its name derives from "World Wide Web" and "get", a HTTP request method. It supports **downloading via HTTP, HTTPS, and FTP**.

如上文所说,wget是一个用来下载网络资源的工具,尽管最初在Linux中使用,但Windows Powershell会通过管道运算符复现对应的功能.
- 大多数场景下curl可以直接代替wget,因此wget的出现频率正不断下降

**使用示例**
```bash
PS C:\Users\user> wget www.baidu.com

StatusCode        : 200
StatusDescription : OK
Content           : <!DOCTYPE html><!--STATUS OK--><html><head><meta http-equiv="Content-Type" content="text/html;chars
                    et=utf-8"><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><meta content="origin-when-
                    cr...
RawContent        : HTTP/1.1 200 OK
                    Bdpagetype: 1
                    Bdqid: 0x926a898e00009a46
                    Connection: keep-alive
                    Content-Length: 632441
                    Content-Type: text/html; charset=utf-8
                    Date: Wed, 08 Apr 2026 10:24:26 GMT
                    P3P: CP=" OTI DS...
Forms             : {form}
Headers           : {[Bdpagetype, 1], [Bdqid, 0x926a898e00009a46], [Connection, keep-alive], [Content-Length, 632441]..
                    .}
Images            : {@{innerHTML=; innerText=; outerHTML=<img src="https://pss.bdstatic.com/static/superman/img/topnav/
                    newfanyi-da0cea8f7e.png">; outerText=; tagName=IMG; src=https://pss.bdstatic.com/static/superman/im
                    g/topnav/newfanyi-da0cea8f7e.png}, @{innerHTML=; innerText=; outerHTML=<img src="https://pss.bdstat
                    ic.com/static/superman/img/topnav/newxueshuicon-a5314d5c83.png">; outerText=; tagName=IMG; src=http
                    s://pss.bdstatic.com/static/superman/img/topnav/newxueshuicon-a5314d5c83.png}, @{innerHTML=; innerT
                    ext=; outerHTML=<img src="https://pss.bdstatic.com/static/superman/img/topnav/newbaike-889054f349.p
                    ng">; outerText=; tagName=IMG; src=https://pss.bdstatic.com/static/superman/img/topnav/newbaike-889
                    054f349.png}, @{innerHTML=; innerText=; outerHTML=<img src="https://pss.bdstatic.com/static/superma
                    n/img/topnav/newzhidao-da1cf444b0.png">; outerText=; tagName=IMG; src=https://pss.bdstatic.com/stat
                    ic/superman/img/topnav/newzhidao-da1cf444b0.png}...}
InputFields       : {@{innerHTML=; innerText=; outerHTML=<input name="ie" type="hidden" value="utf-8">; outerText=; tag
                    Name=INPUT; name=ie; type=hidden; value=utf-8}, @{innerHTML=; innerText=; outerHTML=<input name="f"
                     type="hidden" value="8">; outerText=; tagName=INPUT; name=f; type=hidden; value=8}, @{innerHTML=;
                    innerText=; outerHTML=<input name="rsv_bp" type="hidden" value="1">; outerText=; tagName=INPUT; nam
                    e=rsv_bp; type=hidden; value=1}, @{innerHTML=; innerText=; outerHTML=<input name="rsv_idx" type="hi
                    dden" value="1">; outerText=; tagName=INPUT; name=rsv_idx; type=hidden; value=1}...}
Links             : {@{innerHTML=百度首页; innerText=百度首页; outerHTML=<a class="toindex" href="/">百度首页</a>; oute
                    rText=百度首页; tagName=A; class=toindex; href=/}, @{innerHTML=设置<i class="c-icon c-icon-triangle
                    -down"></i>; innerText=设置; outerHTML=<a name="tj_settingicon" class="pf" href="javascript:;">设置
                    <i class="c-icon c-icon-triangle-down"></i></a>; outerText=设置; tagName=A; name=tj_settingicon; cl
                    ass=pf; href=javascript:;}, @{innerHTML=登录; innerText=登录; outerHTML=<a name="tj_login" class="l
                    b" onclick="return false;" href="https://passport.baidu.com/v2/?login&amp;tpl=mn&amp;u=http%3A%2F%2
                    Fwww.baidu.com%2F&amp;sms=5">登录</a>; outerText=登录; tagName=A; name=tj_login; class=lb; onclick=
                    return false;; href=https://passport.baidu.com/v2/?login&amp;tpl=mn&amp;u=http%3A%2F%2Fwww.baidu.co
                    m%2F&amp;sms=5}, @{innerHTML=

                                                新闻

                                        ; innerText= 新闻 ; outerHTML=<a class="mnav c-font-normal c-color-t" href="htt
                    p://news.baidu.com" target="_blank">

                                                新闻

                                        </a>; outerText= 新闻 ; tagName=A; class=mnav c-font-normal c-color-t; href=htt
                    p://news.baidu.com; target=_blank}...}
ParsedHtml        : mshtml.HTMLDocumentClass
RawContentLength  : 632441
```
- 从返回内容也能看出来基础功能与curl没什么区别


# 包管理器
## Scoop(推荐)
- [官网](https://scoop.sh/)

官网的介绍很简单,只有一行:
>A command-line installer for Windows

由于微软自己开发了Winget包管理器,故不会预先安装Scoop,需要我们用脚本激活:
```bash
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

在终端输入scoop即可查询使用方式:
```bash
PS C:\Users\user> scoop
Usage: scoop <command> [<args>]

Available commands are listed below.

Type 'scoop help <command>' to get more help for a specific command.

Command    Summary
-------    -------
alias      Manage scoop aliases
bucket     Manage Scoop buckets
cache      Show or clear the download cache
cat        Show content of specified manifest.
checkup    Check for potential problems
cleanup    Cleanup apps by removing old versions
config     Get or set configuration values
create     Create a custom app manifest
depends    List dependencies for an app, in the order they'll be installed
download   Download apps in the cache folder and verify hashes
export     Exports installed apps, buckets (and optionally configs) in JSON format
help       Show help for a command
hold       Hold an app to disable updates
home       Opens the app homepage
import     Imports apps, buckets and configs from a Scoopfile in JSON format
info       Display information about an app
install    Install apps
list       List installed apps
prefix     Returns the path to the specified app
reset      Reset an app to resolve conflicts
search     Search available apps
shim       Manipulate Scoop shims
status     Show status and check for new app versions
unhold     Unhold an app to enable updates
uninstall  Uninstall an app
update     Update apps, or Scoop itself
virustotal Look for app's hash or url on virustotal.com
which      Locate a shim/executable (similar to 'which' on Linux)
```

scoop解决了应用安装路径不统一的问题,将安装的应用一律放到scoop文件夹中,而且用户可以自己指定默认安装位置.

尽管大多数应用都可以很方便的使用scoop找到,但对于已经习惯了普通安装方式的我来说还是用的不太顺手.
## Winget(不推荐)
>[官方说明](https://learn.microsoft.com/zh-cn/windows/package-manager/winget/)
WinGet 是一种命令行工具，使用户能够在 Windows 10、Windows 11 和 Windows Server 2025 计算机上发现、安装、升级、删除和配置应用程序

具体用法只需要在终端输入winget即可了解:
```bash
PS C:\Users\user> winget

WinGet 命令行实用工具可从命令行安装应用程序和其他程序包。

使用情况: winget  [<命令>] [<选项>]

下列命令有效:
  install    安装给定的程序包
  show       显示包的相关信息
  source     管理程序包的来源
  search     查找并显示程序包的基本信息
  list       显示已安装的程序包
  upgrade    显示并执行可用升级
  uninstall  卸载给定的程序包
  hash       哈希安装程序的帮助程序
  validate   验证清单文件
  settings   打开设置或设置管理员设置
  features   显示实验性功能的状态
  export     导出已安装程序包的列表
  import     安装文件中的所有程序包
  pin        管理包钉
  configure  将系统配置为所需状态
  download   从给定的程序包下载安装程序
  repair     修复所选包
  dscv3      DSC v3 资源命令
  mcp        MCP 信息
```


1. 要搜索某个工具，请键入 winget search <appname>
2. 确认你需要的工具可用后，可以通过键入 来winget install <appname>该工具。 WinGet 工具会启动安装程序，将应用程序安装在你的电脑上

**使用举例**
```bash
PS C:\Users\uesr> winget search npm
名称            ID              版本          匹配             源
---------------------------------------------------------------------
Node.js         OpenJS.NodeJS   25.9.0        Command: npm     winget
Node.js 10      OpenJS.NodeJS.… 10.24.1       Command: npm     winget
Node.js 12      OpenJS.NodeJS.… 12.22.12      Command: npm     winget
Node.js 14      OpenJS.NodeJS.… 14.21.3       Command: npm     winget
# 一大堆类似的包

PS C:\Users\user> winget install bun
找到多个与输入条件匹配的程序包。请修改输入。
名称             ID           源
-------------------------------------
Bundle Generator 9NBLGGH43PMQ msstore
Bun              Oven-sh.Bun  winget
# 由于我这里已经安装了,所以就会报错
```

winget默认全局安装,如果不操心应用安装位置的话,使用winget比上官网找资源是要快一点的;但捣鼓计算机的一般都很在意应用的安装位置,所以winget基本就没什么用了...


# 基本操作
# 部署
**博客命令**
## hexo
```bash
hexo new post/draft/page # 使用模板
hexo publish draft 文章名
hexo d          # push my blog  deploy
hexo new  +name     # new blog
hexo g            # apply changes  generate
hexo s            # local static html 预览
hexo g -d   # 一次完成
```
>draft也就是草稿，在使用hexo创建文章时，可以先指定为草稿:
```bash
hexo new draft <title>
```

>完成之后，使用publish命令将draft转移到post下:
```bash
hexo publish <title>
```



# --version
尽管很多工具都支持**工具名 --version**的方式查询版本,但遗憾的是有一些工具**不愿意**沿用这个惯例,所以只好单独在这里分类讨论了

- 事实上,尽管大多数工具都统一使用--参数的形式,但也有不少工具使用-参数的形式,真的就没人想过统一一下吗...
### 构建工具
- gcc/g++
- make
- tar
- git
- cmake
- git
- docker
- curl

### 编程
- python
- node
- npm
- ruby
- java: 使用`java -version`也可以

### 不支持的
- go: `go version`,何必少写那两横呢




