//
//  UIButton+Reactive.swift
//  F1-RxSwiftExtension
//
//  Created by Smart on 2025/8/2.
//

import UIKit

final class UIControlTarget: NSObject, DisposableNew {
    private weak var control: UIControl?
    private let event: UIControl.Event
    private let callback: ()->Void
    private var isDisposed = false
    
    init(control: UIControl? = nil, event: UIControl.Event, callback: @escaping () -> Void, isDisposed: Bool = false) {
        self.control = control
        self.event = event
        self.callback = callback
        self.isDisposed = isDisposed
        super.init()
        control?.addTarget(self, action: #selector(eventHandler), for: self.event)
    }
    
    @objc private func eventHandler() {
        if !isDisposed {
            callback()
        }
    }
    
    func dispose() {
        control?.removeTarget(self, action: #selector(eventHandler), for: self.event)
        isDisposed = true
    }
}


/**
 开始拓展UIButton
 1. 给UIButton 拓展独立的rx 空间
 */
extension UIButton: ReactiveCompatible {
    typealias CompatibleType = UIButton
}

extension Reactive where Base: UIButton {
    var tap: ControlEvent<Void> {
        let observable = ObservableNew<Void> { observer in
            let target = UIControlTarget(control: base, event: .touchUpInside) {
                observer.on(.next(value: ()))
            }
            return target
        }
        return ControlEvent(source: observable)
    }
}


