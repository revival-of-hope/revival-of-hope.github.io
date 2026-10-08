---
title: "新潮技术笔记"
date: 2026-10-06T16:12:35+08:00
description: 学习与借鉴
image: 122896122_p0-黄昏下的樱花.webp
tags: 
    - 调研
---
最近十年的新潮技术层出不穷,但总不能看到一个就发一次文章,所以就单独列一个笔记来记录了.主要收集是那些日常开发都不太可能听过的工具和平台
## Agent相关
### Inspect AI
#### 介绍
一个用于评测大语言模型和 AI Agent 的开源框架，由英国 AI Security Institute（AISI） 和 Meridian Labs 开发

测评代码:
```bash
pip install openai
export OPENAI_API_KEY=your-openai-api-key
inspect eval simpleqa.py --model openai/gpt-4o
```
测评Deepseek:
```bash
pip install inspect-ai openai

export DEEPSEEK_API_KEY=你的key

inspect eval arc.py --model deepseek/deepseek-flash
```

当然,最值得推敲的地方就是测评自己写的Agent了,而且可测评的指标很多,是一个相当不错的Agent测试框架.

### DeepEval

## 架构相关
### Temporal
#### 背景
大约 2000 年代中期，Amazon 正在从大型单体系统逐渐走向大量分布式服务。

Maxim Fateev 当时负责 Amazon 的消息基础设施，其中部分工作后来成为 Amazon SQS 的基础；之后他又参与和领导了 Amazon Simple Workflow Service（SWF） 的开发


有一个问题就是,微服务设计下无法简单的保存前几个服务执行状态,例如支付已经完成了，绝对不能再扣一次钱.

所以**业务流程的执行状态必须被可靠地保存下来**,这也就是Durable Execution（持久化执行）,目标是解决这个问题: `怎么让“代码的业务处理”获得数据库一样的持久性？`

Cadence 可以认为是 Temporal 最直接的前身。Maxim Fateev 和 Samar Abbas两人在 2015 年左右共同创建 Cadence；Cadence 在 Uber 内部三年内发展到超过 100 个使用场景，并于 2017 年开源.

2019 年，Maxim Fateev 和 Samar Abbas 离开 Uber，成立了 Temporal。Temporal 最初直接 fork 自 Cadence，之后逐渐独立发展


### AsyncAPI
#### 背景
尽管普通的微服务可以用OpenAPI解决,但对于消息队列等异步系统来说,一直都没有一个可靠的框架,而AsyncAPI就是基于此问题提出的,它不绑定某一种消息队列.于21年的时候称为了Linux Foundation项目,并开始逐渐成熟

一个示例如下:
```yml
asyncapi: 3.0.0

info:
  title: Order Event API
  version: 1.0.0

servers:
  production:
    host: kafka.example.com:9092
    protocol: kafka

channels:
  orderCreated:
    address: order.created

    messages:
      OrderCreated:
        payload:
          type: object

          properties:
            orderId:
              type: string

            userId:
              type: string

            amount:
              type: number

          required:
            - orderId
            - userId
            - amount

operations:
  publishOrderCreated:
    action: send
    channel:
      $ref: "#/channels/orderCreated"
```

### Apache APISIX


## 构建和库相关
