//
//  MVPViewController.swift
//  F3-MVC_MVP_MVVM_VIPER
//
//  Created by 青枫(陈双林) on 2025/8/19.
//

import UIKit

/**
 +---------+           +------------+              +---------+
 |  View   | <-->  | Presenter  | <-->  |  Model  |
 +---------+          +------------+               +---------+
 View：只负责展示 UI，不包含逻辑（通过接口暴露用户交互事件）
 Presenter：真正的业务调度者，处理逻辑，更新 View
 Model：业务数据
 
 优缺点
 ✅ 逻辑转移到 Presenter，Controller 不再臃肿
 ✅ View 更轻，UI 可以替换（方便做 Web / iOS / Android 统一逻辑）
 ❌ 接口复杂（View 和 Presenter 需要定义协议）
 ❌ Presenter 容易变得庞大（Fat Presenter）
 MVP 架构在 iOS 中意味着极好的可测性和巨大的代码量。
 👉 演进驱动力：如何进一步减少「接口胶水」？
 */

/// Model
struct Person2 {
    let firstName: String
    let lastName: String
}

/// 定义View和Presenter之间的协议
protocol GreetingView: AnyObject {
    func setGreeting(greeting: String)
}

protocol GreetingViewPresenter {
    init(view: GreetingView, person: Person2)
    func showGreeting()
}

/// Presenter
class GreetingPresenter: GreetingViewPresenter {
    unowned let view: GreetingView
    let person: Person2
    required init(view: GreetingView, person: Person2) {
        self.view = view
        self.person = person
    }
    
    func showGreeting() {
        let greeting = "Hello" + " " + self.person.firstName + " " + self.person.lastName
        self.view.setGreeting(greeting: greeting)
    }
}

class MVPViewController: UIViewController, GreetingView {
    var presenter: GreetingPresenter!
    var showGreetingButton: UIButton? = nil
    var greetingLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let person2 = Person2(firstName: "霉霉", lastName: "韩")
        self.presenter = GreetingPresenter(view: self, person: person2)
    }
    
    func setupUI() {
        let button = UIButton()
        button.frame = CGRect(x:50, y:400, width:100, height:50)
        view.addSubview(button)
    
        button.addTarget(self, action: #selector(didClickButton(_:)), for: .touchUpInside)
        button.setTitle("点我", for: .normal)
        button.backgroundColor = .lightGray
        self.showGreetingButton = button
        
        let label = UILabel()
        label.frame = CGRect(x:50, y:300, width:100, height:50)
        view.addSubview(label)
        label.backgroundColor = .green
        self.greetingLabel = label
    }
    
    /** 处理用户的输入事件*/
    @objc func didClickButton(_ button: UIButton) {
        print("点击了 按钮 =====")
        self.presenter.showGreeting()
    }
    
    func setGreeting(greeting: String) {
        self.greetingLabel?.text = greeting
    }
}
