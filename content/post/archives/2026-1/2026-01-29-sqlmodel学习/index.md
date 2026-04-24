---
title: 2026-01-29 sqlmodel学习
tags:
  - 数据库
date: 2026-01-29 08:00:00
image: 79084367_p0-红魔馆祭灶图.webp
---

## 概览
### [引入](https://sqlmodel.cn/databases/#distributed-servers)

>讲的很清楚,就连没学过数据库的我看了之后也觉得很明白,就不用重复造轮子了

### 从数据库到代码
```python
# Never do this! 🚨 Continue reading.
user_id = input("Type the user ID: ")
statement = f"SELECT * FROM hero WHERE id = {user_id};"
results = database.execute(statement)
```
>这种直接代入用户输入的代码在面对sql注入时将会直接崩盘,执行一些可怕的操作比如删除所有数据表

```python
user_id = input("Type the user ID: ")

session.exec(
    select(Hero).where(Hero.id == user_id)
).all()
```
>而这样就不会有问题,比如输入"12 ; DELETE TABLE hero ",只会告诉你不存在id"12 ; DELETE TABLE hero "
### Engine and CREATE TABLE

```python
from sqlmodel import Field, SQLModel, create_engine  

class Hero(SQLModel, table=True):  
    id: int | None = Field(default=None, primary_key=True)  
    name: str  
    secret_name: str  
    age: int | None = None  


sqlite_file_name = "database.db"  
sqlite_url = f"sqlite:///{sqlite_file_name}"  

engine = create_engine(sqlite_url, echo=True)  


def create_db_and_tables():  
    SQLModel.metadata.create_all(engine)  


if __name__ == "__main__":  
    create_db_and_tables()
```


>`engine = create_engine(sqlite_url, echo=True) `,engine只能有一个,在其他文件中调用的时候需要导入engine,也就是说,所有的py文件都是在对一个engine进行操控.
- 注意到这里的field和fastapi中basemodel的field用法是类似的,只是参数不太一样
- 非常值得一提的是这里我们不需要显式写类似`CREATE TABLE`这样的语句来实现表的构造,而是由sqlmodel自动帮我们实现,只需要在实例化的时候写明继承SQLModel就行了
  
#### KEY FACT:导入模块实际上是执行了一遍导入的模块代码
```python
from sqlmodel import Field, Session, SQLModel, create_engine


class Hero(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str
    secret_name: str
    age: int | None = None 
sqlite_file_name = "database.db"
sqlite_url = f"sqlite:///{sqlite_file_name}"
engine = create_engine(sqlite_url, echo=True)
def create_db_and_tables():
    SQLModel.metadata.create_all(engine)


def main():
    create_db_and_tables()
if __name__ == "__main__":
    main()
```
也就是说要导入的模块都应该写一个入口函数,放置有副作用的函数,防止多次运行
```python
if __name__ == "__main__":
    main()
```
### Session and INSERT INTO
```sql
INSERT INTO "hero" ("name", "secret_name") 
VALUES ("Deadpond", "Dive Wilson");
```
>这是sql中的插入数据
- 注意在sql中空格和换行都是可以直接忽略的,sql中除了名词以外的操作语句大小写都可以识别,也就是说,可以随便排版让语句更美观
  
```python
def create_heroes():
    hero_1 = Hero(name="Deadpond", secret_name="Dive Wilson")
    hero_2 = Hero(name="Spider-Boy", secret_name="Pedro Parqueador")
    hero_3 = Hero(name="Rusty-Man", secret_name="Tommy Sharp", age=48)

    session = Session(engine)

    session.add(hero_1)
    session.add(hero_2)
    session.add(hero_3)

    session.commit()
    session.close()
```
>这是sqlmodel里的插入数据,看起来直观多了,这种类似git的工作方式让人看起来赏心悦目

