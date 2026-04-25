---
title: "算法笔记"
date: 2026-04-25T09:55:45+08:00
description: 
image: 
math: 
draft: true
---

# 数据结构
## 栈
## 队列
## 哈希表

# 基础算法
## 复杂度分析

## 二分大法
二分法本身的思想不难,最难的是写`<=`还是`<`的时候.
事实上,二分法总共只有两种写法,一个是左闭右闭,一个是左闭右开,但如果两种方法混着用,很容易就记混了,现场推导或许也可以,但总归是要想一下子的.
故我认为只使用下面一种逻辑算法就行了,因为两端均为闭区间最符合正常人直觉.
```cpp
 while (l <= r) {
      int mid = (l + r) / 2;
      res = findsum(mid);
      if (res >= k)
        l = mid + 1;
      else
        r = mid - 1;
    }
```



## 排序
### 冒泡排序

## 搜索
事实上,翻遍全网,找不到一个真正详尽的入门教程,基本都是丢给你几道算法题的解答就结束了,却从来没有真正的讲明白为什么要这样写
### 到底是用dfs还是bfs?(3/14)
- [参考文章](https://cuijiahua.com/blog/2018/01/alogrithm_10.html)
问ai或者上网查,很容易就知道bfs用来求最短路径,而dfs用来求路径条数,那么,为什么是这样呢?
先概览一下代码:
**dfs**
```cpp
#include <bits/stdc++.h>
using namespace std;

const int MAX = 105;

int n,m;
char g[MAX][MAX];
int vis[MAX][MAX];

int dx[4]={-1,1,0,0};
int dy[4]={0,0,-1,1};

void dfs(int x,int y)
{
    vis[x][y]=1;

    for(int i=0;i<4;i++)
    {
        int nx=x+dx[i];
        int ny=y+dy[i];

        if(nx<1||nx>n||ny<1||ny>m)
            continue;

        if(vis[nx][ny])
            continue;

        if(g[nx][ny]=='#')
            continue;

        dfs(nx,ny);
    }
}

int main()
{
    int sx,sy;

    cin>>n>>m;

    for(int i=1;i<=n;i++)
        for(int j=1;j<=m;j++)
        {
            cin>>g[i][j];
            if(g[i][j]=='S')
                sx=i,sy=j;
        }

    dfs(sx,sy);
}
```
可以看到dfs使用的是层层递归的方式,会一条路走到底,直到没有路可走或者找到答案才返回上一级,处理完后再返回上一级.
换句话说也就是**先进后出**,后来新出现的路径优先处理,这也是栈的工作原理.
所以,dfs的数据结构注定了它不能处理太大深度的复杂搜索,否则栈就很容易溢出.
比如下面这题:
```md
乔治有一些同样长的小木棍，他把这些木棍随意砍成几段，直到每段的长都不超过 50。

现在，他想把小木棍拼接成原来的样子，但是却忘记了自己开始时有多少根木棍和它们的长度。

给出每段小木棍的长度，编程帮他找出原始木棍的最小可能长度。

对于全部测试点，1≤n≤65，1≤a[i]≤50
```


**bfs**
```cpp
#include <bits/stdc++.h>
using namespace std;

const int MAX = 105;

int n,m;
char g[MAX][MAX];
int vis[MAX][MAX];

int dx[4]={-1,1,0,0};
int dy[4]={0,0,-1,1};

struct Node{
    int x;
    int y;
    int step;
};

int bfs(int sx,int sy)
{
    queue<Node> q;

    q.push({sx,sy,0});
    vis[sx][sy]=1;

    while(!q.empty())
    {
        Node cur=q.front();
        q.pop();

        int x=cur.x;
        int y=cur.y;
        int step=cur.step;

        if(g[x][y]=='E')  //终点
            return step;

        for(int i=0;i<4;i++)
        {
            int nx=x+dx[i];
            int ny=y+dy[i];

            if(nx<1||nx>n||ny<1||ny>m)
                continue;

            if(vis[nx][ny])
                continue;

            if(g[nx][ny]=='#') //墙
                continue;

            vis[nx][ny]=1;
            q.push({nx,ny,step+1});
        }
    }

    return -1;
}

int main()
{
    int sx,sy;

    cin>>n>>m;

    for(int i=1;i<=n;i++)
        for(int j=1;j<=m;j++)
        {
            cin>>g[i][j];
            if(g[i][j]=='S')
                sx=i,sy=j;
        }

    cout<<bfs(sx,sy);
}
```
最值得关注的便是bfs使用的是队列来存储要处理的节点,而队列的特点便是先进先出,如果遍历四个方向,那么bfs会依次处理这四个方向之后,再处理下一层的节点,这样依次扩展,直到找到终点.
那么bfs之所以能够找到最短路的原因就很明显了,如果当前层找不到终点,说明终点在下一层,如果找到了终点,说明当前路径就是最好的结果,不用继续找了.

事实上,下面才是更为常见的写法,由于OI选手一般能不写函数就不写,所以刚入门时看到这样的代码是比较难理解bfs的.
```cpp
#include <bits/stdc++.h>
using namespace std;

int main()
{
    const int MAX=105;

    int n,m;
    char g[MAX][MAX];
    int vis[MAX][MAX]={0};

    int dx[4]={-1,1,0,0};
    int dy[4]={0,0,-1,1};

    cin>>n>>m;

    int sx,sy;

    for(int i=1;i<=n;i++)
        for(int j=1;j<=m;j++)
        {
            cin>>g[i][j];
            if(g[i][j]=='S')
                sx=i,sy=j;
        }

    struct Node{
        int x,y,step;
    };

    queue<Node> q;

    q.push({sx,sy,0});
    vis[sx][sy]=1;

    while(!q.empty())
    {
        Node cur=q.front();
        q.pop();

        int x=cur.x;
        int y=cur.y;
        int step=cur.step;

        if(g[x][y]=='E')
        {
            cout<<step;
            break;
        }

        for(int i=0;i<4;i++)
        {
            int nx=x+dx[i];
            int ny=y+dy[i];

            if(nx<1||nx>n||ny<1||ny>m)
                continue;

            if(vis[nx][ny])
                continue;

            if(g[nx][ny]=='#')
                continue;

            vis[nx][ny]=1;
            q.push({nx,ny,step+1});
        }
    }
}
```

### 为什么要写vis数组来标记访问路径?
{% raw %}
<div id="dfs-root" style="position: relative; overflow: hidden; background: #ffffff; border: 1px solid #eee; border-radius: 12px; margin: 2rem 0; padding: 1.5rem; color: #333; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;">
    
    <style>
        /* 针对 Butterfly 的局部隔离样式 */
        #dfs-root button { 
            cursor: pointer; padding: 6px 14px; border-radius: 6px; font-size: 13px; font-weight: 600; 
            margin: 4px; border: 1px solid #e2e8f0; transition: all 0.2s; background: #fff; color: #475569;
        }
        #dfs-root button:hover { border-color: #3b82f6; color: #3b82f6; }
        #dfs-root .active-btn { background: #3b82f6 !important; color: #fff !important; border-color: #2563eb !important; }
        
        #dfs-root .grid-container { 
            display: grid; grid-template-columns: repeat(3, minmax(50px, 70px)); gap: 8px; 
            background-color: #f1f5f9; padding: 10px; border-radius: 8px; width: fit-content; margin: 20px auto;
        }
        #dfs-root .cell { 
            aspect-ratio: 1/1; display: flex; align-items: center; justify-content: center; 
            font-size: 14px; font-weight: bold; border-radius: 4px; border: 1px solid #e2e8f0;
            background: #fff; transition: background 0.1s; 
        }
        #dfs-root .v { background-color: #cbd5e1; color: #64748b; } /* visited */
        #dfs-root .c { background-color: #3b82f6; color: #fff; transform: scale(0.95); } /* current */
        #dfs-root .s { outline: 3px solid #22c55e; outline-offset: -2px; } /* start */
        #dfs-root .e { outline: 3px solid #ef4444; outline-offset: -2px; } /* end */
        
        #dfs-root .console { 
            background: #f8fafc; padding: 12px; border-radius: 6px; font-family: 'Fira Code', monospace;
            font-size: 13px; border-left: 4px solid #3b82f6; min-height: 50px;
        }
    </style>

    <div style="display: flex; flex-wrap: wrap; justify-content: center; margin-bottom: 10px;">
        <button onclick="dfsApp.run('no_mark', this)">1. 无标记 (死循环)</button>
        <button onclick="dfsApp.run('no_unmark', this)">2. 无释放 (遗漏)</button>
        <button onclick="dfsApp.run('correct', this)">3. 标准回溯 (全空间)</button>
    </div>

    <div class="grid-container" id="dfs-grid"></div>

    <div style="display: flex; justify-content: center; gap: 10px; margin-bottom: 15px;">
        <button id="dfs-pause" onclick="dfsApp.togglePause()">暂停</button>
        <button id="dfs-speed" onclick="dfsApp.toggleSpeed()">速度: 常速</button>
    </div>

    <div class="console">
        <div id="dfs-log">系统状态：准备就绪</div>
    </div>
