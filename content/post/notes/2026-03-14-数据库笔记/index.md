---
title: 2026-03-14 数据库笔记
tags:
  - [数据库,后端]
date: 2026-03-14 08:00:00
image: 38431299_p0-式さん.webp
---

- 课程用教材:<< Database System Concepts >>
  - 这本书讲的还是比较全面的,但废话也很多,部分地方讲的不够深


# Introduction to the Relational Model
## Structure of Relational Databases
>A relational database consists of a collection of tables, each of which is assigned a
unique name.

>In mathematical terminology, a **tuple** is simply a sequence(or list) of values. A relationship between n values is represented mathematically by an n-tuple of values, that is, a tuple with n values, which corresponds to a row in a table.

Thus, in the relational model: 
- the term **relation** is used to refer to a table;
- the term **tuple** is used to refer to a row; 
- the term **attribute** refers to a column of a table.

>For each attribute of a relation, there is a set of permitted values, called the **domain** of that attribute. Thus, the domain of the salary attribute of the instructor relation is the set of all possible salary values, while the domain of the name attribute is the set of all possible instructor names.

A domain is atomic if elements of the domain are considered to be indivisible units.For example, suppose the table instructor had an attribute phone number, which can store a set of phone numbers corresponding to the instructor. Then the domain of phone number would not be atomic, since an element of the domain is a set of phonenumbers, and it has subparts, namely, the individual phone numbers in the set.

- 如果一个域的值在逻辑上/使用上还能再拆成更小的有意义的单元，那它就不是原子的

>The null value is a special value that signiﬁes that the value is unknown or does not exist.

## Database Schema
- **schema**: the logical design of the database
  - 即数据库中所有关系,属性的处理
  - 这个概念其实很重要,会在之后多次出现.
## Keys
- superkey: a set of one or more attributes that identify uniquely a tuple in the relation.
> For example, the ID attribute of the relation instructor is suﬃcient to distinguish one instructor tuple from another. Thus, ID is a superkey. The name attribute of instructor, on the other hand, is not a superkey, because several instructors might have the same name.

- candidate keys: superkeys for which no proper subset is a superkey.
>It is possible that several distinct sets of attributes could serve as a candidate key.
Suppose that a combination of name and dept name is suﬃcient to distinguish among
members of the instructor relation. Then, both {ID} and {name, dept name} are candidate
keys. Although the attributes ID and name together can distinguish instructor tuples,
their combination, {ID, name}, does not form a candidate key, since the attribute ID
alone is a candidate key.

- primary key: denote a candidate key that is chosen by the database designer as the principal means of identifying tuples within a relation
  - 在这里,primary key可以是由多个attribute组成的tuple

>The primary key should be chosen such that its attribute values are never, or are very rarely, changed.
## Schema Diagrams
A database schema, along with primary key and foreign-key constraints, can be depicted by schema diagrams

>Primary-key attributes are shown underlined. Foreign-key constraints appear as
arrows from the foreign-key attributes of the referencing relation to the primary key of
the referenced relation. We use a two-headed arrow, instead of a single-headed arrow,
to indicate a referential integrity constraint that is not a foreign-key constraints.

## Relational Query Languages
* **Query Language**: A language used by a user to request information from a database. It operates at a higher level of abstraction than standard programming languages.
* **Categorization**:
  * **Imperative Query Language**: The user instructs the system to perform a specific sequence of operations. These languages maintain a notion of **state variables** that are updated during computation.
  * **Functional Query Language**: Computation is expressed as the evaluation of functions. These functions operate on database data or results of other functions. They are **side-effect free** and do not update program state.
  * **Declarative Query Language**: The user describes the desired information using mathematical logic without providing specific steps or function calls. The database system is responsible for determining the physical retrieval method.


* **Pure Query Languages**:
  * **Relational Algebra**: A **functional** query language that forms the theoretical basis of SQL.
  * **Tuple Relational Calculus** and **Domain Relational Calculus**: **Declarative** languages.


* **Characteristics**: These formal languages lack the "syntactic sugar" found in commercial languages but illustrate fundamental techniques for data extraction.

## The Relational Algebra(3/26)
### The Select Operation
`σ dept_name = “Physics” (instructor)`
>We use the lowercase Greek letter sigma (σ) to denote **selection**.

>We can ﬁnd all instructors with salary greater than $90,000 by writing:
`σ salary>90000 (instructor)`
### The Project Operation
>**Projection** is denoted by the uppercase Greek letter pi (Π). 
`Π ID, name, salary (instructor)`
The **project** operation is a unary operation that returns its argument relation, with certain attributes left out. 
我们也可以在投影的时候进行计算:
`Π ID,salary∕12 (instructor)`
### Composition of Relational Operations
“Find the names of all instructors in the Physics department.”:
`Π name (σ dept_name = “Physics” (instructor))`
### The Cartesian-Product Operation
![alt text](../images/2026-03-25/PixPin_2026-03-26_09-03-48.webp)
- 也就是说关系上的笛卡尔积会生成一个nxm大小的单元组表

### The Join Operation
![alt text](../images/2026-03-25/PixPin_2026-03-26_09-08-22.webp)
注意这里的join没有过滤掉重复的id列!
![alt text](../images/2026-03-25/PixPin_2026-03-26_09-10-02.webp)

### Set Operations
求并集(union)的前提条件:
1. 输入的两个关系具有相同数量的属性
2. 当属性相关联时,两个关系中对应属性的类型必须相同
![alt text](../images/2026-03-25/PixPin_2026-03-26_09-16-15.webp)

求交集(intersection):
![alt text](../images/2026-03-25/PixPin_2026-03-26_09-19-11.webp)

求集差(set-diﬀerence):
![alt text](../images/2026-03-25/PixPin_2026-03-26_09-21-50.webp)
### The Assignment Operation
>It is convenient at times to write a relational-algebra expression by assigning parts of it to temporary relation variables. 
The **assignment** operation, denoted by **←**, works like assignment in a programming language.

![alt text](../images/2026-03-25/PixPin_2026-03-26_09-24-00.webp)
### The Rename Operation
>The **rename** operator  refers to  the results of relational-algebra expressions,denoted by the lowercase Greek letter rho (ρ).
![alt text](../images/2026-03-25/PixPin_2026-03-27_08-46-34.webp)

# Introduction to SQL
### Overview of the SQL Query Language
- The SQL language has several parts:
  - **Data-definition language** (DDL). The SQL DDL provides commands for deﬁning relation schemas, deleting relations, and modifying relation schemas.
  - **Data-manipulation language** (DML). The SQL DML provides the ability to query information from the database and to insert tuples into, delete tuples from, and modify tuples in the database.
    - 从这可以看到Data-manipulation是操作实例,Data-definition是操作关系模型
  - Integrity. The SQL DDL includes commands for specifying integrity constraints that the data stored in the database must satisfy. Updates that violate integrity constraints are disallowed.
    - 即规范性.
  - and so on

### SQL Data Definition

#### Basic Types

The SQL standard supports a variety of built-in types, including:

- **char(n)**  
  Fixed-length character string.  
  Exactly n characters long.  
  Padded with spaces if shorter value inserted.  
  Full form: character(n).

- **varchar(n)**  
  Variable-length character string.  
  Maximum n characters.  
  Stores only actual characters (no padding).  
  Full form: character varying(n).

- **int**  
  Integer.  
  Machine-dependent range (usually 32-bit).  
  Full form: integer.

- **smallint**  
  Small integer.  
  Smaller machine-dependent range than int (usually 16-bit).

- **numeric(p, d)**  
  Fixed-point (exact decimal) number.  
  Total digits: p (including sign).  
  Decimal places: d.  
  Example: numeric(3,1) stores -99.9 to 99.9 exactly.  
  Cannot store 444.5 (exceeds p) or 0.32 (needs d≥2).

- **real**  
  Single-precision floating-point.  
  Machine-dependent precision (usually IEEE 32-bit).

- **double precision**  
  Double-precision floating-point.  
  Machine-dependent higher precision (usually IEEE 64-bit).

- **float(n)**  
  Floating-point with minimum precision of n decimal digits.  
  Implementation chooses actual precision ≥ n.

Each type may include a special value called the **null value**. A null value indicates
an absent value that may exist but be unknown or that may not exist at all. 

When comparing a char type with a varchar type, one may expect extra spaces to be added to the varchar type to make the lengths equal, before comparison; however, this may or may not be done, depending on the database system. As a result, even if the same value “Avi” is stored in the attributes A and B above, a comparison A=B may return false. We recommend you always use the varchar type instead of the char type to avoid these problems.
- 也就是说,可变数组在和固定长度数组比较时未必会加上对应长度的空格后再比较

####  Basic Schema Definition
We deﬁne an SQL relation by using the create table command. The following command creates a relation department in the database:
```sql
create table department
(
  dept_name vacchar(20),
  building  varchar(15),
  budget    numeric(12,2),
  primary key(dept_name)
);
```

- 结尾的`;`在大多数sql版本中是可选的

SQL supports a number of diﬀerent integrity constraints. In this section, we discuss only a few of them:
- primary key: required to be nonnull and unique
  - 也就是说不可重复,不可为null
  - Although the primary-key speciﬁcation is optional, it is generally a good idea to specify a primary key for each relation.
- foreign key(A) references s: the value of A in this relation must correspond  to value of the primary key attributes in relation s.
  - 也就是说不允许把s关系中不存在的值写在这个关系中
- not null: the null value is not allowed for that attribute

- **drop table**: remove a relation from an SQL database
  - `drop table r;`只要这样就可以删除关系r了
- **delete from**:  retains relation r, but deletes all tuples in r.
  - `delete from r;`
- **alter table**:  add or drop attributes to an existing relation
  - `alter table r add A D;`:where r is the name of an existing relation, A is the name of the attribute to be added,and D is the type of the added attribute. 
  - `alter table r drop A;`:  drop attributes from a relation
**eg**
```sql
create table teaches
(
ID varchar (5),
course id varchar (8),
sec id varchar (8),
semester varchar (6),
year numeric (4,0),
primary key (ID, course id, sec id, semester, year),
foreign key (course id, sec id, semester, year) references section,
foreign key (ID) references instructor
);
alter table teaches  drop ID;
drop table teaches;
```
### Basic Structure of SQL Queries
The basic structure of an SQL query consists of three clauses: **select, from, and where**.
A query takes as its input the relations listed in the from clause, operates on them as speciﬁed in the where and select clauses, and then produces a relation as the result. 
- 事实上在部分语句或者某些数据库系统中where,from是可选的,但select是必须出现的
####  Queries on a Single Relation

```sql
select dept_name
from instructor;
```

Since more than one instructor can belong to a department, a department name could appear more than once in the instructor relation.
We can rewrite the preceding query as:
```sql
select distinct dept name
from instructor;
```
The result of the above query would contain each department name at most once.

Also,SQL allows us to use the keyword all to specify explicitly that duplicates are not removed:
```sql
select all dept name
from instructor;
```
Since duplicate retention is the default, we shall not use all in our examples. 

The select clause may also contain arithmetic expressions involving the operators +, −, ∗, and / operating on constants or attributes of tuples:
```sql
select ID, name, dept name, salary * 1.1
from instructor;
```
这不会改动原关系里的salary数值,只是在输出上将salary乘以1.1了


The where clause allows us to select only those rows in the result relation of the from clause that satisfy a speciﬁed predicate(断言)

```sql
select name
from instructor
where dept name = 'Comp. Sci.' and salary > 70000;
```

SQL allows the use of the logical connectives and, or, and not in the where clause.
The operands of the logical connectives can be expressions involving the comparison operators <, <=, >, >=, =, and <>.

