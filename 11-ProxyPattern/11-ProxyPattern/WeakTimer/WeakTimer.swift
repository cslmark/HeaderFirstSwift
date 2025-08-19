//
//  WeakTimer.swift
//  11-ProxyPattern
//
//  Created by 青枫(陈双林) on 2025/8/15.
//

import Foundation

class SLWeakProxy: NSProxy {
    weak var target: NSObjectProtocol?
    init(target: NSObjectProtocol? = nil) {
        self.target = target
    }
}
