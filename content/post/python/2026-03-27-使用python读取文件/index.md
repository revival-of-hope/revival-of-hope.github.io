---
title: 使用python读取文件
tags:
  - python
date: 2026-03-27 08:00:00
image: 54943053_p0-a fantastical journey.webp
---

>不会用python来读取文件的话,我想是不太可能会学会爬虫的,不然你怎么处理获取的数据

本文所用的weekly_hiring_comments.json示例的结构如下:
```json
[
  {
    "issue": 692,
    "author": "ruanyf",
    "created_at": "2019-07-18T07:00:46Z",
    "text": "### **高级 Web 前端工程师**\r\n  \r\n[深圳追一科技](https://zhuiyi.ai/)，人工智能创业公司。工作地点：深圳市南山区。\r\n\r\n公司主打 NLP 方向的 B 端 AI 产品落地，诚求英才。要求4年以上实际前端项目的开发经验，熟练掌握 Vue 或 React 生态，查看[详细信息](https://www.zhipin.com/job_detail/79ca9be7fb736e4d03Nz3924FVA~.html)。\r\n\r\nEmail 联系：[winchang@wezhuiyi.com](mailto:winchang@wezhuiyi.com)",
    "url": "https://github.com/ruanyf/weekly/issues/692#issuecomment-512691467"
  },
//   ...
]
```
## open方法
读写文件一般都通过open方法来进行操作,基本用法看下面的代码就很容易理解了:
```py
with open("weekly_hiring_comments.json", "r", encoding="utf-8") as f:
    posts = json.load(f)

with open("本科及以上.json", "w", encoding="utf-8") as f:
    json.dump(bachelor_posts, f, ensure_ascii=False, indent=2)
```
三个参数分别为:
1. file(文件路径)
2. mode(操作方式)
3. encoding(解码方式)

mode 的值包括以下几种:
- 'r' ，表示读取文件
- 'w' 表示写入文件（现有同名文件会被覆盖）
- 'a' 表示打开文件并追加内容，任何写入的数据会自动添加到文件末尾
- 'r+' 表示打开文件进行读写
- **mode 实参是可选的，省略时的默认值为 'r'**


当然,如果看源码的话还能看到一堆参数,但我们一般只用得到上述的三个参数:
```py
def open(
    file: FileDescriptorOrPath,
    mode: OpenTextMode = "r",
    buffering: int = -1,
    encoding: str | None = None,
    errors: str | None = None,
    newline: str | None = None,
    closefd: bool = True,
    opener: _Opener | None = None,
) -> TextIOWrapper: ...
```

现在的问题是这个读写的文件会有很多种格式(.pdf,.txt,.json,.html,.js, ...),我们来看看open是怎么处理的:
1. text mode - 默认格式: 通常情况下,文件以该模式打开,一般使用utf-8进行编码,该模式主要用于处理文本文件
2. binary mode - 以二进制模式读取文件,需要在mode词尾加上一个'b',如`wb`,`ab`等,在二进制模式下无法指定encoding(也没有必要指定),该模式主要用于读取.png,.mp3,.pdf这样的二进制文件

换句话说,open函数根本不会对每种文件进行特殊处理,只是有两种读取方式而已了,对于一些特殊的文件格式,我们都需要额外用其他库去处理.

但是对于一般的文件格式,open函数读取文件名后会返回一个TextIOWrapper对象,它有两种常用的方法:
1. .read()方法: 将全文读入一个字符串变量
   1. 例子: `content = f.read()`
2. .write()方法: 写入字符串
   1. 例子: `f.write(f"## 招聘 \n\n")`


### json系统库:处理json文件
既然是系统库,那自然要先导入后使用,事实上只有两个常用函数: json.load()和json.dump().