####  Queries on Multiple Relations
```sql
select instructor.dept_name, building, name
from instructor, department
where instructor.dept_name= department.dept_name;
```
注意到在不同关系中同时出现的attribute需要用关系名作为前缀来指明,而独特的attribute则不用

**from解析**
The from clause by itself deﬁnes a Cartesian product of the relations listed in the clause. It is deﬁned formally in terms of relational algebra, but it can also be understood as an iterative process that generates tuples for the result relation of the from clause.

```text
for each tuple t1 in relation r1
  for each tuple t2 in relation r2
    …
      for each tuple tm in relation rm
        Concatenate t1 , t2 , … , tm into a single tuple t
        Add t into the result relation
```
也就是说from实际上会将所有关系用笛卡尔积制成一个nxm的表,如果不用where来过滤掉多余组合的话,在大型数据库中select将很难处理这么多数据

```sql
SELECT s.name, c.course_name
FROM students s, courses c;
```
→ 结果行数 = students 行数 × courses 行数（所有学生 × 所有课程的组合）

### Additional Basic Operations
#### The Rename Operation
```sql
select name, course id
from instructor, teaches
where instructor.ID= teaches.ID;
```
The result of this query is a relation with the following attributes:
`name, course id`

We cannot, however, always derive names in this way, for several reasons:

First, two relations in the **from clause** may have attributes with the same name, in which case an attribute name is duplicated in the result.

Second, if we use an arithmetic expression in the **select clause**, the resultant attribute does not have a name.

Third, even if an attribute name can be derived from the base relations as in the preceding example, we may want to change the attribute name in the result.

Hence, SQL provides a way of renaming the attributes of a result relation. It uses the **as clause**, taking the form:
`old-name as new-name`

For example, if we want the attribute name **name** to be replaced with the name **instructor_name**, we can rewrite the preceding query as:

```sql
select name as instructor name, course id
from instructor, teaches
where instructor.ID= teaches.ID;
```

The **as clause** is particularly useful in renaming relations.

One reason to rename a relation is to replace a long relation name with a shortened version that is more convenient to use elsewhere in the query.

To illustrate, we rewrite the query **“For all instructors in the university who have taught some course, find their names and the course ID of all courses they taught.”**

```sql
select T.name, S.course_id
from instructor as T, teaches as S
where T.ID = S.ID;
```

Another reason to rename a relation is a case where we wish to compare tuples in the same relation. We then need to take the **Cartesian product** of a relation with itself and, without renaming, it becomes impossible to distinguish one tuple from the other.

Suppose that we want to write the query **“Find the names of all instructors whose salary is greater than at least one instructor in the Biology department.”**

We can write the SQL expression:

```sql
select distinct T.name
from instructor as T, instructor as S
where T.salary > S.salary and S.dept_name = 'Biology';
```
#### String Operations
SQL speciﬁes strings by enclosing them in **single quotes**, for example, 'Computer'. A single quote character that is part of a string can be speciﬁed by using two single quote characters.

For example, the string “It’s right” can be speciﬁed by 'It''s right'.

The SQL standard speciﬁes that the equality operation on strings is **case sensitive**;as a result, the expression “'comp. sci.' = 'Comp. Sci.'” evaluates to false.

- 但在MySQL和SQL Server中,在字符串比较时不区分大小写,故“'comp. sci.' = 'Comp. Sci.'” 为真.

Pattern matching can be performed on strings using the operator like. We describe patterns by using two special characters:
- Percent (%): The % character matches any substring.
- Underscore (_): The character matches any character.


Patterns are case sensitive.To illustrate pattern matching, we consider the following examples:

-  'Intro%' matches any string beginning with “Intro”.
-  '%Comp%' matches any string containing “Comp” as a substring, for example, 'Intro. to Computer Science', and 'Computational Biology'.
- '___' matches any string of exactly three characters.
- '___%' matches any string of at least three characters.

For patterns to include the special pattern characters (that is, % and ), SQL allows the
speciﬁcation of an escape character. The escape character is used immediately before
a special pattern character to indicate that the special pattern character is to be treated
like a normal character. We deﬁne the escape character for a like comparison using the
escape keyword. To illustrate, consider the following patterns, which use a backslash(∖) as the escape character:

- **like 'ab∖%cd%' escape '∖'** matches all strings beginning with “ab%cd”.
- **like 'ab∖∖cd%' escape '∖'** matches all strings beginning with “ab∖cd”.

也就是说,sql没有通用的转义符,而是需要用户定义并写入字符串中

SQL allows us to search for mismatches instead of matches by using the not like com-
parison operator. Some implementations provide variants of the like operation that do
not distinguish lower- and uppercase.

#### Attribute Specification in the Select Clause
The asterisk symbol “ * ” can be used in the select clause to denote “all attributes.”

```sql
select instructor.*
from instructor, teaches
where instructor.ID= teaches.ID;
```
It indicates that all attributes of instructor are to be selected.

### Ordering the Display of Tuples
The **order by** clause causes the tuples in the result of a query to appear in sorted order. 

By default, the order by clause lists items in ascending order. To specify the sort order,
we may specify desc for descending order or asc for ascending order. Furthermore,
ordering can be performed on multiple attributes. Suppose that we wish to list the
entire instructor relation in descending order of salary. If several instructors have the
same salary, we order them in ascending order by name. We express this query in SQL as follows:
```sql
select *
from instructor
order by salary desc, name asc;
```
### Where-Clause Predicates
SQL includes a **between** comparison operator to simplify **where** clauses that specify
that a value be less than or equal to some value and greater than or equal to some other value.

Similarly, we can use the not between comparison operator.
```sql
select name
from instructor
where salary between 90000 and 100000;
```
尽管它等价于以下语句,但看上去就直白了一点
```sql
select name
from instructor
where salary <= 100000 and salary >= 90000;
```

SQL permits us to use the notation (v1 , v2 , … , vn ) to denote a tuple of arity n con-
taining values v1 , v2 , … , vn ; the notation is called a row constructor. The comparison
operators can be used on tuples, and the ordering is deﬁned lexicographically. For ex-
ample, (a1 , a2 ) <= (b1 , b2 ) is true if a1 <= b1 and a2 <= b2 ; similarly, the two tuples
are equal if all their attributes are equal. Thus, the SQL query:
```sql
select name, course id
from instructor, teaches
where instructor.ID= teaches.ID and dept name = 'Biology';
```

can be rewritten as follows:
```sql
select name, course id
from instructor, teaches
where (instructor.ID, dept name) = (teaches.ID, 'Biology');
```

- 看似简写了,但其实看上去更懵了

## Set Operations
The SQL operations **union, intersect, and except** operate on relations and correspond to the mathematical set operations **∪, ∩, and −**.

### The Union Operation
```sql
(select course id
from section
where semester = 'Fall' and year= 2017)
union
(select course id
from section
where semester = 'Spring' and year= 2018);
```
这里只是把两个结果合并了一下而已

Note that the parentheses we include around each select-
from-where statement below are optional but useful for ease of reading.

- The **union** operation automatically eliminates duplicates, unlike the **select** clause. 

If we want to retain all duplicates, we must write **union all** in place of **union**.

### The Intersect Operation
```sql
(select course id
from section
where semester = 'Fall' and year= 2017)
intersect
(select course id
from section
where semester = 'Spring' and year= 2018);
```
找交集

- 同样可以加一个all来保留相同字段

```sql
(select course id
from section
where semester = 'Fall' and year= 2017)
intersect all
(select course id
from section
where semester = 'Spring' and year= 2018);
```
### The Except Operation
To ﬁnd all courses taught in the Fall 2017 semester **but not** in the Spring 2018 semester,we write:
```sql
(select course id
from section
where semester = 'Fall' and year= 2017)
except
(select course id
from section
where semester = 'Spring' and year= 2018);
```
The **except** operation outputs all tuples from its ﬁrst input that do not occur in the second input.

- 同样可以加一个all来保留相同字段

```sql
(select course id
from section
where semester = 'Fall' and year= 2017)
except all
(select course id
from section
where semester = 'Spring' and year= 2018);
```
## Null Values
**Null values** present special problems in relational operations, including arithmetic operations, comparison operations, and set operations.

The result of an arithmetic expression (involving, for example, +, −, ∗, or ∕) is null.

If any of the input values is null. For example, if a query has an expression r.A + 5, and r.A is null for a particular tuple, then the expression result must also be null for that tuple.

- 也就是说null参与的数学运算结果都是null

Comparisons involving nulls are more of a problem.SQL therefore treats as **unknown** the result of any comparison involving a null value.This creates a third logical value in addition to true and false.

Since the predicate in a where clause can involve Boolean operations such as and,or, and not on the results of comparisons, the deﬁnitions of the Boolean operations are extended to deal with the value **unknown**.

- and: The result of true and unknown is unknown, **false and unknown is false**, while unknown and unknown is unknown.
- or: The result of true or unknown is true, **false or unknown is unknown**, while unknown or unknown is unknown.
- not: The result of not unknown is unknown.

**为什么这样设计?**
- TRUE AND UNKNOWN 为什么是 UNKNOWN?
  - 如果 UNKNOWN 实际上是 TRUE：true and true = true
  - 如果 UNKNOWN 实际上是 FALSE: true and false =false
  - 由于结果可能是 TRUE 也可能是 FALSE，数据库无法给出定论，只能保守地标注为 UNKNOWN。
- false and unknown 为什么是 false?
  - 含有false的and语句恒为false,结果是确定的,故可标记为false.
- true or unknown 为什么是 true?
  - 同理,含有true的or语句恒为true.
- false or unknown 为什么是 unknown?
  - 同理,结果可能是 TRUE 也可能是 FALSE,无法定论.

SQL uses the special keyword null in a predicate to test for a null value. 
Thus, to ﬁnd all instructors who appear in the instructor relation with null values for salary, we write:

- 补充: `5*20+3=null`,`null=null`,返回值都是unknown.
```sql
select name
from instructor
where salary is null;
```
- 有`is null`当然就有`is not null`.

SQL allows us to test whether the result of a comparison is unknown,by using the clauses is unknown and is not unknown.For example:
```sql
select name
from instructor
where salary > 10000 is unknown;
```
## Aggregate Functions
Aggregate functions are functions that take a collection (a set or multiset) of values as
input and return a single value. SQL oﬀers ﬁve standard built-in aggregate functions:
1. Average: avg
2. Minimum: min
3. Maximum: max
4. Total: sum
5. Count: count


### Basic Aggregation
```sql
select avg (salary) as avg_salary
from instructor
where dept name = 'Comp. Sci.';
```
- 找到salary的平均值

```sql
select count (distinct ID)
from teaches
where semester = 'Spring' and year = 2018;
```
- 使用count关键字统计()内的具有对应属性的行数

### Aggregation with Grouping
```sql
select dept_name, avg (salary) as avg salary
from instructor
group by dept_name;
```
这里把instructor用dept_name分组,从而统计出每个部门的avg_salary.
- 也就是说`group by` 需要在select语句中写明操作的对象,才能在结果中反映出来分组的结果
```sql
/* erroneous query */
select dept_name, ID, avg (salary)
from instructor
group by dept_name;
```
- 上述sql语句由于一个分组中的tuple可以有不同的id属性,故不能变成一个分组,会引发错误

>总结一下:
当 SQL 查询包含 GROUP BY 子句时，SELECT 子句中的任何属性（列名）**必须满足以下两个条件之一**，否则该查询在逻辑上是错误的：

