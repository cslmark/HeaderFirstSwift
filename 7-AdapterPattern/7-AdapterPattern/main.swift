//
//  main.swift
//  7-AdapterPattern
//
//  Created by 青枫(陈双林) on 2025/8/12.
//


/**
 适配器模式将一个类的接口转换成客户期望的另一个
 接口。适配器让原本接口不兼容的类可以合作。
 */
import Foundation

protocol Duck {
    func quack()
    func fly()
}

class MallardDuck: Duck {
    func quack() {
        print("Quack")
    }
    
    func fly() {
        print("I'm flying")
    }
}

protocol Turkey {
    func gobble()
    func fly()
}

class WildTurkey: Turkey {
    func gobble() {
        print("Gobble")
    }
    
    func fly() {
        print("我只能短距离飞翔")
    }
}

class TurkeyAdpter: Duck {
    let turkey: Turkey
    
    init(turkey: Turkey) {
        self.turkey = turkey
    }
    
    func quack() {
        turkey.gobble()
    }
    
    func fly() {
        turkey.fly()
    }
}

let turkey = WildTurkey()
let turkeyAdapter = TurkeyAdpter(turkey: turkey)

turkey.gobble()
turkey.fly()

let duck = MallardDuck()
duck.quack()
duck.fly()

turkeyAdapter.quack()
turkeyAdapter.fly()




