//
//  main.swift
//  8-TemplatePattern
//
//  Created by Smart on 2025/8/12.
//

import Foundation

/**
 模板方法模式在一个方法中定义一个算法的骨架，
 而把一些步骤延迟到子类。模板方法使得子类可以
 在不改变算法结构的情况下，重新定义算法中的某
 些步骤。
 */

class CaffeineBeverage {
    func prepareRecipe() {
        boildWater()
        brew()
        purInCup()
        addCondiments()
    }
    
    func boildWater() {
        print("烧水")
    }
    
    
    
    func brew() {
        fatalError("子类必须实现")
    }
    
    func purInCup() {
        print("倒进杯子")
    }
    
    func addCondiments() {
        fatalError("子类必须实现")
    }
}

class Coffee: CaffeineBeverage {
    override func brew() {
        print("泡咖啡")
    }
    
    override func addCondiments() {
        print("加入牛奶")
    }
}

class Tea: CaffeineBeverage {
    override func brew() {
        print("泡茶")
    }
    
    override func addCondiments() {
        print("加入柠檬")
    }
}


let tea = Tea()
tea.prepareRecipe()

let coffie = Coffee()
coffie.prepareRecipe()
