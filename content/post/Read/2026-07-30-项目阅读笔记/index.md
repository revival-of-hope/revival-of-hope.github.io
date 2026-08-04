---
title: "项目阅读笔记"
date: 2026-07-30T15:58:55+08:00
description: 
image: 5290131_p0-空へ.webp
---
## 基础类
### [Redis](https://github.com/redis/redis)
要是一来就冲着最新版本去那还是太高看自己了,所以退而求其次,找个10年前的3.0版本的就行了.
![示意图](PixPin_2026-07-31_11-55-09.webp)

命令如下:
```bash
git clone --branch 3.0 --depth 1 https://github.com/redis/redis.git
```
这样一对比,立刻就赏心悦目了:

![对比图](PixPin_2026-07-31_11-57-10.webp)
使用cloc统计一下源码数量:
![示意图](PixPin_2026-07-31_11-58-06.webp)
简直可以说是小巧得可爱.

### [Cpython](https://github.com/python/cpython)
3.0版本就够用了...
```bash
git clone --branch 3.0 https://github.com/python/cpython.git --depth 1
```
### [FFmpeg](https://github.com/FFmpeg/FFmpeg)
```bash
git clone --branch release/1.0 --depth 1 https://github.com/FFmpeg/FFmpeg.git
```
## Agents
### [AgentGPT](https://github.com/reworkd/AgentGPT)
刚开始看到的时候以为和我的项目撞车了,但后来发现完全不是这样,有以下缺点:
1. 项目在今年1月份被archive了,最近的更新也在1年前,实际来说有两年多没正式维护了
2. python版本为3.11,用的包管理器竟然是poetry,models构建用的是难看的sqlalchemy,对于习惯了sqlmodel写法的我来说看的确实很痛苦.
3. 创建初始表用的是sql,而没用alembic,导致必须要单独弄一个db文件夹出来调整.
4. 由于用的是next13,所以还是pages router写法,看着确实很不适应,也有很多如今不太实用的写法
5. 命名和架构让人看的很难受,现在要想继续维护的唯一方法就是把所有文件删了重写.

我看这个项目倒不是冲着批判来的,重点是看api的写法,不过这也很难说的上有什么可学习的地方了:
```py
router = APIRouter()


@router.post(
    "/start",
)
async def start_tasks(
    req_body: AgentRun = Depends(agent_start_validator),
    agent_service: AgentService = Depends(get_agent_service(agent_start_validator)),
) -> NewTasksResponse:
    new_tasks = await agent_service.start_goal_agent(goal=req_body.goal)
    return NewTasksResponse(newTasks=new_tasks, run_id=req_body.run_id)

# 省略一大堆代码

class ToolModel(BaseModel):
    name: str
    description: str
    color: str
    image_url: Optional[str]


class ToolsResponse(BaseModel):
    tools: List[ToolModel]


@router.get("/tools")
async def get_user_tools() -> ToolsResponse:
    tools = get_external_tools()
    formatted_tools = [
        ToolModel(
            name=get_tool_name(tool),
            description=tool.public_description,
            color="TODO: Change to image of tool",
            image_url=tool.image_url,
        )
        for tool in tools
        if tool.available()
    ]

    return ToolsResponse(tools=formatted_tools)
```
混乱的架构与难以解耦的代码,希望这种事情不要发生在我负责的项目里.
## Games
### [Zdoom](https://zdoom.org/index)
由于GZdoom是手搓的引擎,所以源码不太是正常人能看懂的,这种离谱的硬编码应该很难在现代工程中看到了吧:

![示意图](PixPin_2026-08-03_13-30-03.webp)

尽管代码量不是太离谱,但架构实在是太混乱了:
![代码量](PixPin_2026-08-03_13-31-06.webp)
### [Pypvz](https://github.com/wszqkzqk/pypvz)
- [项目根本来源](https://github.com/marblexu/PythonPlantsVsZombies)

非常有意思的Pvz版本,推荐所有初学python/pygame的人都拿这个项目来练练手,不过这个架构实在是太难看了,如果有时间的话我或许会帮忙重构一下.
## 计算机网络
### trojan
#### 文档阅读
>Trojan features multiple protocols over TLS to avoid both active/passive detections and ISP QoS limitations.
>
>Trojan is not a fixed program or protocol. It's an idea, an idea that imitating the most common service, to an extent that it behaves identically, could help you get across the *** permanently, without being identified ever. We are the GreatER Fire; we ship Trojan Horses.

## 爬虫