**示例**
```py
with open("weekly_hiring_comments.json", "r", encoding="utf-8") as f:
    posts = json.load(f)

bachelor_posts = []

with open(out_dir / "本科及以上.json", "w", encoding="utf-8") as f:
    json.dump(bachelor_posts, f, ensure_ascii=False, indent=2)
```
看看源码和参数:
```py
# load()
(function) def load(
    fp: SupportsRead[str | bytes],
    *,
    cls: type[JSONDecoder] | None = None,
    object_hook: ((dict[Any, Any]) -> Any) | None = None,
    parse_float: ((str) -> Any) | None = None,
    parse_int: ((str) -> Any) | None = None,
    parse_constant: ((str) -> Any) | None = None,
    object_pairs_hook: ((list[tuple[Any, Any]]) -> Any) | None = None,
    **kwds: Any
) -> Any

# dump()
(function) def dump(
    obj: Any,
    fp: SupportsWrite[str],
    *,
    skipkeys: bool = False,
    ensure_ascii: bool = True,
    check_circular: bool = True,
    allow_nan: bool = True,
    cls: type[JSONEncoder] | None = None,
    indent: int | str | None = None,
    separators: tuple[str, str] | None = None,
    default: ((Any) -> Any) | None = None,
    sort_keys: bool = False,
    **kwds: Any
) -> None
```
速览一下就知道用法了,读json文件时指定文件名,写json文件时指定写入内容和写入文件名就可以了
### 处理md文件
md文件没有专门的库,直接读写就可以了
```py
with open("weekly_hiring_comments.json", "r", encoding="utf-8") as f:
    posts = json.load(f)

out = Path("weekly_hiring_comments.md")

with out.open("w", encoding="utf-8") as f:
    for i, p in enumerate(posts, 1):
        f.write(f"## 招聘 {i}\n\n")
        f.write(f"- Issue: #{p['issue']}\n")
        f.write(f"- 作者: {p['author']}\n")
        f.write(f"- 时间: {p['created_at']}\n")
        f.write(f"- 来源: {p['url']}\n\n")
        f.write(p["text"])
        f.write("\n\n---\n\n")
```

## pathlib库
**该库在不同平台下都能轻松读取文件路径**,而不需要操心系统问题或者字符串问题.

