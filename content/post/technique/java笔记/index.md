---
title: Java笔记
image: 55474959_p0-式さん.webp
date: 2026-04-26 08:00:00
description: 重构中...
---

# Java基础学习

## Java历史
- [wiki](https://en.wikipedia.org/wiki/Java_(programming_language))

Java由Sun公司于1995年发布,出于营销的目的,将Java分成了三个主要版本: 
1. Java Platform, Micro Edition(Java ME): 用于嵌入式等内存有限的环境
2. Java Platform, Standard Edition (Java SE): 标准版本
3. Java Platform, Enterprise Edition (Java EE): 企业版本

简单来说,就是包含的库上有一些区别而已,其他的差别并不大.

由于Java依靠JVM运行,而早期的JVM是不开源的,所以引发了很多争议和诉讼案件,也是微软自己开发C#语言(与Java高度相似)的原因.

07年的时候,JVM的所有核心代码都正式开源,从而诞生了大量的第三方JDK,最著名的就是OpenJDK了,不管如何,现在我们可以随便下载JDK而不用担心被诉讼了.

10年Oracle收购Sun后,Java的所有权转入了Oracle公司,之后Java的演进速度趋于稳定,现在的Java SE是半年更新一版,迭代速度还是很快的.
### Kotlin,Groovy与Java

## 环境配置
### 编译器下载
与Cpp运行需要MSVC等编译器,python运行需要python虚拟环境一样,Java运行需要的是JDK(Java Development Kit).
如前面所说,尽管Java版权归Oracle公司所有,但也有开源的社区版本和基于开源版本制作的第三方JDK,性能上的差别非常小.
为了省事,我们直接上[微软官网](https://www.oracle.com/Java/technologies/downloads/#Java21)下载JDK21即可,这样可以**跳过烦人的环境变量配置环节**.
- 至于为什么不选最新的25版本是因为体积更大也没必要.

### 配置环境变量(可跳过)
与cpp类似,如果不配置编译器的环境变量的话,系统是无法识别你的命令的:
```bash
Java --version
Java : 无法将“Java”项识别为 cmdlet、函数、脚本文件或可运行程序的名称。请检查名称的拼写，如果包括路径，请确保路径正确
，然后再试一次。
所在位置 行:1 字符: 1
+ Java --version
+ ~~~~
    + CategoryInfo          : ObjectNotFound: (Java:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
```
但是,如果你用的是微软的OpenJDK,就可以在安装的时候勾选配置环境变量直接跳过这一步:
```bash
Java --version
openjdk 21.0.10 2026-01-20 LTS
OpenJDK Runtime Environment Microsoft-13106404 (build 21.0.10+7-LTS)
OpenJDK 64-Bit Server VM Microsoft-13106404 (build 21.0.10+7-LTS, mixed mode, sharing)
```

但如果你铁着头选择了Oracle官方版本的话,那么还是需要自己配置的...**预先警告这很麻烦**


### VScode配置Java环境
当你第一次创建`.Java`文件时,VScode会自动为你推荐所需的扩展并配置好环境,所以无需额外操作.

## 基础语法
- 参考教程: [W3schools](https://www.w3schools.com/Java/)

### 学习前的要点
我们首先需要知道Java的面向对象特性:
1. 所有函数和变量都写在类里面,因此函数都变成了`方法`,变量都变成了`属性`
2. 如果源文件中包含public类,则文件名必须与该类名完全一致
3. 所有的类名都需要大写,仅是一种规范,但最好大写.

例如:
```Java
public class Main {
  public static void main(String[] args) {
    System.out.println("Hello World");
  }
}
```
包含了这个代码的文件必须叫做Main.Java,区分大小写.

### 主函数
上述代码中的main函数是Java程序的入口,其作用与c/cpp中的main函数别无二致:
```Java
public static void main(String[] args) {
    System.out.println("Hello World");
  }
```
如果你不觉得main函数里的`String[] args`参数很奇怪的话,那我就觉得你很奇怪了.

>这个参数作为命令行交互的接收器,尽管你未必会显式用到这个参数,但是必须要写上.
尽管从Java21开始允许不写这个参数了,但是很多企业内部的数据库交互用的依然是Java8,所以还是写上比较好.

### 变量类型
```Java
// 常用变量类型
int myNum = 5;
float myFloatNum = 5.99f;
double myDoubleNum = 3.14159;
char myLetter = 'D';
boolean myBool = true;
String myText = "Hello";
```
值得注意的是唯独String这个变量类型是大写的,因为它是一个类,如前面所说,Java中的类名都需要大写,所以这里就大写了.

Java  10(2018年发布)引入了类似于cpp中auto的变量类型`var`:
```Java
var x = 5;  // x is an int
System.out.println(x);
```
与auto一样,var不允许只声明不赋值:
```Java
var x; // Error
var x = 5;  // OK
```
### Java数组
由于cpp反直觉的类似`int a[10]`这样的语法,所以Java将声明时的`[]`优化到了变量名前面,变成了这样:
```Java
String[] cars = {"Volvo", "BMW", "Ford", "Mazda"};
System.out.println(cars[0]);
// Outputs Volvo
```
- 看上去顺眼多了,毕竟我们都说`int 数组a`,而不会说`int a数组`.
#### 数组的声明与构造
**数组声明**
```java
int[] arr; // 正确
int[5] arr; // 错误：声明阶段不分配空间
arr = new int[5] // 在声明之后补充数组空间大小的分配
```
**数组构造**
```java
// 第一种写法
int[] arr ={1,2,3};
// 第二种写法
int[] arr;
arr = new int[]{1,2,3};
// 第三种写法
int[] arr = new int[]{1,2,3};
```

#### 二维数组
自然,如果是二维数组,就要写两个[]了:
```Java
int[][] myNumbers = { {1, 4, 2}, {3, 6, 8, 5, 2} };

for (int row = 0; row < myNumbers.length; row++) {
  for (int col = 0; col < myNumbers[row].length; col++) {
    System.out.println("myNumbers[" + row + "][" + col + "] = " + myNumbers[row][col]);
  }
}
```
### Java的for-each循环
由于Java的大多数逻辑语句和cpp别无二致,因此全都略过,但值得一提的是下面这个语法:
```Java
String[] cars = {"Volvo", "BMW", "Ford", "Mazda"};

for (String car : cars) {
  System.out.println(car);
}
```
这被称为for-each循环,于04年的Java5.0引入,而cpp直到c++11才正式引入:
```cpp
std::vector<std::string> cars = {"Volvo", "BMW", "Ford", "Mazda"};

for (const std::string& car : cars) {
    std::cout << car << std::endl;
}
```
## OOP
### 修饰符
先概览一下Java中的常用修饰符,之后会逐渐根据代码理解的
#### 类修饰符 (Class Modifiers)

在 Java 中，类修饰符决定了类的访问权限、继承特性以及实例化规则。

| 修饰符        | 描述                                                   | 适用范围       |
| :------------ | :----------------------------------------------------- | :------------- |
| **public**    | 最宽泛的访问级别。该类对所有类可见。                   | 顶级类、内部类 |
| **protected** | 对同一包内的类及所有子类可见。                         | **仅内部类**   |
| **default**   | (不写关键字) 仅对同一包内的类可见。                    | 顶级类、内部类 |
| **private**   | 仅对定义它的外部类可见。                               | **仅内部类**   |
| **abstract**  | 抽象类。不能被实例化，必须由子类继承并实现其抽象方法。 | 顶级类、内部类 |
| **final**     | 最终类。不能被继承（例如 `Java.lang.String`）。        | 顶级类、内部类 |
| **static**    | 静态内部类。不需要依赖外部类实例即可创建。             | **仅内部类**   |
| **sealed**    | 密封类（Java 17+）。限制哪些类可以继承它。             | 顶级类         |

- 外部类: 直接定义在.java文件中的类
- 内部类: 定义在外部类内部的类

对于外部类来说,类既不能是 private 的（这样除了该类自身，任何类都不能访问它），也不能是 protected 的。所以对于类的访问权限只有两种选择：包访问权限或者 public。为了防止类被外界访问，可以将所有的构造器声明为 private，这样只有你自己能创建对象（在类的 static 成员中）：

```java
// hiding/Lunch.java
// Demonstrates class access specifiers. Make a class
// effectively private with private constructors:

class Soup1 {
    private Soup1() {}

    public static Soup1 makeSoup() { // [1]
        return new Soup1();
    }
}

class Soup2 {
    private Soup2() {}

    private static Soup2 ps1 = new Soup2(); // [2]

    public static Soup2 access() {
        return ps1;
    }

    public void f() {}
}
// Only one public class allowed per file:
public class Lunch {
    void testPrivate() {
        // Can't do this! Private constructor:
        //- Soup1 soup = new Soup1();
    }

    void testStatic() {
        Soup1 soup = Soup1.makeSoup();
    }

    void testSingleton() {
        Soup2.access().f();
    }
}
```
#### 方法修饰符 (Method Modifiers)

方法修饰符控制方法的访问权限、执行逻辑、以及子类覆盖规则。

##### 访问控制修饰符
* **public**: 方法对所有类可见。
* **protected**: 方法对同一包内的类及所有子类可见。
* **default**: (不写关键字) 仅对同一包内的类可见。
* **private**: 仅在当前类内部可见。

##### 非访问控制修饰符
* **static**: 静态方法。属于类而非实例，通过类名直接调用，不能访问非静态成员。
* **final**: 最终方法。子类可以继承但不能覆盖（Override）此方法。
* **abstract**: 抽象方法。没有方法体，必须由非抽象子类实现。


### static修饰符详解
首先我们需要知道一件事:尽管Java强制要求所有方法都写在类中,但是有一些方法我们并不想让它与某个类的实例有任何关系,也就是说,我们想要像cpp定义**全局函数**那样,直接在类内方法中调用该函数,而不需要带上类访问符`.`,那么就可以用`static`关键字来修饰某个方法:
```Java
public class Main {
  static void myMethod() {
    System.out.println("Hello World!");
  }

  public static void main(String[] args) {
    myMethod();
  }
}

// Outputs "Hello World!"
```
- 这里我们直接调用了`myMethod`方法而不需要通过this指针或者类访问符来操作它

总结一下就是说,Java的static方法属于这个类,类外访问时通过`类名.方法`调用,类内访问可以直呼其名,而非static方法属于类实例,需要先实例化一个类后再通过实例调用.

### 创建类实例
Java创建类实例的方法有很多,但最常用的还是通过new操作符:
```Java
public class Main {
  int x = 5;

  public static void main(String[] args) {
    Main myObj = new Main();
    System.out.println(myObj.x);
  }
}
```
由于Java的垃圾回收机制(很后面会提到),我们不用像在cpp中一样,new一个对象后就要使用`delete`操作符删除它,还是很便利的.
### 构造函数
与Java有new没有delete同理,Java有构造函数但没有析构函数,构造函数的写法与cpp的写法相同:与类同名

```Java
public class Main {
  int x;

  public Main(int y) {
    x = y;
  }

  public static void main(String[] args) {
    Main myObj = new Main(5);
    System.out.println(myObj.x);
  }
}

// Outputs 5
```

#### this引用符
由于Java不再显式使用指针,但又需要像cpp一样用某个符号代指类实例,否则无法通过类内方法访问私有属性.

因此,Java引入了this引用符,**用来指向当前的类实例**:
```Java
public class Main {
  int x;  // Class variable x

  // Constructor with one parameter x
  public Main(int x) {
    this.x = x; // refers to the class variable x
  }

  public static void main(String[] args) {
    // Create an object of Main and pass the value 5 to the constructor
    Main myObj = new Main(5);
    System.out.println("Value of x = " + myObj.x);
  }
}
```

- 这与Python中的self有异曲同工之处,但不同的是self需要**显示声明**,而Java的this与cpp的this一样都是**隐式存在**的
#### 构造函数的重载
```Java
public class Main {
  int modelYear;
  String modelName;

  // Constructor with one parameter
  public Main(String modelName) {
    // Call the two-parameter constructor to reuse code and set a default year    
    this(2020, modelName);
  }

  // Constructor with two parameters
  public Main(int modelYear, String modelName) {
    // Use 'this' to assign values to the class variables
    this.modelYear = modelYear;
    this.modelName = modelName;
  }

  // Method to print car information
  public void printInfo() {
    System.out.println(modelYear + " " + modelName);
  }

  public static void main(String[] args) {
    // Create a car with only model name (uses default year)
    Main car1 = new Main("Corvette");

    // Create a car with both model year and name
    Main car2 = new Main(1969, "Mustang");

    car1.printInfo();
    car2.printInfo();
  }
}
```
通过构造函数的重载可以实现类的不同初始化数值

**非常值得注意**
>上述代码的`this(2020, modelName)`并非是简单的语法糖,它指向的是完整版本的构造函数,从而实现代码的复用,换句话说,如果只写这一句而不写完整构造函数就会报错.

- 这么来看的话,它与cpp中的初始化列表完全不同
```cpp
class Main {
public:
    int modelYear;
    string modelName;

    // 使用初始化列表：变量(值)
    Main(string name) : modelYear(2020), modelName(name) {
    }
}
```
### 继承与多态
由于cpp中的继承符号`:`过于简单和抽象,因此Java将继承符号改为了继承关键字`extends`:
```Java
class Vehicle {
  protected String brand = "Ford";        // Vehicle attribute
  public void honk() {                    // Vehicle method
    System.out.println("Tuut, tuut!");
  }
}

class Car extends Vehicle {
  private String modelName = "Mustang";    // Car attribute
  public static void main(String[] args) {

    // Create a myCar object
    Car myCar = new Car();

    // Call the honk() method (from the Vehicle class) on the myCar object
    myCar.honk();

    // Display the value of the brand attribute (from the Vehicle class) and the value of the modelName from the Car class
    System.out.println(myCar.brand + " " + myCar.modelName);
  }
}
```
#### final修饰符详解
Java将cpp中的常量修饰符`const`改成了`final`,这可不是脱裤子放屁,而是因为Java中的final还可以限制某些类不可被继承:
```Java
final class Vehicle {
  ...
}

class Car extends Vehicle {
  ...
}
// Main.Java:9: error: cannot inherit from final Vehicle
// class Main extends Vehicle {
//                   ^
// 1 error)
```
将类也看做常量的想法确实挺奇妙的,但一般来说根本用不到吧.
#### 多态
Java中的方法默认是可以被重载的,这比起cpp要便利很多,同样,被final修饰的方法只能被继承但不能被重载:
```Java
class Animal {
  public void animalSound() {
    System.out.println("The animal makes a sound");
  }
}

class Pig extends Animal {
  public void animalSound() {
    System.out.println("The pig says: wee wee");
  }
}

class Dog extends Animal {
  public void animalSound() {
    System.out.println("The dog says: bow wow");
  }
}
```
#### super引用符
Java设计了super引用符来指向父类:
```Java
class Animal {
  public void animalSound() {
    System.out.println("The animal makes a sound");
  }
}

class Dog extends Animal {
  public void animalSound() {
    super.animalSound(); // Call the parent method
    System.out.println("The dog says: bow wow");
  }
}

public class Main {
  public static void main(String[] args) {
    Dog myDog = new Dog();
    myDog.animalSound();
  }
}
```
当然,super更强大的地方在于能够调用父类的构造函数:
```Java
class Animal {
  Animal() {
    System.out.println("Animal is created");
  }
}

class Dog extends Animal {
  Dog() {
    super(); // Call parent constructor
    System.out.println("Dog is created");
  }
}

public class Main {
  public static void main(String[] args) {
    Dog myDog = new Dog();
  }
}
// Animal is created
// Dog is created
```
这其实很好理解,把super换成父类的类名即可看懂了.

### 抽象与接口
Java将Cpp中的虚函数与重载机制进一步发扬光大,发明了**抽象方法和接口**,简单来说的话,抽象类内的抽象方法没有函数内容,而且必须被子类重载实现;而接口就是抽象类的简写版,里面的所有函数和属性默认都要被重载实现.
**抽象类和抽象方法**
```Java
// Abstract class
abstract class Animal {
  // Abstract method (does not have a body)
  public abstract void animalSound();
  // Regular method
  public void sleep() {
    System.out.println("Zzz");
  }
}

// Subclass (inherit from Animal)
class Pig extends Animal {
  public void animalSound() {
    // The body of animalSound() is provided here
    System.out.println("The pig says: wee wee");
  }
}

class Main {
  public static void main(String[] args) {
    Pig myPig = new Pig(); // Create a Pig object
    myPig.animalSound();
    myPig.sleep();
  }
}
```
为了区分抽象类和接口,Java特定设置了接口的继承关键字`implements`,从而与`extends`区分开来:
```Java
// Interface
interface Animal {
  public void animalSound(); // interface method (does not have a body)
  public void sleep(); // interface method (does not have a body)
}

// Pig "implements" the Animal interface
class Pig implements Animal {
  public void animalSound() {
    // The body of animalSound() is provided here
    System.out.println("The pig says: wee wee");
  }
  public void sleep() {
    // The body of sleep() is provided here
    System.out.println("Zzz");
  }
}

class Main {
  public static void main(String[] args) {
    Pig myPig = new Pig();  // Create a Pig object
    myPig.animalSound();
    myPig.sleep();
  }
}
```
至于为什么Java要单独设置`implements`关键字,是因为它确实与`extends`有些许不同,`implements`后可以跟多个接口,而`extends`后只可以跟一个父类.
- 为什么这么设计?那是设计者的问题了
```Java
interface FirstInterface {
  public void myMethod(); // interface method
}

interface SecondInterface {
  public void myOtherMethod(); // interface method
}

class DemoClass implements FirstInterface, SecondInterface {
  public void myMethod() {
    System.out.println("Some text..");
  }
  public void myOtherMethod() {
    System.out.println("Some other text...");
  }
}

class Main {
  public static void main(String[] args) {
    DemoClass myObj = new DemoClass();
    myObj.myMethod();
    myObj.myOtherMethod();
  }
}
```
## Java系统库
**随便看看即可,用上的时候再去详细了解**
### Java文件读写
The **File** class from the **Java.io** package, allows us to work with files:
```Java
import Java.io.File;  // Import the File class

File myObj = new File("filename.txt"); // Specify the filename
```

#### 创建文件
```Java
import Java.io.File;       // Import the File class
import Java.io.IOException; // Import IOException to handle errors

public class CreateFile {
  public static void main(String[] args) {
    try {
      File myObj = new File("filename.txt"); // Create File object
      if (myObj.createNewFile()) {           // Try to create the file
        System.out.println("File created: " + myObj.getName());
      } else {
        System.out.println("File already exists.");
      }
    } catch (IOException e) {
      System.out.println("An error occurred.");
      e.printStackTrace(); // Print error details
    }
  }
}
```
#### 写入文件 
```Java
import Java.io.FileWriter;   // Import the FileWriter class
import Java.io.IOException;  // Import the IOException class

public class WriteToFile {
  public static void main(String[] args) {
    try {
      FileWriter myWriter = new FileWriter("filename.txt");
      myWriter.write("Files in Java might be tricky, but it is fun enough!");
      myWriter.close();  // must close manually
      System.out.println("Successfully wrote to the file.");
    } catch (IOException e) {
      System.out.println("An error occurred.");
      e.printStackTrace();
    }
  }
}
```
#### 读取文件
```Java
import Java.io.File;                  // Import the File class
import Java.io.FileNotFoundException; // Import this class to handle errors
import Java.util.Scanner;             // Import the Scanner class to read text files

public class ReadFile {
  public static void main(String[] args) {
    File myObj = new File("filename.txt");

    // try-with-resources: Scanner will be closed automatically
    try (Scanner myReader = new Scanner(myObj)) {
      while (myReader.hasNextLine()) {
        String data = myReader.nextLine();
        System.out.println(data);
      }
    } catch (FileNotFoundException e) {
      System.out.println("An error occurred.");
      e.printStackTrace();
    }
  }
}
```

### Java I/O
#### 读缓冲区
```Java
import Java.io.BufferedReader;
import Java.io.FileReader;
import Java.io.IOException;

public class Main {
  public static void main(String[] args) {
    try (BufferedReader br = new BufferedReader(new FileReader("filename.txt"))) {
      String line;
      while ((line = br.readLine()) != null) {
        System.out.println(line);
      }
    } catch (IOException e) {
      System.out.println("Error reading file.");
    }
  }
}
```
#### 写缓冲区
```Java
import Java.io.BufferedWriter;
import Java.io.FileWriter;
import Java.io.IOException;

public class Main {
  public static void main(String[] args) {
    try (BufferedWriter bw = new BufferedWriter(new FileWriter("filename.txt"))) {
      bw.write("First line");
      bw.newLine();  // add line break
      bw.write("Second line");
      System.out.println("Successfully wrote to the file.");
    } catch (IOException e) {
      System.out.println("Error writing file.");
    }
  }
}
```
### Java数据结构
最常用的数据结构都被包装到Java.util包中了:
- ArrayList
- HashSet
- HashMap

这三个数据结构同样也是Java岗面试的必考点,尽管不太看得出来考的必要

#### 快速对照表

| Java 数据结构 | C++ (STL) 对照       | 底层实现 | 排序性   |
| :------------ | :------------------- | :------- | :------- |
| **ArrayList** | `std::vector`        | 动态数组 | 插入顺序 |
| **HashSet**   | `std::unordered_set` | 哈希表   | 无序     |
| **HashMap**   | `std::unordered_map` | 哈希表   | 无序     |
| *TreeSet*     | `std::set`           | 红黑树   | 自动排序 |
| *TreeMap*     | `std::map`           | 红黑树   | 自动排序 |
## Java包管理
- 根据On Java 8整理
### 导入外部包
>例如，标准 Java 发布中有一个工具库，它被组织在 java.util 命名空间下。java.util 中含有一个类，叫做 ArrayList。使用 ArrayList 的一种方式是用其全名 java.util.ArrayList。
```java
public class FullQualification {
    public static void main(String[] args) {
        java.util.ArrayList list = new java.util.ArrayList();
    }
}
```

>这种方式使得程序冗长乏味，因此你可以换一种方式，使用 import 关键字。如果需要导入某个类，就需要在 import 语句中声明：

```java
import java.util.ArrayList;

public class SingleImport {
    public static void main(String[] args) {
        ArrayList list = new ArrayList();
    }
}
```

如果想要使用java.util包中的所有类,则使用以下导入方法:

```java
import java.util.*
```
### 自制工具包
自制包时需要用到`package`关键字,必须在文件的第一个非注释行声明,且按照惯例,包名一律小写.

例如,我们想要让某个java文件能够被其他文件访问,我们可以根据文件目录对应的写成这样:
```java
// hiding/mypackage/MyClass.java
package hiding.mypackage;

public class MyClass {
    // ...
}
```

## Java高级特性
说是高级,其实都很简单,都怪营销号和垃圾博客把Java渲染的多么复杂高深,比起Cpp来说,Java简直不能再简单了.
### Wrapper Classes(封装类)
| Primitive Data Type | Wrapper Class |
| :------------------ | :------------ |
| byte                | Byte          |
| short               | Short         |
| int                 | Integer       |
| long                | Long          |
| float               | Float         |
| double              | Double        |
| boolean             | Boolean       |
| char                | Character     |

由于Java内置的数据结构如`ArrayList`只能存储对象,所以我们需要将数据类型包装成一个数据类来处理:
```Java
import Java.util.ArrayList;

public class Main {
  public static void main(String[] args) {
    ArrayList<String> cars = new ArrayList<String>();
    cars.add("Volvo");
    cars.add("BMW");
    cars.add("Ford");
    cars.add("Mazda");
    System.out.println(cars);
  }
}
```
- 自然,这种脱裤子放屁的事情在Java中还有很多...
![示意图](PixPin_2026-04-27_12-38-33.webp)
### Java 泛型(generic)

**将不同类型的数据统一处理**
```Java
class Box<T> {
  T value; // T is a placeholder for any data type

  void set(T value) {
    this.value = value;
  }

  T get() {
    return value;
  }
}

public class Main {
  public static void main(String[] args) {
    // Create a Box to hold a String
    Box<String> stringBox = new Box<>();
    stringBox.set("Hello");
    System.out.println("Value: " + stringBox.get());

    // Create a Box to hold an Integer
    Box<Integer> intBox = new Box<>();
    intBox.set(50);
    System.out.println("Value: " + intBox.get());
  }
}
```
**处理不同的数据输入**
```Java
public class Main {
  // Generic method: works with any type T
  public static <T> void printArray(T[] array) {
    for (T item : array) {
      System.out.println(item);
    }
  }

  public static void main(String[] args) {
    // Array of Strings
    String[] names = {"Jenny", "Liam"};

    // Array of Integers
    Integer[] numbers = {1, 2, 3};

    // Call the generic method with both arrays
    printArray(names);
    printArray(numbers);
  }
}
```
### Java Annotations(Java注解)
>Annotations are **special notes** you add to your Java code. They start with the `@` symbol.


注解并不会改变程序的运行方式,但是会为编译器和构建工具提供额外的信息,这与Python中的`@`语法糖完全不同.

最常用的注解有三个:
1. `@Override`: Indicates that a method overrides a method in a superclass
2. `@Deprecated`: Marks a method or class as outdated or discouraged from use
3. `@SuppressWarnings`: Tells the compiler to ignore certain warnings

- 尽管看着是累赘设计,不过在Java测试中,Java注解将会真正发挥强大的作用
### Java多线程
Java中有两种方法可以创建进程:
```Java
// 1.继承Thread系统类
public class Main extends Thread {
  public void run() {
    System.out.println("This code is running in a thread");
  }
}
// 2.实现Runnable接口,更推荐
public class Main implements Runnable {
  public void run() {
    System.out.println("This code is running in a thread");
  }
}
```
真正要详细了解多线程需要在后面的Java线程池中学习

### Java反射(待补充)
#### 前言
我一直都十分怀疑中文互联网对于Java反射指定有什么奇怪的共识,所有讲Java反射的教程一上来就会抛给你一段类似这样的代码:

```java
Class clz = Class.forName("com.chenshuyi.reflect.Apple");
Method method = clz.getMethod("setPrice", int.class);
Constructor constructor = clz.getConstructor();
Object object = constructor.newInstance();
method.invoke(object, 4);
```

- 当一个兴致冲冲的小白想要了解Java反射是什么的时候,立刻就被劝退了...

不管怎样,我打算从更底层更初级的角度来学习反射.
#### 反射是什么

#### 反射用到了哪些库

#### 实战
## Java构建与打包

### JDK
- [参考博文](https://www.wdbyte.com/java/jdk-jre-jvm/)

JDK（Java Development Kit）、JRE（Java Runtime Environment）、JVM （Java Virtual Machine）是 Java 开发中的三个重要概念，**JDK 包含了 JRE 和开发工具，JRE 包含了 JVM 和类库，JVM 是 Java 程序的运行环境**。

![示意图](PixPin_2026-05-01_16-49-36.webp)

这张图说的很清楚了:
1. JDK除了包含JRE以外,还有javac,javadoc,jar等开发工具
2. JRE除了包含JVM外,还包含有各类Java系统库,如`java.util`,`java.io`库等.
   1. 如果自己不需要开发Java项目,只用JRE就足够运行已经被javac编译器编译出的class文件.
3. JVM负责执行class文件,从而运行java程序,在需要时由JRE帮助导入系统库和第三方库.

### Java打包(待补充)
我们时常能够看到java项目中的.jar(Java Archive)文件

# Java测试: JUnit
- 由于JUnit库在Java的测试库中占据了绝对主流,所以就只讲JUnit了.
- [官方文档](https://docs.junit.org/6.0.3/overview.html)


## 概览
JUnit is composed of several different modules from **three different sub-projects**:
```txt
JUnit 6.0.3 = JUnit Platform + JUnit Jupiter + JUnit Vintage
```

- JUnit Platform: 作为测试的基础,与JVM交互,启动测试引擎
- JUnit Jupiter: 作为测试的引擎和框架,我们编写的测试代码由Jupiter负责启动
- JUnit Vintage: 被废弃的引擎,只在运行3.0和4.0版本的JUnit时采用
## 写测试
### 一个简单的测试代码
```java
import static org.junit.jupiter.api.Assertions.assertEquals;

import example.util.Calculator;

import org.junit.jupiter.api.Test;

class MyFirstJUnitJupiterTests {

	private final Calculator calculator = new Calculator();

	@Test
	void addition() {
		assertEquals(2, calculator.add(1, 1));
	}

}
```
### 注解
>Unless otherwise stated, **all core annotations** are located in the **org.junit.jupiter.api package** in the junit-jupiter-api module.

重要的注解有以下几个:
- @Test
  - 注明这个方法是一个测试方法
- @BeforeEach
  - 注明
# Java构建工具
与Cpp有Make,ninja,CMake类似,Java也有自己的构建工具,早期的构建工具为Ant,目前由Maven和Gradle两款工具统治,它俩也承担了包管理器的责任.

由于Gradle更轻量现代一点,所以更推荐使用Gradle而非Maven.
## Maven(待补充)
### 安装方法
[官网](https://maven.apache.org/install.html)下载压缩包后解压,将解压路径的bin目录添加到环境变量:
![示意图](PixPin_2026-05-01_12-50-48.webp)

命令行输入`mvn -v`,成功:
![示意图](PixPin_2026-05-01_12-51-05.webp)

### 使用方法
#### 命令行使用
- 官网甚至没有新手教程,只有参考(reference)...
- [菜鸟教程](https://www.runoob.com/maven/maven-intro.html)

打开powershell在当前目录创建一个maven初始项目:
```bash
mvn archetype:generate '-DgroupId=com.example' '-DartifactId=my-first-app' '-DarchetypeArtifactId=maven-archetype-quickstart' '-DinteractiveMode=false'
```

初始结构长这样:

![示意图](PixPin_2026-05-01_16-21-14.webp)

输入`mvn compile`,构建后增加了target文件夹和其中的一些文件:

![示意图](PixPin_2026-05-01_16-22-10.webp)

输入`mvn test`,增加了测试结果文件:

![示意图](PixPin_2026-05-01_16-23-45.webp)

输入`mvn package`,将项目打包成了jar:

![示意图](PixPin_2026-05-01_16-26-33.webp)


#### pom.xml
## Gradle
### 安装方法
[官网](https://docs.gradle.org/current/userguide/installation.html#installation)下载二进制版本,解压后将bin目录添加到环境变量,命令行输入`gradle -v`,成功:

![示意图](PixPin_2026-05-01_12-57-34.webp)

- 不要下载完整(complete)版,下了也可以,但没必要.


### 使用方法
- [官网教程](https://docs.gradle.org/current/userguide/part1_gradle_init.html#part1_begin)

Gradle提供了一个类似`npm create`的方式初始化项目,也就是`gradle init`,在终端输入该命令后,我们也需要像`npm create`一样选择想要的参数和构建方式,之后就会在当前目录生成以下文件:

![示意图](PixPin_2026-06-16_17-11-14.webp)

如果想要立刻看到输出,运行`.\gradlew.bat run`或者`gradle run`即可:

![结果](PixPin_2026-06-16_17-19-10.webp)

运行`.\gradlew.bat build`即可构建项目,分别在app目录和根目录下生成一个build文件夹.

>如果运行`gradle build`的话,那就是使用全局安装的gradle来构建了,有可能会出现版本不兼容问题.不过由于我们这个项目本身用的就是同一个版本的gradle初始化的,所以问题不大.也可以这么用.

在app的build文件夹的libs文件夹中,我们可以看到打包好的`app.jar`文件,这就是我们的构建产物:

![jar](PixPin_2026-06-16_17-17-15.webp)

# Spring与Spring Boot
## 概览
- [官网](https://docs.spring.io/spring-framework/reference/overview.html)
- [wiki](https://zh.wikipedia.org/wiki/Spring_Framework)
- [Spring Boot](https://zh.wikipedia.org/wiki/Spring_Boot)

Spring框架诞生于03年,主要的原因就是官方的Java EE太过于臃肿了.Spring框架由于特别好用高效,又是开源的,所以迅速占领了原本的Java EE市场.

由于Spring的配置非常麻烦,后来Spring内部又于2014年发布了Spring Boot框架,简化了原本的复杂配置
## 入门
- [vscode配置教程](https://vscode.github.net.cn/docs/java/java-spring-boot)
  - 网上能见到的教程要么用IntelliJ IDEA,要么用Spring Boot CLI,这让我一个VSCode的死忠粉很崩溃啊

如官网所说,要在VSCode中开发Spring Boot,需要安装JDK,VSCode中的Java扩展,(Gradle扩展)和Spring Boot扩展,其中Spring Boot扩展包的内容如下,一下子就会导入四个扩展:
![插件图](PixPin_2026-06-19_22-06-10.webp)

要想新建一个初始化的Spring Boot项目的话,直接按`Ctrl+Shift+P`并键入`Spring Initializr`,选择自己想要的模板即可,如果全部按照默认设置的话,最终生成的项目是这样的:

![效果图](PixPin_2026-06-19_22-13-37.webp)

- 不过,使用`gradle init`也可以实现差不多的效果,只不过可能没有这种图形化界面的选择直观了.
- 另一个方法是直接去SPring的官网下载初始化项目,下载得到的项目是完全一样的

>不过,等待项目的各种依赖就绪要很久,应该说这是Java项目的通病了

在扩展栏中多了一个Spring Boot Dashboard工具,点开后运行APPs中的app即可,不出意外的话终端会有如下输出:

![终端](PixPin_2026-06-19_22-24-56.webp)

当然,如果直接拿一个现成的Spring Boot项目来看的话,根本无从下手,所以需要好好了解Spring的基本知识和Spring Boot对它的改进.

## 基础知识
- [官方文档](https://docs.spring.io/spring-framework/reference/core)
  - 非常遗憾的是,除了这个之外,网上根本就没有一个合适的教程

