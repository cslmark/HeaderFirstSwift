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
