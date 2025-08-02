//
//  RxSwift.swift
//  2-ObserverPattern
//
//  Created by Smart on 2025/8/1.
//

////////////////////////// Setup 1 ///////////////////////////////////
// 1. 泛型定义，抹除类型差异
enum Event<Element> {
    case next(Element)
    case completed
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

////////////////////////// Setup 2 ///////////////////////////////////
protocol Disposable {
    func dispose()
}

struct NoDisposable: Disposable {
    func dispose() {
        // 空
    }
}

// 在 RxSwift 中，Observable.create 用于创建一个自定义的 Observable，这个 Observable 可以发出多个事件并完成它们的生命周期。它会接受一个闭包，闭包内通过 observer 发出事件。
// 1. 定义Observable 类型
// 定义一个通用的ObservableType类，并且返回一个Disposable来管理资源释放
class Observable<Element>: ObservableType {
    private let subscirbeAction: (AnyObserver<Element>) -> Disposable
    
    init(subscirbeAction: @escaping (AnyObserver<Element>) -> Disposable) {
        self.subscirbeAction = subscirbeAction
    }
    
    func subscribe(_ observer: AnyObserver<Element>) {
        _ = subscirbeAction(observer)
    }
}

// 2. 实现Observable.create
extension Observable {
    static func create(_ subscirbeAction: @escaping (AnyObserver<Element>) -> Disposable) -> Observable<Element> {
        return Observable(subscirbeAction: subscirbeAction)
    }
}

////////////////////////// Setup 3 ///////////////////////////////////
/**
 构造「可释放的订阅机制」
 */

class AnonymousDisposable: Disposable {
    private var disposeAction: (()->Void)?
    private var isDisposed = false
    
    init(_ disposeAction: @escaping ()-> Void) {
        self.disposeAction = disposeAction
    }
    
    func dispose() {
        guard !isDisposed else {
            return
        }
        isDisposed = true
        disposeAction?()
        disposeAction = nil
    }
}

/// 协议也可以加便捷的初始化函数<但是外部无法访问？？？？ 加public也没有用>
extension Disposable {
    public static func create() -> Disposable {
        return NoDisposable()
    }
    
    public static func create(_ disposeAction: @escaping ()-> Void) -> Disposable {
        return AnonymousDisposable(disposeAction)
    }
}

// 所以这里用结构体的类型方法类替代
struct Disposables {
    static func create() -> Disposable {
        return NoDisposable()
    }
    
    static func create(_ disposeAction: @escaping ()-> Void) -> Disposable {
        return AnonymousDisposable(disposeAction)
    }
}

protocol ObservableType3 {
    associatedtype Element
    func subscribe(_ observer: AnyObserver<Element>) -> Disposable
}

class Observable3<Element>: ObservableType3 {
    private let subscirbeAction: (AnyObserver<Element>) -> Disposable
    
    init(subscirbeAction: @escaping (AnyObserver<Element>) -> Disposable) {
        self.subscirbeAction = subscirbeAction
    }
    
    func subscribe(_ observer: AnyObserver<Element>) -> Disposable {
        subscirbeAction(observer)
    }
}

// 2. 实现Observable.create
extension Observable3 {
    static func create(_ subscirbeAction: @escaping (AnyObserver<Element>) -> Disposable) -> Observable3<Element> {
        return Observable3(subscirbeAction: subscirbeAction)
    }
}

////////////////////////// Setup 4 ///////////////////////////////////
/**
 第四步：实现最基础的 Subject（类似 PublishSubject）
 在 RxSwift 中，Subject 是一种即是 Observable 又是 Observer 的对象，它可以：

 接收事件（作为 Observer）

 分发事件给多个订阅者（作为 Observable）

 我们实现一个最简单的 SimpleSubject<T>：
 */

