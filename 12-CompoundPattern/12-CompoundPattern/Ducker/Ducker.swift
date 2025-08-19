//
//  Ducker.swift
//  12-CompoundPattern
//
//  Created by Smart on 2025/8/19.
//

protocol Quackable {
    func quack()
}

class MallardDuck: Quackable {
    func quack() {
        let className = String(describing: type(of: self))
        print(className, " Quick!!!")
    }
}

class RedHeadDuck: Quackable {
    func quack() {
        let className = String(describing: type(of: self))
        print(className, " Quick!!!")
    }
}

class DuckCall: Quackable {
    func quack() {
        let className = String(describing: type(of: self))
        print(className, " Quick!!!")
    }
}

class RubberDucker: Quackable {
    func quack() {
        let className = String(describing: type(of: self))
        print(className, " Quick!!!")
    }
}

class Goose {
    func honk() {
        let className = String(describing: type(of: self))
        print(className, " Honk!!!")
    }
}

// MARK: - 适配者模式
class GooseAdater: Quackable {
    var goose:Goose
    
    init(goose: Goose) {
        self.goose = goose
    }
    
    func quack() {
        self.goose.honk()
    }
}

// MARK: - 装饰者模式
/// 再不改变类的情况，需要知道一共叫了几声
class DuckerCounter: Quackable {
    static var totalCount = 0
    var duck: Quackable
    init(duck: Quackable) {
        self.duck = duck
    }
    
    func quack() {
        self.duck.quack()
        Self.totalCount += 1
    }
}


// MARK: - 抽象工厂模式
protocol AbstractDuckFactory {
    func createMallardDuck() -> Quackable
    func createRedHeadDuck() -> Quackable
    func createDuckCall() -> Quackable
    func createRubberDuck() -> Quackable
    func createGooseDuck() -> Quackable
}

//class AbstractDuckFactory {
//    func createMallardDuck() -> Quackable {
//        fatalError("子类必须实现 \(#function)")
//    }
//    
//    func createRedHeadDuck() -> Quackable {
//        fatalError("子类必须实现 \(#function)")
//    }
//    
//    func createDuckCall() -> Quackable {
//        fatalError("子类必须实现 \(#function)")
//    }
//    
//    func createRubberDuck() -> Quackable {
//        fatalError("子类必须实现 \(#function)")
//    }
//    
//    func createGooseDuck() -> Quackable {
//        fatalError("子类必须实现 \(#function)")
//    }
//}

class DuckFactory: AbstractDuckFactory {
    func createMallardDuck() -> Quackable {
        MallardDuck()
    }
    
    func createRedHeadDuck() -> Quackable {
        RedHeadDuck()
    }
    
    func createDuckCall() -> Quackable {
        DuckCall()
    }
    
    func createRubberDuck() -> Quackable {
        RubberDucker()
    }
    
    func createGooseDuck() -> Quackable {
        GooseAdater(goose: Goose())
    }
}

class CountingDuckFactory: AbstractDuckFactory {
    func createMallardDuck() -> Quackable {
        DuckerCounter(duck: MallardDuck())
    }
    
    func createRedHeadDuck() -> Quackable {
        DuckerCounter(duck: RedHeadDuck())
    }
    
    func createDuckCall() -> Quackable {
        DuckerCounter(duck: DuckCall())
    }
    
    func createRubberDuck() -> Quackable {
        DuckerCounter(duck: RubberDucker())
    }
    
    func createGooseDuck() -> Quackable {
        DuckerCounter(duck: GooseAdater(goose: Goose()))
    }
}


// MARK: - 组合模式
class Flock: Quackable {
    var quackers = [Quackable]()
    
    func add(_ quacker: Quackable) {
        quackers.append(quacker)
    }
    
    func quack() {
        var iterator = quackers.makeIterator()
        while let ele = iterator.next() {
            ele.quack()
        }
    }
}

// MARK: - 观察者模式
protocol Observer {
    func update(_ duck: QuackObservable)
}

protocol QuackObservable {
    func registerObserver(_ observer: Observer)
    func notifyObservers()
}

// 开始让 Quackable 开始继承
protocol QuackableNew: QuackObservable {
    func quack()
}

class Observable: QuackObservable {
    var observers = [Observer]()
    let duck: QuackObservable
    
    init(observers: [any Observer] = [Observer](), duck: QuackObservable) {
        self.observers = observers
        self.duck = duck
    }
    
    func registerObserver(_ observer: any Observer) {
        observers.append(observer)
    }
    
