//
//  main.swift
//  3_DecoratorPattern
//
//  Created by 青枫(陈双林) on 2025/7/31.
//

import Foundation

/**装饰者模式
 
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



