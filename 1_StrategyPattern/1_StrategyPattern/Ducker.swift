//
//  Ducker.swift
//  1_StrategyPattern
//
//  Created by 青枫(陈双林) on 2025/7/31.
//

class Ducker {
    var flyer: FlyBehavior?
    var quarker: QuarkBehavior?
    
    var name: String {
        return "鸭子"
    }
    func display() {
        print("我是一只", name)
    }
    
    func swimming() {
        print("I Can Swimming")
    }
}

class WildDucker: Ducker {
    override var name: String {
        return "野鸭子"
    }
}


class RubberDucker: Ducker {
    override var name: String {
        return "橡皮鸭"
    }
}


