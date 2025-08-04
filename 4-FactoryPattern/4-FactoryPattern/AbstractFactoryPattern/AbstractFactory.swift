//
//  AbstractFactory.swift
//  4-FactoryPattern
//
//  Created by 青枫(陈双林) on 2025/8/4.
//

class BaseIngredient {
    var _name = ""
    var name: String {
        set {
            _name = newValue
        }
        get {
            if _name.isEmpty {
                return String(describing: type(of: self))
            } else {
                return _name
            }
        }
    }
}

class Dough: BaseIngredient {
    
}

class Sauce: BaseIngredient {
    
}

class Cheese: BaseIngredient {
    
}

class Veggie: BaseIngredient {
    
}

class Pepperoni: BaseIngredient {
    
}

class Clam {
    
}

// 0.1 纽约用到的原材料类
class NYDough: Dough {
    
}

class NYSauce: Sauce {
    
}

class NYCheese: Cheese {
    
}

class NYVeggie: Veggie {
    
}

class NYPepperoni: Pepperoni {
    
}

class NYClam: Clam {
    
}

// 0.2 芝加哥的原材料
class ChicoDough: Dough {
    
}

class ChicoSauce: Sauce {
    
}

class ChicoCheese: Cheese {
    
}

class ChicoVeggie: Veggie {
    
}

class ChicoPepperoni: Pepperoni {
    
}

class ChicoClam: Clam {
    
}

// 1. Step 接口中先定义需要制造原料的接口,需要生产的是一些类的类
protocol PizzaIngredientFactory {
    func createDough() -> Dough
    func createSauce() -> Sauce
    func createCheese() -> Cheese
    func createVeggies() -> [Veggie]
    func createPepperoni() -> Pepperoni
    func createClam() -> Clam
}

// 2. 先建一座工厂来实现这些方法
class NYPizzaIngredientFactory: PizzaIngredientFactory {
    func createDough() -> Dough {
        NYDough()
    }
    
    func createSauce() -> Sauce {
        NYSauce()
    }
    
    func createCheese() -> Cheese {
        NYCheese()
    }
    
    func createVeggies() -> [Veggie] {
        [NYVeggie(), NYVeggie(), NYVeggie()]
    }
    
    func createPepperoni() -> Pepperoni {
        NYPepperoni()
    }
    
    func createClam() -> Clam {
        NYClam()
    }
}

class ChicoPizzaIngredientFactory: PizzaIngredientFactory {
    func createDough() -> Dough {
        ChicoDough()
    }
    
    func createSauce() -> Sauce {
        ChicoSauce()
    }
    
    func createCheese() -> Cheese {
        ChicoCheese()
    }
    
    func createVeggies() -> [Veggie] {
        [ChicoVeggie(), ChicoVeggie(), ChicoVeggie()]
    }
    
    func createPepperoni() -> Pepperoni {
        ChicoPepperoni()
    }
    
    func createClam() -> Clam {
        ChicoClam()
    }
}



// 3. 定义新的Pizza需要很多原材料
class BasePizza {
    var _name = ""
    var name: String {
        set {
            _name = newValue
        }
        get {
            if _name.isEmpty {
                return String(describing: type(of: self))
            } else {
                return _name
            }
        }
    }
    
    var dough = Dough()
    var sauce = Sauce()
    var veggies = [Veggie]()
    var cheese = Cheese()
    var pepperoni = Pepperoni()
    var clam = Clam()
    
    func prepare() {
        fatalError("子类必须实现这个方法，不要调用基类的这个方法！！！")
    }
    
    func bake() {
        print("\(name) \(#function) \(#line)")
    }
    
    func cut() {
        print("\(name) \(#function) \(#line)")
    }
    
    func box() {
        print("\(name) \(#function) \(#line)")
    }
}

// 3.1 开始定义各种特殊Pizza --- 奶酪 Pizza 但是可以来自 不同场地的原材料
class CheesePizza: BasePizza {
    var factory: PizzaIngredientFactory
    init(factory: PizzaIngredientFactory) {
        self.factory = factory
    }
    
    override func prepare() {
        // 特异化的魔法在这里
        dough = factory.createDough()
        sauce = factory.createSauce()
        veggies = factory.createVeggies()
        cheese = factory.createCheese()
        pepperoni = factory.createPepperoni()
        clam = factory.createClam()
    }
}

class VeggiePizza: BasePizza {
    var factory: PizzaIngredientFactory
    init(factory: PizzaIngredientFactory) {
        self.factory = factory
    }
    
    override func prepare() {
        // 特异化的魔法在这里
        dough = factory.createDough()
        sauce = factory.createSauce()
        veggies = factory.createVeggies()
        cheese = factory.createCheese()
        pepperoni = factory.createPepperoni()
        clam = factory.createClam()
    }
}

class ClamPizza: BasePizza {
    var factory: PizzaIngredientFactory
    init(factory: PizzaIngredientFactory) {
        self.factory = factory
    }
    
    override func prepare() {
        // 特异化的魔法在这里
        dough = factory.createDough()
        sauce = factory.createSauce()
        veggies = factory.createVeggies()
        cheese = factory.createCheese()
        pepperoni = factory.createPepperoni()
        clam = factory.createClam()
    }
}






class BasePizzaStore1 {
    func createPizza(type: String) -> BasePizza {
        fatalError("子类必须实现这个方法，我是个抽象类不能调用")
    }
    
    // 这个类需要流程管控，不允许子类进行重载
    // ⼯ ⼚ ⽅ 法 处 理 对 象 的 创 建 ， 并 将 对 象 创 建 封 装 在 ⼦ 类 中 ， 使 得
    // 超 类 中 的 客 户 代 码 从 ⼦ 类 的 对 象 创 建 代 码 解 耦
    @discardableResult final  func orderPizza(type: String) -> BasePizza {
        let pizza = createPizza(type: type)
        
        pizza.prepare()
        pizza.bake()
        pizza.cut()
        pizza.box()
        return pizza
    }
}

class NYPizzaStore1: BasePizzaStore1 {
    var factory: PizzaIngredientFactory = NYPizzaIngredientFactory()
    
    override func createPizza(type: String) -> BasePizza {
        var pizza = BasePizza()
        if type == "Cheese" {
            pizza = CheesePizza(factory: factory)
            pizza.name = "NY Cheese Pizza"
        } else if type == "Clam" {
            pizza = ClamPizza(factory: factory)
            pizza.name = "NY ClamPizza"
        } else if type == "Veggie" {
            pizza = VeggiePizza(factory: factory)
            pizza.name = "NY VeggiePizza"
        }
        return pizza
    }
}

class ChicoPizzaStore1: BasePizzaStore1 {
    var factory: PizzaIngredientFactory = ChicoPizzaIngredientFactory()
    
    override func createPizza(type: String) -> BasePizza {
        var pizza = BasePizza()
        if type == "Cheese" {
            pizza = CheesePizza(factory: factory)
            pizza.name = "Chico Cheese Pizza"
        } else if type == "Clam" {
            pizza = ClamPizza(factory: factory)
            pizza.name = "Chico ClamPizza"
        } else if type == "Veggie" {
            pizza = VeggiePizza(factory: factory)
            pizza.name = "Chico VeggiePizza"
        }
        return pizza
    }
}

/**
 抽象工厂模式提供一个接口来创建相关或依赖
 对象的家族，而不需要指定具体类。
 
 工厂方法是不是潜伏在抽象工厂里面？
 */