- [官方文档](https://docs.python.org/zh-cn/3/library/pathlib.html)

>如果以前从未用过此模块，或不确定哪个类适合完成任务，那要用的可能就是 Path。它在运行代码的平台上实例化为具体路径.

接下来我们来详细介绍这个Path对象
### Path对象的创建
```py
from pathlib import Path

# 基础用法
out_file: Path = Path("a.md")

# 拼接路径的两种写法

# 简写
out_file: Path = Path("modules") / "a.py"

# 分开写
out_dir: Path = Path("modules")
out_file: Path = out_dir / "issues.md"

```
上述的代码由于没有指定绝对路径,故都是相对于python运行目录的路径,但我们也可以指定绝对路径,如下文所示:
```py
from pathlib import Path

# Windows 风格
abs_path_win = Path("C:/Users/Admin/Desktop/a.md")

# Linux/macOS 风格
abs_path_unix = Path("/home/user/project/a.md")
```
也就是说,我们不需要再去折腾不同操作系统的路径问题了,统一用`/`就可以确定相对的路径.
### 使用Path来创建文件夹
只需要调用mkdir方法即可:
```py
out_dir: Path = Path("issues_md")
out_dir.mkdir(exist_ok=True)
```
- exist_ok参数的作用: 默认为False,设置为True时,即便当前路径下有这个文件夹,也不会报错
### Path对象的open方法
事实上,这个open方法与python内置的open方法基本没有区别,只是把文件路径提到外面来了而已:
```py
out_dir: Path = Path("issues_md")
out_dir.mkdir(exist_ok=True)

for issue, items in by_issue.items():
    path = out_dir / f"issue_{issue}.md"
    with path.open("w", encoding="utf-8") as f:
        f.write(f"# Issue #{issue} 招聘汇总\n\n")
```

### Path对象的glob方法(待补充)

### 实战
```py
import json
from pathlib import Path
from collections import defaultdict

with open("weekly_hiring_comments.json", "r", encoding="utf-8") as f:
    posts = json.load(f)
# 读取json列表
by_issue = defaultdict(list)
for p in posts:
    by_issue[p["issue"]].append(p)
# 处理为一个有序字典,这在json列表本身是无序的时候比较好用
out_dir: Path = Path("issues_md")
out_dir.mkdir(exist_ok=True)

for issue, items in by_issue.items():
    path = out_dir / f"issue_{issue}.md"
    with path.open("w", encoding="utf-8") as f:
        f.write(f"# Issue #{issue} 招聘汇总\n\n")

        for i, p in enumerate(items, 1):
            f.write(f"## 招聘 {i}\n\n")
            f.write(f"- 作者: {p['author']}\n")
            f.write(f"- 时间: {p['created_at']}\n")
            f.write(f"- 来源: {p['url']}\n\n")
            f.write(p["text"])
            f.write("\n\n---\n\n")
```

## re系统库
- [官方文档](https://docs.python.org/zh-tw/3.8/library/re.html)

该库是对正则表达式(regular expression)的封装,所以叫re.

### compile方法
compile是一个实例化pattern对象的方法,pattern一词在re中指的是正则表达式字符串
```py
prog = re.compile(pattern)
result = prog.match(string)
# 上述代码等价于下面的这个
result = re.match(pattern, string)
# 为了规范化和复用,我们还是多用compile方法来指明pattern对象
```

>事实上,re库中的大多数常用方法都有两种写法,一种是`模式.方法(参数)`,另一种是`方法.(模式,参数)`.为了规范起见,我们后面都采用`模式.方法(参数)`写法,就不再次说明了



### search方法与match方法
- [菜鸟教程](https://www.runoob.com/python/python-reg-expressions.html)

>re.match只匹配字符串的开始，如果字符串开始不符合正则表达式，则匹配失败，函数返回None；而re.search匹配整个字符串，直到找到一个匹配。

```py
#!/usr/bin/python
import re
 
line = "Cats are smarter than dogs";
 
matchObj = re.match( r'dogs', line, re.M|re.I)
if matchObj:
   print "match --> matchObj.group() : ", matchObj.group()
else:
   print "No match!!"
 
matchObj = re.search( r'dogs', line, re.M|re.I)
if matchObj:
   print "search --> searchObj.group() : ", matchObj.group()
else:
   print "No match!!"
```
**运行结果**
```bash
No match!!
search --> searchObj.group() :  dogs
```

### 实战
下面的整个代码流程为:
1. 载入json文件为列表posts
2. 使用compile方法组织匹配模式
3. 将posts里对应学历要求的帖子中的text字段里的值插入列表中
4. 导出json文件
```py
with open("weekly_hiring_comments.json", "r", encoding="utf-8") as f:
    posts = json.load(f)

bachelor_patterns = [
    r"本科及以上",
    r"本科以上",
]

master_patterns = [
    r"硕士及以上",
    r"硕士以上",
]
# 这里的r是为了禁用`\`转义符,但这里都是中文,不写也可以,为了规范所以加上了

bachelor_re = re.compile("|".join(bachelor_patterns))
master_re = re.compile("|".join(master_patterns))
# 拼接了两个匹配字符串

bachelor_posts = []
master_posts = []

for p in posts:
    # 这个p是列表的子元素,在这里为字典
    text = p.get("text", "")
    # get方法的第一个参数是,查找该字典中的对应字段并返回值,第二个参数是,若查找不到返回的默认值
    if master_re.search(text):
        master_posts.append(p)
    elif bachelor_re.search(text):
        bachelor_posts.append(p)

# === 输出目录 ===
out_dir = Path("degree_split")
out_dir.mkdir(exist_ok=True)

# === 写文件 ===
with open(out_dir / "本科及以上.json", "w", encoding="utf-8") as f:
    json.dump(bachelor_posts, f, ensure_ascii=False, indent=2)

with open(out_dir / "硕士及以上.json", "w", encoding="utf-8") as f:
    json.dump(master_posts, f, ensure_ascii=False, indent=2)

```



## 读取.env文件
对于密码,API密钥这些文件,用json文件存取不够方便也不够安全,因此我们有了.env文件,样式如下:
```toml
# github token
token="ghp_xxxxxxxxxxxx"
```
当我们想要读取这个.env文件中的token字段时,我们可以导入dotenv库和os库来进行简单的读取:
```py
from dotenv import load_dotenv
import os

load_dotenv()
TOKEN = os.getenv("token")
```
`load_dotenv()`函数会递归寻找.env文件并返回内容供os库读取,从而避免了写路径的麻烦.

