//
//  main.swift
//  10-StatusPattern
//
//  Created by 青枫(陈双林) on 2025/8/14.
//

import Foundation

protocol Status {
    // 塞入硬币
    func insertCoin()
    // 旋转把手
    func rotateBar()
    // 吐出硬币
    func backCoin()
    // 出售糖果
    func sendCandy()
}

class SoldOutStatus: Status {
    weak var machine: CandyMachine?
    init(machine: CandyMachine?) {
        self.machine = machine
    }
    
    // 塞入硬币
    func insertCoin() {
        print("你 加入硬币")
        machine?.currentState = machine?.hadCoinStatus
    }
    
    // 旋转把手
    func rotateBar() {
        print("你可以转动，但是没有钱")
    }
    
    // 吐出硬币
    func backCoin() {
        print("你没有投入硬币，我不能给你退钱")
    }
    
    // 出售糖果
    func sendCandy() {
        print("请先付钱")
    }
}

class HadCoreStatus: Status {
    weak var machine: CandyMachine?
    init(machine: CandyMachine?) {
        self.machine = machine
    }
    
    func insertCoin() {
        print("已经售罄，不接受硬币")
    }
    
    func rotateBar() {
        print("转动也不会有糖果")
    }
    
    func backCoin() {
        print("我这里没有硬币")
    }
    
    func sendCandy() {
        print("没有糖果可以销售")
    }
}

class NoCoreStatus: Status {
    weak var machine: CandyMachine?
    init(machine: CandyMachine?) {
        self.machine = machine
    }
    
    // 塞入硬币
    func insertCoin() {
        print("你 加入硬币")
        machine?.currentState = machine?.hadCoinStatus
    }
    
    // 旋转把手
    func rotateBar() {
        print("你可以转动，但是不会给你糖果")
    }
    
    // 吐出硬币
    func backCoin() {
        print("你没有投入硬币，我不能给你退钱")
    }
    
    // 出售糖果
    func sendCandy() {
        print("请先付钱")
    }
}

class SoldStatus: Status {
    weak var machine: CandyMachine?
    init(machine: CandyMachine?) {
        self.machine = machine
    }
    
    func insertCoin() {
        print("正在给你加载糖果，请稍等。。。。。")
    }
    
    func rotateBar() {
        print("旋转2次，不会给你2个糖果")
    }
    
    func backCoin() {
        print("已经加载糖果了，无法退钱。。。。")
    }
    
    func sendCandy() {
        machine?.releaseCandy()
        if machine?.count ?? 0 > 0 {
            machine?.currentState = machine?.noCoinStatus
        } else {
            machine?.currentState = machine?.soldOutStatus
        }
    }
}


class CandyMachine {
    var soldOutStatus: SoldOutStatus!  // 隐式解包可选类型，自动初始化为 nil
    var noCoinStatus: NoCoreStatus!
    var hadCoinStatus: HadCoreStatus!
    var soldStatus: SoldStatus!
    var currentState: (any Status)?
    var count = 0
    
    init(count: Int) {
        /**
         Swift 在初始化过程中，要求在使用 self 之前，所有存储属性都必须有值。但是我们在给 soldOutStatus 赋值时就使用了 self，这违反了初始化规则。
         
         // ← 关键：隐式解包可选类型
         ! 的作用： SoldOutStatus! 是隐式解包可选类型，Swift 会自动给它赋值 nil
         初始化顺序： 由于所有属性都有了初始值（包括自动的 nil），self 现在是"完整"的，可以安全使用
         重新赋值： 然后我们可以安全地用 self 来创建状态对象并重新赋值
         */
        self.soldOutStatus = SoldOutStatus(machine: self)
        self.noCoinStatus = NoCoreStatus(machine: self)
        self.hadCoinStatus = HadCoreStatus(machine: self)
        self.soldStatus = SoldStatus(machine: self)
        
        self.count = count
        if count > 0 {
            self.currentState = self.noCoinStatus
        } else {
            self.currentState = self.soldOutStatus
        }
    }
    
    func insertCoin() {
        currentState?.insertCoin()
    }
    
    func rotateBar() {
        currentState?.rotateBar()
        currentState?.sendCandy()
    }
    
    func backCoin() {
        currentState?.backCoin()
    }
    
    func releaseCandy() {
        print("1 个糖果加载中 ....  ")
        if (count > 0) {
            count = count - 1
            print("1 个糖果出来了 ！！！")
        } else {
            print("天呀，糖果已经卖光了")
            currentState = soldOutStatus
        }
    }
}

