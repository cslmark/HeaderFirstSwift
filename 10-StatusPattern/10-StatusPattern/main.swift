//
//  main.swift
//  10-StatusPattern
//
//  Created by 青枫(陈双林) on 2025/8/14.
//

import Foundation

/**
 状态: 允许对象在内部状态改变时，改变它的行为。对象看起来好像改变了它的类
 1. 状态模式允许一个对象基于内部状态拥有许多不同的行为
 2. 和过程式状态机不同，状态模式用真正的类代表每个状态
 3. Context把行为委托给所组合的的当前状态对象
 4. 状态模式允许Context随着状态的改变而改版行为
 5. 状态迁移可以由state类或context类控制
 6.使用状态模式通常会导致设计中的类的数据增加
 7.状态类可以在多个Context实例内部之间共享
 */

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
        print("已经有硬币了，不需要额外投币")
    }
    
    func rotateBar() {
        print("转动ing....")
        let luckyNum = Int.random(in: 0...9)
        print("生成的幸运数字是: \(luckyNum)")
        if luckyNum == 0 && machine?.count ?? 0 > 1 {
            machine?.currentState = machine?.winnerStatus
        } else {
            machine?.currentState = machine?.soldStatus
        }
    }
    
    func backCoin() {
        print("硬币归还给你")
        machine?.currentState = machine?.noCoinStatus
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

class WinnerStatus: Status {
    weak var machine: CandyMachine?
    init(machine: CandyMachine?) {
        self.machine = machine
    }
    
    func insertCoin() {
        fatalError("这个时候不应该调用 insertCoin")
    }
    
    func rotateBar() {
        fatalError("这个时候不应该调用 rotateBar")
    }
    
    func backCoin() {
        fatalError("这个时候不应该调用 backCoin")
    }
    
    func sendCandy() {
        machine?.releaseCandy()
        if machine?.count == 0 {
            machine?.currentState = machine?.soldOutStatus
        } else {
            machine?.releaseCandy()
            print("你是胜利者，给你2个糖")
            if machine?.count ?? 0 > 0 {
                machine?.currentState = machine?.noCoinStatus
            } else {
                print("已经没有 糖果了")
                machine?.currentState = machine?.soldOutStatus
            }
        }
    }
}


class CandyMachine: CustomStringConvertible {
    var soldOutStatus: SoldOutStatus!  // 隐式解包可选类型，自动初始化为 nil
    var noCoinStatus: NoCoreStatus!
    var hadCoinStatus: HadCoreStatus!
    var soldStatus: SoldStatus!
    var winnerStatus: WinnerStatus!
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
        self.winnerStatus = WinnerStatus(machine: self)
        
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
    
    var description: String {
        return "Machinde: [\(count)] [\(String(describing: currentState.self))]"
    }
}

/// 糖果机开始正式工作
let gumballMachine = CandyMachine(count: 5)

print(gumballMachine)
gumballMachine.insertCoin()
gumballMachine.rotateBar()
print(gumballMachine)

gumballMachine.insertCoin()
gumballMachine.rotateBar()
gumballMachine.insertCoin()
gumballMachine.rotateBar()
print(gumballMachine)






