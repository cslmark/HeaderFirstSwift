//
//  RxSwfit2.swift
//  2-ObserverPattern
//
//  Created by 青枫(陈双林) on 2025/8/2.
//

import Foundation

// 定义事件
enum EventNew<Element> {
    case next(value: Element)
    case completed
    case error
}

// 定义监听协议
protocol ObserverTypeNew {
    associatedtype Element
    func on(_ event: EventNew<Element>)
}

class AnyObserverNew<Element>: ObserverTypeNew {
    let id = UUID() // 添加唯一标识符
    var onAction: ((EventNew<Element>) -> Void)
    
    init(onAction: @escaping (EventNew<Element>) -> Void) {
        self.onAction = onAction
    }
    
    func on(_ event: EventNew<Element>) {
        onAction(event)
    }
}

extension AnyObserverNew {
    static func create(_ onAction:@escaping (EventNew<Element>) -> Void) -> AnyObserverNew<Element> {
        return AnyObserverNew(onAction: onAction)
    }
}

// 新增自动内存管理
protocol DisposableNew {
    func dispose()
}

extension DisposableNew {
    func disposed(by bg: DisposeBag) {
        bg.insert(self)
    }
}

struct NoDisposableNew: DisposableNew {
    func dispose() {
        // Do nothing
    }
}

class BlockDisposable: DisposableNew {
    private let disposeActin: () -> Void
    private var isDisposed = false
    
    init(disposeActin: @escaping () -> Void, isDisposed: Bool = false) {
        self.disposeActin = disposeActin
        self.isDisposed = isDisposed
    }
    
    func dispose() {
        guard !isDisposed else {
            return
        }
        isDisposed = true
        disposeActin()
    }
}

class DisposeBag {
    private var disposables: [DisposableNew] = []
    
    func insert(_ disposable: DisposableNew) {
        disposables.append(disposable)
    }
    
    deinit {
        disposables.forEach {
            $0.dispose()
        }
    }
}

struct DisposesNew {
    static func create() -> DisposableNew {
        return NoDisposableNew()
    }
    
    static func create(_ disposeActin: @escaping () -> Void) -> DisposableNew {
        return BlockDisposable(disposeActin: disposeActin, isDisposed: false)
    }
}

// 定义可被监听协议->主题
// 自动进行内存管理,当调用这个方法意味着订阅结束
protocol ObservableTypeNew {
    associatedtype Element
    func subscribe<O: ObserverTypeNew>(_ observer: O) -> DisposableNew where O.Element == Element
}

extension ObservableTypeNew {
    // 更加优雅的方式实现onNext
    func subscribe(onNext: @escaping (Element) -> Void,
                   onComplete: (()->Void)? = nil,
                   onError: (()->Void)? = nil) -> DisposableNew {
        let observer = AnyObserverNew<Element> { event in
            switch event {
            case .error:
                onError?()
            case .completed:
                onComplete?()
            case .next(let value):
                onNext(value)
            }
        }
        return self.subscribe(observer)
    }
}

// 创建subject
class ObservableNew<Element>: ObservableTypeNew {
    typealias Observer = AnyObserverNew<Element>
    var subscribeAction: (Observer) -> DisposableNew
    
    init(subscribeAction: @escaping (AnyObserverNew<Element>) -> DisposableNew) {
        self.subscribeAction = subscribeAction
    }
    
    // 修正方法签名，使其与协议匹配
    func subscribe<Observer: ObserverTypeNew>(_ observer: Observer) -> DisposableNew where Observer.Element == Element {
        // 这里需要将泛型 observer 转换为 AnyObserverNew
        let anyObserver = AnyObserverNew<Element> { event in
            observer.on(event)
        }
        return subscribeAction(anyObserver)
    }
}

extension ObservableNew {
    static func create(_ subscribeAction:@escaping  ((AnyObserverNew<Element>) -> DisposableNew)) -> ObservableNew<Element> {
        return ObservableNew(subscribeAction: subscribeAction)
    }
}

// 以上通知解决了1对1的问题，没有解决一对多的问题
/**
 第四步：实现最基础的 Subject（类似 PublishSubject）
 在 RxSwift 中，Subject 是一种即是 Observable 又是 Observer 的对象，它可以：

 接收事件（作为 Observer）

 分发事件给多个订阅者（作为 Observable）

 我们实现一个最简单的 SimpleSubject<T>：
 */
class SimpleSubject<Element>: ObservableTypeNew, ObserverTypeNew {
    typealias Observer = AnyObserverNew<Element>
    private var observers: [UUID: Observer] = [:] // 使用字典存储
    
    func subscribe<O>(_ observer: O) -> any DisposableNew where O : ObserverTypeNew, Element == O.Element {
        // 将泛型 observer 转换为 AnyObserverNew
        let anyObserver = AnyObserverNew<Element> { event in
            observer.on(event)
        }
        
        let id = anyObserver.id
        observers[id] = anyObserver
        
        return BlockDisposable { [weak self] in
            self?.observers.removeValue(forKey: id)
        }
    }
    
    func on(_ event: EventNew<Element>) {
        for observer in observers.values {
            observer.on(event)
        }
    }
}
