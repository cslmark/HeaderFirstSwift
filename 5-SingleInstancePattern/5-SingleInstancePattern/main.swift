//
//  main.swift
//  5-SingleInstancePattern
//
//  Created by 青枫(陈双林) on 2025/8/5.
//

import Foundation

/**
 标准的Swift单例模式
 确保一个类只有一个实例，并提供全局访问点
   1. 为了避免单例被多次初始化，将init设定为private
   2. 类型属性定义 保证外面能够访问到
     3. 采用let保证线程安全
     4. 类型属性跟静态变量比较起来，就是只有静态变量，一开始就会被初始化，而类型属性可以按需
 加载，只有被调用才会调用
 */
class SimpleSingal {
    static let shared = SimpleSingal()
    private init() {
        
    }
    
    func doSomething() {
        print("Do Something!!!")
    }
}

SimpleSingal.shared.doSomething()