1. 该属性出现在 GROUP BY 子句中。
2. 该属性被包裹在聚合函数（如 SUM, COUNT, AVG, MAX, MIN）之中。


**进阶版**
```sql
select dept_name, count (distinct ID) as instr count
from instructor, teaches
where instructor.ID = teaches.ID and
semester = 'Spring' and year = 2018
group by dept_name;
```
- “Find the number of instructors in each department who teach a course in the Spring 2018 semester.” 

### The Having Clause
为了处理分组,而不是处理分组后的tuples,引入了**having** clause.
```sql
select dept name, avg (salary) as avg_salary
from instructor
group by dept name
having avg (salary) > 42000;
```
- 上述语句会过滤掉ayg_salary小于等于42000的分组

The logical execution sequence of an SQL query containing aggregation, `GROUP BY`, or `HAVING` clauses is defined as follows:

1.  **Evaluate the `FROM` clause**
    The `FROM` clause is first evaluated to generate a relation (the initial set of data from specified tables or joins).
2.  **Apply the `WHERE` clause** (if present)
    The predicate in the `WHERE` clause is applied to the result relation of the `FROM` clause. Only tuples satisfying this predicate proceed.
3.  **Apply the `GROUP BY` clause** (if present)
    Tuples satisfying the `WHERE` predicate are placed into groups based on the `GROUP BY` clause. If the `GROUP BY` clause is absent, the entire set of filtered tuples is treated as a single group.
4.  **Apply the `HAVING` clause** (if present)
    The `HAVING` clause is applied to each group. Groups that do not satisfy the `HAVING` clause predicate are removed entirely.
5.  **Evaluate the `SELECT` clause**
    The `SELECT` clause uses the remaining groups to generate the final result tuples. Aggregate functions are applied here to produce a single result tuple for each group.

**长难句分析**
```sql
select course_id, semester, year, sec_id, avg (tot_cred)
from student, takes
where student.ID= takes.ID and year = 2017
group by course_id, semester, year, sec_id
having count (ID) >= 2;
```
- 这里把学生按照“班级”扔进不同的筐里。比如“数据库-2017-秋-01班”是一个筐，“算法-2017-秋-02班”是另一个筐

>也就是说,group by后面的属性全部相同时才会被归为一组
###  Aggregation with Null and Boolean Values
```sql
select sum (salary)
from instructor;
```
当salary中有null值的时候,并不会像普通的`5+null=null`一样返回null,而是会忽略null

>In general, aggregate functions treat nulls according to the following rule: All aggre-
gate functions except count (*) ignore null values in their input collection. As a result
of null values being ignored, the collection of values may be empty. The count of an
empty collection is deﬁned to be 0, and all other aggregate operations return a value
of null when applied on an empty collection

- 由于count是统计行数的,故当某一行有null时也会计入

## Nested Subqueries
>A subquery is a **select-from-where** expression that is nested within another query. A common use of subqueries is to perform tests for set membership, make set comparisons, and determine set cardinality by nesting subqueries in the **where** clause. 
### Set Membership
```sql
select distinct course_id
from section
where semester = 'Fall' and year= 2017 and
course_id in (select course_id
              from section
              where semester = 'Spring' and year= 2018);
```
We use the not in construct in a way similar to the in construct. For example, to ﬁnd
all the courses taught in the Fall 2017 semester but not in the Spring 2018 semester,
which we expressed earlier using the except operation, we can write:
```sql
select distinct course id
from section
where semester = 'Fall' and year= 2017 and
course id not in (select course id
from section
where semester = 'Spring' and year= 2018);
```
- 也就是说,之前提到的intersect和except都可以用subquery的形式来解决


### Set Comparison
The phrase “greater than at least one” is represented in SQL by **> some**.
```sql
select name
from instructor
where salary > some (select salary
from instructor
where dept_name = 'Biology');
```
>SQL also allows < some, <= some, >= some, = some, and <> some comparisons.
As an exercise, verify that = some is identical to in, whereas <> some is not the same as not in.

The construct **> all** corresponds to the phrase “greater than all.”

```sql
select name
from instructor
where salary > all (select salary
from instructor
where dept name = 'Biology');
```
As it does for some, SQL also allows < all, <= all, >= all, = all, and <> all comparisons.
As an exercise, verify that <> all is identical to not in, whereas = all is not the same as
in.

### Test for Empty Relations
The **exists** construct returns the value true if the argument subquery is nonempty. 
```sql
select course_id
from section as S
where semester = 'Fall' and year= 2017 and
  exists (select *
          from section as T
          where semester = 'Spring' 
          and year= 2018 
          and S.course_id= T .course_id);
```
>The above query also illustrates a feature of SQL where a correlation name from
an outer query (S in the above query), can be used in a subquery in the where clause.
A subquery that uses a correlation name from an outer query is called a correlated
subquery.

当然,有exists就有`not exists`:
```sql
select S.ID, S.name
from student as S
where not exists ((select course_id
                    from course
                    where dept_name = 'Biology')
                    except
                    (select T .course_id
                    from takes as T
                    where S.ID = T .ID));
```
**长难句分析**
首先计算“Biology 系开设了，但该学生没选”的课程,如果这类课程not exists,说明该学生选了所有Biology系的课程.

### Test for the Absence of Duplicate Tuples(3/18)
Using the **unique** construct, we can write the query “Find all courses that were oﬀered at most once in 2017” as follows:
- 如果你记忆力够好的话,可能会记得之前在create table的时候会用unique来保证对应的属性不能有重复值

```sql
select T .course id
from course as T
where unique (select R.course id
from section as R
where T .course id= R.course id and
R.year = 2017);
```
>Note that if a course were not oﬀered in 2017, the subquery would return an empty result, and the unique predicate would evaluate to true on the empty set.
也就是说即使结果为空,但由于是unique,故也会返回true.

当然,有了unique就有`not unique`,要求返回结果中的每个tuple至少出现两次
```sql
select T .course id
from course as T
where not unique (select R.course id
                  from section as R
                  where T .course id= R.course id and
                  R.year = 2017);
```
- 可以看到,where部分的subquery可以访问外层的关系
### Subqueries in the From Clause
```sql
select dept name, avg salary
from (select dept name, avg (salary)
      from instructor
      group by dept name)
      as dept avg (dept name, avg salary)
where avg salary > 42000;
```
- 是的,from的关系也能用别名...

但是值得注意的是,**在from中的subquery不能访问外层的关系**,因为from中的关系是相互并列的,不存在嵌套关系,只能通过lateral关键字来强制让后继关系能够获取前置关系

```sql
select name, salary, avg_salary
from instructor I1, lateral (select avg(salary) as avg_salary
from instructor I2
where I2.dept name= I1.dept_name);
```
>如果你跟我一样从头看到这里的话,你会清楚的记得前面都是写类似`instructor as I1`的方式来起别名的,但是as实际上是**可选的**!尽管这里并没有提到这一点-这也是我讨厌这本教材的原因之一.
### The With Clause
>The **with** clause provides a way of deﬁning a temporary **relation** whose deﬁnition is available only to the query in which the **with** clause occurs. 
```sql
with max_budget (value) as
  (select max(budget)
  from department)
select budget
from department, max_budget
where department.budget = max_budget.value;
```
注意到这里是先写别名再在as后写原关系,而我们之前都是先写原关系再写as的

> with得到的是关系而非属性,因此我们每次都需要用关系(属性)的方式来使用with

- 实际上,上述的with语句完全可以放到where中
```sql
select budget
from department
where budget = (select max(budget) from department);
```
>We could have written the preceding query by using a nested subquery in either the from clause or the where clause. 
However, using nested subqueries would have made the query harder to read and understand. The with clause makes the query logic clearer;
it also permits this temporary relation to be used in multiple places within a query.

### Scalar(标量) Subqueries
>SQL allows subqueries to occur wherever an expression returning a value is permitted,provided the subquery returns only one tuple containing a single attribute; such sub-queries are called scalar subqueries.

- 也就是说只返回一行一列
**长难句分析**
```sql
select dept_name,
        (select count(*)
          from instructor
          where department.dept_name = instructor.dept_name)
        as num_instructors
from department;
```
- `select count(*)`在这里是无论是否有空值都返回满足`epartment.dept_name = instructor.dept_name`的所有行的意思
### Scalar Without a From Clause
```sql
(select count (*) from teaches) / (select count (*) from instructor);
-- 在某些数据库中会由于没有from语句而报错
select (select count (*) from teaches) / (select count (*) from instructor) from dual;
-- 提供了一个dummy relation来提供from语句且不产生其他副作用
```
## Modification of the Database(3/19)
### Deletion
>A delete request is expressed in much the same way as a query. We can delete only whole tuples; we cannot delete values on only particular attributes. SQL expresses a deletion by:
```sql
delete from r
where P;
-- where P represents a predicate and r represents a relation.
-- The where clause can be omitted, in which case all tuples in r are deleted.
```

```sql
delete from instructor
where salary between 13000 and 15000;
--  Delete all instructors with a salary between $13,000 and $15,000.
```
- 事实上delete与select的用法没有什么区别,只不过一个是选择关系,一个是删除关系而已.

### Insertion
> The attribute values for inserted tuples must be members of the corresponding attribute’s domain. Similarly, tuples inserted must have the correct number of attributes.
```sql
insert into course
values ('CS-437', 'Database Systems', 'Comp. Sci.', 4);

-- 如果忘记了表的顺序,那么可以具体写出属性名来插入,这三种写法的结果完全相同
insert into course (course id, title, dept name, credits)
values ('CS-437', 'Database Systems', 'Comp. Sci.', 4);

insert into course (title, course id, credits, dept name)
values ('Database Systems', 'CS-437', 4, 'Comp. Sci.');

```

```sql
insert into instructor
      select ID, name, dept name, 18000
      from student
      where dept name = 'Music' and tot cred > 144;
```
当然,我们可以从其他关系中获取tuple后再插入,而不是只用value来具体写.
### Updates
>n certain situations, we may wish to change a value in a tuple without changing all values in the tuple. For this purpose, the **update** statement can be used. 
```sql
update instructor
set salary= salary * 1.05;
-- 我们可以对某一列属性整体生效

update instructor
set salary = salary * 1.05
where salary < 70000;
-- 也可以对该列属性的部分值生效

update instructor
set salary = salary * 1.05
where salary < (select avg (salary)
from instructor);
-- 还可以对满足子查询的属性值生效
```
**进阶写法**
```sql
update instructor
set salary = case
              when salary <= 100000 then salary * 1.05
              else salary * 1.03
            end
-- 具体模板如下
-- case
  -- when pred 1 then result1
  -- when pred 2 then result2
  -- …
  -- when pred n then resultn
  -- else result0
-- end
```

# Intermediate SQL(3/15)
## Join Expressions
事实上,单独的join语句不加任何前缀和后缀会报错,因为不存在只写一个join而不进行过滤操作的语法.
### The Natural Join
```sql
select name, course_id
from student, takes
where student.ID = takes.ID;
```
上述语句在执行的中间结果中会保留两个ID列,只是在select时抛弃掉了而已.
```sql
select name, course id
from student natural join takes;
```
而`natural join`的中间结果只保留一个ID列
规则:
1. 找到同名列
2. 过滤掉同名列中的值不相等的行
3. 两个同名列只保留一列

