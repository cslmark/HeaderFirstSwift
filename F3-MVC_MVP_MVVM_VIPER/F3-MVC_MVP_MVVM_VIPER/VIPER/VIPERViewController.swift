//
//  VIPERViewController.swift
//  F3-MVC_MVP_MVVM_VIPER
//
//  Created by 青枫(陈双林) on 2025/8/19.
//

/**
 +---------+                +------------+                 +---------+
 |  View   | <----> | Presenter  | <----> | Entity  |
 +---------+                +------------+                  +---------+
                    |       ^
                    v       |
                  +---------+  |
                  |Interactor|--
                  +---------+

 +---------+
 | Router  |
 +---------+
 
 View：UI 展示

 Presenter：处理用户输入，协调业务逻辑与 UI 展示

 Interactor：核心业务逻辑（Use Case 层）

 Entity：数据模型（User、Order 等）

 Router：处理导航、界面跳转
 
 优缺点
 ✅ 单一职责清晰，便于多人协作
 ✅ 每一层都可以单独测试
 ✅ 适合 大型团队 / 长期维护的项目
 ❌ 初期代码量大，模板化严重
 ❌ 小型项目使用过于复杂
 */

import UIKit

// MARK: - Entity
struct Person4 {
    let firstName: String
    let lastName: String
}

struct GreetingData {  // Transport data Structure <Not Entity>
    let greeting: String
    let subject: String
}

protocol GreetingProvider {
    func provideGreetingData()
}

/// 提供通知的方式
protocol GreetingOutput: AnyObject {
    func receiveGreetingData(greetingData: GreetingData)
}

// MARK: - Interactor
class GreetingInteractor: GreetingProvider {
    weak var output: GreetingOutput!
    
    func provideGreetingData() {
        let person = Person4(firstName: "David", lastName: "Blaine")  // 通常来源于数据访问层
        let subject = person.firstName + " " + person.lastName
        let greeting = GreetingData(greeting: "Hello ", subject: subject)
        self.output.receiveGreetingData(greetingData: greeting)
    }
}

/// UI的事件处理协议
protocol GreetingViewEventHandler {
    func didTapShowGreetingButton()
}

/// UI事件更新的方法协议
protocol GreetingNewView: AnyObject {
    func setGreenting(greeting: String)
}

// MARK: - Presenter
class GreetingPresenterNew: GreetingOutput, GreetingViewEventHandler {
    weak var view: GreetingView!
    var greetingProvider: GreetingProvider!
    
    func didTapShowGreetingButton() {
        self.greetingProvider.provideGreetingData()
    }
    
    func receiveGreetingData(greetingData: GreetingData) {
        let greeting = greetingData.greeting + " " + greetingData.subject
        self.view.setGreeting(greeting: greeting)
    }
}

// MARK: - View
class VIPERViewController: UIViewController, GreetingView {
    var eventHandler: GreetingViewEventHandler!
    var showGreetingButton: UIButton? = nil
    var greetingLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let presenter = GreetingPresenterNew()
        let interactor = GreetingInteractor()
        eventHandler = presenter
        presenter.view = self
        presenter.greetingProvider = interactor
        interactor.output = presenter
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
        self.eventHandler.didTapShowGreetingButton()
    }
    
    func setGreeting(greeting: String) {
        self.greetingLabel?.text = greeting
    }
}
