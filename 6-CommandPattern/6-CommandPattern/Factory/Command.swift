//
//  Command.swift
//  6-CommandPattern
//
//  Created by 青枫(陈双林) on 2025/8/8.
//

protocol Command {
    func execute()
    func undo()
}

class NoCommand: Command {
    func execute() {
        
    }
    
    func undo() {
        
    }
}

class LightOnCommand: Command {
    let light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        light.on()
    }
    
    func undo() {
        light.off()
    }
}

class LightOffCommand: Command {
    let light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        light.off()
    }
    
    func undo() {
        light.on()
    }
}

class CeilFanHighCommand: Command {
    var ceilingFan: CeilingFan
    var preSpeed: CeilingFanState
    
    init(ceilingFan: CeilingFan, preSpeed: CeilingFanState) {
        self.ceilingFan = ceilingFan
        self.preSpeed = preSpeed
    }
    
    func execute() {
        preSpeed = ceilingFan.currentState
        ceilingFan.currentState = .hight
    }
    
    func undo() {
        if preSpeed == .hight {
            ceilingFan.hight()
        } else if preSpeed == .medium {
            ceilingFan.medium()
        } else if preSpeed == .low {
            ceilingFan.low()
        } else if preSpeed == .low {
            ceilingFan.off()
        }
    }
}

class CeilFanMediumCommand: Command {
    var ceilingFan: CeilingFan
    var preSpeed: CeilingFanState
    
    init(ceilingFan: CeilingFan, preSpeed: CeilingFanState) {
        self.ceilingFan = ceilingFan
        self.preSpeed = preSpeed
    }
    
    func execute() {
        preSpeed = ceilingFan.currentState
        ceilingFan.currentState = .medium
    }
    
    func undo() {
        if preSpeed == .hight {
            ceilingFan.hight()
        } else if preSpeed == .medium {
            ceilingFan.medium()
        } else if preSpeed == .low {
            ceilingFan.low()
        } else if preSpeed == .low {
            ceilingFan.off()
        }
    }
}

class CeilFanLowCommand: Command {
    var ceilingFan: CeilingFan
    var preSpeed: CeilingFanState
    
    init(ceilingFan: CeilingFan, preSpeed: CeilingFanState) {
        self.ceilingFan = ceilingFan
        self.preSpeed = preSpeed
    }
    
    func execute() {
        preSpeed = ceilingFan.currentState
        ceilingFan.currentState = .low
    }
    
    func undo() {
        if preSpeed == .hight {
            ceilingFan.hight()
        } else if preSpeed == .medium {
            ceilingFan.medium()
        } else if preSpeed == .low {
            ceilingFan.low()
        } else if preSpeed == .low {
            ceilingFan.off()
        }
    }
}

class CeilFanOffCommand: Command {
    var ceilingFan: CeilingFan
    var preSpeed: CeilingFanState
    
    init(ceilingFan: CeilingFan, preSpeed: CeilingFanState) {
        self.ceilingFan = ceilingFan
        self.preSpeed = preSpeed
    }
    
    func execute() {
        preSpeed = ceilingFan.currentState
        ceilingFan.currentState = .off
    }
    
    func undo() {
        if preSpeed == .hight {
            ceilingFan.hight()
        } else if preSpeed == .medium {
            ceilingFan.medium()
        } else if preSpeed == .low {
            ceilingFan.low()
        } else if preSpeed == .low {
            ceilingFan.off()
        }
    }
}

class MacroCommand: Command {
    var commands: [Command]
    
    init(commands: [Command]) {
        self.commands = commands
    }
    
    func execute() {
        for i in 0..<commands.count {
            commands[i].execute()
        }
    }
    
    func undo() {
        for i in stride(from: commands.count-1, to: -1, by: -1) {
            commands[i].undo()
        }
    }
}