```sql
select name, title
from (student natural join takes) join course using (course_id);
```
The operation **join … using** requires a list of attribute names to be speciﬁed. Both relations being joined must have attributes with the speciﬁed names.
- 也就是说只用using()里面那个属性在join的时候来判断,而不像natural join一样在有多个同名属性的情况下全都要求相等.
###  Join Conditions
>The **on** condition allows a general predicate over the relations being joined. 
```sql
select *
from student join takes on student.ID = takes.ID;
```
完全等价于下面语句,也就是结果都保持了两个ID列
```sql
select *
from student, takes
where student.ID = takes.ID;
```
- 所以基本用不上on
### Outer Joins
```sql
select *
from student natural join takes;
```
由于natural join会丢弃`takes.id!=student.id`的行,对于只在一个表中存在的ID,由于在另一个表中找不到对等的值,也会被抛弃,但在实际需求中,即使没选课的学生,我们也希望展示出来,故这里需要使用**outer join**.

There are three forms of outer join:
- The left outer join preserves tuples only in the relation named before the left outer join operation.
- The right outer join preserves tuples only in the relation named after the right outer join operation.
- The full outer join preserves tuples in both relations.

In contrast, the join operations we studied earlier that do not preserve nonmatched tuples are called **inner-join** operations, to distinguish them from the **outer-join** operations.

>We now explain exactly how each form of outer join operates. We can compute
the left outer-join operation as follows: First, compute the result of the inner join as
before. Then, for every tuple t in the left-hand-side relation that does not match any
tuple in the right-hand-side relation in the inner join, add a tuple r to the result of the
join constructed as follows:

- The attributes of tuple r that are derived from the left-hand-side relation are ﬁlled in with the values from tuple t.
- The remaining attributes of r are ﬁlled with null values.

```sql
select *
from student natural left outer join takes;
```
如果对于在student里出现但在takes里没有的id,会将student表中的值填入,对应takes部分的值均为null.

>The **full outer join** is a combination of the left and right outer-join types. After the
operation computes the result of the inner join, it extends with nulls those tuples from
the left-hand-side relation that did not match with any from the right-hand-side relation
and adds them to the result. Similarly, it extends with nulls those tuples from the right-
hand-side relation that did not match with any tuples from the left-hand-side relation
and adds them to the result. Said diﬀerently, full outer join is the union of a left outer
join and the corresponding right outer join.

- 也就是说保留两边的缺值

**进阶例子**
```sql
select *
from (select *
from student
where dept name = 'Comp. Sci.')
natural full outer join
(select *
from takes
where semester = 'Spring' and year = 2017);
```
>一开始明明都是用`student natural full outer join takes`的,这里为什么要单独把两个结果提出来呢?

```sql
select *
from student
natural full outer join takes
where dept_name = 'Comp. Sci.'
  and semester = 'Spring'
  and year = 2017;
```
因为如果这样写的话,尽管在from部分保留了null,但where部分又把null全部过滤掉了

>The **on** condition is part of the outer join speciﬁcation, but a **where** clause is not. 

```sql
select *
from student left outer join takes on student.ID = takes.ID;
```
也就是说上面这个语句不等价于下面的,因为on是在join阶段生效,即使不匹配也会置为null;
而where是在join之后生效,因此where会过滤掉null行,而上面语句中的on则会保留
```sql
select *
from student left outer join takes on true
where student.ID = takes.ID;
```

### Join Types and Conditions
The keyword **inner** is optional:
```sql
select *
from student join takes using (ID);
```
is equivalent to:
```sql
select *
from student inner join takes using (ID);
```
Similarly, natural join is equivalent to natural inner join.

## Views
>SQL allows a “virtual relation” to be deﬁned by a query, and the relation conceptually contains the result of the query. The virtual relation is not precomputed and stored but instead is computed by executing the query whenever the virtual relation is used.

因此就有了view这个概念用来代表尚未执行的sql语句
### View Definition
```sql
create view v as <query expression>;
```
where < query expression > is any legal query expression. The view name is represented v

```sql
create view faculty as
select ID, name, dept name
from instructor;
```
通过这样写,可以给低权限用户传递view这个关系而不直接接触instructor这个关系.

###  Using Views in SQL Queries
The attribute names of a view can be speciﬁed explicitly as follows:
```sql
create view departments total salary(dept name, total salary) as
select dept name, sum (salary)
from instructor
group by dept name;
```
Since the expression sum(salary) does not have a name, the attribute name is speciﬁed explicitly in the view deﬁnition.

###  Update of a View
Not recommended!
## Transactions
blablabla...

## Integrity Constraints
### Constraints on a Single Relation
- not null
- unique
- check(<predicate>)

### Not Null Constraint
```sql
name varchar(20) not null
budget numeric(12,2) not null
```
The not null constraint prohibits the insertion of a null value for the attribute, and is an example of a domain constraint. 

###  Unique Constraint
The unique speciﬁcation says that no two tuples in the relation can be equal on all the listed attributes.

###  The Check Clause
>When applied to a relation declaration, the clause check(P) speciﬁes a predicate P that must be satisﬁed by every tuple in a relation.
```sql
create table section
(course id
 varchar (8),
sec id
 varchar (8),
semester
 varchar (6),
year
 numeric (4,0),
building
 varchar (15),
room number varchar (7),
time slot id varchar (4),
primary key (course id, sec id, semester, year),
check (semester in ('Fall', 'Winter', 'Spring', 'Summer')));
```
Here, we use the **check** clause to simulate an enumerated type by specifying that semester must be one of 'Fall', 'Winter', 'Spring', or 'Summer'.

还可以把check写在定义的属性之后
```sql
CREATE TABLE classroom (
    building    VARCHAR(15),
    room_number VARCHAR(7),
    capacity    NUMERIC(4,0),
    PRIMARY KEY (building, room_number)
);

CREATE TABLE department (
    dept_name   VARCHAR(20),
    building    VARCHAR(15),
    budget      NUMERIC(12,2) CHECK (budget > 0),
    PRIMARY KEY (dept_name)
);

CREATE TABLE course (
    course_id   VARCHAR(8),
    title       VARCHAR(50),
    dept_name   VARCHAR(20),
    credits     NUMERIC(2,0) CHECK (credits > 0),
    PRIMARY KEY (course_id),
    FOREIGN KEY (dept_name) REFERENCES department 
);

CREATE TABLE instructor (
    ID          VARCHAR(5),
    name        VARCHAR(20) NOT NULL,
    dept_name   VARCHAR(20),
    salary      NUMERIC(8,2) CHECK (salary > 29000),
    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name) REFERENCES department 
);

CREATE TABLE section (
    course_id    VARCHAR(8),
    sec_id       VARCHAR(8),
    semester     VARCHAR(6) CHECK (semester IN ('Fall', 'Winter', 'Spring', 'Summer')),
    year         NUMERIC(4,0) CHECK (year > 1759 AND year < 2100),
    building     VARCHAR(15),
    room_number  VARCHAR(7),
    time_slot_id VARCHAR(4),
    PRIMARY KEY (course_id, sec_id, semester, year),
    FOREIGN KEY (course_id) REFERENCES course ,
    FOREIGN KEY (building, room_number) REFERENCES classroom 
);
```

### Referential Integrity

**默认引用 (Implicit Reference)**
`foreign key (dept_name) references department`

* **底层行为**：当你省略括号中的属性名时，SQL 标准规定该外键必须引用被参照表的 **主键 (Primary Key)**

**显式引用 (Explicit Reference)**
`foreign key (dept_name) references department(dept_name)`

* **底层行为**：目标列（dept_name）不必是主键，但必须具有 唯一性约束 (UNIQUE) 或本身就是 主键。即它必须是一个 超键 (Superkey)。

### Assigning Names to Constraints

```sql
-- 使用constraint关键字命名该限制
salary numeric(8,2), constraint minsalary check (salary > 29000),
-- 删除该限制
alter table instructor drop constraint minsalary;
```
### Complex Check Conditions and Assertions
>An **assertion** is a predicate expressing a condition that we wish the database always
to satisfy. 

**格式**
```sql
create assertion <assertion-name> check <predicate>;
```
```sql
create assertion credits earned constraint check
(not exists (select ID
            from student
            where tot_cred <> (select coalesce(sum(credits), 0)
            from takes natural join course
            where student.ID= takes.ID
              and grade is not null and grade<> ’F’ )))
```
- 非常好的是这种东西不会考,因为主流数据库也不用

## SQL Data Types and Schemas
>There are additional built-in data types supported by SQL, which we describe below. 

### Date and Time Types in SQL

- date: A calendar date containing a (four-digit) year, month, and day of the month.
- time: The time of day, in hours, minutes, and seconds. 
- timestamp: A combination of date and time.

Date and time values can be speciﬁed like this:
```sql
date '2018-04-25'
-- Dates must be speciﬁed in the format year followed by month followed by day
time '09:30:00'
timestamp '2018-04-25 10:29:01.45'
```
### Type Conversion and Formatting Functions(过)
- 由于我找到了中文版教材,故从现在开始大部分使用中文版,少部分使用英文版(因为这本书真的是又臭又长)


**1. 显式类型转换 (Type Casting)**
**语法：** `cast(expression as data_type)`  
**用途：** 物理改变数据的解析方式，常用于修正字符串排序逻辑。

```sql
/* 修正前：'11' 会排在 '2' 前面（字符串字典序） */
select ID from instructor order by ID;

/* 修正后：将字符串物理转为数字，实现数值大小排序 */
select ID 
from instructor 
order by cast(ID as numeric);
```

---

**2. 格式化函数 (Formatting Functions)**
**用途：** 不改变物理类型，只给数据套上“显示滤镜”。各数据库系统实现不同。

```sql
-- MySQL: 数字千分位格式化
select format(salary, 2) from instructor; 

-- PostgreSQL/Oracle: 日期转特定格式字符串
select to_char(now(), 'YYYY-MM-DD'); 

-- SQL Server: 风格化转换
select convert(varchar, getdate(), 101); -- 返回 mm/dd/yyyy
```


---

**3. 空值合并 (Coalesce)**
**语法：** `coalesce(arg1, arg2, ...)`  
**逻辑：** 物理扫描参数列表，返回第一个非 `null` 的值。要求所有参数**物理类型一致**。

```sql
/* 如果 salary 是 null，物理替换为 0 以便后续数学运算 */
select ID, coalesce(salary, 0) as actual_salary
from instructor;

/* 错误示例：coalesce(salary, 'N/A') 会报错，因为数字和字符串类型不匹配 */
```

---

**4. 条件解码 (Decode - Oracle 特有)**
**语法：** `decode(value, search, result, default)`  
**逻辑：** 类似于 `switch-case`。它允许 `null = null` 的物理匹配，且**不强制要求类型一致**。

```sql
/* 将物理空值直接翻译成业务描述字符串 'N/A' */
select ID, decode(salary, null, 'N/A', salary) as salary_text
from instructor;
```

- 随便一看就知道不会考的...

### Default Values
SQL allows a default value to be speciﬁed for an attribute as illustrated by the following
create table statement:
```sql
create table student
    (ID varchar (5),
    name varchar (20) not null,
    dept_name varchar (20),
    tot_cred numeric (3,0) default 0,
    primary key (ID));
```

### Large-Object Types
>SQL provides large-object data types for character data (clob) and binary data (blob). 
The letters “lob” in these data types stand for “Large OBject.”

```sql
book_review clob(10KB)
image blob(10MB)
movie blob(2GB)
```
### User-Defined Types(过)
>SQL supports two forms of user-deﬁned data types. 
The ﬁrst form, which we cover here, is called **distinct types**.

The create type clause can be used to deﬁne new types:
```sql
create type Dollars as numeric(12,2) ﬁnal;
create type Pounds as numeric(12,2) ﬁnal;

create table department
(dept name
 varchar (20),
building
 varchar (15),
budget
 Dollars);
```


- 这一节也不重要,因为主流数据库也不支持