**A better organization**
```python
# Code above omitted 👆

def create_heroes():
    hero_1 = Hero(name="Deadpond", secret_name="Dive Wilson")
    hero_2 = Hero(name="Spider-Boy", secret_name="Pedro Parqueador")
    hero_3 = Hero(name="Rusty-Man", secret_name="Tommy Sharp", age=48)

    with Session(engine) as session:
        session.add(hero_1)
        session.add(hero_2)
        session.add(hero_3)

        session.commit()

# Code below omitted 👇
```
>当with块结束后会话自动关闭,这也是一种语法糖,等价于以下结构
```python
session = Session(engine)
try:
    session.add(hero_1)
    session.add(hero_2)
    session.add(hero_3)
    session.commit()
finally:
    session.close()
```
### int|None and Null
>数据库中的id字段作为PRIMARY KEY时,是必填项,不能为NULL
>但在sqlmodel中对id进行设置时,可以写成以下形式
```python
# Code above omitted 👆
class Hero(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str
    secret_name: str
    age: int | None = None
```
可以看到这里id的默认值为None,而实例化时不设置id
```python
def create_heroes():
    hero_1 = Hero(name="Deadpond", secret_name="Dive Wilson")
    hero_2 = Hero(name="Spider-Boy", secret_name="Pedro Parqueador")
    hero_3 = Hero(name="Rusty-Man", secret_name="Tommy Sharp", age=48)
```
事实上,只有在commit之后,id才会实例化并可以从数据库得到

### Session,select  AND SELECT FROM 
```sql
SELECT id, name, secret_name, age
FROM hero
```
>读取特定列
```sql
SELECT *
FROM hero
```
>读取所有列
```python
def select_heroes():
    with Session(engine) as session:
        statement = select(Hero)
        results = session.exec(statement)
        heroes = results.all() #返回一个包含所有对象的列表
        print(heroes)
```
**Compact Version**
```python
# Code above omitted 👆

def select_heroes():
    with Session(engine) as session:
        heroes = session.exec(select(Hero)).all()
        print(heroes)

# Code below omitted 👇
```
### SELECT().WHERE() AND SELECT FROM WHERE
```sql
SELECT id, name, secret_name, age
FROM hero
WHERE name = "Deadpond"
```
```python
# Code above omitted 👆

def select_heroes():
    with Session(engine) as session:
        statement = select(Hero).where(Hero.name == "Deadpond")
        results = session.exec(statement)
        for hero in results:
            print(hero)

# Code below omitted 👇
```
>可以看出来只是加了where方法

#### 多个where
```sql
SELECT id, name, secret_name, age
FROM hero
WHERE age >= 35 AND age < 40
```
```python
# Code above omitted 👆

def select_heroes():
    with Session(engine) as session:
        statement = select(Hero).where(Hero.age >= 35).where(Hero.age < 40)
        results = session.exec(statement)
        for hero in results:
            print(hero)

# Code below omitted 👇
```
**Another Method**
```python
# Code above omitted 👆

def select_heroes():
    with Session(engine) as session:
        statement = select(Hero).where(Hero.age >= 35, Hero.age < 40)
        results = session.exec(statement)
        for hero in results:
            print(hero)

# Code below omitted 👇
```
### INDEX(26/2/2)
>index是数据库内部用来对某一列数据建立一个索引表的关键字,在很多情况下都能加快查询效率
```sql
CREATE INDEX ix_hero_name
ON hero (name)
```
```python
from sqlmodel import Field, Session, SQLModel, create_engine, select

class Hero(SQLModel, table=True):
    id: int | None = Field(default=None, primary_key=True)
    name: str = Field(index=True) #只加了一个参数
    secret_name: str
    age: int | None = Field(default=None, index=True) #只加了一个参数
# Code below omitted 👇
```
>可以看出来sqlmodel还是要简单直观的多

### UPDATE(2/3)
```sql
UPDATE hero
SET age=16
WHERE name = "Spider-Boy"
```
>看多了sql语句后发现其实也挺直观的,就算没学过sql也可以看懂这段代码干了什么
```python
# Code above omitted 👆

def update_heroes():
    with Session(engine) as session:
        statement = select(Hero).where(Hero.name == "Spider-Boy")
        results = session.exec(statement)
        hero = results.one()
        print("Hero:", hero)

        hero.age = 16
        session.add(hero)
        session.commit()

# Code below omitted 👇
```
>可以看到sqlmodel仅需要像修改对象属性一样直接改动后再commit就可以了

### DELETE(2/3)
```sql
DELETE
FROM hero
WHERE name = "Spider-Youngster"
```
```python
# Code above omitted 👆

def delete_heroes():
    with Session(engine) as session:
        statement = select(Hero).where(Hero.name == "Spider-Youngster")
        results = session.exec(statement)
        hero = results.one()
        print("Hero: ", hero)

        session.delete(hero)
        session.commit()

# Code below omitted 👇
```
>将add换成了delete