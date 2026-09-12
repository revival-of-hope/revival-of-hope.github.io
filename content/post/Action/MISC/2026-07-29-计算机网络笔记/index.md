---
title: "计算机网络笔记"
date: 2026-09-03T12:41:07+08:00
description: 先让AI帮我说说话,之后有空填坑
image: 69045738_p0-….webp
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

## 通信规范：从Rest到gRPC(AI版)
你别说,写的还挺好,让我自己来写都写不到这种程度呢


今天的后端开发中，REST、gRPC、GraphQL 几乎已经成为最常见的三种服务通信方案。但如果从历史上观察，会发现它们并不是几套毫无关系的技术，而是在不断回答同一个问题：

> 分布在不同计算机上的程序，究竟应该如何彼此调用？

从早期 RPC，到互联网时代的 REST，再到微服务时代重新兴起的 gRPC，以及专门解决前端数据获取问题的 GraphQL，整个发展过程实际上体现了分布式系统在**调用便利性、松耦合、性能、可扩展性和开发效率**之间不断寻找平衡的历史。

需要首先区分几个概念：**RPC 是一种远程调用范式；REST 是一种网络软件架构风格；gRPC 是现代 RPC 框架；GraphQL 是 API 查询语言和执行体系。**它们并不处在完全相同的抽象层级上。

### 早期RPC框架

**1. 网络程序最原始的问题**

假设一台服务器拥有一个函数：

```text
getUser(123)
```

如果调用者和函数位于同一个进程中，程序只需要进行一次普通函数调用。

但如果用户服务运行在另外一台服务器上，事情就完全不同了。客户端至少需要完成：

1. 找到远程服务器；
2. 建立网络连接；
3. 把函数名和参数编码成字节；
4. 将数据发送给服务器；
5. 服务器解析数据；
6. 调用真正的函数；
7. 将执行结果再次序列化；
8. 通过网络返回；
9. 客户端解析结果。

如果所有开发者都直接操作 Socket，这套逻辑就会充斥整个应用程序。

RPC，即 **Remote Procedure Call，远程过程调用**，就是为了解决这个问题而产生的。

RPC 最重要的思想非常简单：

> 让调用远程服务器上的函数，看起来尽可能像调用本地函数。

RPC 的经典研究在 20 世纪 80 年代已经形成。Andrew Birrell 与 Bruce Nelson 在 1984 年发表的《Implementing Remote Procedure Calls》系统讨论了客户端绑定、通信协议、参数传递以及 RPC 性能等问题，成为 RPC 发展史上的经典论文。

典型 RPC 系统通常包含：

```text
客户端业务代码
      ↓
Client Stub
      ↓
序列化
      ↓
网络
      ↓
反序列化
      ↓
Server Stub
      ↓
服务器函数
```

这里最重要的组件叫做 **Stub，存根**。

例如程序员写：

```text
user = userService.getUser(123)
```

表面上看只是调用函数，实际上 Client Stub 会自动把它转换成网络消息：

```text
method: getUser
parameter:
    id: 123
```

服务器收到以后，再由 Server Stub 还原并执行真正的方法。

因此 RPC 最大的价值并不是创造了新的网络能力，而是**隐藏了网络通信的复杂性**。

**2. IDL：让不同语言理解彼此**

随后又出现了一个问题。

如果服务器使用 C++，客户端使用 Java，它们如何知道：

```text
getUser(int id) -> User
```

究竟意味着什么？

于是 RPC 体系逐渐发展出 **IDL（Interface Definition Language，接口定义语言）**。

开发者先定义一份与具体编程语言无关的接口：

```text
interface UserService {
    User getUser(long id);
}
```

再通过代码生成工具生成：

```text
Java Client Stub
C++ Server Stub
Python Client Stub
……
```

今天 gRPC 使用 `.proto` 文件，本质上依然继承了这一思想。

IDL 的意义非常重要：它把“网络上的双方必须事先约定数据结构和接口”这件事正式制度化了。

此后很多 RPC 框架实际上都遵循了类似模式：

```text
定义接口
   ↓
生成客户端/服务端代码
   ↓
序列化参数
   ↓
网络传输
   ↓
反序列化
   ↓
执行函数
```

**3. CORBA：大型跨语言 RPC 的早期尝试**

进入 1990 年代以后，企业开始大量建设分布式系统。

1991 年，OMG 发布 CORBA 1.0。CORBA 引入对象模型、IDL 和 ORB（Object Request Broker），希望让不同语言、不同操作系统中的对象能够互相调用。

CORBA 的愿景极其宏大：

```text
Java程序
    ↓
   ORB
    ↓
网络
    ↓
   ORB
    ↓
C++程序
```

应用程序不需要关心底层网络。

与此同时还出现了大量类似技术：

* Microsoft DCOM；
* Java RMI；
* Sun RPC；
* XML-RPC；
* SOAP。

它们共同代表了第一次分布式计算浪潮。

但是早期 RPC 系统也暴露出了非常明显的问题。

一方面，很多 RPC 框架与特定厂商、语言或者运行时深度绑定。例如 Java RMI 更适合 Java 世界，DCOM 则深度依赖微软生态。

另一方面，这些系统往往试图把远程调用伪装成本地调用，但远程调用实际上拥有完全不同的失败模型。

本地函数调用通常不会出现：

```text
网络超时
连接中断
服务器宕机
请求丢失
重复请求
远程服务负载过高
```

而 RPC 会。

这也是分布式系统中一个非常重要的认识：

> 远程调用永远不可能真正等同于本地调用。

网络本身就是系统设计的一部分。

**4. SOAP：把企业 RPC 搬到 Web 上**

互联网兴起以后，人们开始思考：

既然 HTTP 已经能够穿过企业网络、防火墙和代理服务器，为什么不直接通过 HTTP 做远程调用？

于是 XML-RPC、SOAP 等技术出现。

SOAP 使用 XML 描述结构化消息，例如：

```xml
<Envelope>
    <Body>
        <GetUser>
            <Id>123</Id>
        </GetUser>
    </Body>
</Envelope>
```

它可以通过 HTTP 等底层协议传输。

SOAP 随后又逐渐形成了一套庞大的 Web Services 技术体系：

```text
SOAP
WSDL
XML Schema
WS-Security
WS-ReliableMessaging
WS-AtomicTransaction
……
```

其中 WSDL 用于描述服务接口，角色与后来的 `.proto`、OpenAPI 有一定相似之处。

SOAP 在银行、电信、政府以及大型企业系统中长期占据重要位置，因为它强调：

* 明确的接口契约；
* 严格的数据类型；
* 跨语言通信；
* 安全机制；
* 事务机制；
* 企业级可靠性。

但是它的问题也越来越明显：**过于复杂和沉重。**

一个简单的业务请求可能被大量 XML 标签、Namespace、Envelope 和复杂的工具链包围。

随着互联网网站快速发展，大量 Web 开发者开始认为：

> 我只是想让浏览器获取几个用户数据，为什么需要这么复杂？

正是在这种背景下，REST 开始流行。

### Rest的诞生与风行

**1. REST 本来不是一套接口协议**

REST 是 **Representational State Transfer，表述性状态转移**。

2000 年，Roy Fielding 在博士论文《Architectural Styles and the Design of Network-based Software Architectures》中正式系统化提出 REST。

需要特别注意：

> REST 并不是一种协议，也不是一种 RPC 框架。

REST 是一种**网络软件架构风格**。

Fielding 真正研究的问题并不是“如何设计一个方便的后端 API”，而是：

> 为什么整个 World Wide Web 能够扩展到如此巨大的规模？

因此 REST 实际上是对 Web 架构成功经验的一种抽象。

**2. 从“调用函数”转向“操作资源”**

RPC 的思维方式通常是：

```text
getUser()
createUser()
deleteUser()
updateUser()
```

核心对象是**方法**。

例如：

```text
deleteUser(123)
```

意思是：

> 请远程服务器执行 deleteUser 这个动作。

REST 则把思维方式改成了：

> 网络上存在各种资源，客户端通过统一接口操作这些资源。

例如：

```text
/users/123
/orders/10086
/articles/456
```

这些 URI 表示资源。

随后使用 HTTP 方法表达操作：

```text
GET    /users/123
POST   /users
PUT    /users/123
DELETE /users/123
```

因此，同样是删除一个用户：

```text
RPC：

deleteUser(123)
```

REST 则可能是：

```http
DELETE /users/123
```

两者反映了两种完全不同的抽象方式。

RPC 是：

> 我要让服务器执行一个动作。

REST 是：

> 我要获取或者改变某个资源的状态。

**3. REST 的核心约束**

严格意义上的 REST 并不等于：

```text
HTTP + JSON
```

JSON 甚至不是 REST 理论的一部分。

REST 包含一系列架构约束。

首先是 **Client-Server**。

客户端与服务器分离。

例如浏览器并不需要知道服务器究竟使用 PostgreSQL、MySQL 还是 MongoDB；服务器也不需要知道客户端使用 React、Vue 还是原生移动应用。

这种分离使前后端能够独立演化。

其次是 **Stateless，无状态**。

每一个请求应该包含服务器处理它所需要的信息。

例如：

```http
GET /users/123
Authorization: Bearer xxx
```

服务器不应该依赖：

> 客户端此前第 1 次请求做了什么、第 2 次请求又做了什么。

Stateless 对互联网系统极其重要，因为它方便水平扩展：

```text
客户端
   ↓
负载均衡器
 ↙   ↓   ↘
S1   S2   S3
```

请求可以被分配给任意服务器。

第三是 **Cacheable，可缓存**。

HTTP 可以通过：

```text
Cache-Control
ETag
Last-Modified
```

告诉浏览器、代理服务器或者 CDN：

> 这个结果是否可以缓存。

于是形成：

```text
客户端
  ↓
CDN
  ↓
服务器
```

大量请求甚至不需要真正到达源站。

第四是 **Uniform Interface，统一接口**。

这可能是 REST 最核心的思想。

在传统 RPC 中，每个服务可能定义：

```text
createUser()
createOrder()
addProduct()
removeProduct()
cancelPayment()
```

但 REST 尽量要求所有资源遵循统一的操作语义：

```text
GET
POST
PUT
PATCH
DELETE
```

因此客户端并不需要学习每一种资源独有的调用机制。

REST 完整意义上的统一接口还涉及资源标识、Representation、自描述消息和超媒体等约束。

第五是 **Layered System，分层系统**。

客户端并不需要知道自己到底连接的是：

```text
Nginx
API Gateway
CDN
反向代理
真正的应用服务器
```

因此系统可以演化为：

```text
Client
  ↓
CDN
  ↓
Nginx
  ↓
API Gateway
  ↓
Application
```

这使 Web 架构拥有极强的扩展能力。

**4. REST 为什么会迅速风行？**

REST 真正改变开发世界，并不是因为它理论上最严谨，而是因为它极其符合互联网开发的实际需要。

开发者只需要：

```text
HTTP
+
URL
+
JSON
```

就可以搭建非常容易理解的 API。

例如：

```http
GET /api/users/123
```

返回：

```json
{
    "id": 123,
    "name": "Alice"
}
```

几乎任何平台都能调用：

```text
JavaScript
Python
Java
Go
C#
PHP
curl
浏览器
手机 App
```

而且它天然复用了整个 Web 已经存在的基础设施：

* HTTP；
* HTTPS；
* DNS；
* 浏览器；
* CDN；
* Nginx；
* Proxy；
* Cache；
* HTTP Status Code。

因此 REST 最大的优势并不是性能，而是：

> **开放性、简单性和生态兼容性。**

这也是为什么 REST 最终成为互联网公开 API 的事实标准之一。

**5. REST 的问题开始暴露**

REST 在互联网 API 中非常成功，但随着系统从单体应用逐渐演变成微服务，新的问题开始出现。

假设一个订单请求内部需要访问：

```text
用户服务
商品服务
库存服务
优惠券服务
支付服务
物流服务
```

一次用户请求可能演化成十几甚至几十次内部服务调用。

此时 REST 常见的：

```text
HTTP + JSON
```

开始表现出一些性能问题。

例如 JSON：

```json
{
    "user_id": 123,
    "product_id": 456,
    "product_name": "Keyboard"
}
```

字段名本身也要不断通过网络传输。

而 JSON 还是文本格式，服务器还需要进行字符串解析、数字转换和对象构造。

如果每秒只有几十个请求，问题几乎可以忽略。

但如果一个大型微服务系统内部每秒存在：

```text
10万
100万
甚至更多
```

服务间调用，这些成本就会逐渐积累。

与此同时，REST API 的接口契约也比较松。

假设服务端原来返回：

```json
{
    "id": 123
}
```

后来某位开发者改成：

```json
{
    "userId": 123
}
```

如果缺乏完善的接口管理，客户端可能直到运行时才发现问题。

因此微服务时代又重新产生了一个需求：

> 能不能拥有 RPC 那样的强类型接口和高性能，同时又使用现代互联网基础设施？

gRPC 正是在这样的背景下快速兴起。

### gRPC横空出世

