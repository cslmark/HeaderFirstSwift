//
//  main.swift
//  1_StrategyPattern
//
//  Created by 青枫(陈双林) on 2025/7/31.
//


/**
 策略模式:
 定义了一个算法族，分别封装起来，使的它们之间可以相互变换。
 策略让算法的变化独立于使用算法使用者
 */

/**
 OO 基础
 抽象
 封装
 多态
 继承
 
 OO原则
 封装变化
 优先使用组合而不是继承
 针对接口编程，而不是针对实现编程
 */
import Foundation

// 算法使用者Ducker
let ducker = RubberDucker()

// 定义一个算法族
let qucker = Quark()
let flyer = FlyNoWay()

ducker.display()
ducker.quarker?.quark()
ducker.flyer?.fly()

// 可以运行时动态替换算法族，实现不同的算法或者行为
ducker.quarker = qucker
ducker.flyer = flyer

ducker.quarker?.quark()
ducker.flyer?.fly()

// 定义一个算法族
let qucker2 = Squark()
let flyer2 = FlyWithWings()

ducker.quarker = qucker2
ducker.flyer = flyer2

ducker.quarker?.quark()
ducker.flyer?.fly()
