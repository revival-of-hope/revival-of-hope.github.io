---
title: "Go复刻对话项目"
date: 2026-11-06T08:41:42+08:00
description: 项目2-a
image: 137455166_p0-『adieu』.webp
tags: 
    - PDL
math: 
draft: true
---
>[!NOTE]
>
>目标: 复刻之前的Python栈LLM对话项目,采用Gorm+Gin+Postgres,看情况添加功能.

## ch1: 项目学习
- [项目链接](https://github.com/Caknoooo/go-gin-clean-starter)

该项目的选型为Gin+Gorm+Postgres

Go项目怎么看我确实不太会,但还是先看cmd,再看一下modules里的据说是clean architecure的具体架构.
### main.go
```go
package main

import (
	"log"
	"os"

	"github.com/Caknoooo/go-gin-clean-starter/middlewares"
	"github.com/Caknoooo/go-gin-clean-starter/modules/auth"
	"github.com/Caknoooo/go-gin-clean-starter/modules/user"
	"github.com/Caknoooo/go-gin-clean-starter/providers"
	"github.com/Caknoooo/go-gin-clean-starter/script"
	"github.com/samber/do"

	"github.com/common-nighthawk/go-figure"
	"github.com/gin-gonic/gin"
)

func args(injector *do.Injector) bool {
	if len(os.Args) > 1 {
		flag := script.Commands(injector)
		return flag
	}

	return true
}

func run(server *gin.Engine) {
	server.Static("/assets", "./assets")

	port := os.Getenv("GOLANG_PORT")
	if port == "" {
		port = "8888"
	}

	var serve string
	if os.Getenv("APP_ENV") == "localhost" {
		serve = "0.0.0.0:" + port
	} else {
		serve = ":" + port
	}

	myFigure := figure.NewColorFigure("Caknoo", "", "green", true)
	myFigure.Print()

	if err := server.Run(serve); err != nil {
		log.Fatalf("error running server: %v", err)
	}
}

func main() {
	var (
		injector = do.New()
	)

	providers.RegisterDependencies(injector)

	if !args(injector) {
		return
	}

	server := gin.Default()
	server.Use(middlewares.CORSMiddleware())

	// Register module routes
	user.RegisterRoutes(server, injector)
	auth.RegisterRoutes(server, injector)

	run(server)
}
```
这个参数注入留待最后解决,看一下主函数,注册了gin服务器后,注入了user和auth两个路由,并最终启动.
### user部分
先看路由:

## ch2: User模块实现
