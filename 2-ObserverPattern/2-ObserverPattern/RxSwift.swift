//
//  RxSwift.swift
//  2-ObserverPattern
//
//  Created by Smart on 2025/8/1.
//

// 1. 泛型定义，抹除类型差异
enum Event<Element> {
    case next(Element)
}

// 2. 定义Observer协议
protocol ObserverType {
    associatedtype Element
    func on(_ event: Event<Element>)
}

// 2.1 写一个通用的“观察者包装器”，这样可以通过一个闭包直接生产一个订阅者
// 这个设计的方式非常巧妙:
// 1. 简化代码: 通过闭包包装，避免了为每种观察者类型都创建独立的类
// 2. 增加灵活性: 可以自由为每个观察者定义不同的事件处理逻辑，二不关心它的具体类型
// 3. 通用性和类型安全: 确保每个观察者都符合ObserverType协议，且只处理特定的类型的事件
// 背后世界的思路
// 1. 统一接口和协议，我们可以把不同类型的观察者都抽象成统一的类型，便于管理
// 2. 闭包作为事件的处理： 灵活，简洁，易于传递---可以作为参数传递，函数式编程
// 3. 资源释放: 轻量级的封装，方柏霓控制每个观察者的生命周期
class AnyObserver<Element>: ObserverType {
    private let onEvent: (Event<Element>) -> Void
    
    init(onEvent: @escaping (Event<Element>) -> Void) {
        self.onEvent = onEvent
    }
    
    // ObserverType
    func on(_ event: Event<Element>) {
        onEvent(event)
    }
}

// 3. 定义ObservableType协议（subject协议）
protocol ObservableType {
    associatedtype Element
    func subscribe(_ observer: AnyObserver<Element>)
}


// 4. 实现一个简单的Observable
class Just<Element>: ObservableType {
    private let value: Element
    
    init(_ value: Element) {
        self.value = value
    }
    
    func subscribe(_ observer: AnyObserver<Element>) {
        observer.on(.next(value))
    }
}