### Generating Unique Key Values
```sql
ID number(5) generated always as identity
-- When the always option is used, any insert statement must avoid specifying a value
-- for the automatically generated key. 

insert into instructor (name, dept_name, salary)
values ('Newprof', 'Comp. Sci.', 100000);
```

### Create Table Extensions
>Applications often require the creation of tables that have the same schema as an existing table. 
```sql
-- SQL provides a create table like extension to support this task
create table temp_instructor like instructor;
```

## Schemas, Catalogs, and Environments(过)

## Index Definition in SQL(过)
由于这部分基本什么都没讲,还是得到index章节去看

## Authorization
>We may assign a user several forms of authorizations on parts of the database. Authorizations on data include:

• Authorization to **read** data.
• Authorization to **insert** new data.
• Authorization to **update** data.
• Authorization to **delete** data.

- Each of these types of authorizations is called a privilege. 
### Granting and Revoking of Privileges

```sql
-- grant的使用格式
grant <privilege list>
on <relation name or view name>
to <user/role list>;

-- grants database users Amit and Satoshi select authorization on the department relation:
grant select on department to Amit, Satoshi;

-- If the list of attributes is omitted, the update privilege will be granted on all attributes of the relation.
grant update (budget) on department to Amit, Satoshi;

-- To revoke an authorization, we use the revoke statement. It takes a form almost identical to that of grant:
revoke <privilege list>
on <relation name or view name>
from <user/role list>;

revoke select on department from Amit, Satoshi;
revoke update (budget) on department from Amit, Satoshi;
```
### Roles
- 我们使用Roles来解决需要多次指定相同权限的问题
```sql
create role instructor;

-- Roles can then be granted privileges just as the users can,
grant select on takes
to instructor;

-- Roles can be granted to users, as well as to other roles,
create role dean;
grant instructor to dean;
grant dean to Satoshi;
```
### Authorization on Views
```sql
-- 为了让某个工作人员能够看到地质系的所有教师但不能看到其他系的教师表,我们可以这样写:
create view geo_instructor as
(select *
from instructor
where dept name = 'Geology');

-- 但是,下面的操作实际上还是间接的访问了instructor表
select *
from geo_instructor;
```
### Authorizations on Schema
>SQL includes a **references** privilege that permits a user to declare **foreign keys** when creating relations.

```sql
grant references (dept_name) on department to Mariano;
```
为什么要限制引用外码呢?
>However, recall that foreign-key constraints
**restrict deletion and update** operations on the referenced relation. Suppose Mariano
creates a foreign key in a relation r referencing the dept name attribute of the department
relation and then inserts a tuple into r pertaining to the Geology department. It is no
longer possible to delete the Geology department from the department relation without also modifying relation r. 

### Transfer of Privileges
当我们授予某用户一个权限时,默认他是无法将获得的权限传递给其他用户的,如果希望他能够传递权限,我们可以这样写:
```sql
grant select on department to Amit with grant option;
```
- 当然,关系/视图/角色(relation/view/role) 的创建者拥有该对象的所有权限并且可以给其他用户授权(不然就没人能授权了)

### Revoking of Privileges(过)


# Advanced SQL
- 事实上,这部分我觉得期末不考,我猜老师自己也不会😅
  - (4/8): 第一次小测考了前三节,...
## Accessing SQL from a Programming Language(过)
### JDBC
- 你猜怎么着,我们的课程安排是在学完这门课后再学java...
>The **JDBC** standard deﬁnes an application program interface (API) that Java programs can use to connect to database servers. (The word JDBC was originally an abbreviation for **Java Database Connectivity**, but the full form is no longer used.)

### ODBC
>The **Open Database Connectivity** (ODBC) standard deﬁnes an API that applications can use to open a connection with a database, send queries and updates, and get back results. 


## Functions and Procedures(待补充)

## Triggers(待补充)
>A **trigger** is a statement that the system **executes automatically** as a side eﬀect of a modiﬁcation to the database. 
- 也就是说,trigger是一个满足条件时自动执行的函数


# 第一次小测复习
## ch1
### 使用文件处理系统而不是数据库的弊端
- Data redundancy and inconsistency: 可能有多个文件记录了相同的信息,又或者不同文件的记录不相同,没有同步更新
- Diﬃculty in accessing data: 普通的编程语言不能做到用高效又便利的方式取回数据
- Data isolation: 数据被存储在不同类型的不同文件中,很难统一管理
- Integrity problems: 很难通过普通的编程语言去给存储的数据加上各种限制
- Atomicity problems: 转账时,如果在付款方付钱后系统故障,那么收款方账户未必会收到钱,但付款方账户已经扣了钱.也就是说,很难实现这样一种效果:要么两边操作全都发生,要么都不发生
- Concurrent-access anomalies: 并发访问数据时可能导致异常
- Security problems: 很难设置不同管理员的权限
### 数据库结构的基础: 数据模型
本书介绍了4种模型:
1. **Relational Model**: uses a collection of tables to represent **both data and the relationships among those data**. Each table has multiple columns, and each column has a unique name. Tables are also known as relations.
2. Entity-Relationship Model: The entity-relationship (E-R) data model uses a collection of basic objects, called *entities*, and relationships among these objects.
3. Semi-structured Data Model: individual data items of the same type may have diﬀerent sets of attributes. 
4. Object-Based Data Model: 仅仅是第一种类型的扩展,适用于面向对象的编程语言
## ch2: Introduction to the Relational Model
### schema到底是什么
- Relation Schema（关系模式）：对应编程中的“类型定义”或“类声明”。
  - 物理组成：由属性名（Attributes）及其对应的域（Domains/Data Types）组成。
  - 示例分析：`department (dept_name, building, budget)` 物理规定了任何存入该表的记录必须且只能包含这三个维度。
- Database Schema（数据库模式）：对应软件架构中的“逻辑设计”。
## ch3
### 数据类型
- char(n): 固定长度为n的字符串
- varchar(n): 最大长度为n的可变长字符串
- int: 整数
- numeric(p,d): 有p位数字(加上一个符号位)和小数点右边的p位中的d位数字
- float(n): 精度至少为n位数字的浮点数

### 操纵关系表 
**创建表**时可以对变量使用以下六个限制:
1. primary key(d): d非空且唯一
2. foreign key(d) references s: d的值必须出现在s的对应主码上
3. foreign key(d) references s(t): d的值必须与t对应,要求t是唯一的,即具有unique约束
4. not null: 非空
5. unique: 唯一
6. check(d...): 要求新加入的d满足对应条件,否则插入时报错
```sql
create table department(
  dept_name varchar(20) not null,
  building varchar(15) unique,
  budget numeric(12,2),check(buget>0),
  primary key(dept_name)
);
```

**删除表或更改属性**
```sql
-- 删除表r
drop table r;

-- 增加(删除)属性A,类型为D
alter table r add A D;
-- alter table r drop A 很多数据库系统不支持
```
**删除元组**
```sql
-- 删除表r中的所有元组,保留框架
delete from r;
-- 删除满足条件P的元组
delete from r
where P;
```

**插入元组**
```sql
-- 需要按照属性名顺序来,否则可能会插入失败
insert into r
  values(a1,a2,a3,....)
-- 指定插入值的对应属性
insert into course (course id, title, dept name, credits)
values ('CS-437', 'Database Systems', 'Comp. Sci.', 4);

-- 插入查询结果
insert into instructor
select ID, name, dept_name, 18000
from student
where dept name = 'Music' and tot_cred > 144;
```

**更新元组**

```sql
-- 更改满足条件的属性名
update instructor
set salary = salary * 1.05
where salary < 70000;
```

### select...from...where 
#### **select基础部分**
```sql
-- !!!select会选中null行,不自动过滤!!!
-- 默认启用all保留重名行
select (all) dept_name
from instructor;
-- 去掉重名行
select distinct dept_name
from instructor;
-- 简单计算
select ID,salary*1.1
from insructor;

-- 选中所有关系的所有属性
select *
from instructor
-- 选中一个关系的所有属性
select instructor.*
from instructor, teaches
where instructor.ID= teaches.ID;
```
#### **select进阶部分**
```sql
-- max,min,avg,sum:均为op(attribute)格式
select avg (salary)
from instructor
where dept_name = 'Comp. Sci.';
-- 启用as
select avg (salary) as avg_salary
from instructor
where dept_name = 'Comp. Sci.';

-- count(attribute)和count(*)

-- count(attribute): 过滤重名行,一个ID统计一行,但会忽略ID为null的行
select count (distinct ID)
from teaches
where semester = 'Spring' and year = 2018;

-- count(*): 统计所有行,包括存在空值的行
select count (*)
from course;
```

#### **from基础部分**
```sql
-- 启用as
select T .name, S.course_id
from instructor as T , teaches as S
where T .ID= S.ID; 
```
#### **where基础部分**
```sql
-- =判断符
select name
from instructor
where dept_name = 'Comp. Sci.'
-- >,<,>=,<=判断符
select distinct T .name
from instructor as T , instructor as S
where T.salary > S.salary
-- and,or联结词
select name
from instructor
where dept_name = 'Comp. Sci.' and salary > 70000;
-- (not) between...and...联结词
select name
from instructor
where salary between 90000 and 100000;
-- 等价于
select name
from instructor
where salary <= 100000 and salary >= 90000;


-- 字符串比较: like,not like
-- 注意sql中只有单引号,没有双引号
-- %: 匹配任意子串
-- _: 匹配任意一个字符
-- ___%: 匹配至少含有任意三个字符的字符串

select dept_name
from department
where building like '%Watson%';

```
#### **where进阶**
```sql
-- 构造器写法: (a,b)=(c,d)-> a=c and b=d
select name, course_id
from instructor, teaches
where (instructor.ID, dept_name) = (teaches.ID, 'Biology');

-- unknown: 如果对于某一个元组来说,判断符(即使是=)的一边为null,那么结果就是unkown ,则该元组不能被加入到结果中

-- is (not) null,is (not) unknown
select name
from instructor
where salary is null;

select name
from instructor
where salary > 10000 is unknown;
-- 解释: 只有salary为null的行才可以出现在结果中
```
#### where中的子查询
**in,not in**
```sql
select distinct course_id
from section
where semester = 'Fall' and year= 2017 and
course_id in (select course_id
              from section
              where semester = 'Spring' and year= 2018);
```
**some**
```sql
select name
from instructor
where salary > some (select salary
from instructor
where dept_name = 'Biology');
-- 至少比生物学部门的一个老师工资要高
```
>SQL also allows **< some**, **<= some**, **>= some**, **= some**, and **<> some** comparisons.
As an exercise, verify that **= some** is identical to **in**, whereas **<> some** is not the same as **not in**.
**all**
```sql
select name
from instructor
where salary > all (select salary
from instructor
where dept_name = 'Biology');
-- 比生物学部门的所有老师工资都高
```
>SQL also allows **< all**, **<= all**, **>= all**, **= all**, and **<> all** comparisons.
As an exercise, verify that **<> all** is identical to **not in**, whereas **= all** is not the same as **in**.
**(not) exists**
```sql
select course_id
from section as S
where semester = 'Fall' and year= 2017 and
  exists (select *
          from section as T
          where semester = 'Spring' 
          and year= 2018 
          and S.course_id= T .course_id);
```
exists的原理: 当括号内的查询第一次被满足时即返回true,让sql引擎继续扫描下一行.

**unique**
```sql
select T .course id
from course as T
where unique (select R.course id
from section as R
where T .course id= R.course id and
R.year = 2017);
```
如果无重复元组则返回true,无论元组是否为空

