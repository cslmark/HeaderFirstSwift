//
//  Reactive.swift
//  F1-RxSwiftExtension
//
//  Created by Smart on 2025/8/2.
//

/**
 这个 Reactive 结构体其实就是一个包装器（Wrapper），它把“普通对象”（
 比如 UIButton、UITextField、UIView）包装起来，扩展了一个叫 rx 的命名空间。
 */
import UIKit


// 🔹 1）面向协议编程（Protocol-Oriented Programming）
// RxSwift 中核心的 ReactiveCompatible 协议定义了扩展能力
// 👉 只要某个类（如 UIButton、UITextField）实现了 ReactiveCompatible，就会获得 .rx 的访问能力。
protocol ReactiveCompatible {
    associatedtype CompatibleType
    static var rx: Reactive<CompatibleType>.Type { get }
    var rx: Reactive<CompatibleType> { get }
}

extension ReactiveCompatible {
    static var rx: Reactive<CompatibleType>.Type {
        Reactive<CompatibleType>.self
    }
    
    var rx: Reactive<CompatibleType> {
        Reactive(base: self as! Self.CompatibleType)
    }
}

/** 🔹 2）Reactive 是一个命名空间包装器（类似装饰器）
 这其实是个泛型包装器，主要作用是：
 提供 .rx 扩展命名空间
 不会污染原有类型的命名空间
 可以根据 Base 类型来做具体扩展（通过 where 子句）
 */
struct Reactive<Base> {
    let base: Base
    init(base: Base) {
        self.base = base
    }
}
 
/**
 ✅ 2. 什么是 ControlEvent 和 ControlProperty？
 这两个是 RxCocoa 特有的 UI 事件包装类型，它们分别用于不同目的：
 🔹 ControlEvent<T>：只读事件流
 适用于按钮点击、滑动事件等，只发出事件、不持有状态：
 
 a.是 Observable<T> 的子集

 b.封装 UIControl 的 target-action

 c.事件是“冷”的，只有订阅才会触发
 
 🔹 ControlProperty<T>：可读写绑定属性（如 TextField 的 text）
 适用于可双向绑定的控件属性：
 a.是双向绑定的桥梁

 b.内部同时持有 Observable<T> 和 Observer<T>

 c.可以 bind(to:)、也可以被 binded
 */
struct ControlEvent<Element>: ObservableTypeNew {
    private let source: ObservableNew<Element>
    
    init(source: ObservableNew<Element>) {
        self.source = source
    }
    
    func subscribe<O>(_ observer: O) -> any DisposableNew where O : ObserverTypeNew, Element == O.Element {
        return source.subscribe(observer)
    }
    
    func asObservable() -> ObservableNew<Element> {
        return source
    }
}


struct ControlProperty<Value>: ObserverTypeNew, ObservableTypeNew {
    typealias Element = Value
    
    private let _values: ObservableNew<Value>
    private let _observer: AnyObserverNew<Value>
    
    init(_values: ObservableNew<Value>, _observer: AnyObserverNew<Value>) {
        self._values = _values
        self._observer = _observer
    }
    
    func subscribe<O>(_ observer: O) -> any DisposableNew where O : ObserverTypeNew, Value == O.Element {
        return _values.subscribe(observer)
    }
    
    func on(_ event: EventNew<Value>) {
        _observer.on(event)
    }
    
    func asObservable() -> ObservableNew<Value> {
        return _values
    }
}


