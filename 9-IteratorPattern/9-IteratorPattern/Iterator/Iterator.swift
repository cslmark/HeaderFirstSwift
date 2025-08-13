//
//  Iterator.swift
//  9-IteratorPattern
//
//  Created by 青枫(陈双林) on 2025/8/13.
//

class MenuItem {
    var name: String
    var desc: String
    var vegetarian: Bool
    var price: Double
    init(name: String, desc: String, vegetarian: Bool, price: Double) {
        self.name = name
        self.desc = desc
        self.vegetarian = vegetarian
        self.price = price
    }
}

class ListNode<T> {
    var value: T?
    var next: ListNode<T>?
}

class PanckeHouseMenu {
    var head: ListNode<MenuItem>?
    
    init() {
        addItem(name: "香肠", desc: "好吃不贵", vegetarian: false, price: 5)
        addItem(name: "鸡蛋", desc: "好吃不贵", vegetarian: false, price: 15)
        addItem(name: "粽子", desc: "好吃不贵", vegetarian: false, price: 52)
        addItem(name: "冬至包", desc: "好吃不贵", vegetarian: false, price: 35)
    }
    
    func addItem(name: String, desc: String, vegetarian: Bool, price: Double) {
        let menuItem = MenuItem(name: name, desc: desc, vegetarian: vegetarian, price: price)
        let node = ListNode<MenuItem>()
        node.value = menuItem
        node.next = nil
        var tempHead = head
        while tempHead?.next != nil  {
            tempHead = tempHead?.next
        }
        if tempHead == nil {
            head = node
        } else {
            tempHead?.next = node
        }
    }
}

class DinerMenu {
    var menuItems = [MenuItem]()
    
    init() {
        addItem(name: "苹果", desc: "好吃不贵", vegetarian: true, price: 5)
        addItem(name: "香蕉", desc: "好吃不贵", vegetarian: true, price: 15)
        addItem(name: "🍐", desc: "好吃不贵", vegetarian: true, price: 52)
        addItem(name: "荔枝", desc: "好吃不贵", vegetarian: true, price: 35)
    }
    
    func addItem(name: String, desc: String, vegetarian: Bool, price: Double) {
        let menuItem = MenuItem(name: name, desc: desc, vegetarian: vegetarian, price: price)
        menuItems.append(menuItem)
    }
}

/*** 创建迭代器 */
protocol Iterator {
    associatedtype Element
    func hasNext()->Bool
    func next()->Element?
}



class PanckeHouseMenuIterator: Iterator {
    typealias Element = MenuItem
    var head: ListNode<MenuItem>?
    
    init(head: ListNode<MenuItem>? = nil) {
        self.head = head
    }
    
    func hasNext() -> Bool {
        head?.next != nil
    }
    
    func next() -> MenuItem? {
        let current = head?.value
        head = head?.next
        return current
    }
}

class DinerMenuIterator: Iterator {
    typealias Element = MenuItem
    var menuItems: [MenuItem]
    var count = 0
    
    init(menuItems: [MenuItem], count: Int = 0) {
        self.menuItems = menuItems
        self.count = count
    }
    
    func hasNext() -> Bool {
        count < menuItems.count
    }
    
    func next() -> MenuItem? {
        var temp: MenuItem? = nil
        if count < menuItems.count {
            temp = menuItems[count]
            count += 1
        }
        return temp
    }
}

class Waitress {
    var hourse: PanckeHouseMenu
    var diner: DinerMenu
    
    init(hourse: PanckeHouseMenu, diner: DinerMenu) {
        self.hourse = hourse
        self.diner = diner
    }
    
    func printMenu() {
        let pancake: any Iterator = PanckeHouseMenuIterator(head: hourse.head)
        let dinner: any Iterator = DinerMenuIterator(menuItems: diner.menuItems)
        printMenu(iterator: pancake)
        printMenu(iterator: dinner)
    }
    
    func printMenu(iterator: any Iterator) {
        while iterator.hasNext() {
            let item = iterator.next()
            guard let item = item as? MenuItem else {
                continue
            }
            print("name = \(item.name), price = \(item.price)")
        }
    }
}

/***
 更进一步: 继续在后面新增协议
 */
protocol Menu {
    func createIterator() -> any Iterator
}

extension PanckeHouseMenu: Menu {
    func createIterator() -> any Iterator {
        return PanckeHouseMenuIterator(head: head)
    }
}

extension DinerMenu: Menu {
    func createIterator() -> any Iterator {
        return DinerMenuIterator(menuItems: menuItems)
    }
}

class Waitress2 {
    var hourse: PanckeHouseMenu
    var diner: DinerMenu
    
    init(hourse: PanckeHouseMenu, diner: DinerMenu) {
        self.hourse = hourse
        self.diner = diner
    }
    
    func printMenu() {
        let pancake: any Iterator = hourse.createIterator()
        let dinner: any Iterator = diner.createIterator()
        printMenu(iterator: pancake)
        printMenu(iterator: dinner)
    }
    
    func printMenu(iterator: any Iterator) {
        while iterator.hasNext() {
            let item = iterator.next()
            guard let item = item as? MenuItem else {
                continue
            }
            print("name = \(item.name), price = \(item.price)")
        }
    }
}