</div>

<script>
var dfsApp = {
    N: 3, vis: [], ans: 0, steps: 0, isRunning: false, isPaused: false, delayMs: 200,
    dx: [0, 1, 0, -1], dy: [1, 0, -1, 0],
    
    sleep: async function() {
        await new Promise(r => setTimeout(r, this.delayMs));
        while (this.isPaused) await new Promise(r => setTimeout(r, 100));
    },

    render: function(cx, cy) {
        const g = document.getElementById('dfs-grid');
        g.innerHTML = '';
        for(let i=0; i<this.N; i++) {
            for(let j=0; j<this.N; j++) {
                const d = document.createElement('div');
                d.className = 'cell';
                if (i === cx && j === cy) d.className += ' c';
                else if (this.vis[i][j]) d.className += ' v';
                if (i === 0 && j === 0) d.className += ' s';
                if (i === this.N-1 && j === this.N-1) d.className += ' e';
                d.innerText = i + ',' + j;
                g.appendChild(d);
            }
        }
        document.getElementById('dfs-log').innerText = "方案数: " + this.ans + " | 当前步数: " + this.steps;
    },

    dfs: async function(x, y, mode) {
        if (!this.isRunning) return;
        this.steps++;
        if (this.steps > 150 && mode === 'no_mark') {
            document.getElementById('dfs-log').innerText = "[崩溃] 检测到死循环，栈已溢出！";
            throw new Error('Stop');
        }
        this.render(x, y);
        await this.sleep();
        if (x === this.N-1 && y === this.N-1) { this.ans++; return; }
        
        for (let i = 0; i < 4; i++) {
            let nx = x + this.dx[i], ny = y + this.dy[i];
            if (nx >= 0 && nx < this.N && ny >= 0 && ny < this.N) {
                if (mode === 'no_mark' || !this.vis[nx][ny]) {
                    if (mode !== 'no_mark') this.vis[nx][ny] = 1;
                    try { await this.dfs(nx, ny, mode); } catch(e) { if(mode==='no_mark') return; }
                    if (mode === 'correct') this.vis[nx][ny] = 0;
                    if (this.isRunning) { this.render(x, y); await this.sleep(); }
                }
            }
        }
    },

    run: async function(mode, btn) {
        this.isRunning = false; this.isPaused = false;
        document.querySelectorAll('#dfs-root button').forEach(b => b.classList.remove('active-btn'));
        btn.classList.add('active-btn');
        await new Promise(r => setTimeout(r, 100));
        this.isRunning = true;
        this.vis = Array(this.N).fill(0).map(() => Array(this.N).fill(0));
        this.ans = 0; this.steps = 0;
        if (mode !== 'no_mark') this.vis[0][0] = 1;
        await this.dfs(0, 0, mode);
        this.render(-1, -1);
        this.isRunning = false;
    },

    togglePause: function() { this.isPaused = !this.isPaused; document.getElementById('dfs-pause').innerText = this.isPaused ? '继续' : '暂停'; },
    toggleSpeed: function() {
        const b = document.getElementById('dfs-speed');
        if (this.delayMs === 200) { this.delayMs = 800; b.innerText = '速度: 慢速'; }
        
        else { this.delayMs = 200; b.innerText = '速度: 常速'; }
    }
};
dfsApp.render(-1, -1);
</script>
{% endraw %}

```cpp
if (nx >= 1 && nx <= n && ny >= 1 && ny <= m && a[nx][ny] != -1 &&
        !vis[nx][ny]) {
      vis[nx][ny] = 1; // 【标记】占领这个点
      dfs(nx, ny);     // 【递归】继续深入
      vis[nx][ny] = 0; // 【回溯】释放这个点，让别的路径也能经过它
    }
```
以此代码为例,如果不写`vis[nx][ny] = 1;`,则会导致搜索时反复回到已经走过的路径,造成死循环;如果不在递归后写`vis[nx][ny] = 0;`,会导致一个已经遍历过的路径中的方格无法被其他其他路径使用.
- 再解释一下为什么不写vis就会死循环:
  - 从方格1到方格2后,方格2会遍历上下左右四个方向,因为方格1对于2来说是可达的,因此会回到方格1,以此往复.
因此,如果题目要求找到所有路径,或者所写算法中有往回走的可能,就需要使用vis数组,无论是dfs还是bfs.

# 图论



