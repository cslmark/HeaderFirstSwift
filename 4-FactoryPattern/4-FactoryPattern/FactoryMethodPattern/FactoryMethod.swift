//
//  FactoryMethod.swift
//  4-FactoryPattern
//
//  Created by 青枫(陈双林) on 2025/8/4.
//

/*
 工厂方法模式（Factory Method Pattern）
 定义一个创建对象的接口，让子类决定实例化哪个类
 每个具体工厂负责创建一个具体产品
 符合开闭原则
 
 ⼯ ⼚ ⽅ 法 模 式 定 义 了 ⼀ 个 创 建 对 象 的 接 口 ， 但
 由 ⼦ 类 决 定 要 实 例 化 哪 个 类 。 ⼯ ⼚ ⽅ 法 让 类 把 实
 例 化 推 迟 到 ⼦ 类
 */
class BasePizzaStore {
    func createPizza(type: String) -> Pizza {
        fatalError("子类必须实现这个方法，我是个抽象类不能调用")
    }
    
    // 这个类需要流程管控，不允许子类进行重载
    // ⼯ ⼚ ⽅ 法 处 理 对 象 的 创 建 ， 并 将 对 象 创 建 封 装 在 ⼦ 类 中 ， 使 得
    // 超 类 中 的 客 户 代 码 从 ⼦ 类 的 对 象 创 建 代 码 解 耦
    @discardableResult final  func orderPizza(type: String) -> Pizza {
        let pizza = createPizza(type: type)
        
        pizza.prepare()
        pizza.bake()
        pizza.cut()
        pizza.box()
        return pizza
    }
}

class NYPizzaStore: BasePizzaStore {
    override func createPizza(type: String) -> Pizza {
        var pizza = Pizza()
        if type == "Chinses" {
            pizza = ChinesePizza()
        } else if type == "Greek" {
            pizza = GreekPizza()
        } else if type == "Pepper" {
            pizza = PepperPizza()
        } 
        return pizza
    }
}

class ChicoPizzaStore: BasePizzaStore {
    override func createPizza(type: String) -> Pizza {
        var pizza = Pizza()
        if type == "Chinses" {
            pizza = ChinesePizza()
        } else if type == "Greek" {
            pizza = GreekPizza()
        } else if type == "Pepper" {
            pizza = PepperPizza()
        }
        return pizza
    }
}


class Pizza1 {
    var name: String = ""
    var dough: String = ""
    var sauce: String = ""
    var toppings: [String] = []
    
    func prepare() {
        print("Prepare ", name)
        print("Tossing dough ----")
        print("Adding sauce...")
        print("Adding topping...")
        for item in toppings {
            print(item)
        }
    }
    
    func bake() {
        print("Bake for 25 minutes at 350")
    }
    
    func cut() {
        print("Cutting the pizza into disignned slice")
    }
    
    func box() {
        print("Place pizza in official PizzaStore Box")
    }
}

class NYStylePizza: Pizza1 {
    override init() {
        super.init()
        self.name = "NYStylePizza"
        self.dough = "The Crust Dough"
        self.sauce = "Marimara suce"
        self.toppings = ["NYStyle1", "NYStyle2", "NYStyle3"]
    }
    
    override func cut() {
        print("Cutting the pizza into 4 slice")
    }
}


class ChicoStylePizza: Pizza1 {
    override init() {
        super.init()
        self.name = "Chico Pizza"
        self.dough = "The  Chico Crust Dough"
        self.sauce = "Marimara Chico suce"
        self.toppings = ["Chico", "Chico", "Chico"]
    }
    
    override func cut() {
        print("Cutting the pizza into 8 slice")
    }
}


class BasePizzaStore0 {
    func createPizza(type: String) -> Pizza1 {
        fatalError("子类必须实现这个方法，我是个抽象类不能调用")
    }
    
    // 这个类需要流程管控，不允许子类进行重载
    // ⼯ ⼚ ⽅ 法 处 理 对 象 的 创 建 ， 并 将 对 象 创 建 封 装 在 ⼦ 类 中 ， 使 得
    // 超 类 中 的 客 户 代 码 从 ⼦ 类 的 对 象 创 建 代 码 解 耦
    @discardableResult final  func orderPizza(type: String) -> Pizza1 {
        let pizza = createPizza(type: type)
        
        pizza.prepare()
        pizza.bake()
        pizza.cut()
        pizza.box()
        return pizza
    }
}

class NYPizzaStore0: BasePizzaStore0 {
    override func createPizza(type: String) -> Pizza1 {
        var pizza = Pizza1()
        if type == "NYStyle" {
            pizza = NYStylePizza()
        }
        return pizza
    }
}

class ChicoPizzaStore0: BasePizzaStore0 {
    override func createPizza(type: String) -> Pizza1 {
        var pizza = Pizza1()
        if type == "Chico" {
            pizza = ChicoStylePizza()
        }
        return pizza
    }
}

// 依 赖 抽 象 ， 不 依 赖 具 体 类 。
// 这里会有问题，导致店铺类会依赖非常多的Pizza的类，类的依赖关系，容易爆炸
// 设计原则
// 依赖抽象，不依赖具体类
// 依赖倒置的原则中，“倒置”在哪?
// 依赖倒置的原则中的“倒置”，是因为它倒转了通常考虑OO设计的方式。 底层组件现在依赖于更高层的抽象。同样高层组件页绑定到了同一个抽象。 通常的高层组件依赖于底层的组件，现在高层和底层
// 组件都依赖于抽象，依赖图倒置过来了
/**
 避免OO设计中违反依赖倒置的原则:
 1. 变量不应该持有到具体类的引用，因为new的时候就会有具体类的引用。通过使用工厂来绕开
  2. 类不应该派生自具体类(如果派生自具体类，就会依赖具体类。派生自一个抽象)
 3.方法不应该覆盖任何基类的已经实现方法。 （如果覆盖已实现的房费，那么基础类就不是一个真正适合继承的抽象。基类中这些已经实现的方法，应该由所有的子类共享）
 */

