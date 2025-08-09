//
//  Command.swift
//  6-CommandPattern
//
//  Created by 青枫(陈双林) on 2025/8/8.
//

protocol Command {
    func execute()
//    func undo()
}

class LightOnCommand: Command {
    let light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        light.on()
    }
}