#### from中的子查询
```sql
select dept_name, avg_salary
from (select dept_name, avg (salary)
      from instructor
      group by dept_name)
      as dept_avg (dept_name, avg_salary)
where avg_salary > 42000;
```
#### with: 子查询的变种
```sql
with max_budget (value) as
(select max(budget)
from department)
select budget
from department, max_budget
where department.budget = max_budget.value;
```
#### 标量子查询
```sql
select dept_name,
(select count(*)
from instructor
where department.dept_name = instructor.dept_name)
as num_instructors
from department;
```

### having和group by
**group by**
```sql
-- 在group子句中的所有属性取值相同的元组将被分在一个组内,显然,当涉及的属性名越多,分的组也会越多
select dept_name, avg (salary)
from instructor
group by dept_name;
```
注意,没有出现在group by中的属性只能以聚集函数的参数形式在select语句中出现,如下方的例子中ID就是不该出现的属性,因为一个组中的教师可以有不同的ID,那就无法选定保留哪一个ID:

```sql
/* erroneous query */
select dept_name, ID, avg (salary)
from instructor
group by dept_name;
```
#### having: 作用于group的条件判断
```sql
select dept_name, avg (salary) as avg_salary
from instructor
group by dept_name
having avg (salary) > 42000;
-- 平均薪资低于42000的部门分组将被过滤掉
```
### 关系的集合
- 三种运算均自动去重
```sql
-- union(并集): 找到至少在一个关系中出现的被select选中的元组,自动去重
-- union all: 保留重复项
(select course_id
from section
where semester = 'Fall' and year= 2017)
union
(select course_id
from section
where semester = 'Spring' and year= 2018);
-- intersect(交集): 找到在两个关系中都出现的被select选中的元组,自动去重
-- intersect all: 保留重复项
(select course_id
from section
where semester = 'Fall' and year= 2017)
intersect
(select course_id
from section
where semester = 'Spring' and year= 2018);
-- except(差集): 找到在前一个关系中出现,但不在第二个关系中出现的,被select选中的元组,自动去重
-- except all: 保留重复项
```


### 排在最末尾的order by: 结果排序
```sql
-- 不写默认为升序asc
select name
from instructor
where dept_name = 'Physics'
order by name; -- 排序按字典序,首字母大的在后面
-- 先排第一个,同名再按第二个排
select *
from instructor
order by salary desc, name asc;
```
### 习题3.1
**a**
```sql
select title
from course
where credits = 3 and dept_name = 'Comp.Sci.'
```
**b**
```sql
select distinct ID
from instructor,teaches,student,takes
where instructor.name='Einstein' and instructor.ID = teaches.ID  and student.ID =takes.ID and(takes.semester ,takes.sec_id,takes.year,teaches.course_id)=(teaches.semester ,teaches.sec_id,teaches.year,takes.course_id)
-- 写疯了
```
**c**
```sql
select max(salary)
from instructor
```

**d**
```sql
with max_salary(v) as (select max(salary) from instructor)
select ID,name
from instructor
where salary =max_salary(v)

-- 炫技写法1
select ID,name
from instructor
where salary >= all(select salary from instructor)

-- 2
select ID,name
from instructor 
where salary = (select max(salary)from instructor)
```
**e**
目标: 2017年 秋季 每个课程段 选课人数
approach: section,takes
```sql
select count(ID),course_id,sec_id;
from section natural join takes
where year=2017 and semester='autumn'
group by coures_id,sec_id;
```
**f**
target: max enrollment in Autumn 2009
```sql
with enrollment(counts) as (
  select count(ID)
  from section natural join takes
  where semester = 'Autumn' and year = 2009
  group by course_id, sec_id
)
select max(counts) from enrollment;
```

## ch4
### join
#### natural join: 自动去重的发散join
自动去重,多列匹配
```sql
select name, course id
from student, takes
where student.ID = takes.ID;

-- 两者作用相同,尽管from的结果不同,但select时没有选择ID列,所以看不出来区别
select name, course id
from student natural join takes;
```
#### join...using: 自动去重的定向join
>using 只能用于等值连接,不能配合其他谓词使用

```sql
select name, title
from (student natural join takes) join course using (course id);
```
相当于一个仅比对所需列的natural join,更加安全

#### join...on: 不自动去重的定向join
```sql
select *
from student join takes on student.ID = takes.ID;

-- 等价
select *
from student, takes
where student.ID = takes.ID;
```
- 当然,on在大多数情况下都可以用where直接替换,但对于outer join来说,二者是有所不同的
#### outer join: 保留空值的发散join前缀
>outer join本身不能直接使用,需要搭配on,natural或者using

当我们希望即便一边的ID有值,但另一边不存在这个ID时,也保留该行时,可以使用`outer join`.

有三种形式:
1. left outer join: 只保留左边关系中的元组
2. right outer join: 只保留右边关系中的元组
3. full outer join: 保留两边关系的元组

以left outer join为例子来说明:
1. The attributes of tuple r that are **derived from** the left-hand-side relation are ﬁlled in with the values from tuple t.
2. The remaining attributes of r are ﬁlled with **null values**.
![alt text](../images/2026-03-27/PixPin_2026-03-30_10-42-15.webp)

```sql
select ID
from student natural left outer join takes
where course id is null;



select *
from (select *
from student
where dept name = 'Comp. Sci.')
natural full outer join
(select *
from takes
where semester = 'Spring' and year = 2017);
```

# Database Design Using the E-R Model
数据库的设计并不简单,所以我们需要一些好用的模型来组织数据库,比如这章涉及的E-R模型.
- 忽然发现前面的笔记中废话太多了,像我的小测复习这样精炼就已经可以了,能够轻松的获取所需的信息
## The Entity-Relationship Model
- entity: a “thing” or “object” in the real world that is distinguishable from all other objects.
  - 实体是一个独一无二的个体
- attribute: 实体通过一组属性来表示,每个实体在它的每个属性上都有一个值(value)
- entity set: 共享部分属性的实体集合
- relationship: 多个实体之间的关系
- relationship set: 相同类型的联系集合

![alt text](../images/2026-04-08/PixPin_2026-04-09_09-40-11.webp)

- 看这个图就很好理解了,单独的两个实体,如Crick和Tanaka之间的关系就是relationship,而实体集之间的映射关系就是relationship set
## E-R图
- entity set: 使用矩形来表示,分为两个部分,一部分是实体集的名称,一部分是实体集所有属性的名称
- relationship set: 使用菱形来标识,通过线条连接到多个实体集
  - relationship set的描述性属性用单矩形虚线连接
![alt text](../images/2026-04-08/PixPin_2026-04-09_09-37-00.webp)

- **映射基数(mapping cardinality)**: 一个实体通过一个联系集关联的其他实体的数量,有以下四种:
  - 一对一: 从联系集到两个实体集各画一个有向线段
  - 一对多: "多方"使用无向线段连接,"一方"使用有向线段
  - 多对一: 与一对多刚好相反
  - 多对多: 两边都是无向线段
![alt text](../images/2026-04-08/PixPin_2026-04-10_08-44-57.webp)

![alt text](../images/2026-04-08/PixPin_2026-04-10_10-05-54.webp)

>The participation of an entity set E in a relationship set R is said to be **total** if every entity in E must participate in **at least one** relationship in R. 
If it is possible that some entities in E do not participate in relationships in R, the participation of entity set E in relationship R is said to be **partial**.

使用双线来表示一个实体集在联系集中全部参与.
### strong entity and weak entity


#### 强实体 (Strong Entity)
强实体是**自足的**，它不依赖于数据库中任何其他实体的存在。

* **物理特征**：拥有一个独立的**主键 (Primary Key)**。这个主键不包含任何其他实体的属性。
* **物理隐喻**：像一个拥有独立身份证的“自然人”。
* **ER 图标识**：矩形框。
* **例子**：`Student`（学生）。每个学生都有唯一的 `student_id`，无论这个学生是否选课，他作为“学生”这个实体的物理记录在数据库中都是独立存在的。

---

#### 弱实体 (Weak Entity)
弱实体是**寄生的**，它必须依赖于另一个实体（称为“标识实体”或“父实体”）才能获得物理意义上的唯一性。

* **物理特征**：没有足够的属性来构成自己的主键。它的主键是**物理借用**来的，由“父实体的物理主键 + 自己的部分键（Discriminator/Partial Key）”共同组成。
* **物理隐喻**：像“公寓里的房间”。没有公寓（父实体），“101室”这个编号物理上没有任何意义。
* **ER 图标识**：双边矩形框。
* **例子**：`Section`（开课班级）。单独看 `sec_id`（如 1 班）无法确定是哪门课。它必须物理依赖于 `Course`（课程），主键通常是 `(course_id, sec_id, semester, year)`。

### 概化与特化
![alt text](../images/2026-04-08/PixPin_2026-04-10_11-33-45.webp)
#### 特化 (Specialization) —— 自上而下
* **物理逻辑**：将一个高层级的实体集（父类）根据特定特征，物理拆分为多个低层级的子实体集（子类）。
* **触发场景**：当你发现某些属性只适用于部分成员，而不适用于全体时。
* **ER图表示**: 由特化实体用空心箭头指向父类,如果一个实体可以属于多个特化实体集,则称为**重叠特化(overlapping specialization)**,使用两个单独箭头;如果只能属于一个实体集,则称为**不相交特化(disjoint specialization)**,使用一个箭头
* **物理示例**：`员工 (Employee)` 实体。
    * 只有“厨师”拥有 `厨师等级` 属性。
    * 只有“司机”拥有 `驾驶证号` 属性。
    * **物理动作**：从 `员工` 集合中特化出 `厨师` 和 `司机` 子集。

#### 概化 (Generalization) —— 自下而上
* **物理逻辑**：提取多个实体集中的共同属性，物理归纳为一个更高层级的通用实体集（父类）。
* **触发场景**：为了消除数据冗余，并在物理层面提供统一的访问接口。
* **物理示例**：存在 `老虎`、`狮子`、`大象` 三个独立实体。
    * 它们物理上共有 `年龄`、`体重`、`所属区域` 等属性。
    * **物理动作**：将它们概化为 `动物 (Animal)` 实体。



### 汇总
![alt text](../images/2026-04-08/PixPin_2026-04-10_10-35-46.webp)


##  The Unified Modeling Language (UML)(待补充)
# Relational Database Design(较难,待补充)
根据上一章的E-R图我们可以导出一组关系模式:
![alt text](../images/2026-03-25/PixPin_2026-03-26_08-23-16.webp)
# Complex Data Types
>In this chapter, we discuss several non-atomic data types that are widely used,including **semi-structured data, object-based data, textual data, and spatial data**.
## Semi-structured Data
### Overview of Semi-structured Data Models
#### Flexible Schema
Some database systems allow each tuple to potentially have a diﬀerent set of attributes;
such a representation is referred to as a **wide column** data representation. 
The set of attributes is not ﬁxed in such a representation; **each tuple may have a diﬀerent set of attributes**, and new attributes may be added as needed.

A more restricted form of this representation is to have a ﬁxed but very large number of attributes, with each tuple using only those attributes that it needs, leaving the rest with null values; such a representation is called a **sparse column**(稀疏表)  representation.

#### Multivalued Data Types
>Some representations allow attributes to store key-value maps, which store key-value pairs. A **key-value map**, often just called a map, is a set of (key, value) pairs, such that each key occurs in at most one element. 
#### Nested Data Types
All of these data types represent a hierarchy of data types, and that structure leads to the use of the term nested data types. 
- JSON和XML是该数据库类型的最重要的两个代表

