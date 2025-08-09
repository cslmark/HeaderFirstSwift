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

class RemoteControlWithUndo {
    var onComands: [Command]
    var offCommands: [Command]
    var undoCommand: Command
    
    init(onComands: [Command], offCommands: [Command], undoCommand: Command) {
        self.onComands = onComands
        self.offCommands = offCommands
        self.undoCommand = undoCommand
    }
    
    init() {
        self.onComands = [NoCommand](repeating: NoCommand(), count: 7)
        self.offCommands = [NoCommand](repeating: NoCommand(), count: 7)
        self.undoCommand = NoCommand()
    }
    
    func setComand(slot: Int, onCommand: Command, offCommand: Command) {
        guard slot < self.onComands.count else {
            return
        }
        onComands[slot] = onCommand
        offCommands[slot] = offCommand
    }
    
    func onButtonWasPushed(slot: Int) {
        guard slot < self.onComands.count else {
            return
        }
        onComands[slot].execute()
        undoCommand =  onComands[slot]
    }
    
    func offButtonWasPushed(slot: Int) {
        guard slot < self.onComands.count else {
            return
        }
        offCommands[slot].execute()
        undoCommand =  offCommands[slot]
    }
    
    func undoButtonWasPusher() {
        undoCommand.undo()
    }
    
}

print("================ Step1:最简单的空调遥控器 ======================")
let light = Light()
let lightOn = LightOnCommand(light: light)
let remote = SimpleRemoteControl(slot: lightOn)
remote.buttonWasPressed()

let lightOff = LightOffCommand(light: light)


let ceilingFan = CeilingFan()
let ceilingFanHeight = CeilFanHighCommand(ceilingFan: ceilingFan, preSpeed: .off)
let ceilingFanMedium = CeilFanMediumCommand(ceilingFan: ceilingFan, preSpeed: .off)
let ceilingFanLow = CeilFanLowCommand(ceilingFan: ceilingFan, preSpeed: .off)
let offFceilingFanOff = CeilFanOffCommand(ceilingFan: ceilingFan, preSpeed: .off)


let remoteControl = RemoteControlWithUndo()
remoteControl.setComand(slot: 0, onCommand: ceilingFanLow, offCommand: offFceilingFanOff)
remoteControl.setComand(slot: 1, onCommand: ceilingFanMedium, offCommand: offFceilingFanOff)
remoteControl.setComand(slot: 2, onCommand: ceilingFanLow, offCommand: offFceilingFanOff)

remoteControl.onButtonWasPushed(slot: 0)
remoteControl.offButtonWasPushed(slot: 0)
remoteControl.onButtonWasPushed(slot: 1)
remoteControl.offButtonWasPushed(slot: 1)
remoteControl.onButtonWasPushed(slot: 2)
remoteControl.offButtonWasPushed(slot: 2)
remoteControl.undoButtonWasPusher()

var partyOn: [Command] = [lightOn, ceilingFanHeight]
var partyOff: [Command] = [lightOff, offFceilingFanOff]

let paryOnMacro = MacroCommand(commands: partyOn)
let paryOffMacro = MacroCommand(commands: partyOff)

remoteControl.setComand(slot: 3, onCommand: paryOnMacro, offCommand: paryOffMacro)
remoteControl.onButtonWasPushed(slot: 3)
//remoteControl.offButtonWasPushed(slot: 3)
remoteControl.undoButtonWasPusher()
