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

protocol DisplayElement {
    func display()
}


/*** 主题相关 */
protocol Subject: AnyObject {
    func addObserver(_ observer: Observer)
    func removeObserver(_ observer: Observer)
    func notifyObservers()
}

class WeatherData {
    // 目前苹果这个还没有兼容好，只能先用objc来兼容Observer
    private let observers = NSHashTable<Observer>.weakObjects()
    
    var temperature: Double
    var humidity: Double
    var  pressure: Double
    
    init(temperature: Double, humidity: Double, pressure: Double) {
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
    }
    
    func setMeasurement(temperature: Double, humidity: Double, pressure: Double) {
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        notifyObservers()
    }
}

extension WeatherData: Subject {
    func addObserver(_ observer: any Observer) {
        observers.add(observer)
    }
    
    func removeObserver(_ observer: any Observer) {
        observers.remove(observer)
    }
    
    func notifyObservers() {
        // 这里需要过滤掉已经被释放掉的对象== 》 会自动清理 nil 引用
        let snapshot = observers.allObjects
        snapshot.forEach {
            $0.update()
        }
    }
}


/*** 观察者 */
class CurrentConditionDisplay: Observer, DisplayElement {
    private var temperature: Double
    private var humidity: Double
    private var weatherData: WeatherData
    
    init(weatherData: WeatherData) {
        self.weatherData = weatherData
        self.temperature = weatherData.temperature
        self.humidity = weatherData.humidity
        self.weatherData.addObserver(self)
    }
    
    func update() {
        self.temperature = weatherData.temperature
        self.humidity = weatherData.humidity
        self.display()
    }
    
    func display() {
        print("当前温度: \(temperature), 当前湿度: \(humidity)")
    }
}
