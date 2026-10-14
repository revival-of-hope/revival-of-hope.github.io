---
title: "运维笔记"
date: 2026-09-07T12:34:42+08:00
description: 运维真的好累~
image: 57793944_p0-浴衣とお面.webp
---
运维的职责相当广泛,所以值得专门来进行学习,为了方便写文章,我把所有能跟运维扯上关系的技术都放进来了.
# 运维工具年表
|       年份 | 工具／项目                                                                        | 主要领域           | 适用范围                                    | 2026年活跃度     |
| ---------: | --------------------------------------------------------------------------------- | ------------------ | ------------------------------------------- | ---------------- |
|       1979 | [cron](https://man7.org/linux/man-pages/man8/cron.8.html)                         | 定时任务           | Unix/Linux 单机定时执行脚本和命令           | 🔥 基础设施级     |
|       1980 | [syslog](https://www.rfc-editor.org/rfc/rfc5424)                                  | 系统日志           | 主机、应用、网络设备和集中日志服务器        | 🔥 基础设施级     |
|       1993 | [CFEngine](https://docs.cfengine.com/docs/lts/overview/what-is-cfengine-and-why/) | 配置管理           | 大规模 Unix/Linux 主机群                    | ◐ 传统企业环境   |
|       1995 | [SSH／OpenSSH](https://www.openssh.com/history.html)                              | 远程管理           | 服务器、Unix/Linux 和网络设备               | 🔥 基础设施级     |
|       1996 | [rsync](https://rsync.samba.org/)                                                 | 文件同步、备份     | 主机间文件分发、镜像和增量备份              | ● 成熟稳定       |
|       1999 | [Nagios（原NetSaint）](https://www.nagios.org/about/history/)                     | 基础设施监控       | 主机、端口、服务和网络设备                  | ◐ 传统环境常见   |
|       2001 | [Zabbix](https://www.zabbix.com/)                                                 | 综合监控           | 服务器、网络、数据库、应用和虚拟化平台      | 🔥 主流活跃       |
|       2003 | [Splunk](https://www.splunk.com/en_us/about-splunk.html)                          | 日志分析、SIEM     | 企业日志、机器数据、安全审计和故障分析      | 🔥 商用主流       |
|       2005 | [Puppet](https://www.puppet.com/docs/puppet/8/puppet_overview.html)               | 配置管理           | 长生命周期服务器和企业主机群                | ● 稳定，热度下降 |
| 2005／2011 | [Hudson／Jenkins](https://www.jenkins.io/project/)                                | CI/CD              | 软件构建、测试、发布和运维流水线            | 🔥 广泛使用       |
|       2008 | [Graphite](https://graphiteapp.org/overview.html)                                 | 指标监控           | 应用指标和服务器时间序列数据                | ◐ 以存量系统为主 |
|       2009 | [Chef](https://docs.chef.io/chef_overview/)                                       | 配置管理           | 企业服务器、软件部署和合规管理              | ● 企业存量较多   |
|  2009—2011 | [ELK／Elastic Stack](https://www.elastic.co/elastic-stack)                        | 日志采集与搜索     | 集中日志、全文检索、故障分析和安全分析      | 🔥 主流活跃       |
|       2010 | [systemd](https://systemd.io/)                                                    | 服务和主机管理     | 现代 Linux 的启动、服务、日志和定时任务管理 | 🔥 Linux基础设施  |
|       2011 | [Salt](https://docs.saltproject.io/)                                              | 配置管理、远程执行 | 大规模服务器配置、命令执行和事件自动化      | ● 稳定活跃       |
| 2011／2015 | [Fluentd／Fluent Bit](https://www.fluentd.org/architecture)                       | 日志和遥测管道     | 云原生、服务器、容器和边缘设备              | 🔥 云原生日志主流 |
|       2012 | [Ansible](https://docs.ansible.com/)                                              | 配置、部署、编排   | Linux、Windows、网络设备和云资源            | 🔥 主流活跃       |
|       2012 | [Prometheus](https://prometheus.io/docs/introduction/overview/)                   | 指标监控、告警     | 微服务、容器和Kubernetes集群                | 🔥 云原生标准     |
|       2013 | [Docker](https://www.docker.com/blog/docker-11-year-anniversary/)                 | 容器、应用交付     | 开发环境、服务器、CI和微服务                | 🔥 基础设施级     |
|       2014 | [Grafana](https://grafana.com/blog/4-years-of-grafana/)                           | 数据可视化、告警   | 指标、日志、追踪和数据库仪表盘              | 🔥 主流活跃       |
|       2014 | [Terraform](https://developer.hashicorp.com/terraform/intro)                      | 基础设施即代码     | 公有云、私有云、SaaS和Kubernetes资源        | 🔥 IaC主流        |
|       2014 | [Kubernetes](https://kubernetes.io/blog/2024/06/06/10-years-of-kubernetes/)       | 容器编排           | 大规模容器集群、微服务和云原生平台          | 🔥 云原生基础设施 |



2015年之后:

|       年份 | 工具／项目                                                                                        | 主要领域             | 适用范围                               | 2026年活跃度     |
| ---------: | ------------------------------------------------------------------------------------------------- | -------------------- | -------------------------------------- | ---------------- |
|       2015 | [Vault](https://developer.hashicorp.com/vault/docs)                                               | 密钥与身份管理       | 数据库凭证、证书、云账号和应用密钥     | 🔥 主流活跃       |
|       2015 | [Cilium](https://docs.cilium.io/en/stable/overview/intro/)                                        | 容器网络、安全、观测 | Kubernetes、Linux主机和服务网格        | 🔥 高度活跃       |
| 2015／2016 | [Helm](https://helm.sh/docs/)                                                                     | Kubernetes包管理     | Kubernetes应用安装、升级和回滚         | 🔥 Kubernetes标配 |
|       2016 | [Flux](https://fluxcd.io/blog/2022/11/flux-is-a-cncf-graduated-project/)                          | GitOps持续交付       | Kubernetes配置和应用部署               | 🔥 主流活跃       |
|       2018 | [Argo CD](https://argo-cd.readthedocs.io/)                                                        | GitOps持续交付       | 单集群、多集群和大规模应用部署         | 🔥 GitOps主流     |
|       2018 | [Grafana Loki](https://grafana.com/docs/loki/latest/get-started/overview/)                        | 云原生日志           | Kubernetes、容器和微服务日志           | 🔥 主流活跃       |
|       2018 | [Pulumi](https://www.pulumi.com/docs/iac/)                                                        | 基础设施即代码       | 云资源、Kubernetes和SaaS服务           | ● 稳定增长       |
|       2018 | [Crossplane](https://docs.crossplane.io/latest/)                                                  | 云资源控制平面       | 通过Kubernetes管理数据库、网络和云服务 | ● 平台工程常见   |
|       2019 | [OpenTelemetry](https://opentelemetry.io/docs/what-is-opentelemetry/)                             | 可观测性标准         | 指标、日志、分布式追踪和应用埋点       | 🔥 行业标准       |
|       2019 | [GitHub Actions](https://github.blog/changelog/2019-11-11-github-actions-is-generally-available/) | CI/CD、仓库自动化    | GitHub项目构建、测试、发布和自动化任务 | 🔥 主流活跃       |
|       2021 | [Karpenter](https://karpenter.sh/docs/)                                                           | Kubernetes节点管理   | 弹性云Kubernetes集群和节点成本优化     | 🔥 快速普及       |
|       2022 | [Dagger](https://dagger.io/blog/public-launch-announcement/)                                      | 可移植CI/CD          | 本地开发、不同CI平台和容器构建         | ● 成长期         |
|       2022 | [Tetragon](https://tetragon.io/docs/)                                                             | 运行时安全、可观测性 | Kubernetes、容器和Linux主机            | ● 快速增长       |
|       2023 | [OpenTofu](https://opentofu.org/blog/opentofu-announces-fork-of-terraform/)                       | 开源基础设施即代码   | Terraform替代、云资源和SaaS资源管理    | 🔥 快速增长       |
|       2023 | [OpenBao](https://openbao.org/blog/cipherboy-ossna-26-talk/)                                      | 开源密钥管理         |                                        |                  |
# 容器,服务器与虚拟机
## 常用知识
### 主流服务器厂商和类型
### IP地址分配
## Linux命令
### 常用命令
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


### 学习资料
- [在线学习](https://cmdchallenge.com/#/move_file)
### 学习方法
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


## 主流指令集架构汇总
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

## 主流Linux发行版
| 发行版            | 所属家族           | 开发主体 / 背景           | 包管理体系   | 主要定位                 |
| :---------------- | :----------------- | :------------------------ | :----------- | :----------------------- |
| **Debian**        | Debian 系          | Debian 社区               | APT / dpkg   | 通用系统、服务器、稳定性 |
| **Ubuntu**        | Debian 系          | Canonical + 社区          | APT / dpkg   | 桌面、开发、云服务器     |
| **Linux Mint**    | Ubuntu / Debian 系 | Mint 团队                 | APT / dpkg   | 桌面、Windows 用户迁移   |
| **Kali Linux**    | Debian 系          | OffSec                    | APT / dpkg   | 网络安全、渗透测试       |
| **Fedora**        | Red Hat 系         | Fedora 社区、Red Hat 参与 | DNF / RPM    | 新技术、开发者桌面       |
| **RHEL**          | Red Hat 系         | Red Hat                   | DNF / RPM    | 企业服务器、商业支持     |
| **CentOS Stream** | Red Hat 系         | CentOS 社区、Red Hat      | DNF / RPM    | RHEL 上游开发、测试      |
| **Rocky Linux**   | RHEL 兼容生态      | Rocky 社区                | DNF / RPM    | 企业服务器、RHEL 兼容    |
| **AlmaLinux**     | RHEL 兼容生态      | AlmaLinux 基金会          | DNF / RPM    | 企业服务器、RHEL 兼容    |
| **openSUSE**      | SUSE 系            | openSUSE 社区             | Zypper / RPM | 桌面、服务器             |
| **SLES**          | SUSE 系            | SUSE                      | Zypper / RPM | 企业服务器、商业支持     |
| **Arch Linux**    | Arch 系            | Arch 社区                 | Pacman       | 滚动更新、高度自定义     |
| **Manjaro**       | Arch 系            | Manjaro 团队              | Pacman       | 更易上手的 Arch 衍生版   |
| **Alpine Linux**  | 独立发行版         | Alpine 社区               | APK          | 轻量容器、最小化系统     |
| **Gentoo**        | 独立发行版         | Gentoo 社区               | Portage      | 源码构建、高度定制       |
| **NixOS**         | 独立发行版         | NixOS 社区                | Nix          | 声明式配置、可复现系统   |

其中,最需要了解的就是各个派系的包管理工具了,毕竟`sudo apt update`很有可能是你进入新系统后运行的第一条命令:
1. Debian系: apt高级命令和dpkg底层命令,`apt-get`则是一个脚本命令,对应的安装包后缀为`.deb`
2. Red Hat系: dnf高级命令和早期的yum高级命令,对应的安装包后缀为`.rpm`
3. Arch系: pacman
4. Apline专用: apk

### Debian系操作
| 命令               | 实际作用             | 会更新已安装的软件吗？ |
| :----------------- | :------------------- | :--------------------- |
| `sudo apt update`  | 更新本地的软件包索引 | 不会                   |
| `sudo apt upgrade` | 升级已安装的软件包   | 会                     |

![时间线示例](PixPin_2026-10-11_10-49-51.webp)


## 操作系统年表
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


# 部署
## git
推荐阅读: Pro git
## GitHub 
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
### GitHub Actions
推荐阅读: GitHub Actions in action
## 实践
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
# 跨平台构建工具
## 总表
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
## 桌面端
### Electron
#### 介绍
- [wiki](https://en.wikipedia.org/wiki/Electron_(software_framework))

Electron是由Github在13年发布的开源打包框架,可以把你的前端应用变成桌面端上的应用程序,著名的应用有VScode,Github Desktop等

缺点是更新太快,但社区活力不够,截止发布了v43版本的当下,官网的文档还是用的22年11月发布的v23版本,这版本号都翻倍了,而且文档里用的还是CommonJS,你就说这怎么看.
#### 基本架构
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

## 手机端
### Capacitor


## 多端
### Tauri
#### 介绍
-[wiki](https://en.wikipedia.org/wiki/Tauri_(software_framework))

Tauri是于20年发布的构建工具,支持所有主流桌面和移动平台,比起Electron更加有活力,但由于技术栈比较新,所以基本没有大公司会有Tauri来构建应用.
#### 基本架构
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
### React Native
#### 介绍
- [wiki](https://en.wikipedia.org/wiki/React_Native)

React Native由Facebook于15年发布的多平台(除了Linux)打包框架.

### Flutter

# 可观测性



