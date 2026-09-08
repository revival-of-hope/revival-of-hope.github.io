---
title: c/cpp笔记
date: 2026-04-23 08:00:00
description: 早期文章,有空更新
image: 45243652_p0-楽園の素敵な巫女.webp

---

## 语法拾掇
### cpp关键字

### const问题(9/8)
C/Cpp中最容易让人迷糊的就是指针了,但当指针和const混在一起时,这才是噩梦的开始

先放出列表:
| 声明                  | 更准确的名称       | 指针指向能否改变 | 指向的值能否通过该指针修改 |
| --------------------- | ------------------ | ---------------: | -------------------------: |
| `const int *p`        | 指向常量的指针     |             可以 |                     不可以 |
| `int const *p`        | 指向常量的指针     |             可以 |                     不可以 |
| `int * const p`       | 指针常量 / 常指针  |           不可以 |                       可以 |
| `const int * const p` | 指向常量的指针常量 |           不可以 |                     不可以 |

#### 指向常量的指针

其中,下面两个式子完全等价:
```c
const int *p;
int const *p;
```
至于为什么如此,对于`int const *p;`,显然不存在一个指向const的指针,所以这个指针只能是指向int,而const自然就是修饰int的了,所以叫做指向常量int的指针.

尽管如此,这并不意味着对象真的是常量,而是表示**p以为自己指向的是常量**,所以无法通过p修改指向的对象,但对象本身可以是变量:
```c
int a = 10;
const int *p = &a;

a = 20;     // 正确：a本身不是常量
*p = 20;    // 错误：不能通过p修改a
```
#### 指针常量
既然这个指针是常量,也就不可以修改存储的地址了,但仍然可以修改指向对象的值,用处并不大,一个引用就可以完全代替了.
#### 指向常量的指针常量
双重const,额,根本看不出有什么好的用法.

#### 总结
如上所示,这几个概念屁用没有,可惜的是面试总喜欢考这个,莫名其妙的.
### struct/class全解(9/8)
Cpp中struct和class的区别比我想的还要小很多,它们都有访问控制符,有构造和析构函数,支持`->`访问符,唯一的区别在于,struct的默认成员权限为public,而class的默认成员权限为private.

如此也看得出来,class完完全全就是struct的套皮而已.如此一来,我们完全不需要因为Go和Rust中没有class而难受,毕竟二者实际上并没有什么区别.

