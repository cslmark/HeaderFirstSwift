//
//  ViewController.swift
//  11-ProxyPattern
//
//  Created by 青枫(陈双林) on 2025/8/15.
//

import UIKit

/**
 **代理模式（Proxy Pattern）**和 委托（Delegate Pattern） 在 iOS 中经常被混在一起说，但它们其实有区别：

 代理模式（Proxy）：强调控制访问，代理对象站在客户端和目标对象之间，转发或拦截请求。

 委托模式（Delegate）：强调回调与扩展，把“要怎么做”交给外部对象。
 
 */


class ViewController: UIViewController {
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: WeakProxy(target: self), selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    @objc func tick() {
        print("Tick")
    }

    deinit {
        timer?.invalidate()
        print("ViewController Dealloc")
    }
}

