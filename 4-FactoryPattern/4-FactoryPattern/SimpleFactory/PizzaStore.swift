//
//  Pizza.swift
//  4-FactoryPattern
//
//  Created by 青枫(陈双林) on 2025/8/4.
//


class Pizza {
    var name: String {
        let className = String(describing: type(of: self))
        return className
    }
    
    func prepare() {
        print("\(name) \(#function) \(#line)")
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

class ChinesePizza: Pizza {
}

class GreekPizza: Pizza {
}

class PepperPizza: Pizza {
}


class PizzaStore0 {
    @discardableResult func orderPizza(type: String) -> Pizza {
        var pizza = Pizza()
        if type == "Chinses" {
            pizza = ChinesePizza()
        } else if type == "Greek" {
            pizza = GreekPizza()
        } else if type == "Greek" {
            pizza = PepperPizza()
        }
        
        pizza.prepare()
        pizza.bake()
        pizza.cut()
        pizza.box()
        return pizza
    }
}