    func notifyObservers() {
        observers.forEach { observer in
            observer.update(duck)
        }
    }
}

class MallardDuckNew: QuackableNew {
    lazy var observable: Observable = {
        Observable(duck: self)
    }()
    
    func quack() {
        let className = String(describing: type(of: self))
        print(className, " Quick!!!")
        notifyObservers()
    }
    
    func registerObserver(_ observer: any Observer) {
        observable.registerObserver(observer)
    }
    
    func notifyObservers() {
        observable.notifyObservers()
    }
}

class RedHeadDuckNew: QuackableNew {
    lazy var observable: Observable = {
        Observable(duck: self)
    }()
    
    func quack() {
        let className = String(describing: type(of: self))
        print(className, " Quick!!!")
        notifyObservers()
    }
    
    func registerObserver(_ observer: any Observer) {
        observable.registerObserver(observer)
    }
    
    func notifyObservers() {
        observable.notifyObservers()
    }
}

class DuckCallNew: QuackableNew {
    lazy var observable: Observable = {
        Observable(duck: self)
    }()
    
    func quack() {
        let className = String(describing: type(of: self))
        print(className, " Quick!!!")
        notifyObservers()
    }
    
    func registerObserver(_ observer: any Observer) {
        observable.registerObserver(observer)
    }
    
    func notifyObservers() {
        observable.notifyObservers()
    }
}

class RubberDuckerNew: QuackableNew {
    lazy var observable: Observable = {
        Observable(duck: self)
    }()
    
    func quack() {
        let className = String(describing: type(of: self))
        print(className, " Quick!!!")
        notifyObservers()
    }
    
    func registerObserver(_ observer: any Observer) {
        observable.registerObserver(observer)
    }
    
    func notifyObservers() {
        observable.notifyObservers()
    }
}

class GooseAdaterNew: QuackableNew {
    var goose:Goose
    
    lazy var observable: Observable = {
        Observable(duck: self)
    }()
    
    func registerObserver(_ observer: any Observer) {
        observable.registerObserver(observer)
    }
    
    func notifyObservers() {
        observable.notifyObservers()
    }
    
    init(goose: Goose) {
        self.goose = goose
    }
    
    func quack() {
        self.goose.honk()
    }
}

class Quackologist: Observer {
    func update(_ duck: any QuackObservable) {
        let className = String(describing: type(of: self))
        let duckName = String(describing: type(of: duck))
        print(className, " 发现", duckName, " 叫了")
    }
}

// 采用装饰者模式，可以突破所有的类添加行为
class DuckerCounterNew: QuackableNew {
    static var totalCount = 0
    var duck: QuackableNew
    init(duck: QuackableNew) {
        self.duck = duck
    }
    
    func quack() {
        self.duck.quack()
        Self.totalCount += 1
    }
        
    func registerObserver(_ observer: any Observer) {
        self.duck.registerObserver(observer)
    }
    
    func notifyObservers() {
        self.duck.notifyObservers()
    }
}

// MARK: - 组合模式
class FlockNew: QuackableNew {
    var quackers = [QuackableNew]()
    
    func add(_ quacker: QuackableNew) {
        quackers.append(quacker)
    }
    
    func quack() {
        var iterator = quackers.makeIterator()
        while let ele = iterator.next() {
            ele.quack()
        }
    }

    func registerObserver(_ observer: any Observer) {
        quackers.forEach { duck in
            duck.registerObserver(observer)
        }
    }
    
    func notifyObservers() {
        // Do Nothing
    }
}

protocol AbstractDuckFactoryNew {
    func createMallardDuck() -> QuackableNew
    func createRedHeadDuck() -> QuackableNew
    func createDuckCall() -> QuackableNew
    func createRubberDuck() -> QuackableNew
    func createGooseDuck() -> QuackableNew
}


class CountingDuckFactoryNew: AbstractDuckFactoryNew {
    func createMallardDuck() -> QuackableNew {
        DuckerCounterNew(duck: MallardDuckNew())
    }
    
    func createRedHeadDuck() -> QuackableNew {
        DuckerCounterNew(duck: RedHeadDuckNew())
    }
    
    func createDuckCall() -> QuackableNew {
        DuckerCounterNew(duck: DuckCallNew())
    }
    
    func createRubberDuck() -> QuackableNew {
        DuckerCounterNew(duck: RubberDuckerNew())
    }
    
    func createGooseDuck() -> QuackableNew {
        DuckerCounterNew(duck: GooseAdaterNew(goose: Goose()))
    }
}