一个完整的超长class用例如下:
```cpp
#include <algorithm>
#include <compare>
#include <cstddef>
#include <initializer_list>
#include <iostream>
#include <memory>
#include <new>
#include <sstream>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

// ============================================================
// 1. 一个小型“值类”
//
// 演示：
// - class定义
// - private字段
// - constexpr构造函数
// - explicit
// - 静态成员函数
// - 运算符重载
// - 默认生成的三路比较 <=>
// - 显式类型转换
// ============================================================

class Money {
private:
    long long cents_ = 0;

public:
    // explicit阻止整数被隐式转换成Money
    constexpr explicit Money(long long cents = 0) noexcept
        : cents_(cents) {}

    [[nodiscard]]
    constexpr long long cents() const noexcept {
        return cents_;
    }

    [[nodiscard]]
    static Money from_dollars(double dollars) {
        return Money{
            static_cast<long long>(dollars * 100.0)
        };
    }

    constexpr Money& operator+=(Money other) noexcept {
        cents_ += other.cents_;
        return *this;
    }

    constexpr Money& operator-=(Money other) noexcept {
        cents_ -= other.cents_;
        return *this;
    }

    friend constexpr Money operator+(Money left, Money right) noexcept {
        left += right;
        return left;
    }

    friend constexpr Money operator-(Money left, Money right) noexcept {
        left -= right;
        return left;
    }

    // 自动生成 ==、!=、<、<=、>、>=
    constexpr auto operator<=>(const Money&) const noexcept = default;

    // 必须显式转换：
    //
    // double value = static_cast<double>(money);
    explicit constexpr operator double() const noexcept {
        return static_cast<double>(cents_) / 100.0;
    }

    friend std::ostream& operator<<(std::ostream& os, Money money) {
        const long long absolute =
            money.cents_ >= 0 ? money.cents_ : -money.cents_;

        if (money.cents_ < 0) {
            os << '-';
        }

        os << absolute / 100
           << '.';

        const long long decimal = absolute % 100;

        if (decimal < 10) {
            os << '0';
        }

        os << decimal;
        return os;
    }
};

// 编译期使用constexpr类
constexpr Money compile_time_money{12'345};

static_assert(compile_time_money.cents() == 12'345);


// ============================================================
// 2. 一个管理动态资源的类
//
// 演示：
// - 类内默认成员初始化
// - 默认构造函数
// - 有参构造函数
// - initializer_list构造函数
// - 委托构造
// - 拷贝构造
// - 移动构造
// - 拷贝赋值
// - 移动赋值
// - 析构函数
// - Rule of Five
// - 深拷贝
// - copy-and-swap
// - operator[]
// - const与非const重载
// - explicit operator bool
// - friend函数
// ============================================================

class IntBuffer {
private:
    std::size_t size_ = 0;
    std::unique_ptr<int[]> data_;

public:
    // 默认构造函数
    IntBuffer() noexcept {
        std::cout << "[IntBuffer] default constructor\n";
    }

    // explicit避免下面这种隐式转换：
    //
    // IntBuffer buffer = 10;
    explicit IntBuffer(std::size_t size)
        : size_(size),
          data_(size == 0
                    ? nullptr
                    : std::make_unique<int[]>(size)) {
        std::cout << "[IntBuffer] size constructor: "
                  << size_ << '\n';
    }

    // std::initializer_list构造函数
    //
    // IntBuffer buffer{1, 2, 3};
    IntBuffer(std::initializer_list<int> values)
        : IntBuffer(values.size()) {       // 委托给另一个构造函数
        std::copy(values.begin(), values.end(), data_.get());

        std::cout << "[IntBuffer] initializer_list constructor\n";
    }

    // 拷贝构造：执行深拷贝
    IntBuffer(const IntBuffer& other)
        : IntBuffer(other.size_) {
        if (size_ > 0) {
            std::copy_n(other.data_.get(), size_, data_.get());
        }

        std::cout << "[IntBuffer] copy constructor\n";
    }

    // 移动构造：转移资源所有权
    IntBuffer(IntBuffer&& other) noexcept
        : size_(std::exchange(other.size_, 0)),
          data_(std::move(other.data_)) {
        std::cout << "[IntBuffer] move constructor\n";
    }

    // 拷贝赋值：copy-and-swap写法
    IntBuffer& operator=(const IntBuffer& other) {
        std::cout << "[IntBuffer] copy assignment\n";

        if (this == &other) {
            // this是指向当前对象的指针
            return *this;
        }

        IntBuffer temporary(other);
        swap(*this, temporary);

        return *this;
    }

    // 移动赋值
    IntBuffer& operator=(IntBuffer&& other) noexcept {
        std::cout << "[IntBuffer] move assignment\n";

        if (this == &other) {
            return *this;
        }

        size_ = std::exchange(other.size_, 0);
        data_ = std::move(other.data_);

        return *this;
    }

    ~IntBuffer() {
        std::cout << "[IntBuffer] destructor, size="
                  << size_ << '\n';

        // 不需要手动delete[]。
        // unique_ptr会自动释放数组。
    }

    friend void swap(IntBuffer& left, IntBuffer& right) noexcept {
        using std::swap;

        swap(left.size_, right.size_);
        swap(left.data_, right.data_);
    }

    [[nodiscard]]
    std::size_t size() const noexcept {
        return size_;
    }

    int& operator[](std::size_t index) {
        if (index >= size_) {
            throw std::out_of_range("IntBuffer index out of range");
        }

        return data_[index];
    }

    const int& operator[](std::size_t index) const {
        if (index >= size_) {
            throw std::out_of_range("IntBuffer index out of range");
        }

        return data_[index];
    }

    explicit operator bool() const noexcept {
        return size_ != 0;
    }
};


// ============================================================
// 3. 抽象基类
//
// 演示：
// - protected构造函数
// - private数据
// - 纯虚函数
// - 抽象类
// - 虚析构函数
// - 禁止拷贝
// - protected成员函数
// ============================================================

class Entity {
private:
    int id_ = 0;

protected:
    explicit Entity(int id)
        : id_(id) {}

    // 派生类可以使用，但外部不能使用
    void set_id(int id) noexcept {
        id_ = id;
    }

public:
    // 基类析构函数必须为virtual，
    // 才能安全地通过Entity*删除派生类对象。
    virtual ~Entity() = default;

    Entity(const Entity&) = delete;
    Entity(Entity&&) = delete;
    Entity& operator=(const Entity&) = delete;
    Entity& operator=(Entity&&) = delete;

    [[nodiscard]]
    int id() const noexcept {
        return id_;
    }

    // 纯虚函数：使Entity成为抽象类
    [[nodiscard]]
    virtual std::string describe() const = 0;

    [[nodiscard]]
    virtual std::unique_ptr<Entity> clone() const = 0;
};


// ============================================================
// 4. 接口类
//
// C++没有interface关键字。
// 只包含纯虚函数的抽象类通常充当接口。
// ============================================================

class Printable {
public:
    virtual ~Printable() = default;

    virtual void print(std::ostream& os) const = 0;
};


class Auditor;


// ============================================================
// 5. 核心Account类
//
// 集中演示：
// - public/private/protected
// - 嵌套类型
// - enum class
// - using类型别名
// - inline static数据成员
// - static constexpr
// - 构造函数重载
// - 默认构造
// - explicit构造
// - 委托构造
// - 成员初始化列表
// - initializer_list构造
// - 拷贝/移动构造
// - 拷贝/移动赋值
// - 虚析构
// - this指针
// - const成员函数
// - mutable
// - 引用限定符 &、const &、&&
// - 函数重载
// - 默认参数
// - static成员函数
// - 虚函数、override
// - NVI模式
// - friend函数、friend类
// - operator+=、operator+、operator[]
// - operator()、operator++
// - operator<<、operator bool、operator<=>
// - 成员函数模板
// - 自定义operator new/delete
// ============================================================

class Account : public Entity, public Printable {
public:
    // 嵌套枚举类型
    enum class Status {
        active,
        frozen,
        closed
    };

    // 嵌套结构体
    struct Transaction {
        Money amount;
        std::string note;
    };

    // 类型别名
    using TransactionList = std::vector<Transaction>;
    using SizeType = TransactionList::size_type;

    // 嵌套类
    class SecretKey {
    private:
        unsigned long long value_ = 0;

        explicit SecretKey(unsigned long long value)
            : value_(value) {}

        friend class Account;
        friend class Auditor;
    };

private:
    // 成员真正的初始化顺序永远按照这里的声明顺序，
    // 与构造函数初始化列表中的书写顺序无关。

    std::string owner_{"anonymous"};
    Money balance_{};
    Status status_ = Status::active;
    IntBuffer monthly_samples_;
    TransactionList transactions_;

    // const成员函数也可以修改mutable字段
    mutable std::size_t read_count_ = 0;

    SecretKey secret_{0};

    inline static int next_id_ = 1000;
    inline static int live_accounts_ = 0;

public:
    static constexpr Money maximum_balance{
        100'000'000'00LL
    };

    // --------------------------------------------------------
    // 构造函数
    // --------------------------------------------------------

    // 默认构造函数，同时也是委托构造函数
    Account()
        : Account(std::string{"anonymous"}, Money{0}) {
        std::cout << "[Account] default delegating constructor\n";
    }

    // 单参数构造函数
    //
    // explicit阻止：
    // Account account = std::string{"Alice"};
    explicit Account(std::string owner)
        : Account(std::move(owner), Money{0}) {
        std::cout << "[Account] owner delegating constructor\n";
    }

    // 主要构造函数
    //
    // 冒号后面的部分叫“成员初始化列表”。
    // 它不是先默认构造再赋值，而是直接构造成目标值。
    Account(std::string owner, Money initial_balance)
        : Entity(generate_id()),
          owner_(std::move(owner)),
          balance_(initial_balance),
          status_(Status::active),
          monthly_samples_{0, 0, 0},
          transactions_{},
          read_count_(0),
          secret_(
              static_cast<unsigned long long>(id()) *
              2'654'435'761ULL
          ) {
        validate_owner(owner_);

        if (balance_ < Money{0}) {
            throw std::invalid_argument(
                "initial balance cannot be negative"
            );
        }

        if (balance_ > maximum_balance) {
            throw std::invalid_argument(
                "initial balance exceeds maximum"
            );
        }

        ++live_accounts_;

        record(balance_, "initial balance");

        std::cout << "[Account] main constructor, id="
                  << id() << '\n';
    }

    // initializer_list构造函数
    //
    // 注意：
    // “成员初始化列表”和“std::initializer_list”
    // 是两个完全不同的概念。
    Account(
        std::string owner,
        std::initializer_list<long long> initial_transactions
    )
        : Account(std::move(owner), Money{0}) {
        for (long long cents : initial_transactions) {
            (*this)(
                Money{cents},
                "initializer-list transaction"
            );
        }

        std::cout
            << "[Account] initializer_list constructor\n";
    }

    // 禁止从nullptr构造
    Account(std::nullptr_t) = delete;

    // --------------------------------------------------------
    // 拷贝构造
    // --------------------------------------------------------

    Account(const Account& other)
        : Entity(generate_id()),
          owner_(other.owner_),
          balance_(other.balance_),
          status_(other.status_),
          monthly_samples_(other.monthly_samples_),
          transactions_(other.transactions_),
          read_count_(0),
          secret_(
              static_cast<unsigned long long>(id()) *
              2'654'435'761ULL
          ) {
        ++live_accounts_;

        std::cout << "[Account] copy constructor: "
                  << other.id() << " -> " << id() << '\n';
    }

    // --------------------------------------------------------
    // 移动构造
    // --------------------------------------------------------

    Account(Account&& other) noexcept
        : Entity(other.id()),
          owner_(std::move(other.owner_)),
          balance_(std::exchange(other.balance_, Money{0})),
          status_(std::exchange(
              other.status_,
              Status::closed
          )),
          monthly_samples_(
              std::move(other.monthly_samples_)
          ),
          transactions_(std::move(other.transactions_)),
          read_count_(other.read_count_),
          secret_(other.secret_) {
        other.set_id(0);
        other.read_count_ = 0;

        ++live_accounts_;

        std::cout << "[Account] move constructor, id="
                  << id() << '\n';
    }

    // --------------------------------------------------------
    // 拷贝赋值
    //
    // 与拷贝构造的区别：
    //
    // Account b = a;  // 拷贝构造
    // b = a;          // 拷贝赋值
    // --------------------------------------------------------

    Account& operator=(const Account& other) {
        std::cout << "[Account] copy assignment\n";

        if (this == &other) {
            return *this;
        }

        // 赋值时保留当前对象原来的id和secret
        owner_ = other.owner_;
        balance_ = other.balance_;
        status_ = other.status_;
        monthly_samples_ = other.monthly_samples_;
        transactions_ = other.transactions_;
        read_count_ = 0;

        return *this;
    }

    // --------------------------------------------------------
    // 移动赋值
    // --------------------------------------------------------

    Account& operator=(Account&& other) noexcept {
        std::cout << "[Account] move assignment\n";

        if (this == &other) {
            return *this;
        }

        // 当前对象的身份id不变，只接收业务状态
        owner_ = std::move(other.owner_);
        balance_ = std::exchange(other.balance_, Money{0});
        status_ = std::exchange(
            other.status_,
            Status::closed
        );
        monthly_samples_ = std::move(
            other.monthly_samples_
        );
        transactions_ = std::move(other.transactions_);
        read_count_ = 0;

        return *this;
    }

    // --------------------------------------------------------
    // 虚析构函数
    // --------------------------------------------------------

    ~Account() override {
        std::cout << "[Account] destructor, id="
                  << id() << ", owner="
                  << owner_ << '\n';

        --live_accounts_;
    }

    // --------------------------------------------------------
    // 普通getter/setter
    // --------------------------------------------------------

    [[nodiscard]]
    Money balance() const noexcept {
        ++read_count_;
        return balance_;
    }

    [[nodiscard]]
    Status status() const noexcept {
        ++read_count_;
        return status_;
    }

    [[nodiscard]]
    std::size_t read_count() const noexcept {
        return read_count_;
    }

    // --------------------------------------------------------
    // 根据对象值类别重载成员函数
    // --------------------------------------------------------

    // 只能在非const左值对象上调用
    std::string& owner() & noexcept {
        return owner_;
    }

    // 在const左值对象上调用
    const std::string& owner() const & noexcept {
        ++read_count_;
        return owner_;
    }

    // 在右值对象上调用，可以移出字符串
    std::string owner() && noexcept {
        return std::move(owner_);
    }

    // --------------------------------------------------------
    // this指针与链式调用
    // --------------------------------------------------------

    Account& rename(std::string new_owner) {
        validate_owner(new_owner);

        // this的类型近似为Account*
        this->owner_ = std::move(new_owner);

        // *this是当前对象本身
        return *this;
    }

    Account* self_address() noexcept {
        return this;
    }

    const Account* self_address() const noexcept {
        return this;
    }

    // --------------------------------------------------------
    // 函数重载
    // --------------------------------------------------------

    Account& deposit(Money amount) {
        ensure_active();

        if (amount <= Money{0}) {
            throw std::invalid_argument(
                "deposit must be positive"
            );
        }

        if (balance_ + amount > maximum_balance) {
            throw std::overflow_error(
                "maximum balance exceeded"
            );
        }

        balance_ += amount;
        record(amount, "deposit");

        return *this;
    }

    // 同名函数，参数类型不同
    Account& deposit(std::string_view cents_text) {
        long long cents = std::stoll(
            std::string{cents_text}
        );

        return deposit(Money{cents});
    }

    // note具有默认参数
    Account& withdraw(
        Money amount,
        std::string note = "withdraw"
    ) {
        ensure_active();

        if (amount <= Money{0}) {
            throw std::invalid_argument(
                "withdrawal must be positive"
            );
        }

        if (balance_ < amount) {
            throw std::runtime_error(
                "insufficient balance"
            );
        }

        balance_ -= amount;
        record(Money{-amount.cents()}, std::move(note));

        return *this;
    }

    Account& freeze() noexcept {
        status_ = Status::frozen;
        return *this;
    }

    Account& unfreeze() noexcept {
        if (status_ == Status::frozen) {
            status_ = Status::active;
        }

        return *this;
    }

    Account& close() noexcept {
        status_ = Status::closed;
        return *this;
    }

    // --------------------------------------------------------
    // static成员函数
    //
    // static成员函数没有this指针。
    // --------------------------------------------------------

    [[nodiscard]]
    static int live_accounts() noexcept {
        return live_accounts_;
    }

    [[nodiscard]]
    static Account from_dollars(
        std::string owner,
        double dollars
    ) {
        return Account{
            std::move(owner),
            Money::from_dollars(dollars)
        };
    }

    // --------------------------------------------------------
    // virtual、override、多态
    // --------------------------------------------------------

    [[nodiscard]]
    virtual std::string account_kind() const {
        return "ordinary account";
    }

    [[nodiscard]]
    std::string describe() const override {
        std::ostringstream output;

        output << "Account{id=" << id()
               << ", kind=" << account_kind()
               << ", owner=" << owner_
               << ", balance=" << balance_
               << ", status=" << status_name(status_)
               << '}';

        return output.str();
    }

    [[nodiscard]]
    std::unique_ptr<Entity> clone() const override {
        return std::make_unique<Account>(*this);
    }

    void print(std::ostream& os) const override {
        os << *this;
    }

    // --------------------------------------------------------
    // NVI：Non-Virtual Interface模式
    //
    // 外部调用固定的非虚接口month_end()，
    // 派生类只覆盖do_month_end()钩子。
    // --------------------------------------------------------

    void month_end() {
        if (status_ != Status::active) {
            return;
        }

        do_month_end();

        if (monthly_samples_.size() >= 3) {
            monthly_samples_[2] = monthly_samples_[1];
            monthly_samples_[1] = monthly_samples_[0];
            monthly_samples_[0] =
                static_cast<int>(balance_.cents());
        }
    }

    // --------------------------------------------------------
    // operator+=
    // --------------------------------------------------------

    Account& operator+=(Money amount) {
        return deposit(amount);
    }

    // --------------------------------------------------------
    // operator+
    //
    // 通常用成员operator+=实现非成员operator+。
    // 这里为了演示friend访问，直接操作私有字段。
    // --------------------------------------------------------

    friend Account operator+(
        Account left,
        const Account& right
    ) {
        left.balance_ += right.balance_;
        left.record(right.balance_, "operator+");

        return left;
    }

    // --------------------------------------------------------
    // operator[]
    // --------------------------------------------------------

    Transaction& operator[](SizeType index) {
        return transactions_.at(index);
    }

    const Transaction& operator[](SizeType index) const {
        return transactions_.at(index);
    }

    // --------------------------------------------------------
    // operator()
    //
    // 使对象可以像函数一样调用。
    // --------------------------------------------------------

    Account& operator()(
        Money delta,
        std::string note = "operator() transaction"
    ) {
        if (delta >= Money{0}) {
            if (delta == Money{0}) {
                record(delta, std::move(note));
                return *this;
            }

            return deposit(delta);
        }

        return withdraw(
            Money{-delta.cents()},
            std::move(note)
        );
    }

    // --------------------------------------------------------
    // 前置++与后置++
    // --------------------------------------------------------

    Account& operator++() {
        // 前置++：先修改，再返回当前对象
        deposit(Money{1});
        return *this;
    }

    Account operator++(int) {
        // int参数仅用于区分后置++
        Account old_value(*this);
        ++(*this);
        return old_value;
    }

    // --------------------------------------------------------
    // 比较运算符
    // --------------------------------------------------------

    bool operator==(const Account& other) const noexcept {
        return id() == other.id();
    }

    auto operator<=>(const Account& other) const noexcept {
        return id() <=> other.id();
    }

    // --------------------------------------------------------
    // explicit operator bool
    // --------------------------------------------------------

    explicit operator bool() const noexcept {
        return status_ == Status::active;
    }

    // --------------------------------------------------------
    // 流输出运算符
    //
    // 因为左操作数是ostream，所以通常实现为friend非成员函数。
    // --------------------------------------------------------

    friend std::ostream& operator<<(
        std::ostream& os,
        const Account& account
    ) {
        os << "Account("
           << "id=" << account.id()
           << ", owner=" << account.owner_
           << ", balance=" << account.balance_
           << ", status="
           << status_name(account.status_)
           << ')';

        return os;
    }

    // --------------------------------------------------------
    // 成员函数模板
    // --------------------------------------------------------

    template<typename Function>
    void for_each_transaction(Function&& function) const {
        for (const Transaction& transaction : transactions_) {
            std::forward<Function>(function)(transaction);
        }
    }

    // --------------------------------------------------------
    // 类专属operator new/delete
    //
    // 只有动态分配Account对象时才调用。
    // 栈上对象不会调用operator new。
    // --------------------------------------------------------

    static void* operator new(std::size_t size) {
        std::cout << "[Account::operator new] "
                  << size << " bytes\n";

        return ::operator new(size);
    }

    static void operator delete(void* pointer) noexcept {
        std::cout << "[Account::operator delete]\n";

        ::operator delete(pointer);
    }

protected:
    // 派生类可以访问这些函数
    // 但不能直接访问Account的private字段。

    [[nodiscard]]
    Money raw_balance() const noexcept {
        return balance_;
    }

    void credit_without_validation(
        Money amount,
        std::string note
    ) {
        balance_ += amount;
        record(amount, std::move(note));
    }

    virtual void do_month_end() {
        record(Money{0}, "ordinary month end");
    }

private:
    static int generate_id() noexcept {
        return ++next_id_;
    }

    static void validate_owner(const std::string& owner) {
        if (owner.empty()) {
            throw std::invalid_argument(
                "owner cannot be empty"
            );
        }
    }

    void ensure_active() const {
        if (status_ != Status::active) {
            throw std::logic_error(
                "account is not active"
            );
        }
    }

    void record(Money amount, std::string note) {
        transactions_.push_back(
            Transaction{
                amount,
                std::move(note)
            }
        );
    }

    static std::string_view status_name(
        Status status
    ) noexcept {
        switch (status) {
            case Status::active:
                return "active";

            case Status::frozen:
                return "frozen";

            case Status::closed:
                return "closed";
        }

        return "unknown";
    }

    // friend函数可以访问Account的private成员
    friend void transfer(
        Account& from,
        Account& to,
        Money amount
    );

    // Auditor类的所有成员函数都可以访问private成员
    friend class Auditor;
};


// ============================================================
// 6. friend非成员函数
// ============================================================

void transfer(
    Account& from,
    Account& to,
    Money amount
) {
    if (amount <= Money{0}) {
        throw std::invalid_argument(
            "transfer amount must be positive"
        );
    }

    from.ensure_active();
    to.ensure_active();

    if (from.balance_ < amount) {
        throw std::runtime_error(
            "insufficient balance for transfer"
        );
    }

    from.balance_ -= amount;
    to.balance_ += amount;

    from.record(
        Money{-amount.cents()},
        "transfer out"
    );

    to.record(
        amount,
        "transfer in"
    );
}


// ============================================================
// 7. friend类
// ============================================================

class Auditor {
public:
    static void audit(const Account& account) {
        std::cout
            << "[Audit] id=" << account.id()
            << ", owner=" << account.owner_
            << ", secret=" << account.secret_.value_
            << ", reads=" << account.read_count_
            << '\n';
    }
};


// ============================================================
// 8. 继承与运行时多态
//
// 演示：
// - public继承
// - protected成员访问
// - 基类构造函数调用
// - using恢复基类重载
// - override
// - final
// - 派生类拷贝/移动函数
// ============================================================

class SavingsAccount final : public Account {
private:
    int annual_interest_basis_points_ = 0;

public:
    // 防止派生类新增的deposit重载隐藏基类所有deposit
    using Account::deposit;

    SavingsAccount(
        std::string owner,
        Money initial_balance,
        int annual_interest_basis_points
    )
        : Account(
              std::move(owner),
              initial_balance
          ),
          annual_interest_basis_points_(
              annual_interest_basis_points
          ) {
        if (annual_interest_basis_points_ < 0) {
            throw std::invalid_argument(
                "interest rate cannot be negative"
            );
        }

        std::cout
            << "[SavingsAccount] constructor\n";
    }

    SavingsAccount(const SavingsAccount&) = default;
    SavingsAccount(SavingsAccount&&) noexcept = default;

    SavingsAccount& operator=(
        const SavingsAccount&
    ) = default;

    SavingsAccount& operator=(
        SavingsAccount&&
    ) noexcept = default;

    ~SavingsAccount() override {
        std::cout
            << "[SavingsAccount] destructor\n";
    }

    // 派生类自己的deposit重载
    SavingsAccount& deposit(
        Money amount,
        bool add_reward
    ) {
        Account::deposit(amount);

        if (add_reward) {
            credit_without_validation(
                Money{10},
                "deposit reward"
            );
        }

        return *this;
    }

    [[nodiscard]]
    std::string account_kind() const override final {
        return "savings account";
    }

    [[nodiscard]]
    std::unique_ptr<Entity> clone() const override {
        return std::make_unique<SavingsAccount>(*this);
    }

protected:
    void do_month_end() override final {
        const long long interest =
            raw_balance().cents() *
            annual_interest_basis_points_ /
            10'000 /
            12;

        if (interest > 0) {
            credit_without_validation(
                Money{interest},
                "monthly interest"
            );
        }

        // 这里不能直接访问：
        //
        // balance_
        // owner_
        //
        // 因为它们是Account的private成员。
    }
};


// ============================================================
// 9. 自定义智能指针式包装器
//
// 演示：
// - class template
// - operator->
// - operator*
// - 显式bool转换
//
// 普通指针的->由语言内置。
// 类对象的->可以通过operator->重载。
// ============================================================

template<typename T>
class ObjectPtr {
private:
    std::unique_ptr<T> pointer_;

public:
    explicit ObjectPtr(std::unique_ptr<T> pointer)
        : pointer_(std::move(pointer)) {
        if (!pointer_) {
            throw std::invalid_argument(
                "ObjectPtr cannot hold nullptr"
            );
        }
    }

    template<typename... Arguments>
    static ObjectPtr make(Arguments&&... arguments) {
        return ObjectPtr{
            std::make_unique<T>(
                std::forward<Arguments>(arguments)...
            )
        };
    }

    T* operator->() noexcept {
        return pointer_.get();
    }

    const T* operator->() const noexcept {
        return pointer_.get();
    }

    T& operator*() noexcept {
        return *pointer_;
    }

    const T& operator*() const noexcept {
        return *pointer_;
    }

    explicit operator bool() const noexcept {
        return static_cast<bool>(pointer_);
    }
};


// ============================================================
// 10. 禁止拷贝的类
//
// 演示：
// - = default
// - = delete
// - 只能移动，不能拷贝
// ============================================================

class UniqueSession {
private:
    int session_id_ = 0;

public:
    explicit UniqueSession(int session_id)
        : session_id_(session_id) {}

    ~UniqueSession() = default;

    UniqueSession(const UniqueSession&) = delete;

    UniqueSession& operator=(
        const UniqueSession&
    ) = delete;

    UniqueSession(UniqueSession&&) noexcept = default;

    UniqueSession& operator=(
        UniqueSession&&
    ) noexcept = default;

    [[nodiscard]]
    int id() const noexcept {
        return session_id_;
    }
};


// ============================================================
// 11. constexpr类、consteval工厂
// ============================================================

class Point {
private:
    int x_ = 0;
    int y_ = 0;

public:
    constexpr Point(int x, int y) noexcept
        : x_(x),
          y_(y) {}

    [[nodiscard]]
    constexpr int x() const noexcept {
        return x_;
    }

    [[nodiscard]]
    constexpr int y() const noexcept {
        return y_;
    }

    [[nodiscard]]
    constexpr int distance_squared() const noexcept {
        return x_ * x_ + y_ * y_;
    }

    friend constexpr Point operator+(
        Point left,
        Point right
    ) noexcept {
        return Point{
            left.x_ + right.x_,
            left.y_ + right.y_
        };
    }

    static consteval Point origin() {
        return Point{0, 0};
    }
};

constexpr Point origin = Point::origin();
constexpr Point point{3, 4};

static_assert(origin.distance_squared() == 0);
static_assert(point.distance_squared() == 25);


// ============================================================
// 12. 位域与内存对齐
// ============================================================

class Permissions {
private:
    unsigned int can_read_ : 1 = 0;
    unsigned int can_write_ : 1 = 0;
    unsigned int can_execute_ : 1 = 0;

public:
    void allow_read() noexcept {
        can_read_ = 1;
    }

    void allow_write() noexcept {
        can_write_ = 1;
    }

    void allow_execute() noexcept {
        can_execute_ = 1;
    }

    [[nodiscard]]
    bool can_read() const noexcept {
        return can_read_;
    }

    [[nodiscard]]
    bool can_write() const noexcept {
        return can_write_;
    }

    [[nodiscard]]
    bool can_execute() const noexcept {
        return can_execute_;
    }
};

// 要求对象起始地址按照64字节对齐
class alignas(64) CacheLineCounter {
private:
    long long value_ = 0;

public:
    void increment() noexcept {
        ++value_;
    }

    [[nodiscard]]
    long long value() const noexcept {
        return value_;
    }
};


// ============================================================
// 13. 虚继承与菱形继承
//
//                Person
//                /    \
//         Employee    Shareholder
//                \    /
//               Executive
//
// virtual继承保证Executive中只有一个Person子对象。
// ============================================================

class Person {
private:
    std::string name_;

public:
    explicit Person(std::string name)
        : name_(std::move(name)) {
        std::cout << "[Person] constructor\n";
    }

    virtual ~Person() = default;

    [[nodiscard]]
    const std::string& name() const noexcept {
        return name_;
    }
};


class Employee : virtual public Person {
protected:
    int employee_id_ = 0;

public:
    Employee(std::string name, int employee_id)
        : Person(std::move(name)),
          employee_id_(employee_id) {}

    virtual ~Employee() = default;
};


class Shareholder : virtual public Person {
protected:
    int shares_ = 0;

public:
    Shareholder(std::string name, int shares)
        : Person(std::move(name)),
          shares_(shares) {}

    virtual ~Shareholder() = default;
};


class Executive final
    : public Employee,
      public Shareholder {
public:
    Executive(
        std::string name,
        int employee_id,
        int shares
    )
        // 虚基类由最底层派生类负责初始化
        : Person(name),
          Employee(name, employee_id),
          Shareholder(name, shares) {}

    void show() const {
        std::cout
            << "Executive{name=" << name()
            << ", employeeId=" << employee_id_
            << ", shares=" << shares_
            << "}\n";
    }
};


// ============================================================
// 14. struct与class的默认访问权限
// ============================================================

struct PublicByDefault {
    int value = 0;

    void show() const {
        std::cout << value << '\n';
    }
};


class PrivateByDefault {
    // 默认是private
    int value_ = 0;

public:
    explicit PrivateByDefault(int value)
        : value_(value) {}

    [[nodiscard]]
    int value() const noexcept {
        return value_;
    }
};


// ============================================================
// 15. 对象切片演示
// ============================================================

void show_by_value(Account account) {
    // 如果传入SavingsAccount，派生类部分已经被切掉。
    std::cout
        << "By value: "
        << account.account_kind()
        << '\n';
}


void show_by_reference(const Account& account) {
    // 引用保留运行时多态。
    std::cout
        << "By reference: "
        << account.account_kind()
        << '\n';
}


// ============================================================
// 16. main：集中使用全部特性
// ============================================================

int main() {
    std::cout << "========== 1. 构造函数 ==========\n";

    // 默认构造
    Account default_account;

    // explicit单参数构造：必须直接构造
    Account alice{std::string{"Alice"}};

    // 下面不能通过编译，因为构造函数是explicit：
    //
    // Account error = std::string{"Alice"};

    // 重载构造
    Account bob{
        std::string{"Bob"},
        Money{20'000}
    };

    // initializer_list构造
    Account carol{
        std::string{"Carol"},
        {
            10'000,
            -2'500,
            3'000
        }
    };

    // 静态工厂函数
    Account david = Account::from_dollars(
        "David",
        250.75
    );


    std::cout << "\n========== 2. 初始化列表 ==========\n";

    std::cout << bob << '\n';
    std::cout << carol << '\n';

    // Account构造函数里的：
    //
    // : Entity(...),
    //   owner_(...),
    //   balance_(...)
    //
    // 是“成员初始化列表”。
    //
    // carol构造中的：
    //
    // {10000, -2500, 3000}
    //
    // 是“std::initializer_list”。


    std::cout << "\n========== 3. this与链式调用 ==========\n";

    bob.rename("Robert")
       .deposit(Money{5'000})
       .withdraw(Money{1'500}, "buy book")
       .deposit("250");

    std::cout
        << "this address equal: "
        << std::boolalpha
        << (bob.self_address() == &bob)
        << '\n';


    std::cout << "\n========== 4. 点号与箭头 ==========\n";

    // 对象使用点号
    bob.deposit(Money{100});

    // 原始指针使用->
    Account* raw_pointer = &bob;
    raw_pointer->deposit(Money{200});

    // 以下两种形式基本等价：
    raw_pointer->deposit(Money{300});
    (*raw_pointer).deposit(Money{300});

    // 标准智能指针使用->
    auto unique_account =
        std::make_unique<Account>(
            std::string{"HeapUser"},
            Money{30'000}
        );

    unique_account->deposit(Money{500});

    // 自定义类通过operator->模拟指针行为
    auto wrapped_account =
        ObjectPtr<Account>::make(
            std::string{"WrappedUser"},
            Money{40'000}
        );

    wrapped_account->deposit(Money{600});

    // operator*返回对象引用
    (*wrapped_account).withdraw(Money{100});


    std::cout << "\n========== 5. 访问控制 ==========\n";

    std::cout << bob.owner() << '\n';
    std::cout << bob.balance() << '\n';

    // 以下代码不能编译，因为字段是private：
    //
    // bob.owner_ = "Hacker";
    // bob.balance_ = Money{999999};
    // bob.secret_.value_ = 0;

    // friend类可以访问private数据
    Auditor::audit(bob);


    std::cout << "\n========== 6. const成员函数 ==========\n";

    const Account& const_bob = bob;

    std::cout << const_bob.owner() << '\n';
    std::cout << const_bob.balance() << '\n';

    // const对象不能调用会修改普通成员的函数：
    //
    // const_bob.deposit(Money{100});

    // 但balance()可以修改mutable read_count_
    std::cout
        << "read count: "
        << const_bob.read_count()
        << '\n';


    std::cout << "\n========== 7. 拷贝构造 ==========\n";

    Account bob_copy = bob;

    std::cout << "original: " << bob << '\n';
    std::cout << "copy:     " << bob_copy << '\n';

    // 二者是不同对象，具有不同id
    std::cout
        << "same identity: "
        << (bob == bob_copy)
        << '\n';


    std::cout << "\n========== 8. 拷贝赋值 ==========\n";

    Account copy_assignment_target{
        std::string{"Target"},
        Money{100}
    };

    copy_assignment_target = bob;

    std::cout
        << copy_assignment_target
        << '\n';


    std::cout << "\n========== 9. 移动构造 ==========\n";

    Account temporary{
        std::string{"Temporary"},
        Money{9'000}
    };

    Account moved_account = std::move(temporary);

    std::cout << "moved: " << moved_account << '\n';

    // temporary仍然存在，但已进入“有效但未指定/被移走”的状态。
    // 当前实现把它设为closed、余额0、id=0。


    std::cout << "\n========== 10. 移动赋值 ==========\n";

    Account move_assignment_target;

    move_assignment_target = std::move(moved_account);

    std::cout
        << move_assignment_target
        << '\n';


    std::cout << "\n========== 11. 运算符重载 ==========\n";

    bob += Money{1'000};

    bob(
        Money{-200},
        "service fee"
    );

    std::cout
        << "First transaction: "
        << bob[0].amount
        << ", "
        << bob[0].note
        << '\n';

    // 前置++
    ++bob;

    // 后置++
    Account old_bob = bob++;

    std::cout << "old bob: " << old_bob << '\n';
    std::cout << "new bob: " << bob << '\n';

    Account combined = bob + carol;

    std::cout
        << "combined: "
        << combined
        << '\n';

    if (bob) {
        std::cout << "Bob is active\n";
    }

    bob.freeze();

    if (!static_cast<bool>(bob)) {
        std::cout << "Bob is not active\n";
    }

    bob.unfreeze();


    std::cout << "\n========== 12. friend转账 ==========\n";

    transfer(
        bob,
        carol,
        Money{1'000}
    );

    std::cout << bob << '\n';
    std::cout << carol << '\n';


    std::cout << "\n========== 13. static成员 ==========\n";

    std::cout
        << "Live accounts: "
        << Account::live_accounts()
        << '\n';

    std::cout
        << "Maximum balance: "
        << Account::maximum_balance
        << '\n';


    std::cout << "\n========== 14. 成员函数模板 ==========\n";

    bob.for_each_transaction(
        [](const Account::Transaction& transaction) {
            std::cout
                << transaction.amount
                << " : "
                << transaction.note
                << '\n';
        }
    );


    std::cout << "\n========== 15. 继承与多态 ==========\n";

    SavingsAccount savings{
        "SavingsUser",
        Money{100'000},
        600
    };

    // 来自Account的deposit(Money)
    savings.deposit(Money{5'000});

    // SavingsAccount自己的重载
    savings.deposit(
        Money{10'000},
        true
    );

    savings.month_end();

    std::cout
        << savings.describe()
        << '\n';


    std::cout << "\n========== 16. 对象切片 ==========\n";

    show_by_value(savings);
    show_by_reference(savings);

    // 输出：
    //
    // By value: ordinary account
    // By reference: savings account
    //
    // 按值传参会把SavingsAccount切成Account。
    // 引用和指针不会发生对象切片。


    std::cout << "\n========== 17. 多态容器 ==========\n";

    std::vector<std::unique_ptr<Entity>> entities;

    entities.push_back(
        std::make_unique<Account>(
            std::string{"Normal"},
            Money{10'000}
        )
    );

    entities.push_back(
        std::make_unique<SavingsAccount>(
            "Saver",
            Money{20'000},
            300
        )
    );

    for (const auto& entity : entities) {
        // 虚函数调用：根据对象实际类型选择实现
        std::cout
            << entity->describe()
            << '\n';
    }


    std::cout << "\n========== 18. clone虚构造模式 ==========\n";

    std::unique_ptr<Entity> cloned =
        entities[1]->clone();

    std::cout
        << cloned->describe()
        << '\n';


    std::cout << "\n========== 19. dynamic_cast ==========\n";

    Entity* base_pointer = entities[1].get();

    if (
        auto* saving_pointer =
            dynamic_cast<SavingsAccount*>(base_pointer)
    ) {
        saving_pointer->deposit(Money{100});

        std::cout
            << "dynamic_cast succeeded\n";
    }


    std::cout << "\n========== 20. 指向成员的指针 ==========\n";

    // 指向成员函数的指针
    auto balance_function = &Account::balance;

    Money balance1 =
        (bob.*balance_function)();

    Money balance2 =
        (raw_pointer->*balance_function)();

    std::cout << balance1 << '\n';
    std::cout << balance2 << '\n';

    // deposit存在重载，所以要明确函数指针类型
    using DepositFunction =
        Account& (Account::*)(Money);

    DepositFunction deposit_function =
        &Account::deposit;

    (bob.*deposit_function)(Money{100});
    (raw_pointer->*deposit_function)(Money{100});


    std::cout << "\n========== 21. 禁止拷贝 ==========\n";

    UniqueSession session1{123};

    // 不能拷贝：
    //
    // UniqueSession session2 = session1;

    // 可以移动：
    UniqueSession session2 = std::move(session1);

    std::cout
        << "Session ID: "
        << session2.id()
        << '\n';


    std::cout << "\n========== 22. constexpr对象 ==========\n";

    constexpr Point p1{3, 4};
    constexpr Point p2{1, 2};
    constexpr Point p3 = p1 + p2;

    static_assert(p3.x() == 4);
    static_assert(p3.y() == 6);

    std::cout
        << "distance squared: "
        << p3.distance_squared()
        << '\n';


    std::cout << "\n========== 23. 位域 ==========\n";

    Permissions permissions;

    permissions.allow_read();
    permissions.allow_write();

    std::cout
        << "read=" << permissions.can_read()
        << ", write=" << permissions.can_write()
        << ", execute=" << permissions.can_execute()
        << '\n';


    std::cout << "\n========== 24. 对齐 ==========\n";

    CacheLineCounter counter;
    counter.increment();

    std::cout
        << "sizeof(CacheLineCounter) = "
        << sizeof(CacheLineCounter)
        << '\n';

    std::cout
        << "alignof(CacheLineCounter) = "
        << alignof(CacheLineCounter)
        << '\n';


    std::cout << "\n========== 25. 菱形继承 ==========\n";

    Executive executive{
        "Alice CEO",
        10001,
        5000
    };

    executive.show();

    // 因为Employee和Shareholder虚继承Person，
    // Executive内部只有一份Person。


    std::cout << "\n========== 26. placement new ==========\n";

    // 只准备原始内存，不自动创建Account对象
    alignas(Account)
    std::byte storage[sizeof(Account)];

    // ::new表示显式使用全局placement new，
    // 在已经准备好的storage上构造对象。
    Account* placed_account =
        ::new (static_cast<void*>(storage))
            Account{
                std::string{"Placed"},
                Money{1'000}
            };

    placed_account->deposit(Money{100});

    std::cout
        << *placed_account
        << '\n';

    // placement new创建的对象不能直接delete，
    // 必须显式调用析构函数。
    placed_account->~Account();


    std::cout << "\n========== 27. sizeof与成员存储 ==========\n";

    std::cout
        << "sizeof(Money) = "
        << sizeof(Money)
        << '\n';

    std::cout
        << "sizeof(Account) = "
        << sizeof(Account)
        << '\n';

    std::cout
        << "sizeof(SavingsAccount) = "
        << sizeof(SavingsAccount)
        << '\n';

    // 成员函数代码并不会在每个对象中各存一份。
    // static字段也不属于单个对象。
    //
    // Account包含虚函数，所以实现通常会在对象中
    // 保存一个隐藏的虚函数表指针vptr。
    //
    // 但C++标准不强制编译器必须用vtable/vptr实现。


    std::cout << "\n========== 28. 程序即将结束 ==========\n";

    std::cout
        << "Live accounts before local destruction: "
        << Account::live_accounts()
        << '\n';

    // main结束时，局部对象按照构造顺序的反方向析构。
    // 派生类对象先执行派生类析构函数，
    // 然后执行基类析构函数，
    // 最后析构普通成员和基类子对象。

    return 0;
}
```
## cpp的编译
### 为什么需要cpp工程构建
- [参考1](https://docs.eesast.com/docs/languages/C&C++/multi-file_programming)
- [参考2](https://learn.microsoft.com/zh-cn/cpp/cpp/header-files-cpp?view=msvc-170)

#### 多文件管理
在一个文件里导入其他文件中的变量有两种方法:
**1.使用extern关键字**
```cpp
// 文件 A (data.cpp) 
struct Counter {
    int value;
    void display() const {
        std::cout << value << std::endl;
    }
};

Counter g_tracker = {100};
int global_count = 100;

// 文件 B (main.cpp)
extern int global_count;
extern Counter g_tracker;

void print_count() {
    g_tracker.display();
    std::cout << global_count << std::endl;
}

int main() {
    print_count();
    return 0;
}
```
也就是说我们需要在用到这个变量的时候使用extern关键字来声明,才能让编译器明白这个变量是要到其他文件中去找的.

**2.使用头文件**
当需要共享的变量或函数过多时,再一个个写extern不太现实,所以**cpp使用者**设计了单独的文件类型用来存放共享变量(包括常量,外部变量)的声明,也就是.h文件.
```cpp
// vars.h
#ifndef VARS_H
#define VARS_H
// include guard,防止同一个头文件在同一个cpp文件中被多次导入
extern int shared_val; // 声明
#endif

// vars.cpp
#include "vars.h"
int shared_val = 42; // 定义
```

当然,更为常见的是用class来封装变量和函数再放入.h文件,并在对应的cpp文件里实现:
**cocos示例项目**
```cpp
//AppDelegate.h
#ifndef  _APP_DELEGATE_H_
#define  _APP_DELEGATE_H_

#include "cocos2d.h"

class  AppDelegate : private cocos2d::Application
{
public:
    AppDelegate();
    virtual ~AppDelegate();

    virtual void initGLContextAttrs();

};

#endif // _APP_DELEGATE_H_

//同名cpp文件,其实起什么名字都行,但为了标准化还是同名为好
#include "AppDelegate.h"
// 导入后进行实现
AppDelegate::AppDelegate()
{
}

AppDelegate::~AppDelegate() 
{
#if USE_AUDIO_ENGINE
    AudioEngine::end();
#elif USE_SIMPLE_AUDIO_ENGINE
    SimpleAudioEngine::end();
#endif
}

void AppDelegate::initGLContextAttrs()
{
    // set OpenGL context attributes: red,green,blue,alpha,depth,stencil,multisamplesCount
    GLContextAttrs glContextAttrs = {8, 8, 8, 8, 24, 8, 0};

    GLView::setGLContextAttrs(glContextAttrs);
}
// ...诸如此类的实现
```

##### 一个标准.h文件的例子
- `#pragma once`: 'pragma' 源自希腊语 'pragma'（意为“行动”或“事项”）,代指编译指令,整体的意思是只编译一次,也就是第二次在同一个cpp文件里遇到这个头文件时跳过编译
  - 是msvc最早开始启用的预处理指令,之后GCC,Clang也开始支持这个指令,但至今都未纳入cpp标准中
  - 这个奇怪的名字显然是某个自以为很有修养的工程师提出来的,正常人是不会这么起名的

以下示例显示了头文件中允许的各种声明和定义：

```cpp
// sample.h
#pragma once

#include <vector> // #include directive
#include <string>

namespace N  // namespace declaration
{
    inline namespace P
    {
        //...
    }

    enum class colors : short { red, blue, purple, azure };

    const double PI = 3.14;  // const and constexpr definitions
    constexpr int MeaningOfLife{ 42 };
    constexpr int get_meaning()
    {
        static_assert(MeaningOfLife == 42, "unexpected!"); // static_assert
        return MeaningOfLife;
    }
    using vstr = std::vector<int>;  // type alias
    extern double d; // extern variable

#define LOG   // macro definition

#ifdef LOG   // conditional compilation directive
    void print_to_log();
#endif

    class my_class   // regular class definition,
    {                // but no non-inline function definitions

        friend class other_class;
    public:
        void do_something();   // definition in my_class.cpp
        inline void put_value(int i) { vals.push_back(i); } // inline OK

    private:
        vstr vals;
        int i;
    };

    struct RGB
    {
        short r{ 0 };  // member initialization
        short g{ 0 };
        short b{ 0 };
    };

    template <typename T>  // template definition
    class value_store
    {
    public:
        value_store<T>() = default;
        void write_value(T val)
        {
            //... function definition OK in template
        }
    private:
        std::vector<T> vals;
    };

    template <typename T>  // template declaration
    class value_widget;
}
```

- 你很有可能会问为什么头文件中函数,class,struct等高级数据类型的声明不需要用extern修饰,而单独的变量声明却必须要用extern修饰?
  - extern的原理是: 告诉编译器这个变量在别处已经定义;如果单纯写`int x;`,那么编译器就认为这是一个未进行初始化的新定义,会为x再次申请4字节的内存,从而引发重定义报错
  - 函数的声明默认是为extern的
  - 而类和结构体的声明不需要extern,因为它们本身不产生任何内存分配,只有实例化的对象才需要内存分配

##### 头文件的由来
我们需要明确一个事实:cpp标准从没有规定cpp文件和头文件名字的扩展名要求!
事实上如果你将main函数放入x.txt文件中,照样可以正常编译:
```bash
# g++根据扩展名推断语言,所以这里需要用-x c++强制指令语言为cpp,而且我们产生的exe文件使用了txt后缀也没报错
g++ -x c++ x.txt -o result.txt
```
换句话说,`.cpp`,`.h`这些后缀只不过是人为约定的而已,你在里面写的内容与文件名可以毫无关系,也就是说,就算你在头文件里实现了函数的定义也没关系,只要你没有导入进两个或更多文件里,就不会导致函数的重定义进而引发编译器的报错.
#### 复杂项目的处理
当然,如果只有一两个文件的话,我们只用g++进行编译也够了,比如有一个`main.cpp`和一个`tools.cpp`文件,那么我们只要写:
```bash
g++ main.cpp tools.cpp -o result.exe
```
但事实上,我们需要根据各种各样的需求加上各种各样的参数:

| 参数                   | 分类   | 作用说明                                                                          | 示例                           |
| :--------------------- | :----- | :-------------------------------------------------------------------------------- | :----------------------------- |
| **`-o <file>`**        | 基础   | **指定输出文件名**。如果不使用，Linux 默认生成 `a.out`，Windows 默认 `a.exe`。    | `g++ main.cpp -o app`          |
| **`-c`**               | 基础   | **只编译，不链接**。将 `.cpp` 转化为二进制目标文件 `.o`，用于大型项目的增量编译。 | `g++ -c tools.cpp`             |
| **`-I <dir>`**         | 基础   | **指定头文件搜索路径**。当 `#include` 的头文件不在当前目录或标准库时使用。        | `g++ main.cpp -I./include`     |
| **`-L <dir>`**         | 基础   | **指定库文件搜索路径**。告诉编译器去哪里找 `.so` 或 `.a` 静态/动态库文件。        | `g++ main.cpp -L./libs`        |
| **`-l<name>`**         | 基础   | **链接指定的库**。紧跟库名（自动去掉 `lib` 前缀和 `.so`/`.a` 后缀）。             | `g++ main.cpp -lpthread`       |
| **`-g`**               | 调试   | **生成调试信息**。在使用 `gdb` 调试器时，必须加此参数才能看到源码行号。           | `g++ -g main.cpp -o debug_app` |
| **`-Wall`**            | 警告   | **开启常规警告**。检测潜在的逻辑错误（如变量未初始化、类型不匹配）。              | `g++ -Wall main.cpp`           |
| **`-Wextra`**          | 警告   | **开启额外警告**。比 `-Wall` 更严格，能发现更多隐蔽的代码规范问题。               | `g++ -Wall -Wextra main.cpp`   |
| **`-Werror`**          | 警告   | **将警告视为错误**。只要有任何警告出现，编译就会立即终止。                        | `g++ -Werror main.cpp`         |
| **`-O0`**              | 优化   | **不进行优化（默认）**。编译最快，生成的代码与源码一一对应，适合开发阶段。        | `g++ -O0 main.cpp`             |
| **`-O2`**              | 优化   | **标准优化**。平衡编译时间和运行速度，是大多数生产环境项目的首选。                | `g++ -O2 main.cpp`             |
| **`-O3`**              | 优化   | **激进优化**。开启更多高级手段（如循环展开），提升性能但可能增大体积。            | `g++ -O3 main.cpp`             |
| **`-Os`**              | 优化   | **体积优化**。优先缩小生成的二进制文件大小，适合嵌入式或空间受限场景。            | `g++ -Os main.cpp`             |
| **`-std=c++11/17/20`** | 标准   | **指定 C++ 语言版本标准**。开启对应年份的新特性支持（如 `auto`, `concepts`）。    | `g++ -std=c++17 main.cpp`      |
| **`-D<macro>`**        | 预处理 | **定义宏**。相当于在代码顶端写 `#define`，常用于区分测试和生产逻辑。              | `g++ -DDEBUG main.cpp`         |
| **`-E`**               | 预处理 | **只执行预处理**。查看宏展开、头文件包含后的最终代码文本，输出到屏幕。            | `g++ -E main.cpp`              |
| **`-fPIC`**            | 进阶   | **生成位置无关代码**。在编译**动态链接库**（Shared Library）时必须使用。          | `g++ -fPIC -c lib.cpp`         |

显然当文件一多,要链接的库一多,要进行的预编译一多,用g++来写是不可接受的.

让我们先以下面这个cmakelist.txt为例来看看编译时要考虑多少东西:
**cocos示例项目的CMakelists.txt**
```toml
cmake_minimum_required(VERSION 3.6)

set(APP_NAME HelloCpp)

project(${APP_NAME})

set(COCOS2DX_ROOT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cocos2d)
set(CMAKE_MODULE_PATH ${COCOS2DX_ROOT_PATH}/cmake/Modules/)

include(CocosBuildSet)
add_subdirectory(${COCOS2DX_ROOT_PATH}/cocos ${ENGINE_BINARY_PATH}/cocos/core)

# record sources, headers, resources...
set(GAME_SOURCE)
set(GAME_HEADER)

set(GAME_RES_FOLDER
    "${CMAKE_CURRENT_SOURCE_DIR}/Resources"
    )
if(APPLE OR WINDOWS)
    cocos_mark_multi_resources(common_res_files RES_TO "Resources" FOLDERS ${GAME_RES_FOLDER})
endif()

# add cross-platforms source files and header files 
list(APPEND GAME_SOURCE
     Classes/AppDelegate.cpp
     Classes/HelloWorldScene.cpp
     )
list(APPEND GAME_HEADER
     Classes/AppDelegate.h
     Classes/HelloWorldScene.h
     )

if(ANDROID)
    # change APP_NAME to the share library name for Android, it's value depend on AndroidManifest.xml
    set(APP_NAME MyGame)
    list(APPEND GAME_SOURCE
         proj.android/app/jni/hellocpp/main.cpp
         )
elseif(LINUX)
    list(APPEND GAME_SOURCE
         proj.linux/main.cpp
         )
elseif(WINDOWS)
    list(APPEND GAME_HEADER
         proj.win32/main.h
         proj.win32/resource.h
         )
    list(APPEND GAME_SOURCE
         proj.win32/main.cpp
         proj.win32/game.rc
         ${common_res_files}
         )
elseif(APPLE)
    if(IOS)
        list(APPEND GAME_HEADER
             proj.ios_mac/ios/AppController.h
             proj.ios_mac/ios/RootViewController.h
             )
        set(APP_UI_RES
            proj.ios_mac/ios/LaunchScreen.storyboard
            proj.ios_mac/ios/LaunchScreenBackground.png
            proj.ios_mac/ios/Images.xcassets
            )
        list(APPEND GAME_SOURCE
             proj.ios_mac/ios/main.m
             proj.ios_mac/ios/AppController.mm
             proj.ios_mac/ios/RootViewController.mm
             proj.ios_mac/ios/Prefix.pch
             ${APP_UI_RES}
             )
    elseif(MACOSX)
        set(APP_UI_RES
            proj.ios_mac/mac/Icon.icns
            proj.ios_mac/mac/Info.plist
            )
        list(APPEND GAME_SOURCE
             proj.ios_mac/mac/main.cpp
             proj.ios_mac/mac/Prefix.pch
             ${APP_UI_RES}
             )
    endif()
    list(APPEND GAME_SOURCE ${common_res_files})
endif()

# 省略一大堆编译项

```
- 这显然超出了g++的能力了...

#### 构建工具
- [GNU make](https://www.gnu.org/software/make/manual/make.html)
- [ninja作者自述](https://aosabook.org/en/posa/ninja.html)
- [ninja官网](https://ninja-build.org/)

为了解决上述的问题,先后诞生了两种主流的cpp构建工具: make和ninja,它们可以指挥gcc或者其他编译器进行所需的构建.
### make
#### 是什么,怎么用
>The **make** utility automatically determines which pieces of a large program need to be **recompiled**, and issues commands to recompile them.

为了执行make命令,我们需要将它写入makefile文档来执行.

makefile的大致格式如下:
```makefile
target … : prerequisites …
        recipe
        …
        …
```
- target: 生成的目标文件名,比如中间文件(.o)和可执行文件(.exe),当然我们不指明后缀名也行,还可以是要执行的指令名如'clean'等
- prerequisites: 需要用到的源文件
- recipe: make构建时的规则

以下是一个简单的makefile示例:
```makefile
edit : main.o kbd.o command.o display.o \
       insert.o search.o files.o utils.o
        cc -o edit main.o kbd.o command.o display.o \
                   insert.o search.o files.o utils.o
# 将所有中间文件编译成可执行文件                   
# 使用\将一行长句分为两行,也就是说不带\的话默认为单独一行,而makefile中一般一行写源文件名,一行写编译规则
main.o : main.c defs.h
        cc -c main.c
kbd.o : kbd.c defs.h command.h
        cc -c kbd.c
command.o : command.c defs.h command.h
        cc -c command.c
display.o : display.c defs.h buffer.h
        cc -c display.c
insert.o : insert.c defs.h buffer.h
        cc -c insert.c
search.o : search.c defs.h buffer.h
        cc -c search.c
files.o : files.c defs.h buffer.h command.h
        cc -c files.c
utils.o : utils.c defs.h
        cc -c utils.c
clean :
        rm edit main.o kbd.o command.o display.o \
           insert.o search.o files.o utils.o
```
- 很明显,这个makefile是面向Linux系统的,毕竟有`rm`和`cc`这样的终端命令.
在当前目录输入`make`即可生成edit可执行文件,输入`make clean`即可清除中间文件
#### make处理makefile的原理
默认情况下,`make`命令会从makefile里的第一个target开始执行.

>make reads the makefile in the current directory and begins by processing the first rule. In the example, this rule is for relinking edit; but before make can fully process this rule, it must process the rules for the files that edit depends on, which in this case are the object files. Each of these files is processed according to its own rule. These rules say to update each ‘.o’ file by compiling its source file. The recompilation must be done if the source file, or any of the header files named as prerequisites, is more recent than the object file, or if the object file does not exist.
>
>The other rules are processed because their targets appear as prerequisites of the goal. If some other rule is not depended on by the goal (or anything it depends on, etc.), that rule is not processed, unless you tell make to do so (with a command such as make clean).
- 也就是说,make命令只执行第一个target并解决所有的对应依赖项,不会执行第二个命令,除非显示指明

>After recompiling whichever object files need it, make decides whether to relink edit. This must be done if the file edit does not exist, or if any of the object files are newer than it. If an object file was just recompiled, it is now newer than edit, so edit is relinked.
>
>Thus, if we change the file insert.c and run make, make will compile that file to update insert.o, and then link edit. If we change the file command.h and run make, make will recompile the object files kbd.o, command.o and files.o and then link the file edit.

- make会在target对应的源文件更新时自动重新编译target,而不触及其他未改动的部分

事实上了解到这里就差不多了,毕竟现在真的没必要手写makefile了,电脑系统再怎么古老CMake应该还是能用的吧...

### ninja
#### 是什么,怎么用
>Ninja is yet another **build system**. It takes as input the interdependencies of files (typically source code and output executables) and orchestrates building them, **quickly**.
- ninja能够代替古老的make的原因就在于它很快,比make快了十倍以上

>Ninja contains the barest functionality necessary to describe arbitrary dependency graphs. Its lack of syntax makes it impossible to express complex decisions.
>
> Ninja has almost no features; **just** those necessary to get builds correct while punting most complexity to generation of the ninja input files. Ninja by itself is unlikely to be useful for most projects.
- 事实上,ninja的设计初衷就是追求快速,摒弃一切不必要的功能,从而大大提高了构建速度.
  - ninja官网的说明文档在加入了一大堆参数说明后仍然远远短于make官网的说明文档

**一个简短的示例**
```bash
cflags = -Wall

rule cc
  command = gcc $cflags -c $in -o $out
# rule类似于make中的target,但用法上灵活的多
# $为变量插入声明,也就是说,这里的$cflags相当于-Wall
# 当然,我们也可以写成${cflags},看个人喜好
build foo.o: cc foo.c
```
我们需要将这段代码放入**build.ninja**文件中,再在终端执行`ninja`命令即可进行构建,用法与make的命令也基本类似.

实际上我们了解到这个程度也就足够了,只需要知道ninja的原理与make类似,但写法上灵活的多,构建速度也快的多.
### 高级构建工具: CMake
现在来到了我们的重头戏:CMake,先来看一下[wiki介绍](https://zh.wikipedia.org/wiki/CMake)
>CMake是个一个开源的跨平台自动化建构系统，用来管理软件建置的程序，并不依赖于某特定编译器，并可支持多层目录、多个应用程序与多个函数库.
>CMake的配置文件取名为**CMakeLists.txt**,它并不直接建构出最终的软件，而是产生标准的构建文件（如Unix的Makefile）
>
>CMake”这个名字是**Cross platform Make**的缩写。虽然名字中含有“make”，但是CMake和Unix上常见的make系统是分开的，而且更为高阶

- 既然CMake是用来指挥ninja,make等构建文件的,自然它就是高级构建工具了.

#### 命令行使用
- [参考教程](https://modern-cmake-cn.github.io/Modern-CMake-zh_CN/chapters/intro/running.html)

>除非另行说明，你始终应该建立一个专用于构建的目录并在那里构建项目。从技术上来讲，你可以进行内部构建（即在源代码目录下执行 CMake 构建命令），但是必须注意不要覆盖文件或者把它们添加到 git，所以别这么做就好。


一个经典的CMake构建流程如下:
```bash
mkdir build
# 在当前目录创建build文件夹
# 尽管这是Linux命令,但Windows的Powershell现在也支持了
cd build
cmake ..
# 根据上级目录里的CMakelists进行CMake构建
# 并将构建出来的makefile放入build文件夹中
make
# 自然,我们未必会使用make进行构建,所以还可以写成以下形式:
cmake --build .
# 在build目录中使用cmake的默认构建工具进行构建
```

但是四行命令明显太多了,我们可以这样写:
```bash
cmake -S . -B build
# -S: source,指定CMakelists所在目录
# -B: build,指定CMake的输出(如makefile,ninja.build)目录
cmake --build build
# 在build目录中使用cmake的默认构建工具进行构建
```
- 也就是说,我们可以在根目录执行cmake命令,或者进入build文件夹后再执行cmake命令

自然,当我们的电脑上安装了多种构建工具时,我们希望在初次构建时选定自己所需的那种,只需要这么写:
```bash
cmake -S . -B build -G "Ninja"
# 指定ninja
# -G: generator,构建工具
```

运行`cmake --help`可以查看基础的cmake命令和该操作系统上可用的构建工具:
```bash
cmake --help

Usage

  cmake [options] <path-to-source>
  cmake [options] <path-to-existing-build>
  cmake [options] -S <path-to-source> -B <path-to-build>

Specify a source directory to (re-)generate a build system for it in the
current working directory.  Specify an existing build directory to
re-generate its build system.

Options
  -S <path-to-source>          = Explicitly specify a source directory.
  -B <path-to-build>           = Explicitly specify a build directory.
  -C <initial-cache>           = Pre-load a script to populate the cache.
  -G <generator-name>          = Specify a build system generator.
  -T <toolset-name>            = Specify toolset name if supported by
                                 generator.
  -A <platform-name>           = Specify platform name if supported by
                                 generator.
# ...省略一大堆参数

Generators

The following generators are available on this platform (* marks default):
  Visual Studio 18 2026        = Generates Visual Studio 2026 project files.
                                 Use -A option to specify architecture.
* Visual Studio 17 2022        = Generates Visual Studio 2022 project files.
                                 Use -A option to specify architecture.
# ...省略一大堆支持的平台
```

##### 编写CMakelist
当我们运行的是别人的项目时,知道如何用CMake构建就足够了,但很多时候我们都要自己写CMake来构建项目,这就需要我们去深入了解CMakelists的写法了.
- [官方教程](https://cmake.org/cmake/help/latest/guide/tutorial/index.html)
#### CMakelists.txt的前置内容
**最低版本要求**
这是每个`CMakeLists.txt`都必须包含的第一行:

```toml
cmake_minimum_required(VERSION 4.3)
# 该命令不区分大小写,但习惯上小写
# CMake3.12以后的版本支持版本的范围要求:
cmake_minimum_required(VERSION 3.12...3.21)
```
- 如果你用的cmake版本比声明上所写的更高,由于cmake向后兼容,因此会按照声明的版本来运行.
**项目设置**
声明该项目的名字,版本号,描述,使用的语言
```toml
project(MyProject VERSION 1.0
                  DESCRIPTION "Very nice project"
                  LANGUAGES CXX)
# 项目名字之外的参数没有顺序要求
```
>When CMake sees the project() command it performs **various checks** to ensure the environment is suitable for building software; such as checking for compilers and other build tooling, and discovering properties like the endianness of the host and target machines.


这两个部分最好放在顶部或者接近顶部,如:
```toml
# ...版权声明
cmake_minimum_required(VERSION 3.23)

project(MyProjectName)
# ...剩余部分
```

##### CMake的基础特性
>The only fundamental types in CMakeLang are **strings and lists**. Every object in CMake is a **string**, and **lists** are themselves strings which contain **semicolons** as separators.
- 由于CMake的这个特性,故CMakelist看起来非常累,没有`:`,没有单引号,也没有`--`,只通过空格,空行和缩进来体现层次关系,注释则使用`#`.

**设置变量并插入字符串**
```toml
set(var "World!")
message("Hello ${var}")
```
- set用于设置变量
- message用于打印调试信息
- `${var}`用于插入变量


#### 实战
```toml
cmake_minimum_required(VERSION 3.6)

set(APP_NAME cpp-empty-test)

project(${APP_NAME})

if(NOT DEFINED BUILD_ENGINE_DONE)
# DEFINED: 关键字,检查该变量是否用set关键字定义过
    set(COCOS2DX_ROOT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../..)
    # CMAKE_CURRENT_SOURCE_DIR: 内置变量,表示当前的txt文件所在目录
    # /..表示往上级查找,相当于找到上两级的根目录
    set(CMAKE_MODULE_PATH ${COCOS2DX_ROOT_PATH}/cmake/Modules/)
# CMAKE_MODULE_PATH: 内置变量,存放查找自定义脚本文件的搜索路径
    include(CocosBuildSet)
    # include: 关键字,执行对应的自定义CMake脚本文件
    add_subdirectory(${COCOS2DX_ROOT_PATH}/cocos ${ENGINE_BINARY_PATH}/cocos/core)
    #  add_subdirectory: 将该目录加入构建系统
endif()

# record sources, headers, resources...
set(GAME_SOURCE)
set(GAME_HEADER)
# 我们之前的set都会在名字后面加对应的变量名,如果不加默认为空字符串,如果先前已经定义则会重置该变量为空.

set(GAME_RES_FOLDER
    "${CMAKE_CURRENT_SOURCE_DIR}/Resources"
    )
if(APPLE OR VS)
    cocos_mark_multi_resources(cc_common_res RES_TO "Resources" FOLDERS ${GAME_RES_FOLDER})
endif()
# APPLE: cmake内置变量,根据当前平台判断是否为真
# VS: cocos自定义变量,判断是否使用VS进行编译

list(APPEND GAME_HEADER
     Classes/AppMacros.h
     Classes/HelloWorldScene.h
     Classes/AppDelegate.h
     )
list(APPEND GAME_SOURCE
     Classes/AppDelegate.cpp
     Classes/HelloWorldScene.cpp
     )
# 将对应的文件添加到先前定义的两个列表变量中
if(ANDROID)
    # change APP_NAME to the share library name for Android, it's value depend on AndroidManifest.xml
    set(APP_NAME cpp_empty_test)
    list(APPEND GAME_SOURCE
         proj.android/app/jni/main.cpp
         )
elseif(LINUX)
    list(APPEND GAME_SOURCE
         proj.linux/main.cpp
         )
elseif(WINDOWS)
    list(APPEND GAME_HEADER
         proj.win32/main.h
         )
    list(APPEND GAME_SOURCE
         proj.win32/main.cpp
         ${cc_common_res}
         )
elseif(APPLE)
    if(IOS)
        list(APPEND GAME_HEADER
             proj.ios/AppController.h
             proj.ios/RootViewController.h
             )
        set(APP_UI_RES
            proj.ios/LaunchScreen.storyboard
            proj.ios/LaunchScreenBackground.png
            proj.ios/Images.xcassets
            )
        list(APPEND GAME_SOURCE
             proj.ios/main.m
             proj.ios/AppController.mm
             proj.ios/RootViewController.mm
             ${APP_UI_RES}
             )
    elseif(MACOSX)
        set(APP_UI_RES
            proj.mac/Icon.icns
            proj.mac/Info.plist
            proj.mac/en.lproj/MainMenu.xib
            proj.mac/en.lproj/InfoPlist.strings
            )
        list(APPEND GAME_SOURCE
             proj.mac/main.cpp
             ${APP_UI_RES}
             )
    endif()
    list(APPEND GAME_SOURCE ${cc_common_res})
endif()

set(all_code_files
    ${GAME_HEADER}
    ${GAME_SOURCE}
    )
# 将两个列表变量打开后送入变量all_code_files中

# mark app complie info
if(NOT ANDROID)
    add_executable(${APP_NAME} ${all_code_files})
    # 使用所有文件编译成对应名字的可执行程序
else()
    add_library(${APP_NAME} SHARED ${all_code_files})
    add_subdirectory(${COCOS2DX_ROOT_PATH}/cocos/platform/android ${ENGINE_BINARY_PATH}/cocos/platform)
    target_link_libraries(${APP_NAME} -Wl,--whole-archive cpp_android_spec -Wl,--no-whole-archive)
endif()

target_link_libraries(${APP_NAME} cocos2d)
# target_link_libraries: 关键字,指定链接器将cocos2d库和游戏可执行文件绑定
target_include_directories(${APP_NAME} PRIVATE Classes)
# 当你在 .cpp 文件中写 #include "HelloWorldScene.h" 时，编译器需要知道去哪里找这个文件。默认情况下，编译器只在当前源文件所在目录和系统目录里找。

# 这行命令相当于告诉编译器：
# “编译 ${APP_NAME} 的源文件时，记得额外去 Classes 目录下搜索头文件。”
```
根据这个cmakelist,我们大致可以明白cmake的构建过程:
1. 配置编译时要用到的环境变量
2. 设置要进行编译的文件(如这里的GAME_HEADER和GAME_SOURCE)
3. 针对不同的平台设置不同的编译链
4. 加入静态和动态库链接


拓展阅读:
- [比官网写得更好的cmake教程](https://hsf-training.github.io/hsf-training-cmake-webpage/)


# 早期版本存档
- 26年3月的系列文字,写的不清不楚,也不够深入,很多都没写完,之所以没删掉,是认为那个时候的我尽管很菜,但确实有一些思维上的闪光点值得日后回顾.

## cpp历史
- [wiki](https://en.wikipedia.org/wiki/C%2B%2B)

### 1. 诞生背景与“带类的 C”（1979 - 1982）
Bjarne Stroustrup 在贝尔实验室工作期间，因分析 UNIX 内核需要，试图结合 **Simula** 的抽象能力与 **C** 的高效性能。
* **1979年**：开始研发 **“C with Classes”**（C++ 的前身）。
* **核心特性**：引入类（Classes）、继承（Derived Classes）、强类型检查、内联函数（Inlining）和默认参数。

### 2. C++ 奠基时代（1983 - 1991）
* **1983年**：正式更名为 **C++**（利用 C 语言的自增运算符 `++`，寓意 C 的进化）。
* **1984年**：实现首个 **流输入/输出库（Stream I/O）**。
* **1985年**：
    * 发布经典著作 **《The C++ Programming Language》** 第一版。
    * 首个商业化 C++ 编译器正式面世。
* **1989年 (C++ 2.0)**：引入多重继承、抽象类、静态成员函数、`const` 成员函数以及 `protected` 访问权限。
* **1990年**：发布《The Annotated C++ Reference Manual》，为后续标准化工作奠定逻辑框架。

### 3. 标准化与工业成熟期（1998 - 2003）
* **1998年 (C++98)**：第一个国际标准 ISO/IEC 14882:1998 发布。
    * **里程碑特性**：**模板（Templates）**、异常处理、命名空间（Namespaces）、布尔类型、STL（标准模板库）正式入标。
* **2003年 (C++03)**：一个主要针对 C++98 的技术修正版本，修复了大量编译器实现层面的细节问题，稳定性提升。

### 4. 现代 C++ 复兴（2011 - 2020）
在经历了长达 8 年的停滞后，C++ 进入了高频迭代周期：
* **2011年 (C++11)**：**具有划时代意义的“新 C++”**。
    * **核心特性**：自动类型推导（`auto`）、Lambda 表达式、右值引用（Rvalue references）与移动语义、智能指针、基于范围的 `for` 循环。
* **2014年 (C++14)**：对 C++11 的微调与完善，增强了泛型 Lambda 和 `constexpr` 的能力。
* **2017年 (C++17)**：引入结构化绑定、`std::optional`、`std::variant`、文件系统库（Filesystem API）以及对并行的原生支持。
* **2020年 (C++20)**：被称为继 C++11 后最大的变革。
    * **四大支柱**：**概念（Concepts）**、**范围（Ranges）**、**协程（Coroutines）**、**模块（Modules）**。



## 基础语法
- [官方文档](https://cppreference.com/cpp/language/type)
  - 非常难啃,很书面化,不太推荐

### 关键字
#### const与volatile
- [参考](https://eel.is/c++draft/dcl.type.cv)
使用const修饰`int x`的时候,与单纯的写`int x`在内存区域上的表现没有什么不同,也就是说,const是一个编译时关键字,保证在运行时没有任何指令可以修改这块内存区域.

>Any attempt to modify a const object during its lifetime results in undefined behavior.

而**volatile**强制编译器取消对这个变量的运行期优化,要求每次对这个变量的操作都实际发生在内存,但现在基本很难看见这个关键字了.
#### static
- [来源](https://www.runoob.com/w3cnote/cpp-static-usage.html)

>我们知道在函数内部定义的变量，当程序执行到它的定义处时，编译器为它在栈上分配空间，函数在栈上分配的空间在此函数执行结束时会释放掉，这样就产生了一个问题: 如果想将函数中此变量的值保存至下一次调用时，如何实现？ 最容易想到的方法是定义为全局的变量，但定义一个全局变量有许多缺点，最明显的缺点是破坏了此变量的访问范围（使得在此函数中定义的变量，不仅仅只受此函数控制）。static 关键字则可以很好的解决这个问题。
>
>另外，在 C++ 中，需要一个数据对象为整个类而非某个对象服务,同时又力求不破坏类的封装性,即要求此成员隐藏在类的内部，对外不可见时，可将其定义为静态数据。

**TL;DR**:

（1）在修饰变量的时候，static 修饰的静态局部变量只执行初始化一次，而且延长了局部变量的生命周期，直到程序运行结束以后才释放。
（2）static 修饰全局变量的时候，这个全局变量只能在本文件中访问，不能在其它文件中访问，即便是 extern 外部声明也不可以。
（3）static 修饰一个函数，则这个函数的只能在本文件中调用，不能被其他文件调用。static 修饰的变量存放在全局数据区的静态变量区，包括全局静态变量和局部静态变量，都在全局数据区分配内存。初始化的时候自动初始化为 0。


#### static_cast与其他的类型转换
- [参考](https://www.cnblogs.com/wanghongyang/p/15054880.html)
- [StackOverflow上的解答](https://stackoverflow.com/questions/332030/when-should-static-cast-dynamic-cast-const-cast-and-reinterpret-cast-be-used)

当我们需要强制更改变量类型的时候,应该考虑到一点:
- 如果直接在内存对应地址增加或者减小它的占用空间大小,显然会导致各种各样的内存问题.
因此,类型转换一般是不更改内存的,而是在编译时告诉编译器这个变量的类型改变了,请你按照改变后的类型来处理这个变量.

>隐式类型转换是安全的，显式类型转换是有风险的，C语言之所以增加强制类型转换的语法，就是为了强调风险，让程序员意识到自己在做什么。
>
>但是，这种强调风险的方式还是比较粗放，粒度比较大，它并没有表明存在什么风险，风险程度如何。
>
>为了使潜在风险更加细化，使问题追溯更加方便，使书写格式更加规范，C++ 对类型转换进行了分类，并新增了四个关键字来予以支持，它们分别是：
| 关键字                 | 说明                                                                                                                          |
| :--------------------- | :---------------------------------------------------------------------------------------------------------------------------- |
| **`static_cast`**      | 用于良性转换，一般不会导致意外发生，风险很低。                                                                                |
| **`const_cast`**       | 用于 `const` 与非 `const`、`volatile` 与非 `volatile` 之间的转换。                                                            |
| **`reinterpret_cast`** | 高度危险的转换，这种转换仅仅是对二进制位的重新解释，不会借助已有的转换规则对数据进行调整，但是可以实现最灵活的 C++ 类型转换。 |
| **`dynamic_cast`**     | 用于多态和向下转型                                                                                                            |


#### constexpr

#### decltype



### 指针与引用
#### 指针实质
事实上,接触了差不多一年cpp,我还是没有彻底搞懂指针,教材上,网上讲的基本都是怎么用指针,简单的告诉你指针就是取地址,调用的时候就是解引用取得引用对象,但并没有告诉我,为什么这么写就能行.
试着阅读<< C++ Programming Language >>的第七章,里面是这么讲的:
>对于类型T来说,T*是`指向T的指针`的类型,换句话说,T*类型的变量能够存放T类型对象的地址.
>
>对指针的一个基本操作是解引用(dereferencing),即引用指针所指的对象,也被称为间接取值(indirection),解引用运算符为`*`.
比如:
```cpp
char c = 'a';
char* p = &c;
char c2 = *p;
```
但书上到这里就戛然而止了,相当于啥都没讲,并没有触及底层的设计理念.不过话说回来,指针是从c传下来的,不关cpp设计的事.🙂

那么,为什么要这样写呢,也就是说,为什么不能直接写`char p = &c;`来存储地址,然后再把这个解引用运算符用来根据地址p来找到原来的c变量呢?

思考一下,`char p = &c`只是定义了一个char变量而已,也就是规定死了为1字节长,这里由于没用unsigned char,故只能取到0-127的地址值,因为地址的绝对值显然不会为负值.

显然,与其用char,我们不如用`long long int`类型来存储高达8字节的地址值,从而保证能存取足够多的地址,也就是这样写:
```cpp
char c = 'a';
long long p =&c;
```

那么,取到地址之后我们又要怎么根据这个地址取到应该取的值呢?

>要知道,变量值是分布在一块连续内存上的,你并不知道这个地址的前后是什么,可能是程序的核心部分,也可能是上次运行后尚未清除的缓存垃圾.当然,我们可以根据p所引用的变量c的类型来判断要读取的连续字节数,比如在我们的例子中p对应的是`char c`,也就是说我们只需要在这个地址往后取一个字节,就可以找回这个变量c存储的值了.

可是,上述的论述中有一个问题,那就是p只是存储了c的地址而已,**它并不知道c的类型**!那么,显然我们需要一种标识来取代单纯的**long long p**声明,这个标识还需要能够表明我所引用地址对应变量的类型.
比如,为了满足上述的要求,它可以写成类似`long long char mark`的形式,但显然这太长了,也太丑了...

但我们又可以想到,既然指针需要使用long long类型来保证取到尽可能多的地址,那么`long long`这个部分就可以省略了,上述例子从而简化成了`char mark`,让编译器根据这个**mark**来了解这是一个需要用long long来存储的指针变量.

那么,问题就简化到了这个**mark**用什么符号来表示比较好.

非常可惜的是,c语言的设计者们并没有想过将解引用符号`*`和取指针符号**mark**分开来表示,而是直接把**mark**定为了`*`,从而导致了学习c语言的无穷痛苦...

所以,回到这一句:
```cpp
char* p = &c;
```
我们现在可以很清楚的知道, 这个p是一个long long大小的变量,存储了char类型变量c的地址,尽管美中不足的是,这个标记`*`偏偏和解引用的`*`是同一个符号!

#### void*,NULL与nullptr
`void*`是一个指向void类型的指针,由于不存在有一个void类型的变量,故这个指针自然没有任何指向对象,也就无法进行解引用去取对象,无法进行算术运算.在使用时必须显式地转换成某一特定类型的指针.
- 在实际生产中很少被用在上层设计中,多用于底层的资源调度

现在我们根据**__stddef_null.h**来看一看NULL
```cpp
#ifdef __cplusplus
#if !defined(__MINGW32__) && !defined(_MSC_VER)
#define NULL __null
#else
#define NULL 0
#endif
#else
#define NULL ((void*)0)
#endif
```
可以清楚的发现NULL事实上是一个宏,有时候是0,有时候是一个...,`(void*)0`,这是什么东西?
还是从一个简单代码起步好了,我们知道,有时候需要将一个高位类型比如int,塞入一个低位类型比如char中,由于直接塞进去的话编译器会警告可能会丢失值,所以我们可以这样写:
- 注意: static_cast我会在后面涉及,而且在C语言中我们只能这样强制转换.
```cpp
int s = 999999999;
char c = (char)s;
```
我们可以更进一步,加入指针试试:
```cpp
int* p = (int*)100;   // 把数字 100 强制转换成 int* 类型
// 现在 p 指向的“地址”是 100
// 这是一个非常危险的操作，实际程序几乎永远不应该这么写
```
你可能会很好奇,这怎么就取到地址100了呢,真正取地址100,应该写成以下形式:
```cpp
int* p = &100;
```
但事实上这段代码会报错,因为&无法作用于100这样一个纯右值(可以理解为临时值).

当然你会说: 就算这样,我也不能接受`(int*)100`怎么就直接简单的变成地址100了!

我们可以这样理解,`(int*)100`必须得指向一个东西,因为如果不指向某个东西的话,说明它是一个类似于`int* p`这样没有赋值的野指针,但是`(int*)100`并不是这样,它是一个指向int类型的"右值100",那么我不能随便让它指向某块区域,否则就会导致内存混乱,最好指向一个与它的内容"100"有关系的区域,那么在设计者的角度来看,自然是指向地址100比较好了,实际应用中的编译器也是这么处理的.(当然我的这段分析可能是错误的,甚至整个都错了,但是我们需要牢牢记住: `(int*)100`就是地址100!)


经过上面的一大段分析,那么`(void*)0`就比较好理解了:将int类型的0强制转换成指向void类型的地址0,而地址0由于受到保护,故不能被解引用和运算,从而将NULL变成一个受保护的空指针.

很显然,void*和NULL并不够直观和好用,所以c++11引入了nullptr这个关键字用来表示空指针,这里我没有给源码,是因为这个nullptr与int,double这些类型一样,是一个编译器硬编码的运行期对象,不存在用一个库来定义nullptr.

既然nullptr叫做空指针,那么自然无法给int,double这些普通类型变量赋值,而是只能给指针变量赋值:
```cpp
struct Node {
    int data;
    Node* left;
    Node* right;

    Node(int val)
        : data(val)
        , left(nullptr)
        , right(nullptr)
    {}
};
```
如果不赋与nullptr这个初始值,就会产生野指针,从而导致各种各样的内存问题.


#### 数组中的指针
当我们需要处理一个分组的数据比如{1,2,3,4,5}时,我们可以这样写:
```cpp
//{1,2,3,4,5}
int s =12345; //将s作为存储变量
int s1=s/10000;
int s2=s/1000%10;
int s3=s/100%10;
int s4=s/10%10;
int s5=s%10;
```
自然,当数据量过大时这么写就有点过分了,显然不应该用某一个普通的int型或者long long型变量来存数据,而是应该转换思路,用一块连续内存来存数据,从而保证能够容纳足够大的数据量.

因此可以引入一个新的符号,姑且称为x,我们希望这个x可以实现以下几个要求:
1. 初始值为这个存储变量s的首地址,对应的是存储对象列表的第一个元素
2. 根据存储对象的类型(这里是int)得到相邻元素之间的内存距离
3. 可以经过简单的数学运算获取任意一个元素的位置,这被称为**随机存取**

你有可能会想,怎么能有这么好的事可以一下子解决三个问题呢?

但根据前面的讨论,我们知道:指针可以用来映射到一块特定的内存上,也就是说我们可以将指针对准这个存储变量的首地址,并且可以简单的对指针进行加减操作,从而取到下一个元素的地址甚至是任意一个元素的地址!所以,问题解决了.

于是,我们应该可以这么写:
```cpp
int *s =mark(1,2,3,4,5);
```
很显然,这个mark应该能够做到以下事情:
1. 告诉编译器这是一个数据列表,而不是别的什么
2. 为*s提供这个数据列表的首地址

尽管我们可以设计成类似`$(1,2,3,4,5)`或者`#(1,2,3,4,5)`这种比较正常的标记方式,但遗憾的是设计者想起来还有`{}`这个大括号没用过,于是将`mark()`变成了`{}`.(另一个好处是,在早期一个字符的开销也很重要的时候,可以减少表达式所用的字符).

于是,我们或许可以这样写:
```cpp
int *s={1,2,3,4,5};

int s1 = *s;
int s2 = *(s+1);
int s3 = *(s+2);
int s4 = *(s+3);
int s5 = *(s+4);
```
但如果你试着去运行的话,这串代码一定会报错!因为设计者并没有让这个mark成功做到上述的两个事情,上述的一系列设想都是我们的**一厢情愿**.

相反,`{}`只是一个构造器,没有任何返回值,必须需要等号左边部分的配合才可以填入值,而不能单独存在.

如果你好奇为什么的话,我们可以这样想,当你写 {1,2,3,4,5} 时，这五个整数总得找个地方落脚:
- 如果存放在栈（Stack）上，那么当函数执行完毕，这块内存就会被回收。此时你的指针 s 将变成一个恐怖的野指针。
- 如果存放在静态区（Data Segment），那么这块内存就是只读的，你无法在运行时修改它。
- 如果存放在**堆（Heap）**上，谁来负责 delete 它？C++ 的设计哲学是“不为不使用的东西付费”，这种隐式的内存分配违背了确定性。

因此,在将指针指向这个数据列表之前,我们需要先为这个数据列表分配一个合适的地址.
换句话说,我们还需要引入一个新类型变量来存储这个数据列表的地址,因为现有的变量类型是无法存入列表的.

同时,我们应该让这个新类型能够规范数据列表内部的类型为单一的一种,因为如果这个列表内又有int,又有long long,在用指针访问元素时必然出现混乱.

我们不妨写成这样:
```cpp
int mark(t) = {1,2,3,4,5};
int *s = t;
```
这个mark()出色的完成了以下两个任务:
1. 通知编译器划出该数据列表的空间
2. 为*s提供这个数据列表的首地址

更加遗憾的是,设计者又想起来还有`[]`这个中括号没用过...于是整个代码变成了我们熟悉的样子:
```cpp
int t[] = {1,2,3,4,5};
int *s = t;

int s1 = *s;
int s2 = *(s+1);
int s3 = *(s+2);
int s4 = *(s+3);
int s5 = *(s+4);
```
当然,本着物尽其用的原则,`[]`空在那里显然不太好看,于是设计者动了点巧思,让它在初次定义的时候可以规定划定的空间大小,并且在定义之后,能作为解引用符号来访问特定元素:
```cpp
int t[5] = {1,2,3,4,5};

int s1 = t[0]; //t[0] 等价于 *(t+0)
int s2 = t[1];
int s3 = t[2];
int s4 = t[3];
int s5 = t[4];
```
尽管这个设计很精妙,但我的意见是,与其让一个符号承担多个责任,不如清楚的用不同符号区分责任,(我的意见自然是不重要的).

值得一提的是**数组退化**问题:
```cpp
// 虽然形参写成 int arr[]，但在编译器眼里它就是 int* arr
void process(int arr[]) {
    // 这里的 sizeof(arr) 返回的是指针的大小（通常是 8 字节），而不是数组的总大小
    std::cout << "函数内部 sizeof(arr): " << sizeof(arr) << " bytes" << std::endl;

    // 通过指针偏移修改内存，会直接影响原数组
    arr[0] = 99; 
}

int main() {
    int my_array[5] = {1, 2, 3, 4, 5};
    
    std::cout << "函数外部 sizeof(my_array): " << sizeof(my_array) << " bytes" << std::endl;
    
    // 传递数组名，触发退化：int[5] -> int*
    process(my_array);

    std::cout << "修改后的首元素: " << my_array[0] << std::endl;
    return 0;
}
```
当经过上述一系列讨论后,这个问题的答案就显然易见了,process()函数传入的是数组的首地址,那么就应该用指针`int *arr`来处理了,至于为什么形参可以写成`int arr[]`或者`int arr[5]`,那可以理解为设计者还想让这个`[]`继续发光发热,既可以在形参中表示这是一个数组的首地址,还可以填入这个数组的预想空间大小-尽管实际运行时是不起作用的.


>综上所述,本来我们可以通过各种各样的标识来区分`[]`一个符号干的不同活儿,但遗憾的是cpp已经被设计成了这个样子了,那么只好随它去了.

#### const指针
```cpp
void f(char* p){
    char s[]="Gorm";

    const char* pc = s; //指向常量的指针
    pc[3] = 'g'; //错误,pc指向常量
    pc = p; //OK

    char* const cp = s; //指向char的常量指针
    cp[3] = 'a'; //OK
    cp = p; //错误,cp是一个常量

    const char* const cpc = s; //指向常量的常量指针
    cpc[3] = 'a' //错误,cpc指向常量
    cpc = p; //错误,cpc是一个常量
}
```
我们可以根据这段代码得出以下结论:
1. 当指针指向的变量使用const修饰时,无论指向的变量是否是常量,通过指针访问这个变量时都不允许做任何修改;但是,指针可以更改它指向的变量,也就是更改存储的地址内容
2. 当指针被设定为常量时,其存储的地址内容不允许再被修改,也就是固定与初始化的变量绑定,但是可以通过指针修改绑定变量的内容
3. 当常量指针指向常量时,既不能修改绑定变量,又不可以修改被绑定的变量的内容,怎么用都很安全


#### 引用实质
由于指针过于复杂和难懂,我们希望找到另外一种简单的方式,解决跨越函数和文件更改变量值的问题,因此,我们引入了引用(`&`)这个概念.
当我们写出以下代码时:
```cpp
int a = 123;
int &b = a;
```
应该有一个疑问: 变量b是什么?

由于这里没有取地址符号,故b不是指针;它也不是一个新变量,因为当我们改变b的值的时候,a的值也会同步改变.

那么,我们可以这样想:既然这个变量既不是一个指针,也不是一个变量,那么他就只能是一个临时值,换句话说,b是一个只存在于编译期的变量,作为绑定变量的别名,不会被存入内存中.
- 尽管从底层来看的话,引用还是一个指针,因为你终归是要将这个别名指向原变量的

### new/delete操作符
### struct和enum
#### struct
- struct是一个可以存放不同类型变量,甚至可以存放函数的数组,在内存中按照变量的声明顺序依次存储,按字节对齐

当结构体尚未完成声明时,我们可以直接使用这个结构体的指针,因为指针的内存空间是已知的,固定为8字节;但是你不能声明结构体本身,因为结构体的内存还是未知的.
```cpp
struct Link{
    Link* previous;
    Link* successor;
};

// 下面这个结构体会编译失败
struct Failed_Link{
    Failed_Link s;
};

```
#### enum
### OOP
#### this指针
- [菜鸟教程](https://www.runoob.com/cplusplus/cpp-this-pointer.html)
- [官方文档](https://en.cppreference.com/w/cpp/language/this.html)

this指针是class/结构体中的**隐藏指针**,指向当前实例,可以被直接调用:
```cpp
#include <iostream>
 
class MyClass {
private:
    int value;
 
public:
    void setValue(int value) {
        this->value = value;
    }
 
    void printValue() {
        std::cout << "Value: " << this->value << std::endl;
    }
};
 
int main() {
    MyClass obj;
    obj.setValue(42);
    obj.printValue();
 
    return 0;
}
```
##### ->运算符
上述代码中出现了`->`,它的本质是对指针对象进行解引用后再使用成员运算符`.`访问属性,用代码表示是这样的:
```cpp
void printValue() {
        std::cout << "Value: " << this->value << std::endl;
        // 等价于
        *this.value << std::endl;

    }
```

#### 一个完整的类的示例
```cpp
// class.cpp
// compile with: /EHsc
// Example of the class keyword
// Exhibits polymorphism/virtual functions.

#include <iostream>
#include <string>
using namespace std;

class dog
{
public:
   dog()
   {
      _legs = 4;
      _bark = true;
   }

   void setDogSize(string dogSize)
   {
      _dogSize = dogSize;
   }
   virtual void setEars(string type)      // virtual function
   {
      _earType = type;
   }

private:
   string _dogSize, _earType;
   int _legs;
   bool _bark;

};

class breed : public dog
{
public:
   breed( string color, string size)
   {
      _color = color;
      setDogSize(size);
   }

   string getColor()
   {
      return _color;
   }

   // virtual function redefined
   void setEars(string length, string type)
   {
      _earLength = length;
      _earType = type;
   }

protected:
   string _color, _earLength, _earType;
};

int main()
{
   dog mongrel;
   breed labrador("yellow", "large");
   mongrel.setEars("pointy");
   labrador.setEars("long", "floppy");
   cout << "Cody is a " << labrador.getColor() << " labrador" << endl;
}
```

### 宏替换与别名
```cpp
//别名,只用于类型替换
using NewType = OldType;
//示例
using ll =long long;
using vec = std::vector<int>;

//文本替换
#define NAME replacement

//示例

#define PI 3.1415926
#define MAX 100

/*
但也可以带入参数
*/
#define SQR(x) ((x)*(x))
#define LOOP(i,n) for(int i=0;i<n;i++)

//typedef -using的下位替代,基本没用
typedef OldType NewType;
//示例
typedef long long ll;
```
### io
#### 读入多行
`cin>>`遇到空格或换行符会停止输入,想要读取一整行需要使用`getline(cin,s1) 这样的格式
#### scanf和printf
```c
int age;
char name[20];

// 1. 缓冲区残留坑：读取字符/字符串前，若上方有残余换行符，需手动处理
printf("Enter age: ");
if (scanf("%d", &age) != 1) return 1; // 2. 返回值坑：必须检查返回值以确认物理输入成功

printf("Enter name: ");
// 3. 溢出与空格坑：使用 %s 无法读取空格且易越界。限制长度并注意数组名本身是地址
scanf("%19s", name); 

// 4. 格式化输出：printf 严格对应类型，%d 对应整型，%s 对应字符串
printf("Data: Name=%s, Age=%d\n", name, age);
```

## 进阶特性

### 左值引用和右值引用
- [参考1](https://blog.csdn.net/m0_59938453/article/details/125858335)
- [参考2](https://nettee.github.io/posts/2018/Understanding-lvalues-and-rvalues-in-C-and-C/)




### 智能指针

### 为什么类和结构体定义时结尾要加一个分号
- [问题讨论](https://www.zhihu.com/question/441151329)

一种看法是将结构体的定义看作是类似与`int a = 1;`这样的变量声明,自然要加分号,而class源自struct,自然也保留了分号.
- 不过java成功的去掉了这个烦人的分号,加一分.

## STL(Standard Template Library )
在vscode里右键对应的头文件或方法,选择查找定义,则可以找到对应的stl源代码.
### 通用
- .size()方法是STL里通用的求容器长度的方法
- `memset(a, 0, sizeof(a));`or`memset(a, -1, sizeof(a));`是好用的重置大法

#### iterator(迭代器)详解

#### memset()详解
```h
void* __cdecl memset(
    _Out_writes_bytes_all_(_Size) void*  _Dst,
    _In_                          int    _Val,
    _In_                          size_t _Size
    );
```
- `__cdecl,_Out_writes_bytes_all_(_Size), _In_`: 这三个都是Microsoft专用的修饰用宏,由于太过底层所以不用去关注
- `void*  _Dst`: 空指针,指向对象内存区
- `int    _Val`: 填充内容,实际上函数底层会将int强制转换为unsigned char,故只有低8位有效.而且,由于memset的内部机制是逐字节将这低8位填入目标内存区域,如果传入1,则会导致填入内容为(0x01010101),无法做到将填入对象置为1的效果,故只能传入(-1和0),从而一致归0或者一致归1.
- `size_t _Size`: 传入单位为字节,而非直觉上以为的元素个数,这也是为什么不能直接写`memset(a,-1,n)`的原因.
  - 正确的写法为`memset(a,-1,sizeof(a))`,sizeof是一个编译时运算符,用于获取对象占用的字节空间,并非是一个库函数.




#### sort()详解
```cpp

template <class _RanIt, class _Pr>
_CONSTEXPR20 void _Sort_unchecked(_RanIt _First, _RanIt _Last, _Iter_diff_t<_RanIt> _Ideal, _Pr _Pred) {
    // order [_First, _Last)
    for (;;) {
        if (_Last - _First <= _ISORT_MAX) { // small
            _STD _Insertion_sort_unchecked(_First, _Last, _Pred);
            return;
        }

        if (_Ideal <= 0) { // heap sort if too many divisions
            _STD _Make_heap_unchecked(_First, _Last, _Pred);
            _STD _Sort_heap_unchecked(_First, _Last, _Pred);
            return;
        }

        // divide and conquer by quicksort
        auto _Mid = _STD _Partition_by_median_guess_unchecked(_First, _Last, _Pred);

        _Ideal = (_Ideal >> 1) + (_Ideal >> 2); // allow 1.5 log2(N) divisions

        if (_Mid.first - _First < _Last - _Mid.second) { // loop on second half
            _STD _Sort_unchecked(_First, _Mid.first, _Ideal, _Pred);
            _First = _Mid.second;
        } else { // loop on first half
            _STD _Sort_unchecked(_Mid.second, _Last, _Ideal, _Pred);
            _Last = _Mid.first;
        }
    }
}

_EXPORT_STD template <class _RanIt, class _Pr>
_CONSTEXPR20 void sort(const _RanIt _First, const _RanIt _Last, _Pr _Pred) { // order [_First, _Last)
    _STD _Adl_verify_range(_First, _Last);
    const auto _UFirst = _STD _Get_unwrapped(_First);
    const auto _ULast  = _STD _Get_unwrapped(_Last);
    _STD _Sort_unchecked(_UFirst, _ULast, _ULast - _UFirst, _STD _Pass_fn(_Pred));
}

_EXPORT_STD template <class _RanIt>
_CONSTEXPR20 void sort(const _RanIt _First, const _RanIt _Last) { // order [_First, _Last)
    _STD sort(_First, _Last, less<>{});
}
```
先解释一下难看懂的地方:
1. _RanIt: Random Access Iterator,可用[]进行定向访问的迭代器
2. _Iter_diff_t<_RanIt>:迭代器之间的差,可以用来体现容器长度
3. `constexpr int _ISORT_MAX = 32`
4. _Pred: cmp函数,排序规则,根据最下方函数可知默认使用`less<>{}`,即从小到大排
5. `for (;;) `: 编译速度与`while(1)`没有任何区别,只是个人习惯或者历史遗留问题而已

可以看到sort函数内部对于不同的容器有三种处理方式:
1. 当容器大小不大于32时,使用插入排序;
2. 当递归深度太大时,转而使用堆排序
3. 默认使用快速排序

现在,仔细看一下快速排序的代码:
```cpp
// divide and conquer by quicksort
        auto _Mid = _STD _Partition_by_median_guess_unchecked(_First, _Last, _Pred);

        _Ideal = (_Ideal >> 1) + (_Ideal >> 2); // allow 1.5 log2(N) divisions

        if (_Mid.first - _First < _Last - _Mid.second) { // loop on second half
            _STD _Sort_unchecked(_First, _Mid.first, _Ideal, _Pred);
            _First = _Mid.second;
        } else { // loop on first half
            _STD _Sort_unchecked(_Mid.second, _Last, _Ideal, _Pred);
            _Last = _Mid.first;
        }
```
大致结构与平常io写的快排没有任何区别,只是专业化了一点而已







