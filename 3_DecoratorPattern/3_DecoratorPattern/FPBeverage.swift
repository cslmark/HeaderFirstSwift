//
//  FPBeverage.swift
//  3_DecoratorPattern
//
//  Created by 青枫(陈双林) on 2025/7/31.
//

protocol FPBeverageComponent {
    var desc: String { get }
    func cost() -> Double
}

extension FPBeverageComponent {
    func with(condimentName: String, cost: Double) -> FPBeverageComponent {
        return FPCondimentDecorator(beverage: self, condimentName: condimentName, condimentCost: cost)
    }
    
    func withMocha() -> FPBeverageComponent {
        return with(condimentName: "摩卡 ", cost: 0.20)
    }
    
    func withSoy() -> FPBeverageComponent {
        return with(condimentName: "豆浆 ", cost: 0.20)
    }
    
    func withWhip() -> FPBeverageComponent {
        return with(condimentName: "奶泡 ", cost: 0.20)
    }
    
    var debugDesc: String {
        "\(desc) 售价:\(cost())"
    }
}

struct FPEspresso: FPBeverageComponent {
    var desc: String {
        "FP浓缩咖啡"
    }
    
    func cost() -> Double {
        1.99
    }
}

struct FPCondimentDecorator: FPBeverageComponent {
    let beverage: FPBeverageComponent
    let condimentName: String
    let condimentCost: Double
    
    var desc: String {
        return "\(condimentName) " + beverage.desc
    }
    
    func cost() -> Double {
        return condimentCost + beverage.cost()
    }
}

/**
 为了直观的重载运算符引入
 */
enum FPCondiment {
    case mocha
    case soy
    case whip
    case custom(name: String, cost: Double)
    
    var name: String {
        switch self {
        case .mocha: return "摩卡 "
        case .soy: return "豆浆 "
        case .whip: return "奶泡 "
        case .custom(let name, _): return name + " "
        }
    }
    
    var cost: Double {
        switch self {
        case .mocha: return 0.20
        case .soy: return 0.8
        case .whip: return 1.8
        case .custom(name: _, cost: let cost): return cost
        }
    }
}

// 重载 + 号运算符
// 在类型内部定义,一定要加Static
func +(beverage: FPBeverageComponent, condiment: FPCondiment) -> FPBeverageComponent {
    return FPCondimentDecorator(beverage: beverage, condimentName: condiment.name, condimentCost: condiment.cost)
}

