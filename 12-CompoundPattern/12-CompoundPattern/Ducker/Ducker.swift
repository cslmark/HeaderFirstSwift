//
//  Ducker.swift
//  12-CompoundPattern
//
//  Created by Smart on 2025/8/19.
//

protocol Quackable {
    func quack()
}

class MallardDuck: Quackable {
    func quack() {
        let className = String(describing: type(of: self))
        print(className, " Quick!!!")
    }
}

class RedHeadDuck: Quackable {
    func quack() {
        let className = String(describing: type(of: self))
        print(className, " Quick!!!")
    }
}

class DuckCall: Quackable {
    func quack() {
        let className = String(describing: type(of: self))
        print(className, " Quick!!!")
    }
}

class RubberDucker: Quackable {
    func quack() {
        let className = String(describing: type(of: self))
        print(className, " Quick!!!")
    }
}


