---
title: "计算机网络笔记"
date: 2026-07-29T12:41:07+08:00
description: 
image: 69045738_p0-….webp
math: 
draft: true
---
## gRPC与Rest
- [参考文章](https://info.support.huawei.com/info-finder/encyclopedia/zh/gRPC.html)
- [wiki](https://en.wikipedia.org/wiki/GRPC)

## GraphQL
## 加密链接
- Across the Great Wall we can reach every corner in the world.

看了[这篇文章](https://blog.ch3nyang.top/post/%E7%BF%BB%E5%A2%99%E5%8D%8F%E8%AE%AE/)后,我对加密链接有了浓厚的兴趣,先将该文涉及的加密工具按时间线摆出来:
1. 2012年: Shadowsocks
2. 2015年: ShadowsocksR (SSR)
3. 2015年: VMess
4. 2019年: Trojan
5. 2020年: VLESS/Xray
6. 2022年: Hysteria
7. 2022年: REALITY

而常见的加密客户端有以下几种:
1. V2Ray/Xray
2. sing-box
3. clash

接下来,让我们深入探讨一下加密链接的方方面面
### 加密链接的原理
#### 为什么会被拦截
在谈加密协议之前,我们需要先了解为什么请求会被拦截:

1. 当你访问互联网时,并不存在真正的无线通信.如果你使用校园网,那么就需要使用学校的无线接入点,这个无线接入点通过链路与路由器连接,路由器与学校的交换机连接,交换机再与ISP(服务商)的链路连接,再通过外网关口连接到全球的互联网;如果是使用移动数据,那么就需要使用ISP的基站,这个基站通过链路与ISP的核心网络连接,再连接到互联网.
2. 那么,当你访问一个国外网站,比如Google.com时,你的流量就势必要经过内地的网关,而由于没经过加密处理的http请求可以直接被网关探测到,当他判断这个站点"非法"时可以**直接**拒绝转发,返回请求失败的报文.

>事实上,上述的**网关探测**用词是不准确的,当网关处理网络请求时,它必须要解包后得知这个请求的目的IP,才能知道要把这个请求发向哪个国家.至于发现这个目的IP"非法"只不过是顺带的事.

#### 加密方法
网络协议栈可分为自上而下的5层: **应用层,运输层,网络层,链路层和物理层**.加密链接一般只能对上三层做手脚:

1. 应用层: **进一步加密报文**,保证报文只能被中转服务器识别
2. 运输层: **使用UDP包装TCP请求**
3. 网络层: 使用境外的中转服务器,从而将目的IP替换成"合法IP"

总结一下就是说:
1. 为了不让自己的IP请求被直接截取,加密链接需要将原TCP请求报文再封装一次,由于TCP本身就具有重传机制,如果再用TCP封装,就会导致大量的无意义重传,所以我们使用UDP来封装.
2. 由于网关可以直接探测到我们的封装UDP包内部的TCP报文,我们需要对该TCP报文进行加密处理,伪装成正常的网络请求
3. 既然进行了加密处理,直接发给国外网站服务器的话,它是无法正常识别的,因此,我们需要建立境外中转站,将流量发送给境外中转站,**让它帮我们解密报文后再发给目标网站**.这样一来,我们就需要在IP包中将该UDP包中的目的IP替换成中转站的IP.



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