* [参考文章](https://info.support.huawei.com/info-finder/encyclopedia/zh/gRPC.html)

* [wiki](https://en.wikipedia.org/wiki/GRPC)

Google 很早就面临大规模分布式系统内部通信问题。

Google 内部长期使用一种名为 **Stubby** 的 RPC 基础设施，用于连接大量数据中心内部服务。

2015 年前后，Google 将新一代 RPC 技术开源，由此形成了今天的 **gRPC**。

gRPC 可以简单理解为：

> **传统 RPC 思想在现代云计算和微服务环境中的重新实现。**

它将几项技术组合到了一起：

```text
RPC
+
Protocol Buffers
+
HTTP/2
+
IDL
+
自动代码生成
+
Streaming
```

**1. Protocol Buffers：重新强化接口契约**

假设需要开发一个 UserService。

首先创建：

```text
user.proto
```

然后定义：

```proto
service UserService {
    rpc GetUser(GetUserRequest)
        returns (User);
}

message GetUserRequest {
    int64 id = 1;
}

message User {
    int64 id = 1;
    string name = 2;
}
```

这里已经明确规定：

```text
服务叫什么
↓
有哪些方法
↓
方法接收什么参数
↓
返回什么结果
↓
每个字段是什么类型
```

随后通过 `protoc` 等工具生成代码。

例如：

```text
.proto
  ↓
Go Client
Java Client
Python Client
C++ Client
```

于是客户端不需要手工拼：

```http
POST /xxx
Content-Type: application/json
```

也不需要自己分析 JSON。

它可以直接写类似：

```text
client.GetUser(...)
```

这实际上重新回到了 RPC 最早的目标：

> 像调用本地函数一样调用远程服务。

但是与早期 RPC 相比，gRPC 的接口定义更加标准化，跨语言能力和现代工具链也更加成熟。

**2. Protobuf 的二进制序列化**

REST 最典型的数据格式是 JSON。

例如：

```json
{
    "id": 123,
    "name": "Alice"
}
```

优点非常明显：

> 人能直接读懂。

但是机器其实没有必要不断读取：

```text
"id"
"name"
```

因为通信双方早就已经知道字段结构。

Protocol Buffers 会把这些数据编码成紧凑的二进制形式。

因为 `.proto` 已经定义：

```text
字段1 = id
字段2 = name
```

网络传输时只需要编码字段编号、类型和数据。

因此 Protobuf 通常能够获得：

* 更小的数据体积；
* 更快的序列化；
* 更快的反序列化；
* 更低的网络带宽占用。

这对大型微服务尤其重要。

**3. HTTP/2 带来的变化**

gRPC 的另一个核心基础是 HTTP/2。

HTTP/1.1 的典型通信模式长期以来以请求—响应为中心。

即使使用 Keep-Alive，在处理大量并发请求时，往往仍然需要维护多条 TCP 连接。

HTTP/2 引入了 **Stream**。

一个 TCP Connection 可以同时存在：

```text
TCP Connection
 │
 ├── Stream 1
 ├── Stream 3
 ├── Stream 5
 ├── Stream 7
 └── Stream 9
```

不同请求和响应可以在同一连接中交错传输。

这就是：

> **Multiplexing，多路复用。**

因此：

```text
Service A
      ↓
一条HTTP/2连接
      ↓
Service B
```

就可以同时承载大量 RPC。

这对微服务环境尤其合适，因为服务之间通常存在大量短小、高频的调用。

**4. Streaming**

普通 REST 最常见的是：

```text
Request
   ↓
Response
```

也就是一问一答。

gRPC 原生支持四种调用方式。

第一种是 Unary RPC：

```text
Client → Request
Server → Response
```

最接近传统函数调用。

第二种是 Server Streaming：

```text
Client → Request

Server → Message 1
Server → Message 2
Server → Message 3
……
```

服务器可以不断返回数据。

第三种是 Client Streaming：

```text
Client → Chunk 1
Client → Chunk 2
Client → Chunk 3
……
Server → Result
```

客户端连续发送数据，服务器最后统一返回结果。

第四种是 Bidirectional Streaming：

```text
Client ⇄ Server
```

双方都可以持续发送消息。

这使 gRPC 很适合：

* 实时通信；
* 大规模数据传输；
* 日志流；
* 长连接服务；
* AI 推理流式输出；
* 服务间持续数据交换。

**5. gRPC 为什么特别适合微服务？**

假设一个现代电商系统拥有：

```text
User Service
Order Service
Product Service
Inventory Service
Payment Service
Logistics Service
Recommendation Service
```

一个订单请求可能形成：

```text
Order
 ├── User
 ├── Product
 ├── Inventory
 ├── Payment
 └── Logistics
```

服务间通信的特点是：

* 调用频繁；
* 通常由程序调用程序；
* 人类很少直接查看原始请求；
* 双方服务都由企业控制；
* 可以提前共享接口定义；
* 性能要求较高。

这正是 gRPC 最适合的环境。

因此很多系统会采用：

```text
用户
 ↓
REST / GraphQL
 ↓
API Gateway
 ↓
gRPC
 ↓
内部微服务
```

也就是说，gRPC 并不一定直接面对浏览器。

它主要负责：

> **数据中心内部的服务到服务通信。**

**6. gRPC 仍然继承 RPC 的本质**

值得注意的是，gRPC 虽然使用 HTTP/2，但它本质上并不是 REST。

例如：

```proto
rpc CreateUser(...)
rpc GetUser(...)
rpc DeleteUser(...)
```

核心抽象仍然是：

```text
Service
+
Method
```

也就是：

> 调用远程方法。

REST 的核心则是：

```text
Resource
+
Representation
+
Uniform Interface
```

所以两者在思想上实际上存在根本区别。

REST：

```text
DELETE /users/123
```

gRPC：

```text
UserService.DeleteUser(123)
```

前者是：

> 对用户资源执行 DELETE。

后者是：

> 调用 UserService 的 DeleteUser 方法。

因此 gRPC 实际上意味着：

> RPC 并没有被 REST 淘汰。

相反，在微服务时代，RPC 以更现代的形式重新成为核心通信方式。

**7. 为什么 gRPC 没有取代 REST？**

如果 gRPC 性能更好，那么为什么整个互联网没有全部切换到 gRPC？

因为性能并不是 API 设计的唯一目标。

REST 可以直接：

```bash
curl https://api.example.com/users/123
```

然后得到：

```json
{
    "id": 123,
    "name": "Alice"
}
```

开发者甚至打开浏览器就能理解它。

gRPC 则使用二进制 Protobuf。

这意味着：

* 人类无法直接阅读网络消息；
* 调试需要专门工具；
* 浏览器支持没有普通 HTTP API 那么自然；
* 第三方接入成本较高。

因此可以粗略认为：

```text
公网 API
→ REST 更自然

浏览器 ↔ Server
→ REST / GraphQL 更自然

内部微服务
→ gRPC 很有优势

高性能跨服务调用
→ gRPC 很有优势
```

也就是说：

> REST 强在开放性和通用性，gRPC 强在内部高性能服务通信。

两者并没有形成简单的淘汰关系。

### GraphQL的插曲

REST 流行以后，又出现了一类与 RPC 性能完全不同的问题。

问题主要发生在：

> **前端和后端之间。**

假设一个手机 App 的个人主页需要显示：

```text
用户头像
用户名
粉丝数
最近5篇文章
每篇文章评论数
```

传统 REST API 可能需要：

```text
GET /users/123
GET /users/123/followers
GET /users/123/articles
GET /articles/1/comments
GET /articles/2/comments
……
```

前端为了渲染一个页面，可能需要调用很多 API。

这种问题称为：

**Under-fetching。**

也就是：

> 一次请求获得的数据不足，因此需要继续发送其他请求。

相反：

```text
GET /users/123
```

可能返回：

```json
{
    "id": 123,
    "name": "Alice",
    "avatar": "...",
    "birthday": "...",
    "address": "...",
    "register_time": "...",
    "phone": "...",
    "settings": "...",
    "permissions": "..."
}
```

而当前页面其实只需要：

```text
name
avatar
```

于是又产生：

**Over-fetching。**

即：

> API 返回了大量客户端根本不需要的数据。

Facebook 在复杂移动应用开发中遇到了类似问题，并在 2012 年开始开发 GraphQL，2015 年将其公开。

GraphQL 给出的解决方案与 REST 和 gRPC 都不同：

> **客户端自己告诉服务器，它需要什么数据。**

例如：

```graphql
query {
    user(id: 123) {
        name
        avatar
        followers {
            count
        }
        articles(limit: 5) {
            title
            commentCount
        }
    }
}
```

服务器只需要返回：

```json
{
    "user": {
        "name": "Alice",
        "avatar": "...",
        "followers": {
            "count": 100
        },
        "articles": [...]
    }
}
```

客户端不需要的字段就不必返回。

**1. GraphQL 的核心不是“另一种 REST”**

GraphQL 并不是：

```text
REST 2.0
```

它更接近：

> 一种针对 API 数据图进行查询的语言和运行机制。

GraphQL Server 首先定义 Schema，例如：

```graphql
type User {
    id: ID!
    name: String!
    articles: [Article!]!
}
```

然后客户端针对 Schema 发出查询。

因此 GraphQL 和 REST 最大的不同在于：

REST 往往由服务器决定：

```text
这个 Endpoint 返回什么。
```

GraphQL 则让客户端决定：

```text
我需要哪些字段。
```

**2. GraphQL 也不是数据库**

这是一个非常常见的误解。

GraphQL Server 后面可以连接：

```text
PostgreSQL
MySQL
MongoDB
Redis
REST API
gRPC Service
其他 GraphQL Service
```

例如：

```text
Browser
   ↓
GraphQL
   ↓
GraphQL Server
   ├── PostgreSQL
   ├── Redis
   ├── REST Service
   └── gRPC Service
```

因此 GraphQL 实际上经常位于：

> 客户端与大量后端服务之间的聚合层。

**3. GraphQL 为什么没有取代 REST？**

GraphQL 虽然解决了灵活取数的问题，但也带来了新的复杂性。

例如一个客户端可以提交：

```graphql
user {
    friends {
        friends {
            friends {
                friends {
                    ...
                }
            }
        }
    }
}
```

如果没有限制，服务器可能执行极其昂贵的查询。

因此 GraphQL Server 通常还需要：

* Query Depth 限制；
* Query Complexity 限制；
* Rate Limiting；
* DataLoader；
* 权限检查；
* 缓存策略。

同时，REST 可以直接利用 HTTP：

```text
GET /users/123
```

进行非常成熟的 CDN 和 URL 缓存。

GraphQL 常见模式则可能是：

```text
POST /graphql
```

不同查询都经过同一个 Endpoint，传统 HTTP Cache 的利用方式不再像 REST 那么直接。

此外还存在著名的：

> N+1 Query Problem。

例如获取：

```text
100篇文章
+
每篇文章的作者
```

如果 Resolver 设计不合理，就可能产生：

```text
1次查询文章
+
100次查询作者
```

因此 GraphQL 并不是一种“毫无代价的更先进 REST”，它只是针对复杂客户端数据获取问题提供了另一种选择。


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

### Shadowsocks

理解 Shadowsocks，首先需要把“代理”与“VPN”区分开。

Shadowsocks 最核心的结构其实非常简单：

```text
Application
    │
    ↓
SOCKS5 / TUN
    │
    ↓
Shadowsocks Client
    │
    │ 加密连接
    ↓
Shadowsocks Server
    │
    ↓
Target Server
```

官方对经典 Shadowsocks 的描述也是一个典型的 Split Proxy：

```text
client
  ↕
ss-local
  ↕ encrypted
ss-remote
  ↕
target
```

也就是说，Shadowsocks 并不是让浏览器直接理解一种特殊协议，而是在本机放置一个代理程序。应用程序首先把正常的网络请求交给本地 Shadowsocks Client，然后客户端把“我要访问哪个地址”以及真正的数据一起加密，发送给远端 Shadowsocks Server；服务器解密以后，再代替客户端访问真正的目标。

**1. Shadowsocks真正加密的是哪一段？**

假设你要访问：

```text
www.example.com:443
```

正常直连是：

```text
Your Computer
     │
     │ Internet
     ↓
www.example.com
```

Shadowsocks 则增加一个中间节点：

```text
Your Computer
     │
     │ Shadowsocks encrypted tunnel
     ↓
Proxy Server
     │
     │ normal Internet connection
     ↓
www.example.com
```

因此真正由 Shadowsocks 保护的是：

```text
客户端
   ↕
Shadowsocks服务器
```

这一段。

服务器之后到目标网站之间：

```text
Shadowsocks Server
       ↓
Target
```

是否加密，则取决于应用本身使用什么协议。

如果访问：

```text
HTTP
```

那么出口服务器理论上可以看到 HTTP 明文。

如果访问：

```text
HTTPS
```

结构实际上是：

```text
Application Data
      ↓
HTTPS / TLS
      ↓
Shadowsocks Encryption
      ↓
Internet
```

服务器解除 Shadowsocks 外层以后，看到的仍然主要是：

```text
TLS ciphertext
```

而不是网页正文。

所以这里其实存在：

```text
两层加密
```

即：

```text
网页应用层
      │
      ↓
HTTPS
      │
      ↓
Shadowsocks
      │
      ↓
网络
```

这也是理解所有代理协议时极其重要的一点：

> **代理协议的加密与网站本身 HTTPS 的加密并不是同一层。**

---

**2. Shadowsocks的数据包里究竟有什么？**

Shadowsocks 并不是简单地：

```text
encrypt(TCP bytes)
```

因为远端服务器还需要知道：

> 这些数据最终应该发给谁？

所以客户端需要把目标地址放进加密数据。

经典 Shadowsocks 地址格式借用了 SOCKS5 的设计：

```text
Address Type
+
Target Address
+
Target Port
+
Payload
```

例如逻辑上类似：

```text
DOMAIN
example.com
443
<application data>
```

整个部分经过 Shadowsocks 加密后：

```text
[ Target Address + Port + Data ]
              ↓
           Encrypt
              ↓
       Random-looking bytes
```

服务器解密之后才知道：

```text
目标 = example.com:443
```

再建立真正的外部连接。Shadowsocks 的协议资料明确规定了 IPv4、IPv6 和域名三种 SOCKS5 风格的目标地址编码。

因此代理服务器承担的工作可以总结为：

```text
客户端：
应用流量
↓
加入目标地址
↓
加密
↓
发送

服务器：
接收
↓
解密
↓
读取目标地址
↓
连接目标服务器
↓
转发
```

---

**3. 为什么Shadowsocks当时显得如此轻量？**

Shadowsocks 的设计没有试图重新发明：

```text
完整VPN
完整虚拟网卡协议
复杂身份体系
完整PKI
庞大的握手机制
```

它本质上只做了几件事情：

```text
目标地址封装
+
对称加密
+
TCP/UDP转发
```

这意味着：

```text
协议头较小
实现简单
运行开销低
部署成本低
```

也是它早期迅速流行的重要原因。

---

**4. 早期Stream Cipher时代**

早期 Shadowsocks 大量使用：

```text
AES-CFB
ChaCha20
Salsa20
RC4-MD5
```

之类的 Stream Cipher。

基本思想可以理解成：

```text
Plaintext
    ↓
Key Stream
    ↓ XOR
Ciphertext
```

问题是：

> **仅仅“不可读”还不够。**

攻击者即使不知道明文，也可能修改 Ciphertext。

如果协议没有完善的：

```text
Integrity
完整性认证
```

接收方可能无法判断数据是否被恶意篡改。

这也是现代密码协议越来越强调：

```text
Authenticated Encryption
```

而不只是：

```text
Encryption
```

的原因。

---

**5. 从Stream Cipher到AEAD**

后来 Shadowsocks 转向：

```text
AEAD
Authenticated Encryption with Associated Data
```

常见算法包括：

```text
AES-128-GCM
AES-256-GCM
ChaCha20-Poly1305
```

AEAD 同时提供：

```text
Confidentiality
机密性

+

Integrity
完整性

+

Authentication
认证
```

如果攻击者修改 Ciphertext：

```text
Ciphertext
↓
被篡改
↓
Authentication Tag验证失败
↓
拒绝解密
```

而不会把被修改的数据悄悄交给应用。

Shadowsocks 官方目前仍建议使用 AEAD，并明确指出旧 Stream Cipher 已被弃用；当前 shadowsocks-rust 也把传统 Stream Cipher 标记为不安全的兼容功能。

---

**6. Shadowsocks AEAD内部如何工作？**

以一条 TCP 会话为例。

连接开始时会生成：

```text
Salt
```

然后根据：

```text
Master Key
+
Salt
```

通过 Key Derivation Function 导出：

```text
Session Subkey
```

也就是说：

```text
长期密钥
   │
   ├── Session A Salt
   │        ↓
   │     Key A
   │
   ├── Session B Salt
   │        ↓
   │     Key B
   │
   └── Session C Salt
            ↓
         Key C
```

这样不同连接不会简单重复使用完全相同的实际加密密钥。

TCP 数据随后被切成 Chunk：

```text
Encrypted Length
      +
Encrypted Payload
```

每一个部分都经过 AEAD 认证。

官方 AEAD 规范中，每条 TCP Stream 首先携带随机 Salt，然后使用派生出的 Session Subkey 对长度和 Payload 分别进行 AEAD 处理。

这比早期：

```text
一条长Stream Cipher一路加密到底
```

更加健壮。

---

**7. Shadowsocks 2022**

Shadowsocks 后来进一步提出：

```text
AEAD-2022
```

即 SIP022。

官方将它描述为对 2017 年 AEAD 方案的升级，主要目标包括：

```text
更完整的Replay Protection
淘汰旧密码学组件
提升性能
改善UDP会话设计
为协议扩展预留空间
```

Shadowsocks 2022 仍然基于 Pre-Shared Key 和 AEAD，并特别强调完整 Replay Protection。

这里出现一个重要概念：

```text
Replay Attack
重放攻击
```

攻击者虽然看不懂一段数据：

```text
9f 83 a1 ...
```

但可以：

```text
截获
↓
原样保存
↓
过一段时间重新发送
```

如果服务器无法识别：

> “这个合法数据包其实已经使用过。”

就可能被利用。

因此现代加密协议除了：

```text
防窃听
防篡改
```

还经常必须考虑：

```text
防重放
```

---

**8. Shadowsocks的根本特点**

Shadowsocks 的安全设计可以概括为：

```text
共享密钥
+
现代AEAD
+
简单代理封装
```

它并没有建立完整的：

```text
TLS PKI
Certificate
Server Certificate Chain
```

系统。

因此双方必须提前知道同一个秘密：

```text
Client
  │
Shared Secret
  │
Server
```

这就是：

```text
Pre-Shared Key
PSK
```

模型。

这种模式非常轻，但也意味着经典 Shadowsocks 并不提供像 TLS 1.3 某些密钥交换模式那样天然的 Forward Secrecy。SIP022 本身也明确说明 Shadowsocks 2022 仍采用预共享密钥、无握手的设计，因此不提供 Forward Secrecy。

它体现的是一种非常鲜明的工程哲学：

> **尽量少做事情，只构建一个快速、轻量、加密的代理通道。**

### ShadowsocksR

ShadowsocksR，也就是：

```text
SSR
```

可以看成是对 Shadowsocks 第一次大规模的：

```text
“协议层扩展”
```

尝试。

Shadowsocks 原本可以粗略表示为：

```text
Proxy Data
    ↓
Encryption
    ↓
TCP / UDP
```

SSR 则试图拆成更多层：

```text
Application
    ↓
Protocol
    ↓
Encryption
    ↓
Obfuscation
    ↓
TCP
```

在现存的 SSR 实现中，可以明显看到三个独立配置：

```text
method
protocol
obfs
```

例如其社区代码中仍存在：

```text
protocol:
auth_sha1_v4
auth_aes128_md5
auth_chain_a
...

obfs:
http_simple
tls1.2_ticket_auth
...
```

也就是说，SSR 不仅选择：

```text
“用什么算法加密”
```

还额外选择：

```text
“如何认证和封装”
```

以及：

```text
“网络流量表面上长什么样”
```

。

---

**1. Protocol层**

SSR 增加的：

```text
protocol
```

层主要试图承担：

```text
用户认证
数据包认证
重放抵抗
协议封装
```

等工作。

也就是说：

```text
Shadowsocks：
Encryption ≈ 很多事情集中在一层

SSR：
Protocol
+
Encryption
+
Obfs
```

开始把功能拆开。

---

**2. Obfs层**

`obfs` 即：

```text
Obfuscation
混淆
```

它解决的不是：

> “别人是否能够解密。”

而是另外一个问题：

> “别人是否能够判断这是一种特殊代理协议。”

这是两个完全不同的问题。

假设一种协议加密以后产生：

```text
高熵随机字节
```

攻击者虽然无法解密：

```text
????
```

但可能发现：

```text
这种连接建立方式
+
包长
+
方向
+
时间关系
+
首包特征
```

和普通 HTTPS 并不一样。

于是可能进行：

```text
Traffic Classification
流量分类
```

SSR 试图通过：

```text
http_simple
tls1.2_ticket_auth
```

等 Obfs 模式，让外部观察者看到的结构更加接近某些普通协议。

但这里也出现了后来的核心问题：

> **“自己模拟HTTP/TLS”远比真正运行HTTP/TLS困难。**

因为真实 TLS 的：

```text
Cipher Suites
Extensions
ALPN
Session Ticket
Key Share
ClientHello顺序
包长度
握手状态机
```

非常复杂。

仅仅：

```text
“看起来有点像TLS”
```

并不一定等于：

```text
“与真实TLS实现难以区分”
```

因此 SSR 代表了一个重要阶段，却也暴露出“自定义混淆协议越来越复杂”的局限。

后面的 Trojan 会提出完全不同的思路：

> **既然模拟 TLS 很难，那为什么不直接使用真正的 TLS？**

### VMess / V2Ray

V2Ray 的出现带来了一个非常重要的变化：

> **代理协议与代理平台开始分离。**

需要严格区分：

```text
VMess
```

和：

```text
V2Ray
```

VMess 是：

```text
一种代理协议
```

V2Ray 则是：

```text
一个可编排多种协议、传输方式和路由逻辑的平台
```

。

---

**1. V2Ray的基本思想**

早期 Shadowsocks 的结构大致是：

```text
SOCKS
↓
Shadowsocks
↓
TCP
```

V2Ray 则更像：

```text
Inbound
   ↓
Routing
   ↓
Proxy Protocol
   ↓
Transport
   ↓
Security
   ↓
Outbound
```

例如：

```text
SOCKS
 ↓
VMess
 ↓
WebSocket
 ↓
TLS
 ↓
TCP
```

或者：

```text
TUN
 ↓
VLESS
 ↓
gRPC
 ↓
TLS
 ↓
TCP
```

于是：

> **代理协议不再必须和底层传输绑定死。**

这成为 V2Ray/Xray 生态此后最重要的设计思想之一。

---

**2. VMess是什么？**

VMess 是 V2Ray 最早的核心加密协议。

客户端与服务器共享：

```text
UUID
```

这个 UUID 相当于：

```text
User Token
```

。

一条 VMess 请求大致可以理解成：

```text
Authentication
+
Command/Header
+
Payload
```

官方 VMess 规范中，现代 AEAD Header 包括加密认证 ID、加密后的 Header 长度、Nonce、加密指令区以及 Data Section。VMess 仍支持历史 MD5 认证格式，但官方已经将其标记为 Deprecated。

---

**3. VMess为什么依赖时间？**

传统 VMess 身份认证中会使用：

```text
UUID
+
Timestamp
```

等信息。

目的是让每一次认证并不是：

```text
永远发送同一个固定Token
```

而形成一个随时间变化的认证结构。

这样可以降低：

```text
简单复制认证数据
↓
以后再次使用
```

的可行性。

但代价就是：

> 客户端和服务器的系统时间不能相差得过于离谱。

这也是后来 VLESS 特意强调：

```text
“不依赖系统时间”
```

的原因之一。VLESS 官方文档明确将这一点列为其与 VMess 的区别。

---

**4. VMess为什么越来越复杂？**

因为 VMess 一度同时承担：

```text
用户认证
+
Header保护
+
Payload加密
+
协议封装
+
Padding
```

等大量职责。

现代 VMess 已经使用 AEAD 来保护协议头，并支持：

```text
AES-128-GCM
ChaCha20-Poly1305
```

等数据加密方式，同时还存在 Metadata Masking、Padding 等设计。

这就形成一个问题：

> 如果外面已经套了一层 TLS，那么 VMess 内部为什么还必须再次完成一整套复杂加密？

例如：

```text
VMess Encryption
      ↓
TLS Encryption
      ↓
TCP
```

实际上发生：

```text
两次协议加密
```

于是 VLESS 后来走向完全相反的方向：

> **代理协议本身尽量简单，把真正的安全交给外层。**

### Trojan

Trojan 的设计思想是整个演进过程中一次非常重要的转折。

此前的思路经常是：

```text
我设计一个代理协议
↓
再努力把它伪装成TLS
```

Trojan 则反过来说：

> **为什么要伪装成 TLS？直接真正使用 TLS 不就行了？**

---

**1. Trojan的基本结构**

Trojan 的数据路径可以理解为：

```text
Application
    ↓
Trojan Request
    ↓
Real TLS
    ↓
TCP
```

客户端首先和服务器完成：

```text
真实TLS Handshake
```

TLS 成功之后，后续 Trojan 协议内容全部位于真正的 TLS Application Data 内。

Trojan 官方协议文档明确规定：客户端首先进行真正的 TLS Handshake；成功之后，后续 Traffic 全部由 TLS 保护。

所以外部看到：

```text
ClientHello
ServerHello
Certificate
TLS Application Data
...
```

这一点与 HTTPS 的基础结构一致。

---

**2. TLS里面装什么？**

TLS 建立以后，客户端发送：

```text
Password Hash
+
CRLF
+
Trojan Request
+
CRLF
+
Payload
```

其中 Trojan Request 与 SOCKS5 请求结构相似：

```text
Command
Destination Address
Destination Port
```

服务器验证密码以后：

```text
客户端
   ↓
TLS
   ↓
Trojan Server
   ↓
Target Server
```

建立转发通道。

所以 Trojan 自己并不需要重新设计：

```text
AES
ChaCha
Nonce
Tag
Certificate
```

这些加密细节。

它把真正的密码学安全交给成熟 TLS 实现。

---

**3. 为什么Trojan是重要的思想变化？**

SSR 的思路可以简化成：

```text
特殊协议
↓
模拟TLS外观
```

Trojan 则是：

```text
特殊协议
↓
真正TLS
```

这其实反映了一种非常重要的设计原则：

> **不要自己模拟成熟协议，尽量复用成熟协议。**

同时 TLS 还天然带来了：

```text
Certificate
Server Authentication
Forward Secrecy
AEAD
成熟密码套件
成熟实现
```

等能力。

---

**4. Fallback**

Trojan 的另一个经典设计是：

```text
如果认证失败
↓
把连接交给普通Web服务
```

也就是说：

```text
正常Trojan客户端
↓
认证成功
↓
Proxy

普通TLS访问 / 无效请求
↓
认证失败
↓
Web Server
```

原始 Trojan 文档明确描述了这种行为：如果 TLS 后的第一段数据不能被识别成合法 Trojan Request，可以把连接交给预设的普通 Web Endpoint。

这意味着：

```text
同一个443端口
```

表面上仍可以表现得像：

```text
正常HTTPS站点
```

。

这种思路后来对 Xray 的：

```text
Fallback
REALITY
```

等设计产生了明显影响。

### VLESS / Xray

VLESS 可以理解成：

> **对 VMess “协议承担太多职责”的一次反思。**

VMess 是：

```text
认证
+
加密
+
代理
```

VLESS 的经典思路则是：

```text
认证
+
代理
```

把：

```text
真正的Transport Security
```

交给：

```text
TLS
REALITY
XTLS
```

等外层机制。

Xray 官方文档将 VLESS 定义为：

```text
Stateless
Lightweight
Transport Protocol
```

并明确指出其认证同样使用 UUID，但不像 VMess 那样依赖系统时间。

---

**1. VLESS为什么可以更轻？**

逻辑上可以表示为：

```text
VLESS
│
├── 用户是谁？
│
├── 要连接哪里？
│
└── 数据是什么？
```

但它并不一定自己解决：

```text
网络加密
```

。

于是：

```text
VLESS
 ↓
TLS / REALITY
 ↓
Transport
```

形成明确分层。

Xray 当前文档仍要求：除非链路本身可信，或者启用了新的 VLESS Encryption，否则 VLESS 应当与外部 Transport Security 一同使用。

因此千万不能理解成：

```text
VLESS = 更先进的VMess加密算法
```

因为经典 VLESS 恰恰相反：

> **它主动减少协议内部的加密职责。**

---

**2. Xray是什么？**

Xray 又不能和 VLESS 混为一谈。

Xray 是：

```text
Proxy Platform / Core
```

VLESS 是：

```text
Protocol
```

REALITY 是：

```text
Transport Security
```

XTLS Vision 是：

```text
Flow / Data Processing Mechanism
```

所以：

```text
Xray
 ├── VMess
 ├── VLESS
 ├── Trojan
 ├── Shadowsocks
 └── ...
```

而某一条具体连接又可能是：

```text
VLESS
+
RAW
+
REALITY
+
XTLS Vision
```

这就是现代代理生态为什么看起来如此复杂：

> 很多名词其实位于完全不同的协议层。

---

**3. XTLS Vision主要解决什么？**

如果外层已经是 TLS：

```text
HTTPS Payload
      ↓
Proxy
      ↓
TLS
```

数据可能经历大量：

```text
用户态读取
解包
复制
重新写入
```

。

XTLS Vision 的一个重要目标，就是尽量减少不必要的数据复制和重复处理。

当前 Xray 文档甚至支持在特定 Linux/TCP 场景中使用：

```text
splice()
```

让 Kernel 直接转发已经加密的数据，减少数据在：

```text
Kernel
↕
User Space
```

之间反复拷贝，从而降低 CPU 和 I/O 开销。

这说明代理技术的优化方向已经从早期：

```text
“怎样设计一个加密协议”
```

发展到：

```text
“怎样减少系统调用和内存复制”
```

这种更加底层的系统性能问题。

### REALITY

REALITY 又是一个很容易被误解的名字。

它不是：

```text
VLESS的替代品
```

也不是：

```text
另一种完整代理协议
```

而主要位于：

```text
Transport Security
```

这一层。

Xray 当前文档对它的描述是：

> REALITY 是 TLS 的一种修改形式，利用目标站点的 TLS 外观和握手特征进行伪装。

所以典型分层是：

```text
VLESS
    ↓
REALITY
    ↓
RAW / XHTTP / gRPC
    ↓
TCP
```

而不是：

```text
VLESS
↓
REALITY
```

二者“二选一”。

---

**1. 为什么已经有TLS还需要REALITY？**

普通 TLS 通常要求服务器拥有：

```text
Domain
+
Certificate
+
Private Key
```

于是你需要：

```text
注册域名
DNS解析
申请证书
运行真实站点
```

。

而且一个自己部署的小型 TLS Server 的：

```text
证书
域名
IP
握手特征
```

本身就形成一种非常明确的服务器身份。

REALITY 试图改变这一点。

它修改 TLS 的部分握手和认证逻辑，使外部观察到的行为能够借用目标网站的一些 TLS 特征，而真正的 REALITY 客户端又可以通过额外的密码学认证判断：

```text
这是真正的REALITY Server
```

还是：

```text
普通目标网站
```

。

---

**2. REALITY仍然依赖TLS思想**

它并没有重新设计一个：

```text
完全独立的密码系统
```

而是在 TLS 基础上改造。

当前 REALITY 实现本身就是对 Go TLS 包的分支修改，服务端和客户端具有专门的证书验证和认证逻辑。

所以它代表的是：

```text
自定义加密协议
        ↓
真实TLS
        ↓
修改TLS握手与身份体系
```

这一条技术演进路线。

---

**3. REALITY为什么通常和VLESS一起出现？**

因为两者非常互补。

VLESS：

```text
轻量代理层
```

REALITY：

```text
外部安全传输层
```

XTLS Vision：

```text
数据处理/性能优化
```

于是组合起来：

```text
Application
    ↓
VLESS
    ↓
XTLS Vision
    ↓
REALITY
    ↓
TCP
```

每一层只解决一部分问题。

这体现了现代代理框架非常明显的趋势：

> **不再做一个“万能协议”，而是把认证、代理、传输、安全、性能优化拆成可以组合的模块。**

### Hysteria / Hysteria 2

Shadowsocks、VMess、Trojan、VLESS 这一整条路线长期主要围绕：

```text
TCP
```

展开。

Hysteria 则换了一个方向：

> **如果网络本身高延迟、高丢包，能不能直接换掉底层传输模型？**

于是它选择：

```text
QUIC
```

。

Hysteria 2 官方协议目前明确规定其运行于标准 QUIC RFC 9000 之上，并使用 QUIC Datagram Extension；它可以承载 TCP 与 UDP Proxy。

---

**1. QUIC不是“UDP裸传输”**

这是理解 Hysteria 最重要的一点。

很多人看到：

```text
QUIC → UDP
```

便认为：

```text
UDP不可靠
所以Hysteria也不可靠
```

这是错误的。

QUIC 实际上：

```text
建立在UDP上
```

但自己实现了：

```text
可靠传输
拥塞控制
重传
流量控制
多路复用
TLS 1.3安全
```

。

可以粗略理解：

```text
TCP + TLS + 多路复用的一部分能力
            ↓
          QUIC
            ↓
           UDP
```

所以 UDP 只是 QUIC 使用的：

```text
底层Datagram Carrier
```

。

---

**2. QUIC为什么对代理很有吸引力？**

如果一个代理使用：

```text
TCP tunnel
```

而 Tunnel 中又承载：

```text
TCP connection
```

就可能出现经典的：

```text
TCP-over-TCP
```

问题。

结构类似：

```text
Inner TCP
   ↓
Outer TCP Tunnel
```

外层 TCP 一旦发生丢包：

```text
Outer TCP等待重传
```

内层 TCP 又可能：

```text
自己判断发生丢包
↓
再次降低窗口
```

两个拥塞控制机制相互影响。

而 QUIC 可以在一个 UDP Connection 内维护：

```text
Stream 1
Stream 2
Stream 3
...
```

不同 Stream 拥有相对独立的传输状态。

某个 Stream 出现丢包，不必像传统单 TCP Byte Stream 那样阻塞所有逻辑流。

因此在：

```text
高延迟
高丢包
不稳定移动网络
```

环境中，它具有明显的架构优势。

---

**3. Hysteria 2中的数据路径**

可以粗略表示为：

```text
Application
    ↓
SOCKS / HTTP / TUN
    ↓
Hysteria 2
    ↓
QUIC Streams / Datagram
    ↓
UDP
```

TCP 类型业务可以映射到：

```text
QUIC Stream
```

UDP 类型业务则可以使用：

```text
QUIC Datagram
```

。

因此 Hysteria 不是：

```text
“把TCP简单装进UDP包”
```

而是：

> **让 QUIC 重新承担一整套传输控制。**

---

**4. 为什么Hysteria强调Congestion Control？**

网络传输速度并不是：

```text
想发多快就发多快
```

而必须遵守：

```text
Congestion Control
```

即：

> 根据网络容量决定发送速率。

TCP 中经典算法会在检测到：

```text
丢包
RTT上升
```

时降低发送速度。

Hysteria 的设计特别关注：

```text
High Bandwidth
+
High Latency
+
Lossy Network
```

环境。

因此它不仅是：

```text
“另一种加密协议”
```

而很大程度上属于：

```text
Transport Optimization
```

。

这也是它和 Shadowsocks/VLESS 最根本的区别之一。

---

**5. Hysteria 2仍然依赖TLS**

Hysteria 2 并没有抛弃成熟密码学体系。

它建立在：

```text
QUIC
```

之上，而 QUIC 本身深度整合 TLS 1.3。

此外 Hysteria 2 还包含认证、HTTP/3 Masquerading 以及可选 Obfuscation 等机制。官方协议明确将：

```text
Authentication
HTTP/3 masquerading
Congestion Control
Salamander / Gecko Obfuscation
```

列为协议组成部分。

因此 Hysteria 代表的是另外一条路线：

```text
Shadowsocks路线：
TCP
+
自定义代理加密

Trojan/VLESS路线：
TCP
+
TLS/REALITY

Hysteria路线：
QUIC
+
TLS
+
Proxy
```

### mieru

mieru 又代表了一次比较有意思的“回归”。

在 Trojan、REALITY、Hysteria 越来越依赖：

```text
TLS
QUIC
HTTP/3
```

的时候，mieru 选择：

> **不依赖 TLS，重新设计自己的加密和流量结构。**

当前 mieru 官方资料说明其同时支持 TCP 和 UDP，并使用：

```text
XChaCha20-Poly1305
```

作为现行 AEAD 算法，同时加入随机 Padding 和 Replay Detection。

---

**1. mieru为什么不用TLS？**

TLS 的优点很多：

```text
成熟
安全
生态完善
```

但它同时具有非常明确的：

```text
TLS Handshake
```

。

例如：

```text
ClientHello
ServerHello
Certificate
EncryptedExtensions
...
```

这意味着：

> TLS 本身就是一种可以被识别的协议。

mieru 的思路则是：

```text
我不希望表现成TLS
```

而希望：

```text
自己的Traffic Pattern难以被稳定分类
```

。

所以它不再采取：

```text
“像HTTPS”
```

的路线，而采取：

```text
“尽量减少固定可分类特征”
```

的路线。

---

**2. mieru如何生成密钥？**

mieru 的协议文档描述了一套基于：

```text
username
+
password
+
system time
```

的密钥派生机制。

逻辑上类似：

```text
username + password
        ↓
      Hash
        ↓
Time-dependent Salt
        ↓
      PBKDF2
        ↓
Session Encryption Key
```

然后用：

```text
XChaCha20-Poly1305
```

执行 AEAD 加密。

所以它与 VLESS 的：

```text
UUID只负责认证
+
安全交给外层
```

完全不同。

mieru 更接近 Shadowsocks：

> **协议自己负责数据加密。**

---

**3. Random Padding的作用**

假设一个协议每次连接的首包永远是：

```text
100 bytes
```

第二包：

```text
64 bytes
```

第三包：

```text
1370 bytes
```

即使所有内容都经过加密：

```text
不可读
```

这个：

```text
Packet Length Pattern
```

本身仍然可能形成特征。

因此 mieru 会插入随机 Padding：

```text
真实数据
+
Random Padding
```

于是：

```text
相同业务
```

在不同连接中的：

```text
Packet Size
```

不必完全一样。

其协议甚至把 Padding 分散在 Metadata 和 Payload 的不同位置，并允许调整传输段的信息熵和可打印字符特征。

这体现了现代流量分析对抗中的一个核心认识：

> **加密隐藏内容，但不自动隐藏形状。**

攻击者仍可能观察：

```text
什么时候连接
持续多久
每个方向多少Byte
Packet长度
Packet间隔
Burst模式
```

。

所以：

```text
Encryption
```

与：

```text
Traffic Obfuscation
```

始终是两个问题。

### 从协议到客户端：为什么现在一个客户端能支持十几种协议？

到这里需要再次强调：

```text
协议
≠
核心程序
≠
GUI客户端
```

例如：

```text
VLESS
```

只是协议。

```text
Xray-core
```

是实现协议并处理网络流量的 Core。

```text
某个Windows GUI
```

则可能只是：

```text
配置界面
+
订阅管理
+
启动Xray-core
+
系统代理设置
```

。

真正执行数据转发的仍然是底层 Core。

现代客户端逐渐形成这样一个架构：

```text
GUI
 ↓
Configuration Manager
 ↓
Proxy Core
 ↓
┌──────────────────────────┐
│ SS / VMess / VLESS       │
│ Trojan / Hysteria / ...  │
└──────────────────────────┘
 ↓
Routing Engine
 ↓
Network
```

于是：

> 客户端的发展已经从“某个协议的专用客户端”，走向“统一流量平台”。

### V2Ray / Xray：协议编排型Core

V2Ray/Xray 的核心优势不只是：

```text
支持VMess/VLESS
```

而是它们具有明显的：

```text
Inbound
→ Routing
→ Outbound
```

模型。

例如：

```text
Browser
   ↓
SOCKS Inbound
   ↓
Routing
   ↓
VLESS Outbound
```

另一类流量可以：

```text
LAN
 ↓
Transparent Inbound
 ↓
Routing
 ↓
Direct
```

所以 Core 真正处理的是：

```text
“流量应该从哪里进来？”
+
“应该采用什么规则？”
+
“应该从哪里出去？”
```

。

这已经比最早的：

```text
ss-local
```

复杂了一个层级。

### sing-box：把“代理工具”进一步变成网络平台

sing-box 的方向更加明显。

它今天支持的 Outbound 已经包括：

```text
Shadowsocks
VMess
VLESS
Trojan
WireGuard
Hysteria
Hysteria2
TUIC
SSH
Tor
Naive
...
```

同时也存在对应的多种 Inbound。

所以 sing-box 的抽象不是：

```text
一个VLESS客户端
```

而是：

```text
Network Proxy Platform
```

。

---

**1. TUN为什么如此重要？**

传统代理模式：

```text
Browser
↓
SOCKS5
↓
Proxy
```

要求 Application 自己支持：

```text
HTTP Proxy / SOCKS
```

。

但很多程序：

```text
游戏
部分系统服务
UDP应用
某些后台进程
```

根本不会读取系统 SOCKS Proxy。

于是现代代理程序大量采用：

```text
TUN
```

。

操作系统看到的是一个：

```text
Virtual Network Interface
```

例如：

```text
tun0
```

系统会认为：

```text
这是一张网卡
```

。

于是：

```text
Application
    ↓
Operating System
    ↓
TUN
    ↓
sing-box
    ↓
Routing
    ↓
Proxy / Direct
```

应用甚至不知道：

```text
自己正在使用代理
```

。

sing-box 当前仍提供完整 TUN Inbound，并可以自动配置 Route、DNS Hijacking 和透明转发等行为。

这就是为什么今天：

```text
“代理客户端”
```

越来越接近：

```text
用户态网络栈
```

而不仅是：

```text
SOCKS5程序
```

。

### Mihomo：从Clash的“规则分流”思想继续发展

Mihomo 的核心特色又和 Xray 不完全一样。

Clash 体系最重要的创新之一，并不是某一种代理协议，而是：

> **把流量策略放在第一位。**

假设设备上同时存在：

```text
Node A
Node B
Node C
DIRECT
```

传统思维是：

```text
我现在选择Node A
```

Clash/Mihomo 的思维则是：

```text
Google
→ Proxy Group A

GitHub
→ Proxy Group B

LAN
→ DIRECT

某些应用
→ Node C
```

于是形成：

```text
Traffic
  ↓
Rule Engine
  ↓
Proxy Group
  ↓
Proxy Node
```

。

---

**1. Proxy Group**

例如一个逻辑组：

```text
Auto
```

内部可以包含：

```text
Node A
Node B
Node C
```

客户端进行：

```text
Health Check
Latency Test
Failure Detection
```

然后自动选择。

Mihomo 当前文档仍提供：

```text
select
url-test
fallback
```

等类型的 Proxy Group，并支持 Health Check。

于是：

```text
协议
```

成为底层能力；

```text
策略
```

反而成为用户真正操作的东西。

---

**2. Proxy Provider**

进一步地：

```text
节点列表
```

甚至可以由：

```text
Provider
```

动态提供。

逻辑上：

```text
Subscription
    ↓
Proxy Provider
    ↓
Node A
Node B
Node C
    ↓
Proxy Group
    ↓
Routing Rule
```

。

Mihomo 当前仍保留完整的 Proxy Provider 体系，并可以从 HTTP、File 等来源加载节点集合。

---

**3. Mihomo为什么能够支持这么多协议？**

因为现代代理 Core 已经把：

```text
Routing
```

与：

```text
Outbound Protocol
```

解耦。

例如：

```text
Rule Engine
    ↓
Proxy A
```

Proxy A 究竟是：

```text
Shadowsocks
VLESS
Trojan
Hysteria2
mieru
```

对上层 Routing Engine 来说并不重要。

Mihomo 当前的 Inbound 类型已经包括 Shadowsocks、VMess、VLESS、Trojan、Hysteria2、Mieru 等，同时提供 TUN、TProxy、Redirect 等流量接入方式。

它甚至已经加入了 mieru 原生支持，包括 TCP/UDP Transport 和 Multiplexing 等能力。

所以现代代理软件越来越像：

```text
模块化网络操作系统
```

。

### 把所有协议重新分层

看完这些协议以后，最容易混乱的地方就在于：

```text
Shadowsocks
VMess
VLESS
Trojan
REALITY
XTLS
Hysteria
Xray
sing-box
Mihomo
```

这些词并不属于同一层。

更加准确的分类应该是：

```text
应用
│
│
├── 浏览器
├── 游戏
├── Git
└── 其他程序
│
↓
流量接入层
│
├── SOCKS5
├── HTTP Proxy
├── TUN
├── TProxy
└── Redirect
│
↓
代理协议层
│
├── Shadowsocks
├── VMess
├── VLESS
├── Trojan
├── Hysteria2
└── mieru
│
↓
传输/封装层
│
├── RAW TCP
├── WebSocket
├── gRPC
├── HTTP
├── XHTTP
└── QUIC
│
↓
安全层
│
├── Shadowsocks AEAD
├── VMess AEAD
├── TLS
├── REALITY
└── mieru AEAD
│
↓
TCP / UDP
│
↓
IP
```

而：

```text
V2Ray
Xray
sing-box
Mihomo
```

则是：

```text
把这些组件组织起来的Core
```

。

因此不能简单地问：

> “REALITY 和 VLESS 哪个更好？”

因为它们甚至不是一类东西。

更像是在问：

> “HTTPS 和 HTTP 哪个更好？”

正确关系是：

```text
VLESS
+
REALITY
```

。

同理：

```text
VLESS
+
gRPC
+
TLS
```

也是一个组合。

### 这些协议的技术路线究竟是怎样演进的？

如果只看名字，会觉得：

```text
SS
SSR
VMess
Trojan
VLESS
REALITY
Hysteria
mieru
```

非常杂乱。

但如果从设计问题看，其实演进路线非常清晰。

最初的问题是：

```text
如何建立一个简单加密代理？
```

于是有：

```text
Shadowsocks
```

它的答案是：

> **SOCKS式代理 + 对称加密。**

随后出现：

```text
如何抵抗流量识别？
```

于是 SSR 的答案是：

> **在加密之外再加入Protocol与Obfuscation。**

但新的问题出现：

```text
自己模拟HTTP/TLS越来越复杂。
```

于是 Trojan 回答：

> **不要模拟TLS，直接运行真正的TLS。**

与此同时 V2Ray 提出另外一个问题：

```text
为什么代理协议、传输协议和路由策略必须绑在一起？
```

答案是：

> **全部模块化。**

于是出现：

```text
VMess
+
WS
+
TLS
```

各种组合。

随后人们发现：

```text
VMess自己承担的加密和认证职责仍然太重。
```

于是 VLESS 回答：

> **代理层做轻，把安全交给TLS/REALITY。**

REALITY 又进一步问：

```text
能不能保留TLS级别的安全和外观，
但改变传统证书/站点部署模式？
```

于是产生新的 TLS Transport Security 设计。

另一边 Hysteria 则问：

```text
如果问题根本不是协议识别，
而是网络高延迟、高丢包怎么办？
```

于是：

> **直接转向QUIC和新的拥塞控制。**

mieru 又重新问：

```text
是否一定要表现成TLS/HTTPS？
```

它给出的答案是：

> **不依赖TLS，通过自己的AEAD、Padding和流量结构降低分类特征。**

所以真正的演进其实是：

```text
Shadowsocks
│
│ 重点：加密
↓
SSR
│
│ 重点：加密 + 混淆
↓
V2Ray / VMess
│
│ 重点：模块化代理平台
↓
Trojan
│
│ 重点：真正TLS
↓
VLESS / Xray
│
│ 重点：协议轻量化、职责分离
↓
REALITY
│
│ 重点：重新设计TLS式传输安全与外观
↓
Hysteria2
│
│ 重点：QUIC和弱网络性能
↓
mieru
│
│ 重点：非TLS路线 + AEAD + Traffic Pattern控制
```

它不是简单的：

```text
新协议性能 > 旧协议性能
```

而是每一代都在重新回答几个不同问题：

```text
怎么加密？
怎么认证？
怎么发现恶意连接？
怎么隐藏协议特征？
怎么降低延迟？
怎么抗丢包？
怎么减少CPU开销？
怎么支持UDP？
怎么让一个Core支持十种协议？
```

### 加密、混淆和匿名必须严格区分

最后还需要澄清一个非常重要的问题。

这些技术经常被统称为：

```text
“加密代理”
```

但：

```text
Encryption
Obfuscation
Anonymity
```

实际上是三件完全不同的事情。

**Encryption：**

解决：

> 别人能不能读懂通信内容？

例如：

```text
AES-GCM
ChaCha20-Poly1305
TLS
```

。

---

**Obfuscation：**

解决：

> 别人能不能判断你运行的是什么协议？

例如：

```text
Padding
TLS-like traffic
HTTP-like traffic
REALITY
某些随机化机制
```

。

---

**Anonymity：**

解决：

> 对方能不能知道通信者是谁？

而一个普通单跳 Proxy：

```text
User
 ↓
Proxy
 ↓
Website
```

并没有解决完整匿名问题。

Proxy Server 至少可能知道：

```text
客户端IP
连接时间
流量大小
部分目标信息
```

。

网站则看到：

```text
Proxy Server IP
```

而不是用户原始 IP。

所以单跳代理本质上更接近：

```text
Encrypted Proxy
```

而不是：

```text
Anonymous Network
```

。

Tor 那种：

```text
Client
 ↓
Entry
 ↓
Relay
 ↓
Exit
 ↓
Destination
```

才是在完全不同的架构层面处理匿名问题。

### 节点到底能看到什么？

这也可以补充你前面“碎碎念”中的判断。

假设：

```text
User
 ↓
Encrypted Proxy Tunnel
 ↓
Proxy Server
 ↓
HTTPS Website
```

本地 ISP 通常能够看到：

```text
User IP
↓
正在连接某个Proxy IP
↓
时间
流量大小
协议特征
```

但因为代理隧道加密：

```text
通常看不到最终应用数据
```

。

Proxy Server 则知道更多：

```text
User IP
连接时间
连接大小
目的地址相关信息
```

。

但是如果内部应用本身仍然是：

```text
HTTPS
```

那么：

```text
HTTP正文
Cookie内容
密码
页面数据
```

通常仍由：

```text
Browser
↔
Website
```

之间的 TLS 保护。

可以把它想象成：

```text
HTTPS ciphertext
        ↓
再装进Proxy ciphertext
```

到了 Proxy：

```text
拆掉Proxy Encryption
↓
仍然剩HTTPS ciphertext
```

。

因此：

> **代理服务器被攻破，并不自动等于所有 HTTPS 内容都变成明文。**

但是攻击者仍然可能获得大量重要的：

```text
Metadata
Traffic Log
DNS信息
目标IP
访问时间
账户与节点对应关系
```

并且如果客户端忽略：

```text
Certificate Validation
```

或者安装了恶意根证书，情况又会完全不同。

所以更加准确的安全模型是：

```text
安全性
=
协议密码学
×
客户端实现
×
服务器可信度
×
密钥安全
×
目标网站HTTPS
×
DNS安全
×
操作系统安全
```

而绝不是：

```text
“用了REALITY”
=
绝对安全
```

或者：

```text
“用了AES-256”
=
绝对安全
```

。

一套现代代理连接实际上是一条很长的信任链：

```text
Application
   ↓
Operating System
   ↓
Proxy Client
   ↓
Protocol Implementation
   ↓
Encryption Keys
   ↓
Proxy Server
   ↓
DNS / Routing
   ↓
Target TLS
   ↓
Target Website
```

其中任何一个环节发生：

```text
恶意软件
密钥泄露
客户端后门
服务器入侵
TLS证书验证关闭
错误DNS
错误路由
```

都可能改变最终安全性。

这也解释了为什么过去十多年中代理协议不断变化，但一个最基本的原则始终没有变化：

> **真正的安全从来不是“找到一种神奇协议”，而是明确每一层在保护什么、信任谁，以及哪一部分仍然暴露。**


## P2P与磁力链接(AI版)

今天人们提到 P2P，最容易联想到的往往是：

```text
BT下载
磁力链接
种子文件
迅雷
qBittorrent
```

但从计算机网络的角度来看，P2P 的意义远比“下载文件”更加基础。

传统互联网服务通常采用：

```text
Client
   ↓
Server
```

即：

> **服务器提供资源，客户端消费资源。**

P2P，即 **Peer-to-Peer，对等网络**，则试图改变这种关系：

```text
Peer A ↔ Peer B
  ↕        ↕
Peer C ↔ Peer D
```

网络中的一台计算机既可以是：

```text
Client
```

也可以同时是：

```text
Server
```

因此更加准确地说：

> **P2P 并不是一种具体协议，而是一种分布式网络组织方式。**

BitTorrent 是 P2P 思想最成功的实现之一；`.torrent` 种子文件是描述 BitTorrent 内容的一种元数据文件；磁力链接则进一步把“如何获得这份元数据”本身也进行了去中心化。

理解磁力链接最重要的一个问题是：

> 为什么只有几十个字符的一串哈希值，竟然能够最终找到一部几十 GB 的文件？

要回答这个问题，就必须从 P2P 本身开始。

### 从Client-Server到P2P

传统文件下载非常容易理解。

假设服务器拥有：

```text
movie.iso
10 GB
```

1000 个用户同时下载。

结构是：

```text
                Server
                  │
        ┌─────────┼─────────┐
        ↓         ↓         ↓
     Client1   Client2   Client3
        ...
        ↓
     Client1000
```

每个用户都只能从服务器获得数据。

如果：

```text
文件大小 = 10 GB
1000个人下载
```

那么服务器理论上至少需要向外发送：

```text
10 GB × 1000
=
10 TB
```

的数据。

用户越多：

```text
服务器压力越大
```

因此传统 Client-Server 分发有一个天然特点：

> **需求增长会给中心服务器带来更大的带宽压力。**

---

P2P 则反过来思考这个问题。

既然 Client 1 已经从服务器下载了：

```text
文件的第1部分
```

Client 2 下载了：

```text
文件的第2部分
```

那么为什么他们不能彼此交换？

于是结构变成：

```text
               初始发布者
                   │
             ┌─────┴─────┐
             ↓           ↓
          Peer A       Peer B
             ↘         ↙
               Peer C
              ↙      ↘
          Peer D      Peer E
```

Peer A 从发布者那里获得了一部分以后，可以立刻把这一部分上传给 Peer C。

Peer C 随后又可以上传给 Peer D。

于是产生一个非常重要的效果：

```text
下载者越多
    ↓
同时参与上传的人也可能越多
    ↓
整个网络可以获得更多总上传带宽
```

这与传统服务器模型形成鲜明对比。

传统模型：

```text
用户越多
↓
服务器越累
```

理想化的 P2P 模型：

```text
用户越多
↓
潜在上传节点也越多
↓
整个Swarm容量可能同步增加
```

BitTorrent 官方协议说明也将这一点视为其核心优势：多个用户同时下载同一内容时，下载者也相互上传，从而使原始发布源在只增加有限负载的情况下服务大量下载者。

这就是 P2P 最重要的工程价值：

> **把原本集中在服务器上的带宽资源分散到整个用户网络中。**

### 早期P2P：从Napster到Gnutella

P2P 并不是 BitTorrent 首先提出的。

1990 年代末至 2000 年代初，互联网已经出现大量文件共享系统。

其中一个著名例子是：

```text
Napster
```

Napster 使用的是一种混合架构。

文件本身存在用户计算机上：

```text
Peer A：Song A
Peer B：Song B
Peer C：Song C
```

但：

> 哪个用户拥有什么文件？

需要中央服务器记录。

因此结构大致是：

```text
               Central Index
             /      |      \
          Peer A  Peer B  Peer C
```

用户首先询问：

```text
“谁有Song A？”
```

中央服务器回答：

```text
“Peer A有。”
```

之后：

```text
Peer B ↔ Peer A
```

直接传输文件。

所以 Napster 并不是完全中心化，也不是完全去中心化，而是：

```text
资源传输
→ P2P

资源索引
→ 中心化
```

这种设计非常简单高效，但也存在明显弱点：

> **中央索引服务器是单点。**

只要中央服务器消失，Peer 之间就很难发现彼此。

---

之后出现的 Gnutella 则尝试更加彻底的去中心化。

它不使用一个统一中央目录，而是让节点互相询问：

```text
A：
谁有X？

↓广播

B、C、D

↓继续传播

E、F、G……
```

这类方法解决了中央服务器问题，却引入另外一个严重问题：

```text
Flooding
泛洪
```

如果每个查询不断扩散：

```text
1
↓
10
↓
100
↓
1000
```

网络中的控制消息数量会迅速增长。

因此早期 P2P 面临一个核心难题：

> **既不能依赖一个中央服务器，又不能让所有节点毫无目的地询问整个互联网。**

BitTorrent 后来的 DHT，实际上就是这个问题的一种非常重要的解决方案。

### BitTorrent的出现：P2P不再传“整个文件”

2001 年，Bram Cohen 设计 BitTorrent 协议。BitTorrent 官方历史资料同样将其起点追溯到 2001 年。

BitTorrent 最重要的设计，并不是：

> 让 A 把完整文件传给 B。

而是：

> **把文件切成大量 Piece，让很多节点同时交换不同 Piece。**

假设一个文件：

```text
8 GB
```

可以逻辑上切成：

```text
Piece 0
Piece 1
Piece 2
Piece 3
...
Piece 32767
```

于是：

```text
Peer A
拥有：
0 1 4 8

Peer B
拥有：
2 3 4 7

Peer C
拥有：
0 5 6 9
```

它们可以同时交换：

```text
A → B：Piece 1

B → C：Piece 3

C → A：Piece 5
```

这就是 BitTorrent 真正的核心。

不是：

```text
Server
↓
完整文件
↓
Client
```

而是：

```text
大量Piece
      ↓
散布在大量Peer中
      ↓
Peer彼此拼装出完整文件
```

BitTorrent 协议把参与同一 Torrent 的所有 Peer 称为一个：

```text
Swarm
```

即：

> **群集。**

例如：

```text
               Torrent X

     ┌──────────Swarm──────────┐
     │                         │
   Peer A ←→ Peer B ←→ Peer C
     ↕         ↕         ↕
   Peer D ←→ Peer E ←→ Peer F
     │                         │
     └─────────────────────────┘
```

只要 Swarm 中不同节点合起来仍然拥有完整数据，就不一定要求某一个特定服务器持续提供整个文件。

### 一个.torrent种子文件究竟是什么？

这是理解磁力链接之前最重要的一步。

很多人会把：

```text
xxx.torrent
```

理解成：

> “一个很小的下载文件。”

实际上：

> **`.torrent` 并不包含真正要下载的大文件。**

它只是一个：

```text
Metainfo File
元数据文件
```

也就是：

> 描述目标内容的信息。

BitTorrent 使用一种叫：

```text
Bencode
```

的编码格式保存 `.torrent`。

经典 BitTorrent v1 的 `.torrent` 文件中通常包含：

```text
announce
info
```

其中 `announce` 可以记录 Tracker 地址，而 `info` 字典中保存名称、文件长度、Piece 大小和各 Piece 的哈希等信息。BitTorrent v1 规范明确规定 `.torrent` 是一个 Bencode 字典，并通过 `piece length` 和 `pieces` 描述文件分片；其中每个 Piece 对应一个 20 字节 SHA-1 哈希。

可以简化成：

```text
Torrent Metadata
│
├── 文件名
├── 文件大小
├── Piece大小
├── Piece 0 Hash
├── Piece 1 Hash
├── Piece 2 Hash
├── ...
└── Tracker地址
```

例如：

```text
ubuntu.iso

大小：
4 GB

Piece Length：
1 MB

Pieces：
0 → hash_A
1 → hash_B
2 → hash_C
...
```

所以 `.torrent` 真正告诉客户端的是：

> 我要下载一个什么结构的数据，以及每一块正确的数据应该长什么样。

### Piece Hash为什么如此重要？

假设 Peer B 给你发送：

```text
Piece 567
```

你怎么知道：

> Peer B 没有发送错误数据？

BitTorrent 并不要求你“相信 Peer B”。

客户端下载这一 Piece 后：

```text
Piece 567
     ↓
计算SHA-1
     ↓
hash = ABCDEF...
```

再与 `.torrent` 中保存的：

```text
Piece 567 Hash
=
ABCDEF...
```

比较。

相同：

```text
✓ Piece有效
```

不同：

```text
✗ 丢弃
```

因此 BitTorrent 的数据验证思想实际上是：

```text
不信任来源
↓
信任密码学哈希
```

这一点极其重要。

因为在 P2P 网络中：

```text
Peer可能来自世界任何地方
```

你不知道：

```text
它是谁
它是否可靠
它是否恶意
```

但是只要你已经拥有可信的 Torrent Metadata，就能够验证 Peer 发给你的每一个 Piece。

这也是哈希在 P2P 中承担的核心作用之一：

> **内容完整性验证。**

### Info Hash：Torrent真正的身份证

进一步考虑一个问题。

如果一个 `.torrent` 文件本身也需要一个唯一 ID，该怎么办？

BitTorrent v1 会取 `.torrent` 中最核心的：

```text
info dictionary
```

然后：

```text
Bencode(info)
       ↓
     SHA-1
       ↓
    Info Hash
```

BitTorrent v1 规范把 `info_hash` 定义为 `.torrent` 中 Bencode 后 `info` 值的 20 字节 SHA-1 哈希。

于是：

```text
Info Hash
```

就成为：

> **这个 Torrent 内容集合的身份证。**

例如：

```text
A1B2C3D4E5...
```

不是：

```text
服务器地址
```

不是：

```text
文件路径
```

也不是：

```text
下载网址
```

而是：

> “我寻找的是具有这一特定元数据哈希的 Torrent。”

这个思维变化非常重要。

传统 URL：

```text
https://example.com/file.iso
```

实际上回答：

> 文件在哪里？

核心是：

```text
Location
位置
```

而 Info Hash 回答：

> 我要找的内容是什么？

核心是：

```text
Identity
身份
```

这正是磁力链接能够成立的基础。

### Tracker：最早的Peer发现机制

现在客户端已经知道：

```text
Info Hash
```

也知道：

```text
Piece Hash
```

但还存在一个关键问题：

> **去哪里找拥有这些 Piece 的其他 Peer？**

最早的 BitTorrent 主要依赖：

```text
Tracker
```

Tracker 本身通常并不保存真正的文件。

它做的事情非常简单：

> **维护某个 Torrent 当前有哪些 Peer。**

结构类似：

```text
                     Tracker
                        │
     ┌──────────────────┼──────────────────┐
     ↓                  ↓                  ↓
Peer A               Peer B             Peer C
```

客户端下载 `.torrent` 后看到：

```text
announce:
https://tracker.example.com/announce
```

于是向 Tracker 发送：

```text
我的Info Hash是：
ABC...

我的IP/Port是：
1.2.3.4:6881

我正在参与这个Torrent
```

Tracker 返回：

```text
Peer A
5.6.7.8:6881

Peer B
9.10.11.12:51413

Peer C
...
```

客户端随后：

```text
Client
  │
  ├────→ Peer A
  ├────→ Peer B
  └────→ Peer C
```

直接进行 BitTorrent 连接。

因此必须明确：

```text
Tracker
≠
文件服务器
```

Tracker 更接近：

```text
通讯录
```

或者：

```text
Peer Directory
```

它告诉你：

> 谁可能拥有这个 Torrent。

真正的数据通常仍然是：

```text
Peer ↔ Peer
```

直接传输。

### Peer之间到底如何交换数据？

客户端找到 Peer 后，会执行 BitTorrent：

```text
Peer Wire Protocol
```

首先进行 Handshake。

其中会携带：

```text
Info Hash
Peer ID
```

双方确认：

> 我们谈论的是同一个 Torrent。

BitTorrent v1 的 Handshake 就包含目标 Torrent 的 20 字节 `info_hash`，随后是 Peer ID；若双方目标 Hash 不匹配，就不会继续该 Torrent 会话。

连接建立以后，Peer 会交换自己拥有哪些 Piece。

例如 Peer A：

```text
Piece:
0 1 4 6 8
```

可以编码成一个：

```text
Bitfield
```

例如：

```text
110010101...
```

其中：

```text
1 = 我拥有这个Piece
0 = 我没有
```

Peer B 收到以后就知道：

```text
Peer A有什么
```

协议中存在一些很直观的消息：

```text
have
bitfield
interested
not interested
choke
unchoke
request
piece
cancel
```

官方协议规范中也定义了这些 Peer Message。

于是一个下载过程可能是：

```text
A → B：
bitfield
“我有0、1、4、6、8”

B → A：
interested
“你有我需要的数据”

A → B：
unchoke
“允许你请求”

B → A：
request Piece 6的一部分

A → B：
piece

B：
计算Hash
↓
验证成功
↓
保存
↓
向其他Peer宣布have Piece 6
```

所以：

> **下载和上传实际上在持续同时发生。**

### Piece与Block：文件还会进一步切小

BitTorrent 并不一定一次请求一个完整 Piece。

例如：

```text
Piece = 4 MB
```

网络传输时还会切成更小的：

```text
Block
```

经典 Peer Wire Protocol 中，`request` 指定：

```text
index
begin
length
```

也就是：

```text
哪个Piece
+
从哪里开始
+
请求多少字节
```

规范描述的传统实现通常使用 16 KiB 的请求块。

所以真正结构更接近：

```text
File
 ↓
Piece
 ↓
Block
```

例如：

```text
File

├── Piece 0
│   ├── Block 0
│   ├── Block 1
│   └── ...
│
├── Piece 1
│   ├── Block 0
│   ├── Block 1
│   └── ...
```

这样做的好处是可以：

```text
并行请求
流水线传输
更细粒度调度
```

### 为什么BT可以同时从很多人那里下载？

假设：

```text
Peer A有Piece 1
Peer B有Piece 2
Peer C有Piece 3
Peer D有Piece 4
```

客户端下载时不需要：

```text
先从A下完整个文件
```

而可以：

```text
A ──Piece1──┐
B ──Piece2──┤
C ──Piece3──┼→ Client
D ──Piece4──┘
```

理论上总下载速度就可以接近：

```text
A可提供速度
+
B可提供速度
+
C可提供速度
+
D可提供速度
```

当然实际还受到：

```text
本地带宽
Peer上传速度
连接数量
TCP/uTP拥塞控制
磁盘性能
Piece调度
NAT
ISP策略
```

等因素影响。

但这是 BitTorrent 与单服务器下载最大的结构差异。

### Choke与Unchoke：为什么大家愿意上传？

如果每个 Peer 都想：

```text
只下载
不上传
```

P2P 网络很快就会失效。

因此 BitTorrent 引入：

```text
Choking Algorithm
```

基本思想是：

> 优先为能够给自己带来较好交换效果的 Peer 提供上传机会。

协议具有：

```text
choke
unchoke
```

两种状态。

简单理解：

```text
unchoke
→
允许你向我请求数据

choke
→
暂时不给你上传
```

经典 BitTorrent 的算法具有明显的：

```text
Tit-for-Tat-ish
```

思想：

> 如果某个 Peer 能较好地向我提供数据，我通常也更愿意给它提供数据。

但它又不是严格的：

```text
你给我1MB
我必须给你1MB
```

而会周期性执行：

```text
Optimistic Unchoking
```

即：

> 偶尔随机尝试一个还没有建立良好交换关系的 Peer。

这样可以发现：

```text
潜在更高速的新Peer
```

同时也让刚进入 Swarm、暂时还没有 Piece 可交换的新节点获得起步机会。

BitTorrent 协议本身也说明 Choking 一方面用于控制并发上传、改善 TCP 表现，另一方面支持一种近似 tit-for-tat 的互惠策略，并通过 optimistic unchoking 探测新的连接。

因此 BitTorrent 不仅仅是一套网络协议，还隐含了一种：

> **分布式资源激励机制。**

### 为什么最后几个Piece有时特别难下？

假设一个文件有：

```text
1000 Pieces
```

你已经获得：

```text
999 Pieces
```

只差：

```text
Piece 734
```

但是恰好只有一个很慢的 Peer 拥有它。

那么：

```text
99.9%
```

可能长时间无法完成。

BitTorrent 因此设计了：

```text
Endgame Mode
```

在下载接近完成时，客户端可能向多个 Peer 同时请求尚未完成的 Block。

谁先返回：

```text
接受
```

其他重复请求：

```text
cancel
```

这样可以避免整个 Torrent 被最后一个慢 Peer 拖住。

这也是为什么 Peer Wire Protocol 里会专门存在：

```text
cancel
```

消息。

### Tracker的问题：去中心化还不彻底

到这里会发现一个明显矛盾。

BitTorrent 的文件传输虽然已经：

```text
Peer ↔ Peer
```

但是 Peer 发现仍然依赖：

```text
Tracker
```

如果 Tracker：

```text
关闭
宕机
被封锁
域名失效
```

那么客户端可能知道：

```text
我要Torrent X
```

却不知道：

```text
谁在下载Torrent X
```

于是 BitTorrent 的下一步演化就是：

> **连Tracker也去掉。**

这便引出了：

```text
DHT
Distributed Hash Table
分布式哈希表
```

### DHT：把Tracker拆散到整个网络

BitTorrent DHT 基于：

```text
Kademlia
```

思想，并通过 UDP 工作。BEP 5 将其描述为一种用于 Trackerless Torrent 的“distributed sloppy hash table”，DHT 中保存 Peer 联系信息，使各 BitTorrent 客户端本身也成为 DHT 节点。

理解 DHT 最关键的是：

> **DHT通常不是用来存真正的大文件。**

它主要回答：

```text
给定Info Hash
↓
哪些Peer可能正在参与这个Torrent？
```

也就是把：

```text
Tracker：
Info Hash → Peer List
```

变成：

```text
整个DHT网络：
Info Hash → Peer List
```

---

传统 Hash Table 可以想象成：

```text
Key              Value

ABC123       →   Peer A
DEF456       →   Peer B
```

但是普通 Hash Table 存在一台服务器内。

DHT 要解决：

> 如果没有中央服务器，这张表存在哪里？

答案是：

> **分散存储在大量节点上。**

### Kademlia的核心：XOR距离

BitTorrent DHT 中，每个节点拥有：

```text
Node ID
```

经典 BitTorrent DHT 使用一个 160 位 ID 空间；Info Hash 也处在同一个空间中。节点之间通过 XOR 衡量“距离”。BEP 5 定义：

```text
distance(A,B) = A XOR B
```

结果越小，就认为两者越“接近”。

注意：

> 这里的“接近”不是物理距离。

不是：

```text
东京
离
大阪
多远
```

而是：

```text
二进制ID
之间
数学意义上的距离
```

例如：

```text
Node A ID
001101...

Node B ID
001111...

XOR
000010...
```

结果很小：

```text
→ 比较接近
```

因此整个 DHT 可以把巨大数量的节点组织进一个：

```text
逻辑地址空间
```

### DHT如何找到某个Torrent的Peer？

假设你拥有：

```text
Info Hash = H
```

你不需要询问全世界所有节点：

```text
“谁知道H？”
```

而是：

1. 查看自己的 Routing Table；
2. 找出 Node ID 与 H 比较接近的节点；
3. 向它们发送 `get_peers(H)`；
4. 对方如果知道 Peer，直接返回；
5. 如果不知道，就告诉你“我认识几个比我更接近 H 的节点”；
6. 继续询问那些更接近 H 的节点；
7. 不断逼近目标。

过程类似：

```text
你
│
↓
Node A
“我不知道，但问B/C/D”
│
↓
Node C
“我不知道，但问E/F”
│
↓
Node F
“我知道：
Peer X
Peer Y”
```

BEP 5 对这一过程的描述就是：节点首先询问自己已知的、ID 最接近目标 Info Hash 的节点；若目标节点没有 Peer 信息，就返回更接近该 Info Hash 的节点，如此迭代直到无法继续逼近。

DHT 中对应的关键 RPC 包括：

```text
ping
find_node
get_peers
announce_peer
```

其中：

```text
get_peers(info_hash)
```

查询：

> 谁正在参与这个 Torrent？

而：

```text
announce_peer(info_hash)
```

意味着：

> 我也是这个 Torrent 的 Peer，你们可以把我的地址告诉别人。

BEP 5 对 `get_peers` 和 `announce_peer` 的行为作出了明确规定。

于是：

```text
Tracker
```

原本承担的目录功能，被拆散到了：

```text
成千上万甚至更多DHT节点
```

之中。

### DHT为什么不会变成全网广播？

这是 Kademlia 与早期 Gnutella 泛洪的重要区别。

Gnutella 式搜索可能接近：

```text
问所有邻居
↓
邻居继续问所有邻居
↓
大量消息爆炸
```

而 DHT 更接近：

```text
我知道目标ID在某个方向
↓
每轮都寻找“更接近”的节点
↓
不断缩小搜索范围
```

所以它不是：

```text
盲目扩散
```

而是：

```text
按哈希空间导航
```

这就是 DHT 能够在大规模去中心化网络中保持可用的重要原因。

### PEX：Peer也可以互相介绍Peer

即使有 Tracker 和 DHT，BitTorrent 还进一步发展出了：

```text
PEX
Peer Exchange
```

基本思想极其简单。

假设：

```text
A认识：
B C D

B认识：
A E F
```

那么 A 和 B 建立连接以后：

```text
B可以告诉A：
“我还认识E和F。”
```

于是：

```text
A
↓
B
↓
获得E/F
```

Peer 本身也成为：

```text
Peer Directory的一部分
```

BEP 11 将 PEX 定义为 Swarm 在已经通过 DHT 或 Tracker 等方式完成初始启动之后的一种额外 Peer Discovery 机制，可以提供更加及时的 Swarm 视图并降低反复查询其他来源的需要。

因此现代 BitTorrent 客户端发现 Peer 往往并不是只有一种方式，而可能同时使用：

```text
Tracker
+
DHT
+
PEX
+
本地Peer发现
```

这提高了网络韧性。

### 磁力链接为什么会出现？

传统 BitTorrent 有一个仍然没有解决的问题：

```text
你首先需要得到.torrent文件
```

流程是：

```text
网站
 ↓
下载xxx.torrent
 ↓
打开Torrent
 ↓
读取Info Hash
 ↓
找Tracker / DHT
 ↓
找Peers
 ↓
下载文件
```

那么问题来了：

> 既然真正识别 Torrent 的核心是 Info Hash，为什么还必须先下载 `.torrent`？

于是磁力链接出现了。

典型 Magnet URI：

```text
magnet:?xt=urn:btih:INFO_HASH
```

例如：

```text
magnet:?xt=urn:btih:
0123456789ABCDEF...
```

这里真正关键的是：

```text
xt
```

即：

```text
Exact Topic
```

对于经典 BitTorrent v1：

```text
urn:btih:
```

表示：

```text
BitTorrent Info Hash
```

因此：

```text
magnet:?xt=urn:btih:ABC...
```

真正表达的不是：

> 去某个服务器下载某个文件。

而是：

> **我要寻找 Info Hash 为 ABC…… 的 BitTorrent 内容。**

BEP 9 给出的 Magnet URI v1 形式就是：

```text
magnet:?xt=urn:btih:<info-hash>
```

并允许附加 `dn`、`tr`、`x.pe` 等可选参数；其中真正必须存在的是 `xt`。

### URL与磁力链接在思想上有什么区别？

普通 URL：

```text
https://server.com/files/movie.mkv
```

实际上表达：

```text
协议：
HTTPS

服务器：
server.com

路径：
/files/movie.mkv
```

核心思想是：

> **Location Addressing**
>
> 按位置寻址。

即：

```text
“去这里找文件。”
```

磁力链接则是：

```text
magnet:?xt=urn:btih:HASH
```

没有要求：

```text
Server A
```

也没有要求：

```text
/path/movie.mkv
```

它表达：

> **Content Addressing**
>
> 按内容身份寻址。

也就是：

```text
“我要的是这个东西，
至于从谁那里拿，无所谓。”
```

这一思想后来在很多分布式系统中都非常重要。

可以形象理解：

传统 URL 像：

> “我要北京市某仓库3号货架上的《某书》。”

磁力链接更像：

> “我要 ISBN 为 XXXXX 的这本书，谁有都可以。”

前者强调：

```text
Where
```

后者强调：

```text
What
```

### 点击磁力链接后究竟发生了什么？

这是整个原理中最重要的一段。

假设你点击：

```text
magnet:?xt=urn:btih:ABCDEF...
```

客户端一开始实际上只知道：

```text
Info Hash = ABCDEF...
```

它甚至可能不知道：

```text
文件名
文件数量
文件大小
Piece数量
Piece Hash
```

因此它还不能真正开始下载文件。

整个过程大致是：

```text
Magnet
↓
Info Hash
↓
找Peer
↓
从Peer获取Torrent Metadata
↓
验证Metadata
↓
知道文件结构和Piece Hash
↓
下载Piece
↓
验证Piece
↓
重组文件
```

逐步来看：

**第一步：解析磁力链接**

客户端读取：

```text
xt = Info Hash
```

可能还会读取：

```text
dn
```

即 Display Name；

以及：

```text
tr
```

即 Tracker 地址。

例如：

```text
magnet:?
xt=urn:btih:ABC...
&
dn=example
&
tr=udp://tracker.example.com
```

但：

```text
dn
tr
```

都不是磁力下载最核心的部分。

---

**第二步：寻找Peer**

如果 Magnet 中包含 Tracker：

```text
tr=
```

客户端可以直接联系 Tracker。

如果没有：

```text
客户端通常可以通过DHT查询Info Hash
```

BEP 9 明确指出，当 Magnet 没有指定 Tracker 时，客户端应使用 DHT 获取 Peer。

于是：

```text
Info Hash
↓
DHT
↓
Peer A
Peer B
Peer C
```

---

**第三步：连接Peer**

客户端通过 BitTorrent Handshake 告诉对方：

```text
我要讨论的Torrent
Info Hash = ABC...
```

如果对方也参与这个 Torrent：

```text
连接继续
```

---

**第四步：请求Metadata**

这里出现一个重要扩展：

```text
BEP 10
Extension Protocol
```

它允许 BitTorrent 在原协议之上协商新扩展。

其中非常重要的一个扩展就是：

```text
ut_metadata
```

由 BEP 9 定义。

Peer 可以直接把：

```text
Torrent Metadata
```

传给客户端。

Metadata 本身也会分片传输，BEP 9 规定普通 Metadata Piece 为 16 KiB，最后一块可以更短。

也就是说：

```text
你甚至不需要从网站下载.torrent
```

因为：

> **其他Peer本身就可以把Torrent Metadata发给你。**

---

**第五步：验证Metadata**

但是 Peer 是陌生人。

它完全可能发给你一个假的：

```text
Torrent Metadata
```

怎么办？

这就是 Magnet 中 Info Hash 的真正力量。

客户端收到 Metadata：

```text
info dictionary
```

然后计算：

```text
SHA-1(
Bencode(info)
)
```

得到：

```text
XYZ...
```

与 Magnet 中的：

```text
ABC...
```

比较。

如果：

```text
XYZ != ABC
```

说明：

```text
Metadata是假的
→ 丢弃
```

如果：

```text
XYZ == ABC
```

那么在哈希安全假设成立的前提下，可以认为：

```text
这就是Magnet所指向的Metadata
```

于是你终于知道：

```text
文件名
文件大小
目录结构
Piece Length
所有Piece Hash
```

---

**第六步：正式开始下载**

之后整个 Magnet 下载就退化成普通 BitTorrent 下载：

```text
询问Peer拥有哪些Piece
↓
请求Block
↓
组合Piece
↓
计算Piece Hash
↓
验证
↓
保存
```

所以：

> **磁力链接本身并不包含文件，也通常不包含完整 Torrent Metadata。**

它更像：

```text
启动整个P2P内容发现过程的一把钥匙
```

### 为什么几十个字符可以“代表”几十GB？

现在这个问题就容易理解了。

Magnet：

```text
ABCDEF...
```

并没有：

```text
压缩几十GB数据
```

而只是：

```text
标识Metadata
```

然后：

```text
Info Hash
↓
找到Peer
↓
Peer提供Metadata
↓
Metadata描述Pieces
↓
Peers提供Pieces
↓
最终恢复完整文件
```

所以磁力链接实际上利用的是一种：

```text
递归寻址链
```

可以画成：

```text
Magnet
  │
  ↓
Info Hash
  │
  ↓
DHT / Tracker
  │
  ↓
Peer
  │
  ↓
Torrent Metadata
  │
  ↓
Piece Hashes
  │
  ↓
Pieces
  │
  ↓
完整文件
```

这也是理解 BitTorrent 最重要的一张逻辑图。

### Magnet是不是完全去中心化？

不能简单回答：

```text
是
```

更准确的答案是：

> **磁力链接使 BitTorrent 可以在没有特定 `.torrent` 下载服务器、甚至没有特定 Tracker 的情况下运行，但实际网络仍然需要某种 Bootstrap 和 Peer Discovery 基础设施。**

例如 DHT 客户端刚启动时：

```text
我的Routing Table是空的
```

它至少需要先认识：

```text
几个已有DHT节点
```

才能进入整个网络。

这通常通过：

```text
Bootstrap Nodes
```

完成。

随后：

```text
认识几个节点
↓
查询更多节点
↓
填充Routing Table
↓
逐渐融入整个DHT
```

所以：

> 去中心化通常不等于“系统中绝对不存在任何已知入口”。

而意味着：

> **系统核心运行不依赖某一个永久不可替代的中央节点。**

### Seed、Peer与Leecher是什么？

BitTorrent 中还经常出现几个术语。

拥有完整 Torrent 内容并继续上传的节点叫：

```text
Seeder
Seed
做种者
```

例如：

```text
100%
```

仍然在线上传。

而正在参与 Torrent 的节点一般都可以称：

```text
Peer
```

没有完整内容的下载者常被称为：

```text
Leecher
```

但在技术讨论和不同客户端中，Leecher 的具体使用有时并不完全一致。

可以简单理解：

```text
Seeder
→ 已有100%

Leecher
→ 尚未100%

Peer
→ 两者的统称
```

如果某个 Torrent：

```text
0 Seeder
```

也不一定立即无法完成。

假设：

```text
A拥有Piece 1-500
B拥有Piece 501-1000
```

虽然：

```text
A不是Seed
B也不是Seed
```

但是：

```text
A + B
=
完整文件
```

那么 Swarm 仍然可能形成完整副本。

真正关键的是：

> **整个 Swarm 是否还拥有100%的Piece集合。**

### 为什么有时磁力链接“有Peer却下不动”？

原因可能很多。

例如：

```text
Peer很多
```

并不等于：

```text
这些Peer拥有完整数据
```

也可能出现：

```text
100个Peer
```

但所有人都只有：

```text
同样的90%
```

那么剩余 10% 已经在整个 Swarm 中消失。

此时：

```text
Availability < 1
```

Torrent 就无法完成。

还可能是：

```text
NAT导致无法建立入站连接
防火墙
端口限制
Peer上传速度极低
对方Choke
DHT发现的是失效Peer
Tracker信息滞后
```

因此：

> Peer 数量只是一个指标，真正重要的是数据可用性和有效连接质量。

### P2P为什么特别怕NAT？

理论上的 P2P 最理想结构是：

```text
A ↔ B
```

双方都能够直接连接对方。

但是现代家庭网络通常是：

```text
Internet
   │
Public IP
   │
Router/NAT
   │
192.168.1.10
```

内部 Peer 实际拥有的是：

```text
Private IP
```

外部节点不能简单执行：

```text
connect 192.168.1.10
```

因此 P2P 必须处理：

```text
NAT Traversal
端口映射
UPnP
NAT-PMP
PCP
IPv6
```

等问题。

这也是很多现代 P2P 系统真正复杂的地方：

> **“知道某个Peer存在”并不等于“能够直接连接这个Peer”。**

### BitTorrent为什么后来又发展出uTP？

早期 BitTorrent 大量使用 TCP。

如果客户端同时与几十甚至上百个 Peer 传输：

```text
大量TCP流
```

很容易把家庭网络路由器或上行队列塞满。

结果可能是：

```text
BT下载很快

但是：

网页延迟极高
游戏卡顿
VoIP质量下降
```

因此后来又发展出：

```text
uTP
Micro Transport Protocol
```

它运行于 UDP 之上，但自己实现可靠传输和拥塞控制。

其目标之一就是：

> BitTorrent 可以充分利用空闲带宽，但尽量减少对交互式流量的影响。

BEP 29 明确指出，uTP 的设计动机之一就是避免 BitTorrent 填满家庭宽带设备的发送缓冲区而导致网页、语音等交互流量出现数秒延迟。

这说明 BitTorrent 的演进并不仅仅围绕：

```text
“怎样下得更快”
```

还包括：

```text
怎样更友好地共享网络资源
```

### BitTorrent v2：从SHA-1走向SHA-256与Merkle Tree

经典 BitTorrent v1 的一个重要历史遗产是：

```text
SHA-1
```

随着 SHA-1 的密码学安全性逐渐不足，BitTorrent 又发展出了：

```text
BitTorrent v2
```

v2 对数据组织方式进行了重要修改。

其中一个核心变化是使用：

```text
SHA-256
```

以及：

```text
Merkle Tree
```

BEP 52 规定 v2 的 `infohash` 使用 SHA-256，并为文件构建以 SHA-256 为摘要算法的 Merkle Tree。

Merkle Tree 可以想象成：

```text
                Root Hash
               /         \
           Hash AB       Hash CD
           /    \        /    \
        Hash A Hash B Hash C Hash D
          │      │      │      │
        BlockA BlockB BlockC BlockD
```

底层数据：

```text
Block A
Block B
Block C
Block D
```

各自计算 Hash。

随后：

```text
Hash A + Hash B
↓
Hash AB
```

最后生成：

```text
Root Hash
```

这样，一个 Root Hash 就能够代表整棵数据树。

只要底层任意一个字节发生变化：

```text
Block
↓
Leaf Hash变化
↓
Parent Hash变化
↓
Root Hash变化
```

因此 Merkle Tree 特别适合：

```text
大规模分块数据
+
局部验证
+
内容寻址
```

BitTorrent v2 中每个非空文件都可以拥有自己的：

```text
Pieces Root
```

BEP 52 明确规定该值是由文件的 16 KiB 数据块构建的二叉 Merkle Tree 根哈希。

这使 BitTorrent 的内容验证结构更加现代化。

### Magnet v1与v2也发生了变化

经典 v1 Magnet 使用：

```text
xt=urn:btih:<info-hash>
```

而 v2 可以使用：

```text
xt=urn:btmh:<tagged-info-hash>
```

BEP 9 当前规范同时列出了 v1 和 v2 Magnet URI 格式，并允许 Hybrid Torrent 同时携带 `btih` 与 `btmh`。

因此现代 Magnet 已经不一定永远长成过去最常见的：

```text
magnet:?xt=urn:btih:...
```

BitTorrent 协议本身也在持续演进。

### P2P真正“去中心化”的是什么？

理解 P2P 时，一个常见误区是：

> P2P = 完全没有服务器。

实际上不是。

现代 BitTorrent 中仍然可能存在：

```text
Torrent网站
Tracker
Bootstrap Node
Web Seed
DNS
搜索网站
```

真正去中心化的是：

> **核心内容分发能力不必永久依赖一个唯一的数据服务器。**

例如：

```text
Torrent网站挂掉
```

只要你还拥有 Magnet：

```text
可能继续下载
```

Tracker 挂掉：

```text
DHT可能继续工作
```

某个 Seeder 下线：

```text
其他Peer仍可能保存完整数据
```

某个 Peer 消失：

```text
Swarm中的其他节点仍然可以交换
```

所以 P2P 的核心并不是：

```text
No Server
```

而是：

```text
No Single Essential Server
```

即：

> **尽量减少不可替代的中心节点。**

### 哈希能够保证什么，又不能保证什么？

这一点非常重要。

假设 Magnet：

```text
Info Hash = ABC
```

客户端下载 Metadata，并验证：

```text
Hash(Metadata) = ABC
```

之后又按照 Piece Hash 校验所有下载数据。

这能够保证：

> **你最终获得的数据与这个 Magnet 所指向的数据一致。**

但是它不能回答：

> 这个数据是不是你原本想要的东西？

例如一个 Magnet 的名称写成：

```text
ubuntu.iso
```

但其真正内容可能完全不是 Ubuntu。

如果你一开始得到的 Info Hash 就来自恶意来源：

```text
哈希校验仍然可以100%通过
```

因为哈希保证的是：

```text
Integrity / Identity
```

而不是：

```text
Trust / Authenticity
```

换句话说：

```text
Hash告诉你：
“你拿到的确实是ABC。”

但Hash不会告诉你：
“ABC是一个可信、安全、合法的软件。”
```

如果需要验证：

> 某文件确实由 Ubuntu 官方发布。

还需要：

```text
HTTPS官方网站
数字签名
PGP签名
可信软件仓库
开发者签名
```

等外部信任体系。

因此密码学中必须区分：

```text
完整性
≠
来源真实性
```

### 把整个BitTorrent与Magnet流程串起来

如果使用 `.torrent` 文件，完整流程可以概括成：

```text
获得.torrent
      ↓
读取Info Dictionary
      ↓
计算/获得Info Hash
      ↓
读取Tracker
      ↓
Tracker / DHT寻找Peer
      ↓
建立Peer连接
      ↓
交换Bitfield
      ↓
请求Block
      ↓
组装Piece
      ↓
Piece Hash验证
      ↓
继续上传给其他Peer
      ↓
最终拼成完整文件
```

而 Magnet 则将最开始部分改成：

```text
获得Magnet
      ↓
获得Info Hash
      ↓
Tracker / DHT寻找Peer
      ↓
连接Peer
      ↓
通过ut_metadata获取Metadata
      ↓
计算Metadata Hash
      ↓
是否与Magnet中的Info Hash一致？
      ↓
     Yes
      ↓
获得文件结构与Piece Hash
      ↓
正常BitTorrent下载
```

于是可以发现：

> **磁力链接不是另一套文件传输协议。**

真正的数据传输：

```text
仍然是BitTorrent
```

磁力链接解决的主要是：

> **如何在没有 `.torrent` 文件下载地址的情况下，仅凭内容身份启动 BitTorrent。**

### P2P与磁力链接究竟代表了什么？

传统互联网的思维是：

```text
我要文件X
↓
文件X在哪里？
↓
Server A
↓
连接Server A
↓
下载
```

BitTorrent 的思维逐渐变成：

```text
我要内容X
↓
X的Info Hash是什么？
↓
谁拥有X的Metadata？
↓
谁拥有X的不同Piece？
↓
同时连接这些Peer
↓
验证并重新组合
```

因此它真正改变的是：

```text
Server-Oriented
服务器导向
```

向：

```text
Content-Oriented
内容导向
```

的转变。

可以把整个技术演进总结成：

```text
Client-Server
“从指定服务器下载完整文件”
        ↓
早期P2P
“用户之间直接交换文件”
        ↓
BitTorrent
“把文件切成Piece，让整个Swarm共同分发”
        ↓
Tracker
“中央服务器只负责告诉大家Peer在哪里”
        ↓
DHT
“连Peer目录也分散到整个网络”
        ↓
PEX
“Peer彼此介绍新的Peer”
        ↓
Magnet
“连Torrent Metadata的初始文件都不一定需要中央网站”
        ↓
BitTorrent v2
“SHA-256 + Merkle Tree进一步强化内容寻址与验证”
```

如果只用一句话概括 P2P：

> **P2P 是把网络中的消费者同时变成资源提供者，从而把集中式服务器承担的工作分散到大量对等节点。**

而磁力链接则可以概括成：

> **磁力链接不是“文件地址”，而是“内容身份”；客户端以这个身份为起点，通过 Tracker、DHT、PEX 和其他 Peer 逐层找到 Metadata 与真正的数据。**

因此最核心的区别其实只有两个词：

```text
HTTP URL
→ Location

Magnet
→ Identity
```

传统 URL 告诉计算机：

> **去哪里找。**

而 Magnet 告诉计算机：

> **我要找什么。**

至于这个东西究竟来自：

```text
Peer A
Peer B
Peer C
还是Peer D
```

并不重要。

这正是 BitTorrent、DHT 和磁力链接组合起来以后，P2P 内容分发体系最核心的技术思想。

## SSH协议：从Telnet到OpenSSH(AI版)
- 不得不说,尽管AI讲原理一般都不咋地,但讲历史还真了不得

如果说 HTTP、REST、gRPC 解决的是“应用程序之间如何通信”，那么 SSH 解决的是一个更加基础的问题：

> **人在不可信的网络上，如何安全地控制另一台计算机？**

今天我们在服务器上输入：

```bash
ssh root@192.168.1.100
```

几秒钟之后就能够获得远程 Shell。

这件事情看起来非常普通，但它实际上同时完成了服务器身份认证、密钥交换、加密、完整性保护、用户认证和会话建立。

而在 SSH 出现之前，远程服务器管理长期依赖 Telnet、rlogin、rsh 等工具。

它们最大的共同问题是：

> **互联网最初建立在一个“网络参与者基本可信”的环境中，而不是今天这种充满窃听和攻击的不可信网络中。**

SSH 的历史，就是互联网从“默认可信”走向“默认不可信”的一个缩影。

### SSH之前：Telnet与明文远程登录时代

**1. 最早的问题：如何远程操作一台计算机？**

早期计算机价格昂贵，一台大型计算机通常由许多人共享。

用户并不是每个人拥有一台完整计算机，而是通过终端连接大型机：

```text
终端
 │
 │
 ↓
大型计算机
```

终端本身可能几乎没有计算能力，只负责：

```text
键盘输入
   ↓
发送给主机
   ↓
主机计算
   ↓
返回字符
   ↓
显示器输出
```

随着计算机网络发展，人们自然希望：

> 如果计算机已经连接到网络，那么能不能通过网络直接登录另一台机器？

于是出现了 **Telnet**。

Telnet 可以把一台计算机上的终端连接到另一台计算机：

```text
Computer A
    │
 Telnet
    │
 TCP/IP
    │
Computer B
```

用户输入：

```bash
telnet server.example.com
```

随后：

```text
login: alice
password: ********
```

便可以获得远程 Shell。

Telnet 默认使用 TCP 23 端口。

从功能上看，这已经非常接近今天的 SSH。

---

**2. Unix世界的rlogin和rsh**

Unix 系统中还发展出了另外一套远程操作工具。

例如：

```text
rlogin
rsh
rcp
```

其中：

```text
rlogin
```

负责远程登录；

```text
rsh
```

负责远程执行命令；

```text
rcp
```

负责远程复制文件。

从用户体验上看已经相当方便：

```bash
rsh server ls /home
```

就可以直接让远程服务器执行：

```bash
ls /home
```

这套思路后来甚至能够在 SSH 中看到明显的继承：

```text
rlogin → ssh

rcp → scp
```

问题在于，当时很多协议的设计建立在一个非常危险的前提上：

> 网络本身基本可信。

---

**3. 致命问题：密码在网络上裸奔**

如果用户通过 Telnet 登录服务器：

```text
Alice
 │
 │ username=alice
 │ password=123456
 ↓
Server
```

中间的数据并没有得到现代意义上的加密保护。

只要攻击者能够观察这段网络：

```text
Alice
   │
   ├────────→ Server
   │
Attacker
```

就可能直接看到：

```text
alice
123456
ls
cd /home/alice
cat secret.txt
```

不仅密码可能被窃取，用户之后输入的命令以及服务器返回的数据同样可能被窃听。

在今天看来，这种设计几乎无法接受。

但在早期互联网环境中，局域网、大学网络和科研机构网络的参与者数量有限，攻击模型与今天完全不同。

到了 1990 年代，互联网迅速扩大。

问题随之爆发。

一种非常有效的攻击方式就是：

```text
Password Sniffer
```

即密码嗅探器。

攻击者只需要控制网络上的某台机器并监听数据，就可能批量收集经过 Telnet、FTP、rlogin 等协议传输的用户名和密码。

SSH 的诞生，正是直接源于这种攻击。

### SSH-1的诞生

**1. 1995年的密码嗅探事件**

1995 年，芬兰赫尔辛基理工大学网络发生了一次严重的密码嗅探事件。

攻击者在连接大学骨干网络的服务器上安装了 Password Sniffer。Tatu Ylönen 后来回忆，被发现时其中已经记录了数千个用户名和密码。正是这次事件促使他开始研究如何安全地进行远程登录。

他的目标很直接：

> Telnet 能远程登录，但是不安全；那么能不能设计一个加密版本的远程 Shell？

大约三个月后，第一个 SSH 实现完成。

1995 年 7 月，Ylönen 发布了早期 SSH 软件。

SSH 的全称就是：

```text
Secure Shell
```

即：

> **安全的远程 Shell。**

---

**2. 为什么SSH使用22端口？**

SSH 最终使用：

```text
TCP 22
```

这背后甚至有一个很有意思的历史细节。

当时：

```text
FTP     → 21
Telnet  → 23
```

而 22 端口恰好位于两者之间，并且尚未分配。

Ylönen 当时希望 SSH 同时替代：

```text
FTP
+
Telnet
```

于是向 IANA 申请了 22 号端口。

1995 年 7 月 10 日，IANA 正式把端口 22 分配给 SSH。

于是形成了一个很有历史意味的排列：

```text
21   FTP
22   SSH
23   Telnet
```

SSH 恰好站在两个自己准备取代的协议之间。

---

**3. SSH真正改变了什么？**

最简单的理解是：

```text
Telnet

Client ───────────────→ Server
       明文
```

SSH 则变成：

```text
SSH

Client
   │
   │ 加密数据
   ↓
Server
```

但 SSH 并不仅仅做“加密密码”。

真正建立 SSH 会话之后，包括：

```text
用户名
密码
Shell命令
Shell输出
文件数据
转发流量
```

都可以运行在加密连接中。

这意味着，即使攻击者能够监听网络：

```text
Client
   │
   ├────────→ Server
   │
Attacker
```

攻击者看到的也主要是密文，而不能像 Telnet 那样直接读取：

```text
password=123456
```

SSH 因而迅速开始替代：

```text
Telnet
rlogin
rsh
rcp
```

SSH.COM 的历史资料记载，第一版 SSH 就是在 1995 年的网络密码嗅探事件后开发出来的，并迅速成为安全远程登录的重要工具。

不过第一代 SSH 并不是今天使用的完整协议。

今天真正占据统治地位的是：

> **SSH-2。**

### SSH-2：从一个远程登录工具到完整协议

随着 SSH 快速传播，人们开始发现第一代协议本身仍然存在一些设计上的安全问题和扩展性问题。

于是 1997 年前后，SSH 开始进入 IETF 标准化过程，并推动第二代协议设计。SSH-2 并不是简单地给 SSH-1 打几个补丁，而是对整个协议结构进行了重新设计。OpenBSD 对这段历史的总结也指出，SSH-2 将协议重新划分为 Transport、Authentication 和 Connection 等不同组成部分，并在过程中处理了第一代协议中的若干安全问题。

因此：

```text
SSH-1
```

与：

```text
SSH-2
```

实际上是两个不同版本的协议。

今天所说的 SSH，基本上都指：

```text
SSH Protocol 2
```

---

**1. SSH-2最重要的设计：分层**

SSH-2 最漂亮的一点，是它不再把“安全远程 Shell”设计成一整个无法拆开的功能，而是分成三个主要协议层。

RFC 4251 对现代 SSH 架构的描述可以概括为：

```text
SSH Connection Protocol
        ↑
SSH User Authentication Protocol
        ↑
SSH Transport Layer Protocol
        ↑
       TCP
```

RFC 4251 明确把 SSH 分成 Transport Layer、User Authentication 和 Connection 三个主要组件。

这一点极其重要。

因为 SSH 从此不只是：

> 一个加密 Telnet。

而变成了：

> **一个能够在不安全网络上建立安全连接，并在其中承载多种逻辑通道的通用安全通信框架。**

---

**2. Transport Layer：先建立安全通道**

当你执行：

```bash
ssh alice@server
```

第一步不是立即输入密码。

SSH 首先需要解决：

> 我们之后说的话怎样才能不被第三者偷听？

因此双方会先协商：

```text
Key Exchange Algorithm
Host Key Algorithm
Cipher
MAC / AEAD
Compression
```

然后进行密钥交换。

可以把过程简化成：

```text
Client                    Server

   ───── 协商算法 ─────→

   ←──── 协商结果 ─────

        密钥交换

   ←──── Host Key ─────

     计算 Session Key

   ===== 加密通道 =====
```

这里有一个非常重要的设计思想：

> SSH 并不会使用 RSA、Ed25519 之类的公钥算法去加密整个 Shell 会话。

因为公钥密码学计算成本太高。

它主要用于：

```text
身份认证
+
密钥交换中的认证
```

真正大量的数据传输通常由：

```text
AES
ChaCha20
```

等对称加密算法完成。

因此整个架构实际上是：

```text
公钥密码学
     ↓
安全协商密钥
     ↓
对称加密
     ↓
高速传输整个会话
```

这也是 TLS、SSH 等现代安全协议普遍采用的基本思想。

---

**3. Host Key：你连接的真的是你的服务器吗？**

加密本身并不足够。

假设 Alice 想连接 Server：

```text
Alice → Server
```

攻击者完全可以插在中间：

```text
Alice
  ↓
Attacker
  ↓
Server
```

然后分别建立两个加密连接：

```text
Alice ⇄ Attacker ⇄ Server
```

Alice 依然看到：

```text
encrypted
```

Server 也依然看到：

```text
encrypted
```

但攻击者处在两条加密连接的中间。

这就是：

```text
Man-in-the-Middle
MITM
中间人攻击
```

因此 SSH 不仅需要：

> 加密。

还必须解决：

> **服务器身份认证。**

于是服务器拥有自己的：

```text
Host Key
```

第一次连接新服务器时，我们经常看到：

```text
The authenticity of host 'example.com' can't be established.
ED25519 key fingerprint is ...
Are you sure you want to continue connecting?
```

第一次确认以后，SSH 客户端把服务器公钥信息保存到：

```text
~/.ssh/known_hosts
```

下一次连接：

```text
Server
  ↓
提供Host Key
  ↓
Client与known_hosts比较
```

如果相同：

```text
正常
```

如果突然变化：

```text
WARNING:
REMOTE HOST IDENTIFICATION HAS CHANGED!
```

这可能意味着：

```text
服务器重装
Host Key更换
DNS/IP发生变化
```

也可能意味着：

```text
正在遭受MITM攻击
```

这种模式叫做：

> **TOFU——Trust On First Use。**

即：

> 第一次先信任，以后的连接验证服务器身份是否发生变化。

RFC 4251 同样建议实现可以在第一次连接时保存 Host Key，并在后续连接中进行比较。

---

**4. 用户认证：服务器又如何知道你是谁？**

安全通道建立以后，SSH 才进入：

```text
User Authentication
```

最容易理解的是：

```text
Password Authentication
```

即：

```text
username
+
password
```

不过与 Telnet 不同，这一次密码本身已经运行在 SSH 加密隧道之内。

所以网络攻击者不能简单监听密码。

后来更加流行的是：

```text
Public Key Authentication
```

也就是我们今天经常使用的：

```bash
ssh-keygen
```

产生：

```text
Private Key
Public Key
```

服务器保存：

```text
~/.ssh/authorized_keys
```

里面放的是：

```text
Public Key
```

客户端则保存：

```text
Private Key
```

认证逻辑并不是：

```text
把Private Key发给服务器
```

这一点非常重要。

Private Key **永远不应该离开客户端**。

实际过程更接近：

```text
Server
  ↓
请证明你拥有对应Private Key
  ↓
Client用Private Key完成签名
  ↓
Server用Public Key验证
  ↓
验证成功
```

于是服务器确认：

> 这个客户端确实拥有那把私钥。

但服务器从始至终并不知道私钥本身。

因此：

```text
Password
```

是：

> 证明“我知道某个秘密”。

而：

```text
SSH Public Key
```

则是：

> 通过密码学签名证明“我拥有某个私钥”。

这也是为什么 SSH Key 特别适合服务器和自动化系统。

### OpenSSH的崛起

SSH 很快取得成功，但随后出现了另一个问题：

> SSH 的协议可以开放，但究竟应该使用哪个软件实现？

Tatu Ylönen 后来成立 SSH Communications Security，后续版本的许可逐渐变得更加商业化。

而 Unix/Linux 世界非常需要：

> 一个真正自由、开放、能够默认集成进操作系统的 SSH 实现。

于是 **OpenSSH** 出现。

---

**1. OpenBSD接手**

1999 年，OpenBSD 开发者基于 Tatu Ylönen 早期仍可自由复用的 SSH 1.2.12 代码以及 OSSH 工作进行了新的分支开发。

这就是：

```text
OpenSSH
```

OpenSSH 于 1999 年 9 月导入 OpenBSD，随后随 **OpenBSD 2.6** 于 1999 年 12 月 1 日正式发布。

其演进关系可以粗略理解成：

```text
Tatu Ylönen SSH
        │
        ├── 商业SSH产品
        │
        └── ssh 1.2.12
                │
               OSSH
                │
             OpenSSH
```

---

**2. OpenSSH支持SSH-2**

最初的 OpenSSH 主要还是 SSH-1 实现。

随后 Markus Friedl 等开发者加入 SSH-2 支持。

2000 年 6 月，包含 SSH-2 支持的 OpenSSH 2.0 随 OpenBSD 2.7 发布。

从此以后：

```text
OpenSSH
+
SSH Protocol 2
```

开始逐渐成为 Unix/Linux 世界最主流的实现组合。

今天我们在 Linux 上安装：

```bash
openssh-server
```

得到的：

```bash
sshd
```

以及客户端：

```bash
ssh
```

本质上就是这一项目的延续。

OpenSSH 最终还形成了一整套工具体系，例如 `ssh`、`sshd`、`scp`、`sftp`、`ssh-keygen`、`ssh-agent` 和 `ssh-add` 等。OpenBSD 官方也将这些工具列为 OpenSSH 的组成部分。

---

**3. SFTP：SSH开始取代FTP**

2000 年 11 月，OpenSSH 2.3.0 加入了服务器端 SFTP 支持，之后又加入了 SFTP 客户端。

因此：

```text
FTP
```

和：

```text
SFTP
```

需要严格区分。

SFTP 并不是：

```text
FTP
+
TLS
```

也不是：

```text
FTP
+
SSH简单加密
```

它实际上是：

```text
SSH File Transfer Protocol
```

作为 SSH 内部的一个文件传输协议运行。

结构更接近：

```text
SFTP
 ↓
SSH Connection
 ↓
SSH Transport
 ↓
TCP
```

所以今天登录服务器以后：

```bash
sftp user@server
```

本质上仍然首先建立一条 SSH 连接。

### SSH不再只是远程Shell

随着 SSH-2 和 OpenSSH 成熟，一个非常关键的变化发生了：

> SSH 从“远程 Shell 工具”逐渐变成了一条通用加密隧道。

原因就在于 SSH-2 的：

```text
Connection Protocol
```

能够在同一条 SSH 连接中建立多个逻辑 Channel。

可以想象：

```text
                    ┌── Shell
                    │
SSH Connection ─────┼── SFTP
                    │
                    ├── Port Forward
                    │
                    └── Other Channel
```

因此一条 SSH 连接可以承载很多不同用途。

---

**1. 远程执行命令**

最普通的是：

```bash
ssh user@server
```

进入：

```text
Remote Shell
```

但甚至不需要真正打开交互终端。

例如：

```bash
ssh user@server "docker ps"
```

实际发生的是：

```text
Local Machine
      ↓
SSH
      ↓
Remote Server
      ↓
docker ps
      ↓
结果通过SSH返回
```

这使 SSH 天然适合自动化运维。

---

**2. SCP与SFTP**

SSH 还可以完成：

```text
文件传输
```

例如：

```bash
scp app.tar.gz user@server:/opt/
```

或者：

```bash
sftp user@server
```

于是过去可能分别需要：

```text
Telnet
+
FTP
```

现在一套 SSH 基础设施就能够同时解决：

```text
远程登录
+
远程执行
+
文件复制
```

---

**3. Local Port Forwarding**

SSH 更强大的能力是：

```text
Port Forwarding
```

例如数据库只允许服务器本地访问：

```text
PostgreSQL
127.0.0.1:5432
```

公网无法直接连接。

可以建立：

```bash
ssh -L 15432:localhost:5432 user@server
```

于是：

```text
你的电脑
localhost:15432
      │
      │ SSH Tunnel
      ↓
服务器
localhost:5432
      ↓
PostgreSQL
```

你访问：

```text
localhost:15432
```

就像访问本地数据库，但真正的数据通过 SSH 隧道到达远程 PostgreSQL。

---

**4. Remote Port Forwarding**

方向也可以反过来：

```bash
ssh -R 8080:localhost:3000 user@server
```

假设你的电脑本地运行：

```text
localhost:3000
```

就可以通过 SSH 把它映射到远程机器。

结构变成：

```text
Remote Server :8080
        │
        │ SSH Tunnel
        ↓
Local Machine :3000
```

这就是：

```text
Remote Forwarding
```

---

**5. Dynamic Forwarding**

甚至可以执行：

```bash
ssh -D 1080 user@server
```

SSH 会建立一个本地：

```text
SOCKS Proxy
```

于是：

```text
Browser
   ↓
SOCKS5 :1080
   ↓
SSH Tunnel
   ↓
Remote Server
   ↓
Internet
```

此时 SSH 已经明显超出了：

> “安全远程 Shell”

这个原始定义。

它实际上已经具有了一部分：

```text
VPN / Tunnel
```

的能力。

### SSH进入现代开发体系

SSH 最初是系统管理员使用的工具。

但到了今天，它已经进入大量开发基础设施。

最典型的例子就是：

```text
Git
```

我们经常配置：

```bash
git@github.com:user/project.git
```

表面上：

```text
Git
```

负责代码版本控制。

底层认证和传输则可以走：

```text
SSH
```

于是：

```text
Developer
    ↓
Git
    ↓
SSH
    ↓
Git Server
```

开发者通过 SSH Key：

```text
~/.ssh/id_ed25519
```

完成身份认证，而不必每次输入密码。

---

现代服务器运维同样高度依赖 SSH。

例如：

```text
Developer
   ↓
SSH
   ↓
Linux Server
   ↓
Docker
   ↓
Application
```

云厂商创建虚拟机时也经常让用户直接添加：

```text
SSH Public Key
```

然后：

```bash
ssh root@server
```

即可管理实例。

Ansible 等自动化工具长期以来也大量利用 SSH 完成：

```text
Control Node
   │
   ├──── SSH ──── Server 1
   ├──── SSH ──── Server 2
   └──── SSH ──── Server 3
```

这使 SSH 从：

> 一个人远程登录服务器的工具

进一步演化成：

> **机器批量管理机器的重要底层通道。**

### SSH Key、ssh-agent与现代认证

随着 SSH 使用量增加，一个新的问题出现：

> 如果我管理 100 台服务器，难道我要保存和输入 100 个密码？

Public Key Authentication 解决了其中一部分问题。

假设：

```text
Private Key
```

保存在：

```text
Laptop
```

然后把对应：

```text
Public Key
```

部署到：

```text
Server A
Server B
Server C
```

此时同一身份就可以安全访问多台服务器。

但如果私钥本身又使用 Passphrase 保护：

```text
Private Key
+
Passphrase
```

每次 SSH 都输入密码仍然非常麻烦。

于是出现：

```text
ssh-agent
```

工作模式可以理解为：

```text
Private Key
     ↓
 ssh-agent
     ↓
保存在当前登录会话中
     ↓
SSH需要签名时
     ↓
请求agent完成签名
```

这样用户通常只需要解锁一次密钥。

`ssh-agent` 并不要求把 Private Key 不断交给每一个程序，而是提供：

> “帮我用这个私钥签名。”

的服务。

这也是现代密码学系统中非常常见的模式。

后来 SSH 又进一步支持硬件安全设备、FIDO 安全密钥等形式，使私钥甚至可以不以普通文件形式存在于计算机磁盘。

### SSH算法也在不断淘汰

SSH 并不是 1995 年设计完成以后就没有变化。

相反，它非常典型地体现了：

> **安全协议必须持续淘汰旧算法。**

因为密码学算法并不存在“永久安全”。

早期 SSH 曾经广泛使用：

```text
DSA
RSA + SHA-1
传统Diffie-Hellman
```

但随着计算能力、密码分析研究和安全标准不断变化，一些算法逐渐被认为不再适合作为默认选择。

于是现代 OpenSSH 大量采用：

```text
Ed25519
Curve25519
ChaCha20-Poly1305
AES-GCM
SHA-2
```

等更加现代的算法组合。

OpenSSH 10.0 在 2025 年正式移除了弱 DSA 签名算法支持。

这很好地体现了安全协议与 REST、HTTP 之类应用协议的一个重大区别：

> API 设计可能几十年仍然可以兼容旧格式，但密码学算法如果不淘汰，就可能直接成为系统漏洞。

### SSH进入后量子时代

SSH 最新一轮重要演进甚至已经开始针对：

```text
Quantum Computer
量子计算机
```

传统公钥密码系统中的一些算法理论上可能在足够强的量子计算机出现后受到 Shor 算法攻击。

而网络通信存在一个特殊风险：

```text
Store Now
Decrypt Later
```

即攻击者今天可能无法破解 SSH 流量，但可以：

```text
今天
↓
大量录制加密流量
↓
保存十几年
↓
未来获得量子计算能力
↓
尝试解密历史流量
```

因此后量子安全并不一定需要等：

> “量子计算机已经能攻击了。”

才开始部署。

OpenSSH 从 9.0（2022 年）起就已经默认提供后量子安全的混合密钥交换方案；OpenSSH 10.0 在 2025 年进一步把：

```text
mlkem768x25519-sha256
```

设为默认密钥交换算法。

它的基本思想是：

```text
传统椭圆曲线算法
        +
后量子ML-KEM算法
        ↓
Hybrid Key Exchange
```

如果传统算法依然安全：

```text
连接安全
```

如果未来量子计算使传统算法失效，但 ML-KEM 仍然安全：

```text
连接仍然安全
```

因此：

> 两种机制必须同时失败，攻击者才有机会破解密钥交换。

截至 2026 年 8 月发布的 OpenSSH 10.5，OpenSSH 仍然是完整的 SSH Protocol 2.0 实现，并继续维护其安全与密码算法体系。

因此 SSH 今天甚至已经完成了这样一条非常长的技术演进：

```text
1995
解决明文密码嗅探
        ↓
SSH-1
安全远程Shell
        ↓
SSH-2
模块化安全协议
        ↓
OpenSSH
Unix/Linux标准基础设施
        ↓
Public Key
无密码认证
        ↓
Port Forwarding
安全隧道
        ↓
Git / Cloud / DevOps
开发基础设施
        ↓
Ed25519 / ChaCha20
现代密码算法
        ↓
ML-KEM Hybrid
后量子密钥交换
```

### SSH究竟是一种什么协议？

理解 SSH 最容易犯的错误，就是把它简单理解成：

```text
Telnet + Encryption
```

从历史起点看，这并不完全错误。

但从今天的体系结构看，它明显过于狭窄。

更准确地说：

> **SSH 是一种在不可信网络上建立经过身份认证、具有机密性和完整性保护的安全连接，并允许在该连接上复用多个逻辑通信通道的协议体系。**

因此完整的 SSH 可以理解成：

```text
Application

Shell
SFTP
Git
Port Forwarding
Remote Command
        │
        ↓
SSH Connection Protocol
        │
        ↓
SSH User Authentication
        │
        ↓
SSH Transport Layer
        │
        ↓
TCP
        │
        ↓
IP
```

它首先建立：

```text
Secure Transport
```

然后完成：

```text
User Authentication
```

最后允许建立：

```text
Shell Channel
SFTP Channel
Forwarding Channel
...
```

RFC 4251 所描述的三层结构正是现代 SSH 的核心。

所以 SSH 的历史可以概括为三次重要转变。

最初：

> **“我要解决 Telnet 密码被监听的问题。”**

后来：

> **“我要建立一套标准化、安全的远程登录协议。”**

再后来：

> **“既然已经有一条经过认证和加密的连接，就让各种应用都通过这条连接运行。”**

最终 SSH 从一个：

```text
Remote Shell
```

变成了：

```text
Secure Communication Infrastructure
```

今天当我们执行：

```bash
ssh root@server
```

看起来只是一条极其普通的命令。

但它背后的技术实际上已经跨越三十余年：

```text
Telnet的明文终端
        ↓
1995年的密码嗅探危机
        ↓
SSH-1
        ↓
SSH-2
        ↓
OpenSSH
        ↓
公钥认证
        ↓
安全隧道
        ↓
Git与云计算
        ↓
自动化运维
        ↓
后量子密码
```

这也是为什么 SSH 至今依然没有像很多 1990 年代网络协议那样退出历史舞台。

它最初解决的是：

> **如何安全登录另一台计算机。**

但它最终形成的抽象是：

> **如何在一个完全不能信任的网络上，先建立一条可以信任的通信通道。**

只要远程服务器、云计算、自动化运维和分布式基础设施仍然存在，这个问题就不会消失，而 SSH 也就仍然拥有自己的核心位置。

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


# 实战
## 配置邮箱服务器
所有的网站注册基本都支持邮箱注册功能,但刚开始的配置我是一筹莫展的,除了知道邮箱使用SMTP协议,要有一个邮件服务器负责收发信件之外就啥也不懂了.
