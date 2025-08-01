//
//  main.swift
//  2-ObserverPattern
//
//  Created by 青枫(陈双林) on 2025/8/1.
//

import Foundation

let weatherData = WeatherData(temperature: 0.0, humidity: 0.0, pressure: 0.0)
let displayer = CurrentConditionDisplay(weatherData: weatherData)
weatherData.setMeasurement(temperature: 36.0, humidity: 20.0, pressure: 2)
weatherData.setMeasurement(temperature: 18.0, humidity: 20.0, pressure: 2)
weatherData.setMeasurement(temperature: 50.0, humidity: 20.0, pressure: 2)
weatherData.setMeasurement(temperature: 36.0, humidity: 10.0, pressure: 2)
