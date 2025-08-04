//
//  SimpleFactory.swift
//  4-FactoryPattern
//
//  Created by 青枫(陈双林) on 2025/8/4.
//

/**
 简 单 ⼯ ⼚ 其 实 不 是 ⼀ 个 设 计 模 式 ， 更 多 是 ⼀ 种 编 程 习 惯
 */
class SimplePizzaFactory {
    func createPizza(type: String) -> Pizza {
        var pizza = Pizza()
        if type == "Chinses" {
            pizza = ChinesePizza()
        } else if type == "Greek" {
            pizza = GreekPizza()
        } else if type == "Greek" {
            pizza = PepperPizza()
        }
        return pizza
    }
}

// 也可以拓展出不同的工厂，来创建更多类型的Pizza,给Pizza店
// 致命缺陷在于，后面其他家的Pizza需要自定义自己的Pizza制作过程，不同的pizza有些差异
// 这个Factory不符合开闭原则
class Simple1PizzaFactory: SimplePizzaFactory {
    override func createPizza(type: String) -> Pizza {
        var pizza = Pizza()
        if type == "Chinses" {
            pizza = ChinesePizza()
        } else if type == "Greek" {
            pizza = GreekPizza()
        } else if type == "Greek" {
            pizza = PepperPizza()
        }
        return pizza
    }
}

class Simple2PizzaFactory: SimplePizzaFactory {
    override func createPizza(type: String) -> Pizza {
        var pizza = Pizza()
        if type == "Chinses" {
            pizza = ChinesePizza()
        } else if type == "Greek" {
            pizza = GreekPizza()
        } else if type == "Greek" {
            pizza = PepperPizza()
        }
        return pizza
    }
}


class SimpleFactoryPizzaStore {
    var simpleFactory: SimplePizzaFactory
    
    init(simpleFactory: SimplePizzaFactory) {
        self.simpleFactory = simpleFactory
    }
    
    @discardableResult func orderPizza(type: String) -> Pizza {
        
        // 把会改变的代码用一个对象来生成做下代码隔离
        let pizza = simpleFactory.createPizza(type: type)
        
        pizza.prepare()
        pizza.bake()
        pizza.cut()
        pizza.box()
        return pizza
    }
}
