//
//  ViewController.swift
//  F3-MVC_MVP_MVVM_VIPER
//
//  Created by 青枫(陈双林) on 2025/8/19.
//

import UIKit

/**
 +---------+           +------------+             +---------+
 |  View   | <-->  | Controller | <-->  |  Model  |
 +---------+           +------------+            +---------+
 Model：模型持有所有数据、状态和应用逻辑。模型对视图和控制器是无视的，虽然它提供了操纵和检索其状态的接口，并发送状态改变通知给观察者

 View：呈现模型，视图通常直接从模型中取得展示所需要的状态和数据

 Controller：取得用户输入并解读其对模型的含义

 优缺点

 ✅ 简单直观，快速上手
 ❌ Controller 太臃肿（Massive View Controller），逻辑和 UI 混在一起，难以测试

 👉 演进驱动力：如何减轻 Controller 的负担？
 https://www.objc.io/issues/1-view-controllers/lighter-view-controllers/
 */

// Model
struct Person {
    let firstName: String
    let lastName: String
}

// View + Controller
class ViewController: UIViewController {
    var person: Person?
    var showGreetingButton: UIButton? = nil
    var greetingLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.person = Person(firstName: "霉霉", lastName: "韩")
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
        guard let person = self.person else {
            return
        }
        /// 更新页面
        let greeting = "Hello" + " " + person.firstName + " " + person.lastName
        self.greetingLabel?.text = greeting
    }
}

