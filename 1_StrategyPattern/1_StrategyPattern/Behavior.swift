//
//  Behavi.swift
//  1_StrategyPattern
//
//  Created by 青枫(陈双林) on 2025/7/31.
//

/**
 1.面向接口编程而不是面向实现
 
 */
protocol FlyBehavior {
    func fly()
}

class FlyWithWings: FlyBehavior {
    func fly() {
        print("飞行速度 10km/h")
    }
}

class FlyNoWay: FlyBehavior {
    func fly() {
        // print("我不会飞")
    }
}


protocol QuarkBehavior {
    func quark()
}

class Quark: QuarkBehavior {
    func quark() {
        print("嘎嘎嘎")
    }
}

class Squark: QuarkBehavior {
    func quark() {
        print("叽叽叽")
    }
}

class MuteQuark: QuarkBehavior {
    func quark() {
        // print("我不会叫")
    }
}
