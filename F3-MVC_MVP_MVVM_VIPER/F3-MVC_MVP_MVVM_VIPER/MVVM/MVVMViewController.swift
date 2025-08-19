//
//  MVVMViewController.swift
//  F3-MVC_MVP_MVVM_VIPER
//
//  Created by 青枫(陈双林) on 2025/8/19.
//

/**
 +---------+        Binding        +------------+            <->     +---------+
 |  View   | <----------> | ViewModel  | <------> |  Model |
 +---------+                            +------------+                        +---------+
 View：UI 展示

 ViewModel：负责业务状态管理，把 Model 转换为 View 可用的数据

 Model：业务数据

 关键点：双向绑定（Binding） —— View 和 ViewModel 自动同步
 
 优缺点
 ✅ 大幅减少 View <-> 逻辑之间的胶水代码
 ✅ ViewModel 可测试（无需依赖 UI）
 ✅ 特别适合 RxSwift / Combine / SwiftUI 这种响应式框架
 ❌ 学习成本高，绑定数据流难以追踪
 ❌ 容易出现 Fat ViewModel

 👉 演进驱动力：在大型复杂项目中，还需要更清晰的职责拆分。
 
 如何看待ViewController中角色定位:
 MVVM 架构把 ViewController 看做 View。
 View 和 Model 之间没有紧耦合
 
 iOS 里面的 ViewModel 到底是个什么东西呢？
 本质上来讲，他是独立于 UIKit 的， View 和 View 的状态的一个呈现（representation）。ViewModel 能主动调用对 Model 做更改，也能在 Model 更新的时候对自身进行调整，然后通过 View 和 ViewModel 之间的绑定，对 View 也进行对应的更新。
 */

import UIKit

// Model
struct Person3 {
    let firstName: String
    let lastName: String
}

// ViewModel ---> 通过这种方式，其实少了ViewModel 和 View之间的通信协议
protocol GreetingViewModelProtocol: AnyObject {
    var greeting: String? { get }
    var greetingDidChange: ((GreetingViewModelProtocol) -> ())? { get set }
    init(person: Person3)
    func showGreeting()
}

class GreetingViewModel: GreetingViewModelProtocol {
    let person: Person3
    var greeting: String? {
        didSet {
            self.greetingDidChange?(self)
        }
    }
    
    var greetingDidChange: ((any GreetingViewModelProtocol) -> ())?
    
    required init(person: Person3) {
        self.person = person
    }
    
    func showGreeting() {
        self.greeting = "Hello" + " " + self.person.firstName + " " + self.person.lastName
    }
}

class MVVMViewController: UIViewController {
    var showGreetingButton: UIButton? = nil
    var greetingLabel: UILabel?
    
    var viewModel: GreetingViewModelProtocol! {
        didSet {
            self.viewModel.greetingDidChange = { [weak self] viewModel in
                guard let self else {
                    return
                }
                self.greetingLabel?.text = viewModel.greeting
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let person3 = Person3(firstName: "霉霉", lastName: "韩")
        self.viewModel = GreetingViewModel(person: person3)
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
        self.viewModel.showGreeting()
    }
}
