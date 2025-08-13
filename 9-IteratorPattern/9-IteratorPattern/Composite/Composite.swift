//
//  Composite.swift
//  9-IteratorPattern
//
//  Created by 青枫(陈双林) on 2025/8/13.
//

/**
 组合模式允许你将对象组合成树形结构来
 表现部分－整体层次结构。组合让客户可以
 统一处理个别对象和对象组合。
 */
class MenuComponent {
    func add(_ item: MenuComponent) {
        fatalError("抽象类不实现这个方法")
    }
    
    func remove(_ item: MenuComponent) {
        fatalError("抽象类不实现这个方法")
    }
    
    func getChild(_ index: Int) -> MenuComponent {
        fatalError("抽象类不实现这个方法")
    }
    
    func getName() -> String {
        fatalError("抽象类不实现这个方法")
    }
    
    func getDesc() -> String {
        fatalError("抽象类不实现这个方法")
    }
    
    func getPrice() -> Double {
        fatalError("抽象类不实现这个方法")
    }
    
    func isVegetarian() -> Bool {
        fatalError("抽象类不实现这个方法")
    }
    
    func print() {
        fatalError("抽象类不实现这个方法")
    }
}

class MenuItem2: MenuComponent {
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
    
    override func getName() -> String {
        return name
    }
    
    override func getDesc() -> String {
        return desc
    }
    
    override func getPrice() -> Double {
        return price
    }
    
    override func isVegetarian() -> Bool {
        return vegetarian
    }
    
    override func print() {
        Swift.print("\(getName())_\(getPrice())_\(isVegetarian())_\(getDesc())")
    }
}

class Menu2: MenuComponent {
    var menuComponentList = [MenuComponent]()
    var name: String
    var desc: String
    
    init(menuComponentList: [MenuComponent] = [MenuComponent](), name: String, desc: String) {
        self.menuComponentList = menuComponentList
        self.name = name
        self.desc = desc
    }
    
    override func add(_ item: MenuComponent) {
        menuComponentList.append(item)
    }
    
    override func remove(_ item: MenuComponent) {
        menuComponentList.removeAll {
            $0 === item
        }
    }
    
    override func getChild(_ index: Int) -> MenuComponent {
        // 这里不是很安全
        return menuComponentList[index]
    }
    
    override func getName() -> String {
        return name
    }
    
    override func getDesc() -> String {
        return desc
    }
    
    override func print() {
        Swift.print("\(getName())_\(getDesc())")
        for item in menuComponentList {
            item.print()
        }
    }
}

class Waitress3 {
    var allMenuComponent: MenuComponent
    init(allMenuComponent: MenuComponent) {
        self.allMenuComponent = allMenuComponent
    }
    
    func printMenu() {
        allMenuComponent.print()
    }
}

func testAllMenu() {
    let pancakeMenu = Menu2(name: "PANC HOUSE MENU", desc: "Breakfas")
    let dinerMenu = Menu2(name: "DINER MENU", desc: "Lunch")
    let cafeMenu = Menu2(name: "CAFE MENU", desc: "Dinner")
    let dessertMenu = Menu2(name: "DESSERT MENU", desc: "DESSERT")
    
    let allMenus = Menu2(name: "All MENU", desc: "All menus combine")
    allMenus.add(pancakeMenu)
    allMenus.add(dinerMenu)
    allMenus.add(cafeMenu)
    
    dinerMenu.add(MenuItem2(name: "Pasta", desc: "好吃不贵", vegetarian: false, price: 25.0))
    dinerMenu.add(dessertMenu)
    dessertMenu.add(MenuItem2(name: "冰淇淋", desc: "好吃不贵", vegetarian: false, price: 55.0))
    
    let waitress = Waitress3(allMenuComponent: allMenus)
    waitress.printMenu()
}
