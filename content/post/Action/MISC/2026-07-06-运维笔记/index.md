---
title: "运维笔记"
date: 2026-07-20T12:34:42+08:00
description: 
image: 57793944_p0-浴衣とお面.webp
math: 
draft: true
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

# 容器
## Docker 
推荐阅读: [Docker 从入门到实践](https://yeasy.gitbook.io/docker_practice)
# 自动部署与自动构建
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

在hexo上的效果如下:
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

# 监控与日志
## Sentry

