//
//  main.swift
//  3_DecoratorPattern
//
//  Created by 青枫(陈双林) on 2025/7/31.
//

import Foundation

/**装饰者模式
 基础概念: 给对象动态附加额外的责任。对于拓展功能，除了去子类化之外，装饰者提供弹性的替代方案
 **/

/**装饰者模式来解决这个问题**/
let beverage = HouseBlend()
print(beverage.debugDesc)

var beverage2: BeverageComponent = Espresso()
print(beverage2.debugDesc)
beverage2 = MoCha(beverage: beverage2)
print(beverage2.debugDesc)
beverage2 = Whip(beverage: beverage2)
print(beverage2.debugDesc)

/**
 如果你仔细观察会发现，整体装饰者模式结构很适合函数式编程的方式来搞定
 本质上最终的调用方式这样的:
 eg: var beverage2: BeverageComponent = Whip(beverage: MoCha(beverage: Espresso()))
 */
let fpBeverage = FPEspresso()
    .withMocha()
    .withSoy()
print(fpBeverage.debugDesc)

/** 重载运算符之后，优化的调用 */
let fpBeverage2 = FPEspresso() + FPCondiment.mocha + FPCondiment.whip
print(fpBeverage2.debugDesc)


