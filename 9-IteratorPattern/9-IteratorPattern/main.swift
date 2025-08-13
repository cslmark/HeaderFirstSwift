//
//  main.swift
//  9-IteratorPattern
//
//  Created by Smart on 2025/8/12.
//

import Foundation

/**
 迭代器模式提供一种方式，可以访问
 一个聚合对象中的元素而又不暴露其潜
 在的表示。
 */

/**
 组合模式允许你将对象组合成树形结构来
 表现部分－整体层次结构。组合让客户可以
 统一处理个别对象和对象组合。
 */

print("第一步 ----- 调用")
let pancake = PanckeHouseMenu()
let diner = DinerMenu()
let waitress = Waitress(hourse: pancake, diner: diner)
waitress.printMenu()

print("第二步 ----- 调用")
let waitress2 = Waitress2(hourse: pancake, diner: diner)
waitress2.printMenu()


print("第三步 ----- 组合模式调用")
testAllMenu()
