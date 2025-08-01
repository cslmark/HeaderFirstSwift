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
