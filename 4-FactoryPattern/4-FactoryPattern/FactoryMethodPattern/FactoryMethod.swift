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
