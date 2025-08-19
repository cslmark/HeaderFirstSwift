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

/// Entity
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

protocol GreetingOutput: AnyObject {
    func receiveGreetingData(greetingData: GreetingData)
}



class VIPERViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
