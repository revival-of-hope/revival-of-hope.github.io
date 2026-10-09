---
title: "数据库和架构笔记"
date: 2026-08-18T11:04:38+08:00
description: 
image: 67994520_p0-沖田総司.webp
---
## 软件架构与建模理论
### 时间线


| 时间                  | 名称 / 概念                                             | 所属类别     | 核心作用                                              |
| --------------------- | ------------------------------------------------------- | ------------ | ----------------------------------------------------- |
| 1970年代              | DFD · Data Flow Diagram<br>数据流图                     | 建模语言     | 描述数据流转、处理过程及存储关系                      |
| 1976                  | ER Model / ERD<br>实体关系模型                          | 数据建模     | 描述数据库实体、属性及关系                            |
| 1987                  | Zachman Framework<br>扎克曼框架                         | 企业架构     | 通过不同视角与维度组织企业架构                        |
| 1987                  | Statecharts<br>状态图                                   | 行为建模     | 建模复杂系统的状态与状态转换                          |
| 1980年代末—1990年代初 | Graphviz / DOT<br>图形描述语言                          | 绘图工具     | 用文本定义节点与关系，自动生成图形                    |
| 1991                  | OMT · Object Modeling Technique<br>对象建模技术         | 面向对象建模 | UML 的重要前身之一                                    |
| 1992—1993             | Software Architecture<br>软件架构理论                   | 理论基础     | 系统研究组件、连接器与架构风格                        |
| 1994                  | SAAM<br>软件架构分析方法                                | 架构评估     | 利用场景分析软件架构质量                              |
| 1995                  | 4+1 View Model<br>4+1 架构视图模型                      | 架构描述     | 通过逻辑、进程、开发、物理视图及场景描述系统          |
| 1995                  | Siemens Four View Model<br>西门子四视图模型             | 架构描述     | 以概念、模块、执行、代码四个视图描述架构              |
| 1995                  | RM-ODP<br>开放分布式处理参考模型                        | 架构标准     | 通过五种视点描述分布式系统                            |
| 1995                  | TOGAF<br>开放组架构框架                                 | 企业架构     | 规范企业架构规划、设计与治理                          |
| 1990年代              | ADL · Architecture Description Language<br>架构描述语言 | 语言类别     | 形式化描述架构元素、关系和约束                        |
| 1997                  | UML · Unified Modeling Language<br>统一建模语言         | 建模标准     | 统一类图、时序图、活动图等建模记法                    |
| 1997年前后            | Acme ADL<br>架构描述语言                                | 建模语言     | 支持架构表示及不同架构工具间的数据交换                |
| 1998                  | ATAM<br>架构权衡分析方法                                | 架构评估     | 分析性能、安全、可维护性等质量属性间的权衡            |
| 2000                  | IEEE 1471<br>软件密集型系统架构描述标准                 | 架构标准     | 确立利益相关者、关注点、视点和视图等核心概念          |
| 2001                  | MDA · Model Driven Architecture<br>模型驱动架构         | 开发方法     | 利用平台无关模型与平台特定模型驱动开发                |
| 2002                  | Views and Beyond<br>多视图架构文档方法                  | 架构文档     | 根据实际关注点组织和记录架构视图                      |
| 2003                  | DDD · Domain-Driven Design<br>领域驱动设计              | 软件设计     | 以领域模型、聚合与限界上下文组织复杂业务              |
| 2004                  | BPMN<br>业务流程模型与标记法                            | 建模标准     | 统一描述业务流程、事件、活动和网关                    |
| 2004                  | ArchiMate（早期版本）<br>企业架构建模语言               | 企业架构     | 关联业务、应用与技术架构                              |
| 2004                  | AADL<br>架构分析与设计语言                              | 建模语言     | 建模实时系统、嵌入式系统及性能关键系统                |
| 2005                  | arc42<br>软件架构文档模板                               | 架构文档     | 规范架构背景、构建块、运行时、部署与决策等内容        |
| 2005                  | Viewpoints and Perspectives<br>架构视点与质量属性视角   | 架构描述     | 结合系统视点与跨视图质量属性分析                      |
| 2005                  | Hexagonal Architecture<br>六边形架构 / Ports & Adapters | 架构模式     | 通过端口和适配器隔离业务逻辑与外部依赖                |
| 2006                  | ADD 2.0<br>属性驱动设计方法                             | 架构设计     | 根据质量属性要求逐步形成架构方案                      |
| 2007                  | SysML 1.0<br>系统建模语言                               | 建模标准     | 描述复杂软硬件系统的需求、结构和行为                  |
| 2008                  | Onion Architecture<br>洋葱架构                          | 架构模式     | 围绕领域核心组织代码及依赖方向                        |
| 2009                  | PlantUML<br>文本式 UML 绘图工具                         | 绘图工具     | 通过 DSL 生成 UML 和软件架构图                        |
| 2009                  | ArchiMate 1.0<br>The Open Group 正式标准                | 企业架构标准 | 标准化企业架构描述和跨层关系                          |
| 2011                  | C4 Model<br>四层软件架构可视化模型                      | 架构描述     | 通过 Context、Container、Component、Code 分层展示系统 |
| 2011                  | ADR · Architecture Decision Record<br>架构决策记录      | 架构文档     | 记录架构决策的背景、理由和影响                        |
| 2011                  | ISO/IEC/IEEE 42010:2011<br>架构描述国际标准             | 架构标准     | 统一架构描述的概念与实践规范                          |
| 2012                  | Clean Architecture<br>整洁架构                          | 架构模式     | 通过依赖规则保护核心业务逻辑                          |
| 2013                  | EventStorming<br>事件风暴                               | 协作建模     | 利用领域事件探索业务流程与领域边界                    |
| 2014                  | Mermaid<br>文本式图表绘制工具                           | 绘图工具     | 通过文本生成流程图、时序图和类图                      |
| 2014                  | Microservices<br>微服务架构的重要传播节点               | 架构风格     | 围绕业务能力构建可独立部署的服务                      |
| 2010年代中期          | Structurizr<br>基于模型的 C4 架构工具                   | 建模工具     | 通过单一架构模型生成并维护多种架构视图                |
| 2017                  | UAF 1.0<br>统一架构框架                                 | 架构标准     | 为复杂企业和系统之系统提供统一建模框架                |
| 2010年代后期          | C4-PlantUML<br>C4 专用 PlantUML 图库                    | 绘图工具     | 使用 PlantUML 语法绘制 C4 架构图                      |
| 2019                  | Team Topologies<br>团队拓扑模型                         | 组织设计     | 通过团队类型与交互模式协调组织和架构                  |
| 2020                  | Diagrams（Python）<br>Python 架构绘图库                 | 绘图工具     | 以 Python 代码生成云基础设施和系统架构图              |
| 2022                  | D2<br>声明式图表语言                                    | 绘图工具     | 通过简洁文本及自动布局生成技术图                      |
| 2020年代              | LikeC4<br>可定制的 C4 风格建模工具                      | 建模工具     | 通过声明式模型创建可导航的架构视图                    |
| 2025                  | SysML v2<br>第二代系统建模语言                          | 建模标准     | 强化形式化语义、文本建模及模型互操作                  |



