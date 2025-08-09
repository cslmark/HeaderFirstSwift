//
//  main.swift
//  6-CommandPattern
//
//  Created by 青枫(陈双林) on 2025/8/8.
//

import Foundation

/**
 命令模式 把请求封装为对象，以便用不同的请求、队列或者日志请求来参数化其他对象
 并且支持可撤销的操作
 */
class SimpleRemoteControl {
    var slot: Command
    init(slot: Command) {
        self.slot = slot
    }
    
    func setCommand(_ command: Command) {
        slot = command
    }
    
    func buttonWasPressed() {
        slot.execute()
    }
}

print("================ Step1:最简单的空调遥控器 ======================")
let light = Light()
let lightCommand = LightOnCommand(light: light)
let remote = SimpleRemoteControl(slot: lightCommand)
remote.buttonWasPressed()




