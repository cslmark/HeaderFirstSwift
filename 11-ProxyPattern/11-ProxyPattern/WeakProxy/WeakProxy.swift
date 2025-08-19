//
//  WeakTimer.swift
//  11-ProxyPattern
//
//  Created by 青枫(陈双林) on 2025/8/15.
//

import Foundation

/**
 本质：命令模式 + 代理模式

 命令模式：Timer 持有一个“执行动作”（selector）。

 代理模式：WeakProxy 站在中间，负责把消息转发到真正的目标。

 好处是：目标对象可以销毁而不影响 Timer，同时 Timer 仍然能正常运作
 */

class WeakProxy: NSObject {
    weak var target: AnyObject?
    
    init(target: AnyObject? = nil) {
        self.target = target
    }
    
    /// 将timer触发的方法，这里将消息转发给真实对象
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        return target
    }
    
    override func responds(to aSelector: Selector!) -> Bool {
        return target?.responds(to: aSelector) ?? false
    }
}
