//
//  ViewController.swift
//  F1-RxSwiftExtension
//
//  Created by Smart on 2025/8/2.
//

import UIKit

/**
 RxSwift 通过 ControlProperty / ControlEvent + Target-Action / Delegate / KVO 的桥接机制，
 把 UI 控件的事件封装成 Observable，暴露出响应式的“属性”供外部订阅。
 */

class ViewController: UIViewController {
    @IBOutlet weak var rxButton: UIButton!
    @IBOutlet weak var rxTextField: UITextField!
    @IBOutlet weak var rxLabel: UILabel!
    private let disposeBg = DisposeBag()
    private var disposeFlag: DisposableNew?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**一定要注意管理这里的生命周期，否则会导致，按钮点击没有反应**/
        disposeFlag = rxButton.rx.tap.subscribe(AnyObserverNew(onAction: { event in
            switch event {
            case .error:
                print("disposeFlag 发送了完成事件")
            case .completed:
                print("disposeFlag 按钮 Erro")
            case .next(_):
                print("disposeFlag 按钮被点击了")
            }
        }))
        
        
        rxButton.rx.tap.subscribe {
            print("onNext 按钮被点击了")
        }.disposed(by: self.disposeBg)
        
    }
}

