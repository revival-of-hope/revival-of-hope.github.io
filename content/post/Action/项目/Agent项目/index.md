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

## ch1: 分层架构项目学习
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
#### 路由
先看路由:
```go
func RegisterRoutes(server *gin.Engine, injector *do.Injector) {
	userController := do.MustInvoke[controller.UserController](injector)
	jwtService := do.MustInvokeNamed[service.JWTService](injector, constants.JWTService)

	userRoutes := server.Group("/api/user")
	{
		userRoutes.GET("", userController.GetAllUser)
		userRoutes.GET("/me", middlewares.Authenticate(jwtService), userController.Me)
		userRoutes.PUT("/:id", middlewares.Authenticate(jwtService), userController.Update)
		userRoutes.DELETE("/:id", middlewares.Authenticate(jwtService), userController.Delete)
	}
}
```
有四个路由:
1. get`""`: 获取用户列表
2. get`"/me"`: 获取用户主页
3. put`"/:id"`: 更新特定用户
4. delete`"/:id"`: 删除特定用户
#### Controller
```go
type (
	UserController interface {
		Me(ctx *gin.Context)
		GetAllUser(ctx *gin.Context)
		Update(ctx *gin.Context)
		Delete(ctx *gin.Context)
	}

	userController struct {
		userService    service.UserService
		userValidation *validation.UserValidation
		db             *gorm.DB
	}
)

func NewUserController(injector *do.Injector, us service.UserService) UserController {
	db := do.MustInvokeNamed[*gorm.DB](injector, constants.DB)
	userValidation := validation.NewUserValidation()
	return &userController{
		userService:    us,
		userValidation: userValidation,
		db:             db,
	}
}

func (c *userController) GetAllUser(ctx *gin.Context) {
	var filter = &query.UserFilter{}
	filter.BindPagination(ctx)

	ctx.ShouldBindQuery(filter)

	users, total, err := pagination.PaginatedQueryWithIncludable[query.User](c.db, filter)
	if err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_GET_USER, err.Error(), nil)
		ctx.JSON(http.StatusBadRequest, res)
		return
	}

	paginationResponse := pagination.CalculatePagination(filter.Pagination, total)
	response := pagination.NewPaginatedResponse(http.StatusOK, dto.MESSAGE_SUCCESS_GET_LIST_USER, users, paginationResponse)
	ctx.JSON(http.StatusOK, response)
}

func (c *userController) Me(ctx *gin.Context) {
	userId := ctx.MustGet("user_id").(string)

	result, err := c.userService.GetUserById(ctx.Request.Context(), userId)
	if err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_GET_USER, err.Error(), nil)
		ctx.JSON(http.StatusBadRequest, res)
		return
	}

	res := utils.BuildResponseSuccess(dto.MESSAGE_SUCCESS_GET_USER, result)
	ctx.JSON(http.StatusOK, res)
}

func (c *userController) Update(ctx *gin.Context) {
	var req dto.UserUpdateRequest
	if err := ctx.ShouldBind(&req); err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_GET_DATA_FROM_BODY, err.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusBadRequest, res)
		return
	}

	if err := c.userValidation.ValidateUserUpdateRequest(req); err != nil {
		res := utils.BuildResponseFailed("Validation failed", err.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusBadRequest, res)
		return
	}

	userId := ctx.MustGet("user_id").(string)
	result, err := c.userService.Update(ctx.Request.Context(), req, userId)
	if err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_UPDATE_USER, err.Error(), nil)
		ctx.JSON(http.StatusBadRequest, res)
		return
	}

	res := utils.BuildResponseSuccess(dto.MESSAGE_SUCCESS_UPDATE_USER, result)
	ctx.JSON(http.StatusOK, res)
}

func (c *userController) Delete(ctx *gin.Context) {
	userId := ctx.MustGet("user_id").(string)

	if err := c.userService.Delete(ctx.Request.Context(), userId); err != nil {
		res := utils.BuildResponseFailed(dto.MESSAGE_FAILED_DELETE_USER, err.Error(), nil)
		ctx.AbortWithStatusJSON(http.StatusBadRequest, res)
		return
	}

	res := utils.BuildResponseSuccess(dto.MESSAGE_SUCCESS_DELETE_USER, nil)
	ctx.JSON(http.StatusOK, res)
}
```
userController结构体实现了UserController的四个路由处理函数.问题在于,代码上不具备任何的可读性,分层是分层了,但是不彻底,彼此都有不少的耦合,更离谱的是引用的第三方pagination库还是同一作者自己写的.
### 总结
对于Go项目来说,过早的引入分层架构就是灾难,可读性实在是太差了.



## ch2: User模块实现
