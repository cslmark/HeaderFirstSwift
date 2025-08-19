//
//  MVVM设计模式.swift
//  F3-MVC_MVP_MVVM_VIPER
//
//  Created by 青枫(陈双林) on 2025/8/19.
//

/**
 MVVM中采用哪些设计模式
 1. 观察者模式（Observer Pattern）

 核心：View 观察 ViewModel 的数据变化，当数据变化时自动更新 UI。

 在 MVVM 中的体现：

 ViewModel 中的数据状态（如 Observable<T>、LiveData、@Published 属性）

 View 订阅这些数据，当数据变化时自动刷新 UI
 
 2. 数据绑定（Mediator + Observer 的组合）

 数据绑定本质上是 中介者模式 (Mediator) + 观察者模式 的结合。

 作用：解耦 View 和 ViewModel，不需要手动写一堆 “View → ViewModel → View 更新” 的代码。

 例子：在 SwiftUI 中，@State 和 @Binding 就是一个简化后的数据绑定机制。
 
 3. 命令模式（Command Pattern）

 核心：把用户的操作（点击按钮、滑动等）封装成命令，由 ViewModel 执行，而不是直接写在 View 里。

 在 MVVM 中的体现：

 ViewModel 提供 Action 或 Command，View 只绑定这些命令

 用户交互 → View 触发命令 → ViewModel 执行业务逻辑
 
 4. 适配器模式（Adapter Pattern）

 核心：ViewModel 经常需要把 Model 转换为 UI 友好的格式，这就是适配器模式的思想。

 例子：

 Model 里的 timestamp: 1692342342 → ViewModel 转换为 08-18 15:30
V
 Model 里的 gender: 1 → ViewModel 转换为 "男"

 👉 ViewModel 就是一个天然的 数据适配层。
 
 5. 依赖注入（Dependency Injection，常结合 IoC 容器）

 核心：MVVM 要保持可测试性，ViewModel 依赖的服务（网络请求、数据库）通常通过依赖注入提供，而不是在内部直接构建。

 好处：

 解耦（ViewModel 不依赖具体实现，而是依赖抽象接口）

 单元测试可以替换为 Mock
 */