### JSON(JavaScript Object Notation)
>The **JavaScript Object Notation** (JSON), is a textual representation of complex data types that is widely used to transmit data between applications and to store complex data. 
JSON supports the primitive data types integer, real and string, as well as arrays,
and “objects,” which are a collection of (attribute name, value) pairs.


```json
{
  "ID": "22222",
  "name": {
    "firstname: "Albert",
    "lastname: "Einstein"
  },
  "deptname": "Physics",
  "children": [
    {"firstname": "Hans", "lastname": "Einstein" },
    {"firstname": "Eduard", "lastname": "Einstein" }
  ]
}
```
### XML(Extensible Markup Language)
>The **XML** data representation adds tags enclosed in angle brackets, <>, to mark up information in a textual representation. 
Tags are used in pairs, with <tag> and </tag> delimiting the beginning and the end of the portion of the text to which the tag refers.
```xml
<course>
  <course_id> CS-101 </course_id>
  <title> Intro. to Computer Science </title>
  <dept_name> Comp. Sci. </dept_name>
  <credits> 4 </credits>
</course>
```
## Object Orientation
Three approaches are used in practice for integrating object orientation with
database systems:
1. Build an **object-relational database system**, which adds object-oriented features to a relational database system.
2. Automatically convert data from the native object-oriented type system of the programming language to a relational representation for storage, and vice versa for retrieval. Data conversion is speciﬁed using an **object-relational mapping**.
3. Build an **object-oriented database system**, that is, a database system that natively supports an object-oriented type system and allows direct access to data from an object-oriented programming language using the native type system of the language.

We provide a brief introduction to the ﬁrst two approaches in this section. 
### Object-Relational Database Systems
**User-Defined Types**
```sql
create type Person
(ID varchar(20) primary key,
name varchar(20),
address varchar(20))
ref from(ID);

create table people of Person;

-- We can create a new person as follows:

insert into people (ID, name, address) values
('12345', 'Srinivasan', '23 Coyote Run');
```
**Type Inheritance**
```sql
create type Student under Person
(degree varchar(20)) ;
create type Teacher under Person
(salary integer);
```

**Table Inheritance**
```sql
-- PostgreSQL
create table students
(degree varchar(20))
inherits people;
create table teachers
(salary integer)
inherits people;
```
### Object-Relational Mapping(ORM)
>**A fringe beneﬁt** of using an ORM is that any of a number of databases can be used
to store data, with exactly the same high-level code. ORMs hide minor SQL diﬀerences
between databases from the higher levels. Migration from one database to another is
thus relatively straightforward when using an ORM, whereas SQL diﬀerences can make
such migration signiﬁcantly harder if an application uses SQL to communicate with
the database.

>**On the negative side**, object-relational mapping systems can suﬀer from signiﬁcant
performance ineﬃciencies for bulk database updates, as well as for complex queries
that are written directly in the imperative language. It is possible to update the database
directly, bypassing the object-relational mapping system, and to write complex queries
directly in SQL in cases where such ineﬃciencies are discovered.
## Textual Data
>Textual data consists of unstructured text. The term **information retrieval** generally refers to the querying of unstructured textual data.
### Keyword Queries
A keyword query retrieves documents whose set of keywords contains all the keywords in the query.

搜索引擎是information retrieval systems的典型例子,根据关键词返回网页内容.

### Relevance Ranking
>The set of all documents that contain the keywords in a query may be very large; in
particular, there are billions of documents on the web, and most keyword queries on
a web search engine ﬁnd hundreds of thousands of documents containing some or all of the keywords.

Information-retrieval systems therefore estimate relevance of documents to a query and return only highly ranked documents as answers.
#### Ranking Using TF-IDF
- **term**: refers to a keyword occurring in a document, or given as part of a query.
- TF: term frequency

One way of measuring TF(d, t), the relevance of a term t to a document d, is:
![alt text](../images/2026-04-03/PixPin_2026-04-14_10-07-26.webp)
where n(d) denotes the number of term occurrences in the document and n(d, t) denotes the number of occurrences of term t in the document d.

>However, not all terms used as keywords are equal. Suppose a query uses two terms, one
of which occurs frequently, such as “database”, and another that is less frequent, such
as “Silberschatz”. A document containing “Silberschatz” but not “database” should be
ranked higher than a document containing the term “database” but not “Silberschatz”.

To ﬁx this problem, weights are assigned to terms using the inverse document fre-
quency (IDF), deﬁned as:
![alt text](../images/2026-04-03/PixPin_2026-04-14_10-12-52.webp)

where n(t) denotes the number of documents (among those indexed by the system) that contain the term t. The **relevance** of a document d to **a set of terms Q** is then deﬁned as:
![alt text](../images/2026-04-03/PixPin_2026-04-14_10-13-55.webp)

>Almost all text documents (in English) contain words such as “and,” “or,” “a,” and
so on, and hence these words are useless for querying purposes since their inverse doc-
ument frequency is extremely low. Information-retrieval systems deﬁne a set of words,
called **stop words**, containing 100 or so of the most common words, and ignore these
words when indexing a document. Such words are not used as keywords, and they are
discarded if present in the keywords supplied by the user.
- 这就是为什么输入`python和爬虫`得到的结果与`python 爬虫`相差无几的原因
#### Ranking Using Hyperlinks
>Hyperlinks between documents can be used to decide on the overall importance of
a document, independent of the keyword query; for example, documents linked from
many other documents are considered more important.

Pagerank是该排序方法的著名代表之一

## Spatial Data
Two types of spatial data are particularly important:
1. Geographic data: such as road maps, land-usage maps, topographic elevation maps, political maps showing boundaries.
2. Geometric data:  include spatial information about how objects— such as buildings, cars, or aircraft— are constructed

游戏建模,谷歌地图都属于空间数据这一范畴
# Application Development(过)
# Big Data
当数据的数量和种类多到一定程度时,传统的关系型数据库就无能为力了,需要采用更为复杂的数据结构来处理.
## The MapReduce Paradigm(待补充)
# Data Analytics(过)
>The term **data analytics** refers broadly to the processing of data to infer patterns,
correlations, or models for **prediction**.
# Physical Storage Systems
## Overview of Physical Storage Media(物理存储介质概述)
* **高速缓存 (Cache)**：速度最快且成本最高的存储形式。容量较小，由计算机系统硬件管理。数据库系统实现者在设计查询处理数据结构和算法时会关注高速缓存效应。
* **主存储器 (Main memory)**：用于存放可被操作数据的存储介质，通用机器指令在主存上运行。主存容量在个人电脑上通常为几十 GB，大型服务器可达数百至数千 GB。主存具有**易失性 (volatile)**，电源故障或系统崩溃时内容会丢失。
* **闪存 (Flash memory)**：与主存不同，闪存是**非易失性 (non-volatile)** 的。其单位字节成本低于主存，但高于磁带。
    * 广泛用于照相机、手机和 USB 闪存盘。
    * **固态硬盘 (Solid State Drive,SSD)** 内部使用闪存存储数据，提供类似于磁碟的**面向块的接口 (block-oriented interface)**，典型块大小为 512 字节至 8 KB。
* **磁碟存储 (Magnetic-disk storage)**：长期在线存储数据的主要介质，也称为硬盘驱动器 (Hard Disk Drive,HDD)。磁碟是非易失性的。访问磁碟数据时，系统必须先将数据从磁碟移至主存。虽然比 SSD 便宜，但在每秒支持的数据访问操作次数上性能较低。
  * 俗称为机械硬盘
* **光存储 (Optical storage)**：包括 DVD 和蓝光光盘，使用激光读写。虽然可用于存储备份，但不适合存储活动数据库数据，因为其访问时间远长于磁碟。存在只读、单次写入 (WORM) 和多次擦写版本。
* **磁带存储 (Tape storage)**：主要用于备份和归档数据（如出于法律原因需长期安全存储的数据）。
    * 磁带比磁盘便宜且可拆卸，但访问速度极慢，因为必须从头开始**顺序访问 (sequential-access)**。
    * 磁碟和 SSD 被称为**直接访问存储 (direct-access storage)**。
    * 常用于存储海量科学数据（可达 PB 级）或大型视频文件。

## Storage Interfaces
### 接口标准
* **SATA (Serial ATA)**：常用接口。SATA-3 版本理论带宽 6 Gbps，实际数据传输速率可达 600 MB/s。
* **SAS (Serial Attached SCSI)**：通常仅用于服务器。SAS-3 版本支持 12 Gbps 的传输速率。
* **NVMe (Non-Volatile Memory Express)**：专门为 SSD 优化的逻辑接口标准，通常运行在 **PCIe** 总线上。

### 存储网络架构
* **SAN (Storage Area Network)**：
    * **定义**：通过高速网络将大量磁盘连接到多台服务器。
* **NAS (Network Attached Storage)**：
    * **定义**：与 SAN 类似，但不对外呈现为裸磁盘，而是通过 **NFS** 或 **CIFS** 等网络文件系统协议提供**文件系统接口**。



### 云存储 (Cloud Storage)
* **特征**：数据存储在云端，通过 API 访问。
* **限制**：若数据未与数据库同地部署，延迟高达数十至数百毫秒，因此不适合作为数据库的基础存储。
* **应用**：常用于存储对象（Object Storage）。
# Data Storage Structures(过)
就算考了我也不会...
# Indexing(索引)
## Basic Concepts(基本概念)
>使用索引可以在不深入查询数据库的情况下快速找到数据

有两种基本的索引类型:
1. 顺序索引(ordered index): 基于值的顺序排序
2. 哈希索引(hash index): 通过哈希函数映射

被索引标记的,用来查找记录的属性或属性集被称为搜索码(search key).
## Ordered Indices(顺序索引)

>The records in the indexed ﬁle may themselves be stored in **some sorted order**. A ﬁle may have several indices, on diﬀerent **search keys**. If the ﬁle containing
the records is **sequentially ordered**, a **clustering index** is an index whose search key
**also deﬁnes the sequential order of the ﬁle**. 
- Clustering indices are also called **primary indices**

>Indices whose search key speciﬁes an order diﬀerent from the sequential order of the ﬁle are called **nonclustering indices**, or **secondary indices**. 

也就是说,与文件顺序相同就是聚集索引,不同就是非聚集索引.
### 顺序索引的类别
顺序索引可以细分为两类:
1. 稠密索引(dense index): 对于文件中的每个搜索码值都有一个索引项
2. 稀疏索引(sparse index): 只为某些搜索码值建立索引项.

自然,稠密索引更容易定位一条记录,但稀疏索引占用的空间和维护开销更小.
### 索引更新
在以下两种情况下需要更新索引:插入和删除
#### 插入
1. 如果是稠密索引:
   1. 如果插入项的搜索码值未出现在索引中,则插入一个新的索引项
   2. 如果该搜索码值出现在索引中,则根据不同的索引结构来插入:
      1. 如果是每个索引项对应一个指针列表或一个桶的结构,那么就将该值指向该索引项的指针队列末端即可.
      2. 如果是索引项仅存储一个指针的结构,那么只需要把新纪录插入到该索引项对应记录的末端,不需要改动索引项
2. 如果是稀疏索引(将记录分成块):
   1. 如果新记录创建了新块,那么就需要插入一个新索引,选择该块中搜索键序号最小的键值作为索引键
   2. 如果新记录插入到现有块中,并且键值比该块的所有记录都要小,那么就将旧键值替换成新的键值;否则不做任何改动

