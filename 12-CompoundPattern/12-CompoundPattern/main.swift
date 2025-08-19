//
//  main.swift
//  12-CompoundPattern
//
//  Created by Smart on 2025/8/19.
//


/**
 模式通常被一起使用，并结合在同一设计的解决方案中
 
 复合模式在一个解决方案总结合两个或者多个模式，以解决一般的活重复发生的问题
 */
import Foundation

class DuckSimulator {
    static func main() {
        let simulator = DuckSimulator()
        simulator.simulate()
    }
    
    func simulate() {
        let mallardDuck = MallardDuck()
        let redheadDuck = RedHeadDuck()
        let duckcall = DuckCall()
        let rebberDuck = RubberDucker()
        
        print(" ========= Duck Simulator =========")
        simulate(mallardDuck)
        simulate(redheadDuck)
        simulate(duckcall)
        simulate(rebberDuck)
    }
    
    func simulate(_ duck: Quackable) {
        duck.quack()
    }
}

DuckSimulator.main()
