---
title: "Agent项目"
date: 2026-11-06T08:41:42+08:00
description: 第二个项目
image: 137455166_p0-『adieu』.webp
tags: 
    - 调研
math: 
draft: true
---
>[!NOTE]
>
>目标: 使用Eino开发出一个,根据要求能够智能查找目标GitHub仓库,分析仓库功能得到分析文档,并git clone其中最重要仓库的简易Agent.计划是渲染一个本地网页出来,不需要用户管理,API_KEY内置.

## ch0: 前言
1. 为什么用Eino?
   1. 我需要锻炼Go能力,而Eino是为数不多的Go Agent框架,同时也是测试一下这个字节框架的潜力
2. 市面上已经有DeepWiki,DeepGit这样的成熟产品了,那你为什么还做?
   1. 我做这个主要是出于学习目的,有成熟产品反而就有能够模仿与借鉴的例子了.


## ch1: Eino基础
### 初印象
下载官方示例代码:
```bash
git clone https://github.com/cloudwego/eino-examples.git
```
看一下hello-world:
```go
package main

import (
	"context"
	"fmt"
	"log"
	"os"

	"github.com/cloudwego/eino/adk"
	"github.com/cloudwego/eino/schema"

	"github.com/cloudwego/eino-ext/components/model/openai"
)

func main() {
	ctx := context.Background()

	// 初始化模型
	model, err := openai.NewChatModel(ctx, &openai.ChatModelConfig{
		APIKey:  os.Getenv("OPENAI_API_KEY"),
		Model:   os.Getenv("OPENAI_MODEL"),
		BaseURL: os.Getenv("OPENAI_BASE_URL"),
		ByAzure: func() bool {
			return os.Getenv("OPENAI_BY_AZURE") == "true"
		}(),
	})
	if err != nil {
		log.Fatal(err)
	}

	// 创建 ChatModelAgent
	agent, err := adk.NewChatModelAgent(ctx, &adk.ChatModelAgentConfig{
		Name:        "hello_agent",
		Description: "A friendly greeting assistant",
		Instruction: "You are a friendly assistant. Please respond to the user in a warm tone.",
		Model:       model,
	})
	if err != nil {
		log.Fatal(err)
	}

	// 创建 Runner
	runner := adk.NewRunner(ctx, adk.RunnerConfig{
		Agent:           agent,
		EnableStreaming: true,
	})

	// 执行对话
	input := []adk.Message{
		schema.UserMessage("Hello, please introduce yourself."),
	}

	events := runner.Run(ctx, input)
	for {
		event, ok := events.Next()
		if !ok {
			break
		}

		if event.Err != nil {
			log.Printf("错误: %v", event.Err)
			break
		}

		if msg, err := event.Output.MessageOutput.GetMessage(); err == nil {
			fmt.Printf("Agent: %s\n", msg.Content)
		}
	}
}
```
创建Agent之后,再调用runner并输入用户消息,即可开始流式对话,并且是ReAct模式的.`events.Next()`不断遍历Agent输出,直到Agent输出完毕.

不过示例代码的一个问题在于,这里开启了Stream,但循环中却是获取的单次消息.

查了一下API,发现如果这样的话就是直接关闭Stream,拼接完字符串后完整输出.



### 核心概念
1. Component: 组件,基础单元,如调用LLM的`ChatModel`,封装工具的`Tool`,检索知识库的`Retriever`.
2. `Compose`: 编排组件,支持Chain,Graph,Workflow三种抽象
3. `Flow`: 对常用编排的封装,如RaAct Agent或者Host Multi-Agent,如今较少用
4. ADK: 高层框架,是Flow的上位替代.最重要的两个模块就是Agent,ChatModelAgent