#### 删除
1. 如果是稠密索引:
   1. 如果被删记录是该搜索码值的唯一记录, 则直接从索引中删除对应的索引项。
   2. 如果该搜索码值在索引中仍有其他记录, 则根据索引结构处理:
      1. 如果是每个索引项对应一个指针列表或桶的结构, 则仅从该列表中删除指向被删记录的指针。
      2. 如果是索引项仅存储一个指针的结构（指向首条记录）:
         * 如果被删的是该键值的首条记录, 则更新索引项, 使其指向下一条具有相同键值的记录。
         * 如果被删的不是首条记录, 则无需改动索引项。



2. 如果是稀疏索引 (以块为基准):
   1. 如果索引中不存在该被删记录的搜索码值, 则无需对索引做任何改动。
   2. 如果索引中存在该搜索码值, 则根据记录余留情况处理:
      1. 如果被删记录是该搜索码值的唯一记录:
         * 用数据文件中下一个出现的搜索码值替换当前的索引项。
         * 如果下一个搜索码值已经拥有索引项（即它已经是某块的块首）, 则直接删除当前索引项即可。
      2. 如果该键值仍有其他记录存在（即被删者是块首但不是唯一记录）:
         * 如果索引项正指向该被删记录, 则更新索引项, 使其指向该键值的下一条记录（新的块首）。
## B+-Tree Index Files(待补充)
## B+-Tree Extensions
## Hash Indices(哈希索引)(过)
## Multiple-Key Access(过)
## Creation of Indices(创建索引)
```sql
-- 就某个关系的某个属性创建索引
create index <index-name> on <relation-name> (<attribute-list>);

-- 删除索引
drop index <index-name>;
```

**例子**
```sql
create index dept index on instructor (dept name);
```
## Bitmap Indices(位图索引)
书上讲的特别烂,所以让AI写了一份:

为了透彻理解位图索引，我们直接通过一个**教职员工数据表**的完整流程来拆解。

### 1. 原始数据表 (Relation)
假设有 5 名员工，我们要对“性别”和“收入等级”建立位图索引：

| 记录编号 (ID) | 姓名 | 性别 (Gender) | 收入等级 (Income) |
| :------------ | :--- | :------------ | :---------------- |
| **0**         | 张三 | 男 (m)        | L1                |
| **1**         | 李四 | 女 (f)        | L2                |
| **2**         | 王五 | 女 (f)        | L1                |
| **3**         | 赵六 | 男 (m)        | L4                |
| **4**         | 孙七 | 女 (f)        | L3                |

---

### 2. 索引的物理构造
系统会为每个属性的**每一个可能取值**生成一个位图。

#### 性别属性 (Gender)
由于性别只有 `m` 和 `f`，产生两个位图：
* **性别=m** 的位图：`1 0 0 1 0`（第0、3位是男，填1）
* **性别=f** 的位图：`0 1 1 0 1`（第1、2、4位是女，填1）

#### 收入等级属性 (Income)
收入等级有 `L1, L2, L3, L4`，产生四个位图：
* **L1** 位图：`1 0 1 0 0`（记录0和2是L1）
* **L2** 位图：`0 1 0 0 0`（记录1是L2）
* **L3** 位图：`0 0 0 0 1`（记录4是L3）
* **L4** 位图：`0 0 0 1 0`（记录3是L4）



---

### 3. 为什么它在多条件查询时极快？
假设我们要找：**“收入等级为 L1 的男性”**。
SQL 语句：`SELECT * FROM table WHERE Gender='m' AND Income='L1';`

**数据库的操作步骤：**
1.  **加载 `Gender=m` 的位图**：`1 0 0 1 0`
2.  **加载 `Income=L1` 的位图**：`1 0 1 0 0`
3.  **进行“与”运算 (AND)**：
    $$
    \begin{array}{r@{\quad}l}
      & 1 \ 0 \ 0 \ 1 \ 0 \\
    \text{AND} & 1 \ 0 \ 1 \ 0 \ 0 \\
    \hline
      & 1 \ 0 \ 0 \ 0 \ 0
    \end{array}
    $$
4.  **读取结果**：结果位图只有**第 0 位**是 1，系统直接去磁盘取 `record 0` 的数据。



---

### 4. 关键点总结：到底好在哪里？

* **对比 B+ 树**：
    如果你用 B+ 树找“男性”，它会给你一堆指针列表；如果你再找“L1”，它又给你一堆指针。要把这两堆指针取交集，CPU 需要进行复杂的列表比对。而位图索引将这个问题简化成了**计算机最擅长的位运算**。
* **对比全表扫描**：
    如果不建索引，数据库必须把每条记录的姓名、性别、收入等所有字段都读进内存再判断。而位图索引非常小，通常可以全部塞进内存，在不碰磁盘的情况下就已经把目标行号算出来了。
* **空间压缩**：
    在实际工程中，如果数据量巨大，这些 `000001` 会经过特殊的压缩算法（如 WAH 压缩），占用的空间微乎其微。

### 5. 什么时候**不能**用？
如果一个属性的取值非常多（高基数），比如“身份证号”：
* 如果有 1 亿条记录，身份证号就有 1 亿种。
* 你需要建立 1 亿个位图，每个位图 1 亿比特。
* **结果**：索引的大小会远超数据表本身，查询效率崩塌。
# 复习要点
>仔细想想,中文班和英文班的卷子除了语言不同外应该没有什么区别,由于中英文版本教材的编排不同,所以只需要把内容更少的中文版教材搞定就行了!

1. 全部的关系代数
2. 全部的sql语法
3. 索引

# Query Processing(只要看1,2小节)(过)

# Transactions
## Transaction Concept
- transaction: a **unit of program execution** that accesses and possibly updates various data items.

事务需要满足以下特性,这被称为ACID特性:
- **atomicity**: 要么不执行要么全部执行,不存在中间状态
- **consistency**: 保证数据库的属性,接口,完整性约束不变
- **isolation**: 事务能够正常执行,不被并发执行的事务影响
- **durability**: 即使事务执行时系统崩溃,该操作也不可撤销.

## 存储器分类
- volatile storage: 易失性存储器,包括cache和main memory,存储的信息在系统崩溃后即丢失
- non-volatile storage: 非易失性存储器,包括SSD,HDD和磁带等存储设备,尽管不会在系统崩溃时丢失数据,但是容易受到故障的影响导致信息丢失.
- stable storage: 稳定存储器,将数据备份到多个非易失性存储器中
## Transaction Atomicity and Durability

# 补充
## Outline Of The Course
* Chapter 1: Introduction
* *Chapter 2: Introduction to Relational Model*
* **Chapter 3: Introduction to SQL**
* *Chapter 4: Intermediate SQL*
* Chapter 5: Advanced SQL (只要求前三节)
* **Chapter 6: Entity-Relationship Model**
* **Chapter 7: Relational Database Design**
* Chapter 8: Complex Data Types
* Chapter 9: Application Design
* Chapter 10: Big Data
* Chapter 11: Data Analytics
* Chapter 12: Physical Storage Systems (Sections 12.5 (RAID) omitted)
* Chapter 13: Storage and File Structure
* **Chapter 14: Indexing and Hashing**
* Chapter 15: Query Processing (Section 15.1, 15.2)
* Chapter 17: Transactions

- 斜体的为需要熟练的部分,黑体的为非常重要的部分
### 吐槽
教材详细过头了,而ppt基本是原封不动的搬运了整本书1300多页的内容,一个ppt最少五六十张,而总共有20多个ppt.
要说他敬业呢,ppt上的内容破碎无比,速览一遍发现不如看书完整,要说他不敬业呢,好歹有这么大的工作量.

- (3/26)这本书真的是又臭又长...
- (3/28)我服了原来这个ppt是[官网](https://db-book.com/slides-dir/index.html)上的,而我们老师实际啥都没干...

## 本教材核心: 大学数据库
![alt text](../images/2026-03-25/PixPin_2026-03-26_08-23-16.webp)
- keys used
![alt text](../images/2026-03-25/PixPin_2026-03-26_08-24-59.webp)
- schema diagram

### 关系表解析
```sql
create table classroom
	(building		varchar(15),
	 room_number		varchar(7),
	 capacity		numeric(4,0),
	 primary key (building, room_number)
	);

create table department
	(dept_name		varchar(20), 
	 building		varchar(15), 
	 budget		        numeric(12,2) check (budget > 0),
	 primary key (dept_name)
	);

create table course
	(course_id		varchar(8), 
	 title			varchar(50), 
	 dept_name		varchar(20),
	 credits		numeric(2,0) check (credits > 0),
	 primary key (course_id),
	 foreign key (dept_name) references department (dept_name)
		on delete set null
	);

create table instructor
	(ID			varchar(5), 
	 name			varchar(20) not null, 
	 dept_name		varchar(20), 
	 salary			numeric(8,2) check (salary > 29000),
	 primary key (ID),
	 foreign key (dept_name) references department (dept_name)
		on delete set null
	);

create table section
	(course_id		varchar(8), 
         sec_id			varchar(8),
	 semester		varchar(6)
		check (semester in ('Fall', 'Winter', 'Spring', 'Summer')), 
	 year			numeric(4,0) check (year > 1701 and year < 2100), 
	 building		varchar(15),
	 room_number		varchar(7),
	 time_slot_id		varchar(4),
	 primary key (course_id, sec_id, semester, year),
	 foreign key (course_id) references course (course_id)
		on delete cascade,
	 foreign key (building, room_number) references classroom (building, room_number)
		on delete set null
	);

create table teaches
	(ID			varchar(5), 
	 course_id		varchar(8),
	 sec_id			varchar(8), 
	 semester		varchar(6),
	 year			numeric(4,0),
	 primary key (ID, course_id, sec_id, semester, year),
	 foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
		on delete cascade,
	 foreign key (ID) references instructor (ID)
		on delete cascade
	);

create table student
	(ID			varchar(5), 
	 name			varchar(20) not null, 
	 dept_name		varchar(20), 
	 tot_cred		numeric(3,0) check (tot_cred >= 0),
	 primary key (ID),
	 foreign key (dept_name) references department (dept_name)
		on delete set null
	);

create table takes
	(ID			varchar(5), 
	 course_id		varchar(8),
	 sec_id			varchar(8), 
	 semester		varchar(6),
	 year			numeric(4,0),
	 grade		        varchar(2),
	 primary key (ID, course_id, sec_id, semester, year),
	 foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
		on delete cascade,
	 foreign key (ID) references student (ID)
		on delete cascade
	);

create table advisor
	(s_ID			varchar(5),
	 i_ID			varchar(5),
	 primary key (s_ID),
	 foreign key (i_ID) references instructor (ID)
		on delete set null,
	 foreign key (s_ID) references student (ID)
		on delete cascade
	);

create table time_slot
	(time_slot_id		varchar(4),
	 day			varchar(1),
	 start_hr		numeric(2) check (start_hr >= 0 and start_hr < 24),
	 start_min		numeric(2) check (start_min >= 0 and start_min < 60),
	 end_hr			numeric(2) check (end_hr >= 0 and end_hr < 24),
	 end_min		numeric(2) check (end_min >= 0 and end_min < 60),
	 primary key (time_slot_id, day, start_hr, start_min)
	);

create table prereq
	(course_id		varchar(8), 
	 prereq_id		varchar(8),
	 primary key (course_id, prereq_id),
	 foreign key (course_id) references course (course_id)
		on delete cascade,
	 foreign key (prereq_id) references course (course_id)
	);
```

- departname: 部门的办公地点和预算
- course: 培养计划中的课程
- instructor: 教师的信息
- section: 课表中的真实课程
  - section是course在某一学期的映射
- teaches: 教师教授的课程信息
- student: 学生的信息
- takes: 学生所选的真实课表
- 
