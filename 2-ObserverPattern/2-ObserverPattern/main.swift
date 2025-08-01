//
//  main.swift
//  2-ObserverPattern
//
//  Created by 青枫(陈双林) on 2025/8/1.
//

import Foundation

/**
 观察者模式:
 观察者，定义对象之间一堆多的依赖这样，当一个对象改变状态时，它的所有依赖者会被通知并且自动更新
 1. 注意观察者管理人弱引用关系
 2. 最典型的引用RxSwift代码
 */

let weatherData = WeatherData(temperature: 0.0, humidity: 0.0, pressure: 0.0)
let displayer = CurrentConditionDisplay(weatherData: weatherData)
weatherData.setMeasurement(temperature: 36.0, humidity: 20.0, pressure: 2)
weatherData.setMeasurement(temperature: 18.0, humidity: 20.0, pressure: 2)
weatherData.setMeasurement(temperature: 50.0, humidity: 20.0, pressure: 2)
weatherData.setMeasurement(temperature: 36.0, humidity: 10.0, pressure: 2)
