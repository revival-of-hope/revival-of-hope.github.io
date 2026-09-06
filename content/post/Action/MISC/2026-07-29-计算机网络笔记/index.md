---
title: "计算机网络笔记"
date: 2026-09-03T12:41:07+08:00
description: 先发出来吧,提醒自己更新
image: 69045738_p0-….webp
math: 
---
# 网络基础
## 计算机网络技术年表
|       年份 | 技术／标准                                                                                                           | 层级／主要领域           | 家族／演进方式                                                                                                           | 2026年状态                  |
| ---------: | -------------------------------------------------------------------------------------------------------------------- | ------------------------ | ------------------------------------------------------------------------------------------------------------------------ | --------------------------- |
|       1969 | [ARPANET](https://www.internetsociety.org/internet/history-internet/brief-history-internet/)                         | 分组交换实验网络         | 电路交换之外的分组交换路线；NCP网络最终迁移到TCP/IP                                                                      | △ 1990年停止运行            |
| 1971／1985 | [FTP](https://www.rfc-editor.org/info/rfc959/)                                                                       | 应用层、文件传输         | ARPANET文件传输协议→FTP；后来出现FTPS。SFTP实际属于SSH家族，并非FTP升级版                                                | ◐ 明文FTP逐渐淘汰           |
| 1973／1983 | [Ethernet／IEEE 802.3](https://standards.ieee.org/beyond-standards/the-evolution-of-wi-fi-technology-and-standards/) | 链路层、有线局域网       | ALOHAnet思想→Xerox Ethernet→DIX Ethernet→IEEE 802.3→百兆、千兆、万兆及更高速率                                           | 🔥 有线局域网基础            |
| 1974／1981 | [TCP](https://www.rfc-editor.org/info/rfc793/)                                                                       | 传输层、可靠字节流       | 早期TCP同时承担网络层和传输层职责→拆分为IP与TCP；旧RFC 793后来由[RFC 9293](https://www.rfc-editor.org/info/rfc9293/)更新 | 🔥 互联网核心                |
|       1979 | 1G模拟移动通信                                                                                                       | 蜂窝通信、无线接入       | 模拟语音蜂窝网络→数字化2G；不同地区包括AMPS、NMT、TACS等体系                                                             | △ 已基本退出                |
|       1980 | [UDP](https://www.rfc-editor.org/info/rfc768/)                                                                       | 传输层、无连接数据报     | 作为TCP的轻量替代；自身不保证可靠、顺序和拥塞控制；后来成为DNS、RTP、QUIC等的承载基础                                    | 🔥 互联网核心                |
|       1981 | [IPv4](https://www.rfc-editor.org/info/rfc791/)                                                                      | 网络层、寻址与路由       | 早期Internet Protocol→IPv4；地址不足促成CIDR、NAT，长期继任者是IPv6                                                      | 🔥 主流但地址耗尽            |
|       1981 | [ICMP](https://www.rfc-editor.org/info/rfc792/)                                                                      | 网络层控制与诊断         | IPv4控制协议；形成ping、traceroute等工具基础；IPv6对应ICMPv6                                                             | 🔥 网络基础协议              |
|       1982 | [SMTP](https://www.rfc-editor.org/info/rfc821/)                                                                      | 应用层、电子邮件         | ARPANET邮件协议→SMTP→扩展SMTP；当前核心规范主要是RFC 5321                                                                | 🔥 邮件传输核心              |
|       1982 | [ARP](https://www.rfc-editor.org/info/rfc826/)                                                                       | 链路层与网络层之间       | IPv4地址解析为局域网MAC地址；IPv6不使用ARP，改为ICMPv6邻居发现                                                           | 🔥 IPv4局域网基础            |
| 1983／1987 | [DNS](https://www.rfc-editor.org/info/rfc1034/)                                                                      | 应用层、名称解析         | 集中维护`hosts.txt`→分布式层级DNS→DNSSEC、DoT和DoH                                                                       | 🔥 互联网核心                |
| 1988／1994 | [BGP／BGP-4](https://www.rfc-editor.org/info/rfc4271/)                                                               | 网络层控制平面、域间路由 | EGP→BGP-1→BGP-4；支持CIDR和自治系统间策略路由                                                                            | 🔥 全球互联网骨干            |
| 1990／1991 | [WWW与HTTP/0.9](https://www.w3.org/History/19921103-hypertext/hypertext/WWW/Protocols/HTTP.html)                     | 应用层、Web              | 超文本系统+URL+HTTP+HTML→HTTP/1.0→HTTP/1.1→HTTP/2→HTTP/3                                                                 | △ 原版本仅有历史意义        |
|       1991 | [2G／GSM](https://www.3gpp.org/about-us)                                                                             | 蜂窝通信、数字语音       | 1G模拟语音→GSM、IS-95等数字网络→GPRS/EDGE“2.5G”→3G                                                                       | ◐ 多地退网，仍有存量        |
| 1993／1997 | [DHCP](https://www.rfc-editor.org/info/rfc2131/)                                                                     | 应用层、网络配置         | RARP/BOOTP→DHCPv4；IPv6环境中又出现DHCPv6与SLAAC                                                                         | 🔥 局域网基础                |
|       1994 | [NAT](https://www.rfc-editor.org/info/rfc1631/)                                                                      | 网络层地址转换           | IPv4地址紧缺的过渡方案→家庭NAT、NAPT、运营商级CGNAT；IPv6试图恢复端到端寻址                                              | 🔥 IPv4环境普遍              |
|       1995 | [SSH](https://www.openssh.com/history.html)                                                                          | 应用层、远程登录         | Telnet、rlogin等明文远程登录→SSH-1→SSH-2→OpenSSH；SFTP也建立在SSH上                                                      | 🔥 运维基础协议              |
| 1995／1998 | [IPv6](https://www.rfc-editor.org/info/rfc2460/)                                                                     | 网络层、下一代寻址       | IPv4→IPng→IPv6；32位地址扩大至128位，通过双栈、隧道和协议转换逐步部署                                                    | 🔥 持续扩张                  |
|       1996 | [RTP／RTCP](https://www.rfc-editor.org/info/rfc3550/)                                                                | 应用层实时媒体传输       | 实时音视频数据与质量反馈；后来衍生SRTP，并成为SIP、WebRTC媒体栈的重要部分                                                | 🔥 音视频基础                |
|       1997 | [HTTP/1.1](https://www.rfc-editor.org/info/rfc2068/)                                                                 | 应用层、Web传输          | HTTP/0.9→1.0→1.1；加入持久连接、Host、缓存和分块传输；现代规范重写为RFC 9110—9112                                        | 🔥 仍被广泛使用              |
|       1997 | [IEEE 802.11／Wi‑Fi](https://standards.ieee.org/beyond-standards/the-evolution-of-wi-fi-technology-and-standards/)   | 链路层、无线局域网       | 初代802.11→802.11a/b/g→Wi‑Fi 4/5/6/6E/7                                                                                  | 🔥 无线局域网基础            |
|       1999 | [TLS 1.0](https://www.rfc-editor.org/info/rfc2246/)                                                                  | 安全传输                 | Netscape SSL 2.0/3.0→TLS 1.0→1.1→1.2→1.3                                                                                 | ◐ 1.0/1.1已弃用，家族仍主流 |
| 1999／2014 | [MQTT](https://mqtt.org/)                                                                                            | 应用层、物联网消息       | IBM提出的轻量发布/订阅协议→OASIS MQTT 3.1.1→MQTT 5.0                                                                     | ● 物联网主流                |


|       年份 | 技术／标准                                                                                           | 层级／主要领域         | 家族／演进方式                                                                               | 2026年状态           |
| ---------: | ---------------------------------------------------------------------------------------------------- | ---------------------- | -------------------------------------------------------------------------------------------- | -------------------- |
|       2000 | [REST](https://www.ics.uci.edu/~fielding/pubs/dissertation/rest_arch_style.htm)                      | 分布式系统架构风格     | 从Web和HTTP架构中总结出的约束集合；常用HTTP+JSON实现，但REST本身不是协议，也不等于“JSON接口” | 🔥 Web API主流        |
| 2000／2003 | [SOAP 1.1／1.2](https://www.w3.org/TR/soap12-part1/)                                                 | 应用层、Web Service    | XML-RPC思想→SOAP→WSDL与WS-*体系；与REST形成两条不同的服务接口路线                            | ◐ 企业存量为主       |
|       2001 | [MPLS](https://www.rfc-editor.org/info/rfc3031/)                                                     | “2.5层”、运营商网络    | IP逐跳查表→标签交换；发展出MPLS VPN、流量工程，再受到SR-MPLS和SRv6挑战                       | ● 运营商网络重要     |
|       2001 | [3G／IMT-2000](https://www.itu.int/itunews/issue/2001/08/licensing3g.html)                           | 蜂窝通信、移动数据     | 2G/GPRS/EDGE→WCDMA、CDMA2000→HSPA/HSPA+→LTE                                                  | ◐ 全球逐步退网       |
|       2002 | [SIP](https://www.rfc-editor.org/info/rfc3261/)                                                      | 应用层、会话信令       | H.323之外的互联网式信令路线；通常组合SDP、RTP，后来成为IMS和VoIP核心                         | ● 电信与企业通信常用 |
|       2009 | Wi‑Fi 4／IEEE 802.11n                                                                                | 无线局域网             | 802.11a/b/g→802.11n；引入MIMO和信道绑定→Wi‑Fi 5                                              | ◐ 老设备存量         |
| 2009／2012 | [4G LTE／LTE-Advanced](https://www.itu.int/net/pressoffice/press_releases/2012/02.aspx)              | 蜂窝通信、移动宽带     | 3G/HSPA→LTE Release 8→LTE-Advanced Release 10→LTE-A Pro→5G NSA/SA                            | 🔥 全球移动网络主体   |
|       2011 | [WebSocket](https://www.rfc-editor.org/info/rfc6455/)                                                | 应用层、长连接         | HTTP Upgrade完成握手→在TCP连接上进行全双工通信；后来出现WebTransport等补充路线               | 🔥 实时Web常用        |
| 2011／2021 | [WebRTC 1.0](https://www.w3.org/TR/webrtc/)                                                          | 浏览器实时通信         | 浏览器插件式音视频→Web原生API；组合ICE、STUN、TURN、DTLS-SRTP和RTP                           | 🔥 实时音视频主流     |
| 2012／2015 | [GraphQL](https://graphql.org/)                                                                      | API查询语言与运行规范  | Facebook内部数据查询层→2015年公开规范；通常承载在HTTP上，可与REST并存，并不直接操作数据库    | ● 广泛使用           |
|       2013 | Wi‑Fi 5／IEEE 802.11ac                                                                               | 无线局域网             | Wi‑Fi 4→802.11ac；更宽信道、更高阶调制与多用户MIMO→Wi‑Fi 6                                   | ● 成熟存量           |
|       2014 | [CoAP](https://www.rfc-editor.org/info/rfc7252/)                                                     | 应用层、物联网         | 将REST式资源模型压缩到受限设备，通常运行在UDP上；可配合DTLS或OSCORE                          | ● 物联网特定场景     |
|       2015 | [HTTP/2](https://www.rfc-editor.org/info/rfc7540/)                                                   | 应用层、Web传输        | Google SPDY→HTTP/2；保留HTTP语义，引入二进制帧、多路复用和头部压缩，底层仍通常是TCP          | 🔥 Web主流            |
| 2015／2016 | [gRPC](https://grpc.io/blog/ga-announcement/)                                                        | 应用层、RPC框架        | Google内部Stubby+Protocol Buffers→开源gRPC；通常使用HTTP/2，支持代码生成和双向流             | 🔥 微服务后端主流     |
| 2016／2018 | [DoT／DoH](https://www.rfc-editor.org/info/rfc8484/)                                                 | 应用层、加密DNS        | 传统明文DNS→DNS over TLS→DNS over HTTPS；解析体系不变，改变的是传输与加密方式                | ● 持续普及           |
|       2018 | [TLS 1.3](https://www.rfc-editor.org/info/rfc8446/)                                                  | 安全传输               | TLS 1.2→TLS 1.3；删除旧算法、缩短握手，并成为QUIC的强制安全基础                              | 🔥 当前主流版本       |
| 2018／2019 | [5G／3GPP Release 15](https://www.3gpp.org/specifications-technologies/releases/release-15)          | 蜂窝通信、增强移动宽带 | LTE/4G→5G NR；NSA复用4G核心网→SA采用5G核心网→5G-Advanced                                     | 🔥 持续扩张           |
| 2019／2021 | Wi‑Fi 6／IEEE 802.11ax                                                                               | 无线局域网             | Wi‑Fi 5→Wi‑Fi 6；加入OFDMA、更完整的MU-MIMO、TWT；6E扩展到6GHz频段                           | 🔥 当前主流           |
|       2021 | [QUIC v1](https://www.rfc-editor.org/info/rfc9000/)                                                  | 传输层、安全多路复用   | Google QUIC→IETF QUIC；运行于UDP之上，集成TLS 1.3、可靠传输、多路复用和连接迁移              | 🔥 快速普及           |
|       2022 | [HTTP/3](https://www.rfc-editor.org/info/rfc9114/)                                                   | 应用层、Web传输        | 保留HTTP语义，将底层由TCP+TLS改为QUIC；避免HTTP/2中跨流的TCP队头阻塞                         | 🔥 持续普及           |
|       2023 | [IMT-2030／6G框架](https://www.itu.int/en/ITU-R/study-groups/rsg5/rwp5d/imt-2030/pages/default.aspx) | 下一代蜂窝通信         | IMT-2020/5G→IMT-2030/6G；当前主要处于需求定义、候选技术研究和标准化阶段                      | ◇ 尚未商用           |
|       2024 | [Wi‑Fi 7／IEEE 802.11be](https://grouper.ieee.org/groups/802/11/)                                    | 无线局域网             | Wi‑Fi 6/6E→Wi‑Fi 7；引入320MHz信道、多链路操作和4096-QAM                                     | ● 快速增长           |
|       2024 | [5G-Advanced／3GPP Release 18](https://www.3gpp.org/specifications-technologies/releases/release-18) | 蜂窝通信、5G增强       | 5G Release 15—17→Release 18首个5G-Advanced版本→Release 19→未来6G                             | ● 商用早期           |

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

客户端则主要有以下几种：

1. [V2Ray](https://github.com/v2fly/v2ray-core) / [Xray](https://github.com/XTLS/Xray-core)

   1. V2Ray 是较早的通用代理平台，支持 VMess、Shadowsocks、SOCKS、HTTP 等协议；Xray 最初从 V2Ray 生态发展而来，目前增加并重点维护了 **VLESS、XTLS、REALITY、XHTTP** 等技术。两者都是“核心程序”，Windows、Android 等平台上的图形客户端通常是在这些核心之上再提供 GUI。

2. [sing-box](https://github.com/SagerNet/sing-box)

   1. sing-box 是 SagerNet 开发的现代通用代理平台，使用 Go 编写，目标是通过一个核心统一支持多种代理、VPN和隧道协议。它拥有 Android、Apple 系统以及桌面端的相关官方客户端项目，同时能够作为服务器端程序使用。

3. [Mihomo（原 Clash.Meta）](https://github.com/MetaCubeX/mihomo)

   1. 原版 **Clash** 已经停止维护，它继承了 Clash 的基于规则进行流量分流的设计，并扩充了 VLESS、VMess、Trojan、Hysteria、WireGuard 等大量协议支持。Mihomo 本身主要是核心程序，上层可以搭配不同的图形界面使用。

### 碎碎念
总的来说,无论客户端和协议再怎么演进,重点是服务器没有出问题,如果使用的节点是钓鱼的或者被破解了,那么这个加密链接自然就失效了.

### Shadowsocks(待补充)


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
### nginx

### traefik

# 网络安全
## 恶意软件年表
| 年份 | 名称                                                                                                       | 类型               | 传播／攻击方式                                                       | 主要影响／灾害                                                                              | 2026年状态                             |
| ---- | ---------------------------------------------------------------------------------------------------------- | ------------------ | -------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | -------------------------------------- |
| 1971 | Creeper                                                                                                    | 实验性蠕虫         | 在ARPANET中的TENEX计算机之间移动并显示信息                           | 通常被视为第一个网络蠕虫先驱；基本没有破坏性                                                | 仅有历史意义                           |
| 1982 | Elk Cloner                                                                                                 | 引导区病毒         | 感染Apple II软盘，计算机从软盘启动时进入内存并感染其他软盘           | 第一批在个人电脑用户中真实传播的病毒之一                                                    | 原病毒消亡                             |
| 1983 | Fred Cohen计算机病毒实验                                                                                   | 概念与实验         | 证明程序可以把自身代码嵌入其他程序，并随宿主运行而复制               | “计算机病毒”成为正式学术和安全研究概念                                                      | 理论基础                               |
| 1986 | Brain                                                                                                      | DOS引导区病毒      | 感染软盘引导扇区，通过软盘交换传播                                   | 通常被称为首个广泛传播的IBM PC兼容机病毒；推动早期杀毒产业形成                              | 原病毒消亡                             |
| 1987 | Jerusalem                                                                                                  | 文件型病毒         | 感染DOS的`.COM`和`.EXE`文件，驻留内存继续感染程序                    | 会降低系统速度，并在某些“13号星期五”删除运行的程序                                          | 仅作病毒分析样本                       |
| 1988 | [Morris Worm](https://www.fbi.gov/history/cases-and-criminals/morris-worm)                                 | 网络蠕虫           | 利用Unix服务漏洞、弱密码和远程信任关系传播；复制控制错误导致重复感染 | 使当时互联网中数千台机器不可用；促成CERT/CC建设，并产生美国《计算机欺诈与滥用法》下首宗定罪 | 原虫消亡，漏洞蠕虫模式延续             |
| 1989 | AIDS Trojan／PC Cyborg                                                                                     | 木马、早期勒索软件 | 通过邮寄软盘传播，运行一定次数后隐藏或加密文件名并索要付款           | 通常被视为首个有明确勒索目的的恶意软件                                                      | 原木马消亡，勒索模式成为主流           |
| 1992 | Michelangelo                                                                                               | 引导区病毒         | 感染硬盘主引导记录及软盘，设定在3月6日破坏磁盘数据                   | 媒体预测会造成全球灾难，实际感染远低于预期；成为早期“病毒恐慌”代表                          | 原病毒消亡                             |
| 1995 | Concept                                                                                                    | Word宏病毒         | 把恶意宏写入Word文档和全局模板，经文档交换传播                       | 证明“文档也能执行恶意代码”，使Windows与Mac用户都可能受影响                                  | 原病毒消亡，Office宏仍是攻击入口       |
| 1999 | [Melissa](https://www.fbi.gov/news/stories/melissa-virus-20th-anniversary-032519)                          | 宏病毒、邮件蠕虫   | 用户打开Word附件后，借Outlook自动向通讯录前50人发送感染文档          | 大量企业邮件服务器被迫关闭；FBI估计清理与修复损失约8000万美元                               | 原病毒消亡                             |
| 2000 | [ILOVEYOU](https://www.govinfo.gov/content/pkg/GAOREPORTS-T-AIMD-00-181/html/GAOREPORTS-T-AIMD-00-181.htm) | VBScript蠕虫、木马 | 伪装为“LOVE-LETTER-FOR-YOU”附件，打开后覆盖文件并群发给通讯录联系人  | 数百万计算机受影响；美国政府部门邮件和文件系统中断，NASA至少1000个文件受损                  | 原虫消亡；社交工程手法仍主流           |
| 2001 | [Code Red](https://www.gao.gov/products/gao-01-1073t)                                                      | 网络蠕虫           | 利用微软IIS缓冲区溢出漏洞自动扫描并感染服务器                        | 9小时感染超过25万套系统；网页被篡改并参与拒绝服务攻击，GAO估计经济损失超过24亿美元          | 原虫消亡                               |
| 2001 | Nimda                                                                                                      | 多向量蠕虫         | 同时利用邮件附件、IIS漏洞、网页浏览、共享目录和已植入后门传播        | 企业内网可在极短时间内被全面感染，服务器、客户端和邮件系统同时受影响                        | 原虫消亡；多向量传播成为常态           |
| 2003 | SQL Slammer／Sapphire                                                                                      | 内存型网络蠕虫     | 利用SQL Server的UDP 1434漏洞，随机扫描IP；整个代码仅约376字节        | 数分钟内令全球网络拥塞；韩国互联网和移动通信受影响，美国银行ATM及航空订票系统中断           | 原虫消亡；是蠕虫传播速度极限的经典案例 |
| 2003 | Blaster／MSBlast                                                                                           | 网络蠕虫           | 利用Windows RPC漏洞自动感染，随后下载代码并计划对微软服务器发动DDoS  | 大量Windows电脑反复重启，企业和政府网络受到影响                                             | 原虫消亡                               |
| 2004 | Mydoom                                                                                                     | 邮件蠕虫、后门     | 通过伪装邮件附件和P2P文件传播，在感染设备上建立后门                  | 一度产生极高比例的互联网邮件流量，并对SCO、微软等网站发动DDoS                               | 原虫基本消亡                           |
| 2004 | Sasser                                                                                                     | 网络蠕虫           | 利用Windows LSASS漏洞直接通过网络传播，无须用户打开附件              | 航空公司、银行、医院、电视台和政府机构系统异常或停机                                        | 原虫消亡；说明补丁延迟即可形成灾害     |

| 年份 | 名称                                                                                                                                                                                                           | 类型                         | 传播／攻击方式                                                                              | 主要影响／灾害                                                                                            | 2026年状态                          |
| ---- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------- | ------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- | ----------------------------------- |
| 2007 | Zeus／Zbot                                                                                                                                                                                                     | 银行木马、僵尸网络           | 通过钓鱼邮件和漏洞包感染浏览器，记录按键、窃取银行凭证并劫持交易                            | Zeus源代码泄露后衍生出大量银行木马，成为网络金融犯罪的重要基础                                            | 原版消亡，后代和技术仍活跃          |
| 2007 | Storm Worm                                                                                                                                                                                                     | 邮件木马、P2P僵尸网络        | 用新闻标题诱导用户打开附件，再把计算机接入分布式P2P控制网络                                 | 建立规模庞大的僵尸网络，可用于垃圾邮件、恶意软件下载和DDoS                                                | 原网络消亡，去中心化C2仍常见        |
| 2008 | Conficker                                                                                                                                                                                                      | 网络蠕虫、僵尸网络           | 利用Windows服务漏洞、弱管理员密码和U盘自动运行传播                                          | 感染数百万台计算机，包括政府、医院和军用网络；促成跨国联合清理行动                                        | 少量老旧设备可能残留                |
| 2010 | Stuxnet                                                                                                                                                                                                        | 工控蠕虫、Rootkit、网络武器  | 借U盘和多个零日漏洞进入隔离网络，修改西门子PLC指令，同时向监控端返回正常数据                | 使伊朗纳坦兹部分离心机异常运行并受损；首次证明恶意代码能够直接造成工业设备物理破坏                        | 原攻击结束，工控安全转折点          |
| 2011 | [GameOver Zeus](https://www.fbi.gov/contact-us/field-offices/omaha/news/press-releases/u.s.-leads-multi-national-action-against-gameover-zeus-botnet-and-cryptolocker-ransomware-charges-botnet-administrator) | P2P银行木马、僵尸网络        | 去中心化控制感染设备，窃取网银凭证，并作为其他恶意软件的投递平台                            | 约50万至100万台设备受感染；FBI估计造成超过1亿美元损失                                                     | 原网络被破坏，技术被后继家族继承    |
| 2012 | Flame                                                                                                                                                                                                          | 网络间谍木马、蠕虫           | 通过局域网和可移动介质传播，录音、截图、记录键盘并窃取文档                                  | 主要感染中东政府和机构，被视为高度模块化国家级间谍软件代表                                                | 原行动基本结束                      |
| 2013 | [CryptoLocker](https://www.fbi.gov/contact-us/field-offices/omaha/news/press-releases/u.s.-leads-multi-national-action-against-gameover-zeus-botnet-and-cryptolocker-ransomware-charges-botnet-administrator)  | 加密勒索木马                 | 由邮件和GameOver Zeus投递，使用公钥密码学加密用户文件后索要比特币                           | 感染超过23万台计算机；早期两个月赎金估计超过2700万美元，奠定现代勒索商业模式                              | 原基础设施被摧毁，模式高度活跃      |
| 2014 | [Emotet](https://www.cisa.gov/news-events/alerts/2018/07/20/emotet-malware)                                                                                                                                    | 银行木马、下载器、僵尸网络   | 通过带宏文档或链接的钓鱼邮件进入系统，再下载其他木马和勒索软件                              | 从银行木马演变为“恶意软件投递平台”；感染数十万台设备并造成数百万美元损失                                  | 原网络多次被打击，投递器模式仍主流  |
| 2015 | [BlackEnergy／KillDisk](https://www.cisa.gov/news-events/ics-alerts/ir-alert-h-16-056-01)                                                                                                                      | 工控木马、擦除器             | 通过鱼叉邮件进入电力企业，窃取凭证、控制设备，再用KillDisk破坏系统                          | 与乌克兰电网停电事件有关，约23万用户一度断电；关键基础设施网络攻击进入现实阶段                            | 原家族沉寂，OT攻击持续              |
| 2016 | [Mirai](https://www.cisa.gov/news-events/alerts/2017/10/17/heightened-ddos-threat-posed-mirai-and-other-botnets)                                                                                               | IoT蠕虫、僵尸网络            | 扫描摄像头、路由器等设备，尝试出厂默认用户名和密码，感染后发动DDoS                          | 对DNS服务商Dyn的攻击令Twitter、Netflix、GitHub等大量网站短暂无法访问                                      | 源码已泄露，变种仍活跃              |
| 2017 | [WannaCry](https://www.cisa.gov/sites/default/files/FactSheets/NCCIC%20ICS_FactSheet_WannaCry_Ransomware_S508C.pdf)                                                                                            | 勒索软件、加密蠕虫           | 利用Windows SMBv1的EternalBlue漏洞自动横向传播并加密文件                                    | 波及150多个国家、数十万台设备；英国NHS约1.9万次预约被取消，估计损失约9200万英镑                           | 全球爆发结束，未修补设备仍有风险    |
| 2017 | [NotPetya](https://www.cisa.gov/news-events/alerts/2017/07/01/petya-ransomware)                                                                                                                                | 擦除器、伪勒索软件、蠕虫     | 从被污染的乌克兰财务软件更新进入网络，再利用EternalBlue和窃取的凭证横向扩散                 | 乌克兰政府、银行和交通系统受重创，并扩散至马士基、默克、TNT等企业；全球损失估计约100亿美元                | 一次性破坏行动，攻击手法仍有影响    |
| 2017 | Triton／TRISIS                                                                                                                                                                                                 | 工控木马                     | 专门攻击石化设施的安全仪表系统，尝试修改负责紧急停车的控制器                                | 导致目标工厂意外停机；若成功绕过安全系统，可能造成设备损毁和人员伤亡                                      | 原行动受限，但属于最高风险OT威胁    |
| 2018 | SamSam                                                                                                                                                                                                         | 定向勒索软件                 | 攻击者先获得服务器或远程桌面权限，再人工横向移动并集中加密网络                              | 亚特兰大市政、医院和政府机构遭受严重业务中断；体现从“撒网传播”向“定向入侵”转变                            | 原家族沉寂，人工运营勒索已成常态    |
| 2020 | [SUNBURST／SolarWinds](https://www.gao.gov/blog/solarwinds-cyberattack-demands-significant-federal-and-private-sector-response-infographic)                                                                    | 供应链后门、间谍木马         | 攻击者污染SolarWinds Orion的构建和软件更新，让合法签名更新携带后门                          | 约1.8万客户收到受污染更新；攻击者从中选择美国政府部门和大型企业等高价值目标进行长期间谍活动               | 原后门清除，供应链攻击持续活跃      |
| 2021 | [DarkSide／Colonial Pipeline](https://www.cisa.gov/news-events/news/attack-colonial-pipeline-what-weve-learned-what-weve-done-over-past-two-years)                                                             | 勒索软件、RaaS               | 入侵企业IT网络并窃取、加密数据；运营方为控制风险主动暂停管道系统                            | 美国最大成品油管道之一暂停运营，引发东海岸燃油短缺、排队和恐慌购买                                        | DarkSide品牌消失，RaaS模式仍活跃    |
| 2022 | HermeticWiper                                                                                                                                                                                                  | 磁盘擦除器                   | 破坏Windows主引导记录和磁盘数据，使设备无法正常启动                                         | 在俄乌战争前后攻击乌克兰政府、金融及其他机构，体现恶意软件与军事行动协同                                  | 特定行动结束，擦除器仍用于战争      |
| 2023 | [Cl0p／MOVEit事件](https://www.cisa.gov/news-events/cybersecurity-advisories/aa23-158a)                                                                                                                        | 数据窃取、勒索、边界设备攻击 | 批量利用MOVEit Transfer零日SQL注入漏洞，从大量机构服务器中窃取文件并勒索                    | 政府、大学、金融、医疗和企业供应链同时受影响；说明一个文件传输产品漏洞可以造成全球级连锁泄露              | 原漏洞已修复，批量勒索模式活跃      |
| 2024 | [ALPHV／Change Healthcare](https://www.hhs.gov/hipaa/for-professionals/special-topics/change-healthcare-cybersecurity-incident-frequently-asked-questions/index.html)                                          | 勒索软件、数据窃取           | 凭证入侵后控制关键医疗支付与理赔网络，窃取数据并迫使运营方隔离系统                          | 美国处方、理赔和医疗付款广泛中断；公司后续估计约1.9亿人的信息受到影响，成为美国医疗领域影响最大的攻击之一 | ALPHV品牌遭打击，附属加盟模式仍危险 |
| 2024 | [XZ Utils后门](https://www.cisa.gov/news-events/alerts/2024/03/29/reported-supply-chain-compromise-affecting-xz-utils-data-compression-library-cve-2024-3094)                                                  | 开源供应链后门               | 攻击者长期取得项目维护权限，把高度混淆的恶意代码植入XZ 5.6.0/5.6.1发布包，试图影响SSH认证链 | 在进入大多数稳定Linux发行版前被发现，实际灾害有限；但暴露了长期渗透开源维护链的巨大潜在风险               | 污染版本已撤回，供应链风险持续      |

至于[DDoS](https://www.radware.com/security/ddos-knowledge-center/ddos-chronicles/ddos-attacks-history/)这种不太有技巧性的攻击,就不用放上去了.


