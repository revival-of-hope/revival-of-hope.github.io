---
title: 2026-01-27 以tcp为基础的协议
tags:
  - 计算机网络
date: 2026-01-27 08:00:00
image: 81012089_p0-春.webp
---
## 建立在 TCP 之上的常见协议(2/6)

**TCP 提供特性**：可靠、有序、面向连接的字节流

---

### Web / 接口类

- HTTP/1.1  
- HTTP/2（仍基于 TCP）  
- HTTPS（HTTP + TLS + TCP）  
- WebSocket（HTTP Upgrade → 长连接）

---

### 文件 / 数据传输

- FTP  
- SFTP（SSH 子协议）  
- SMB  
- NFS（早期版本）

---

### 邮件

- SMTP  
- POP3  
- IMAP  

---

### 远程登录 / 管理

- SSH  
- Telnet（已淘汰）

---

### 数据库协议

- MySQL Protocol  
- PostgreSQL Protocol  
- Redis RESP  

挑几个重点的来分析

## http协议(2026/1/28)
### 概览
- [参考链接](https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Guides/Overview)
>HTTP 是一个客户端—服务器协议：请求由一个实体，即用户代理（user agent），或是一个可以代表它的代理方（proxy）发出。大多数情况下，这个用户代理都是一个 Web 浏览器，不过它也可能是任何东西，比如一个爬取网页来充实、维护搜索引擎索引的机器爬虫。
>
>每个请求都会被发送到一个服务器，它会处理这个请求并提供一个称作响应的回复。在客户端与服务器之间，还有许许多多的被称为代理的实体，履行不同的作用，例如充当网关或缓存。

**客户端发送的请求**
```HTTP
POST /api/v1/user/update?id=1024 HTTP/1.1
Host: www.example.com
Content-Type: application/json
User-Agent: Mozilla/5.0
Authorization: Bearer eyJhbGci...
Content-Length: 45

{
  "nickname": "Apollo",
  "gender": "male"
}
```
>POST: 客户端发起的请求所用方法
`/api/v1/user/update?id=1024`:服务器对应资源的路径和Query参数
Host: 目标服务器域名
Content-Type: 传输数据格式声明
User-Agent: 使用的浏览器代理
Authorization: cookie或token等身份识别头
Content-Length: 请求体字节长度
`{"nickname": "Apollo","gender": "male"}`: 传输数据

**服务端返回的报文**
```
HTTP/1.1 200 OK
Date: Sat, 09 Oct 2010 14:28:02 GMT
Server: Apache
Last-Modified: Tue, 01 Dec 2009 20:18:22 GMT
ETag: "51142bc1-7449-479b075b2891b"
Accept-Ranges: bytes
Content-Length: 29769
Content-Type: text/html

<!DOCTYPE html>…（此处是所请求网页的内容）
```
### METHOD
- [wiki](https://zh.wikipedia.org/wiki/%E8%B6%85%E6%96%87%E6%9C%AC%E4%BC%A0%E8%BE%93%E5%8D%8F%E8%AE%AE)

HTTP/1.1 协议中共定义了八种方法来以不同方式操作指定的资源,下面我列举常用的几种
#### GET
The request is for a representation of a resource.The server should only retrieve data; not modify state.

#### HEAD
The request is like a GET except that the response should not include the representation data in the body. 
HEAD = GET − Response Body

#### POST
The request is to process a resource in some way.
#### PUT
The request is to create or update a resource with the state in the request.
#### DELETE
The request is to delete a resource.


### status code
>In HTTP, you send a numeric status code of 3 digits as part of the response.
These status codes have a name associated to recognize them, but the important part is the number.

>In short:
100 - 199 are for "Information". You rarely use them directly. Responses with these status codes cannot have a body.
200 - 299 are for "Successful" responses. These are the ones you would use the most.
200 is the default status code, which means everything was "OK".
Another example would be 201, "Created". It is commonly used after creating a new record in the database.
A special case is 204, "No Content". This response is used when there is no content to return to the client, and so the response must not have a body.
300 - 399 are for "Redirection". Responses with these status codes may or may not have a body, except for 304, "Not Modified", which must not have one.
400 - 499 are for "Client error" responses. These are the second type you would probably use the most.
An example is 404, for a "Not Found" response.
For generic errors from the client, you can just use 400.
500 - 599 are for server errors. You almost never use them directly. When something goes wrong at some part in your application code, or server, it will automatically return one of these status codes.

### [User Agent](https://developer.mozilla.org/zh-TW/docs/Web/HTTP/Reference/Headers/User-Agent)

>[wiki](https://zh.wikipedia.org/wiki/%E7%94%A8%E6%88%B7%E4%BB%A3%E7%90%86):用户代理（英语：user agent）在计算机科学中指的是代表用户行为的程序（软件代理程序）。例如，网页浏览器就是一个“帮助用户获取、渲染网页内容并与之交互”的用户代理

>简单说,user agent是http header里的客户端标识,告诉目标服务器自己是通过哪个浏览器进行访问的
- 爬虫总是需要伪装自己是通过某个代理访问服务器的,否则容易被拦截

标准形式:
```html
User-Agent: <product> / <product-version> <comment>
```

web浏览器的通用格式:
```html
User-Agent: Mozilla/5.0 (<system-information>) <platform> (<platform-details>) <extensions>
```

示例:
```html
Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36
Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36 Edg/91.0.864.59
```

### Proxy(2/4)
>In computer networking, a proxy server is a server application that acts as an intermediary between a client requesting a resource and the server then providing that resource.[1]

>[Forward proxy vs. reverse proxy](https://en.wikipedia.org/wiki/Proxy_server)
A forward proxy is a server that routes traffic between clients and another system, which is, in most cases, external to the network. This means it can regulate traffic according to preset policies, convert and mask client IP addresses, enforce security protocols, and block unknown traffic. A forward proxy enhances security and policy enforcement within an internal network.A reverse proxy, instead of protecting the client, is used to protect the servers. A reverse proxy accepts a request from a client, forwards that request to another one of many other servers, and then returns the results from the server that specifically processed the request to the client. Effectively, a reverse proxy acts as a gateway between clients, users, and application servers and handles all the traffic routing whilst also protecting the identity of the server that physically processes the request.

**eg**
家庭网络中的路由器就同时扮演了正向代理和反向代理两个角色




