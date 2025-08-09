//
//  Receiver.swift
//  6-CommandPattern
//
//  Created by 青枫(陈双林) on 2025/8/8.
//

class ReceiverBase {
    func on() {
        let className = String(describing: type(of: self))
        print("\(className) -> ON")
    }
    
    func off() {
        let className = String(describing: type(of: self))
        print("\(className)  -> OFF")
    }
}

class Light: ReceiverBase {
    
}

enum CeilingFanState {
    case hight
    case medium
    case low
    case off
}

public class CeilingFan {
    var currentState: CeilingFanState = .off {
        didSet {
            print("CeilingFan 调整为: \(currentState)")
        }
    }
    func hight() {
        currentState = .hight
    }
    
    func medium() {
        currentState = .medium
    }
    
    func low() {
        currentState = .low
    }
    
    func off() {
        currentState = .off
    }
    
    
}



