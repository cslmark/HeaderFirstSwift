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
