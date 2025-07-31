//
//  B.swift
//  3_DecoratorPattern
//
//  Created by 青枫(陈双林) on 2025/7/31.
//

/*
 定义饮料的接口<书本采用的时候抽象类的原因，是因为星巴克本身已经有了抽象类，不想改变
 1. 可以采用接口来定义更适合
 2. 书本的类名是饮料，个人认为应该叫饮料组件更适合
 */
protocol BeverageComponent {
    var desc: String { get }
    func cost() -> Double
}

extension BeverageComponent {
    var debugDesc: String {
        "\(desc) 售价:\(cost())"
    }
}

protocol CondimentDecorator: BeverageComponent {
    var beverage: BeverageComponent { get set }
}

/**
 基础饮料成分实现类
 */
class Espresso: BeverageComponent {
    var desc: String {
        "浓缩咖啡"
    }
    
    func cost() -> Double {
        1.99
    }
}

class HouseBlend: BeverageComponent {
    var desc: String {
        "家常综合"
    }
    
    func cost() -> Double {
        0.89
    }
}

class Orange: BeverageComponent {
    var desc: String {
        "橙汁"
    }
    
    func cost() -> Double {
        1.89
    }
}


/**调料**/
// 创建抽象基类来消除重复的init代码
class BaseCondimentDecorator: CondimentDecorator {
    var beverage: BeverageComponent
    
    init(beverage: BeverageComponent) {
        self.beverage = beverage
    }
    
    // 子类必须重写这些方法
    var desc: String {
        fatalError("desc must be overridden by subclass")
    }
    
    func cost() -> Double {
        fatalError("cost() must be overridden by subclass")
    }
}

class MoCha: BaseCondimentDecorator {
    override var desc: String {
        return "摩卡 " + beverage.desc
    }
    
    override func cost() -> Double {
        return beverage.cost() + 0.20
    }
}

class Soy: BaseCondimentDecorator {
    override var desc: String {
        return "豆浆 " + beverage.desc
    }
    
    override func cost() -> Double {
        return beverage.cost() + 0.15
    }
}

class Whip: BaseCondimentDecorator {
    override var desc: String {
        return "奶泡 " + beverage.desc
    }
    
    override func cost() -> Double {
        return beverage.cost() + 0.10
    }
}