## 心得
### DBMS年表
|   年份 | DBMS／节点                                                                                            | 类型与适用范围                           | 主要索引／存储结构                                 | 当前活跃度                 |
| -----: | ----------------------------------------------------------------------------------------------------- | ---------------------------------------- | -------------------------------------------------- | -------------------------- |
| 约1963 | [IDS](https://computerhistory.org/profile/charles-w-bachman/)                                         | 早期网状数据库；大型机、制造业数据处理   | 指针链、记录集合、导航式访问                       | △ 历史                     |
|   1968 | [IBM IMS](https://www.ibm.com/history/information-management-system)                                  | 层次数据库；银行、电信、大型机高可靠事务 | 层次树、路径访问、二级索引                         | ◐ 仍在大型机核心系统中使用 |
|   1973 | Ingres                                                                                                | 研究型关系库，后来商业化为 Actian X      | ISAM、B-tree、Hash                                 | ◐ 稳定、小众               |
|   1975 | IBM System R                                                                                          | 研究型关系库；验证 SQL、查询优化器       | B-tree、基于代价的查询计划                         | △ 项目结束，影响深远       |
|   1979 | [Oracle V2](https://www.oracle.com/database/50-years-relational-database/)                            | 首批商用 SQL RDBMS；企业 OLTP            | B-tree；后续加入 Bitmap、函数索引等                | 🔥 Oracle Database仍旺盛    |
|   1981 | IBM SQL/DS                                                                                            | IBM首个商用关系数据库产品；大型机        | B-tree                                             | △ 被后续产品继承           |
|   1983 | [IBM Db2](https://www.ibm.com/history/relational-database)                                            | 企业 OLTP、主机数据库、数据仓库          | B-tree；后续有列存储、分区和多维聚簇               | ● 活跃                     |
|   1984 | Teradata DBC/1012                                                                                     | MPP并行数据仓库、大规模分析              | Hash主索引、二级索引、Join Index                   | ● 成熟活跃                 |
|   1986 | [POSTGRES项目](https://www.postgresql.org/docs/current/history.html)                                  | 对象关系研究；PostgreSQL前身             | 可扩展索引、B-tree、R-tree等                       | △ 已演变为PostgreSQL       |
|   1987 | Sybase SQL Server／SAP ASE                                                                            | 客户端—服务器 OLTP；金融、电信           | 聚簇／非聚簇B-tree                                 | ◐ 稳定维护、市场收缩       |
|   1989 | [Microsoft SQL Server 1.0](https://learn.microsoft.com/en-us/shows/history/history-of-microsoft-1989) | 企业 OLTP、报表、微软技术栈              | 聚簇／非聚簇B-tree、列存、全文倒排                 | 🔥 旺盛                     |
|   1995 | [MySQL](https://dev.mysql.com/doc/refman/5.7/en/history.html)                                         | Web应用、中小型及大型 OLTP               | InnoDB聚簇B-tree、二级B-tree、全文倒排、空间R-tree | 🔥 旺盛                     |
|   1996 | [PostgreSQL](https://www.postgresql.org/docs/current/history.html)                                    | 通用关系库；复杂 SQL、GIS、扩展开发      | B-tree、Hash、GiST、SP-GiST、GIN、BRIN             | 🔥 旺盛                     |

20年之后:

|     年份 | DBMS                                                                                                          | 类型与适用范围                               | 主要索引／存储结构                                 | 当前活跃度            |
| -------: | ------------------------------------------------------------------------------------------------------------- | -------------------------------------------- | -------------------------------------------------- | --------------------- |
|     2000 | [SQLite](https://sqlite.org/hctree/dir?ci=e651ea3110aa726e)                                                   | 嵌入式关系库；手机、桌面软件、单机服务       | B-tree、FTS倒排、R-tree                            | 🔥 极其活跃、应用极广  |
|     2005 | Apache CouchDB                                                                                                | 文档数据库；离线同步、HTTP应用               | 追加式B-tree、MapReduce视图索引                    | ◐ 稳定                |
|     2007 | Apache HBase                                                                                                  | 宽列数据库；Hadoop生态、海量稀疏数据         | LSM、MemStore、HFile、Bloom Filter                 | ● 成熟活跃            |
|     2008 | Apache Cassandra                                                                                              | 宽列分布式库；高写入、多地域、高可用         | LSM、MemTable、SSTable、Bloom、SAI/Trie            | ● 活跃                |
|     2009 | [MongoDB](https://www.mongodb.com/company/our-story)                                                          | 文档数据库；内容、产品目录、快速迭代应用     | B-tree、文本倒排、地理与向量索引                   | 🔥 旺盛                |
|     2009 | [Redis](https://redis.io/blog/redis-then-and-now-adapting-with-developers-through-every-era/)                 | 内存键值／数据结构库；缓存、会话、排行榜     | Hash表、跳表、Radix Tree；搜索模块含倒排/HNSW      | 🔥 Redis与Valkey双生态 |
|     2009 | [MariaDB](https://mariadb.org/en/)                                                                            | MySQL分支；Web OLTP、MySQL替代               | InnoDB系B-tree、全文、空间索引                     | ● 活跃                |
|     2010 | [Neo4j 1.0](https://neo4j.com/blog/news/neo4j-1-0-released/)                                                  | 图数据库；关系网络、风控、知识图谱           | 原生图邻接；Range、全文、Point、Vector索引         | ● 活跃                |
|     2010 | [Elasticsearch](https://www.elastic.co/blog/licensing-change)                                                 | 搜索与分析；日志、全文检索、可观测性         | Lucene倒排、BKD Tree、Doc Values、HNSW             | 🔥 旺盛                |
|     2010 | [OceanBase项目](https://oceanbase.github.io/)                                                                 | 分布式关系库；金融、电商、HTAP               | LSM、MemTable、SSTable、Bloom Filter               | ● 成熟活跃            |
|     2011 | SAP HANA 1.0                                                                                                  | 内存列式数据库；ERP、实时分析、HTAP          | 字典编码列存、倒排和值索引                         | ● 活跃                |
|     2012 | Amazon DynamoDB                                                                                               | 托管键值／文档库；Serverless、高并发服务     | 分区键、排序键、GSI、LSI；底层实现不公开           | 🔥 旺盛                |
|     2012 | Snowflake项目                                                                                                 | 云数据仓库；BI、数据共享、弹性分析           | 微分区元数据裁剪、聚簇键、Search Access Path       | 🔥 旺盛                |
|     2013 | InfluxDB                                                                                                      | 时序数据库；监控、IoT、指标                  | TSM/TSI；新架构转向Parquet及列统计                 | ● 活跃、架构换代中    |
|     2013 | FoundationDB                                                                                                  | 有序分布式KV；作为其他数据库的事务底座       | 有序键区间；Redwood B-tree等，存储引擎持续演进     | ● 活跃但偏基础设施    |
|     2016 | [ClickHouse开源](https://clickhouse.com/blog/open-source-10)                                                  | 列式 OLAP；日志、实时分析、可观测性          | 稀疏主索引、MinMax、Bloom、跳数索引、倒排/向量索引 | 🔥 旺盛                |
|     2017 | [Apache Doris开源](https://doris.apache.org/docs/3.x/gettingStarted/what-is-apache-doris/)                    | MPP实时分析、数据仓库、湖仓查询              | Prefix、ZoneMap、Bloom、倒排、Bitmap               | 🔥 旺盛                |
|     2017 | [Google Cloud Spanner GA](https://cloud.google.com/blog/products/gcp/cloud-natural-language-api-enters-beta/) | 全球分布式关系库；强一致、多地域 OLTP        | 有序主键区间、二级索引；内部结构专有               | ● 活跃                |
|     2017 | [CockroachDB 1.0](https://www.cockroachlabs.com/blog/cockroachdb-1-0-release/)                                | 分布式 SQL；跨地域、云原生 OLTP              | Pebble LSM、MVCC、逻辑二级及倒排索引               | ● 活跃                |
|     2017 | [TiDB 1.0](https://docs.pingcap.com/tidb/stable/release-1.0-ga/)                                              | MySQL兼容分布式 SQL、HTAP                    | TiKV/RocksDB LSM、KV编码二级索引、TiFlash列存      | ● 活跃                |
|     2018 | [YugabyteDB 1.0](https://www.yugabyte.com/blog/announcing-yugabyte-db-1-0/)                                   | PostgreSQL兼容分布式 SQL、多地域事务         | DocDB/RocksDB LSM、分布式二级索引                  | ● 活跃                |
| 2018／19 | [DuckDB](https://duckdb.org/history/)                                                                         | 嵌入式 OLAP；本地数据分析、Parquet、Python/R | 自动Zone Map、ART自适应基数树                      | 🔥 2020年代增长极快    |
|     2019 | [Milvus开源](https://milvus.io/blog/journey-to-35k-github-stars-story-of-building-milvus-from-scratch.md)     | 分布式向量数据库；推荐、图像和RAG检索        | IVF、HNSW、DiskANN、PQ/SQ量化                      | 🔥 旺盛                |


### 数据库架构问题(26/8/18)
DBMS的诞生是程序员的福音,但也是各类生产事故的来源,从早期的关系数据库,迈步到MongoDB等文档数据库,再到焕发新生的NoSQL数据库,数据库的架构一直在演进,但我们却始终找不到一个可靠的方案去一次性解决所有的问题,我们只有一个万无一失的口诀: `It depends`.

不过,我们还是要思考一下,为什么数据库架构会这么难处理:

1. 对于初创公司来说,光是配置一个云服务器就够了,毕竟几千几万的用户量也不太需要有什么额外的考量.至于选什么数据库倒是无所谓,看你主要存储的数据类型就行了.

![示意图](PixPin_2026-08-18_22-51-54.webp)

2. 当用户增长到百万级之后,光是一个服务器就不够用了,这时候你可能说,那我们可以把数据拆分后放到多个数据库中,这时候就有个非常关键的问题了,如果还用的是关系型数据库,一般来说用SQL的话只能对单个数据库起作用,一个容易想到的方法是在后端中通过条件判断来分流,将1-100万的用户id分配到第一个数据库里,依次类推,当然,更好的方法是将不同类型的数据分到各个数据库中,这样操作起来也更有针对性
3. 显然,这种硬编码维护起来非常麻烦,用起来也有问题,当我想要一次性获取所有用户的信息用于数据统计时,这又该怎么办?只能单独写一个函数去逐个遍历所有数据库了吧.
4. 但是这又有一个问题,数据库分流后不可避免地会拖慢查询速度,毕竟大多数流量都来自于`Select`请求而非`Update Table`请求,这样一来,我们必须在数据库前面套一层Redis缓存,存储先前传来的完全相同的请求结果.
5. 如此一来又引入了缓存一致性问题,当你更新数据库的时候如果没能更新缓存的话,用户获取的就仍然是旧的数据,这在很多时候都会有灾难性的影响,特别是转账等常见的交易环节.

这一过程可以不断递推下去,每次的扩展都会引入新的问题,可以说永远不会完结,这不像房地产行业,交付了新房后直接走人即可,将维护问题丢给物业,而是需要持续不断地调整架构,**软件工程永远都是进行时**

### 数据库原理(9/7)
考虑一下,从存储数据到执行查询时返回数据,到底发生了什么?

对于绝大部分的DBMS来说,数据都是存储在磁盘中的,每个DBMS都会设计出一种独特的文件格式,用来存储数据表的结构和用户数据.至于具体是什么格式,就得详细去学习了

SQL指令由DBMS的查询引擎负责执行,先经过一些初步的优化,比如调整指令顺序,简化外连接等.如果我们的指令是涉及所有用户的,那么无论怎么优化都还是快不起来,毕竟数据量有这么大,都需要从头到尾扫描一遍.

但99.999%的情况都是执行特定用户的查询,比如访问用户主页,获取好友关系,这些指令只需要找到特定的那个用户就可以了如执行`select * from user where user.name == "Mike Junior"`,这种命令还从头到尾扫描一遍也太蠢了,好在所有的DBMS都支持对数据库建立索引(index),索引一般为B+树,LSM树等结构,可以在极短的时间内确定对应用户所在的磁盘区块位置,接着返回结果.

>如果是聚簇索引(可以理解为主键索引),那么上述过程是没问题的,但如果是二级索引(辅助索引),那么这个索引只是存储了对应的主键位置(通常是id),查询引擎还需要在去查询一遍id列才能找到真正的磁盘位置,这被称为回表.

上述的过程仅仅是在DBMS上执行SQL指令的流程,但我们的应用程序都是间接执行SQL指令的,无论是ORM还是`Raw SQL`,终归是要先连接(connect)到DBMS,将SQL指令传输给DBMS执行,至于怎么连接的,尽管可以分为本地连接和远程连接两种,但实质上基本都是通过TCP连接到DBMS的,应用程序会连接到DBMS开放的URL端口上,如PostgreSQL中的网址格式为:
```toml
DATABASE_URL = postgresql://postgres:123456@db:5432/app
```
上述格式拆解如下:
```toml
POSTGRES_SERVER=db
POSTGRES_PORT=5432
POSTGRES_DB=app
POSTGRES_USER=postgres
POSTGRES_PASSWORD=123456
```

即:
```text
postgresql://用户名:密码@服务器地址:端口/数据库名
             │     │       │       │       │
          postgres 123456   db     5432  my_chat_db
```

### 数据结构
学习数据库最重要的其实是用来构造索引的数据结构,而至于底层的详细存储形式我们不是很有必要了解,不仅是因为非常枯燥,而且就算这一块出了问题我们也解决不了,但索引不一样,索引构造得当可以大幅度加快查询/更新的速率.

常见的数据结构有以下几种,按照出现的时间顺序排列:
1. 倒排索引,不是记录“每篇文档有哪些词”，而是记录“每个词出现在哪些文档里”: Lucene及Elasticsearch
2. 哈希表: Redis
3. B树,和B-树是一个东西,英文名是`B-tree`,至于为什么有些人叫做`B减树`我就不理解了,这也给我一开始学习的时候带来了一点误导: Oracle,SQLite,MongoDB,MySQL,这些常用的数据库都使用B树或者B+树(用的更多)来作为索引
4. 跳表: Redis ZSet,LevelDB
5. LSM树: LevelDB

上面5种可以涵盖所有的常见数据库.
### 一招鲜(10/6)
现在想到,从网站开发到底层架构,一切都可以用两个模型来解释,Server 和 Client.

Client负责提要求,Server负责完成要求;Client负责发送消息,Server负责接收消息,这可以直接涵盖以下的所有情况:
1. 网站/APP开发的前端用户交互和后端API
2. 消息队列的Client和Server
3. 数据库的客户端负责接收和包装用户操作,执行引擎负责执行该操作
4. Nginx的客户端负责接收流量,Server负责反代流量
5. Docker的客户端负责接受用户命令如`docker ps`,服务端负责管理,值得注意的是,这还是通过REST实现通信的
6. Root用户向Linux内核发送请求,内核负责与文件系统和磁盘交互.

再列举下去就没完没了了,不过这个模型建立其实是一个水到渠成的过程,当服务很简单时,我们甚至可以塞到一个文件里面,但等规模增大时,我们就需要拆分,但却必须要在拆分得到的两个或者多个服务之间保持沟通,也就是存在数据的流动,那这就存在一个收发的不对等关系,也就可以划分成Client和Server模型.

如此一来,我们对计算机和网络的认识就瞬间变得清晰了,大多数应用都是通过收发消息实现的,如果你只需要用到这个应用,那就只学Client就行,如果需要深入研究甚至开发,那么就要学习Server部分,我们平常对某个技术抱有模糊的感觉时,那就是因为你没有关注Server部分的实现.


### 数据存储
使用数据库的时候我们都很好奇,数据都存在了哪里呢,这主要有两种情况:
1. 用一个特殊格式的文件存储在操作系统的文件系统中,这是绝大部分数据库的做法(从SQLite到Elasticsearch都是如此),如此一来,需要获取数据时就要通过文件系统的接口来实现I/O
2. 把数据直接放在内存中,从而摆脱了每次查询都要读取磁盘的麻烦,如Redis和Memcached

至于那些云服务器或者分布式数据库,自然都是存在远程服务器的硬盘之中.

