//
//  Observer.swift
//  2-ObserverPattern
//
//  Created by 青枫(陈双林) on 2025/8/1.
//

import Foundation

@objc protocol Observer: AnyObject {
    // 通知更新
    func update()
}

protocol Subject: AnyObject {
    func addObserver(_ observer: Observer)
    func removeObserver(_ observer: Observer)
    func notifyObservers()
}

class WeatherData {
    // 目前苹果这个还没有兼容好，只能先用objc来兼容Observer
    private let observers = NSHashTable<Observer>.weakObjects()
    
    var temp: Double?
    var 
}

extension WeatherData: Subject {
    func addObserver(_ observer: any Observer) {
        observers.add(observer)
    }
    
    func removeObserver(_ observer: any Observer) {
        observers.remove(observer)
    }
    
    func notifyObservers() {
        // 这里需要过滤掉已经被释放掉的对象
        let snapshot = observers.allObjects
        snapshot.forEach {
            $0.update()
        }
    }
}
