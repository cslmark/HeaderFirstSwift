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
   static func simulateAdapter() {
        let mallardDuck = MallardDuck()
        let redheadDuck = RedHeadDuck()
        let duckcall = DuckCall()
        let rebberDuck = RubberDucker()
        let goose = Goose()
        let gooseDuck = GooseAdater(goose: goose)
        
        print(" ========= Duck Simulator =========")
        simulate(mallardDuck)
        simulate(redheadDuck)
        simulate(duckcall)
        simulate(rebberDuck)
        simulate(gooseDuck)
    }
    
    static func simulate(_ duck: Quackable) {
        duck.quack()
    }
    
    static func simulateNew(_ duck: QuackableNew) {
        duck.quack()
    }
    
    static func simulateCount() {
        let mallardDuck = MallardDuck()
        let redheadDuck = RedHeadDuck()
        let duckcall = DuckCall()
        let rebberDuck = RubberDucker()
        let goose = Goose()
        let gooseDuck = GooseAdater(goose: goose)
        
        let mallardCounter = DuckerCounter(duck: mallardDuck)
        let redheadCounter = DuckerCounter(duck: redheadDuck)
        let duckCallCounter = DuckerCounter(duck: duckcall)
        let rebberCounter = DuckerCounter(duck: rebberDuck)
        let gooseCounter = DuckerCounter(duck: gooseDuck)
        
        print(" ========= Duck Simulator =========")
        simulate(mallardCounter)
        simulate(redheadCounter)
        simulate(duckCallCounter)
        simulate(rebberCounter)
        simulate(gooseCounter)
        
        print("一共叫了: \(DuckerCounter.totalCount)")
    }
    
    static func simulateFactory(factory: AbstractDuckFactory) {
        let mallardDuck = factory.createMallardDuck()
        let redheadDuck = factory.createRedHeadDuck()
        let duckcall = factory.createDuckCall()
        let rebberDuck = factory.createRubberDuck()
        let gooseDuck = factory.createRedHeadDuck()
        
        print(" ========= Duck Simulator =========")
        simulate(mallardDuck)
        simulate(redheadDuck)
        simulate(duckcall)
        simulate(rebberDuck)
        simulate(gooseDuck)
        
        print("一共叫了: \(DuckerCounter.totalCount)")
    }
    
    static func simulateFactoryWithCompose(factory: AbstractDuckFactory) {
        let redheadDuck = factory.createRedHeadDuck()
        let duckcall = factory.createDuckCall()
        let rebberDuck = factory.createRubberDuck()
        let gooseDuck = factory.createRedHeadDuck()
        
        let flock = Flock()
        flock.add(redheadDuck)
        flock.add(duckcall)
        flock.add(rebberDuck)
        flock.add(gooseDuck)
        
        let mallardFlock = Flock()
        let mallardDuck1 = factory.createMallardDuck()
        let mallardDuck2 = factory.createMallardDuck()
        let mallardDuck3 = factory.createMallardDuck()
        let mallardDuck4 = factory.createMallardDuck()
        let mallardDuck5 = factory.createMallardDuck()
        
        mallardFlock.add(mallardDuck1)
        mallardFlock.add(mallardDuck2)
        mallardFlock.add(mallardDuck3)
        mallardFlock.add(mallardDuck4)
        mallardFlock.add(mallardDuck5)
       
        
        print(" ========= Duck Simulator =========")
        simulate(flock)
        simulate(mallardFlock)
        
        print("一共叫了: \(DuckerCounter.totalCount)")
    }
    
    
    static func simulateFactoryWithObserver(factory: AbstractDuckFactoryNew) {
        let redheadDuck = factory.createRedHeadDuck()
        let duckcall = factory.createDuckCall()
        let rebberDuck = factory.createRubberDuck()
        let gooseDuck = factory.createRedHeadDuck()
        
        let flock = FlockNew()
        flock.add(redheadDuck)
        flock.add(duckcall)
        flock.add(rebberDuck)
        flock.add(gooseDuck)
        
        let quackologist = Quackologist()
        flock.registerObserver(quackologist)
        
        print(" ========= Duck Simulator =========")
        simulateNew(flock)
        print("一共叫了: \(DuckerCounter.totalCount)")
    }

}

print("========== 适配者模式 ===== ")
DuckSimulator.simulateAdapter()

print("========== 装饰者模式 ===== ")
DuckSimulator.simulateCount()

print("========== 抽象工厂模式 ===== ")
DuckSimulator.simulateFactory(factory: CountingDuckFactory())

print("========== 组合模式 ===== ")
DuckSimulator.simulateFactoryWithCompose(factory: CountingDuckFactory())

print("========== 观察者模式 ===== ")
DuckSimulator.simulateFactoryWithObserver(factory: CountingDuckFactoryNew())
