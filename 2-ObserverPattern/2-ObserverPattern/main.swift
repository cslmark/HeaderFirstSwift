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

/**Simple ObserverPattern**/
print("================= Simple ObserverPattern ================= ")
let weatherData = WeatherData(temperature: 0.0, humidity: 0.0, pressure: 0.0)
let displayer = CurrentConditionDisplay(weatherData: weatherData)
weatherData.setMeasurement(temperature: 36.0, humidity: 20.0, pressure: 2)
weatherData.setMeasurement(temperature: 18.0, humidity: 20.0, pressure: 2)
weatherData.setMeasurement(temperature: 50.0, humidity: 20.0, pressure: 2)
weatherData.setMeasurement(temperature: 36.0, humidity: 10.0, pressure: 2)

/**RxSwift ObserverPattern**/
print("================= RxSwift ObserverPattern  Step1 ================= ")
let obsevable = Just("Hello Rx")
let observer = AnyObserver<String> { event in
    switch event {
    case .next(let value):
        print("Receive: \(value)")
    case .completed:
        print("Complete")
    }
}

obsevable.subscribe(observer)

print("================= RxSwift ObserverPattern  Step2 ================= ")
let observable = Observable.create { observer in
    observer.on(.next("Hello"))
    observer.on(.next("RxSwift"))
    observer.on(.next("is Cool"))
    observer.on(.completed)
    
    return NoDisposable()
}

let observer2 = AnyObserver<String> { event in
    switch event {
    case .next(let value):
        print("Received2 value: \(value)")
    case .completed:
        print("Sequence2 completed")
    }
}

observable.subscribe(observer2)

print("================= RxSwift ObserverPattern  Step3 ================= ")
let observable3 = Observable3.create { observer in
    observer.on(.next("Hello"))
    observer.on(.next("RxSwift"))
    observer.on(.next("is Cool"))
    observer.on(.completed)
    
    return Disposables.create {
        print("Disposed subscription")
    }
}

let observer3 = AnyObserver<String> { event in
    switch event {
    case .next(let value):
        print("Received2 value: \(value)")
    case .completed:
        print("Sequence2 completed")
    }
}

let dispose = observable3.subscribe(observer3)
dispose.dispose()

// 你可以在任何时候调用
print("================= RxSwift ObserverPattern  Step4 New RXSwift2 ================= ")
let observerNew1 = AnyObserverNew<String> { event in
    switch event {
    case .onNext(let value):
        print("observerNew1 --Get---  value: \(value)")
    case .completed:
        print("observerNew1 --Get--- completed")
    case .error:
        print("observerNew1 --Get--- Error")
    }
}

let observerNew2 = AnyObserverNew<String> { event in
    switch event {
    case .onNext(let value):
        print("observerNew2 --Get--- value: \(value)")
    case .completed:
        print("observerNew2 --Get---  completed")
    case .error:
        print("observerNew2  --Get---  Error")
    }
}



let subject = SimpleSubject<String>()
let realDispose1 = subject.subscribe(observerNew1)
let realDispose2 = subject.subscribe(observerNew2)
subject.on(.onNext(value: "1"))
subject.on(.onNext(value: "2"))
realDispose1.dispose()

print("observerNew1 取消订阅")
subject.on(.onNext(value: "3"))
subject.on(.onNext(value: "4"))
realDispose2.dispose()

print("observerNew2 取消订阅")
subject.on(.onNext(value: "5"))
subject.on(.onNext(value: "6"))

