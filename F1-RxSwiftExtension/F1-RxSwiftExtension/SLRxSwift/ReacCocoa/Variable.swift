//
//  Variable.swift
//  F1-RxSwiftExtension
//
//  Created by Smart on 2025/8/2.
//

// 写一个实现双向数据绑定的功能
/**
 ✅ 1. Variable<T>（或类似的双向变量包装器）
 它持有一个值，并对外提供 Observable<T> 和 Observer<T> 的能力（类似 BehaviorRelay 或早期的 Variable）。

 ✅ 2. UITextField+Rx.swift —— 扩展 rx.text
 你需要让 rx.text 返回一个类似于 ControlProperty<String?> 的结构：

 Observable<String?>：当 textField 文本变化时发出新值。

 Observer<String?>：可以外部赋值，更新 textField.text。

 ✅ 3. 监听 textField 的输入变化（target-action 或通知）
 */

final class Variable<T> {
    private var value: T
    private let subject: SimpleSubject<T>
    
    init(value: T, subject: SimpleSubject<T>) {
        self.value = value
        self.subject = subject
    }
    
//    func asObservable() -> ObservableNew<T> {
//        
//    }
}
