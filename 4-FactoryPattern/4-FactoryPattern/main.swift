//
//  main.swift
//  4-FactoryPattern
//
//  Created by Smart on 2025/8/1.
//

import Foundation

/**
 简单工厂
 */
print("============ 简单工厂 Start ================")
let pizzaStore0 = PizzaStore0()
pizzaStore0.orderPizza(type: "Chinese")
pizzaStore0.orderPizza(type: "Greek")
pizzaStore0.orderPizza(type: "Greek")
pizzaStore0.orderPizza(type: "xxx")


let simpleFactory = SimplePizzaFactory()
let simplePizzaStore = SimpleFactoryPizzaStore(simpleFactory: simpleFactory)
simplePizzaStore.orderPizza(type: "Greek")

print("============ 简单工厂 End ================")
