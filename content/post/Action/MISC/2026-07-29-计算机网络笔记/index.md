---
title: "计算机网络笔记"
date: 2026-07-29T12:41:07+08:00
description: 
image: 69045738_p0-….webp
math: 
draft: true
---
## 通信规范:从Rest到gRPC
### 早期RPC框架
### Rest的诞生与风行
### gRPC横空出世
- [参考文章](https://info.support.huawei.com/info-finder/encyclopedia/zh/gRPC.html)
- [wiki](https://en.wikipedia.org/wiki/GRPC)
### GraphQL的插曲

## 加密链接
### 前言
>[!CAUTION]
Across the Great Wall we can reach every corner in the world.

看了[这篇文章](https://blog.ch3nyang.top/post/%E7%BF%BB%E5%A2%99%E5%8D%8F%E8%AE%AE/)后,我对加密链接有了浓厚的兴趣,先将该文涉及的加密协议及平台按时间线摆出来:

1. [Shadowsocks](https://github.com/shadowsocks/shadowsocks-rust)（2012年）

   1. Shadowsocks 最初由 clowwindy 开发，是一种轻量级加密代理协议。其早期 Python 实现已经停止维护，目前 Shadowsocks 官方组织中较活跃的实现是 **shadowsocks-rust**，使用 Rust 编写，同时支持客户端和服务端。

2. [ShadowsocksR（SSR）](https://github.com/shadowsocksrr/shadowsocksr)（2015年）

   1. ShadowsocksR 是在 Shadowsocks 基础上发展出的分支，增加了额外的协议和混淆机制。原始 SSR 项目已经停止维护，目前能够找到的 `shadowsocksrr/shadowsocksr` 属于后续社区维护版本，因此严格来说不能视为原作者仍在维护的“官方仓库”。

3. [VMess / V2Ray](https://github.com/v2fly/v2ray-core)（2015年）

   1. VMess 是 V2Ray 体系早期的核心代理协议之一，而 **V2Ray** 本身是支持多种入站、出站协议和传输方式的代理平台。现在主要由 V2Fly 社区维护 `v2ray-core`。

4. [Trojan](https://github.com/trojan-gfw/trojan)（2019年）

   1. Trojan 的主要设计思路是让代理通信建立在 TLS 之上，使网络流量在外观上更接近普通 TLS 通信。

5. [VLESS / Xray](https://github.com/XTLS/Xray-core)（2020年）

   1. VLESS 是 Xray/V2Ray 生态中使用的轻量级代理协议，本身不负责像传统 Shadowsocks 那样在协议内部设计一套数据加密，而通常与 TLS、XTLS、REALITY 等安全传输机制组合使用。**Xray-core** 是目前 VLESS 最主要的实现之一，同时支持 VMess、Trojan、Shadowsocks、VLESS 等多种协议。

6. [Hysteria](https://github.com/apernet/hysteria)（2022年，Hysteria 2 后续继续发展）

   1. Hysteria 是基于 QUIC 思路构建的代理协议和实现，重点针对高延迟、高丢包等质量较差的网络环境。当前主要使用 **Hysteria 2**，项目同时支持 SOCKS5、HTTP Proxy、TCP/UDP 转发和 TUN 等工作模式。

7. [REALITY / Xray](https://github.com/XTLS/Xray-core)（2022年）

   1. REALITY 并不是一个与 VMess、VLESS 完全同层级的独立代理协议，而是 **Xray/XTLS 体系中的安全传输机制**，通常与 VLESS 等协议搭配使用。其主要实现位于 Xray-core 中，因此并不存在一个需要单独安装的“REALITY客户端”。

8. [mieru](https://github.com/enfein/mieru)（原文没有,2025年诞生）

   1. 支持 TCP 和 UDP，不依赖 TLS，而是采用自身的加密、随机 padding、重放检测等设计。到 2026 年仍持续发布 3.x 版本，并已经得到 Mihomo 等第三方客户端支持

客户端平台则主要有以下几种：

1. [V2Ray](https://github.com/v2fly/v2ray-core) / [Xray](https://github.com/XTLS/Xray-core)

   1. V2Ray 是较早的通用代理平台，支持 VMess、Shadowsocks、SOCKS、HTTP 等协议；Xray 最初从 V2Ray 生态发展而来，目前增加并重点维护了 **VLESS、XTLS、REALITY、XHTTP** 等技术。两者都是“核心程序”，Windows、Android 等平台上的图形客户端通常是在这些核心之上再提供 GUI。

2. [sing-box](https://github.com/SagerNet/sing-box)

   1. sing-box 是 SagerNet 开发的现代通用代理平台，使用 Go 编写，目标是通过一个核心统一支持多种代理、VPN和隧道协议。它拥有 Android、Apple 系统以及桌面端的相关官方客户端项目，同时能够作为服务器端程序使用。

3. [Mihomo（原 Clash.Meta）](https://github.com/MetaCubeX/mihomo)

   1. 原版 **Clash** 已经停止维护，它继承了 Clash 的基于规则进行流量分流的设计，并扩充了 VLESS、VMess、Trojan、Hysteria、WireGuard 等大量协议支持。Mihomo 本身主要是核心程序，上层可以搭配不同的图形界面使用。


### Shadowsocks


## 网盘与磁力链接
## 镜像站点
我经常能看到一些镜像源,镜像站,但从没有详细的了解它的具体原理.

- [wiki](https://en.wikipedia.org/wiki/Mirror_site)

一般来说,镜像站都是因为特殊原因诞生的,比如大名鼎鼎的清华镜像源,里面存有几乎所有常用的国外开源软件镜像.

镜像站一般有三种方法:
1. 第三方维护的镜像,定期从主站点爬取资源和网页,这是最常见的一种方法
2. 反向代理型的镜像,在用户访问时,转而向原网站请求内容,由于经过了一次甚至多次跳转,可想而知非常慢
3. 原网站负责人自己部署的镜像,将所有内容复制到多个不同域名的服务器上,这与只缓存视频/图像等部分资源的CDN不同.


## 反向代理(待补充)
### 前置知识
- 早期的文章,日后可能会重构
#### domain name(域名)
- [wiki](https://en.wikipedia.org/wiki/Domain_name)
>domain name identifies a **network domain** or an **Internet Protocol** (IP) resource, such as a **personal computer** used to access the Internet, or a server computer.
- 也就是说domain name是用来标识电脑和服务器的.

A **fully qualified domain name** (FQDN) is a domain name that is completely specified with all labels in the hierarchy of the DNS, having no parts omitted.
- 比如`en.wikipedia.org`就由被两个点分开的三个部分组成,每一部分都是一个域名.

#### hostname(主机名)
- [wiki](https://en.wikipedia.org/wiki/Hostname)
>On the Internet, a hostname is a **domain name** assigned to a host computer. This is usually a **combination** of the host's local name with its parent domain's name. For example, `en.wikipedia.org` consists of a local hostname (en) and the domain name wikipedia.org. **This kind of hostname is translated into an IP address via the local hosts file, or the DNS resolver**. It is possible for a single host computer to have several hostnames, but generally, the operating system of the host prefers to have **one hostname** that the host uses for itself.

也就是说,`en.wikipedia.org`就是一个主机名,跟DNS紧密关联;而个人电脑也具有主机名,在cmd中输入hostname即可查询自己电脑的主机名.默认输出为`My-com`.

当然主机名本身从来都不是一个必要的东西,你永远都可以直接通过IP地址来访问某个网站或者主机.
#### localhost
- [wiki](https://en.wikipedia.org/wiki/Localhost)
>In computer networking, localhost is a hostname that refers to the **current computer** used to access it. The name localhost is reserved for **loopback**(回环) purposes.It is used to access the network services that are running on the host via the loopback network interface. Using the loopback interface bypasses any local network interface hardware.

- localhost就是本机用来访问本地网址的域名
##### loopback
>The local **loopback** mechanism may be used to run a network service on a host without requiring a physical network interface, or without making the service accessible from the networks the computer may be connected to. For example, a locally installed website may be accessed from a Web browser by the URL http://localhost to display its home page.
- 所有操作系统都会预留一个将localhost这个域名映射到IPv4和IPv6地址的注册表
>IPv4 network standards reserve the entire address block 127.0.0.0/8 (**more than 16 million addresses**) for loopback purposes.That means any packet sent to any of those addresses is looped back. The address **127.0.0.1** is the **standard address** for IPv4 loopback traffic; the rest are not supported by all operating systems. However, they can be used to set up multiple server applications on the host, all listening on the same port number. In the IPv6 addressing architecture there is only a single address assigned for loopback: **::1**. The standard precludes the assignment of that address to any physical interface, as well as its use as the source or destination address in any packet sent to remote hosts.
- 由于IPv4的糟糕设计,超过1600万个IP地址被直接浪费了,所以IPv6只保留了一个回环地址**[::1]**.由于历史习惯问题,大多数教程和实践仍然使用`localhost`和`127.0.0.1`来进行回环访问,但三者都是等价的.
  - 在IPv6中`::`表示省略前面的所有0,换句话说IPv6的回环地址就是地址`1`(省略了127个0).

##### 实战
使用docker运行以下命令:
`docker run -d -p 8080:80 nginx:alpine`

![示意图](PixPin_2026-04-15_12-22-23.webp)
通过以下四(~~1600万~~)种方式都可以成功访问上图页面
1. `http://[::1]:8080/`: 少见
2. `http://localhost:8080/`: 最为常用
3. `http://127.0.0.1:8080/`: 第二常用
4. `http://127.1.0.2:8080/`: 罕见
#### port(端口)
- 如果我问上面的`:8080`是什么,大多数人都知道这是端口,但我自己并不很清楚它具体的实现原理.

>[wiki](https://en.wikipedia.org/wiki/Port_(computer_networking))
>
>In computer networking, a port is a **communication endpoint**. **At the software level** within an operating system, a port is a logical construct that i**dentifies a specific process or a type of network service**. A port is uniquely identified by a number, the port number, associated with the combination of a transport protocol and the network IP address. Port numbers are 16-bit unsigned integers.(最大为65535)


**常见的应用层协议端口**
| 端口号      | 服务/协议  | 完整名称                            | 主要用途                           |
| :---------- | :--------- | :---------------------------------- | :--------------------------------- |
| **22**      | **SSH**    | Secure Shell                        | 安全外壳协议，用于远程加密登录     |
| **23**      | **Telnet** | Telnet                              | 远程登录服务，采用明文传输         |
| **25**      | **SMTP**   | Simple Mail Transfer Protocol       | 简单邮件传输协议，用于邮件发送     |
| **53**      | **DNS**    | Domain Name System                  | 域名系统服务，将域名解析为 IP      |
| **67 / 68** | **DHCP**   | Dynamic Host Configuration Protocol | 动态主机配置协议，自动分配 IP 地址 |
| **80**      | **HTTP**   | Hypertext Transfer Protocol         | 超文本传输协议，万维网基础         |
| **443**     | **HTTPS**  | HTTP Secure (HTTP over TLS/SSL)     | 超文本传输安全协议，加密网页访问   |

#### Proxy
>[wiki](https://en.wikipedia.org/wiki/Proxy_server)
In computer networking, a proxy server is a server application that acts as an intermediary between a client requesting a resource and the server then providing that resource.
- 也就是说,proxy就是服务器和客户端之间的中间层了,双方的数据发送都可以经过代理来转发和储存

**正向代理(forward proxy)**
**forward proxy**: an **Internet-facing** proxy used to retrieve data from a wide range of sources (in most cases, anywhere on the Internet). 
**反向代理(reverse proxy)**
- **reverse proxy**: an **internal-facing** proxy used as a front-end to control and protect access to a server on a private network,also performs tasks such as **load-balancing**, **authentication**, **decryption**, and **caching**.

也就是说,正向代理是面向客户端的,反向代理是面向服务器的.

现在,我们可以开始正式学习nginx和traefik了.
## nginx

## traefik

