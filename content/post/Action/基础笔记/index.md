---
title: "基础笔记"
date: 2026-11-20T13:52:05+08:00
description: 大整合
image: 57793944_p0-浴衣とお面.webp
math: 
---
>之所以叫基础笔记,是因为我真的把除了Agent之外的所有东西都放进来了.具体包含内容为: 计算机网络,操作系统,数据库,编程语言,运维相关,架构相关.基本都是放的心得和一些实战体会,所以比较零散.
# 基础操作
## 运维相关
### 速查表格
#### 主流服务器厂商和类型
厂商类型:
| 厂商                               | 标准云服务器产品                                                                       | 轻量服务器产品                                             | 其他主要计算产品                               |
| ---------------------------------- | -------------------------------------------------------------------------------------- | ---------------------------------------------------------- | ---------------------------------------------- |
| Amazon Web Services（AWS）         | [EC2](https://aws.amazon.com/ec2/)（Elastic Compute Cloud）                            | [Lightsail](https://aws.amazon.com/lightsail/)             | EC2 GPU、Bare Metal、Spot Instances            |
| Microsoft Azure                    | [Azure Virtual Machines](https://azure.microsoft.com/en-us/products/virtual-machines)  | B系列等入门规格VM                                          | Spot VM、Dedicated Host、GPU VM                |
| Google Cloud（GCP）                | [Compute Engine](https://cloud.google.com/products/compute)（GCE）                     | E2等入门规格VM                                             | GPU VM、Bare Metal Instances                   |
| Alibaba Cloud（阿里云）            | [ECS](https://www.alibabacloud.com/product/ecs)（Elastic Compute Service）             | Simple Application Server（轻量应用服务器）                | 弹性裸金属、GPU实例                            |
| Tencent Cloud（腾讯云）            | [CVM](https://cloud.tencent.com/product/cvm)（Cloud Virtual Machine）                  | [Lighthouse](https://cloud.tencent.com/product/lighthouse) | 裸金属云服务器、GPU云服务器                    |
| Huawei Cloud（华为云）             | [ECS](https://www.huaweicloud.com/intl/en-us/product/ecs.html)（Elastic Cloud Server） | Flexus系列                                                 | BMS裸金属服务器、GPU云服务器                   |
| 百度智能云                         | [BCC](https://cloud.baidu.com/product/bcc)（Baidu Cloud Compute）                      | 经济型等入门规格                                           | GPU云服务器、专用计算资源                      |
| 火山引擎（字节跳动）               | [ECS](https://www.volcengine.com/product/ecs)（Elastic Compute Service）               | —                                                          | GPU实例、弹性裸金属                            |
| Oracle Cloud Infrastructure（OCI） | [OCI Compute](https://www.oracle.com/cloud/compute/)                                   | Always Free适用的VM规格                                    | Bare Metal、GPU实例                            |
| DigitalOcean                       | [Droplets](https://www.digitalocean.com/products/droplets)                             | Basic Droplets                                             | Dedicated CPU、GPU Droplets                    |
| Vultr                              | [Cloud Compute](https://www.vultr.com/products/cloud-compute/)                         | Cloud Compute入门规格                                      | Optimized Cloud Compute、Cloud GPU、Bare Metal |
| Akamai（原Linode）                 | [Linode Compute Instances](https://www.linode.com/products/compute/)                   | Shared CPU Linodes                                         | Dedicated CPU、High Memory、GPU                |
| Hetzner                            | [Hetzner Cloud](https://www.hetzner.com/cloud/)                                        | Shared Resources                                           | Dedicated Resources、Dedicated Servers         |
| OVHcloud                           | [Public Cloud Instances](https://www.ovhcloud.com/en/public-cloud/)                    | 入门规格实例                                               | Compute Optimized、Bare Metal                  |
| IBM Cloud                          | [Virtual Servers for VPC](https://www.ibm.com/products/virtual-servers)                | 小规格Virtual Servers                                      | Bare Metal、Dedicated Host、GPU                |


服务器类型:
| 英文名称                 | 中文名称       | 主要特点                             | 典型用途             |
| :----------------------- | :------------- | :----------------------------------- | :------------------- |
| **Compute Instance**     | 计算实例       | 泛指云上的计算资源                   | 通用服务器           |
| **Cloud Instance**       | 云实例         | 泛称，具体含义看厂商                 | 各类云服务           |
| **VM Instance**          | 虚拟机实例     | 通过虚拟化技术提供操作系统环境       | Web、API、数据库     |
| **VPS**                  | 虚拟专用服务器 | 通常配置和价格较简单                 | 个人网站、小项目     |
| **Bare Metal Server**    | 裸金属服务器   | 直接使用物理服务器，不经普通虚拟机层 | 数据库、高性能计算   |
| **Dedicated Host**       | 专用宿主机     | 独占物理宿主机，可在上面创建虚拟机   | 隔离、合规           |
| **General Purpose**      | 通用型实例     | CPU 与内存比例均衡                   | 后端、微服务         |
| **Compute Optimized**    | 计算优化型     | CPU 相对更强                         | 高计算负载、视频编码 |
| **Memory Optimized**     | 内存优化型     | 配备更多内存                         | Redis、大型数据库    |
| **Storage Optimized**    | 存储优化型     | 更强调磁盘吞吐与 IOPS                | 大数据、存储服务     |
| **GPU Instance**         | GPU 实例       | 提供 GPU 加速计算                    | AI 训练、推理        |
| **Burstable Instance**   | 突发性能实例   | 通常具有基准 CPU 性能与突发机制      | 低负载网站           |
| **Spot Instance**        | 抢占式实例     | 使用可回收容量，通常更便宜           | 可中断任务、批处理   |
| **Serverless Container** | 无服务器容器   | 无需自行管理底层服务器               | 弹性容器工作负载     |
#### IPv4地址分配
IPv4的地址分配相当混乱,我们记住特殊的几个即可:
| 网段             | 地址数量   | 常见用途                           |
| ---------------- | ---------- | ---------------------------------- |
| `10.0.0.0/8`     | 16,777,216 | 企业内网、云计算、Kubernetes       |
| `172.16.0.0/12`  | 1,048,576  | 企业网络、容器网络                 |
| `192.168.0.0/16` | 65,536     | 家庭路由器、局域网                 |
| `127.0.0.0/8`    | 16,777,216 | 回环地址（本机通信，如 127.0.0.1） |

#### 主流域名厂商
| 厂商                       | 国家/地区 | 域名注册产品或平台                                                      | 主要特点                                          |
| -------------------------- | --------- | ----------------------------------------------------------------------- | ------------------------------------------------- |
| GoDaddy                    | 美国      | [GoDaddy Domains](https://www.godaddy.com/domains)                      | 大型域名注册商，提供域名交易、邮箱、建站等        |
| Namecheap                  | 美国      | [Namecheap Domains](https://www.namecheap.com/domains/)                 | 域名注册、隐私保护、DNS及API                      |
| Cloudflare                 | 美国      | [Cloudflare Registrar](https://domains.cloudflare.com/)                 | 按批发成本价注册及续费，必须使用Cloudflare权威DNS |
| Porkbun                    | 美国      | [Porkbun Domains](https://porkbun.com/)                                 | 价格透明，提供免费域名隐私保护及DNS               |
| Dynadot                    | 美国      | [Dynadot Domains](https://www.dynadot.com/)                             | 域名批量管理、交易市场、API                       |
| Spaceship                  | 美国      | [Spaceship Domains](https://www.spaceship.com/domains/)                 | 低价注册、域名管理、API                           |
| NameSilo                   | 美国      | [NameSilo](https://www.namesilo.com/)                                   | 域名批量管理、隐私保护、API                       |
| Squarespace                | 美国      | [Squarespace Domains](https://domains.squarespace.com/)                 | 已接收原Google Domains用户，集成建站服务          |
| Gandi                      | 法国      | [Gandi Domains](https://www.gandi.net/en/domain)                        | 域名注册、企业域名管理                            |
| IONOS                      | 德国      | [IONOS Domains](https://www.ionos.com/domains)                          | 域名、主机、邮箱及企业服务                        |
| OVHcloud                   | 法国      | [OVHcloud Domains](https://www.ovhcloud.com/en/domains/)                | 域名、DNS、云服务器一体化                         |
| Amazon Web Services（AWS） | 美国      | [Route 53 Domains](https://aws.amazon.com/route53/)                     | 与AWS DNS、云计算资源集成                         |
| 阿里云（万网）             | 中国      | [阿里云万网](https://wanwang.aliyun.com/)                               | 域名注册、域名交易、DNS、备案                     |
| 腾讯云                     | 中国      | [腾讯云域名注册](https://cloud.tencent.com/product/domain)              | 域名注册、DNSPod解析、备案                        |
| 华为云                     | 中国      | [Huawei Cloud Domains](https://www.huaweicloud.com/product/domain.html) | 域名注册、实名认证、DNS、备案                     |

#### 主流指令集架构汇总
| 架构                   | 常见名称                        | 主要公司/组织                            | 当前热门度 | 软件生态接受程度 | 主要应用场景                          |
| ---------------------- | ------------------------------- | ---------------------------------------- | ---------: | ---------------: | ------------------------------------- |
| **x86-64**             | x86-64 / x64 / AMD64 / Intel 64 | Intel、AMD                               |      ★★★★★ |            ★★★★★ | PC、服务器、云、游戏、工作站          |
| **ARM 64-bit**         | ARM64 / AArch64                 | Arm；Apple、Qualcomm、AWS、NVIDIA 等实现 |      ★★★★★ |            ★★★★★ | 手机、Mac、云服务器、嵌入式、AI       |
| **RISC-V 64**          | RISC-V / RV64                   | RISC-V International，开放 ISA           |    ★★★★☆ ↑ |          ★★★☆☆ ↑ | MCU、嵌入式、汽车、AI、逐渐进入服务器 |
| **POWER / Power ISA**  | POWER / PowerPC 64              | IBM、OpenPOWER Foundation                |      ★★☆☆☆ |            ★★★☆☆ | IBM 企业服务器、HPC、数据库           |
| **IBM z/Architecture** | z/Architecture / IBM Z          | IBM                                      |      ★★☆☆☆ |            ★★★☆☆ | 大型机、银行、保险、核心交易          |
| **LoongArch**          | LoongArch / 龙芯架构            | 龙芯中科                                 |      ★★☆☆☆ |          ★★☆☆☆ ↑ | 国产 PC、服务器、政企                 |
| **MIPS**               | MIPS / MIPS64                   | 历史上 MIPS Technologies                 |    ★☆☆☆☆ ↓ |            ★★☆☆☆ | 老路由器、嵌入式、遗留设备            |
| **SPARC**              | SPARC / SPARC64                 | SPARC International、Oracle、Fujitsu     |    ★☆☆☆☆ ↓ |            ★☆☆☆☆ | 老 Unix/Solaris 企业系统              |
| **x86 32-bit**         | x86 / IA-32 / i386              | Intel、AMD                               |    ★☆☆☆☆ ↓ |            ★★☆☆☆ | 老 PC、遗留工业系统                   |
| **ARM 32-bit**         | ARM / ARMv6 / ARMv7             | Arm 生态                                 |    ★★☆☆☆ ↓ |            ★★★☆☆ | 老树莓派、MCU、嵌入式设备             |

#### 主流Linux发行版
| 发行版            | 所属家族           | 开发主体 / 背景           | 包管理体系 | 主要定位                 |
| :---------------- | :----------------- | :------------------------ | :--------- | :----------------------- |
| **Debian**        | Debian 系          | Debian 社区               | APT / dpkg | 通用系统、服务器、稳定性 |
| **Ubuntu**        | Debian 系          | Canonical + 社区          | APT / dpkg | 桌面、开发、云服务器     |
| **Linux Mint**    | Ubuntu / Debian 系 | Mint 团队                 | APT / dpkg | 桌面、Windows 用户迁移   |
| **Kali Linux**    | Debian 系          | OffSec                    | APT / dpkg | 网络安全、渗透测试       |
| **Fedora**        | Red Hat 系         | Fedora 社区、Red Hat 参与 | DNF / RPM  | 新技术、开发者桌面       |
| **RHEL**          | Red Hat 系         | Red Hat                   | DNF / RPM  | 企业服务器、商业支持     |
| **CentOS Stream** | Red Hat 系         | CentOS 社区、Red Hat      | DNF / RPM  | RHEL 上游开发、测试      |
| **Rocky Linux**   | RHEL 兼容生态      | Rocky 社区                | DNF / RPM  | 企业服务器、RHEL 兼容    |
| **Arch Linux**    | Arch 系            | Arch 社区                 | Pacman     | 滚动更新、高度自定义     |
| **Manjaro**       | Arch 系            | Manjaro 团队              | Pacman     | 更易上手的 Arch 衍生版   |
| **Alpine Linux**  | 独立发行版         | Alpine 社区               | APK        | 轻量容器、最小化系统     |


其中,最需要了解的就是各个派系的包管理工具了,毕竟`sudo apt update`很有可能是你进入新系统后运行的第一条命令:
1. Debian系: apt高级命令和dpkg底层命令,`apt-get`则是一个脚本命令,对应的安装包后缀为`.deb`
2. Red Hat系: dnf高级命令和早期的yum高级命令,对应的安装包后缀为`.rpm`
3. Arch系: pacman
4. Apline专用: apk

##### Debian系操作
| 命令               | 实际作用             | 会更新已安装的软件吗？ |
| :----------------- | :------------------- | :--------------------- |
| `sudo apt update`  | 更新本地的软件包索引 | 不会                   |
| `sudo apt upgrade` | 升级已安装的软件包   | 会                     |

![时间线示例](PixPin_2026-10-11_10-49-51.webp)


#### 操作系统年表
| 年份 | 操作系统 / 项目              | 所属体系           | 历史地位及特点                                                  |
| :--- | :--------------------------- | :----------------- | :-------------------------------------------------------------- |
| 1969 | Unix                         | Unix               | 贝尔实验室开发，现代操作系统的重要技术源头                      |
| 1977 | BSD                          | Unix 衍生          | 加州大学伯克利分校发布早期 BSD，后来发展出多个 BSD 系统         |
| 1981 | MS-DOS                       | DOS                | 微软面向 IBM PC 时代的重要命令行操作系统                        |
| 1983 | GNU 项目                     | 类 Unix            | 自由软件操作系统项目启动，后来提供了大量 GNU/Linux 用户空间工具 |
| 1984 | Macintosh System Software    | Classic Mac OS     | 苹果早期图形界面操作系统                                        |
| 1985 | Windows 1.0                  | Windows            | 微软早期图形操作环境，运行于 MS-DOS 之上                        |
| 1991 | Linux Kernel                 | Linux              | Linus Torvalds 发布 Linux 内核，现代 Linux 发行版的基础         |
| 1992 | SLS                          | Linux              | 最早一批综合性 Linux 发行版之一                                 |
| 1992 | Solaris                      | Unix               | Sun 推出的企业级 Unix 系统                                      |
| 1993 | Slackware                    | Linux / 独立       | 历史最悠久且仍在维护的 Linux 发行版之一                         |
| 1993 | Debian                       | Linux / Debian 系  | 社区主导的发行版，后来衍生 Ubuntu 等系统                        |
| 1993 | FreeBSD                      | BSD                | 基于 BSD 技术传统发展的独立 Unix-like 操作系统                  |
| 1993 | Windows NT                   | Windows NT         | 微软现代 Windows 内核体系的重要起点                             |
| 1994 | Red Hat Linux                | Linux / Red Hat 系 | 早期重要的商业 Linux 发行版                                     |
| 1994 | SUSE Linux                   | Linux / SUSE 系    | 欧洲重要的 Linux 发行版，后来发展出企业服务器产品               |
| 1995 | Windows 95                   | Windows            | 推广开始菜单、任务栏等经典界面                                  |
| 1996 | Linux Mint 的前身？          | —                  | 此时尚不存在 Linux Mint；该发行版实际于 2006 年推出             |
| 1998 | Windows 98                   | Windows            | 面向个人电脑的 Windows 9x 系统                                  |
| 2000 | Windows 2000                 | Windows NT         | 将 NT 技术进一步推广到专业桌面与服务器                          |
| 2000 | SUSE Linux Enterprise Server | Linux / SUSE 系    | 企业级 Linux 服务器产品                                         |
| 2001 | Mac OS X                     | Unix / Darwin      | 苹果转向基于 Darwin 的现代 macOS 技术体系                       |
| 2001 | Windows XP                   | Windows NT         | 微软统一消费级与专业桌面 Windows 的重要版本                     |
| 2002 | RHEL                         | Linux / Red Hat 系 | Red Hat Enterprise Linux，面向企业长期维护                      |
| 2002 | Arch Linux                   | Linux / Arch 系    | 强调简洁、可定制和滚动更新                                      |
| 2002 | Gentoo Linux                 | Linux / 独立       | 以源码构建和 Portage 包管理闻名                                 |
| 2003 | Fedora Core                  | Linux / Red Hat 系 | 社区发行版，强调较新的技术                                      |
| 2004 | Ubuntu                       | Linux / Debian 系  | Canonical 推出，强调易用性和规律发布                            |
| 2004 | CentOS Linux                 | Linux / RHEL 兼容  | 曾广泛用于企业服务器                                            |
| 2005 | openSUSE                     | Linux / SUSE 系    | 社区发行版，拥有独立的发布体系                                  |
| 2005 | Alpine Linux                 | Linux / 独立       | 轻量发行版，后来广泛应用于容器环境                              |
| 2006 | Linux Mint                   | Linux / Ubuntu 系  | 强调传统桌面体验和易用性                                        |
| 2007 | iPhone OS（后称 iOS）        | Apple / Darwin     | 苹果移动操作系统                                                |
| 2008 | Android                      | Linux 内核         | Google 主导的移动操作系统平台                                   |
| 2013 | Kali Linux                   | Linux / Debian 系  | 面向安全测试和渗透测试                                          |
| 2015 | Windows 10                   | Windows NT         | 微软重要的现代桌面操作系统版本                                  |
| 2019 | CentOS Stream                | Linux / Red Hat 系 | 参与 RHEL 后续版本开发的上游发行版                              |


| 技术路线       | 发展脉络                                                                                |
| :------------- | :-------------------------------------------------------------------------------------- |
| **Unix**       | Unix（1969）→ BSD（1977）→ FreeBSD（1993）                                              |
| **GNU/Linux**  | GNU 项目（1983）+ Linux 内核（1991）→ 各类 GNU/Linux 发行版                             |
| **Debian 系**  | Debian（1993）→ Ubuntu（2004）→ Linux Mint（2006）                                      |
| **Red Hat 系** | Red Hat Linux（1994）→ RHEL（2002）、Fedora（2003）→ CentOS Stream（2019）              |
| **SUSE 系**    | SUSE Linux（1994）→ SLES（2000）→ openSUSE 项目（2005）                                 |
| **Windows**    | MS-DOS（1981）→ Windows 1.0（1985）→ Windows NT（1993）→ Windows 2000 / XP → Windows 10 |
| **Apple**      | Classic Mac OS（1984）→ Mac OS X（2001）→ iPhone OS（2007）                             |
## 操作系统相关
### Unix标准
#### POSIX
POSIX 全称为 `Portable Operating System Interface`（可移植操作系统接口），是由 IEEE 等标准化组织制定的一系列操作系统接口标准。它的核心目的，是让开发者能够使用一套统一的接口，在不同的类 Unix 操作系统上编写程序。

POSIX涵盖以下内容:
| 领域         | 典型接口                         | 用途                  |
| :----------- | :------------------------------- | :-------------------- |
| 文件操作     | `open`, `read`, `write`, `close` | 文件读写              |
| 进程管理     | `fork`, `exec`, `waitpid`        | 创建和管理进程        |
| 线程管理     | `pthread_create`, `pthread_join` | 多线程编程            |
| 进程同步     | `sem_wait`, `pthread_mutex_lock` | 信号量、互斥锁        |
| 网络通信     | `socket`, `bind`, `connect`      | 网络编程              |
| I/O 多路复用 | `select`, `poll`                 | 同时管理多个 I/O 对象 |
| Shell 和工具 | `sh`, `grep`, `awk`              | 命令行环境            |


#### Berkeley Socket(BSD Socket)
它在 1983 年发布的 4.2BSD Unix 中出现，为 Unix 系统提供了一套广泛使用的 TCP/IP 网络编程接口。其核心思想是：使用 Socket（套接字）作为通信端点，让应用程序通过统一的函数与操作系统网络协议栈交互。BSD Socket在01年被纳入到POSIX标准中,因此也被称为POSIX Socket.

典型的几个操作函数如下:
| 函数                | 作用               |
| :------------------ | :----------------- |
| `socket()`          | 创建套接字         |
| `bind()`            | 绑定 IP 地址和端口 |
| `listen()`          | 监听连接           |
| `accept()`          | 接受客户端连接     |
| `connect()`         | 连接远程服务器     |
| `send()` / `recv()` | 发送和接收数据     |
| `close()`           | 关闭文件描述符     |

#### ELF
ELF（Executable and Linkable Format，可执行与可链接格式） 是 Unix/Linux 系统中广泛使用的一种二进制文件格式标准。

它规定了编译后的程序、目标文件、动态链接库等文件如何组织，以及链接器和操作系统如何解释这些文件。
#### Bash/sh
sh于1971年在贝尔实验室诞生,是UNIX的命令解释器,而在1979年,Stephen Bourne开发了Bourne Shell,改进了原本的sh并加入了脚本语言,1989年时,GNU项目开发了Bourne Again Shell(BASH),补充了更多功能.

通常来说,用POSIX标准里的sh的功能就足够了,Bash的功能过于臃肿,因此后来又开发了ash,Dash等Shell来简化命令执行,Debian系的Linux发行版用的就都是Dash.

再讲一下在sh系脚本中必须出现在第一行的`#!/bin/bash`或者`#!/bin/sh`声明,这被称为**Shebang**,它的作用是：告诉操作系统应该使用哪个解释器来执行这个文件。

- 至于为什么这么读,是因为#读作Sharp,而!读作Bang,连起来就是Shebang,显然是某个对命名一点都不讲究的hacker搞出来的

当可执行文件以 #! 开头时，系统将后续内容识别为Shell路径:
```sh
#!/bin/bash

echo "Hello World"
```


| 场景                        | 推荐做法                 |
| :-------------------------- | :----------------------- |
| Linux Bash 脚本             | `#!/bin/bash`            |
| 跨平台 Bash 脚本            | `#!/usr/bin/env bash`    |
| POSIX Shell 脚本            | `#!/bin/sh`              |
| Python 可执行脚本           | `#!/usr/bin/env python3` |
| 始终通过 `bash xxx.sh` 执行 | 可以省略                 |

在Docker容器中,推荐使用 `#!/bin/sh`，因为大多数 Linux 基础镜像都有 `/bin/sh`，但不一定安装了 Bash。


### Linux命令
#### 常用命令
| 序号 | 分类       | 命令     | 全名                            | 作用                         | 常见用法                         |
| ---- | ---------- | -------- | ------------------------------- | ---------------------------- | -------------------------------- |
| 1    | 文件与目录 | `pwd`    | Print Working Directory         | 查看当前工作目录             | `pwd`                            |
| 2    | 文件与目录 | `ls`     | List                            | 列出目录内容                 | `ls -lah`                        |
| 3    | 文件与目录 | `cd`     | Change Directory                | 切换工作目录                 | `cd /var/log`                    |
| 4    | 文件与目录 | `mkdir`  | Make Directory                  | 创建目录                     | `mkdir -p a/b/c`                 |
| 5    | 文件与目录 | `rmdir`  | Remove Directory                | 删除空目录                   | `rmdir test`                     |
| 6    | 文件与目录 | `touch`  | \_                              | 创建空文件或更新时间戳       | `touch test.txt`                 |
| 7    | 文件与目录 | `cp`     | Copy                            | 复制文件或目录               | `cp -r src/ backup/`             |
| 8    | 文件与目录 | `mv`     | Move                            | 移动或重命名文件             | `mv old.txt new.txt`             |
| 9    | 文件与目录 | `rm`     | Remove                          | 删除文件或目录               | `rm -r test/`                    |
| 10   | 文件与目录 | `find`   | \_                              | 查找文件或目录               | `find . -name "*.log"`           |
| 11   | 文件与目录 | `ln`     | Link                            | 创建硬链接或软链接           | `ln -s /data/app app`            |
| 12   | 文件与目录 | `stat`   | Status                          | 查看文件元数据               | `stat test.txt`                  |
| 13   | 文本处理   | `cat`    | Concatenate                     | 输出或拼接文件内容           | `cat config.yaml`                |
| 14   | 文本处理   | `less`   | \_                              | 分页查看文件                 | `less app.log`                   |
| 15   | 文本处理   | `head`   | \_                              | 查看文件前几行               | `head -n 20 app.log`             |
| 16   | 文本处理   | `tail`   | \_                              | 查看文件末尾或实时日志       | `tail -f app.log`                |
| 17   | 文本处理   | `grep`   | Global Regular Expression Print | 按模式搜索文本               | `grep -rn "ERROR" logs/`         |
| 18   | 文本处理   | `sed`    | Stream Editor                   | 流式文本编辑                 | `sed -n '1,10p' file.txt`        |
| 19   | 文本处理   | `awk`    | Aho, Weinberger, Kernighan      | 文本按列处理和统计           | `awk '{print $1}' file.txt`      |
| 20   | 文本处理   | `sort`   | \_                              | 对文本行排序                 | `sort data.txt`                  |
| 21   | 文本处理   | `uniq`   | Unique                          | 去除相邻重复行               | `sort data.txt \\| uniq -c`      |
| 22   | 文本处理   | `wc`     | Word Count                      | 统计行数、单词数和字节数     | `wc -l app.log`                  |
| 23   | 权限与用户 | `chmod`  | Change Mode                     | 修改文件权限                 | `chmod 755 script.sh`            |
| 24   | 权限与用户 | `chown`  | Change Owner                    | 修改文件所有者               | `chown user:group file`          |
| 25   | 权限与用户 | `sudo`   | Substitute User Do              | 以其他用户权限执行命令       | `sudo apt update`                |
| 26   | 权限与用户 | `whoami` | Who Am I                        | 查看当前有效用户名           | `whoami`                         |
| 27   | 权限与用户 | `id`     | Identity                        | 查看 UID、GID 和用户组       | `id username`                    |
| 28   | 权限与用户 | `passwd` | Password                        | 修改用户密码                 | `passwd`                         |
| 29   | 进程管理   | `ps`     | Process Status                  | 查看进程信息                 | `ps aux`                         |
| 30   | 进程管理   | `top`    | \_                              | 实时查看进程资源占用         | `top`                            |
| 31   | 进程管理   | `kill`   | \_                              | 向指定进程发送信号           | `kill -15 1234`                  |
| 32   | 进程管理   | `pkill`  | Process Kill                    | 根据名称等条件向进程发送信号 | `pkill -f "python app.py"`       |
| 33   | 进程管理   | `jobs`   | \_                              | 查看当前 Shell 的任务        | `jobs -l`                        |
| 34   | 进程管理   | `nohup`  | No Hangup                       | 让程序忽略挂断信号           | `nohup python app.py &`          |
| 35   | 系统与磁盘 | `df`     | Disk Free                       | 查看文件系统磁盘空间         | `df -h`                          |
| 36   | 系统与磁盘 | `du`     | Disk Usage                      | 查看目录或文件占用空间       | `du -sh /var/log`                |
| 37   | 系统与磁盘 | `free`   | \_                              | 查看系统内存情况             | `free -h`                        |
| 38   | 系统与磁盘 | `uname`  | Unix Name                       | 查看内核及系统信息           | `uname -a`                       |
| 39   | 系统与磁盘 | `uptime` | \_                              | 查看运行时长和系统负载       | `uptime`                         |
| 40   | 网络管理   | `ip`     | Internet Protocol               | 查看和配置网络接口、路由     | `ip addr show`                   |
| 41   | 网络管理   | `ping`   | \_                              | 测试网络连通性               | `ping -c 4 8.8.8.8`              |
| 42   | 网络管理   | `curl`   | Client URL                      | 发起 HTTP 等网络请求         | `curl -I https://example.com`    |
| 43   | 网络管理   | `ss`     | Socket Statistics               | 查看 Socket 和端口状态       | `ss -tulnp`                      |
| 44   | 网络管理   | `ssh`    | Secure Shell                    | 远程登录服务器               | `ssh user@192.168.1.10`          |
| 45   | 压缩与传输 | `tar`    | Tape Archive                    | 打包或解包归档文件           | `tar -czvf backup.tar.gz data/`  |
| 46   | 压缩与传输 | `gzip`   | GNU Zip                         | 使用 gzip 压缩文件           | `gzip app.log`                   |
| 47   | 压缩与传输 | `scp`    | Secure Copy                     | 基于 SSH 传输文件            | `scp file.txt user@server:/tmp/` |


#### 学习资料
- [在线学习](https://cmdchallenge.com/#/move_file)
#### 学习方法
这个年代还要开虚拟机就太low了,用docker运行不就行了.

先写一个`compose.yml`:
```yml
services:
  linux:
    image: ubuntu:24.04
    container_name: linux-lab
    stdin_open: true
    tty: true
    command: bash
```
然后运行以下命令启动并运行bash:
```bash
docker compose up -d
docker exec -it linux-lab bash
```

![示意图](PixPin_2026-09-17_12-02-10.webp)

效果杠杠的好不好!


### Socket编程
了解

## 部署与构建

### GitHub Actions
#### 介绍
GitHub Actions 于2018年10月发布，2019年11月正式推出。在项目根目录的`.github/workflows`文件夹中配置yml文件后,即可在推送代码到Github时按需运行CI/CD.
#### 基本语法
##### 基本概念
GitHub Actions 的 Workflow YAML 文件共有9个顶级Key:
| 一级 Key    | 作用                     | 是否必需 |
| :---------- | :----------------------- | :------- |
| name        | 定义工作流名称           | 否       |
| run-name    | 定义每次执行的名称       | 否       |
| on          | 定义触发工作流的事件     | 是       |
| permissions | 设置 GITHUB_TOKEN 权限   | 否       |
| env         | 定义全局环境变量         | 否       |
| defaults    | 设置默认 Shell、工作目录 | 否       |
| concurrency | 控制工作流并发执行       | 否       |
| cache-mode  | 控制工作流的缓存读写权限 | 否       |
| jobs        | 定义需要执行的任务       | 是       |


##### 设定触发条件
在顶级关键字`on`下面,我们可以指定某个workflow在push,fork,pull_request,issues发生时触发,也可以指定在某个特定branch如master,main,dev触发,还可以指定当对应path下的文件或者文件夹发生修改时才触发,也可以忽略某些文件夹的修改,一个实战的yml如下:
```yml
on:
  push:
    branches: [ master ]
    paths-ignore:
      - 'doc/**'
      - 'src/pretix/locale/**'
  pull_request:
    branches: [ master ]
    paths-ignore:
      - 'doc/**'
      - 'src/pretix/locale/**'
```

其中,push等二级key被称为Event Trigger(事件触发器),表示当对应事件发生时触发Workflow,目前总共有33个触发器:
| 分类           | 数量 | 触发器                                                                              |
| :------------- | :--- | :---------------------------------------------------------------------------------- |
| 代码与分支     | 6    | push、create、delete、pull_request、pull_request_target、merge_group                |
| Issue与讨论    | 6    | issues、issue_comment、discussion、discussion_comment、label、milestone             |
| 代码审查与检查 | 5    | pull_request_review、pull_request_review_comment、check_run、check_suite、status    |
| 发布与部署     | 6    | release、deployment、deployment_status、registry_package、page_build、image_version |
| 仓库活动       | 5    | fork、watch、public、gollum、branch_protection_rule                                 |
| 自动化调度     | 5    | schedule、workflow_dispatch、workflow_call、workflow_run、repository_dispatch       |

##### 设定jobs
jobs关键字下用开发者自定义的`job_id`定义job,job_id下有21个三级key,常用的有以下几个:

| Key         | 作用                     |
| :---------- | :----------------------- |
| runs-on     | 指定任务运行环境         |
| steps       | 定义任务执行步骤         |
| name        | 设置任务显示名称         |
| needs       | 定义任务之间的依赖关系   |
| if          | 条件判断，决定是否执行   |
| env         | 定义环境变量             |
| permissions | 设置 GitHub Token 权限   |
| strategy    | 使用矩阵并行测试不同环境 |

一个不太全面的例子是这样的:
```yml
  test:
    strategy:
      matrix:
        runs-on: [ubuntu-latest, macos-latest, windows-latest]
    runs-on: ${{ matrix.runs-on }}

    steps:
      # Clone this repo
      - name: Checkout
        uses: actions/checkout@v4.1.6

      # Basic checkout
      - name: Checkout basic
        uses: ./
        with:
          ref: test-data/v2/basic
          path: basic
      - name: Verify basic
        shell: bash
        run: __test__/verify-basic.sh

```



steps下定义了该job的运行流程,按照yml列表展示,有以下几种常用的key:

| Key               | 作用               |
| :---------------- | :----------------- |
| name              | 设置步骤显示名称   |
| uses              | 调用已有的 Action  |
| run               | 执行 Shell 命令    |
| with              | 向 Action 传递参数 |
| id                | 设置步骤唯一标识符 |
| if                | 设置步骤执行条件   |
| env               | 定义步骤环境变量   |
| working-directory | 设置命令执行目录   |
| shell             | 指定 Shell 类型    |

steps中的每个step可以粗暴地用dockerfile的构建系统来看,所有step共享同一个Runner的文件系统,使用独立的Shell进程.所以可以这么写:
```yml
jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Install
        run: npm install

      - name: Build
        run: npm run build

      - name: Test
        run: npm test
```

##### Runner
每个Job都会由Github自动分配一个虚拟机来跑,你写什么运行环境就会分配什么:

| 标签           | 运行环境            |
| :------------- | :------------------ |
| ubuntu-latest  | GitHub 托管 Ubuntu  |
| ubuntu-24.04   | Ubuntu 24.04        |
| windows-latest | GitHub 托管 Windows |
| macos-latest   | GitHub 托管 macOS   |

尽管服务器的花销肯定不小,但是Github官方财大气粗,只要你正常使用Actions,是绝对不可能用完免费额度的.

而且,如果是Public仓库,又使用了Github托管的Runner,就不消耗任何额度,除非你要用规模更大的Runner或者改为Private仓库,那才会消耗额度,而这样也有每个月运行2000min的额度,一般来说也够用了.

##### 常用action
基本来说每个Github Action的job都有这一行:
```yml
- uses: actions/checkout@v4
```
它会用git自动从当前Github仓库拉取(fetch)对应提交版本到当前的Runner中,深度为1(即不拉取git历史)

>至于为什么叫checkout,因为老式的git切换分支写法就是`git checkout v6.0`嘛.


#### 总结
实际上我没用多少字数就把Actions的基本原理给介绍清楚了,但如果看官方文档,那是不可能看懂的...

通过GitHub Actions就能很好地理解CI的便利了,编写代码后,如果觉得本地运行测试太麻烦,或者自己本身是在Linux平台写的代码,不确定能不能在Windows上运行,只要提交一次git commit,构建和测试一次完成,彻底解放双手.

至于CD的话,无论是发布博客到Github Pages,还是将新版本的库发布到PyPI,都可以用到Github Actions.


### 跨平台构建
#### 总表
| 时间            | 技术                           | 原本熟悉的技术 → 目标平台                    | 核心实现方式                                                                 | 历史意义 / 今天怎么看                                                                                                                                          |
| --------------- | ------------------------------ | -------------------------------------------- | ---------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **1995**        | **Qt**                         | C++ → Windows/Linux/macOS，后来移动端        | 自己提供跨平台 GUI 抽象层                                                    | 很早的“一套 API 多平台”代表，更像传统跨平台 GUI 框架                                                                                                           |
| **2008**        | **PhoneGap** → Apache Cordova  | HTML/CSS/JS → iOS/Android                    | **WebView + JS↔Native Bridge**                                               | 现代 Hybrid App 路线的重要起点。PhoneGap 2008 年由 Nitobi 开始，2011 年进入 Apache 后成为 Cordova。([Apache Cordova][1])                                       |
| **约 2009**     | **Appcelerator Titanium**      | JavaScript/Web 开发者 → Native Mobile        | JS API 映射到原生能力/控件                                                   | 很早就尝试“用 JS 写原生移动应用”，思想上是 React Native/NativeScript 的前辈。([GitHub][2])                                                                     |
| **2011**        | **NW.js / node-webkit**        | HTML/CSS/JS + Node.js → Desktop              | **Chromium + Node.js**                                                       | Web 技术进入桌面应用的重要先驱，Electron 出现前已经走通这条路；项目始于 2011。([Google Groups][3])                                                             |
| **2011 / 2014** | **Xamarin / Xamarin.Forms**    | C#/.NET → iOS/Android                        | .NET + 原生平台绑定；Forms 再抽象 UI                                         | 把微软/.NET 开发者带到移动端的重要路线；后来被 .NET MAUI 接替，Xamarin 已于 2024 年结束微软支持。([微软学习][4])                                               |
| **2013**        | **Electron（原 Atom Shell）**  | HTML/CSS/JS + Node → Windows/macOS/Linux     | 每个应用携带 **Chromium + Node.js**                                          | Web→桌面的标志性方案。首个 Electron 仓库 commit 是 2013-03-13，2015 年 Atom Shell 正式更名为 Electron。([Electron][5])                                         |
| **2013**        | **Ionic**                      | Web/Angular，后来 React/Vue → Mobile/PWA     | Web UI + Cordova/Capacitor                                                   | 把 Hybrid App 开发做成完整 UI 框架。2013 年出现，今天主要与 Capacitor 配套。([Ionic][6])                                                                       |
| **2014–2015**   | **NativeScript**               | JavaScript/TypeScript/CSS → iOS/Android      | JS Runtime → **真正的原生 UI/API**，不用 WebView 渲染 UI                     | 与 React Native 属于相似时代，但技术实现不同。2014 年 preview，2015 年 1.0。([Telerik.com][7])                                                                 |
| **2015**        | **React Native**               | **React/JavaScript → iOS/Android Native UI** | React reconciler + Native Components                                         | 非常关键的一次转变：不是把网页塞进 WebView，而是把 React 编程模型迁移到原生 UI。iOS 于 2015 年 3 月开源，Android 同年 9 月发布。([Facebook][8])                |
| **2015 → 2018** | **Flutter**                    | Dart → iOS/Android，后来 Web/Desktop         | **自己绘制 UI**，而不是大量依赖系统原生控件                                  | 开辟另一条路线：不是 WebView，也不是 React Native 那种 native-widget 映射，而是跨平台自绘。1.0 于 2018-12-04 发布。([Google开发者博客][9])                     |
| **2017**        | **Kotlin Multiplatform (KMP)** | Kotlin/JVM → Android/iOS/Web/Desktop 等      | **共享业务逻辑**，平台代码可分别实现；后来配合 Compose Multiplatform 共享 UI | 与 RN/Flutter 最大区别是最初并不强迫 UI 也共享。2017 年作为 Kotlin 1.2 experimental multiplatform feature 出现，2023 年 KMP Stable。([The JetBrains Blog][10]) |
| **2018**        | **Capacitor**                  | Web/React/Vue/Angular → iOS/Android/Web      | WebView + 现代 Native Plugin API                                             | Ionic 团队针对 Cordova 时代问题设计的新一代 native runtime；2018 年公布 Alpha。([Ionic][11])                                                                   |
| **2019 → 2022** | **Tauri**                      | HTML/CSS/JS/React/Vue 等 → Desktop           | **系统 WebView + Rust Core**                                                 | 可以看作对 Electron 思路的一次“瘦身”：不捆绑完整 Chromium，而使用 OS WebView。项目从约 2019 年起发展，1.0 于 2022 年 6 月发布。([Tauri][12])                   |
| **2022**        | **.NET MAUI**                  | C#/XAML/.NET → Android/iOS/macOS/Windows     | .NET + 平台原生 UI abstraction                                               | Xamarin.Forms 的正式继任者，2022 年 5 月 GA。([Microsoft for Developers][13])                                                                                  |
| **2024**        | **Tauri 2.0**                  | Web 技术 → **Desktop + iOS + Android**       | System WebView + Rust，移动端插件可接 Swift/Kotlin                           | Tauri 不再只是 Electron 的桌面替代品，而真正进入桌面+移动跨平台领域。2.0 于 2024-10-02 stable。([Tauri][14])                                                   |

[1]: https://cordova.apache.org/announcements/2020/08/14/goodbye-phonegap.html?utm_source=chatgpt.com "Goodbye PhoneGap - Apache Cordova"

[2]: https://github.com/Jasig/titanium_mobile?utm_source=chatgpt.com "GitHub - Jasig/titanium_mobile: Appcelerator Titanium Mobile · GitHub"

[3]: https://groups.google.com/g/nwjs-general/c/LIrC7zHtQdo?utm_source=chatgpt.com "Statement on the history of node-webkit project"

[4]: https://learn.microsoft.com/dotnet/maui/migration/?WT.mc_id=dotnet-35129-website&view=net-maui-8.0&utm_source=chatgpt.com "Upgrade from Xamarin to .NET - .NET MAUI | Microsoft Learn"

[5]: https://www.electronjs.org/blog/10-years-of-electron?utm_source=chatgpt.com "10 years of Electron 🎉 | Electron"

[6]: https://ionic.io/blog/announcing-ionic?utm_source=chatgpt.com "Announcing The Ionic Framework - Ionic Blog"

[7]: https://www.telerik.com/blogs/announcing-nativescript---cross-platform-framework-for-building-native-mobile-applications?utm_source=chatgpt.com "Announcing NativeScript - cross-platform framework for build"

[8]: https://about.fb.com/news/2015/03/f8-day-two-2015/?utm_source=chatgpt.com "F8 2015: Updates on Connectivity Lab, Facebook AI Research and Oculus"

[9]: https://developers.googleblog.com/en/flutter-10-googles-portable-ui-toolkit/?utm_source=chatgpt.com "Flutter 1.0: Google’s Portable UI Toolkit - Google Developers Blog"

[10]: https://blog.jetbrains.com/kotlin/2017/09/kotlin-1-2-beta-is-out/?utm_source=chatgpt.com "Kotlin 1.2 Beta Is Out - The JetBrains Blog"

[11]: https://ionic.io/blog/announcing-capacitor-1-0-0-alpha?utm_source=chatgpt.com "Announcing Capacitor 1.0.0 Alpha - Ionic Blog"

[12]: https://v3.tauri.app/blog/tauri-20/ "Tauri 2.0 Stable Release | Tauri"

[13]: https://devblogs.microsoft.com/dotnet/introducing-dotnet-maui-one-codebase-many-platforms/?utm_source=chatgpt.com "Introducing .NET MAUI - One Codebase, Many Platforms - .NET Blog"

[14]: https://v3.tauri.app/blog/tauri-20/?utm_source=chatgpt.com "Tauri 2.0 Stable Release | Tauri"




```mermaid
flowchart TD
    A[跨平台应用开发]

    subgraph WEB[Web 技术路线]
        direction TB

        subgraph MOBILE[Web → Mobile]
            direction TB
            M1[PhoneGap]
            M2[Cordova]
            M3[Ionic]
            M4[Capacitor]

            M1 --> M2 --> M3 --> M4
        end

        subgraph DESKTOP[Web → Desktop]
            direction TB
            E1[NW.js]
            E2[Electron]
            E3[Tauri]
            E4[iOS / Android 支持<br/>Tauri 2.0]

            E1 --> E2 --> E3 --> E4
        end
    end

    subgraph NATIVE[Native UI 路线]
        direction TB

        N1[Xamarin]
        N2[NativeScript]
        N3[React Native]
        N4[.NET MAUI]

        N1 --> N4
    end

    subgraph DRAW[自绘 UI 路线]
        direction TB

        F1[Flutter]
    end

    A --> WEB
    A --> NATIVE
    A --> DRAW
```
#### 桌面端
##### Electron
- [wiki](https://en.wikipedia.org/wiki/Electron_(software_framework))

Electron是由Github在13年发布的开源打包框架,可以把你的前端应用变成桌面端上的应用程序,著名的应用有VScode,Github Desktop等

缺点是更新太快,但社区活力不够,截止发布了v43版本的当下,官网的文档还是用的22年11月发布的v23版本,这版本号都翻倍了,而且文档里用的还是CommonJS,你就说这怎么看.

运行以下命令获取官方的模板项目:
```bash
git clone https://github.com/electron/minimal-repro.git electron-learn
```
- 很遗憾的是,这个模板项目用的也还是CommonJS

根据Readme文档启动该项目,效果如下:
![示意图](PixPin_2026-07-18_14-50-12.webp)

看一下主要文件`main.js`:
```js
const { app, BrowserWindow } = require('electron')
const path = require('node:path')

function createWindow () {
  // Create the browser window.
  const mainWindow = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      preload: path.join(__dirname, 'preload.js')
    }
  })

  // and load the index.html of the app.
  mainWindow.loadFile('index.html')

}

app.whenReady().then(() => {
  createWindow()

  app.on('activate', function () {
    // On macOS it's common to re-create a window in the app when the
    // dock icon is clicked and there are no other windows open.
    if (BrowserWindow.getAllWindows().length === 0) createWindow()
  })
})

app.on('window-all-closed', function () {
  if (process.platform !== 'darwin') app.quit()
})

```
可以看到Electron的底层与普通的浏览器引擎并没有太大区别,多出来的这些函数也都是调用操作系统接口的封装而已.

总的来说,目前要学习Electron,就需要忍受陈旧的文档和全新的界面操作函数,市面上关于Electron的新书也是聊胜于无,而且不能够复用面向网站的前端写法,后端只能用api调用来实现,开发体验给个2星.

#### 手机端
##### Capacitor
支持ios和安卓端,可以把原生的前端代码包装成webview组件,所以体验效果比较差,甚至不如直接看网站来得好.

#### 多端
##### Tauri
-[wiki](https://en.wikipedia.org/wiki/Tauri_(software_framework))

Tauri是于20年发布的构建工具,支持所有主流桌面和移动平台,比起Electron更加有活力,但由于技术栈比较新,所以基本没有大公司会有Tauri来构建应用.

```bash
pnpm create tauri-app tauri-test
cd tauri-test
pnpm install
pnpm tauri dev
```
运行上述命令后可以构建出以下界面:
![图示](PixPin_2026-07-18_15-18-31.webp)


项目结构如下:
```bash
.
├── package.json
├── index.html
├── src/
│   ├── main.js
├── src-tauri/
│   ├── Cargo.toml
│   ├── Cargo.lock
│   ├── build.rs
│   ├── tauri.conf.json
│   ├── src/
│   │   ├── main.rs
│   │   └── lib.rs
│   ├── icons/
│   │   ├── icon.png
│   │   ├── icon.icns
│   │   └── icon.ico
│   └── capabilities/
│       └── default.json
```

最显眼的地方在于,前端界面可以使用诸如Nextjs等现代前端框架,因为Tauri是通过Webview组件实现应用包装的.

至于后端,可以使用Rust来编写,也可以通过api来调用.这一点也很不错,开发体验给个4.5星.
##### React Native
- [wiki](https://en.wikipedia.org/wiki/React_Native)

React Native由Facebook于15年发布的多平台(除了Linux)打包框架.

##### Flutter
支持全平台,但需要专门学习dart语言,实际上是一个更难用的Javascript




## 个人实践
### 个人项目部署
对于个人项目来说,Docker Compose+Dokploy简直不能太好用,基本的流程如下:

1. 找一个服务器厂商和域名厂商,其中任何一个选了国内的就要备案.
2. 目前Dokploy只支持Ubuntu24及Debian12以下版本,建议用Ubuntu24一键速通即可
3. `ssh root@服务器IP`后安装Dokploy:

```bash
curl -sSL https://dokploy.com/install.sh | sh
```
>如果你像我一样总要反复销毁服务器实例的话,当IP重复导致SSH报错时,用`ssh-keygen -R 报错IP`即可

>当然,如果你用国内平台的话,还需要先用国内镜像源安装Docker:`curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun`.

4. 安装Dokploy后,注册你的Git仓库,导入仓库后Build即可,注入环境变量.由于Dokploy会自动配置Traefik,所以需要将无端口的完整域名导引到你的Nignx或者其他反向代理上,这需要在Domain页中配置.

通常来讲,个人小项目选择最低配置即可(如1核/2核的2G内存,20/30G的硬盘就足够了)
#### 腾讯云实践
腾讯云刚好有一个月的轻量服务器免费用,记录一下踩坑:
1. 先装Docker的阿里云镜像再装Dokploy,否则会非常麻烦
2. Dokploy需要开放3000端口,而腾讯云的防火墙很严格,所以需要检查服务器的防火墙是否放行3000端口
   1. 折腾这个折腾了二十分钟
### IPv6和IPv4问题(11/19)
我们在进行本地开发时,有时候会写数据库或者其他服务的开放port为`127.0.0.1`,如:`"127.0.0.1:5432"`,有时候会写port为`"localhost:5432"`,一般来说,我们会认为二者是等价的,但其实并不是,这中间有一点误区.

首先,localhost就是一个hostname,需要被电脑解析为一个指向自身网络的IP地址,这被称为回环地址.

在IPv6和IPv4并行的现在,localhost会被解析为两种回环地址,一个是IPv6的`::1`,一个是IPv4的超大回环地址集,通常选用`127.0.0.1`.

在docker中,当我们填写Postgres的端口映射为`"127.0.0.1:5432:5432`时,它指向的其实是IPv4地址,不会接收IPv6地址,如果你的后端服务将`localhost`先解析为IPv6地址,试图通过`::1`来连接,就有可能出问题.

但如果我们将端口映射填写为`5432:5432`,则一般不会有问题,如果用IPv4连接,Docker就用IPv4回答,如果用IPv6连接,Docker就用IPv6回答.

# 后端专题
>[!TIP]
>曾经我在给每个编程语言都写了几万字的笔记,后来发现基本全是废话,没有什么可读性,远不如专业技术书籍来得有用,真遇到不会的了,也不如查AI来的快,所以,我现在只会放自己的心得了.
## 共性与杂谈
### Markup Language的历史
关键技术的时间线:
| 时间           | 名称                         | 类型                | 主要用途             | 历史地位 / 今天状态                  |
| -------------- | ---------------------------- | ------------------- | -------------------- | ------------------------------------ |
| **1964**       | **RUNOFF**                   | 过程式标记/文本排版 | 文档排版             | 最早的重要计算机文本标记系统之一     |
| **1969**       | **GML**                      | 描述性标记          | IBM 文档             | SGML 的直接祖先                      |
| **1978**       | **TeX**                      | 排版语言/宏语言     | 数学、科技出版       | 至今仍极重要                         |
| **1984–1985**  | **LaTeX**                    | 高层排版标记系统    | 科研论文、图书       | 至今科研领域主流                     |
| **1986**       | **SGML**                     | 元标记语言          | 大型结构化文档       | HTML、XML 的重要祖先                 |
| **1990–1991**  | **HTML**                     | 超文本标记语言      | Web 页面             | 当今最重要的标记语言之一             |
| **1991**       | **DocBook**                  | SGML/XML 文档语言   | 技术书籍、软件文档   | 技术出版经典标准                     |
| **1992**       | **Setext**                   | 轻量级标记          | 邮件、电子出版       | Markdown 等思想的先驱之一            |
| **1995**       | **Wiki markup / WikiText**   | 轻量级标记          | Wiki                 | 开创“普通人直接编辑网页”模式         |
| **1998**       | **XML**                      | 元标记语言          | 数据和文档结构       | 企业系统、配置、协议、文档中仍很重要 |
| **1998**       | **BBCode**                   | 轻量级标记          | 论坛                 | 2000 年代论坛时代极常见              |
| **2000**       | **XHTML**                    | XML 化 HTML         | Web                  | 曾被认为是 HTML 的未来，后来路线失败 |
| **2001**       | **reStructuredText**         | 轻量级标记          | Python 文档          | Python/Sphinx 生态仍重要             |
| **2001**       | **SVG**                      | XML 图形标记        | 矢量图形             | 至今 Web 核心格式                    |
| **2001–2002**  | **MediaWiki WikiText**       | Wiki 标记           | Wikipedia            | 世界上影响最大的 Wiki 标记之一       |
| **2004**       | **Markdown**                 | 轻量级标记          | Web、README、文档    | 当今最普及轻量标记语言               |
| **2008–2010s** | **GitHub Flavored Markdown** | Markdown 方言       | GitHub               | 程序员事实上的常用 Markdown          |
| **2014 前后**  | **R Markdown**               | Markdown 扩展       | 数据分析、科研报告   | R / 数据科学领域广泛使用             |
| **2018 前后**  | **MDX**                      | Markdown + JSX      | React 文档、内容网站 | 前端生态重要混合格式                 |
| **2022–2023**  | **Typst**                    | 标记式排版语言      | 科研论文、排版       | 新一代 LaTeX 竞争者                  |

- 最后一个Typst我一开始是很看好的,现在的热度也确实起来了,希望能够早日取代Latex,简直不是人写的.不过话说回来我又用不到.

### 斜杠(Slash)和反斜杠(Backslash)
* `/`：**正斜杠 (Forward Slash)**，主要用于 Linux、macOS 文件路径、URL、Docker 路径，以及命令行选项等。
* `\`：**反斜杠 (Backslash)**，主要用于 Windows 文件路径、编程语言转义、Bash/Dockerfile等的换行。

简单来说,无脑用`/`,只有Windows,转义,换行要考虑用`\`.

### GitHub Flavored Markdown,GFM
- [参考文章](https://github.com/guodongxiaren/README)

值得一提的是hugo也内置了对GFM的支持,感兴趣的博主可以在里面测试一下.
#### Alerts
```md
> [!NOTE]
> 这是一个提示信息

> [!TIP]
> 这是一个技巧提示

> [!IMPORTANT]
> 这是重要信息

> [!WARNING]
> 这是警告信息

> [!CAUTION]
> 这是危险警告
```
![图示](PixPin_2026-07-31_16-14-52.webp)

在hugo上的效果如下:
> [!NOTE]
> 这是一个提示信息

> [!TIP]
> 这是一个技巧提示

> [!IMPORTANT]
> 这是重要信息

> [!WARNING]
> 这是警告信息

> [!CAUTION]
> 这是危险警告
#### diff
其语法与代码高亮类似，只是在三个反引号后面写diff，
并且其内容中，可以用 `+ `开头表示新增，`- `开头表示删除。
另外还有有 `!`和`#`的语法。

```diff
+ 人闲桂花落，
- 夜静春山空。
! 月出惊山鸟，
# 时鸣春涧中。
```
### 各门语言中导入机制的处理(待补充)
一开始以为导入不就是将文件插入过来合并到一起嘛,后来发现除了C/Cpp之外,其他语言的做法都不是这样
### 正则表达式

## Python
### 搭建GPU环境(26/1)
先在nvidia官网下载cuda13.0,然后根据这个toml运行uv sync即可:
```toml
[project]
name = "ml"
version = "0.1.0"
description = "Add your description here"
readme = "README.md"
requires-Python = ">=3.13"
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

测试代码:
```py
import torch
print(f"CUDA status: {torch.cuda.is_available()}")
print(f"CUDA version: {torch.version.cuda}")
```
输出结果:
```bash
uv run ch1.py
CUDA status: True
CUDA version: 13.0
```
### Python管理器历史-AI
| 时间      | 代表工具       | 解决的问题                           | 后来的地位         |
| --------- | -------------- | ------------------------------------ | ------------------ |
| 1998–2000 | `distutils`    | 构建、打包、安装 Python 包           | 已淘汰             |
| 2004      | `setuptools`   | 增强 distutils、依赖声明、Egg        | 仍是重要构建后端   |
| 2004      | `easy_install` | 自动从 PyPI 下载并安装依赖           | 被 pip 取代        |
| 2007 左右 | `virtualenv`   | 项目间 Python 环境隔离               | 仍存在             |
| 2008      | `pip`          | 更可靠的包安装                       | 长期事实标准       |
| 2012      | `venv`         | 官方标准库虚拟环境                   | 仍广泛使用         |
| 2012 前后 | `conda`        | Python + 非 Python 依赖 + 环境       | 科学计算领域仍重要 |
| 2010s     | `pyenv`        | 管理多个 Python 解释器版本           | 仍常用             |
| 2015 前后 | `pip-tools`    | 依赖解析、锁定                       | 仍在维护           |
| 2017 前后 | `Pipenv`       | pip + virtualenv + lockfile          | 影响大，但热度下降 |
| 2018 前后 | `Poetry`       | 依赖、环境、构建、发布统一           | 至今主流           |
| 2020      | `PDM`          | 基于 `pyproject.toml` 的现代项目管理 | 至今活跃           |
| 2022      | Hatch v1       | 构建、环境、测试、发布               | PyPA 项目          |
| 2023      | Rye            | Python 安装 + 环境 + 包 + 项目统一   | 已停止开发         |
| 2024      | **uv**         | 高性能统一 Python 管理               | 当前快速成为主流   |

uv彻底终结了比赛,并让python的学习变得异常轻松.


### PEP介绍
- [PEP1](https://peps.python.org/pep-0001/)

PEP的全称为Python Enhancement Proposal,于2000年的PEP1正式提出,用于收集Python社区中的决策记录,提案和总结.PEP的类型有三种:
1. Standards Track PEP: 介绍Python的新特性
2. Informational PEP: 用于描述Python相关的设计提案,或者用于通知和指导.**users and implementers are free to ignore Informational PEPs or follow their advice.**
3. Process PEP: 类似于第一种PEP,但更多的注重于开发流程

PEP的编号并不是按照时间线来的,而是按照PEP的功能决定编号范围:

| 编号范围  | 分配逻辑                                                    | 例子                      |
| --------- | ----------------------------------------------------------- | ------------------------- |
| 0—99      | 主要保留给元 PEP，即管理其他 PEP 或规定开发流程、规范的提案 | PEP 1、PEP 8              |
| 100—999   | 常规提案编号，涵盖语言特性、开发流程等                      | PEP 255、PEP 342、PEP 492 |
| 3000—3099 | 专门为 Python 3000（Python 3）规划的元 PEP 编号段           | PEP 3000                  |
| 3100—3999 | 最初为 Python 3000 的功能提案规划的编号段                   | PEP 3156                  |

如果你不是核心开发者,就必须要找到一个Sponsor(通常是核心开发者)来帮你正式提交该PEP,并由PEP委员会来审核该PEP,并经过广泛的讨论后才可以正式作为某个PEP存在,并由委员会分配PEP编号,一经确认则不会重新编号,通常来讲,编号是在给定的编号范围内逐渐递增的.

>PEP 编辑不会无故拒绝发布 PEP。拒绝发布 PEP 的理由包括：工作重复、技术上不合理、未能提供充分的动机或解决向后兼容性问题，或者不符合 Python 的理念。在审批阶段可以咨询指导委员会，指导委员会对草案是否符合 PEP 的要求拥有最终决定权
#### 重要PEP
- AI总结的,毕竟我不可能去一个个翻吧...

以下整理了 Python 发展史上具有代表性的 49 份 PEP，按照语言设计、迭代与异步、类型系统、后端生态、解释器优化以及社区治理六个方向分类。

对于语言功能，年份以首次正式发布的 Python 版本为主；对于治理和生态规范，则以提案创建或正式形成的时间为主。

1\. Python 语言设计与基础语法

| 年份 / 版本 | PEP（官方原文）                                                                        | 主要内容与历史意义                                                           |
| ----------- | -------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| 2000 · 2.0  | [PEP 202](https://peps.python.org/pep-0202/) — List Comprehensions                     | 列表推导式：引入 `[x for x in items]`，简化集合数据处理。                    |
| 2001 · 2.2  | [PEP 234](https://peps.python.org/pep-0234/) — Iterators                               | 迭代器协议：奠定现代 `iter()`、`next()` 和 `for` 迭代机制的基础。            |
| 2001 · 2.2  | [PEP 255](https://peps.python.org/pep-0255/) — Simple Generators                       | 生成器：引入 `yield`，允许函数暂停、返回值并恢复运行。                       |
| 2004 · 2.4  | [PEP 318](https://peps.python.org/pep-0318/) — Decorators                              | 装饰器：引入 `@decorator`，成为 FastAPI 路由等 API 的语法基础。              |
| 2006 · 2.5  | [PEP 343](https://peps.python.org/pep-0343/) — The with Statement                      | 上下文管理器：引入 `with`，统一资源获取和释放操作。                          |
| 2008 · 3.0  | [PEP 3107](https://peps.python.org/pep-3107/) — Function Annotations                   | 函数注解：建立参数及返回值注解的语言基础。                                   |
| 2012 · 3.3  | [PEP 380](https://peps.python.org/pep-0380/) — Syntax for Delegating to a Subgenerator | 生成器委托：引入 `yield from`，简化嵌套生成器。                              |
| 2016 · 3.6  | [PEP 498](https://peps.python.org/pep-0498/) — Literal String Interpolation            | f-string：引入 `f"{value}"` 字符串插值。                                     |
| 2018 · 3.7  | [PEP 557](https://peps.python.org/pep-0557/) — Data Classes                            | 数据类：引入 `@dataclass`，自动生成初始化、比较等方法。                      |
| 2019 · 3.8  | [PEP 572](https://peps.python.org/pep-0572/) — Assignment Expressions                  | 海象运算符：支持在表达式中使用 `:=` 赋值。                                   |
| 2021 · 3.10 | [PEP 634](https://peps.python.org/pep-0634/) — Structural Pattern Matching             | 结构化模式匹配：引入 `match` / `case`，匹配复杂数据结构。                    |
| 2022 · 3.11 | [PEP 654](https://peps.python.org/pep-0654/) — Exception Groups and except\*           | 异常组：引入 `ExceptionGroup` 和 `except*`，支持处理并发任务产生的多个异常。 |
| 2023 · 3.12 | [PEP 701](https://peps.python.org/pep-0701/) — Syntactic Formalization of f-strings    | f-string 语法改革：规范语法并解除部分表达式限制。                            |
| 2025 · 3.14 | [PEP 750](https://peps.python.org/pep-0750/) — Template Strings                        | 模板字符串：引入 `t"..."`，为自定义、安全的字符串处理提供结构化模板。        |

2\. 生成器、协程和异步编程

这一组与 `asyncio`、`yield`、`async/await` 关系最直接。

| 年份 / 版本 | PEP（官方原文）                                                                       | 核心贡献                                                                                        |
| ----------- | ------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| 2006 · 2.5  | [PEP 342](https://peps.python.org/pep-0342/) — Coroutines via Enhanced Generators     | 增强生成器：引入 `send()`、`throw()`、`close()`，让生成器能够承担协程功能。                     |
| 2014 · 3.4  | [PEP 3156](https://peps.python.org/pep-3156/) — Asynchronous IO Support Rebooted      | asyncio：建立统一异步 I/O 框架，提供事件循环及协程调度基础。                                    |
| 2015 · 3.5  | [PEP 492](https://peps.python.org/pep-0492/) — Coroutines with async and await syntax | async/await：将原生协程作为独立语言概念，引入 `async def`、`await`、`async with`、`async for`。 |
| 2016 · 3.6  | [PEP 525](https://peps.python.org/pep-0525/) — Asynchronous Generators                | 异步生成器：支持在 `async def` 中使用 `yield`。                                                 |
| 2016 · 3.6  | [PEP 530](https://peps.python.org/pep-0530/) — Asynchronous Comprehensions            | 异步推导式：支持 `[x async for x in items]`。                                                   |
| 2018 · 3.7  | [PEP 567](https://peps.python.org/pep-0567/) — Context Variables                      | contextvars：为并发异步任务提供正确隔离的上下文变量。                                           |

这几份 PEP 之间存在清晰的技术演进关系：
```mermaid

flowchart TD
    A["PEP 255 · yield<br/>2001 · 生成器"]
    B["PEP 342 · 增强生成器<br/>2005 · 生成器与协程"]
    C["PEP 380 · yield from<br/>2009 · 生成器委托"]
    D["PEP 3156<br/>asyncio 框架"]
    E["PEP 492<br/>async / await"]
    F["PEP 525 / 530 / 567<br/>异步生成器、异步推导式、任务上下文"]

    A --> B
    B --> C
    C --> D
    C --> E
    D --> F
    E --> F

    style A fill:#E3F2FD,stroke:#64B5F6,color:#1565C0
    style B fill:#E3F2FD,stroke:#64B5F6,color:#1565C0
    style C fill:#E3F2FD,stroke:#64B5F6,color:#1565C0
    style D fill:#E8F5E9,stroke:#81C784,color:#2E7D32
    style E fill:#E8F5E9,stroke:#81C784,color:#2E7D32
    style F fill:#F3E5F5,stroke:#BA68C8,color:#7B1FA2
```

3\. Python 类型系统与现代面向对象编程

| 年份 / 版本 | PEP（官方原文）                                                                              | 核心贡献                                                               |
| ----------- | -------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| 2015 · 3.5  | [PEP 484](https://peps.python.org/pep-0484/) — Type Hints                                    | 类型提示：建立 Python 静态类型系统的基础，引入标准化的 `typing` 约定。 |
| 2016 · 3.6  | [PEP 526](https://peps.python.org/pep-0526/) — Syntax for Variable Annotations               | 变量类型注解：引入 `name: str` 等语法。                                |
| 2019 · 3.8  | [PEP 544](https://peps.python.org/pep-0544/) — Protocols: Structural subtyping               | Protocol：引入基于结构的静态子类型机制，支持静态鸭子类型。             |
| 2020 · 3.9  | [PEP 585](https://peps.python.org/pep-0585/) — Type Hinting Generics In Standard Collections | 内置泛型：允许使用 `list[str]`、`dict[str, int]`。                     |
| 2021 · 3.10 | [PEP 604](https://peps.python.org/pep-0604/) — Union Types                                   | 联合类型新语法：允许使用 `str \\| None`。                              |
| 2023 · 3.12 | [PEP 695](https://peps.python.org/pep-0695/) — Type Parameter Syntax                         | 泛型语法改革：支持 `class Box[T]`、`def func[T](...)`。                |
| 2025 · 3.14 | [PEP 649](https://peps.python.org/pep-0649/) — Deferred Evaluation of Annotations            | 延迟求值注解：改善前向引用、循环依赖及运行时读取注解的问题。           |

这组提案尤其值得 Python 后端开发者关注。例如，FastAPI 和 Pydantic 广泛使用类型注解，而 `Protocol` 则可以帮助我们在设计仓储接口、领域服务接口时减少对具体实现类的依赖。

需要区分：类型注解并不等同于 Python 自动执行运行时类型检查。PEP 484 的主要目标是支持静态分析；Pydantic 的运行时校验是其自身实现的行为。

4\. Python Web、数据库与项目工程化

| 年份 / 版本      | PEP（官方原文）                                                                             | 核心贡献                                                                 |
| ---------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| 1999 · 早期规范  | [PEP 249](https://peps.python.org/pep-0249/) — Python DB API 2.0                            | 数据库接口规范：统一 Python 数据库驱动的连接、游标和异常等 API。         |
| 2003 · 规范      | [PEP 333](https://peps.python.org/pep-0333/) — WSGI                                         | Web 服务器接口：定义 Web 服务器与 Python 应用之间的标准接口。            |
| 2010 · 规范      | [PEP 3333](https://peps.python.org/pep-3333/) — WSGI 1.0.1                                  | 更新 WSGI 规范以适配 Python 3。                                          |
| 2014 · 3.4       | [PEP 453](https://peps.python.org/pep-0453/) — Explicit bootstrapping of pip                | pip 安装机制：通过 `ensurepip` 为 Python 安装环境提供 pip 引导支持。     |
| 2016—2017 · 规范 | [PEP 517](https://peps.python.org/pep-0517/) / [PEP 518](https://peps.python.org/pep-0518/) | 构建系统标准化：定义构建前后端接口，以及 `pyproject.toml` 构建依赖配置。 |
| 2020 · 规范      | [PEP 621](https://peps.python.org/pep-0621/) — Storing project metadata in pyproject.toml   | 项目元数据：统一 `[project]` 中的包名、版本、依赖等配置。                |
| 2021 · 规范      | [PEP 668](https://peps.python.org/pep-0668/) — Externally Managed Environments              | 包安装环境保护：避免 pip 随意破坏系统包管理器维护的 Python 环境。        |
| 2023 · 规范      | [PEP 723](https://peps.python.org/pep-0723/) — Inline Script Metadata                       | 单文件脚本元数据：允许在 Python 脚本注释中声明运行环境和依赖。           |

PEP 249 有一个特殊情况：官方文档的创建日期是 1999 年 4 月，早于 2000 年的 PEP 制度正式建立。这反映了其作为早期数据库 API 规范被纳入 PEP 文档体系的历史背景。

另外，ASGI 并不是一个对应某份正式 PEP 的标准。它由 Python 异步 Web 生态发展形成，因此不要把 WSGI 的 PEP 333 与现代 ASGI 混为一谈。

5\. CPython 解释器、GIL 与性能优化

| 年份 / 版本 | PEP（官方原文）                                                                      | 核心贡献                                                                                                       |
| ----------- | ------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------- |
| 2022 · 3.11 | [PEP 659](https://peps.python.org/pep-0659/) — Specializing Adaptive Interpreter     | 自适应专门化解释器：通过字节码专门化提高 CPython 执行性能。                                                    |
| 2023 · 3.12 | [PEP 684](https://peps.python.org/pep-0684/) — A Per-Interpreter GIL                 | 解释器级 GIL：允许满足隔离条件的子解释器拥有独立 GIL。                                                         |
| 2024 · 3.13 | [PEP 703](https://peps.python.org/pep-0703/) — Making the GIL Optional               | 可选无 GIL 构建：引入实验性的 Free-threaded Python 构建。                                                      |
| 2025 · 3.14 | [PEP 779](https://peps.python.org/pep-0779/) — Free-threaded Python Support Criteria | 自由线程正式支持阶段：推动 Free-threaded Python 从实验性阶段走向正式支持，但仍属于可选构建，并未成为默认模式。 |

这组提案体现了近年来 Python 的另一条重要演化方向：在保持动态语言开发体验的同时，改善解释器性能与多核并行能力。

6\. Python 语言理念、版本演进与治理

| 年份 | PEP（官方原文）                                                               | 核心意义                                                       |
| ---- | ----------------------------------------------------------------------------- | -------------------------------------------------------------- |
| 2000 | [PEP 1](https://peps.python.org/pep-0001/) — PEP Purpose and Guidelines       | PEP 制度本身：规定提案目的、分类、流程及审议机制。             |
| 2000 | [PEP 0](https://peps.python.org/) — PEP Index                                 | 提案总索引：组织全部 PEP 的编号、类别和状态。                  |
| 2001 | [PEP 8](https://peps.python.org/pep-0008/) — Style Guide for Python Code      | Python 代码风格：规定命名、缩进、代码布局等编程规范。          |
| 2001 | [PEP 257](https://peps.python.org/pep-0257/) — Docstring Conventions          | 文档字符串规范：规定函数、类、模块的文档字符串写法。           |
| 2004 | [PEP 20](https://peps.python.org/pep-0020/) — The Zen of Python               | Python 之禅：概括简单、显式、可读等语言设计理念。              |
| 2006 | [PEP 3000](https://peps.python.org/pep-3000/) — Python 3000                   | Python 3 设计纲领：明确 Python 3.0 的重大改革原则。            |
| 2009 | [PEP 387](https://peps.python.org/pep-0387/) — Backwards Compatibility Policy | 向后兼容政策：规定兼容性、弃用和破坏性变更的处理原则。         |
| 2018 | [PEP 8016](https://peps.python.org/pep-8016/) — The Steering Council Model    | 治理改革方案：提出指导委员会制度，后来成为正式治理机制的基础。 |
| 2018 | [PEP 13](https://peps.python.org/pep-0013/) — Python Language Governance      | 现行治理制度：确立核心开发者与 Steering Council 的权力和职责。 |
| 2019 | [PEP 602](https://peps.python.org/pep-0602/) — Annual Release Cycle           | 年度发布周期：从 Python 3.9 起采用每年一次功能版本发布的节奏。 |
### 生成器和迭代器
#### 基本概念
- **可迭代对象（Iterable）**：能够提供迭代器的对象，例如 `list`、`tuple`、`dict`。  
- **迭代器（Iterator）**：能够通过 `next()` 逐个返回元素的对象。  
- **生成器（Generator）**：一种特殊的迭代器，通常通过 `yield` 创建，可以自动保存和恢复执行状态。

![包含关系](PixPin_2026-10-09_10-04-31.webp)

例如,Python中的for循环就是通过Iter实现的:
```py
numbers = [10, 20, 30]

for number in numbers:
    print(number)
```
上述代码实际上是:
```py
numbers = [10, 20, 30]

iterator = iter(numbers)

while True:
    try:
        number = next(iterator)
        print(number)
    except StopIteration:
        break
```

这总共涉及了三个关键概念:

| 操作             | 作用                   |
| ---------------- | ---------------------- |
| `iter(obj)`      | 从可迭代对象获取迭代器 |
| `next(iterator)` | 获取迭代器的下一个元素 |
| `StopIteration`  | 告诉调用方迭代已经结束 |

总的来说,典型的Iterator必须包含两个方法:
```py
def __iter__(self):
    return self

def __next__(self):
    ...
```
而列表自己只支持iter,不支持next方法,这是因为它只是一个存储工具,不应该涉及遍历的状态管理,通过for循环的封装来遍历就足够了.因此dcit/tuple/str/range等对象通通只是Iter,而不是Iterator.


手写next和iter毕竟还是太麻烦了,所以Python引入了yield关键字,用于包装next和StopIteration,从而实现逐个迭代对象的功能.
#### 历史提案
1. PEP234: 引入了next迭代和Iterator
2. PEP255: 在该提案发布时,想要动态取值只能通过回调函数实现,或者通过Iterator加上next迭代,但是如此一来每次调用时都要记住还剩多少个值没迭代.
   1. 该提案从其他高级语言如Sather和Icon中借鉴了Generator的思想,从而让函数可以从上次中断的地方继续执行
3. PEP288: 最终合并到PEP343/342中,由with关键字杀死了比赛
4. PEP342: 引入了send方法,尽管我从来没见过也从没用过;支持yield作为右值,即放在等号右边,可以返回值.
#### 从类型注释来看
Typing库中有三个相关的类型注释,也非常重要:
```py
from typing import Iterable, Iterator, Generator


# 1. Iterable：可迭代对象
# 只需要实现 __iter__()，返回一个迭代器
class NumberIterable(Iterable[int]):
    def __init__(self, numbers: list[int]):
        self.numbers = numbers

    def __iter__(self) -> Iterator[int]:
        return NumberIterator(self.numbers)


# 2. Iterator：迭代器
# 需要实现 __iter__() 和 __next__()
# 自己记录迭代进度
class NumberIterator(Iterator[int]):
    def __init__(self, numbers: list[int]):
        self.numbers = numbers
        self.index = 0

    def __iter__(self) -> Iterator[int]:
        return self

    def __next__(self) -> int:
        if self.index >= len(self.numbers):
            raise StopIteration

        value = self.numbers[self.index]
        self.index += 1
        return value


# 3. Generator：生成器
# 使用 yield 自动实现迭代器协议
def number_generator() -> Generator[int, None, None]:
    print("生成器开始执行")

    for number in [1, 2, 3]:
        yield number


# ===== 验证三者的区别 =====

# Iterable：这里每次迭代都会创建新的迭代器
iterable = NumberIterable([1, 2, 3])

print(list(iterable))  # [1, 2, 3]
print(list(iterable))  # [1, 2, 3]


# Iterator：记录迭代状态，逐个消耗元素
iterator = iter(iterable)

print(next(iterator))  # 1
print(list(iterator))  # [2, 3]
print(list(iterator))  # []


# Generator：调用函数不会立即执行函数体
generator = number_generator()

print("生成器已创建")
print(next(generator))  # 开始执行，返回 1
print(list(generator))  # [2, 3]
print(list(generator))  # []
```
其中,Generator有三个参数,是因为它不仅可以产生值,还可以接受外部给的值并在结束时返回结果:
```py
Generator[YieldType, SendType, ReturnType]
```

示例代码:
```py
def example() -> Generator[int, str, bool]:
    message = yield 100
    print(message)
    return True


g = example()

print(next(g))          # 100
g.send("Hello")         # 打印 Hello，然后抛出 StopIteration
```
### 异步(10/10)

#### asyncio
>鉴于Python官方自己也知道自己的官方库文档不具备什么可读性,于是设立了一个[Howto](https://docs.python.org/zh-cn/3/howto/index.html)栏目,其中就有对asyncio的详细阐述,毕竟这可是python中举足轻重的库了,而里面的论述也还不错

asyncio中的一切都是围绕事件循环展开的,事件循环包含一组等待运行的Task,有些Task是代码中主动添加的,有些是由asyncio自己添加的.

事件循环会从Task队列中取出一个唤醒,一旦它暂停或者完成,就会将控制权返回给事件循环.此过程将无限地重复，事件循环也不停地循环下去。 如果没有待执行的作业，事件循环会足够智能地转入休息状态以避免浪费 CPU 周期，并在有更多工作需完成时恢复运行。

而Task粗略来说就是一个Coroutine,而asyncio负责将Task和事件循环自动关联起来:
```py
import asyncio

async def main():
    # 执行各种稀奇古怪、天马行空的异步操作……
    ...

if __name__ == "__main__":
    asyncio.run(main())
    # 直到协程 main() 结束，程序才会到达下面的打印语句。
    print("coroutine main() is done!")
```


#### 协程原理
至于协程与进程的关系,看下图即可:

```mermaid

flowchart TD
    P["Python 进程"]
    P --> T1["线程 1"]
    P --> T2["线程 2"]
    T1 --> EL["asyncio Event Loop"]
    EL --> C1["协程 A"]
    EL --> C2["协程 B"]
    EL --> C3["协程 C"]
    T2 --> B["普通同步任务"]
    style EL fill:#DCEBFA,stroke:#4289CB,color:#174D82
```

#### PEP历史
- 首先得先了解生成器和迭代器相关的PEP历史再来看这里

1. PEP380: 提出新表达式`yield from <expr>`,expr是一个可迭代对象.即用于帮助一个生成器调用另一个生成器
2. PEP3156: 引入asyncio包和事件循环,协程,Future与Task
3. PEP492: 引入aysnc,await关键字,`async def`用于声明一个协程(即使内部没有await关键字),在被调用时会返回一个协程对象
   1. await关键字用于获取协程的执行结果,它会暂停协程的执行,直到被等待的函数执行完毕并返回结果,才会重新激活原协程:

```py
async def read_data(db):
    data = await db.fetch('SELECT ...')
    ...
```

4. PEP525: 引入异步生成器,即在async def的函数中使用`yield`

### 并发与多线程(10/10)
#### 基本概念
- Concurrency（并发）：多个任务在同一时间段内推进，不要求同一时刻执行。
- Parallelism（并行）：多个任务在同一时刻真正执行，通常需要多个 CPU 核心。

| 执行方式                                                   | Concurrency（并发） | Parallelism（并行）   |
| :--------------------------------------------------------- | :------------------ | :-------------------- |
| **asyncio**（单线程事件循环）                              | 是                  | 否                    |
| **ThreadPoolExecutor**（传统 CPython，纯 Python CPU 任务） | 是                  | 通常否（受 GIL 限制） |
| **ThreadPoolExecutor**（I/O 任务）                         | 是                  | I/O 操作可重叠        |
| **ProcessPoolExecutor**（多核 CPU）                        | 是                  | 是                    |

```mermaid

flowchart TD
    A["concurrent.futures.Executor<br/>抽象基类"]
    A --> B["ThreadPoolExecutor<br/>线程池"]
    A --> C["ProcessPoolExecutor<br/>进程池"]
    A --> D["InterpreterPoolExecutor<br/>多解释器池 · Python 3.14+"]
    B -.-> E["threading<br/>线程机制"]
    C -.-> F["multiprocessing<br/>进程机制"]
    D -.-> G["多个独立解释器"]
    classDef root fill:#E3F2FD,stroke:#64B5F6,color:#174D82
    classDef impl fill:#E8F5E9,stroke:#81C784,color:#256339
    class A root
    class B,C,D impl
```

#### PEP历史
1. PEP371: 引入multiprocessing库,通过模仿threading库(在98年引入),实现了一种基于进程的线程编程方法,有效地绕过了GIL,实际上来说,就是多进程而已
2. PEP3148: 引入顶级包concurrent,子包executor和future.
   1. Executor是一个抽象类,提供异步执行的方法,并有两个子类ProcessPoolExecutor和ThreadPoolExecutor,支持map方法.
   2. Future表示Executor类的执行结果
   3. 本模块的设计很大程度上受到了 Java java.util.concurrent 包的影响
### Python Web(10/10)
#### 概貌
| 类型           | 代表技术                                    | 核心职责                                 |
| :------------- | :------------------------------------------ | :--------------------------------------- |
| **接口规范**   | CGI、WSGI、ASGI                             | 规定服务器与应用程序如何通信             |
| **应用服务器** | Gunicorn、uWSGI、Uvicorn、Daphne、Hypercorn | 接收 HTTP 连接，管理请求、应用调用及响应 |
| **Web 框架**   | Django、Flask、Starlette、FastAPI           | 提供路由、请求处理、业务开发等能力       |

1990-2014是CGI和WSGI的时代,而之后则是ASGI的时代:

| 年份         | 技术 / 项目                                                             | 类型                   | 主要贡献与历史意义                                                                             |
| ------------ | ----------------------------------------------------------------------- | ---------------------- | ---------------------------------------------------------------------------------------------- |
| 1990年代初   | CGI（Common Gateway Interface）                                         | 接口规范               | 允许 Web 服务器调用外部程序动态生成 HTTP 响应，是早期 Python Web 开发的重要方式                |
| 1990年代中期 | FastCGI                                                                 | 接口协议               | 通过持久化应用进程，减少传统 CGI 每次请求启动程序的开销                                        |
| 2002         | [Twisted](https://twisted.org/)                                         | 异步网络框架 / 服务器  | 基于 Reactor 事件循环提供网络服务，早于 Python `asyncio` 十余年                                |
| 2003         | [PEP 333 — WSGI](https://peps.python.org/pep-0333/)                     | 接口规范               | 提出统一的 Python Web Server Gateway Interface，解耦 Web 服务器与应用框架                      |
| 2005         | [Django](https://www.djangoproject.com/)                                | Web 框架               | 推广完整的 Python Web 开发体系，后来支持 WSGI                                                  |
| 2006         | [wsgiref](https://docs.python.org/3/library/wsgiref.html)               | 标准库 / 参考服务器    | 在 Python 2.5 中提供 WSGI 参考实现及测试工具                                                   |
| 2007         | [mod_wsgi](https://modwsgi.readthedocs.io/)                             | Apache 模块            | 让 Apache HTTP Server 可以托管符合 WSGI 规范的 Python 应用                                     |
| 2009         | [Tornado](https://www.tornadoweb.org/)                                  | 异步 Web 框架 / 服务器 | 面向大量并发连接和长轮询场景，提供自己的事件循环及 HTTP 服务器                                 |
| 2009         | [uWSGI](https://uwsgi-docs.readthedocs.io/)                             | 应用服务器             | 提供进程管理、WSGI 应用托管和多协议支持                                                        |
| 2009—2010    | [Gunicorn](https://gunicorn.org/)                                       | 应用服务器             | 基于 Pre-fork 多进程模型托管 Python 应用，2010 年正式公开发行                                  |
| 2010         | [Flask](https://flask.palletsprojects.com/)                             | Web 框架               | 将轻量级 WSGI 应用开发推广为主流方式                                                           |
| 2010         | [PEP 3333 — WSGI 1.0.1](https://peps.python.org/pep-3333/)              | 接口规范               | 更新 WSGI 对 Python 3 字符串和字节数据的处理规则                                               |
| 2011         | [Waitress](https://docs.pylonsproject.org/projects/waitress/en/stable/) | WSGI 服务器            | 提供跨平台、纯 Python 的生产级 WSGI HTTP 服务器                                                |
| 2014         | [PEP 3156 — asyncio](https://peps.python.org/pep-3156/)                 | 异步运行框架           | 为 Python 提供标准化事件循环、Future、Task 等异步机制                                          |
| 2015         | [PEP 492 — async/await](https://peps.python.org/pep-0492/)              | 语言特性               | 原生支持协程，让异步服务器和异步框架的开发更加自然                                             |
| 2015—2016    | ASGI 早期规范                                                           | 接口规范               | 从 Django Channels 生态中发展出来，支持异步交互和 WebSocket                                    |
| 2015—2016    | [Daphne](https://github.com/django/daphne)                              | ASGI 服务器            | 第一批 ASGI 服务器实现，服务于 Django Channels                                                 |
| 2016         | [uvloop](https://github.com/MagicStack/uvloop)                          | 事件循环实现           | 基于 libuv 实现高性能 asyncio 事件循环，可供服务器使用                                         |
| 2017         | [ASGI 2.0](https://asgi.readthedocs.io/en/latest/specs/main.html)       | 接口规范               | 2017 年 11 月形成不依赖 Channel Layer 的新接口设计                                             |
| 2017         | [Uvicorn](https://uvicorn.dev/)                                         | ASGI 服务器            | 提供轻量、高性能的异步 Python 应用服务器                                                       |
| 2018         | [Hypercorn](https://hypercorn.readthedocs.io/)                          | ASGI / WSGI 服务器     | 从 Quart 的服务器代码独立出来，支持 HTTP/2、WebSocket 等                                       |
| 2018         | [Starlette](https://starlette.dev/)                                     | ASGI Web 框架          | 提供轻量级异步请求处理、WebSocket、中间件与路由基础设施                                        |
| 2018         | [FastAPI](https://fastapi.tiangolo.com/)                                | ASGI Web 框架          | 结合 Starlette、Pydantic、类型注解与 OpenAPI，推动现代异步 API 开发                            |
| 2019         | [ASGI 3.0](https://asgi.readthedocs.io/en/latest/specs/main.html)       | 接口规范               | 采用单一异步可调用对象形式，即 `app(scope, receive, send)`                                     |
| 2019         | Django 3.0                                                              | Web 框架升级           | 正式增加 ASGI 应用支持，但内部请求处理当时仍主要是同步的                                       |
| 2020         | Django 3.1                                                              | Web 框架升级           | 增加异步视图支持，进一步向异步请求处理演进                                                     |
| 2022         | [Granian](https://github.com/emmett-framework/granian)                  | Rust 实现的应用服务器  | 采用 Rust 的 Hyper、Tokio，支持 ASGI、WSGI 等接口                                              |
| 2024         | [uvicorn-worker](https://github.com/Kludex/uvicorn-worker)              | Gunicorn Worker        | 将 Uvicorn 的 Gunicorn Worker 适配器独立成包                                                   |
| 2026         | [Gunicorn 24 / 25](https://gunicorn.org/)                               | 服务器升级             | 24.0 引入原生 ASGI Worker，25.1 将其提升为稳定支持，不再必须借助 Uvicorn Worker 运行 ASGI 应用 |


### 装饰器探析(10/6)
#### 装饰器的历史
时间线:

| 时间            | 事件                                                    |
| --------------- | ------------------------------------------------------- |
| Python 2.2      | 已存在 `classmethod()`、`staticmethod()` 等函数转换机制 |
| 2002            | Python 社区开始持续讨论专门的 decorator 语法            |
| 2003-06         | **PEP 318** 正式提出                                    |
| 2002–2004       | `python-dev` 围绕语法进行了大量讨论                     |
| 2004 EuroPython | Guido 综合各种方案后决定使用 `@decorator`               |
| Python 2.4a2    | `@decorator` 首次进入 Python                            |
| **2004-11-30**  | Python 2.4 正式发布，函数装饰器成为正式语言特性         |
| 2007            | PEP 3129 提出 class decorator                           |
| Python 3.0      | 类装饰器正式加入                                        |

当时甚至还有与如今的rust非常相似的提案:
```py
[decorator]
def foo():
    ...
```
只能说还好没这么写,不然可读性确实要差上不少,至于rust为什么不写成`@`?反正可读性本来就够差了...



装饰器的本质就是函数嵌套,从而避免了用户自己再去调用库函数来包装函数的麻烦,可以说极大地简化了开发流程.

比较早版本的装饰器只允许装饰函数,因为class已经有`metaclass`这个参数来配置了,但用起来显然没有装饰器简单,所以Collin Winter 在 2007 年提出 PEP 3129,并在python3.0中将装饰器引入到类中,可以说是极其重要的改进.





让我们再回顾一下装饰器诞生的关键提案[PEP318](https://peps.python.org/pep-0318):

>从 2002 年 2 月到 2004 年 7 月，python-dev 邮件列表上的讨论断断续续地持续着。数百条帖子涌现，人们提出了许多可能的语法变体。Guido 将一份提案列表带到了2004 年的 EuroPython 大会上，并在会上进行了讨论。之后，他决定采用Java 风格的 @decorator 语法，并在 2.4a2 版本中首次出现
#### 基本格式
```py
@dec2
@dec1
def func(arg1, arg2, ...):
    pass
```
等价于:
```py
def func(arg1, arg2, ...):
    pass
func = dec2(dec1(func))
```
#### 类中的装饰器
1. `@dataclass`: 数据类,意思是把这个类用来存放数据

```py
from dataclasses import dataclass

@dataclass
class InventoryItem:
    """Class for keeping track of an item in inventory."""
    name: str
    unit_price: float
    quantity_on_hand: int = 0

    def total_cost(self) -> float:
        return self.unit_price * self.quantity_on_hand
```
编译时会给这个类自动加上初始化方法和其他方法如`repr`和`eq`(从而可以直接用等号来比较两个数据类):
```py
def __init__(self, name: str, unit_price: float, quantity_on_hand: int = 0):
    self.name = name
    self.unit_price = unit_price
    self.quantity_on_hand = quantity_on_hand
```
如果写成这样:
```py
@dataclass(frozen=True)
class TokenUsage:
    input_tokens: int = 0
    output_tokens: int = 0
    total_tokens: int = 0
```
就表示在初始化后不能再修改:
```py
usage = TokenUsage(100, 50, 150)

usage.input_tokens = 200
# dataclasses.FrozenInstanceError
```
2. `@staticmethod`: 静态方法,用法与Cpp中的静态方法基本一样,不需要传入self,可以通过实例和类名直接调用
3. `@property`: 将方法转换成属性,即原来是通过`user.full_name()`调用,而现在可以通过`user.full_name`,在不需要给函数传入参数的时候还是很有用的
#### 函数装饰器

### Python项目组织风格(10/31)
Python官方是没有一个统一的风格推荐的,不过社区里的话,一个比较好的实践是这样的:
```text
project/
├── app/
├── tests/
├── alembic/
├── scripts/
├── pyproject.toml
├── alembic.ini
└── README.md
```
- 有的也会把`app`放在`src`文件夹之下.

而另一种风格则是直接把所有的非测试代码放在项目同名文件夹中,如scrapy的根目录下就有`scrapy`文件夹.
### Python继承与抽象(10/31)
Python中有多种抽象/接口/继承机制,最主要的有以下几个:
1. Protocol类: 不具有强制性,不需要显式声明,借助类型检查约束
2. ABC类: 配合`@abstractmethod`语法糖使用,强制子类实现对应接口
3. Generic: 不具有强制性,定义泛型类,并通过TypeVar实现注入的变量约束
4. `@final`和`@override`: 不具有强制性,通过类型检查约束
5. 类型操作: 这类机制有NewType,Callable,TypeAlias等,均通过静态类型检查实现真实的约束
#### Protocol
```py
from typing import Protocol

class Repository(Protocol):
    def get(self, user_id: int) -> str:
        ...

class BadRepository:
    def get(self, user_id: str) -> int:
        return 123

def process(repo: Repository):
    print(repo.get(1))

process(BadRepository())
```
Python解释器不会阻止程序运行,但类型检查会警告BadRepository不符合Repository.

#### ABC
```py
from abc import ABC, abstractmethod

class Repository(ABC):
    @abstractmethod
    def get(self, id: int) -> str:
        pass

class UserRepository(Repository):
    pass

repo = UserRepository()
# TypeError
```
- 如果只有继承 ABC 而没有声明抽象方法，不会强制子类实现任何方法。
#### Generic
```py
from typing import Generic, TypeVar

T = TypeVar("T")

class Repository(Generic[T]):
    def get(self, id: int) -> T:
        raise NotImplementedError

class User:
    pass

class UserRepository(Repository[User]):
    def get(self, id: int) -> User:
        return User()
```
Generic最推荐的写法就是用来组装依赖了:

只要我在一个文件中这么写了:
```py
RepoT = TypeVar("RepoT", bound=BaseRepo)

class BaseService(Generic[RepoT]):
    def __init__(self, repo: RepoT) -> None:
        self._repo = repo
```
那么就可以在子类中直接注入具体的Repo:
```py
class ChatService(BaseService[ConversationRepo]):
    def get_messages(self, conversation_id: int, user_id: int) -> MessagesPublic:

        messages = self._repo.get_messages(
            conversation_id, user_id, 0, settings.MESSAGE_LIMIT
        )

        return messages
```
初始化时传入repo类即可:
```py
def get_chat_service(session: SessionDep) -> ChatService:
    repo = ConversationRepo(session)
    return ChatService(repo)
```

#### final和override
```py
from typing import final, override

class BaseService:
    def get(self):
        pass

    @final
    def validate(self):
        pass

class UserService(BaseService):
    @override
    def get(self):
        pass

    def validate(self):
        pass  # 静态检查报错
```
1. @final 告诉类型检查器，该方法不能被子类覆盖
2. @override 告诉类型检查器，该方法应该覆盖父类中存在的方法。如果父类将 get() 重命名，类型检查器就能发现覆盖关系失效。

#### 类型操作
1. NewType用于创建逻辑上不同的类型:
```py
from typing import NewType

UserId = NewType("UserId", int)
OrderId = NewType("OrderId", int)

def get_user(user_id: UserId):
    ...

def get_order(order_id: OrderId):
    ...

user_id = UserId(100)
order_id = OrderId(200)

get_user(user_id)   # 正确
get_user(order_id)  # 静态类型检查报错
```
2. Callable是一个针对函数的类型接口,基本写法如下:

```py
from collections.abc import Callable

Handler = Callable[[int, str], bool]
# 对应的函数类型是
def handler(x: int, y: str) -> bool: ...
```
实际使用:
```py
from collections.abc import Callable

def execute(
    callback: Callable[[int], str],
    value: int,
) -> str:
    return callback(value)

def good(x: int) -> str:
    return str(x)

def bad(x: str) -> int:
    return len(x)

execute(good, 10)  # 正确
execute(bad, 10)   # 静态类型检查报错
```
3. `@overload`用于解决类型检查过于宽泛的情况:
```py
from typing import overload

@overload
def double(value: int) -> int:
    ...

@overload
def double(value: str) -> str:
    ...

def double(value: int | str) -> int | str:
    return value * 2

a = double(10)     # 推断为 int
b = double("Hi")   # 推断为 str
```
如果不用overload,我们就需要在函数内部进行条件判断,但话有说回来,写了overload我们也要额外写处理函数,而且分离了处理逻辑,所以需要有一个权衡.

4. TypeAlias/type用于给类型起一个别名:
```py
type UserScores = dict[str, list[int]]

def get_users() -> UserScores:
    ...
```

### FastAPI速通(11/11)
#### 速览
```py
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/items/{item_id}")
def read_item(item_id: int, q: str | None = None):
    return {"item_id": item_id, "q": q}
```
真的,fastapi的全部精华就在上面了,装饰器注解HTTP方法和路由,函数参数处理路径参数和请求体内容,函数内部返回响应体.如此朴实无华,展现了Python的最大魅力.

#### 进阶要点
##### async def与def
在fastapi中,用def定义一个路由函数时,它会将其加入到**外部线程池**中并等待处理结果,而不会直接调用(若直接调用则会阻塞服务器).

这同样适用于`Depends`等外部注入的依赖甚至是子依赖,只要是def定义的,都会被运行在外部线程池中,从而从根上避免阻塞.

另一方面,如果定义了`async def`,则会将当前任务加入到事件循环中,那么必须要用`await`等待耗时操作的结果,否则就会阻塞.
##### lifespan
**示例**
```py
from contextlib import asynccontextmanager

from fastapi import FastAPI


def fake_answer_to_everything_ml_model(x: float):
    return x * 42


ml_models = {}


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Load the ML model
    ml_models["answer_to_everything"] = fake_answer_to_everything_ml_model
    yield
    # Clean up the ML models and release the resources
    ml_models.clear()


app = FastAPI(lifespan=lifespan)


@app.get("/predict")
async def predict(x: float):
    result = ml_models["answer_to_everything"](x)
    return {"result": result}
```
yield之前的部分会在应用启动之前执行,yield之后的部分会在应用完成后执行,和pytest的fixture设置一样.

### Uvicorn文档阅读(11/17)
#### 概览
先搞清楚一个概念就行:

Uvicorn是ASGI web server,而FastAPI是一个web application,FastAPI再强,也需要Uvicorn来全面负责所有的外部通信,Uvicorn支持什么协议,FastAPI也只能用什么协议.

任何一个能够在Uvicorn上运行的app,都需要满足以下这个原语:
```py
async def app(scope, receive, send):
    assert scope['type'] == 'http'

    await send({
        'type': 'http.response.start',
        'status': 200,
        'headers': [
            (b'content-type', b'text/plain'),
            (b'content-length', b'13'),
        ],
    })
    await send({
        'type': 'http.response.body',
        'body': b'Hello, world!',
    })
```
即可通过uvicorn来运行:
```bash
uvicorn main:app
```

当然,也可以写在python代码里:
```py
import uvicorn

async def app(scope, receive, send):
    ...

if __name__ == "__main__":
    uvicorn.run("main:app", port=5000, log_level="info")
```
#### ASGI
WSGI server不支持WebSocket和长连接,而ASGI不仅支持,还可以运行后台任务和实现I/O并发.
#### worker
启动uvicorn时可以指定worker,本质上就是启动了一个父进程后,由这个父进程来管理多个子进程,进程之间彼此独立,分别对应自己的application,所以lifespan也是独立的.


### trio文档阅读(11/17)
asyncio的一个问题在于,当我们创建一个异步的后台任务后,就把它放着不管了,无论是否处理完,是否发生了错误,我们一概不知,必须通过一些特定的函数去获取进度.

## Golang
### Gin速通(10/30)
#### r和c
Gin中的绝大部分常用操作都只围绕着两个字母`r`(route)和`c`(gin.Context)展开.

对于route,我们只用到以下操作即可:
```go
func main() {
  route := gin.Default()
  route.GET("/testing", startPage)
  route.POST("/testing", startPage)
  route.Run(":8085")
}
```
`route.HTTPMethod`接收两个参数,一个是路由,另一个就是路由处理函数.

路由处理函数一律需要接收`gin.Context`,惯例简写为`c`参数,最常用的方法可以分成三种:
1. HTTP响应: 如`c.JSON`,`c.File`,`c.Header`,`c.String`,`c.HTML`,换句话说,所有的HTTP响应都可以从这个接口返回,这些响应方法一般都是接收两个参数,第一个就是状态响应码,第二个就是数据负载,如最常用的c.JSON格式如下:
```go
c.JSON(http.StatusOK, gin.H{
    "code": 200,
    "message": "success",
    "data": user,
})
// gin.H本质上就是一个map[string]any类型,方便我们构造JSON对象
```
1. 路由和请求参数提取: 如`c.Param()`获取路径参数,`c.Query()`获取查询参数,`c.PostForm()`获取表单字段.
2. 参数绑定和校验: 如`c.ShouldBind`,`c.ShouldBindJSON`,例子如下,这会提取请求体中的user字段并填充到空结构体中:

```go
type User struct {
    Name string `json:"name" binding:"required"`
    Age  int    `json:"age" binding:"gte=0"`
}

func createUser(c *gin.Context) {
    var user User

    if err := c.ShouldBindJSON(&user); err != nil {
        c.JSON(400, gin.H{"error": err.Error()})
        return
    }

    c.JSON(201, user)
}
```

有了这些知识,我们就已经能做一个简单的无数据库网站出来了,要想进一步优化数据交互,就要加上结构体标签来处理:
```go
package main

import (
  "log"
  "net/http"
  "time"

  "github.com/gin-gonic/gin"
)

type Person struct {
  Name     string    `form:"name"`
  Address  string    `form:"address"`
  Birthday time.Time `form:"birthday" time_format:"2006-01-02" time_utc:"1"`
}

func main() {
  route := gin.Default()
  route.GET("/testing", startPage)
  route.POST("/testing", startPage)
  route.Run(":8085")
}

func startPage(c *gin.Context) {
  var person Person
  if err := c.ShouldBind(&person); err != nil {
    c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
    return
  }

  log.Printf("Name: %s, Address: %s, Birthday: %s\n", person.Name, person.Address, person.Birthday)
  c.JSON(http.StatusOK, gin.H{
    "name":     person.Name,
    "address":  person.Address,
    "birthday": person.Birthday,
  })
}
```
#### 结构体标签
Gin支持解析的结构体标签有常见的以下几种:
1. 请求字段映射: 指定请求中的某个字段应该映射到结构体的哪个字段

| 标签     | 作用                   | 示例                     | 对应方法                        |
| :------- | :--------------------- | :----------------------- | :------------------------------ |
| `json`   | JSON 字段映射          | `json:"name"`            | `ShouldBindJSON`                |
| `form`   | 表单、URL 查询参数映射 | `form:"name"`            | `ShouldBindQuery`、`ShouldBind` |
| `uri`    | URL 路径参数映射       | `uri:"id"`               | `ShouldBindUri`                 |
| `header` | HTTP 请求头映射        | `header:"Authorization"` | `ShouldBindHeader`              |
| `xml`    | XML 字段映射           | `xml:"name"`             | `ShouldBindXML`                 |
| `yaml`   | YAML 字段映射          | `yaml:"name"`            | `ShouldBindYAML`                |
| `toml`   | TOML 字段映射          | `toml:"name"`            | `ShouldBindTOML`                |

2. 通过binding标签实现的数据验证: 如`binding:"required"`要求该参数为必填项,`binding:"email"`表示该字段必须为邮箱格式,`binding:"omitempty,email"`在该字段为空时跳过后续验证,`binding:"gt=0"`表示该字段必须大于0
3. 提供默认值: 如`form:"page,default=1"`

### GORM速通(10/31)
在25年5月发布v1.30.0版本之前,GORM还用的是Traditional API,不需要注入上下文:
```go
package main

import (
  "gorm.io/driver/sqlite"
  "gorm.io/gorm"
)

type Product struct {
  gorm.Model
  Code  string
  Price uint
}

func main() {
  db, err := gorm.Open(sqlite.Open("test.db"), &gorm.Config{})
  if err != nil {
    panic("连接数据库失败")
  }

  // 自动建表
  db.AutoMigrate(&Product{})

  // 创建
  db.Create(&Product{Code: "D42", Price: 100})

  // 查询
  var product Product
  db.First(&product, 1) // 查找对应主键的产品
  db.First(&product, "code = ?", "D42") // 查找 code 为 D42 的所有产品

  // 更新 - 将产品价格更新为 200
  db.Model(&product).Update("Price", 200)
  // 更新 - 更新多个字段
db.Model(&product).Updates(Product{Price: 200, Code: "F42"}) // 仅更新非零字段
  db.Model(&product).Updates(map[string]interface{}{"Price": 200, "Code": "F42"})

  // 删除 - 删除产品
  db.Delete(&product, 1)
}
```

而在这之后则引入了泛型API,采用显式传入Context的设置,实际上代码变得难看了很多:
```go
package main

import (
  "context"
  "gorm.io/driver/sqlite"
  "gorm.io/gorm"
)

type Product struct {
  gorm.Model
  Code  string
  Price uint
}

func main() {
  db, err := gorm.Open(sqlite.Open("test.db"), &gorm.Config{})
  if err != nil {
    panic("连接数据库失败")
  }

  ctx := context.Background()

  // 自动建表
  db.AutoMigrate(&Product{})

  // 创建
  err = gorm.G[Product](db).Create(ctx, &Product{Code: "D42", Price: 100})

  // 查询
  product, err := gorm.G[Product](db).Where("id = ?", 1).First(ctx) // 查找对应主键的产品
  products, err := gorm.G[Product](db).Where("code = ?", "D42").Find(ctx) // 查找 code 为 D42 的所有产品

  // 更新 - 将产品价格更新为 200
  err = gorm.G[Product](db).Where("id = ?", product.ID).Update(ctx, "Price", 200)
  // 更新 - 更新多个字段
  err = gorm.G[Product](db).Where("id = ?", product.ID).Updates(ctx, Product{Code: "D42", Price: 100})

  // 删除 - 删除产品
  err = gorm.G[Product](db).Where("id = ?", product.ID).Delete(ctx)
}
```

尽管这是出于安全和效率的考量,但请你先把文档更新好啊,里面一堆的Traditional API代码残留,很混乱的好不好.

#### 数据表
##### GORM约定
GORM对数据表的约定如下:
1. 主键: 默认使用`ID`字段作为主键
2. 表名: 默认将结构体名称转换为snake_case并加上复数,例如，`User` 结构体会在数据库中变成 `users`，而 `GormUserName` 会变成 `gorm_user_names`。
3. 列名: 自动将字段名称转换为snake_case
4. 时间戳字段：使用字段 `CreatedAt` 和 `UpdatedAt` 来自动跟踪记录的创建和更新时间。

值得一提的是GORM提供了一个预定义的结构体`gorm.Model`,定义如下:
```go
type Model struct {
  ID        uint           `gorm:"primaryKey"`
  CreatedAt time.Time
  UpdatedAt time.Time
  DeletedAt gorm.DeletedAt `gorm:"index"`
}
```
只要将这个结构体嵌入到结构体之中,就可以在调用时自动展开这些字段.
##### 结构体标签
GORM中常见的结构体标签有几类,均以`gorm:"xxx"`的结构展示:
1. 主键和数据库约束: 如设定主键和自增的`gorm:"primaryKey;autoIncrement"`,设置unique和not null的`gorm:"unique;not null"`,设置默认值的`gorm:"default:1"`
2. 设置索引,如普通索引和复合索引:
```go
type User struct {
    ID    uint
    Name  string `gorm:"index"`
}

type User struct {
    ID     uint
    Name   string `gorm:"index:idx_name_age"`
    Age    int    `gorm:"index:idx_name_age"`
}
```
3. 关联关系: 设置外键和约束
```go
type User struct {
    ID    uint
    Posts []Post `gorm:"foreignKey:AuthorID"`
}

type Post struct {
    ID       uint
    Title    string
    AuthorID uint
}
```

```go
type User struct {
    ID    uint
    Posts []Post `gorm:"constraint:OnDelete:CASCADE"`
}
```

值得注意的是,GORM采用约定优于配置的设计,只要遵循默认命名,就可以尽可能地少写标签.

如下方示例中,`CompanyID`会自动查找并对应到`Company.ID`,确认这是被引用的外键:
```go
type Company struct {
    ID   uint
    Name string
}

type User struct {
    ID        uint
    Name      string
    CompanyID uint
    Company   Company
}
```
上述情况适用于一对一关系或者隐含的多对一关系,而对于多对一关系,声明成数组即可:

```go
type User struct {
    ID    uint
    Name  string
    Posts []Post
}

type Post struct {
    ID     uint
    Title  string
    UserID uint
}
```
#### CRUD
##### 创建数据表
有两种格式,第二种result方式可以获取更多关于操作错误的信息,但一版用第一种方法就足够了:
```go
user := User{Name: "Jinzhu", Age: 18, Birthday: time.Now()}

// Create a single record
ctx := context.Background()
err := gorm.G[User](db).Create(ctx, &user) // pass pointer of data to Create

// Create with result
result := gorm.WithResult()
err := gorm.G[User](db, result).Create(ctx, &user)
user.ID             // returns inserted data's primary key
result.Error        // returns error
result.RowsAffected // returns inserted records count
```
##### 查询
对于单个对象的检索,GORM提供三种查询方法:
```go
ctx := context.Background()

// Get the first record ordered by primary key
user, err := gorm.G[User](db).First(ctx)
// SELECT * FROM users ORDER BY id LIMIT 1;

// Get one record, no specified order
user, err := gorm.G[User](db).Take(ctx)
// SELECT * FROM users LIMIT 1;

// Get last record, ordered by primary key desc
user, err := gorm.G[User](db).Last(ctx)
// SELECT * FROM users ORDER BY id DESC LIMIT 1;

// check error ErrRecordNotFound
errors.Is(err, gorm.ErrRecordNotFound)
```

条件检索的写法比较独特:
```go
package main

import (
  "context"
  "gorm.io/driver/sqlite"
  "gorm.io/gorm"
)

type Product struct {
  gorm.Model
  Code  string
  Price uint
}

func main() {
  db, err := gorm.Open(sqlite.Open("test.db"), &gorm.Config{})
  if err != nil {
    panic("连接数据库失败")
  }

  ctx := context.Background()

  // 自动建表
  db.AutoMigrate(&Product{})

  // 创建
  err = gorm.G[Product](db).Create(ctx, &Product{Code: "D42", Price: 100})

  // 查询
  product, err := gorm.G[Product](db).Where("id = ?", 1).First(ctx) // 查找对应主键的产品
  products, err := gorm.G[Product](db).Where("code = ?", "D42").Find(ctx) // 查找 code 为 D42 的所有产品

  // 更新 - 将产品价格更新为 200
  err = gorm.G[Product](db).Where("id = ?", product.ID).Update(ctx, "Price", 200)
  // 更新 - 更新多个字段
  err = gorm.G[Product](db).Where("id = ?", product.ID).Updates(ctx, Product{Code: "D42", Price: 100})

  // 删除 - 删除产品
  err = gorm.G[Product](db).Where("id = ?", product.ID).Delete(ctx)
}
```
使用`?`作为占位符,并用第二个参数注入到`Where`中


GORM中的查询默认不会加载关联(Relationship),而是需要用`Preload`函数显式声明:
```go
user, err := gorm.G[User](db).
    Preload("Posts", nil).
    Where("id = ?", 1).
    First(ctx)
```
GORM大致执行:
```sql
-- 查询用户
SELECT * FROM users WHERE id = 1 LIMIT 1;

-- 查询该用户的文章
SELECT * FROM posts WHERE user_id IN (1);
```
##### 更新
```go
ctx := context.Background()

// Update with conditions
err := gorm.G[User](db).Where("active = ?", true).Update(ctx, "name", "hello")
// UPDATE users SET name='hello', updated_at='2013-11-17 21:34:10' WHERE active=true;

// Update with ID condition
err := gorm.G[User](db).Where("id = ?", 111).Update(ctx, "name", "hello")
// UPDATE users SET name='hello', updated_at='2013-11-17 21:34:10' WHERE id=111;

// Update with multiple conditions
err := gorm.G[User](db).Where("id = ? AND active = ?", 111, true).Update(ctx, "name", "hello")
// UPDATE users SET name='hello', updated_at='2013-11-17 21:34:10' WHERE id=111 AND active=true;
```

##### 删除
```go
ctx := context.Background()

// Delete by ID
err := gorm.G[Email](db).Where("id = ?", 10).Delete(ctx)
// DELETE from emails where id = 10;

// Delete with additional conditions
err := gorm.G[Email](db).Where("id = ? AND name = ?", 10, "jinzhu").Delete(ctx)
// DELETE from emails where id = 10 AND name = "jinzhu";
```

#### 数据库连接
连接到Postgres有两种方式,一个是使用键值对格式:
```sql
import (
  "gorm.io/driver/postgres"
  "gorm.io/gorm"
)

dsn := "host=localhost user=gorm password=gorm dbname=gorm port=9920 sslmode=disable TimeZone=Asia/Shanghai"
db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
```
另一个则是指定URL:
```go
import (
    "gorm.io/driver/postgres"
    "gorm.io/gorm"
)

dsn := "postgresql://gorm:gorm@localhost:9920/gorm?sslmode=disable&TimeZone=Asia%2FShanghai"

db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
```
#### Context机制
一个最简单的例子如下:
```go
ctx, cancel := context.WithTimeout(context.Background(), 2*time.Second)
defer cancel()

users, err := gorm.G[User](db).Find(ctx)
```

之所以要显式管理Context,是因为Context可以扩展到HTTP服务器中,从而随着路由请求的结束而关闭上下文,避免长期占用连接.

#### 错误处理
```go
ctx := context.Background()

// Error handling with direct return values
user, err := gorm.G[User](db).Where("name = ?", "jinzhu").First(ctx)
if err != nil {
  // Handle error...
}

// For operations that don't return a result
err := gorm.G[User](db).Where("id = ?", 1).Delete(ctx)
if err != nil {
  // Handle error...
}
```

#### 迁移
AutoMigrate 会自动创建表、缺失的外键、约束、列和索引。
```go
db.AutoMigrate(&User{})

db.AutoMigrate(&User{}, &Product{}, &Order{})

// 创建表时添加后缀
db.Set("gorm:table_options", "ENGINE=InnoDB").AutoMigrate(&User{})
```


### Go项目组织风格(10/30)
- [官方文档说明](https://go.dev/doc/modules/layout)

惯例情况下,我们将可供主程序调用的内部源码通通放在`/internal`文件夹下.

我们编译Go时一般都是条件编译的,例如数据库迁移,管理员操作,HTTP服务器三者是彼此独立的组件,我们不可能写一个大的`main.go`,然后把三种操作用if来区分.

因此,传统上是把所有的程序入口都放在`/cmd`文件夹中.

最终,我们得到的文件夹结构如下:
```text
project-root-directory/
  go.mod
  internal/
    auth/
      ...
    metrics/
      ...
    model/
      ...
  cmd/
    api-server/
      main.go
    metrics-analyzer/
      main.go
    ...
  ... the project's other directories with non-Go code
```

## Java
### Java历史
- [wiki](https://en.wikipedia.org/wiki/Java_(programming_language))

Java由Sun公司于1995年发布,出于营销的目的,将Java分成了三个主要版本: 
1. Java Platform, Micro Edition(Java ME): 用于嵌入式等内存有限的环境
2. Java Platform, Standard Edition (Java SE): 标准版本
3. Java Platform, Enterprise Edition (Java EE): 企业版本

简单来说,就是包含的库上有一些区别而已,其他的差别并不大.

由于Java依靠JVM运行,而早期的JVM是不开源的,所以引发了很多争议和诉讼案件,也是微软自己开发C#语言(与Java高度相似)的原因.

07年的时候,JVM的所有核心代码都正式开源,从而诞生了大量的第三方JDK,最著名的就是OpenJDK了,不管如何,现在我们可以随便下载JDK而不用担心被诉讼了.

10年Oracle收购Sun后,Java的所有权转入了Oracle公司,之后Java的演进速度趋于稳定,现在的Java SE是半年更新一版,迭代速度还是很快的.
### Spring环境配置
- [vscode配置教程](https://vscode.github.net.cn/docs/java/java-spring-boot)
  - 网上能见到的教程要么用IntelliJ IDEA,要么用Spring Boot CLI,这让我一个VSCode的死忠粉很崩溃啊

如官网所说,要在VSCode中开发Spring Boot,需要安装JDK,VSCode中的Java扩展,(Gradle扩展)和Spring Boot扩展,其中Spring Boot扩展包的内容如下,一下子就会导入四个扩展:
![插件图](PixPin_2026-06-19_22-06-10.webp)

要想新建一个初始化的Spring Boot项目的话,直接按`Ctrl+Shift+P`并键入`Spring Initializr`,选择自己想要的模板即可,如果全部按照默认设置的话,最终生成的项目是这样的:

![效果图](PixPin_2026-06-19_22-13-37.webp)

- 不过,使用`gradle init`也可以实现差不多的效果,只不过可能没有这种图形化界面的选择直观了.
- 另一个方法是直接去SPring的官网下载初始化项目,下载得到的项目是完全一样的

>不过,等待项目的各种依赖就绪要很久,应该说这是Java项目的通病了

在扩展栏中多了一个Spring Boot Dashboard工具,点开后运行APPs中的app即可,不出意外的话终端会有如下输出:

![终端](PixPin_2026-06-19_22-24-56.webp)

当然,如果直接拿一个现成的Spring Boot项目来看的话,根本无从下手,所以需要好好了解Spring的基本知识和Spring Boot对它的改进.

>[!NOTE]
>(26/8/25)突然发现我之前还是太蠢了,直接看现成项目才是学习Spring Boot的王道,扯什么IoC,依赖注入,一点用都没有,毕竟无论是什么语言,什么框架,一旦涉及了CRUD,就几乎没有什么太大的架构差别.
## Cpp
### 刷题常用知识点
#### 获取容器长度
1. STL容器统一使用`.size()`,如vector,array,queue,map等
2. string类型可以用`.size()`,也可以用`.length()`
3. 普通数组用`std::size()`.

所以无脑用`.size()`即可.

#### vector解析
vector初始化,与数组不同,可以用变量:
```cpp
vector<int> dp(n, 0);                   // 一维数组
// 第一个参数指定元素个数,第二个参数指定所有元素的初始值,不写则默认为0

vector<vector<int>> dp(n, vector<int>(m, 0)); // 二维数组
// 第一个参数指定数组个数,第二个参数指定数组的内容
```
常用操作:
- `push_back()`: 添加尾部元素
- `empty()`: 判断是否为空
- `resize(5,0)`: 调整长度为5,不够则填充0.

#### 常用STL及对应情景
总表:
| 容器             | 底层实现（通常）           | 特点                          | 典型场景           | 初始化写法                      |
| ---------------- | -------------------------- | ----------------------------- | ------------------ | ------------------------------- |
| `stack`          | 容器适配器（默认 `deque`） | 后进先出 LIFO                 | 括号匹配、单调栈   | `stack<int> st;`                |
| `queue`          | 容器适配器（默认 `deque`） | 先进先出 FIFO                 | BFS、任务队列      | `queue<int> q;`                 |
| `priority_queue` | 堆（默认大顶堆）           | 获取最大值 O(1)               | Top K、优先级调度  | `priority_queue<int> pq;`       |
| `set`            | 红黑树                     | 元素唯一、自动有序            | 有序去重、范围查询 | `set<int> s;`                   |
| `unordered_set`  | 哈希表                     | 元素唯一、无序，平均查询 O(1) | 快速判重           | `unordered_set<int> s;`         |
| `map`            | 红黑树                     | Key 唯一且有序                | 有序键值映射       | `map<string, int> m;`           |
| `unordered_map`  | 哈希表                     | Key 唯一且无序，平均查询 O(1) | 计数、索引、缓存   | `unordered_map<string, int> m;` |



1. set:
```cpp
#include <set>
using namespace std;

set<int> s = {5, 2, 3, 2, 1};

s.insert(4);
s.erase(2);

bool exists = s.count(3) > 0;

for (int x : s) {
    cout << x << " ";
}
// 输出：1 3 4 5
```
2. map:
```cpp
#include <map>

map<string, int> scores;

scores["Alice"] = 90;
scores["Bob"] = 85;
scores["Charlie"] = 95;

cout << scores["Alice"];  // 90
```

3. priority_queue:
```cpp
// 大顶堆（默认）
priority_queue<int> maxHeap;

// 小顶堆
priority_queue<
    int,
    vector<int>,
    greater<int>
> minHeap;

minHeap.push(3);
minHeap.push(1);
minHeap.push(2);

cout << minHeap.top();  // 1
```
#### map和set的通用成员函数
| 方法          | 作用                             | 示例             |
| ------------- | -------------------------------- | ---------------- |
| `insert(x)`   | 插入元素                         | `s.insert(5);`   |
| `erase(x)`    | 删除指定元素或 Key               | `s.erase(5);`    |
| `count(x)`    | 判断元素或 Key 是否存在          | `s.count(5);`    |
| `find(x)`     | 查找元素，返回迭代器             | `s.find(5);`     |
| `contains(x)` | 判断是否存在，返回 bool（C++20） | `s.contains(5);` |
| `size()`      | 获取元素数量                     | `s.size();`      |
| `empty()`     | 判断容器是否为空                 | `s.empty();`     |
| `clear()`     | 清空容器                         | `s.clear();`     |
| `begin()`     | 返回首元素迭代器                 | `s.begin();`     |
| `end()`       | 返回尾后迭代器                   | `s.end();`       |

特别需要注意的是,二者都可以通过迭代器区间初始化:
```cpp
vector<int> nums = {3, 1, 2, 2, 4};

set<int> s(nums.begin(), nums.end());

unordered_set<int> us(nums.begin(), nums.end());
```
```cpp
vector<pair<int, int>> nums = {
    {1, 10},
    {2, 20},
    {3, 30}
};

map<int, int> m(nums.begin(), nums.end());

unordered_map<int, int> um(nums.begin(), nums.end());
```
#### string操作
1. 根据起始下标和长度截取字串:
```cpp
// 左右下标 [l, r]，包含 r
s.substr(l, r - l + 1);
```
### struct/class全解(9/8)
Cpp中struct和class的区别比我想的还要小很多,它们都有访问控制符,有构造和析构函数,支持`->`访问符,唯一的区别在于,struct的默认成员权限为public,而class的默认成员权限为private.

如此也看得出来,class完完全全就是struct的套皮而已.如此一来,我们完全不需要因为Go和Rust中没有class而难受,毕竟二者实际上并没有什么区别.

### const问题(9/8)
C/Cpp中最容易让人迷糊的就是指针了,但当指针和const混在一起时,这才是噩梦的开始

先放出列表:
| 声明                  | 更准确的名称       | 指针指向能否改变 | 指向的值能否通过该指针修改 |
| --------------------- | ------------------ | ---------------: | -------------------------: |
| `const int *p`        | 指向常量的指针     |             可以 |                     不可以 |
| `int const *p`        | 指向常量的指针     |             可以 |                     不可以 |
| `int * const p`       | 指针常量 / 常指针  |           不可以 |                       可以 |
| `const int * const p` | 指向常量的指针常量 |           不可以 |                     不可以 |

#### 指向常量的指针

其中,下面两个式子完全等价:
```c
const int *p;
int const *p;
```
至于为什么如此,对于`int const *p;`,显然不存在一个指向const的指针,所以这个指针只能是指向int,而const自然就是修饰int的了,所以叫做指向常量int的指针.

尽管如此,这并不意味着对象真的是常量,而是表示**p以为自己指向的是常量**,所以无法通过p修改指向的对象,但对象本身可以是变量:
```c
int a = 10;
const int *p = &a;

a = 20;     // 正确：a本身不是常量
*p = 20;    // 错误：不能通过p修改a
```
#### 指针常量
既然这个指针是常量,也就不可以修改存储的地址了,但仍然可以修改指向对象的值,用处并不大,一个引用就可以完全代替了.
#### 指向常量的指针常量
双重const,额,根本看不出有什么好的用法.

#### 总结
如上所示,这几个概念屁用没有,可惜的是面试总喜欢考这个,莫名其妙的.
## Rust
### 优秀的Github仓库
1. [入门学习](https://github.com/rust-lang/rustling): 非常NB的交互式学习!
2. [中文教程](https://beatai.org/rust-course/basic/)
3. [链表入门](https://rust-unofficial.github.io/too-many-lists/)
4. [mini-redis](https://github.com/tokio-rs/mini-redis/tree/master)
5. [pingcap](https://github.com/pingcap/talent-plan)

## CS
### 环境配置

#### .NET编译器介绍
- [wiki](https://en.wikipedia.org/wiki/.NET)
##### 是什么,有什么用
.NET是微软发布的开源编译器,支持C#,F#和Visual Basic开发,类似于Java中的JDK和Cpp中的MSVC,至于为什么叫.NET,只不过是微软糟糕的命名品味(.net=>.NET)而已.

- Windows的PowerShell,Visual Studio均基于.NET构建,Unity也需要.NET环境来解释C#脚本
##### .NET历史
* **2000年 - 2002年：诞生与标准化**
    微软在 PDC 2000 会议上公布 C# 语言，并随后将 **CLI (公共语言基础设施)** 提交 ECMA 进行标准化。2002 年，**.NET Framework 1.0** 正式发布，确立了基于虚拟运行时的受控代码开发模式。

* **2014年：开源与跨平台转型**
    11 月 12 日，微软宣布启动 **.NET Core** 项目。这是一个完全重构的开源、跨平台版本，旨在摆脱对 Windows 操作系统的绑定，并成立了 **.NET Foundation** 负责社区化运营。

* **2016年 - 2017年：.NET Core 初期**
    2016 年 6 月，**.NET Core 1.0** 发布，正式实现 Linux 和 macOS 运行能力。2017 年发布的 **.NET Core 2.0** 引入了 **.NET Standard 2.0**，统一了 API 规范，解决了新旧平台间的代码兼容难题。

* **2019年：桌面支持与成熟**
    **.NET Core 3.0** 发布。该版本最显著的变化是支持 WPF 和 WinForms 桌面应用在 Core 环境下运行，性能相比旧版 Framework 大幅提升。

* **2020年：架构大统一 (.NET 5)**
    微软跳过版本号 4.0 并移除了 "Core" 后缀，发布 **.NET 5**。此举标志着 .NET Framework（旧版）和 .NET Core（新版）合二为一，成为未来唯一的 .NET 演进路径。

* **2021年 - 2023年：LTS 演进 (.NET 6 - .NET 8)**
    **.NET 6** (2021) 确立了 3 年期的长期支持 (LTS) 模式。**.NET 8** (2023) 作为目前的核心 LTS 版本，引入了 **Native AOT** 编译技术，极大优化了云原生场景下的启动速度。

* **2024年 - 2026年：现代版本与 AI 集成**
    **.NET 9** (2024) 重点增强了 AI 扩展能力和运行时效率。目前最新的 **.NET 10 (LTS)** 已于 2025 年 11 月发布，其支持周期将持续至 2028 年，成为当前企业级开发的基础版本。
##### Nuget
- [wiki](https://en.wikipedia.org/wiki/NuGet)
.NET的包管理器,被集成在.NET中,不需要单独下载即可直接调用
- 至于为什么叫Nuget,则又是微软的糟糕命名品味(new get=>nuget)了


#### 使用VS运行项目
1. 在创建新项目中选择语言为C#,找到被标记的这一栏

![示意图](PixPin_2026-04-13_20-56-53.webp)
- 可以看到有两种C#窗体应用,第一种是我们要选择的.NET平台,第二个则是古老的.NET framework平台

1. 随便起个名字比如说`test`,选择默认的.NET 8.0(长期支持版本)
2. 在终端输入`cd test`: VS非常神奇的地方在于当你创建.NET项目时,VS会创建一个同名子文件夹来存放项目
   1. 也就是说,所有的东西和.NET依赖并不在根目录,而是会在test子文件夹中,所以这里我们需要`cd test`
3. 再输入上述的命令行安装链接,安装之后按一下f5,成功弹出来一个空白的窗口
4. 但是现在我们打开解决方案资源管理器后,点击里面的Form1.cs,弹出来的是一个空白窗口,右键该界面的空白处或者右键Form1.cs即可查看代码...

![alt text](PixPin_2026-04-13_21-09-50.webp)

#### 使用VScode运行项目
没有人喜欢用VS来开发,所以我们可以通过终端来初始化和运行C#项目:
1. 创建一个项目后在终端输入`dotnet new`,提示你可以创建以下项目,这正好对应了之前VS中的创建项目方式:
```bash
“dotnet new”命令基于模板创建 .NET 项目。

常用模板包括:
模板名            短名称    语言        标记
----------------  --------  ----------  ----------------------
Blazor Web 应用   blazor    [C#]        Web/Blazor/WebAssembly
Windows 窗体应用  winforms  [C#],VB     Common/WinForms
WPF 应用程序      wpf       [C#],VB     Common/WPF
控制台应用        console   [C#],F#,VB  Common/Console
类库              classlib  [C#],F#,VB  Common/Library
```
2. 再输入`dotnet run`即可运行项目,实现与VS中相同的效果
3. 但要在VScode中进行C#和Oracle开发的话我们还需要下载.NET相关的插件以及`Oracle SQL Developer Extension for VSCode`,然后就可以用VScode开始开发了

# 前端专题
## 前端概览
- [W3schools](https://www.w3schools.com/css/css_intro.asp)
  - 本文的主要参考教程
- [wiki](https://en.wikipedia.org/wiki/Front_end_and_back_end)

>前端与后端是一对概念,前端用于指代用户交互层,后端用于指代数据处理层

前端最令人遗憾的地方在于,早期的浏览器大战使得网络生态混乱不堪,不同企业之间高筑护城河,诞生了各种各样的框架和新特性,让新入门的程序员一筹莫展,不知道学什么好.

不管怎样,我还是按照前端三件套到JSX,TSX的步骤来学习,从而更深入的理解前端的方方面面.
## HTML
**Hypertext Markup Language**(HTML)是一门用来处理网页文档内容的标记语言,通过dom(Document Object Model)将HTML中的元素映射到引擎中,从而展示出你现在看到的网页.
### HTML历史
- [wiki](https://en.wikipedia.org/wiki/HTML)

* **1980年 - 1989年：概念原型**
    * **1980年**：Tim Berners-Lee 在 CERN 开发 ENQUIRE 系统，用于共享文档。
    * **1989年**：Berners-Lee 编写备忘录，提议建立基于互联网的超文本系统。
* **1990年 - 1991年：诞生与初步公开**
    * **1990年**：Berners-Lee 编写了首个浏览器和服务器软件。
    * **1991年10月**：首次公开提及“HTML Tags”，包含 18 个元素，设计深受 CERN SGML（标准通用标记语言）影响。
* **1993年 - 1995年：标准化尝试**
    * **1993年6月**：IETF 发布首个 HTML 规范草案。
    * **1993年末**：HTML+ 草案提出支持表格和表单。
    * **1995年11月**：**HTML 2.0** 发布（RFC 1866），成为首个正式标准。
* **1997年 - 1999年：W3C 主导时期**
    * **1997年1月**：**HTML 3.2** 发布，W3C 接手标准化工作，吸收了大量浏览器厂商的专有标签。
    * **1997年12月**：**HTML 4.0** 发布，开始推行结构与样式分离（引入 CSS），并分为 Strict、Transitional、Frameset 三种变体。
    * **1999年12月**：**HTML 4.01** 发布，成为长期稳定的 Web 基础。
* **2000年 - 2009年：XHTML 转向与停滞**
    * **2000年**：XHTML 1.0 发布，将 HTML 4.01 重新表述为 XML。
    * **2004年**：由于 W3C 坚持 XHTML 2.0 方向（不向下兼容），部分成员成立 **WHATWG**，开始研发 HTML5。
    * **2009年**：W3C 停止 XHTML 2.0 工作，转向 HTML5。
* **2014年至今：HTML5 与活标准**
    * **2014年10月**：**HTML5** 正式成为 W3C 推荐标准。
    * **2019年5月**：W3C 与 WHATWG 达成协议，HTML 与 DOM 标准的发布权交由 WHATWG。
    * **现状**：HTML 采取“Living Standard”（活标准）模式，由 WHATWG 持续更新。
      * 换句话说就是不再用版本号来标识了,很长一段时间会一直定格在HTML5.


- [参考教程](https://www.w3schools.com/html/html_intro.asp)
### 学习html的前提
首先,我们需要知道诸如`<p><p/>`这样的独特标签语法的来源: **SGML(Standard Generalized Markup Language)**,它诞生于1986年,使用`<`和`>`定义标签,通过重叠的标签来展示层次化的内容.

由于SGML的语法过于繁琐,XML与HTML均对其进行了简化和处理,但保留了**标签语法**.

其次,我们时常可以看到两种html文件格式: `.html`与`.htm`,显然这个`htm`是简化版本,但它为什么会存在呢?
>由于早期Windows的文件系统均采用“8.3 格式”。即：文件名最长 8 个字符，扩展名最长 3 个字符,所以无法表示html,为了兼容Windows系统,不得不将`html`后缀变成`htm`.
>但现在就没有这个问题了,所以都统一用html后缀了.

- `yaml`与`yml`也是同样的道理.

接着我们要知道的是,html元素内部是**不存在逗号**的,**只能通过空白**来区分两个属性或者属性的内部值,而且,属性值可以写引号但也可以不写,但如果不写引号的话,当有多个属性时就非常混乱,所以官方推荐全部加上引号,而且是双引号.

```html
<button type="submit" id="main-auth-btn" class="ui-button primary-style large-size" name="login-action" value="execute" title="点击进行登录" aria-label="登录账户" data-api-endpoint="/v1/auth" data-loading="false" disabled>立即登录</button>
```

由于下面的属性中style本质上是**css代码**,遵循css语法,故可以出现分号:
```html
<button class="btn btn-primary btn-large" style="color: white; background-color: blue; padding: 10px 20px;">
  Click Me
</button>
```
最后,特别要注意的是,html里的标签是**大小写不敏感**的,官方推荐**全都小写**


### 主体架构
一个简化的html文档如下所示:
```html
<!DOCTYPE html>

<html>

<head>
<title>Page Title</title>
</head>

<body>
<h1>My First Heading</h1>
<p>My first paragraph.</p>
</body>

</html>
```
我做了相应的缩进以让层次划分更加明显:

1. 首行的`<!DOCTYPE html>`声明: 历史遗留语法,供浏览器识别这个文档为html类型,无论如何都必须写,而且写在第一行.
2. 整个网页内容由`<html><html/>`包裹,尽管大家都知道这是html文档了,但还是需要用html标签来声明.
3. 整个网页内容分成两部分: **head与body**,head部分包括了网页的各种属性,供搜索引擎和浏览器识别;body部分包括了整个网页的内容,决定了渲染的用户界面

### 文本表示
**标题**
```html
<h1>This is heading 1</h1>
<h2>This is heading 2</h2>
<h3>This is heading 3</h3>
```
- h对应的英文全称为Heading


**段落**
```html
<p>This is a paragraph.</p>
<p>This is another paragraph.</p>
```
- p对应的英文全称为paragraph

需要注意的是,p标签会自动过滤多余的空格和换行,根据窗口大小自动渲染文本:
![示意图](PixPin_2026-04-26_23-38-28.webp)


### html常用属性
#### style
```html
<p style="color:red;">This is a red paragraph.</p>
```
- 一般都通过css来操纵样式,没必要用这个属性

#### lang
```html
<!DOCTYPE html>
<html lang="zh-CN">
<body>
...
</body>
</html>
```
帮助搜索引擎和爬虫了解该文章所用的语言,我们平常浏览页面时弹出的是否翻译此页面,就是根据这个属性来判断,当前页面语言和浏览器默认语言是否相同的.
#### class
为css提供一个访问入口,css通过`.`前缀来绑定dom中的class属性:
```html
<!DOCTYPE html>
<html>
<head>
<style>
.city {
  background-color: tomato;
  color: white;
  border: 2px solid black;
  margin: 20px;
  padding: 20px;
}
</style>
</head>
<body>

<div class="city">
  <h2>London</h2>
  <p>London is the capital of England.</p>
</div>

<div class="city">
  <h2>Paris</h2>
  <p>Paris is the capital of France.</p>
</div>

<div class="city">
  <h2>Tokyo</h2>
  <p>Tokyo is the capital of Japan.</p>
</div>

</body>
</html>
```

**效果**

![示意图](PixPin_2026-04-28_16-16-45.webp)

class有以下特点:

1. **一个元素可以有多个class,一个class也可以被多个元素使用**.
2. **后定义的class会覆盖先定义的class**

#### id
显然,如果只有class的话,当两个标签的排版只有些微的不同时,我们是不希望重新写一个只有些微不同的class的,所以,html引入了**id**属性,用于额外标识标签元素,从而实现元素的精细化操控.

在同一个HTML页面中,ID必须是唯一的(类似身份证号),并且可被css通过`#`前缀来绑定:

![示意图](PixPin_2026-04-28_16-23-03.webp)

如前所说,我们引入id属性是为了对标签进行独特的修改,那么当一个元素同时拥有 id 和 class，且两者定义了同一个属性时,**id 的样式会覆盖 class 的样式**,这与它们在代码中出现的先后顺序无关.
### 中断符
#### hr
`<hr>`表示界面的中断,会在文本中间划一道分割线.通常用它来分割内容:
![示意图](PixPin_2026-04-26_23-41-12.webp)
- hr: Horizontal Rule,水平分割线
#### br
`<br>`表示换行,在文本中强制插入一个换行符,但不会开启新的段落:
![示意图](PixPin_2026-04-26_23-44-10.webp)

- br: Line Break,换行
### 排版元素表示
主要涉及: 表格/列表/容器/按钮
#### 表格
![示意图](PixPin_2026-04-28_15-44-56.webp)
在table标签中`tr`意思是**table row**,`td`意思是**table data**,`td`意思是`table head`,都很好理解
#### 列表
看首字母即可知道这几个元素的意思:

- ul: **unordered list**
- ol: **ordered list**
- dl: **description list**
- li: **list item**
- dt: **description term**(不用description item的原因可能是怕与div标签搞混)
- dd: **description details**

**分点列表(没有序号)**

```html
<ul>
  <li>Coffee</li>
  <li>Tea</li>
  <li>Milk</li>
</ul>
```
![示意图](PixPin_2026-04-28_15-58-13.webp)

**数字列表**

```html
<ol>
  <li>Coffee</li>
  <li>Tea</li>
  <li>Milk</li>
</ol>
```
![示意图](PixPin_2026-04-28_15-59-29.webp)

**加入描述的列表**

```html
<dl>
  <dt>Coffee</dt>
  <dd>- black hot drink</dd>
  <dt>Milk</dt>
  <dd>- white cold drink</dd>
</dl>
```

![示意图](PixPin_2026-04-28_16-00-12.webp)
##### 嵌套列表
![示意图](PixPin_2026-04-28_16-03-20.webp)
#### 容器(div)
>The <div> element is by default a **block element**, meaning that **it takes all available width**, and comes with line breaks before and after.

![示意图](PixPin_2026-04-28_16-05-30.webp)

之所以div叫做容器,因为它可以装载html元素成一个单独的分块,方便被css和js处理并渲染:

![示意图](PixPin_2026-04-28_16-07-00.webp)

#### span
该标签没有任何实质作用,仅仅是将一部分文本标记起来,方便通过设定class属性来供css和js操控:

![示意图](PixPin_2026-04-28_16-14-35.webp)

#### 按钮
```html
<button>Click Me</button>
```

- 不太懂html制定者的标准是什么,image五个字母要变成img,button六个字母却不变成btn甚至bt...

button最强大的地方在于可以通过onclick属性绑定js:
```html
<button onclick="alert('Hello!')">Click Me</button>
```


### 链接表示
**超文本链接**
```html
<a href="https://www.w3schools.com">This is a link</a>
```
- href: Hypertext Reference,意为跳转链接

>**a标签的详细说明**
>
>a对应的全称为anchor(锚点),指代互联网海洋中相互勾连的节点,你可以从一个锚点跳转到另一个锚点.

**图像链接**
```html
<img src="w3schools.jpg" alt="W3Schools.com" width="104" height="142">
```
这是我们目前为止看到的第一个不需要闭合的标签,因为我们无法用文本来指代图像.

- **src**: source,图片路径,可以是文件路径也可以是网页路径
- **alt**: **Alternate Text**,备用文本,以防图片无法正常显示时出现的占用文字,同时可以帮助盲人和爬虫理解.
- 宽高比通常由css设置,没必要在html中指定




### 嵌入文本文件/音视频
#### iframe
>**iframe**用于在html内部展示另一个html文件或者其他文本文件.

- iframe: **inline frame**,行内框架
**基本结构**
```html
<iframe src="url" title="description"></iframe>
```

![示意图](PixPin_2026-04-29_14-22-25.webp)

##### 流媒体展示
由于可以直接展示html网页,自然也就可以展示流媒体(B站,Youtube)中的音视频:
```html
<iframe 
    src="//player.bilibili.com/player.html?bvid=BV1yVQFBNEPn&page=1&high_quality=1&danmaku=0" 
    allow="autoplay; fullscreen; encrypted-media" 
    allowfullscreen="true" 
    width="100%" 
    height="500" 
    frameborder="0">
</iframe>
```

<iframe 
    src="//player.bilibili.com/player.html?bvid=BV1yVQFBNEPn&page=1&high_quality=1&danmaku=0&autoplay=0" 
    allow="fullscreen; encrypted-media" 
    allowfullscreen="true" 
    width="100%" 
    height="500" 
    frameborder="0">
</iframe>


#### video
video的用法与image标签别无二致
```html
<video 
    src="https://www.w3schools.com/html/mov_bbb.mp4" 
    controls 
    width="640">
    您的浏览器不支持 video 标签。
</video>
```

<video 
    src="https://www.w3schools.com/html/mov_bbb.mp4" 
    controls 
    width="640">
    您的浏览器不支持 video 标签。
</video>

#### audio
用法别无二致:

```html
<audio controls>
  <source src="horse.ogg" type="audio/ogg">
  <source src="horse.mp3" type="audio/mpeg">
Your browser does not support the audio element.
</audio>
```
值得注意的是,我们这里使用了source内部标签而没有将src作为父标签`audio`的属性,source标签用于为浏览器提供多样的选择,自上而下扫描第一个可用的源.
### 表单(form)
>早期不使用js的时候我们只能通过html中的表单(form)元素来提交用户输入,所以还是有必要了解的.

#### form标签
该标签作为所有输入标签的容器,不会单独出现
#### input标签
最常用的输入标签,根据内部的type属性来决定输入的内容,下面是一些常用的type属性值:
| Type                      | Description                                                      |
| :------------------------ | :--------------------------------------------------------------- |
| `<input type="text">`     | Displays a single-line text input field                          |
| `<input type="radio">`    | Displays a radio button (for selecting one of many choices)      |
| `<input type="checkbox">` | Displays a checkbox (for selecting zero or more of many choices) |
| `<input type="submit">`   | Displays a submit button (for submitting the form)               |
| `<input type="button">`   | Displays a clickable button                                      |
#### name属性
除了submit类型外,每个input标签都需要有一个**name属性**才可以被发送到服务器并被识别:
```html
<form action="/action_page.php">
  <label for="fname">First name:</label><br>
  <input type="text" id="fname" value="John"><br><br>
  <input type="submit" value="Submit">
</form>
```
#### label标签
该标签用于显示输入提示,因为**input标签是无闭合的**,所以需要额外的信息来提示用户输入:
```html
<form>
  <label for="fname">First name:</label><br>
  <input type="text" id="fname" name="fname"><br>
  <label for="lname">Last name:</label><br>
  <input type="text" id="lname" name="lname">
</form>
```

**渲染出来的界面如下:**

<form>
  <label for="fname">First name:</label><br>
  <input type="text" id="fname" name="fname"><br>
  <label for="lname">Last name:</label><br>
  <input type="text" id="lname" name="lname">
</form>


我们可以看到label标签中有个for属性,可以看到它与input标签中的id属性值相同.它主要用于将label和input标签绑定起来,当点击标签文素时,**浏览器可以自动帮你将光标聚焦到输入框内**.

事实上,尽管form有很多功能还没提及,但了解到这里就够了,能够看懂JSX中的输入标签即可.

### Head部分的标签
#### 概览
| Tag        | Description                                                           |
| :--------- | :-------------------------------------------------------------------- |
| `<head>`   | Defines information about the document                                |
| `<title>`  | Defines the title of a document                                       |
| `<base>`   | Defines a default address or a default target for all links on a page |
| `<link>`   | Defines the relationship between a document and an external resource  |
| `<meta>`   | Defines metadata about an HTML document                               |
| `<script>` | Defines a client-side script                                          |
| `<style>`  | Defines style information for a document                              |

下面开始逐个解释这些标签:

#### **title**
功能:
1. defines a title in the browser toolbar
2. provides a title for the page when it is added to favorites
3. displays a title **for the page in search engine-results**

```html
<!DOCTYPE html>
<html>
<head>
  <title>A Meaningful Page Title</title>
</head>
<body>

The content of the document......

</body>
</html>
```

#### **style**
功能:

- 写入内嵌css

```html
<style>
  body {background-color: powderblue;}
  h1 {color: red;}
  p {color: blue;}
</style>
```

#### **link**
功能:

1. 引入外部静态文件

说明:

1. rel: relationship,点名这个文件的格式和功能
2. type: 对于图像等格式众多的文件,需要额外说明它的具体格式

引入外部css文件
```html
<link rel="stylesheet" href="mystyle.css">
```
引入标题栏的图标:
```html
<!DOCTYPE html>
<html>
<head>
  <title>My Page Title</title>
  <link rel="icon" type="image/x-icon" href="/images/favicon.ico">
</head>
<body>
<!-- omitted -->
</body>
</html>
```

#### **meta**

功能:

1. pecify the character set, page description, keywords, author of the document, and viewport settings.
2. 不会展示在页面上,仅供浏览器/搜索引擎识别和处理

Define the character set used:

```html
<meta charset="UTF-8">
```

Define keywords for search engines:

```html
<meta name="keywords" content="HTML, CSS, JavaScript">
```

Define a description of your web page:

```html
<meta name="description" content="Free Web tutorials">
```

Define the author of a page:

```html
<meta name="author" content="John Doe">
```

Refresh document every 30 seconds:

```html
<meta http-equiv="refresh" content="30">
```

Setting the viewport to make your website look good on all devices:

```html
<meta name="viewport" content="width=device-width, initial-scale=1.0">
```

#### script
由于html的某些设计问题,js代码没有像css一样用link进行导入,而是单独引入了一个标签script:

```html
<script>
function myFunction() {
  document.getElementById("demo").innerHTML = "Hello JavaScript!";
}
</script>
```
### body部分的语义标签(semantic elements)
这一部分主要是谈一下一些常用的语义标签,它们基本都可以在JSX中找到对应的元素

#### section标签
将文档分节,一般用在以下位置:

1. Chapters
2. Introduction
3. News items
4. Contact information

```html
<section>
<h1>WWF</h1>
<p>The World Wide Fund for Nature (WWF) is an international organization working on issues regarding the conservation, research and restoration of the environment, formerly named the World Wildlife Fund. WWF was founded in 1961.</p>
</section>

<section>
<h1>WWF's Panda symbol</h1>
<p>The Panda has become the symbol of WWF. The well-known panda logo of WWF originated from a panda named Chi Chi that was transferred from the Beijing Zoo to the London Zoo in the same year of the establishment of WWF.</p>
</section>
```

- 没什么难懂的

#### article标签
用于展示文章和评论:

```html
<article>
<h2>Google Chrome</h2>
<p>Google Chrome is a web browser developed by Google, released in 2008. Chrome is the world's most popular web browser today!</p>
</article>

<article>
<h2>Mozilla Firefox</h2>
<p>Mozilla Firefox is an open-source web browser developed by Mozilla. Firefox has been the second most popular web browser since January, 2018.</p>
</article>

<article>
<h2>Microsoft Edge</h2>
<p>Microsoft Edge is a web browser developed by Microsoft, released in 2015. Microsoft Edge replaced Internet Explorer.</p>
</article>
```
#### header标签
展示引言:
```html
<article>
  <header>
    <h1>What Does WWF Do?</h1>
    <p>WWF's mission:</p>
  </header>
  <p>WWF's mission is to stop the degradation of our planet's natural environment,
  and build a future in which humans live in harmony with nature.</p>
</article>
```
#### footer标签
展示脚注:
```html
<footer>
  <p>Author: Hege Refsnes</p>
  <p><a href="mailto:hege@example.com">hege@example.com</a></p>
</footer>
```
#### nav标签
展示导航链接:

```html
<nav>
  <a href="/html/">HTML</a> |
  <a href="/css/">CSS</a> |
  <a href="/js/">JavaScript</a> |
  <a href="/jquery/">jQuery</a>
</nav>
```
#### figure与figcaption标签
由于img,video等标签无法展示说明文字或者标题,只能通过div容器的包装实现假标题,所以HTML5中引入了这figure和figcaption标签,用于更好地展示图表:

```html
<figure>
  <img src="pic_trulli.jpg" alt="Trulli">
  <figcaption>Fig1. - Trulli, Puglia, Italy.</figcaption>
</figure>
```

![示意图](PixPin_2026-04-30_12-35-25.webp)


### 总结
首先我们需要知道的是,大多数html标签都是闭合的,需要写成类似`<p> </p>`的格式,少数标签如img,input,meta和换行符才不需要闭合.

其次,我们一直没有深入探讨html元素的原生style修饰,那是因为在html中指明样式太麻烦了,所以在html诞生不久之后,又一个划时代的标记语言: CSS,产生了.

## CSS
- [wiki](https://en.wikipedia.org/wiki/CSS)

>**Cascading Style Sheets** (CSS) is a style sheet language used for specifying the presentation and styling of a document written in a markup language, such as **HTML or XML**.

- 总结一下就是,**css是因为html中的style写法很麻烦才发明出来的**

### CSS历史
#### 单体版本阶段 (1994 - 2011)
此阶段 CSS 作为一个整体规范进行线性迭代。

* **1994 - 1996：诞生与 CSS1**
    * **1994**：Håkon Wium Lie 提出 CSS 构想。
    * **1996**：**CSS 1.0** 正式发布。定义了基础的文字颜色、字体和盒模型。
* **1998：功能扩张与 CSS2**
    * 发布 **CSS 2.0**。引入了 `absolute/relative` 定位、`z-index` 及媒体类型（如打印样式）。
* **2011：基石奠定与 CSS 2.1**
    * 经过 13 年的浏览器兼容性博弈与修正，**CSS 2.1** 发布。它删除了未被实现的特性，成为现代 CSS 的核心基石。


#### 模块化演进阶段 (1999 - 至今)
自 CSS3 起，W3C 废弃了整体版本号，将规范拆分为数十个独立的**模块 (Modules)**。

* **1999 - 2011：CSS3 模块化开启**
    * 规范被拆分为“选择器”、“颜色”、“盒模型”等模块。
    * **版本逻辑**：在 CSS2.1 已有的功能基础上，新版本编号从 **Level 3** 开始（即常说的 CSS3）。
* **2012 - 2020：高版本模块迭代 (CSS4/5 概念)**
    * 不存在整体的“CSS4”文件。
    * **Level 4 演进**：当 Level 3 模块开发完成后，自动进入 **Level 4**（如 `Selectors Level 4` 引入了 `:has()` 选择器）。
    * **Level 1 起步**：对于全新特性（如 Flexbox、Grid），版本号从 **Level 1** 开始。
* **2021 - 2026：年度快照 (Snapshots)**
    * W3C 定期发布 **CSS Snapshot**，定义当前已稳定并被主流浏览器广泛支持的模块集合，作为开发者的实践参考。

看得出来CSS本身的生态比起HTML来更加混乱,甚至没有一个统一的版本号.

### CSS基本语法
一个常见的css写法如下:
![示意图](PixPin_2026-04-30_12-38-22.webp)

- selector: 选择器,指向被修饰的元素
- declaration: 修饰语句
- property: 修饰所用的属性
- value: 属性值

可以看到css用分号将多个修饰语句隔开,用`{}`隔离不同的修饰段,比起html语义更加清晰了:

```css
p {
  color: red;
  text-align: center;
}
```
#### 基本的css选择器
##### 标签元素的修饰
该方法通常用于全局样式的处理,例如下面的代码会将所有的p标签变红:
```css
p {
  text-align: center;
  color: red;
}
```
##### id和class属性的修饰
id选择器只会处理单个标签:
```css
#para1 {
  text-align: center;
  color: red;
}
```
而class选择器处理一类标签:
```css
/* In this example all HTML elements with class="center" will be red and center-aligned:  */
.center {
  text-align: center;
  color: red;
}
```
##### 多个元素的选择
通配符`*`会影响**html中的所有元素**:
```css
* {
  text-align: center;
  color: blue;
}
```

而有时候如果多个元素的处理方法相同的话,我们可以这样写:
```css
h1 {
  text-align: center;
  color: red;
}

h2 {
  text-align: center;
  color: red;
}

p {
  text-align: center;
  color: red;
}
```
显然这么写太麻烦了,我们可以合并一下变成下面这样:
```css
h1, h2, p {
  text-align: center;
  color: red;
}
```

#### 层叠的css
之所以CSS叫做**Cascading Style Sheets**,是因为当一个html中含有多个css时,它按照以下顺序解读:
1. Inline style (inside an HTML element)
2. External and internal style sheets (in the head section)
   1. 后定义的样式表属性会覆盖先定义的样式表中的相同属性
3. Browser default
### CSS调色
#### 颜色属性名
**color**,调整标签中文本的颜色:
```html
<h1 style="color:Tomato;">Hello World</h1>
<p style="color:DodgerBlue;">Lorem ipsum...</p>
<p style="color:MediumSeaGreen;">Ut wisi enim...</p>
```

**border**,调整标签的边框颜色:
![示意图](PixPin_2026-05-01_22-40-11.webp)

**background-color**,调整标签背景颜色:

```html
<h1 style="background-color:rgb(255, 99, 71);">...</h1>
<h1 style="background-color:#ff6347;">...</h1>
<h1 style="background-color:hsl(9, 100%, 64%);">...</h1>

<h1 style="background-color:rgba(255, 99, 71, 0.5);">...</h1>
<h1 style="background-color:hsla(9, 100%, 64%, 0.5);">...</h1>
```

效果:
![示意图](PixPin_2026-05-01_23-07-42.webp)


#### 调色方法
##### 通过颜色名调色
```html
<h1 style="color:Tomato;">Hello World</h1>
<p style="color:DodgerBlue;">Lorem ipsum...</p>
<p style="color:MediumSeaGreen;">Ut wisi enim...</p>
```
![示意图](PixPin_2026-05-01_21-58-26.webp)
##### 通过RGB调色
**RGB**: red,green,blue,通过调整三原色的数值(取值为0-255),我们可以展示所有的颜色.
```html
<!DOCTYPE html>
<html>
<body>

<h1>Specify colors using RGB values</h1>

<h2 style="background-color:rgb(255, 0, 0);">rgb(255, 0, 0)</h2>
<h2 style="background-color:rgb(0, 0, 255);">rgb(0, 0, 255)</h2>
<h2 style="background-color:rgb(60, 179, 113);">rgb(60, 179, 113)</h2>
<h2 style="background-color:rgb(238, 130, 238);">rgb(238, 130, 238)</h2>
<h2 style="background-color:rgb(255, 165, 0);">rgb(255, 165, 0)</h2>
<h2 style="background-color:rgb(106, 90, 205);">rgb(106, 90, 205)</h2>

</body>
</html>
```
**效果**
![示意图](PixPin_2026-05-01_23-13-42.webp)

**RGBA**: red,green,blue,alpha,其中,alpha用于调整背景颜色的**不透明度**,取值为0-1.

![示意图](PixPin_2026-05-01_23-24-22.webp)

RGBA本质上是线性插值运算:

$$C_o = \alpha C_f + (1 - \alpha) C_b$$
其中：
*   $C_o$：输出颜色（Output）
*   $C_f$：前景颜色（Foreground）
*   $C_b$：背景颜色（Background）
*   $\alpha$：[0, 1] 之间的取值

##### 通过HEX调色
HEX: **hexadecimal**,用十六进制来表示之前的RGB,那么每种原色就需要两位数字,相当于`#rrggbb`:
![示意图](PixPin_2026-05-02_13-00-52.webp)

由于个位数上的差别不会对颜色有多大的影响,故我们可以使用三位数的缩写:
```css
body {
  background-color: #fc9; /* same as #ffcc99 */
}

h1 {
  color: #f0f; /* same as #ff00ff */
}

p {
  color: #b58; /* same as #bb5588 */
}
```
##### 通过HSL调色
hsl,**(hue, saturation, lightness)**:

- Hue is **a degree on the color wheel** (from 0 to 360):
  - 0 (or 360) is red
  - 120 is green
  - 240 is blue
- Saturation is a percentage value: 0% means a shade of gray, and 100% is the full color.
  - 灰度层,相当于调整颜色的鲜艳度
- Lightness is also a percentage; 0% is black, 50% is neither light or dark, 100% is white.
  - 亮度层,相当于调整颜色的打光度

![示意图](PixPin_2026-05-02_13-06-02.webp)
### CSS调整背景
#### 调整背景颜色
**background-color**可以对所有的html元素生效:

```css
h1 {
  background-color: green;
}

div {
  background-color: lightblue;
}

p {
  background-color: yellow;
}
```

还可以在background-color的基础上调整背景颜色的透明度:
```css
div {
  background-color: green;
  opacity: 0.3;
}
```

![示意图](PixPin_2026-05-03_10-06-49.webp)

#### 设置背景图像

我们需要通过url参数来定位图像
```css
body {
  background-image: url("paper.gif");
}
/* 这里的引号不是必须的,但可以提升兼容性 */
```

By default, the image is repeated so it covers the entire element:
![示意图](PixPin_2026-05-03_10-10-43.webp)

因此,我们需要对图像的默认重复做出调整,比如调整为只在水平方向/垂直方向重复,或者调整为不重复:
```css
body {
  background-image: url("gradient_bg.png");
  background-repeat: repeat-x;
}
```

```css
body {
  background-image: url("img_tree.png");
  background-repeat: no-repeat;
}
```
![示意图](PixPin_2026-05-03_10-13-10.webp)

我们还可以设置图像的位置:
```css
body {
  background-image: url("img_tree.png");
  background-repeat: no-repeat;
  background-position: right top;
}
```
![示意图](PixPin_2026-05-03_10-14-16.webp)

还可以让图像随着页面一起滚动:
```css
body {
  background-image: url("img_tree.png");
  background-repeat: no-repeat;
  background-position: right top;
  background-attachment: fixed;
}
```

四个参数一个个写太麻烦了,所以我们可以全都合并到background参数里面:
```css
body {
  background: #ffffff url("img_tree.png") no-repeat right top;
}
```

The `background` property is a shorthand property for the following properties:

*   **background-color**
*   **background-image**
*   **background-position**
*   **background-size**
*   **background-repeat**
*   **background-attachment**
*   **background-origin**
*   **background-clip**

If some of the property values are missing, they will be set to their initial (default) values.
### CSS调整边界/页边距/空白(待补充)
### 高级CSS选择器
#### 选择符
- [简单有效的知乎专栏](https://zhuanlan.zhihu.com/p/180011240)
##### 空格
选择某元素内的所有子元素
```css
<style type="text/css">
	h1 strong {
		color: red;
	}
</style>

<body>
	<h1>
		<strong>一代子元素</strong>
	</h1>
	<h1>
		<span>
			<strong>二代子元素</strong>
		</span>
	</h1>
</body>
```
- 上述的两个strong标签都会被选中

##### 大于号
选择某元素后的一代子元素
```css
<style type="text/css">
	h1>strong {
		color: red;
	}
</style>

<body>
	<h1>
		<strong>一代子元素</strong>
	</h1>
	<h1>
		<span>
			<strong>二代子元素</strong>
		</span>
	</h1>
</body>
```
- 只有一代的strong标签会被选中

#### 属性选择器
- [菜鸟教程](https://www.runoob.com/css/css-attribute-selectors.html)

```css
/* 选择所有具有 `type` 属性的元素 */
[type] {
  border: 1px solid red;
}
```

```css
/* 选择所有 `type` 属性等于 `text` 的元素 */
[type="text"] {
  background-color: yellow;
}
```
#### 合并选择
我们可以将普通的选择和类选择合并,变成这样:
```css
p.dotted {outline-style: dotted;}
```
- 上述代码只会选择具有dotted类的p标签.
#### 伪类
css中有一类关键词被称为**伪类(Pseudo-classes)**,它可以加在选择器的后面,达成一些特殊的目的,如:
1. Style an element when a user moves the mouse over it
2. Style visited and unvisited links differently
3. Style an element when it gets focus
4. Style valid/invalid/required/optional form elements
5. Style an element that is the first child of its parent

语法如下,使用了冒号:
```css
selector:pseudo-class-name {
  CSS properties
}
```

常用的一些伪类如下:
*   `:hover`：鼠标指针悬停在元素上时。
*   `:active`：元素被激活时（如鼠标按下未释放）。
*   `:focus`：元素获得焦点时（如通过 Tab 键选中输入框）。
*   `:visited`：链接已被访问过。
*   
*   `:disabled`：匹配禁用的表单元素。
*   `:enabled`：匹配可用的表单元素。
*   `:checked`：匹配选中的复选框（checkbox）或单选按钮（radio）。
*   
*   `:first-child`：匹配其父元素的第一个子元素。
*   `:last-child`：匹配其父元素的最后一个子元素。
*   `:nth-child(n)`：匹配其父元素的第 n 个子元素（可用 `2n` 表示偶数，`odd` 表示奇数）。
*   `:only-child`：匹配父元素中唯一的子元素。

例如,我们可以这样调整a标签:
```css
/* unvisited link */
a:link {
  color: #FF0000;
}

/* visited link */
a:visited {
  color: #00FF00;
}

/* mouse over link */
a:hover {
  color: #FF00FF;
}

/* selected link */
a:active {
  color: #0000FF;
}
```

例如,选择特定的子元素:
![示意图](PixPin_2026-05-05_16-47-43.webp)

#### 伪元素
另一类更少见的关键词是**伪元素（Pseudo-Elements）**,它主要用来更改一段文本的特定部分,例如:
1. Style the first letter or first line, of an element
2. Style the user-selected portion of an element
3. Style the viewbox behind a dialog box

语法如下:
```css
selector::pseudo-element-name {
  CSS properties
}
```

例如,我们可以只渲染一个段落的第一行:
```css
p::first-line {
  color: red;
  font-variant: small-caps;
  font-size: 19px;  
}
```
![示意图](PixPin_2026-05-05_16-53-44.webp)


我们偶尔会看到CSS代码中出现`@`这个符号,它的作用十分广大,属于CSS的高级语法
### @规则
我们经常可以在css中看到诸如`@import`,`@media`等语句,它们都属于@规则(at-rules),属于一个比较高级的css语法.
#### 概览
| At-rule                    | Description                                                                                                                                                                                                                                       |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`@charset`**             | Specifies the character encoding used in the style sheet                                                                                                                                                                                          |
| **`@container`**           | Define styles for elements in container, depending on the container's size or style                                                                                                                                                               |
| **`@counter-style`**       | Lets you define your own counter styles                                                                                                                                                                                                           |
| **`@font-face`**           | Specifies a custom font with which to display text                                                                                                                                                                                                |
| **`@font-palette-values`** | Allows you to customize the default values of a font-palette                                                                                                                                                                                      |
| **`@import`**              | Allows you to import a style sheet into another style sheet                                                                                                                                                                                       |
| **`@keyframes`**           | Controls the steps in an animation by defining styles for points along the animation sequence                                                                                                                                                     |
| **`@layer`**               | Used to control how the CSS cascade layers evaluates the order of styles                                                                                                                                                                          |
| **`@media`**               | Applies parts of a style sheet based on the result of one or more media queries                                                                                                                                                                   |
| **`@namespace`**           | Defines an XML namespace to be used in the style sheet                                                                                                                                                                                            |
| **`@page`**                | Customizes the dimension, orientation, and margins of printed pages                                                                                                                                                                               |
| **`@property`**            | Allows you to define custom CSS properties directly in the stylesheet without having to run any JavaScript. This at-rule has data type checking and constraining, sets default values, and defines whether the property can inherit values or not |
| **`@scope`**               | Allows you to select elements in specific DOM subtrees and target elements precisely without writing overly-specific selectors                                                                                                                    |
| **`@starting-style`**      | Defines an element's starting styles before the element gets its first style update                                                                                                                                                               |
| **`@supports`**            | Used to test whether a browser supports a CSS feature                                                                                                                                                                                             |
#### 参考文章
- [一个比较全面的参考文章](https://www.cnblogs.com/coco1s/p/16853591.html)
  - 看这篇文章就够了.
### flex布局
- [阮一峰教程](https://www.ruanyifeng.com/blog/2015/07/flex-grammar.html)
### 特殊css语法
#### :root选择器
- [参考](https://www.w3schools.com/cssref/sel_root.php)

root选择器会作用于所有的html元素,注意,是所有的.它永远指向html标签,所有的后代元素都会继承这些属性.
```css
:root
{
    background:#ff0000;
}
```
但是,:root的优先级不是最高的,CSS 的权重由高到低排列如下：

1. Inline 样式（写在 HTML 标签内的 style="..."）
2. ID 选择器（如 #app）
3. 类/伪类/属性选择器（如 .btn, :root, :hover, [disabled]）
4. 元素/伪元素选择器（如 html, body, div, ::before）

:root 属于第 3 级。因此，ID 选择器和 Inline 样式的优先级都高于 :root。
```css
/* 1. 在根元素上定义变量 */
:root {
  --theme-color: oklch(0.6 0.118 184.704); /* 青色 */
}

/* 2. 使用 HTML 元素选择器（权重低于 :root） */
html {
  --theme-color: red; /* 无法覆盖 :root，因为 :root 权重更高 */
}

/* 3. 使用 ID 选择器（权重高于 :root） */
#page-root {
  --theme-color: blue; /* 成功覆盖！如果 <html> 标签带有 id="page-root"，变量将变为蓝色 */
}
```

>如果你在 :root 中定义了基础变量，后续在特定组件（如 .dark-theme 类）中需要修改变量时，由于类选择器的权重与 :root 平级，只要后面的解析顺序靠后，或者选择器更具体（如 body.dark-theme），就能轻易覆盖掉全局变量，实现主题切换。
#### 自定义属性
出于让css属性的作用更加清晰的目的,我们会自定义一些css属性,在属性名字前加上`--`前缀即可:
```css
:root {
  --radius: 0.625rem;
  --background: oklch(1 0 0);
  --foreground: oklch(0.145 0 0);
  --card: oklch(1 0 0);
  --card-foreground: oklch(0.145 0 0);
}
```
使用时,我们需要通过var关键字来调用自定义属性,告知浏览器去找我们自定义的值:
```css
.card {
  /* 使用 --radius 变量设置圆角 */
  border-radius: var(--radius); 
  
  /* 使用 --card 和 --card-foreground 设置背景色和文字颜色 */
  background-color: var(--card);
  color: var(--card-foreground);
  
  /* 使用 --border 变量设置边框颜色 */
  border: 1px solid var(--border);
}
```
甚至还可以通过calc关键字对数字类的变量进行数学运算:
```css
.large-card {
  /* 将原本 0.625rem 的圆角放大两倍 */
  border-radius: calc(var(--radius) * 2); 
}
```



### 实战: 实现明暗主题切换
**index.html**
```html
<!DOCTYPE html>
<html lang="zh-CN" data-theme="light">
<head>
  <meta charset="UTF-8">
  <title>主题切换示例</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>

  <div class="card">
    <h2>主题切换核心原理</h2>
    <p>通过修改 html 标签上的 data-theme 属性，触发不同作用域下的 CSS 变量覆盖。</p>
    <button id="theme-toggle">切换主题</button>
  </div>

  <script>
    const toggleBtn = document.getElementById('theme-toggle');
    const htmlEl = document.documentElement;

    toggleBtn.addEventListener('click', () => {
      const currentTheme = htmlEl.getAttribute('data-theme');
      const nextTheme = currentTheme === 'light' ? 'dark' : 'light';
      htmlEl.setAttribute('data-theme', nextTheme);
    });
  </script>
</body>
</html>
```
**style.css**
```css
/* ==========================================================================
   1. 变量定义（利用属性选择器进行同级权重覆盖）
   ========================================================================== */

/* 默认浅色主题：绑定在带有 data-theme="light" 的根元素上 */
:root[data-theme="light"] {
  --background: oklch(1 0 0);           /* 纯白 */
  --foreground: oklch(0.145 0 0);       /* 深灰黑 */
  --card: oklch(0.98 0 0);              /* 极浅灰 */
  --border: oklch(0.922 0 0);           /* 浅灰边框 */
  --primary: oklch(0.5982 0.10687 182.4689); /* 品牌青色 */
  --primary-foreground: oklch(1 0 0);  /* 按钮文字白 */
}

/* 深色主题：当属性变为 data-theme="dark" 时，同权重的变量被整组覆盖 */
:root[data-theme="dark"] {
  --background: oklch(0.145 0 0);       /* 深灰黑 */
  --foreground: oklch(0.985 0 0);       /* 接近纯白 */
  --card: oklch(0.2 0 0);               /* 稍浅的深灰 */
  --border: oklch(0.3 0 0);             /* 暗灰边框 */
  --primary: oklch(0.65 0.12 182.4689);  /* 略微调高亮度的青色 */
  --primary-foreground: oklch(0.1 0 0); /* 按钮文字黑 */
}

/* ==========================================================================
   2. 样式应用（业务代码完全不需要感知当前是什么主题，直接引用变量）
   ========================================================================== */

body {
  background-color: var(--background);
  color: var(--foreground);
  font-family: system-ui, sans-serif;
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  margin: 0;
  /* 平滑过渡主题切换时的色彩突变 */
  transition: background-color 0.3s ease, color 0.3s ease;
}

.card {
  background-color: var(--card);
  border: 1px solid var(--border);
  padding: 2rem;
  border-radius: 0.625rem;
  max-width: 400px;
  box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.05);
  transition: background-color 0.3s ease, border-color 0.3s ease;
}

button {
  background-color: var(--primary);
  color: var(--primary-foreground);
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 0.375rem;
  cursor: pointer;
  font-weight: 500;
  transition: background-color 0.3s ease, color 0.3s ease;
}

button:hover {
  filter: brightness(0.9);
}
```
可以看到,我们通过设置两套css属性,和简单的js脚本,就实现了明暗主题的切换:

![亮主题](PixPin_2026-05-20_13-44-25.webp)

![暗主题](PixPin_2026-05-20_13-44-42.webp)

### 总结
现代的css可以非常复杂,并非我们通常认为的那样简单,后面会介绍一些现代css框架,减少css编写的难度,但先让我们进入Javascript的世界,让网页动起来吧.

## JavaScript
- [wiki](https://en.wikipedia.org/wiki/JavaScript)

JS是一门让静态网页`动起来`的脚本语言,CSS和HTML只用于展示内容,而JS用于真正的**用户交互**.

### JS历史
#### 1. 诞生与混乱期 (1995 - 1996)
* **1995年5月**：Brendan Eich 在 Netscape 仅用 10 天设计出原型，初名 **Mocha**。
* **1995年9月**：更名为 **LiveScript** 随 Navigator 2.0 beta 发布。
* **1995年12月**：Netscape 与 Sun 联手，将其正式定名为 **JavaScript**（纯粹的营销策略，与 Java 无关）。
* **1996年**：微软发布 **JScript**（IE3.0），浏览器战争爆发，兼容性碎片化开始。



#### 2. 标准化初期 (1997 - 1999)
* **1997年6月**：**ECMAScript 1 (ES1)** 发布，确立了语言的标准核心。
* **1998年6月**：**ES2** 发布，主要与 ISO 国际标准对齐。
* **1999年12月**：**ES3** 发布。引入正则表达式、try/catch、`switch` 等现代语法，成为此后十年网页脚本的基石。


#### 3. 停滞与再生期 (2000 - 2009)
* **2000 - 2008年**：由于微软 IE 占据 95% 市场份额，标准制定陷入僵局，激进的 **ES4** 提案因过于复杂被废弃。
* **2005年**：**AJAX** 概念提出，JS 从“弹窗小工具”转型为开发 Web 应用的核心。
* **2008年**：Google 发布 **Chrome (V8 引擎)**，引入 JIT 编译技术，JS 运行速度实现量级跨越。
* **2009年**：**Node.js** 诞生，JS 脱离浏览器进入服务器端领域。
* **2009年12月**：**ES5** 正式发布。增加“严格模式”、JSON 支持及数组原型方法（如 `map`, `filter`）。



#### 4. 现代爆发期 (2015 - 至今)
* **2015年6月**：**ES6 (ECMAScript 2015)** 发布。这是历史上最大的更新，引入了类 (Class)、箭头函数、模块化 (Modules)、Promise 等现代编程特性。
* **年度迭代机制**：自 ES6 后，TC39 委员会改为每年发布一个小版本，不再通过版本号（如 ES7/8）而是通过年份命名。
    * **ES2016 - ES2023**：持续引入 `async/await`、可选链 (`?.`)、空值合并 (`??`) 等特性。

### JS语法
- [js.info教程](https://zh.javascript.info/)
  - 很全面,但会谈到很多不必要的琐碎知识点,建议该跳过的就跳过,不然看的很累
JS的设计一开始非常糟糕,现在的良好架构都是在后来加上的,所以我们只学习最新的语法即可,而不用管哪些琐碎的老旧知识点.

#### 基础语法
- 学js前建议先入门一个后端语言如cpp和python,不然js的混乱语法会把你搞得很懵
##### 变量声明与定义
普通变量的定义如下:
```js
// 先声明再赋值

let message;
message = 'Hello'; // 将字符串 'Hello' 保存在名为 message 的变量中

// 定义多个变量的两种方法

let user = 'John', age = 25, message = 'Hello';

let user = 'John';
let age = 25;
let message = 'Hello';
```

常量定义如下:
```js
const myBirthday = '18.04.1982';

myBirthday = '01.01.2001'; // 错误，不能对常量重新赋值
```
##### 变量类型
由于JS和python一样本身是动态类型的,所以一个变量可以被赋不同类型的值多次,需要重点理解的是null和undefined类型,它们是一类特殊的值,也是js的一大难点.

- undefined: 未被赋值,表示该值未初始化.
- null: 空值,通常用在占位符和函数的返回值中.
##### 严格相等: ===运算符
普通的相等性检查存在一个问题,它不能区分0和false,也不能区分空字符串和flase,原因是`==`会在进行比较时先进行类型转换.

最值得诟病的就是以下这个特性:

```js
null == undefined //true
null == 0;           // false
undefined == false;  // false
```

- 而当使用其他数学式(<,>,<=,>=)时,null被转换成0,undefined被转换成`NaN`,`NaN`值与任何值进行大小比较都会返回false


因此,js又设计了`===`运算符,在比较时不进行转换,而是直接进行比较.

所以下面这个结果就比较正常:
```js
alert( null === undefined ); // false
```

因此,我们需要在恰当的时机使用`===`,从而规避`undefined`和`null`带来的麻烦.
##### 问号运算符的新特性
ECMAScript 2020 引入了`?.`和`??`运算符,由于这两个运算符特别强大,不久便被广泛用在前端代码中,所以需要特别了解.

可选链运算符: ?.
- 功能: 如果`?.`左侧的值为`null`或者`undefined`,表达式将短路并返回`undefined`,而不会报错

**使用.会导致报错**
```js
let user = {}; // 一个没有 "address" 属性的 user 对象

alert(user.address.street); // Error!
```

**而使用?.就不会**
```js
let user = {}; // user 没有 address 属性

alert( user?.address?.street ); // undefined（不报错）
```

空值合并运算符: ??
- 功能: 当左侧的操作数为null或者undefined时,返回右侧操作数,否则返回左侧操作数

至于为什么在有`||`的情况下还要推出`??`,是因为`|| `会在左侧为任何“虚值”（如 0, "", false和 null/undefined）时返回右侧，而 `??` 只针对 null 和 undefined。
```js
const count = 0;
const result1 = count || 10; // 结果为 10，因为 0 是虚值
const result2 = count ?? 10; // 结果为 0，因为 0 不是 null 或 undefined
```

如此一来,即便我们对于某个变量的值赋为0和空字符串,也可以正常运作,而不是在使用`||`的时候被替换成默认值.
##### 反引号
js中的单双引号都不支持跨行字符串,也不支持变量嵌入,而反引号可以做到上述两点,并在JSX和TSX中发挥出非常大的威力:

```js
function sum(a, b) {
  return a + b;
}

alert(`1 + 2 = ${sum(1, 2)}.`); // 1 + 2 = 3.

let guestList = `Guests:
 * John
 * Pete
 * Mary
`;

alert(guestList); // 客人清单，多行
```
#### 函数
##### 函数的创建
有三种语法可以创建函数:
1. 函数声明
2. 函数表达式
3. 箭头函数(ES6引入)
**函数声明**
```js
function sayHi() {
  alert( "Hello" );
}
// 函数声明没有分号
```

**函数表达式**
```js
let sayHi = function() {
  alert( "Hello" );
};
// 写成表达式要有分号
```
**箭头函数**
```js
let sum = (a, b) => a + b;

/* 这个箭头函数是下面这个函数的更短的版本：

let sum = function(a, b) {
  return a + b;
};
*/

alert( sum(1, 2) ); // 3
```

如果只有一个参数,我们还可以省略参数外的圆括号:
```js
let double = n => n * 2;
// 差不多等同于：let double = function(n) { return n * 2 }

alert( double(3) ); // 6
```

但如果是多行函数,我们需要在函数体外加上花括号,并使用return来返回值:
```js
let sum = (a, b) => {  // 花括号表示开始一个多行函数
  let result = a + b;
  return result; // 如果我们使用了花括号，那么我们需要一个显式的 “return”
};

alert( sum(1, 2) ); // 3
```
##### 将函数作为参数
js的一大特性就是可以**将函数作为参数**:
```js
function ask(question, yes, no) {
  if (confirm(question)) yes()
  else no();
}

function showOk() {
  alert( "You agreed." );
}

function showCancel() {
  alert( "You canceled the execution." );
}

// 用法：函数 showOk 和 showCancel 被作为参数传入到 ask
ask("Do you agree?", showOk, showCancel);
```
- 函数 showOk 和 showCancel被称为**回调(callback)函数**

我们可以在调用时定义函数,不需要再写函数名字,这被称为**匿名函数**:
```js
function ask(question, yes, no) {
  if (confirm(question)) yes()
  else no();
}

ask(
  "Do you agree?",
  function() { alert("You agreed."); },
  function() { alert("You canceled the execution."); }
);
```


#### 对象
##### 创建对象
有两种方法来创建对象:
```js
let user = new Object(); // “构造函数” 的语法
let user = {};  // “字面量” 的语法
```
>第一种写法一看就知道是为了取悦Java,标榜自己是JavaScipt才诞生的,而下面一种写法与c语言的结构体很像,事实上也确实如此.

一个常见的js对象如下:
```js
let user = {     // 一个对象
  name: "John",  // 键 "name"，值 "John"
  age: 30        // 键 "age"，值 30
};

// 读取文件的属性：
alert( user.name ); // John
alert( user.age ); // 30
```
- 可以看到这就是普通的json字典或者说python字典而已,实际使用时我们也可以将对象作为字典来存储数据.

##### 遍历对象
js使用`for in`遍历字典对象,而非Java使用的`for :`:
```js
let user = {
  name: "John",
  age: 30,
  isAdmin: true
};

for (let key in user) {
  // keys
  alert( key );  // name, age, isAdmin
  // 属性键的值
  alert( user[key] ); // John, 30, true
}
```

##### 将函数加入对象中
```js
// 完整版本
user = {
  sayHi: function() {
    alert("Hello");
  }
};

// 简写版本
let user = {
  sayHi() { // 与 "sayHi: function(){...}" 一样
    alert("Hello");
  }
};
```

上述的两种方法都可以将函数写入对象里,一个采用了`key: value`的正式写法,另一个采用了简写语法糖,尽管简写版本才更符合平常写c结构体的直觉.
##### this关键字
与python一样,js引入了this引用符,用于指向实例化的对象,当然目前的对象都是实例化了的,我们可以直接使用,来访问对象内部定义的变量:
```js
let user = {
  name: "John",
  age: 30,

  sayHi() {
    // "this" 指的是“当前的对象”
    alert(this.name);
  }

};

user.sayHi(); // John
```

##### 构造函数
前面的对象都是使用{}构造符直接进行构造的,要想使用new关键字进行构造,我们需要先写一个**构造函数**:
```js
function User(name) {
  this.name = name;
  this.isAdmin = false;
}

let user = new User("Jack");

alert(user.name); // Jack
alert(user.isAdmin); // false
```

可以看到构造函数使用this引用符指向了某个对象,只在对象初始化的时候才会真正实现.

除此之外,构造函数有两个特点:
1. 首字母大写
2. 只能由new操作符执行

向构造函数中加入方法:
```js
function User(name) {
  this.name = name;

  this.sayHi = function() {
    alert( "My name is: " + this.name );
  };
}

let john = new User("John");

john.sayHi(); // My name is: John

/*
john = {
   name: "John",
   sayHi: function() { ... }
}
*/
```
#### 解构赋值
- 这个语法会被经常用在React中,所以需要特别关注

**解构赋值**: 将对象或者数组拆开,将其中的元素复制给一个或多个变量,而不修改原先的对象或数组.

- 有时候我们可以对任何可迭代对象使用解构赋值:

```js
let [a, b, c] = "abc"; // ["a", "b", "c"]
let [one, two, three] = new Set([1, 2, 3]);
```
##### 数组解构
一个简单的数组解构如下:

```js
let [firstName, surname] = "John Smith".split(' ');
alert(firstName); // John
alert(surname);  // Smith
```

但如果数组比左边的列表长,那么其余的数组将被忽略,这点与python还是有所不同的:
```js
let [name1, name2] = ["Julius", "Caesar", "Consul", "of the Roman Republic"];

alert(name1); // Julius
alert(name2); // Caesar
// 其余数组项未被分配到任何地方
```

如果你想一个不漏地接收,可以在最后一个变量名前加上`...`:
```js
let [name1, name2, ...rest] = ["Julius", "Caesar", "Consul", "of the Roman Republic"];

// rest 是包含从第三项开始的其余数组项的数组
alert(rest[0]); // Consul
alert(rest[1]); // of the Roman Republic
alert(rest.length); // 2
```

如果数组比左边的列表短,缺少对应值的变量都会被赋值undefined:
```js
let [firstName, surname] = [];

alert(firstName); // undefined
alert(surname); // undefined
```
如果想要给没有对应值的变量赋给默认值,可以用`=`提供,这在JSX中特别常见:
```js
// 默认值
let [name = "Guest", surname = "Anonymous"] = ["Julius"];

alert(name);    // Julius（来自数组的值）
alert(surname); // Anonymous（默认值被使用了）
```
##### 对象解构
很多时候我们需要将对象中的各个键值对拆分出来,这时候就可以使用对象解构:
```js
let options = {
  title: "Menu",
  width: 100,
  height: 200
};

let {title, width, height} = options;
// 均与对象中的键名字对应

alert(title);  // Menu
alert(width);  // 100
alert(height); // 200
```
但键的顺序并不重要:
```js
// 改变 let {...} 中元素的顺序也是等价的
let {height, width, title} = { title: "Menu", height: 200, width: 100 }
```

如果我们想自己给键起个新名字,可以这样写:
```js
let options = {
  title: "Menu",
  width: 100,
  height: 200
};

// { sourceProperty: targetVariable }
let {width: w, height: h, title} = options;

// width -> w
// height -> h
// title -> title

alert(title);  // Menu
alert(w);      // 100
alert(h);      // 200
```

同样,对于可能缺失的值,我们使用`=`赋予默认值:
```js
let options = {
  title: "Menu"
};

let {width = 100, height = 200, title} = options;

alert(title);  // Menu
alert(width);  // 100
alert(height); // 200
```
与数组解构一样,多余的变量会被忽略:
```js
let options = {
  title: "Menu",
  width: 100,
  height: 200
};

// 仅提取 title 作为变量
let { title } = options;

alert(title); // Menu
```

一个复杂的例子如下:
```js
let options = {
  size: {
    width: 100,
    height: 200
  },
  items: ["Cake", "Donut"],
  extra: true
};

// 为了清晰起见，解构赋值语句被写成多行的形式
let {
  size: { // 把 size 赋值到这里
    width,
    height
  },
  items: [item1, item2], // 把 items 赋值到这里
  title = "Menu" // 在对象中不存在（使用默认值）
} = options;

alert(title);  // Menu
alert(width);  // 100
alert(height); // 200
alert(item1);  // Cake
alert(item2);  // Donut
```
##### 真实应用
很多时候我们会写出这种难看的函数:
```js
function showMenu(title = "Untitled", width = 200, height = 100, items = []) {
  // ...
}
```
但更为实际的方法是将这些参数通通装入对象中,再在函数参数中解构:
```js
// 我们传递一个对象给函数
let options = {
  title: "My menu",
  items: ["Item1", "Item2"]
};

// ……然后函数马上把对象解构成变量
function showMenu({title = "Untitled", width = 200, height = 100, items = []}) {
  // title, items – 提取于 options，
  // width, height – 使用默认值
  alert( `${title} ${width} ${height}` ); // My Menu 200 100
  alert( items ); // Item1, Item2
}

showMenu(options);
```

要想使用函数的默认参数,我们必须传入一个空对象才可以:
```js
showMenu({}); // 不错，所有值都取默认值

showMenu(); // 这样会导致错误
```
因此我们可以在函数里就写明默认值为空对象:
```js
function showMenu({ title = "Menu", width = 100, height = 200 } = {}) {
  alert( `${title} ${width} ${height}` );
}

showMenu(); // Menu 100 200
```
##### 对象展开
- 由于对象展开与解构赋值干的事情差不多,所以就放在这里了.

如前所说,我们有时候会使用`...`来接收多余或者多出的变量:
```js
function showName(firstName, lastName, ...titles) {
  alert( firstName + ' ' + lastName ); // Julius Caesar

  // 剩余的参数被放入 titles 数组中
  // i.e. titles = ["Consul", "Imperator"]
  alert( titles[0] ); // Consul
  alert( titles[1] ); // Imperator
  alert( titles.length ); // 2
}

showName("Julius", "Caesar", "Consul", "Imperator");
```

但是js开发者显然很喜欢这个`...`,在**对象展开**的时候也要用它来干活,这被称为**Spread语法**:
```js
let arr = [3, 5, 1];

alert( Math.max(...arr) ); // 5（spread 语法把数组转换为参数列表）
```

一个更为复杂的应用如下:
```js
let obj = { a: 1, b: 2, c: 3 };

let objCopy = { ...obj }; // 将对象 spread 到参数列表中
                          // 然后将结果返回到一个新对象

// 两个对象中的内容相同吗？
alert(JSON.stringify(obj) === JSON.stringify(objCopy)); // true

// 两个对象相等吗？
alert(obj === objCopy); // false (not same reference)

// 修改我们初始的对象不会修改副本：
obj.d = 4;
alert(JSON.stringify(obj)); // {"a":1,"b":2,"c":3,"d":4}
alert(JSON.stringify(objCopy)); // {"a":1,"b":2,"c":3}
```

显然,对象展开与解构赋值干的活儿差不多,但是对象展开没必要知道对象内部有什么,而解构赋值是必须要一个个重新赋值或者确认的.因此,当我们仅仅是要跨越函数传递参数时,一般都使用**对象展开**,直到最后的执行函数才使用解构赋值.
#### OOP
js直到ES6才引入了class,大致的结构和python中的类没有区别.

##### 构造函数
class中的构造函数是`constructor`:
```js
class User {

  constructor(name) {
    this.name = name;
  }

  sayHi() {
    alert(this.name);
  }

}

// 用法：
let user = new User("John");
user.sayHi();
```
##### 继承与多态
js中的继承和java中一样使用关键字`extends`:
```js
class Rabbit extends Animal {
  hide() {
    alert(`${this.name} hides!`);
  }
}
```
与python中一样,JavaScript的所有方法都是默认可被重载的,在子类中重写方法会覆盖父类的方法,但可以通过super指向父类,调用父类的方法:
```js
class Rabbit extends Animal {
  stop() {
    // ……现在这个将会被用作 rabbit.stop()
    // 而不是来自于 class Animal 的 stop()
  }
}
```
与java一样,js可以用super关键字来指向父类:
```js
class Rabbit extends Animal {
  hide() {
    alert(`${this.name} hides!`);
  }

  stop() {
    super.stop(); // 调用父类的 stop
    this.hide(); // 然后 hide
  }
}
```
##### static关键字
尽管没有引入其他的修饰符,但js引入了static关键字,用于修饰静态方法和静态属性:
```js
class User {
  static staticMethod() {
    alert(this === User);
  }
}

User.staticMethod(); // true
```
#### 异常处理
```js
try {
  lalala; // error, variable is not defined!
} catch (err) {
  alert(err.name); // ReferenceError
  alert(err.message); // lalala is not defined
  alert(err.stack); // ReferenceError: lalala is not defined at (...call stack)

  // 也可以将一个 error 作为整体显示出来
  // error 信息被转换为像 "name: message" 这样的字符串
  alert(err); // ReferenceError: lalala is not defined
}
```
- js中的异常简单处理时,不需要专门用一个异常类指明,还是比较方便的

当然,js中也有专门的异常类:
```js
let error = new Error(message);
// 或
let error = new SyntaxError(message);
let error = new ReferenceError(message);
// ...
```
使用异常类可以让程序更加清晰,更好调试:
```js
let json = '{ "age": 30 }'; // 不完整的数据

try {

  let user = JSON.parse(json); // <-- 没有 error

  if (!user.name) {
    throw new SyntaxError("数据不全：没有 name"); // (*)
  }

  alert( user.name );

} catch(err) {
  alert( "JSON Error: " + err.message ); // JSON Error: 数据不全：没有 name
}
```
同样,js中也有一个收尾的finally关键字:
```js
try {
  alert( 'try' );
  if (confirm('Make an error?')) BAD_CODE();
} catch (err) {
  alert( 'catch' );
} finally {
  alert( 'finally' );
}
```


#### Promise与异步
- 同样于ES6引入,属于一个比较高级的语法

**标准语法如下:**
```js
let promise = new Promise(function(resolve, reject) {
  // executor（生产者代码，“歌手”）
});
```
##### 生产者详解
executor(**生产者**)内部执行代码后,如果成功,则调用resolve函数执行;如果失败,则调用reject函数执行.

实例化的Promise对象promise有以下两个属性:
1. state: 初始值是"pending",在resolve被调用时变成"fulfilled";在reject被调用时变成"rejected".
2. result: 初始值是undefined,在resolve被调用时得到executor的返回值,在reject被调用时得到executor产生的error.

![示意图](PixPin_2026-05-11_13-46-45.webp)

##### 消费者详解
promise实例具有三个**消费者**方法:
1. then
2. catch
3. finally

then方法内可以有两个函数,分别在生产者执行成功时调用它的**返回值**和失败时调用抛出的**错误**:
```js
promise.then(
  function(result) { /* handle a successful result */ },
  function(error) { /* handle an error */ }
);
```

但是有时候我们希望将异常处理和代码执行区分开来,就可以将`function(error)`部分提出来放在catch方法里:
```js
downloadFile("https://example.com/logo.png")
  .then((response) => {
    console.log("✅ 成功：", response.msg);
  })
  .catch((err) => {
    console.error("❌ 失败：", err.message);
  })
```

有时候我们希望执行一点收尾工作,就可以使用`finally`方法:
```js
downloadFile("https://example.com/logo.png")
  .then((response) => {
    console.log("✅ 成功：", response.msg);
  })
  .catch((err) => {
    console.error("❌ 失败：", err.message);
  })
  .finally(() => {
    console.log("🏁 进度条结束（无论成功失败均隐藏）");
  });
```

一个完整的实战代码如下:
```js
// 1. 生产者：封装下载逻辑
function downloadFile(url) {
  return new Promise((resolve, reject) => {
    console.log("正在从 " + url + " 下载文件...");

    // 模拟真实的资源加载（例如图片加载）
    const image = new Image();
    
    // 成功时的回调函数
    image.onload = () => {
      resolve({ status: 200, msg: "文件已成功载入" });
    };

    // 失败时的回调函数
    image.onerror = () => {
      reject(new Error("文件地址无效或网络异常"));
    };

    // 触发下载
    image.src = url;
  });
}

// 2. 消费者：根据下载结果更新界面
downloadFile("https://example.com/logo.png")
  .then((response) => {
    console.log("✅ 成功：", response.msg);
  })
  .catch((err) => {
    console.error("❌ 失败：", err.message);
  })
  .finally(() => {
    console.log("🏁 进度条结束（无论成功失败均隐藏）");
  });
```
##### Promise链
鉴于前端有时候需要对某个异步操作进行反复处理,所以js引入了promise链语法: 将一个then方法写在一个then方法之后时,前一个then方法的返回值会自动包装成Promise实例,供下一个then方法使用,置于具体原理就没必要去了解了,可以看成是一个高阶语法糖.

```js
new Promise(function(resolve, reject) {

  setTimeout(() => resolve(1), 1000); // (*)

}).then(function(result) { // (**)

  alert(result); // 1
  return result * 2;

}).then(function(result) { // (***)

  alert(result); // 2
  return result * 2;

}).then(function(result) {

  alert(result); // 4
  return result * 2;

});
```
- 本质上来说,这减少了函数的层层缩进,不同阶段的处理都使用同样的缩进,更符合阅读习惯.


**实战代码**
```js
function loadJson(url) {
  return fetch(url)
    .then(response => response.json());
}

function loadGithubUser(name) {
  return loadJson(`https://api.github.com/users/${name}`);
}

function showAvatar(githubUser) {
  return new Promise(function(resolve, reject) {
    let img = document.createElement('img');
    img.src = githubUser.avatar_url;
    img.className = "promise-avatar-example";
    document.body.append(img);

    setTimeout(() => {
      img.remove();
      resolve(githubUser);
    }, 3000);
  });
}

// 使用它们：
loadJson('/article/promise-chaining/user.json')
  .then(user => loadGithubUser(user.name))
  .then(showAvatar)
  .then(githubUser => alert(`Finished showing ${githubUser.name}`));
  // ...
```

##### Promise.all
promise除了then,catch方法,还有all方法可以使用,它的本质是: **并行执行多个promise,等待所有promise执行完后再进行处理**,示例代码如下:
```js
Promise.all([
  new Promise(resolve => setTimeout(() => resolve(1), 3000)), // 1
  new Promise(resolve => setTimeout(() => resolve(2), 2000)), // 2
  new Promise(resolve => setTimeout(() => resolve(3), 1000))  // 3
]).then(alert); // 1,2,3 当上面这些 promise 准备好时：每个 promise 都贡献了数组中的一个元素
```
- 这个示例代码并不那么容易好懂,可以看到then方法中的那个alert函数并没有任何参数,却依旧可以打印出三个promise函数的返回值,原因如下: **当你直接把一个函数名传递给then方法时,引擎会自动将上一步的结果作为参数传递给该函数**.
  - 显然,js最令后端开发者难受的地方就是这些莫名其妙的简写了.

##### async/await
鉴于promise过于复杂和难懂,所以js使用关键字`async`和`await`来实现接近相同的功能,事实上在可能的情况下,我们都使用这两个关键字,而非promise调用.

- 以fastapi模板项目为例:
- >![示意图](PixPin_2026-05-11_14-45-32.webp)
- ![示意图](PixPin_2026-05-11_14-46-55.webp)

详细用法:
```js
async function f() {
  return 1;
}

f().then(alert); // 1
```
上述代码与下面的代码作用相同:
```js
function f() {
  return Promise.resolve(1);
}

f().then(alert);
```

换句话说,async会自动将函数的返回值包装成Promise实例.

而await则是对promise.then的包装:
```js
async function f() {

  let promise = new Promise((resolve, reject) => {
    setTimeout(() => resolve("done!"), 1000)
  });

  let result = await promise; // 等待，直到 promise resolve (*)

  alert(result); // "done!"
}

f();
```


上面的说明还不是很清晰,让我们看看**实战代码**:
```js
function getOrderData() {
  return fetch('/api/user')
    .then(response => response.json())
    .then(user => fetch(`/api/orders?userId=${user.id}`))
    .then(response => response.json())
    .then(orders => fetch(`/api/order/${orders[0].id}`))
    .then(response => response.json())
    .catch(error => console.error("请求失败:", error));
}

getOrderData().then(detail => console.log(detail));
```
上面这个丑陋的函数可以改写成这样:
```js
async function getOrderData() {
  try {
    const userRes = await fetch('/api/user');
    const user = await userRes.json();

    const ordersRes = await fetch(`/api/orders?userId=${user.id}`);
    const orders = await ordersRes.json();

    const detailRes = await fetch(`/api/order/${orders[0].id}`);
    const detail = await detailRes.json();

    return detail;
  } catch (error) {
    console.error("请求失败:", error);
  }
}

getOrderData().then(detail => console.log(detail));
```

- 这样看起来就舒服多了.

##### 总结
如果对js中的异步还不是很清晰的话,可以看一下这个示例代码:
```js
async function test() {
  console.log("A"); 
  await fetch('/api/user'); // 暂停在这里，释放主线程
  console.log("B"); // 等数据回来后再执行
}

console.log("C");
test();
console.log("D");

// 实际输出顺序：
// C
// A (进入函数执行到 await 之前)
// D (遇到 await，函数挂起，主线程继续执行函数外部的代码)
// ... 过了很久 ...
// B (请求完成，微任务触发)
```
异步就是,**挂起需要等待数据传来的函数,优先执行其他的函数.**

#### 模块
>一个模块（module）就是一个文件。一个脚本就是一个模块。就这么简单。

模块可以相互加载，并可以使用特殊的指令 export 和 import 来交换功能，从另一个模块调用一个模块的函数：
- export 关键字标记了可以从当前模块外部访问的变量和函数。
- import 关键字允许从其他模块导入功能。

**一个简单的例子**
```js
// 📁 sayHi.js
export function sayHi(user) {
  alert(`Hello, ${user}!`);
}

// 📁 main.js
import { sayHi } from './sayHi.js';

alert(sayHi); // function...
sayHi('John'); // Hello, John!
```
##### 导出与导入
我们可以通过在声明之前放置 export 来标记任意声明为导出，无论声明的是变量，函数还是类都可以。
```js
// 导出数组
export let months = ['Jan', 'Feb', 'Mar','Apr', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

// 导出 const 声明的变量
export const MODULES_BECAME_STANDARD_YEAR = 2015;

// 导出类
export class User {
  constructor(name) {
    this.name = name;
  }
}
```

通常，我们把要导入的东西列在花括号 import {...} 中，就像这样：
```js
// 📁 main.js
import {sayHi, sayBye} from './say.js';

sayHi('John'); // Hello, John!
sayBye('John'); // Bye, John!

// 或者一并导入
// 📁 main.js
import * as say from './say.js';

say.sayHi('John');
say.sayBye('John');
```

鉴于js使用{}来区分导入变量,所以就不像python一样将别名写在最后面,而是直接跟在变量名后面:
```js
// 📁 main.js
import {sayHi as hi, sayBye as bye} from './say.js';

hi('John'); // Hello, John!
bye('John'); // Bye, John!
```
##### 默认导出
每个文件都可以指定一个默认导出的元素(变量/函数/类),在其他文件中导入时不需要用花括号包裹:
```js
// 📁 user.js
export default class User { // 只需要添加 "default" 即可
  constructor(name) {
    this.name = name;
  }
}

// 📁 main.js
import User from './user.js'; // 不需要花括号 {User}，只需要写成 User 即可

new User('John');
```

- 看上去作用不大,但它将在jsx和tsx中发挥强大的能量.

#### fetch函数
- 鉴于该函数的应用广泛性,所以有必要专门了解它

**基本语法**
```js
let promise = fetch(url, [options])
```
- url —— 要访问的 URL。
- options —— 可选参数：method，header 等.若不写参数则默认使用GET请求

可以看到fetch函数返回的就是一个promise对象,原生就支持异步调用.

该函数的执行有两个阶段:
1. 解析响应头(response header)
2. 解析响应体(response body)

返回的promise对象有以下常用的方法或者属性:
- **status** —— HTTP 状态码，例如 200。
- **ok** —— 布尔值，如果 HTTP 状态码为 200-299，则为 true。
- **text()** —— 读取 response，并以文本形式返回 response。
- **json()** —— 将 response 解析为 JSON 格式。
- **blob()** —— 以 Blob（具有类型的二进制数据）形式返回 response，

如果我们通过await来调用的话,可以这么写:
```js
let response = await fetch(url);

if (response.ok) { // 如果 HTTP 状态码为 200-299
  // 获取 response body（此方法会在下面解释）
  let json = await response.json();
} else {
  alert("HTTP-Error: " + response.status);
}
```
- fetch首先会返回状态码,但这个时候响应体可能还在传输中,所以需要再使用一次await来获取.

一个更典型的写法是这样的:
```js
let response = await fetch(url, options); // 解析 response header
let result = await response.json(); // 将 body 读取为 json
```
response可能尚未完全加载完毕,所以需要再用一次await确保获取完整内容.

##### 加入请求头
```js
let response = fetch(protectedUrl, {
  headers: {
    Authentication: 'secret'
  }
});
```
- 可以看到除了url之外的参数都用`{}`包裹起来了.

##### 使用其他方法进行请求
```js
let user = {
  name: 'John',
  surname: 'Smith'
};

let response = await fetch('/article/fetch/post/user', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json;charset=utf-8'
  },
  body: JSON.stringify(user)
});

let result = await response.json();
alert(result.message);
```
##### 一个完整的fetch请求
```js
let promise = fetch(url, {
  method: "GET", // POST，PUT，DELETE，等。
  headers: {
    // 内容类型 header 值通常是自动设置的
    // 取决于 request body
    "Content-Type": "text/plain;charset=UTF-8"
  },
  body: undefined // string，FormData，Blob，BufferSource，或 URLSearchParams
  referrer: "about:client", // 或 "" 以不发送 Referer header，
  // 或者是当前源的 url
  referrerPolicy: "no-referrer-when-downgrade", // no-referrer，origin，same-origin...
  mode: "cors", // same-origin，no-cors
  credentials: "same-origin", // omit，include
  cache: "default", // no-store，reload，no-cache，force-cache，或 only-if-cached
  redirect: "follow", // manual，error
  integrity: "", // 一个 hash，像 "sha256-abcdef1234567890"
  keepalive: false, // true
  signal: undefined, // AbortController 来中止请求
  window: window // null
});
```

### 总结
尽管ES6之后的js终于变得像是一门正式语言了,但是如果我们每次写网页都需要写一个个html文档,再通过script标签嵌入js代码的话,是很难做到模块化开发的,大量的代码杂糅在一起,十分难看又很难维护.

因此,又一门出色的语言:JSX诞生了,它将模块式开发引入了js,解决了上述的开发难题.

## JavaScript XML

### 概览
- [jsx的简单历史介绍](https://www.greatfrontend.com/zh-CN/react-interview-playbook/react-landscape-history)
- [官方文档](https://react.dev/learn)
  - 写的不是很好,但对于js基础扎实的人也够用了
- [w3schools](https://www.w3schools.com/react)

JSX于2013年正式发布,由Facebook的工程师们发明,在诞生初期遭受了不少质疑,但在几年后迅速席卷了整个前端开发界.

- 尽管JSX起初是只用在React框架中的,但由于Babel等转译器的支持,大多数框架都可以使用JSX来编写了.
- 为了更好地学习JSX,最好直接看React的官方文档

如果熟练掌握了ES6语法和html语法的话,看JSX会觉得相当轻松:
```jsx
function MyButton() {
  return (
    <button>
      I'm a button
    </button>
  );
}

export default function MyApp() {
  return (
    <div>
      <h1>Welcome to my app</h1>
      <MyButton />
    </div>
  );
}
```

**效果图**:
![示意图](PixPin_2026-05-12_12-53-57.webp)

可以看到,JSX将html标签作为js函数的返回值,并通过类似`<MyButton />`的语法来将函数编程组件.


### 基础语法
#### 前置概念
1. 如果我们只需要在函数中返回一个标签的话,直接写就行了,但如果要返回多个标签,那么就需要用空标签来包裹这些元素:
```jsx
return (
    <>
      <div className="board-row">
        <Square value={squares[0]} onSquareClick={() => handleClick(0)} />
        <Square value={squares[1]} onSquareClick={() => handleClick(1)} />
        <Square value={squares[2]} onSquareClick={() => handleClick(2)} />
      </div>
      <div className="board-row">
        <Square value={squares[3]} onSquareClick={() => handleClick(3)} />
        <Square value={squares[4]} onSquareClick={() => handleClick(4)} />
        <Square value={squares[5]} onSquareClick={() => handleClick(5)} />
      </div>
      <div className="board-row">
        <Square value={squares[6]} onSquareClick={() => handleClick(6)} />
        <Square value={squares[7]} onSquareClick={() => handleClick(7)} />
        <Square value={squares[8]} onSquareClick={() => handleClick(8)} />
    </>
  );
```

2. 鉴于class在ES6中是关键字,所以jsx将html标签中的class修改成了`className`:
```jsx
export default function Square() {
  return <button className="square">X</button>;
}
```
3. JSX中的所有标签都需要闭合,所以像html中`<img>`这样的自闭合标签要写成`<img />`
```jsx
<>
  <img
    src="https://react.dev/images/docs/scientists/yXOvdOSs.jpg"
    alt="Hedy Lamarr"
    class="photo"
   />
  <ul>
      <li>发明一种新式交通信号灯</li>
      <li>排练一个电影场景</li>
      <li>改进频谱技术</li>
  </ul>
</>
```
4. JSX使用驼峰命名法,即除了第一个单词的其他单词首字母都要大写.
5. 如果要在标签中直接嵌入js值,就需要使用`{}`:
```jsx
export default function Avatar() {
  const avatar = 'https://react.dev/images/docs/scientists/7vQD0fPs.jpg';
  const description = 'Gregorio Y. Zara';
  return (
    <img
      className="avatar"
      src={avatar}
      alt={description}
    />
  );
}
```
6. 有时候我们需要使用双大括号用于传递对象,比如这种情况:
```html
<button class="btn btn-primary btn-large" style="color: white; background-color: blue; padding: 10px 20px;">
  Click Me
</button>
```
原生html中使用引号来包裹值,并且style内部的属性使用`;`划分,而这会在JSX中被单纯的认为是一个字符串,所以需要改成用js对象传递值,类似这样:
```jsx
export default function TodoList() {
  return (
    <ul style={{
      backgroundColor: 'black',
      color: 'pink'
    }}>
      <li>Improve the videophone</li>
      <li>Prepare aeronautics lectures</li>
      <li>Work on the alcohol-fuelled engine</li>
    </ul>
  );
}
```
#### props: 在组件间传递js值
JSX既然可以在原生html标签中传递js值,自然也可以在自定义的标签(这被称为**组件**)中传递js值:
```jsx
import { getImageUrl } from './utils.js';

function Avatar({ person, size }) {
  return (
    <img
      className="avatar"
      src={getImageUrl(person)}
      alt={person.name}
      width={size}
      height={size}
    />
  );
}

export default function Profile() {
  return (
    <div>
      <Avatar
        size={100}
        person={{
          name: 'Katsuko Saruhashi',
          imageId: 'YfeOqp2'
        }}
      />
      <Avatar
        size={80}
        person={{
          name: 'Aklilu Lemma',
          imageId: 'OKS67lh'
        }}
      />
      <Avatar
        size={50}
        person={{
          name: 'Lin Lanying',
          imageId: '1bX5QH6'
        }}
      />
    </div>
  );
}
```
很显然,写在组件中的js参数是作为一个js对象传入Avatar函数的,并通过解构语法被分别赋值.

我们甚至可以在组件间传递组件:
```jsx
import Avatar from './Avatar.js';

function Card({ children }) {
  return (
    <div className="card">
      {children}
    </div>
  );
}

export default function Profile() {
  return (
    <Card>
      <Avatar
        size={100}
        person={{
          name: 'Katsuko Saruhashi',
          imageId: 'YfeOqp2'
        }}
      />
    </Card>
  );
}
```
#### main.jsx与index.html
当我们使用各种模板创建jsx项目时,目录下通常都有这两个文件,先看看index.html:
```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Full Stack FastAPI Project</title>
    <link rel="icon" type="image/x-icon" href="/assets/images/favicon.png" />
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="./src/main.jsx"></script>
  </body>
</html>
```
去掉无关信息后是这样的:
```html
<!DOCTYPE html>
<html lang="en">
  <body>
    <div id="root"></div>
    <script type="module" src="./src/main.jsx"></script>
  </body>
</html>
```

它仅仅嵌入了main.jsx,其他并没有什么特殊的地方,那来看看main.jsx:
```jsx
import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './App.jsx'

createRoot(document.getElementById('root')).render(
  <StrictMode>
      <App />
    </StrictMode>
  )  
```
- 可以看到,main.jsx通过html中的`root`标签来渲染页面,这就是jsx的工作原理.

>就算将`<div>`换成`<header>`等无关紧要的标签,或者把`root`这个名字换成`candy`,都不影响jsx的渲染
### Hook
以use开头的函数称为**Hook**,用来保留用户状态.
#### useState
useState是最常用的Hook,所以需要重点了解.

>**State** generally refers to data or properties that need to be tracking in an application.

useState accepts an initial state and returns two values:
1. The current state.
2. A function that updates the state.

```jsx
import { useState } from "react";

function FavoriteColor() {
  const [color, setColor] = useState("red");
}
```
>useState返回的是一个二元数组,通过数组解构来获取对应值即可(数组解构可以任意命名,但习惯上我们将这对值命名为`var`和`setVar`的形式).

要更新初始值,我们调用更新函数即可:
```jsx
import { useState } from 'react';
import { createRoot } from 'react-dom/client';

function FavoriteColor() {
  const [color, setColor] = useState("red");

  return (
    <>
      <h1>My favorite color is {color}!</h1>
      <button
        type="button"
        onClick={() => setColor("blue")}
      >Blue</button>
    </>
  )
}

createRoot(document.getElementById('root')).render(
  <FavoriteColor />
);
```
setColor本质上是一个回调函数,会在触发时去更新被绑定的state.

而useState实际上支持两种传参方式,一种是我们上面的直接传参,另一种则是传递一个回调函数,例如:
```jsx
setCount((c) => c + 1)
```
至于为什么这么设计,我也看不出有什么特别有必要的地方...

state也可以是对象:
```jsx
import { useState } from 'react';
import { createRoot } from 'react-dom/client';

function MyCar() {
  const [car, setCar] = useState({
    brand: "Ford",
    model: "Mustang",
    year: "1964",
    color: "red"
  });

  return (
    <>
      <h1>My {car.brand}</h1>
      <p>
        It is a {car.color} {car.model} from {car.year}.
      </p>
    </>
  )
}

createRoot(document.getElementById('root')).render(
  <MyCar />
);
```


#### useEffect
useEffect是第二常用的React Hook,用来执行一些**side effects**,包括:
1. fetching data
2. updating the DOM
3. 计时

>[!NOTE]
鉴于官方把useEffect的效果称为`side effects`,但它实质上并不是那种常规的**有危害的副作用**的意思,所以就保持原文算了.

useEffect有两个参数,第二个参数是可选的:
```jsx
useEffect(<function>, <dependency>)
```

**用例**
```jsx
import { useState, useEffect } from 'react';
import { createRoot } from 'react-dom/client';

function Timer() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    setTimeout(() => {
      setCount((count) => count + 1);
    }, 1000);
  });

  return <h1>I've rendered {count} times!</h1>;
}

createRoot(document.getElementById('root')).render(
  <Timer />
);
```
上述代码每过一秒便会将count+1并渲染出来,永不停息,这是因为我们没给setTimeout函数加上任何限制,一般来说我们有三种写法:
```jsx
useEffect(() => {
  //Runs on every render
});

// 有时候我们希望只用useEffect进行初始化
useEffect(() => {
  //Runs only on the first render
}, []);

// 当界面状态改变时我们希望再次进行渲染.
useEffect(() => {
  //Runs on the first render
  //And any time any dependency value changes
}, [prop, state]);
```

下面这个代码就是一个很好的例子:
```jsx
import { useState, useEffect } from 'react';
import { createRoot } from 'react-dom/client';

function Counter() {
  const [count, setCount] = useState(0);
  const [calculation, setCalculation] = useState(0);

  useEffect(() => {
    setCalculation(() => count * 2);
  }, [count]); // <- add the count variable here

  return (
    <>
      <p>Count: {count}</p>
      <button onClick={() => setCount((c) => c + 1)}>+</button>
      <p>Calculation: {calculation}</p>
    </>
  );
}

createRoot(document.getElementById('root')).render(
  <Counter />
);
```

#### useContext
useState只能写在函数中,这意味着它不能通过全局变量来在组件中共享,想要跨越文件传递值则更加困难:
```jsx
import { useState } from 'react';
import { createRoot } from 'react-dom/client';

function Component1() {
  const [user, setUser] = useState("Linus");

  return (
    <>
      <h1>{`Hello ${user}!`}</h1>
      <Component2 user={user} />
    </>
  );
}

function Component2({ user }) {
  return (
    <>
      <h1>Component 2</h1>
      <Component3 user={user} />
    </>
  );
}

function Component3({ user }) {
  return (
    <>
      <h1>Component 3</h1>
      <h2>{`Hello ${user} again!`}</h2>
    </>
  );
}

createRoot(document.getElementById('root')).render(
  <Component1 />
);
```
>Even though component 2 did not need the state, it had to pass the state along so that it could reach component 3.

要使用useContext,我们需要导入createContext:
```jsx
import { useState, createContext, useContext } from 'react';
import { createRoot } from 'react-dom/client';

const UserContext = createContext();
```

然后就可以通过Provider组件来跨越组件传值:
```jsx
function Component1() {
  const [user, setUser] = useState("Linus");

  return (
    <UserContext.Provider value={user}>
      <h1>{`Hello ${user}!`}</h1>
      <Component2 />
    </UserContext.Provider>
  );
}
```
要想在子组件中直接传递变量,就需要用到useContext了:
```jsx
function Component3() {
  const user = useContext(UserContext);

  return (
    <>
      <h1>Component 3</h1>
      <h2>{`Hello ${user} again!`}</h2>
    </>
  );
}
```

**完整代码如下**:
```jsx
import { useState, createContext, useContext } from 'react';
import { createRoot } from 'react-dom/client';

const UserContext = createContext();

function Component1() {
  const [user, setUser] = useState("Linus");

  return (
    <UserContext.Provider value={user}>
      <h1>{`Hello ${user}!`}</h1>
      <Component2 />
    </UserContext.Provider>
  );
}

function Component2() {
  return (
    <>
      <h1>Component 2</h1>
      <Component3 />
    </>
  );
}

function Component3() {
  const user = useContext(UserContext);

  return (
    <>
      <h1>Component 3</h1>
      <h2>{`Hello ${user} again!`}</h2>
    </>
  );
}

createRoot(document.getElementById('root')).render(
  <Component1 />
);
```

>是不是很匪夷所思,组件3中的user是如何获取组件1中的变量的? 我们需要注意的是,应该以一种自顶向下的方法来使用useContext.组件1中使用了Provider组件来广播这个值到组件2中,尽管组件2本身没有使用user变量,但它调用了组件3,React会顺势将user变量通过`useContext(UserContext)`传递进组件3中.
#### useRef
如果我们想统计useState的渲染次数的话,我们可不能再引入useState或者useEffect,因为它们执行时都会重新渲染一次页面,所以,我们需要用到useRef:
```jsx
import { useState, useRef, useEffect } from 'react';
import { createRoot } from 'react-dom/client';

function App() {
  const [inputValue, setInputValue] = useState("");
  const count = useRef(0);

  useEffect(() => {
    count.current = count.current + 1;
  });

  return (
    <>
      <p>Type in the input field:</p>
      <input
        type="text"
        value={inputValue}
        onChange={(e) => setInputValue(e.target.value)}
      />
      <h1>Render Count: {count.current}</h1>
    </>
  );
}

createRoot(document.getElementById('root')).render(
  <App />
);
```
useRef只返回一个对象变量,它只有一个current属性.

在 React 中，你不能直接用 `document.getElementById`。你需要用 useRef 挂载到标签上:
```jsx
const inputRef = useRef(null);

const handleClick = () => {
  // 直接操作底层 DOM 元素
  inputRef.current.focus(); 
};

return <input ref={inputRef} />;
```
#### useCallback
这是最后一个比较常用的Hook了,主要用来缓存回调函数,接受两个参数:
```jsx
useCallback(callback, dependencies)
```
1. callback: The function that you want to memoize.
2. dependencies: An array of dependencies for the callback function. The memorized callback will only change if one of these dependencies has changed.

```jsx
//Without useCallback:
import React, { useState } from 'react';
import { createRoot } from 'react-dom/client';

// Child component that receives a function prop
const Button = React.memo(({ onClick, text }) => {
  alert(`Child ${text} button rendered`);
  return <button onClick={onClick}>{text}</button>;
});

// Parent component without useCallback
function WithoutCallbackExample() {
  const [count1, setCount1] = useState(0);
  const [count2, setCount2] = useState(0);

  // This function is recreated on every render
  const handleClick1 = () => {
    setCount1(count1 + 1);
  };

  const handleClick2 = () => {
    setCount2(count2 + 1);
  };

  alert("Parent rendered");
  return (
    <div>
      <h2>Without useCallback:</h2>
      <p>Count 1: {count1}</p>
      <p>Count 2: {count2}</p>
      <Button onClick={handleClick1} text="Button 1" />
      <Button onClick={handleClick2} text="Button 2" />
    </div>
  );
}

createRoot(document.getElementById('root')).render(
  <WithoutCallbackExample />
);  
```
上述代码没有使用useCallback函数,每次按按钮时都会重新渲染所有组件,如果改成使用useCallback,是这样的:
```jsx
//With useCallback:
import React, { useState, useCallback } from 'react';
import { createRoot } from 'react-dom/client';

// Child component that receives a function prop
const Button = React.memo(({ onClick, text }) => {
  console.log(`${text} button rendered`);
  return <button onClick={onClick}>{text}</button>;
});

// Parent component with useCallback
function WithCallbackExample() {
  const [count1, setCount1] = useState(0);
  const [count2, setCount2] = useState(0);

  // These functions are memoized and only recreated when dependencies change
  const handleClick1 = useCallback(() => {
    setCount1(count1 + 1);
  }, [count1]);

  const handleClick2 = useCallback(() => {
    setCount2(count2 + 1);
  }, [count2]);

  console.log("Parent rendered");
  return (
    <div>
      <h2>With useCallback:</h2>
      <p>Count 1: {count1}</p>
      <p>Count 2: {count2}</p>
      <Button onClick={handleClick1} text="Button 1" />
      <Button onClick={handleClick2} text="Button 2" />
    </div>
  );
}

createRoot(document.getElementById('root')).render(
  <WithCallbackExample />
);  
```

上述的例子还是太难看懂了,也不够直观,我们拿一个时常要用到的黑夜/白天主题切换情景作为例子,顺便复习一下前面的知识:
```jsx
import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useState,
} from "react"

export type Theme = "dark" | "light" | "system"

const ThemeProviderContext = createContext<ThemeProviderState>(initialState)

export function ThemeProvider({
  children,
  defaultTheme = "system",
  storageKey = "vite-ui-theme",
  ...props
}: ThemeProviderProps) {
  const [theme, setTheme] = useState<Theme>(
    () => (localStorage.getItem(storageKey) as Theme) || defaultTheme,
  )

  const getResolvedTheme = useCallback((theme: Theme): "dark" | "light" => {
    if (theme === "system") {
      return window.matchMedia("(prefers-color-scheme: dark)").matches
        ? "dark"
        : "light"
    }
    return theme
  }, [])

  const [resolvedTheme, setResolvedTheme] = useState<"dark" | "light">(() =>
    getResolvedTheme(theme),
  )

  const updateTheme = useCallback((newTheme: Theme) => {
    const root = window.document.documentElement

    root.classList.remove("light", "dark")

    if (newTheme === "system") {
      const systemTheme = window.matchMedia("(prefers-color-scheme: dark)")
        .matches
        ? "dark"
        : "light"

      root.classList.add(systemTheme)
      return
    }

    root.classList.add(newTheme)
  }, [])

  useEffect(() => {
    updateTheme(theme)
    setResolvedTheme(getResolvedTheme(theme))

    const mediaQuery = window.matchMedia("(prefers-color-scheme: dark)")

    const handleChange = () => {
      if (theme === "system") {
        updateTheme("system")
        setResolvedTheme(getResolvedTheme("system"))
      }
    }

    mediaQuery.addEventListener("change", handleChange)

    return () => {
      mediaQuery.removeEventListener("change", handleChange)
    }
  }, [theme, updateTheme, getResolvedTheme])

  const value = {
    theme,
    resolvedTheme,
    setTheme: (theme: Theme) => {
      localStorage.setItem(storageKey, theme)
      setTheme(theme)
    },
  }

  return (
    <ThemeProviderContext.Provider {...props} value={value}>
      {children}
    </ThemeProviderContext.Provider>
  )
}
export const useTheme = () => {
  const context = useContext(ThemeProviderContext)

  if (context === undefined)
    throw new Error("useTheme must be used within a ThemeProvider")

  return context
}
```

我们看一看使用了useCallback部分的代码:
```jsx
const getResolvedTheme = useCallback((theme: Theme): "dark" | "light" => {
    if (theme === "system") {
      return window.matchMedia("(prefers-color-scheme: dark)").matches
        ? "dark"
        : "light"
    }
    return theme
  }, [])

const updateTheme = useCallback((newTheme: Theme) => {
    const root = window.document.documentElement

    root.classList.remove("light", "dark")

    if (newTheme === "system") {
      const systemTheme = window.matchMedia("(prefers-color-scheme: dark)")
        .matches
        ? "dark"
        : "light"

      root.classList.add(systemTheme)
      return
    }

    root.classList.add(newTheme)
  }, [])
```
如果不用useCallback包裹这两个函数,那么之后每次渲染时这些函数都会重新执行一遍,对于整个页面的渲染是个很大的开销.

- 这里的依赖项为空数组的作用与在useEffect中的作用一样,都是只在初始化执行一次,后续不再改变.


### 总结
事实上,JSX需要了解的就是Hook和组件写法了,其他的基本都属于原生JS的语法范畴.

但是,用JS写项目还是不太顺手,大型JS项目的维护也无比艰难,因为JS没有**静态类型检查**,这让代码编写变得十分痛苦.

所以,Typescript诞生了,带来了前端领域的又一场变革.
## Typescript
### 概览
- [官方文档](https://www.typescriptlang.org/docs/handbook/intro.html)
  - 内容很杂很乱,只看需要的部分即可

Typescript由微软在2014年发布,主要目的就是为了解决Javascript中的动态类型带来的各种疑难问题,所以引入的新特性不是很多.但也足够使用了.
### ts编译
鉴于typescript不是原生的js语法,无法被浏览器直接处理,需要导入typescript编译器后运行:
```bash
npm install -g typescript
```

比如我们现在写了一个ts文件,命名为`test.ts`,要编译它就可以在终端输入:
```bash
tsc test.ts
```
ts编译器会将`test.ts`编译成`test.js`文件,去掉其中的ts语法.

如果我们的ts文件中出错了,那么编译过程就会报错,比如下列代码:
```ts
// This is an industrial-grade general-purpose greeter function:
function greet(person, date) {
  console.log(`Hello ${person}, today is ${date}!`);
}
 
greet("Brendan");
```

尽管ts代码仍然会变成js代码,但是命令行会抛出错误,告诉你哪些类型检查没通过
### 类型注释
ts的类型注释只有一种写法`var/func(): type`:
```ts
// Parameter type annotation
function greet(name: string): any {
  console.log("Hello, " + name.toUpperCase() + "!!");
}
```

ts中的类型注释有以下几种:
1. 基本类型: `string`,`number`,`boolean`
2. 任意类型: any
   1. 与python的Any类型一样,类型检查时会直接跳过它
3. 未知类型: unknown
   1. 由于any不够安全,所以TS3.0引入了该类型,它是所有类型的顶级类型.
4. 可选类型: `?: type`,一个例子如下:

```ts
function printName(obj: { first: string; last?: string }) {
  // ...
}
// Both OK
printName({ first: "Bob" });
printName({ first: "Alice", last: "Alisson" });
```

4. null类型: 鉴于undefined只用在变量未定义时,因此类型注释只有null即可,毕竟你传入的变量一定是已经定义好了的

>当然,在ts中更多的是由用户自定义的类或者type进行类型注释.

5. 至于像对象这种格式为`key: value`的类型,想要对键也进行类型注释的话可不能再直接写一个`:`号,那样没人看得懂的,ts的写法是这样的:

```ts
type OnlyBoolsAndHorses = {
  [key: string]: boolean | Horse;
};
 
const conforms: OnlyBoolsAndHorses = {
  del: true,
  rodney: false,
};
```

上述写法表示: 该类型中的所有新定义的键值对都要满足key是string类型,值是boolean或者Horse类型.

#### type关键字
ts使用type关键字声明自定义的类型:
```ts
type Point = {
  x: number;
  y: number;
};
 
// Exactly the same as the earlier example
function printCoord(pt: Point) {
  console.log("The coordinate's x value is " + pt.x);
  console.log("The coordinate's y value is " + pt.y);
}
 
printCoord({ x: 100, y: 100 });
```

#### readonly修饰符
该类修饰符禁止在使用时直接修改被修饰的变量:
```ts
interface Config {
  readonly meta: { version: string };
}
const cfg: Config = { meta: { version: "1.0" } };
// cfg.meta = { version: "2.0" }; // 报错：无法分配到 "meta" ，因为它是只读属性。
cfg.meta.version = "2.0";        // 允许：内部属性未受保护。
```

### 加强的OOP
鉴于原生js的OOP实在是不堪入目,所以TS大大加强了OOP特性,让它成为了一个更加面向对象的语言(尽管本质上还是面向函数的).
#### 接口
ts中的接口与Java中的接口别无二致,声明也是一样的:
```ts
interface Point {
  x: number;
  y: number;
}
 
function printCoord(pt: Point) {
  console.log("The coordinate's x value is " + pt.x);
  console.log("The coordinate's y value is " + pt.y);
}
 
printCoord({ x: 100, y: 100 });
```

继承写法也是一样:
```ts
interface Colorful {
  color: string;
}
 
interface Circle {
  radius: number;
}
 
interface ColorfulCircle extends Colorful, Circle {}
 
const cc: ColorfulCircle = {
  color: "red",
  radius: 42,
};
```
#### 泛型
- ts项目中会大量用到泛型,所以需要重点理解.
##### 用在类和接口中
有时候某些变量我们希望他能够接受多种类型的值,一个直觉上的写法是这样的:
```ts
interface Box {
  contents: number|string|boolean;
}
```
但上面这种写法有一个问题,当我们希望这个接口作为number类型使用的时候,不应该由其他维护者传入其他的类型如string和boolean.

那么一个更加安全的写法是将这个接口拆分成三个:
```ts
interface NumberBox {
  contents: number;
}
 
interface StringBox {
  contents: string;
}
 
interface BooleanBox {
  contents: boolean;
}
```
这显然太麻烦了,而cpp的泛型思想刚好适用于这种情况,我们将cpp的泛型写法直接照搬过来就行了:
```ts
interface Box<Type> {
  contents: Type;
}

let boxA: Box<string> = { contents: "hello" };
```
那么当这个接口被使用时,由于类型注释的限制,其他维护者也无法传入其他类型的值了.
##### 用在函数中
```ts
function identity<Type>(arg: Type): Type {
  return arg;
}
```
函数中的用法实质上与用在类中没什么太大的区别.

#### 加强的类
只给一个类的示例就能看懂ts中多了什么了:
```ts
export class CancelError extends Error {
	constructor(message: string) {
		super(message);
		this.name = 'CancelError';
	}

	public get isCancelled(): boolean {
		return true;
	}
}
```
多出来的只有三种类型修饰符(`public`,`private`,`protected`),其他的改进很有限,也不是很有必要了解.

### 总结
我上面只给了最基础的ts语法,遗漏了很多语法,如果一看到真正的ts项目是完全应付不了的:
```ts
export class CancelError extends Error {
	constructor(message: string) {
		super(message);
		this.name = 'CancelError';
	}

	public get isCancelled(): boolean {
		return true;
	}
}

export interface OnCancel {
	readonly isResolved: boolean;
	readonly isRejected: boolean;
	readonly isCancelled: boolean;

	(cancelHandler: () => void): void;
}

export class CancelablePromise<T> implements Promise<T> {
	private _isResolved: boolean;
	private _isRejected: boolean;
	private _isCancelled: boolean;
	readonly cancelHandlers: (() => void)[];
	readonly promise: Promise<T>;
	private _resolve?: (value: T | PromiseLike<T>) => void;
	private _reject?: (reason?: unknown) => void;

	constructor(
		executor: (
			resolve: (value: T | PromiseLike<T>) => void,
			reject: (reason?: unknown) => void,
			onCancel: OnCancel
		) => void
	) {
		this._isResolved = false;
		this._isRejected = false;
		this._isCancelled = false;
		this.cancelHandlers = [];
		this.promise = new Promise<T>((resolve, reject) => {
			this._resolve = resolve;
			this._reject = reject;

			const onResolve = (value: T | PromiseLike<T>): void => {
				if (this._isResolved || this._isRejected || this._isCancelled) {
					return;
				}
				this._isResolved = true;
				if (this._resolve) this._resolve(value);
			};

			const onReject = (reason?: unknown): void => {
				if (this._isResolved || this._isRejected || this._isCancelled) {
					return;
				}
				this._isRejected = true;
				if (this._reject) this._reject(reason);
			};

			const onCancel = (cancelHandler: () => void): void => {
				if (this._isResolved || this._isRejected || this._isCancelled) {
					return;
				}
				this.cancelHandlers.push(cancelHandler);
			};

			Object.defineProperty(onCancel, 'isResolved', {
				get: (): boolean => this._isResolved,
			});

			Object.defineProperty(onCancel, 'isRejected', {
				get: (): boolean => this._isRejected,
			});

			Object.defineProperty(onCancel, 'isCancelled', {
				get: (): boolean => this._isCancelled,
			});

			return executor(onResolve, onReject, onCancel as OnCancel);
		});
	}

	get [Symbol.toStringTag]() {
		return "Cancellable Promise";
	}

	public then<TResult1 = T, TResult2 = never>(
		onFulfilled?: ((value: T) => TResult1 | PromiseLike<TResult1>) | null,
		onRejected?: ((reason: unknown) => TResult2 | PromiseLike<TResult2>) | null
	): Promise<TResult1 | TResult2> {
		return this.promise.then(onFulfilled, onRejected);
	}

	public catch<TResult = never>(
		onRejected?: ((reason: unknown) => TResult | PromiseLike<TResult>) | null
	): Promise<T | TResult> {
		return this.promise.catch(onRejected);
	}

	public finally(onFinally?: (() => void) | null): Promise<T> {
		return this.promise.finally(onFinally);
	}

	public cancel(): void {
		if (this._isResolved || this._isRejected || this._isCancelled) {
			return;
		}
		this._isCancelled = true;
		if (this.cancelHandlers.length) {
			try {
				for (const cancelHandler of this.cancelHandlers) {
					cancelHandler();
				}
			} catch (error) {
				console.warn('Cancellation threw an error', error);
				return;
			}
		}
		this.cancelHandlers.length = 0;
		if (this._reject) this._reject(new CancelError('Request aborted'));
	}

	public get isCancelled(): boolean {
		return this._isCancelled;
	}
}
```

我相信任何人看到这段代码后都不会认为写前端是很简单的活儿.

>好在ts生态中有各种各样的框架,有了这些框架后,我们可以尽可能少的写出这么离谱难懂的代码.

不管怎样,写前端项目还是以实战为主,所以就让我们先抛开难懂的ts语法,大踏步进入当代前端语言演进的最后终点: TSX.

## TypeScript XML
### 概览和总结
15年9月,ts1.6发布,引入了对tsx文件的解析支持,将jsx语法直接融入了ts中,从此,前端项目既实现了标准的类型检查,也能够真正的使用组件化的模式进行开发.

如今的前端项目中,一般只有两种涉及js的文件,一个是ts文件,只放置符合ts语法的代码,如类/接口/类型的声明及定义;另一个是tsx文件,用于设计组件和UI.

![示意图](PixPin_2026-05-16_19-30-41.webp)

不管怎样,现在写前端代码终于能够和写后端一样舒服了...

## 前端运行环境
- 令人震惊的是网上没有人能够好好的把这些必要的知识点好好总结一下,让无数前端新人看着一大堆配置文件一脸懵逼.
### 前置概念
如同cpp,java等语言需要经过编译后才能执行一样,前端项目也有自己的编译器: **浏览器引擎**,它有以下功能:
* **HTML 解析与 DOM 树构建**：将从网络接收到的 HTML 原始字节流转换为符合 W3C 标准的文档对象模型（DOM）树结构。
* **CSS 解析与 CSSOM 树构建**：解析所有样式表（包含行内、内联、外部 CSS 文件及浏览器默认样式），构建出定义层级样式的 CSSOM 树。
* **渲染树生成（Render Tree）**：将 DOM 树与 CSSOM 树进行物理合并，过滤掉不显示的节点（如 `display: none`），生成仅包含可见元素的渲染树。
* **布局/排版计算（Layout/Reflow）**：从渲染树根节点开始遍历，精确计算每个可见节点在屏幕上的几何大小、相对位置和所占用的物理像素。
* **元素绘制（Painting）**：遍历布局树和图层，将每个节点的文本、颜色、边框、背景、阴影等视觉样式转换为底层的具体绘图指令。
* **图层栅格化与合成（Rasterization & Compositing）**：将绘图指令转换为屏幕底层的位图（Pixels），并调用 GPU 将各个图层合成一帧，最终输出到显示器上。
* **JavaScript 引擎集成与通信**：为 JavaScript 引擎（如 V8）提供宿主环境，通过 DOM API 桥接底层 C++ 核心，实现脚本对网页结构的动态操作。
* **事件流调度（Event Dispatching）**：监听并捕获来自操作系统的底层物理输入（如鼠标点击、屏幕触摸、键盘输入、页面滚动），并按照冒泡/捕获机制分发给网页代码。

最典型的浏览器引擎就是开源的Blink引擎,chorome,egde,国产浏览器都使用它来渲染页面.

浏览器引擎只能处理html代码和css代码,而js单独由js引擎编译,最常见的js引擎就是**v8引擎**.

而Node则彻底将js引擎和浏览器引擎分离,从而让我们在不使用浏览器的情况下处理前端代码.
### Node
- [wiki](https://en.wikipedia.org/wiki/Node.js)

>目前Node仍然是前端项目的主流运行时.
#### Node的历史
##### 1. 诞生与初期（2009 - 2011）

* **起源**：2009年由 **Ryan Dahl** 基于 Google V8 引擎开发。其初衷是解决 Apache 等服务器在高并发（10,000+ 连接）下的瓶颈，推行事件驱动和非阻塞 I/O 范式。
* **生态起步**：2010年，**npm** 诞生，简化了包的发布与安装。
* **跨平台**：2011年，在微软与 Joyent 的合作下发布了原生 Windows 版本。

##### 2. 管理更迭与分裂（2012 - 2014）

* **领导权更替**：Ryan Dahl 之后，项目先后由 Isaac Schlueter（npm 创始人）和 Timothy J. Fontaine 领导。
* **社区分裂**：由于对 Joyent 治理模式及 V8 更新速度不满，Fedor Indutny 于 2014 年创建了分支 **io.js**，旨在建立更开放的社区治理结构。

##### 3. 合并与统一（2015 - 2019）

* **基金会成立**：2015年初成立 Node.js 基金会以调和双方矛盾。
* **回归统一**：2015年9月，Node.js v0.12 与 io.js v3.3 合并为 **Node v4.0**，引入了 ES6 特性并确立了长期支持（LTS）周期。
* **最终合并**：2019年，JS 基金会与 Node.js 基金会合并为 **OpenJS 基金会**。

**版本演进**
- 偶数版本（如 18, 20, 22）：每年的 4 月发布，10 月进入 LTS 阶段，生命周期通常为 3 年，适合生产环境。
- 奇数版本（如 19, 21, 23）：每年的 10 月发布，生命周期短（约 6 个月），主要用于测试新特性。

而现在已经迭代到26版本号了.
#### npm使用
- [官方文档](https://docs.npmjs.com/cli/v11/commands/npm)

Node项目中都有一个`package.json`文件,记录了导入的包和可使用的命令行命令等信息:
```json
{
  "name": "vite-project",
  "private": true,
  "version": "0.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc -b && vite build",
    "lint": "eslint .",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^19.2.6",
    "react-dom": "^19.2.6"
  },
  "devDependencies": {
    "@babel/core": "^7.29.0",
    "@eslint/js": "^10.0.1",
    "@rolldown/plugin-babel": "^0.2.3",
    "@types/babel__core": "^7.20.5",
    "@types/node": "^24.12.3",
    "@types/react": "^19.2.14",
    "@types/react-dom": "^19.2.3",
    "@vitejs/plugin-react": "^6.0.1",
    "babel-plugin-react-compiler": "^1.0.0",
    "eslint": "^10.3.0",
    "eslint-plugin-react-hooks": "^7.1.1",
    "eslint-plugin-react-refresh": "^0.5.2",
    "globals": "^17.6.0",
    "typescript": "~6.0.2",
    "typescript-eslint": "^8.59.2",
    "vite": "^8.0.12"
  }
}
```

- scripts: 表明了可以使用的脚本命令,比如dev对应的命令可以通过`npm run dev`来运行

接下来重点介绍一些常用的npm命令
##### npm install

- `npm install 包名1 包名2 ...`: 安装所需的npm包
- `npm i 包名`: 简写形式
- `npm i 包名 --global`/`npm i 包名 -g`: 全局安装,安装在本地文件夹而非项目文件夹中,除非你确实需要用这个npm包来执行全局命令,否则不要这么做
- `npm install 包名@1.2.1`: 安装该包的特定版本
- `npm install 包名@latest`: 安装或者升级到该包的最新版本,这也是默认命令


有时候我们安装npm包后,命令行会弹出类似这样的警告:
![示意图](image.png)

这就涉及到了npm的安全漏洞知识了.
##### npm安全漏洞解析
- [官方文档](https://docs.npmjs.com/auditing-package-dependencies-for-security-vulnerabilities)

npm 将漏洞分为四个风险等级：

1. Low (低度): 难以被恶意利用，通常需要本地访问权限。
2. Moderate (中度): 具备一定的被攻击风险，例如特定构造下的拒绝服务攻击（DoS）。
3. High (高度): 漏洞可能导致数据泄露、跨站脚本攻击（XSS）。
4. Critical (严重): 极度危险，攻击者可能借此远程执行恶意代码（RCE），必须立刻修复。

所以,当我们安装npm包的时候需要额外注意,不要下载了恶意的代码包(这也被称为**供应链投毒**),而由于所有的包管理器(pnpm,bun,yarn)都共享同一个仓库源,所以用其他下载方式也会被感染.
##### npm audit
- `npm audit fix`: 该命令用于修复一些比较简单的包漏洞
- `npm audit fix --force`: 强制将包升级到绝对安全的版本,很有可能会导致项目无法运行.
##### npx/npm exec
>npx本质上是`npm exec`的别名,用法基本一样.

运行`npx 包名`时,它会按照以下路径查找包:
1. 项目目录
2. 本地全局目录

如果没有找到,它就会在临时目录中创建该包的缓存,并不会下载到项目目录中,在运行结束后会进行清理.
##### npm create/npm init
- [博客文章](https://www.cnblogs.com/itkkk/p/18184613)

- `npm create`是`npm init`的别名,由于`create`比起`init`来说更直观,能够表达出构建模板项目的意思,所以很多时候都会使用`npm create`来代替`npm init`.

官方对`npm init`的解释如下:
- npm init foo -> npm exec create-foo
- npm init @usr/foo -> npm exec @usr/create-foo
- npm init @usr -> npm exec @usr/create
- npm init @usr@2.0.0 -> npm exec @usr/create@2.0.0
- npm init @usr/foo@2.0.0 -> npm exec @usr/create-foo@2.0.0

大致来说就是,运行`npm create vite@latest`相当于运行`npm init vite@latest`,而后一个命令相当于运行`npm exec create-vite@latest`,能够执行初始化脚本后搭建一个基本项目出来.

>一般来说,执行`npm create xxx`时,你可以有各种各样的配置选项,跟着命令行的说明选择自己想要的项目版本就行了.

![配置图片](PixPin_2026-05-19_12-07-39.webp)
### 新兴的包管理器
后来,有开发者觉得npm运行太慢了,就又开发了yarn和pnpm两种包管理器.


当然,长江后浪推前浪,后来又出现了一个新的包管理器Bun,它的速度更是快的吓人.
![示意图](PixPin_2026-05-17_16-58-47.webp)

- [图片来源](https://javascript.plainenglish.io/npm-yarn-pnpm-bun-install-real-app-benchmarking-72c475498024)


然而,Bun本身并不仅仅是一个包管理器,它的目标是彻底代替Node.js,作为新的js运行时:
![示意图](PixPin_2026-05-17_17-01-59.webp)

### 新兴的js运行时
#### Bun
- [官网](https://bun.com/)

Bun于2023年正式发布,由于构建速度很快,且兼容Node项目,很快就爆火了,但最近两年的Bun可以说是All-in-AI了,我很不看好,甚至在前两天做出了这么离谱的事情(今天是5/17):
![示意图](PixPin_2026-05-17_17-26-28.webp)

- 哈?一百万行代码?你直接梭哈了?
- [知乎讨论](https://www.zhihu.com/question/2038401743025854118)

真的无法理解:
![示意图](PixPin_2026-05-17_17-29-09.webp)

不过看到bun项目的issues数量后,我释怀了:
![示意图](PixPin_2026-05-17_17-34-57.webp)
#### Deno
- [wiki](https://en.wikipedia.org/wiki/Deno_(software))
Deno是由Node.js创始人于2018年的演讲中推出的Node.js替代品,为的是消除Node.js的种种缺陷:
![示意图](PixPin_2026-05-17_17-08-45.webp)

- Deno最初用Go编写,但后来用Rust取代了Go

尽管如此,买账的人并不太多,Deno往往是Bun和Node.js后的第三选项.


### 构建器
#### Webpack
- [官网](https://webpack.docschina.org/concepts/)
- [wiki](https://zh.wikipedia.org/wiki/Webpack)

>Webpack 是一款由 Tobias Koppers 于 2012 年发布的静态模块打包器，它通过建立一个包含项目所有资源（JS、CSS、图片等）的依赖关系图，将各种不同规范的模块转化为浏览器可识别的静态资源.

Webpack是前端构建器的始祖,如果用npm导入它的话,是这样写的:
```bash
npm install webpack webpack-cli
```
然后就可以用`webpack.config.js`进行基本的构建配置,当然我们没有必要去深入了解,毕竟现在确实不会用到webpack了.
#### Rollup
- [官网](https://www.rollupjs.com/)
>Rollup 是一款由 Rich Harris 于 2015 年推出的 JavaScript 模块打包器，它开创性地引入了 **Tree-shaking**（摇树优化）技术，通过静态分析 ES 模块依赖关系来剔除未使用的代码，从而生成体积极小、结构扁平的生产环境资源包，因其输出代码纯净且符合标准，现已成为 Vite 生产构建核心及多数开源库（如 React、Vue）打包的首选工具。

- [教程](https://www.rollupjs.com/tutorial/)
  - 非常他推荐跟着这个教程走一遍,然后就可以懂得前端打包的基本原理了.
#### esbuild
- [官网](https://esbuild.bootcss.com/getting-started/)
  - 推荐跟着教程来快速入门

现代构建器esbuild于2020年正式发布,并以他超绝的构建速度震惊了全世界,官网上有一个对比图:
![示意图](PixPin_2026-05-17_17-41-03.webp)

不管怎样,它的构建速度确实很快,我们看看它是如何做到的,首先新建一个项目后运行以下命令:
```bash
npm i esbuild react react-dom
```
之后在根目录新建一个`app.jsx`文件:
```jsx
import * as React from "react";
import * as Server from "react-dom/server";

let Greet = () => <h1>Hello, world!</h1>;
console.log(Server.renderToString(<Greet />));
```
之后运行以下命令执行esbuild脚本:
```bash
.\node_modules\.bin\esbuild app.jsx --bundle --outfile=out.js
```
然后就得到了一个一万多行的js代码:
![示意图](PixPin_2026-05-18_14-25-45.webp)

很惊人吧,而且,之前的构件工具只能处理html,css和普通的js代码,而它不需要转译器的帮助就可以处理jsx代码了,自然ts和tsx文件也是支持的,从而直接取代了转译器的活儿.

#### Vite
##### 概览
>Vite 是由 Vue.js 作者尤雨溪（Evan You）于 2020 年发起的新一代前端构建工具

>Vite 诞生之初，浏览器刚刚获得了对 ES 模块（ESM）的广泛支持。ESM 允许浏览器直接加载 JavaScript 文件，无需工具事先将它们打包成单个文件。而传统的构建工具（通常称为 打包器）会在浏览器展示任何内容之前，将整个应用预先处理一遍。应用越大，等待的时间就越长。

Vite 采用了一种截然不同的方式，将工作拆分为两部分：

1. 依赖（几乎不会变动的库）：使用快速的原生工具 预构建 一次，即可随时就绪。
2. 源码（频繁变动的应用代码）：通过原生 ESM 按需提供。浏览器只加载当前页面所需的内容，Vite 则在请求时对每个文件进行转换。

这意味着无论应用规模多大，开发服务器的启动几乎都是即时的。当你修改某个文件时，Vite 通过原生 ESM 的 **模块热替换**（HMR）只更新浏览器中的对应模块，无需整页刷新，也无需等待重新构建。

>Vite 最初在底层依赖两个独立的工具：esbuild 负责开发阶段的快速编译，Rollup 负责生产构建中的深度优化。这套方案可行，但维护两条流水线带来了不一致性：不同的转换行为、各自独立的插件系统，以及越来越多的粘合代码来保持两者对齐。

>**Rolldown** 的出现将二者统一为一个打包器：用 Rust 编写以获得原生速度，并与生态系统已依赖的同一套插件 API 兼容。它使用 Oxc 进行解析、转换和压缩。这赋予了 Vite 一条端到端的工具链，其中构建工具、打包器和编译器共同维护，作为一个整体协同演进。

换句话说vite是前端构建工具的集大成者,将前端项目的构建速度优化到了极致.
##### 配置文件
使用vite的前端项目中,根目录下都有一个`vite.config.ts`文件:
```ts
import path from "node:path"
import tailwindcss from "@tailwindcss/vite"
import { tanstackRouter } from "@tanstack/router-plugin/vite"
import react from "@vitejs/plugin-react-swc"
import { defineConfig } from "vite"

// https://vitejs.dev/config/
export default defineConfig({
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
  plugins: [
    tanstackRouter({
      target: "react",
      autoCodeSplitting: true,
    }),
    react(),
    tailwindcss(),
  ],
})
```

以下代码非常值得关注:
```ts
resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
```
我们在前端项目中看到有些文件是以`@`的形式导入的,就是通过这个别名设置实现的:
```js
import { zodResolver } from "@hookform/resolvers/zod"
import { useMutation, useQueryClient } from "@tanstack/react-query"
```

### 转译器
#### Babel
>Babel 是一类比较常用的jsx转换工具

```js
// 转换前
const element = <h1>Hello</h1>;

// 转换后
var element = React.createElement("h1", null, "Hello");
```
#### typescript compiler(tsc)
用于将tsx和ts代码转换成普通的js代码,前面已经介绍过它的效果了,这里就不多说了.

#### SWC
- [官网](https://swc.rs/docs/getting-started)

使用Rust编写的现代转译器,速度极快,是现代前端框架的标准配置.

### tsconfig.json详解
- [官方文档](https://www.typescriptlang.org/zh/docs/handbook/tsconfig-json.html)

>当目录中出现了 tsconfig.json 文件，则说明该目录是 TypeScript 项目的根目录。tsconfig.json 文件指定了编译项目所需的根目录下的文件以及编译选项。
>
>JavaScript 项目可以使用 jsconfig.json 文件，它的作用与 tsconfig.json 基本相同，只是默认启用了一些 JavaScript 相关的编译选项。

有两个比较基本的例子:
```json
{
  "compilerOptions": {
    "module": "commonjs",
    "noImplicitAny": true,
    "removeComments": true,
    "preserveConstEnums": true,
    "sourceMap": true
  },
  "files": [
    "core.ts",
    "sys.ts",
    "types.ts",
    "scanner.ts",
    "parser.ts",
    "utilities.ts",
    "binder.ts",
    "checker.ts",
    "emitter.ts",
    "program.ts",
    "commandLineParser.ts",
    "tsc.ts",
    "diagnosticInformationMap.generated.ts"
  ]
}
```

一个个加ts文件太麻烦了,与CMakelist的写法类似,我们可以通过通配符一键导入所有文件:
```ts
{
  "compilerOptions": {
    "module": "system",
    "noImplicitAny": true,
    "removeComments": true,
    "preserveConstEnums": true,
    "outFile": "../../built/local/tsc.js",
    "sourceMap": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "**/*.spec.ts"]
}
```
- 编译配置和很多乱七八糟的内容就没必要一一赘述了,还是很好懂的.再说使用框架编写的话就没必要管这些配置了.

#### vite中让人搞不懂的tsconfig配置
如果你曾经使用过vite官方的模板项目的话,也就是运行过以下命令:
```bash
npm create vite@latest 
```
就会发现它的文件夹下有三个tsconfig配置文件:
![示意图](PixPin_2026-05-19_11-40-04.webp)

ts的默认配置文件`tsconfig.json`下只有这个内容:
```json
{
  "files": [],
  // "files": [] 是必须的，它告诉编译器主文件不需要直接编译任何代码，只需调度引用的子项目。
  "references": [
    { "path": "./tsconfig.app.json" },
    { "path": "./tsconfig.node.json" }
  ]
}
```
另外两个文件分别对应了`app`模式和`node`模式,即在浏览器中运行的配置和在node中运行的配置,这是为什么呢?

[StackOverflow](https://stackoverflow.com/questions/72027949/why-does-vite-create-two-typescript-config-files-tsconfig-json-and-tsconfig-nod)上有一个不太清晰的解答,而[geeksforgeeks](https://www.geeksforgeeks.org/typescript/why-does-vite-create-multiple-typescript-config-files-tsconfigjson-tsconfigappjson-and-tsconfignodejson/)上的解答也是摸棱两可的,翻遍了全网也找不到一个比较好的说明.

那没办法了,只好来找不同了:

这是tsconfig.app.json:
```json
{
  "compilerOptions": {
    "tsBuildInfoFile": "./node_modules/.tmp/tsconfig.app.tsbuildinfo",
    "target": "es2023",
    "lib": ["ES2023", "DOM"],
    "module": "esnext",
    "types": ["vite/client"],
    "skipLibCheck": true,

    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "verbatimModuleSyntax": true,
    "moduleDetection": "force",
    "noEmit": true,
    "jsx": "react-jsx",

    /* Linting */
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "erasableSyntaxOnly": true,
    "noFallthroughCasesInSwitch": true
  },
  "include": ["src"]
}
```

这是tsconfig.node.json:
```ts
{
  "compilerOptions": {
    "tsBuildInfoFile": "./node_modules/.tmp/tsconfig.node.tsbuildinfo",
    "target": "es2023",
    "lib": ["ES2023"],
    "module": "esnext",
    "types": ["node"],
    "skipLibCheck": true,

    /* Bundler mode */
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "verbatimModuleSyntax": true,
    "moduleDetection": "force",
    "noEmit": true,

    /* Linting */
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "erasableSyntaxOnly": true,
    "noFallthroughCasesInSwitch": true
  },
  "include": ["vite.config.ts"]
}
```

我们需要先澄清一个[误区](https://kettanaito.com/blog/one-thing-nobody-explained-to-you-about-typescript),`include`属性真正的作用是**配置tsconfig.json的作用域**,也就是说,我们针对不同的文件可以设定不同的配置.

比如说这里,我们的`tsconfig.node.json`只是针对`vite.config.ts`设定的,而`tsconfig.app.json`是针对src文件夹中的所有文件设定的.

由于Vite使用的是Node的接口,那么它自然需要针对Node做出对应的配置调整,而源文件夹使用Vite进行构建,就需要针对Vite进行自己的调整.

### 总结
前端项目中有好几个概念:
1. 运行时: Node,Bun,Deno
2. 构建器: Vite,Webpack,Rollup等
3. 转译器: Babel,tsc

运行时是现代前端项目开发的基石,它负责处理网络通信,IO读取等原本由浏览器引擎来做的活儿,让前端的开发能够暂时离开浏览器.

构建器将html,css,js文件打包成一个或几个文件,并进行大量的优化工作,方便项目的打包和运行.

转译器将jsx,ts,tsx等代码转换成普通的js文件,供构建器调用处理.

了解了这些概念,你就会明白为什么前端项目会比后端项目多出那么多配置文件了:
![示意图](PixPin_2026-05-18_12-52-15.webp)

- 当然,上述的介绍都很浅薄,真要实战的话需要专门去看相应的官方文档.
- 前端工具开发目前正在全面转向Rust/Go,说明这两个语言确实很快.


## 前端常用库(待补充)

### Axios
#### 概览
- [reddit上的讨论](https://www.reddit.com/r/webdev/comments/1s8i384/what_do_people_use_axios_for/?tl=zh-hans)
- [官网](https://axios.rest/pages/getting-started/first-steps.html)

axios库实际上干的就是ES6中`fetch`的活儿,用于处理与后端服务器的通信,只不过多了一些好用的特性,如果项目比较简单的话就没必要额外导入axios了.

一个非常简单的示例如下:
```js
import axios from "axios";

const response = await axios.get(
  "https://jsonplaceholder.typicode.com/posts/1"
);

console.log(response.data);
```
我们可以像使用fetch一样加入时延,但不用到setTimeOut函数:
```js
const response = await axios.get("https://example.com/data", {
  timeout: 5000, // 5 seconds
});
```

### Zod
#### 概览
- [官网](https://zod.nodejs.cn/)

- 由于TS只在开发时检查类型,无法在运行时提供任何类型检查,所以就需要各种各样的第三方类型验证库来做补充.

Zod是一个类型验证库,用于核验传入的数据是否符合类型验证的要求,通常用在表单提交等场景.


### Zustand
#### 概览
- [官网](https://zustand.docs.pmnd.rs/)

鉴于React原生的`createContext`比较笨重,需要嵌套多个组件来传递状态,而Zustand能够很好的管理这种跨越组件传递状态的情况,通过语法糖简化状态管理.


### playwright
### eslint
### biome

## 现代CSS框架与组件库
### Tailwind
#### 前置概念: 为什么要有Tailwind
- [背景介绍](https://blog.huli.tw/2022/05/23/atomic-css-and-tailwind-css/)
- [简要介绍tailwind](https://medium.com/@Kelly_CHI/tailwind-css-introduction-and-tools-68e770b2bf7f)
- [tailwind辨析](https://www.builder.io/blog/tailwind-css-drama)


![示意图](PixPin_2026-05-20_11-03-08.webp)


大多数人第一次见到tailwind的时候都会是这个感受:
>When I first encountered it, I kind of gagged a bit. I couldn’t help but glaze over the long list of classes that sullied my HTML.

不管怎样,在了解了它的优缺点后,先来试试用Tailwindcss进行开发吧.

#### 安装步骤
- [官网](https://tailwindcss.com/docs/installation/using-vite)

tailwind可以在html和JSX/TSX文件中使用,如果仅仅是在html中使用的话相当简单,通过CDN导入即可:
```html
<!doctype html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <!-- CDN导入 -->
  </head>
  <body>
    <h1 class="text-3xl font-bold underline">
      Hello world!
    </h1>
  </body>
</html>
```

![效果图](PixPin_2026-05-20_11-11-03.webp)

还可以设定自定义的css规则:
```html
<!doctype html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <style type="text/tailwindcss">
      @theme {
        --color-clifford: #aa373d;
      }
    </style>
  </head>
  <body>
    <h1 class="text-3xl font-bold underline text-clifford">Hello world!</h1>
  </body>
</html>
```

![效果图](PixPin_2026-05-20_11-15-54.webp)


如果是在vite框架中使用的话,需要进行以下配置:
1. 导入tailwindcss包: `npm install tailwindcss @tailwindcss/vite`
2. 在`vite.config.ts`里导入tailwindcss:
```ts
import { defineConfig } from 'vite'
import tailwindcss from '@tailwindcss/vite'
export default defineConfig({
  plugins: [
    tailwindcss(),
  ],
})
```
3. 在全局css文件(可能是main.css/app.css/index.css)中导入tailwindcss:
```css
@import "tailwindcss";
```
4. 入口ts文件(可能是main.tsx)中一般都已经导入了该全局css文件: `import './index.css'`,因此,在src文件夹中的所有文件中,都可以通过`className`使用tailwind,不需要进行额外的导入.
```ts
// src/components/Button.tsx
// ❌ 顶部不需要 import 'tailwindcss'

export default function Button() {
  return (
    //  直接使用，直接生效
    <button className="bg-blue-500 text-white px-4 py-2 rounded">
      按钮
    </button>
  )
}
```

#### 基本语法(待补充)

### shadcn
- [官网](https://ui.shadcn.com/)
- [比较完整的介绍](https://medium.com/@Kelly_CHI/shadcn-ui-tailwind-components-6fd4f1959147)

如果自己手写tailwind的话,我想真需要练习好几个月才敢自己来写一个完整的网站,好在shadcn提供了各种各样可以直接迁移到自己项目中使用的组件,让后端开发者也能够轻松写出美观的前端界面.
#### 基本用法
1. 进入官网,找到自己要用的框架:
![示意图](PixPin_2026-05-21_19-16-56.webp)
2. 选择自己的框架之后,可以点开黑色按钮找自己喜欢的风格:
![示意图](PixPin_2026-05-21_19-17-35.webp)
3. 选择好风格后点击`get code`按钮,获取自己的包导入代码:
![示意图](PixPin_2026-05-21_19-19-17.webp)

4. 如果看不懂某些功能有什么用的话采用默认配置也行,然后就可以直接在终端中初始化项目了:
![示意图](PixPin_2026-05-21_19-25-36.webp)

可以看到,我们的src文件夹下多了一个components文件夹,里面有一个内置好了的button组件库:
```tsx
import { Button as ButtonPrimitive } from "@base-ui/react/button"
import { cva, type VariantProps } from "class-variance-authority"

import { cn } from "@/lib/utils"

const buttonVariants = cva(
  "group/button inline-flex shrink-0 items-center justify-center rounded-md border border-transparent bg-clip-padding text-sm font-medium whitespace-nowrap transition-all outline-none select-none focus-visible:border-ring focus-visible:ring-3 focus-visible:ring-ring/50 active:not-aria-[haspopup]:translate-y-px disabled:pointer-events-none disabled:opacity-50 aria-invalid:border-destructive aria-invalid:ring-3 aria-invalid:ring-destructive/20 dark:aria-invalid:border-destructive/50 dark:aria-invalid:ring-destructive/40 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4",
  {
    variants: {
      variant: {
        default: "bg-primary text-primary-foreground hover:bg-primary/80",
        outline:
          "border-border bg-background shadow-xs hover:bg-muted hover:text-foreground aria-expanded:bg-muted aria-expanded:text-foreground dark:border-input dark:bg-input/30 dark:hover:bg-input/50",
        secondary:
          "bg-secondary text-secondary-foreground hover:bg-secondary/80 aria-expanded:bg-secondary aria-expanded:text-secondary-foreground",
        ghost:
          "hover:bg-muted hover:text-foreground aria-expanded:bg-muted aria-expanded:text-foreground dark:hover:bg-muted/50",
        destructive:
          "bg-destructive/10 text-destructive hover:bg-destructive/20 focus-visible:border-destructive/40 focus-visible:ring-destructive/20 dark:bg-destructive/20 dark:hover:bg-destructive/30 dark:focus-visible:ring-destructive/40",
        link: "text-primary underline-offset-4 hover:underline",
      },
      size: {

        icon: "size-9",
        "icon-xs":
          "size-6 rounded-[min(var(--radius-md),8px)] in-data-[slot=button-group]:rounded-md [&_svg:not([class*='size-'])]:size-3",
        "icon-sm":
          "size-8 rounded-[min(var(--radius-md),10px)] in-data-[slot=button-group]:rounded-md",
        "icon-lg": "size-10",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
)

function Button({
  className,
  variant = "default",
  size = "default",
  ...props
}: ButtonPrimitive.Props & VariantProps<typeof buttonVariants>) {
  return (
    <ButtonPrimitive
      data-slot="button"
      className={cn(buttonVariants({ variant, size, className }))}
      {...props}
    />
  )
}

export { Button, buttonVariants }
```

并且index.css也变得完全不一样了,内置了对明暗主题的支持:
```css
@import "tailwindcss";
@import "tw-animate-css";
@import "shadcn/tailwind.css";
@import "@fontsource-variable/geist";

@custom-variant dark (&:is(.dark *));

@theme inline {
    --font-heading: var(--font-sans);
    --font-sans: 'Geist Variable', sans-serif;
    --color-sidebar-ring: var(--sidebar-ring);
    --color-sidebar-border: var(--sidebar-border);
}
/* below omitted */
```
- 显然,让我们自己写这些代码是不太可能的.

然后在App.tsx中已经帮我们导入了Button组件:
```tsx
import { Button } from "@/components/ui/button"

export function App() {
  return (
    <div className="flex min-h-svh p-6">
      <div className="flex max-w-md min-w-0 flex-col gap-4 text-sm leading-loose">
        <div>
          <h1 className="font-medium">Project ready!</h1>
          <p>You may now add components and start building.</p>
          <p>We&apos;ve already added the button component for you.</p>
          <Button className="mt-2">Button</Button>
        </div>
        <div className="font-mono text-xs text-muted-foreground">
          (Press <kbd>d</kbd> to toggle dark mode)
        </div>
      </div>
    </div>
  )
}
export default App
```
运行`npm run dev`后出现以下界面:
![示意图](PixPin_2026-05-21_19-30-14.webp)

- 很成功!

如果之后还要加入新组件的话,就需要继续导入:
```bash
pnpm dlx shadcn@latest add card
```
并在使用的时候导入该组件:
```tsx
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"

function App() {
  return (
    <Card className="max-w-sm">
      <CardHeader>
        <CardTitle>Project Overview</CardTitle>
        <CardDescription>
          Track progress and recent activity for your Vite app.
        </CardDescription>
      </CardHeader>
      <CardContent>
        Your design system is ready. Start building your next component.
      </CardContent>
    </Card>
  )
}

export default App
```

尽管我们仍然需要自己折腾组件的布局,并加入一些简单的tailwindcss样式,但这可比自己从零开始搭强上千万倍了.

如果有自己想要的组件,可以直接在官网中寻找并导入:
![示意图](PixPin_2026-05-21_19-39-22.webp)

- 尽管这些组件的布局语法也要专门学习一下,但还是比自己手搓强.

>接下来会介绍一下主流的React框架,这些框架能够帮助我们更好地进行路由管理和状态管理.(部分原因也在于React的原生语法确实不太好用)
>
>由于设计理念的不同,不同框架之间的差别(包括文件路由和依赖库)可能非常大,所以简单浏览一下主流框架的特性后建议迅速选定自己想用的框架,不然在框架之间迁移是很痛苦的.



## Next.js
### 概览
- [官方文档](https://nextjs.org/docs)
  - 三个月前,大概是26年2月,我第一次接触next的时候,官方文档还写的很烂,现在重构了一版,清晰了不少,但还是非常烂,结构非常混乱,看起来很难受
#### 简要介绍
Next.js是一个全面拥抱AI的React框架,深度适配Agent,有多适配呢,甚至会在模板项目里内置AGENTS.md,你就说离不离谱吧:
![示意图](PixPin_2026-05-21_15-34-19.webp)

内容如下:
```md
<!-- BEGIN:nextjs-agent-rules -->
# This is NOT the Next.js you know

This version has breaking changes — APIs, conventions, and file structure may all differ from your training data. Read the relevant guide in `node_modules/next/dist/docs/` before writing any code. Heed deprecation notices.
<!-- END:nextjs-agent-rules -->
```
- 看得出来很贴心了...

#### 历史
鉴于[wiki](https://en.wikipedia.org/wiki/Next.js)上的说明实在太简单了,让AI总结了一下...

##### 1. 萌芽期：解决 React 的痛点 (2016 - 2018)

2016 年前后的 React 处于绝对的统治地位，但它有一个致命问题：**纯客户端渲染（CSR）**。这意味着浏览器拿到的 HTML 是一个空壳，对 SEO（搜索引擎优化）极不友好，且首屏加载慢。

* **2016年10月（v1.0）**：由 ZEIT 公司（现 Vercel）开源。它最初只有 6 个核心功能，主打**开箱即用的服务端渲染（SSR）**和**基于文件系统的路由（Pages Router）**。开发者只需在 `pages` 目录下建个文件，路由和服务器端渲染就自动搞定了。
* **2019年（v8.0）**：引入了 **Serverless（无服务器）** 架构支持，使每个页面路由都可以编译成一个独立的 Lambda 函数，为后续的全球边缘分发奠定了工程基础。

##### 2. 黄金期：拥抱静态化与全面流行 (2019 - 2021)

随着 Jamstack 概念的兴起，Next.js 开始从单一的 SSR 向多元化渲染架构演进，并得到了 Google 团队的直接工程代码贡献。

* **v9.x - v10.x**：推出了 **SSG（静态站点生成）** 以及革命性的 **ISR（增量静态再生）**。ISR 允许开发者在后台增量更新部分静态页面，而无需重新构建整个网站，近乎完美地平衡了“静态页面的极速”与“动态数据的实时”。
* **2020年**：公司正式更名为 **Vercel**，获得了巨大的商业成功。
* **2021年（v12.0）**：这是一个底层工程的转折点。Next.js 开始放弃原有的 JavaScript 工具链，引入了基于 Rust 编写的 **SWC 编译器**，替代了 Babel 和 Terser，使代码编译和压缩速度提升了数倍。

##### 3. 阵痛与变革：App Router 与重构 (2022 - 2024)

随着 React 官方提出 React Server Components（RSC，服务端组件）概念，Next.js 作为其实验小白鼠，迎来了历史上最具争议也最激进的一次彻底重构。

* **2022年10月（v13.0）**：推出了全新的 **App Router (`app/` 目录)**。它彻底改变了原有的页面开发思维：组件默认在服务器端运行，只有声明 `"use client"` 的才是客户端组件。
* **2023年（v14.0）**：**Server Actions（服务器动作）** 走向稳定。前端开发者可以在组件里直接写操作数据库的异步函数，甚至不需要再手动编写传统意义上的 API 路由。
* *这一时期的代价是巨大的。缓存机制过于激进、文档混乱、黑盒问题频发，导致社区出现了不小的抵触情绪。*

##### 4. 稳健与前沿：反思缓存与 AI 时代 (2025 - 至今)

在经历了两年的动荡后，Next.js 开始回归理性，专注于稳定性、底层工具链的收尾，以及对新兴技术的适配。

* **2024年底 - 2025年（v15.0）**：顺应民意进行大刀阔斧的“拨乱反正”。核心改变是**将默认的激进自动缓存改为“默认不缓存（Opt-in）”**，大幅度降低了开发者的心智负担，并全面适配 React 19。同时，基于 Rust 的全新打包工具 **Turbopack** 逐步替代 Webpack 成为默认的开发构建底座。
* **2025年底 - 2026年（v16.0 及后续）**：进入稳定长期支持（LTS）阶段。除进一步稳固基础外，开始内置对 **AI 开发生态（如 Agent 和 MCP 协议）** 的原生工程支持，从“全栈 Web 框架”向“AI 时代的通用应用底座”演进。
#### App Router与Pages Router
根据上面的历史也可以知道,Next.js目前支持两种路由,一个是App Router,一个是Pages Router,由于Pages Router不再进行更新,所以现在只推荐使用App Router了:

![官网](PixPin_2026-05-21_15-45-15.webp)
### 基本特性介绍
#### 前置概念
next.js中将组件分为服务端和客户端:
- 服务端(server): 运行在服务器上,是组件的默认配置.
  - 负责与数据库/API通信,在用户看到界面之前就执行完毕,生成静态的html文件
  - 不能使用`useState`等与用户输入/交互相关的Hook和触发器
- 客户端(client): 运行在用户的浏览器上,通过文件顶部的`"use client"`声明来将组件变成客户端.
  - 负责用户交互和局部的动态更新,生成js代码
  - 可以自由使用用户交互相关的函数

当然,上面的说法不太专业,但能够很好的描述实际发生了的事情,而官网上的说法就有点云山雾罩了:

![官网说明](PixPin_2026-05-24_15-58-45.webp)

- **水合(Hydration)**: 形象的说就是给html注入js代码,让网页变得充实起来.具体来讲,服务端将不具备任何交互能力的代码发送到浏览器后,客户端会下载网页对应的js代码,扫描当前页面的DOM结构,使得用户可以与组件进行交互
  - 客户端代码对应的就是水合要注入的js文件
  - 由于水合会存在各种各样的问题,我们应该尽可能减少客户端的代码,让大部分网页渲染逻辑在服务端完成.
  - 查看[wiki](https://en.wikipedia.org/wiki/Hydration_(web_development))进一步了解



#### 文件架构
##### 文件夹
Next通过文件系统来映射路由,用`page.tsx`文件来展示对应路由的网页:
```text
app/
├── layout.tsx         # 全局布局（导航栏、页脚）
├── page.tsx           # 根路由 ( / )
├── dashboard/
│   ├── page.tsx       # 仪表盘路由 ( /dashboard )
│   └── settings/
│       └── page.tsx   # 设置路由 ( /dashboard/settings )
└── blog/
    └── [id]/
        └── page.tsx   # 动态路由 ( /blog/1, /blog/abc )
```
一个长长的路由示例如下:
![示意图](PixPin_2026-05-22_20-45-08.webp)

- 只有`page.tsx`和`route.tsx`文件会被映射到路由,其他名字的文件不会被映射到路由:

![示意图](PixPin_2026-05-23_21-55-32.webp)


next还支持对文件夹名字做出各种各样的修改:

1. 如果我们要实现动态路由,即在路由中插入变量,需要将文件夹的名字修改成`[var]`或者另外两种变体:

| Next.js App Router 文件路径     | 匹配的 URL 示例                                                      | 路由模式名称                                   |
| ------------------------------- | -------------------------------------------------------------------- | ---------------------------------------------- |
| `app/blog/[slug]/page.tsx`      | `/blog/my-first-post`                                                | 动态路由 (Dynamic Segment)                     |
| `app/shop/[...slug]/page.tsx`   | `/shop/clothing`, `/shop/clothing/shirts`                            | 捕获所有路由 (Catch-all Segments)              |
| `app/docs/[[...slug]]/page.tsx` | `/docs`, `/docs/layouts-and-pages`, `/docs/api-reference/use-router` | 可选捕获所有路由 (Optional Catch-all Segments) |

2. 如果我们需要对不同功能的路由进行分组,又不希望加深一层路由,就需要用到路由组功能;如果有一些工具文件不希望被映射到路由,那就将`_`放在文件夹名字前面:

| Next.js App Router 文件路径     | 匹配的 URL 路径 | 路由模式 / 特性说明                                                                                                                 |
| ------------------------------- | --------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `app/(marketing)/page.tsx`      | `/`             | **路由组 (Route Groups)**：圆括号命名的文件夹在 URL 路径中会被完全省略。                                                            |
| `app/(shop)/cart/page.tsx`      | `/cart`         | **共享布局路由组**：在 `(shop)` 文件夹内定义的 `layout.tsx` 会被组内所有页面（如 `/cart`）共享，而不影响 URL 结构。                 |
| `app/blog/_components/Post.tsx` | *不可路由*      | **私有文件夹 (Private Folders)**：以底线 `_` 开头的文件夹及其子目录会被路由系统忽略。适合存放当前模块特有的 UI 组件。               |
| `app/blog/_lib/data.ts`         | *不可路由*      | **私有文件夹 (Private Folders)**：以底线 `_` 开头的文件夹内的所有文件均不参与路由。适合存放当前模块特有的数据层代码或实用工具函数。 |


另外一个非常重要的点就是App Router对应的文件夹就是`app`,这个名字不可更改,next会在app里开始映射路由,app根目录的文件对应的路由即为`/`.

但是,next允许用src文件夹在app文件夹外面进行包裹,也就是说src文件夹下可以有路由文件夹`app`和其他的工具文件夹或者组件库,从而将所有的代码与配置文件隔离开来:

![示意图](PixPin_2026-05-23_21-59-36.webp)

##### 布局文件: layout.tsx
next中使用`layout.tsx`文件来设置当前路由以及所有子路由的布局,这个名字不可改动,更令人惊讶的特性是,该文件不需要手动导入到其他文件夹中,会默认作用于当前路由,这也是通过默认导出函数实现的:


尽管其他路由的`layout.tsx`文件是可选的,但根路径下必须有一个`layout.tsx`,且必须包含html和body标签,一般长这样:
```tsx
export default function DashboardLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>
        {/* 布局 UI */}
        {/* 将 children 放在你想要渲染页面或嵌套布局的位置 */}
        <main>{children}</main>
      </body>
    </html>
  )
}
```
- 这样一来,就不需要React自带的index.html了,主观上来说项目更加清晰了.

##### 页面文件: page.tsx

在每一个`page.tsx`中,都需要有一个**默认导出函数**来展示最终的界面,叫什么名字倒是无所谓,也没有什么意义:
```tsx
import { useChatStore } from "@/store/chat";
import ChatArea from "@/components/chat/ChatArea";

export default function ChatPage() {
  const activeSession = useChatStore((s) => s.activeSession);

  if (!activeSession) {
    return <ChatArea />;
  }

  return <ChatArea />;
}
```
如果是动态路由下的文件,需要接收文件夹`[var]`的名字`var`作为参数:
```tsx
// app/blog/[slug]/page.tsx
export default async function BlogPostPage({
  params,
}: {
  params: Promise<{ slug: string }>
}) {
  const { slug } = await params
  const post = await getPost(slug)
 
  return (
    <div>
      <h1>{post.title}</h1>
      <p>{post.content}</p>
    </div>
  )
}
```


##### 预加载文件: loading.tsx
用于放置某个路由文件夹下,该文件同样不能改成其他名字,nextjs会优先加载`loading.tsx`,先给用户展示大致的UI框架,之后再加载`page.tsx`返回完整页面
##### 异常文件

next中主要有三种异常文件,全都是自动生效/不可改名的:

| 专用文件名                                    | 触发场景                                                                        | 本质对应的 React 特性            | 必须加 `"use client"` 吗         |
| --------------------------------------------- | ------------------------------------------------------------------------------- | -------------------------------- | -------------------------------- |
| **`not-found.tsx`**                           | 1. 访问了不存在的路由（404）。<br>                                              |
| <br>2. 在代码中显式触发了 `notFound()` 函数。 | 局部的 404 兜底组件                                                             | **否** (默认是 Server Component) |
| **`error.tsx`**                               | 捕获该路由目录及其子目录下，所有页面在**运行时（Runtime）**抛出的未知代码崩溃。 | 局部错误边界 `<ErrorBoundary>`   | **是** (必须是 Client Component) |
| **`global-error.tsx`**                        | 专门用于捕获根布局 `app/layout.tsx` 本身崩溃的极端情况。                        | 整个应用的终极死机界面           | **是** (必须是 Client Component) |

##### 路由处理函数
- [API文档](https://nextjscn.org/docs/app/api-reference/functions/use-params)

1. useParams: 返回当前路由中用`[]`包裹的动态参数,由于是客户端动态返回的,所以在客户端组件中才能使用.
```tsx
'use client'
 
import { useParams } from 'next/navigation'
 
export default function ExampleClientComponent() {
  const params = useParams<{ tag: string; item: string }>()
 
  // Route -> /shop/[tag]/[item]
  // URL -> /shop/shoes/nike-air-max-97
  // `params` -> { tag: 'shoes', item: 'nike-air-max-97' }
  console.log(params)
 
  return '...'
}
```
详细示例见表格:

| 路由文件路径 (App Router)       | 请求 URL    | `useParams()` 返回值      | 路由类型                               |
| ------------------------------- | ----------- | ------------------------- | -------------------------------------- |
| `app/shop/page.js`              | `/shop`     | `{}`                      | 静态路由 (Static Route)                |
| `app/shop/[slug]/page.js`       | `/shop/1`   | `{ slug: '1' }`           | 动态路由 (Dynamic Segment)             |
| `app/shop/[tag]/[item]/page.js` | `/shop/1/2` | `{ tag: '1', item: '2' }` | 嵌套动态路由 (Nested Dynamic Segments) |
| `app/shop/[...slug]/page.js`    | `/shop/1/2` | `{ slug: ['1', '2'] }`    | 全捕获路由 (Catch-all Segments)        |

2. usePathname: 获取静态路由,但由于需要过滤掉客户端的请求参数,所以也是客户端组件:
```tsx
'use client'
 
import { usePathname } from 'next/navigation'
 
export default function ExampleClientComponent() {
  const pathname = usePathname()
  return <p>Current pathname: {pathname}</p>
}
```

表格如下:

| 完整 URL              | 提取后的路由路径 (Pathname) | 说明                            |
| --------------------- | --------------------------- | ------------------------------- |
| `'/'`                 | `'/'`                       | 根路径                          |
| `'/dashboard'`        | `'/dashboard'`              | 静态路径                        |
| `'/dashboard?v=2'`    | `'/dashboard'`              | 自动过滤查询参数 (Query Params) |
| `'/blog/hello-world'` | `'/blog/hello-world'`       | 嵌套静态路径                    |

3. useSearchParams: 获取搜索参数,同样是客户端组件

```tsx
'use client'
 
import { useSearchParams } from 'next/navigation'
 
export default function SearchBar() {
  const searchParams = useSearchParams()
 
  const search = searchParams.get('search')
 
  // URL -> `/dashboard?search=my-project`
  // `search` -> 'my-project'
  return <>Search: {search}</>
}
```

表格如下:
| 完整 URL               | 方法调用                   | 返回值       | 行为说明                                                   |
| ---------------------- | -------------------------- | ------------ | ---------------------------------------------------------- |
| `'/dashboard?a=1'`     | `searchParams.get("a")`    | `'1'`        | 正常获取指定参数的值。                                     |
| `'/dashboard?a='`      | `searchParams.get("a")`    | `''`         | 参数存在但无值，返回空字符串。                             |
| `'/dashboard?b=3'`     | `searchParams.get("a")`    | `null`       | 参数不存在，返回 `null`。                                  |
| `'/dashboard?a=1&a=2'` | `searchParams.get("a")`    | `'1'`        | 存在同名参数时，`get()` 仅返回**第一个**匹配的值。         |
| `'/dashboard?a=1&a=2'` | `searchParams.getAll("a")` | `['1', '2']` | 使用 `getAll()` 可获取同名参数的**所有**值，返回一个数组。 |

4. useRouter,允许动态更改路由,实现客户端界面的跳转,同样是客户端组件
```tsx
'use client'
 
import { useRouter } from 'next/navigation'
 
export default function Page() {
  const router = useRouter();
 
  return (
    <button type="button" onClick={() => router.push('/dashboard')}>
      Dashboard
    </button>
  );
}
```
`useRouter`的实例有以下方法:

![示意图](PixPin_2026-05-25_13-34-23.webp)

- `router.replace`一般只用于用户验证和重定向,用户在重定向到`/login`并跳转回首页时,点击后退按钮不会重新回到登录页;而`router.push`则会保留过往记录,能够退回到重定向的位置.

#### 常用特性

##### 简单使用Metadata
>设置html中head标签部分的metadata,从而改善网页的SEO.

nextjs会默认配置以下两个metadata:
```html
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
```

我们可以在`layout.tsx`中配置自定义的metadata:
```tsx
import type { Metadata } from 'next'
 
export const metadata: Metadata = {
  title: 'My Blog',
  description: '...',
}
 
export default function Layout() {}
```

### 实战
总的来说,nextjs包揽了构建和路由,但是状态管理和API调用还是得靠其他的库来实现.
