//
//  DSL.swift
//  F2_SnapKit_CommandPattern
//
//  Created by Smart on 2025/8/10.
//

import UIKit

final class ConstraintMaker {
    private weak var view: UIView?
    fileprivate var commands: [Command] = []
    /// pending relations：在 activate 前收集、允许链式修改
    fileprivate var pendingRelations: [ConstraintRelation] = []
    
    init(view: UIView? = nil) {
        self.view = view
    }
    
    // 每个属性返回一个ConstraintItem
    var left: ConstraintItem {
        ConstraintItem(view: view, attr: .left, maker: self)
    }
    var right: ConstraintItem {
        ConstraintItem(view: view, attr: .right, maker: self)
    }
    var top: ConstraintItem {
        ConstraintItem(view: view, attr: .top, maker: self)
    }
    var bottom: ConstraintItem {
        ConstraintItem(view: view, attr: .bottom, maker: self)
    }
    var width: ConstraintItem {
        ConstraintItem(view: view, attr: .width, maker: self)
    }
    var height: ConstraintItem {
        ConstraintItem(view: view, attr: .height, maker: self)
    }
    var centerX: ConstraintItem {
        ConstraintItem(view: view, attr: .centerX, maker: self)
    }
    var centerY: ConstraintItem {
        ConstraintItem(view: view, attr: .centerY, maker: self)
    }
    
    func activate() {
        // 先把所有 pending relation commit 成命令（commit 是幂等的）
        pendingRelations.forEach { $0.commit() }
        pendingRelations.removeAll()
        
        let composite = CompositeCommand(commands: commands)
        CommandManager.shared.execute(composite)
        commands.removeAll()
    }
}

// 中间第一层，属性对象
final class ConstraintItem {
    weak var view: UIView?
    let attr: NSLayoutConstraint.Attribute
    unowned let maker: ConstraintMaker
    
    init(view: UIView? = nil, attr: NSLayoutConstraint.Attribute, maker: ConstraintMaker) {
        self.view = view
        self.attr = attr
        self.maker = maker
    }
    
    func equalTo(_ other: UIView) -> ConstraintRelation {
        return ConstraintRelation(firstView:view,
                                  firtstAttr: attr, relation: .equal, secondView: other, secondAttr: attr, maker:maker)
    }
    
    @discardableResult func equalTo(_ constant: CFloat) -> ConstraintRelation {
        let relation = ConstraintRelation(firstView: view, firtstAttr: attr, relation: .equal, secondView: nil, secondAttr: .notAnAttribute, constant: CGFloat(constant), maker: maker)
        maker.pendingRelations.append(relation)
        return relation
    }
}

final class ConstraintRelation {
    weak var firstView: UIView?
    let firtstAttr: NSLayoutConstraint.Attribute
    let relation: NSLayoutConstraint.Relation
    weak var secondView: UIView?
    let secondAttr: NSLayoutConstraint.Attribute
    var constant: CGFloat
    var multiplier: CGFloat
    unowned let maker: ConstraintMaker
    
    private(set) var committed: Bool = false
    
    init(firstView: UIView? = nil,
    firtstAttr: NSLayoutConstraint.Attribute,
    relation: NSLayoutConstraint.Relation,
    secondView: UIView? = nil,
    secondAttr: NSLayoutConstraint.Attribute,
    constant: CGFloat  = 0,
    multiplier: CGFloat = 1,
    maker: ConstraintMaker) {
        self.firstView = firstView
        self.firtstAttr = firtstAttr
        self.relation = relation
        self.secondView = secondView
        self.secondAttr = secondAttr
        self.constant = constant
        self.multiplier = multiplier
        self.maker = maker
    }
    
    func offset(_ value: CGFloat) {
        constant = value
        commit()
    }
    
    func multipliedBy(_ value: CGFloat) {
        multiplier = value
        commit()
    }
    
    func commit() {
        guard !committed, let firstView = firstView else {
            return
        }
        
        let cmd = ConstraintCommand(firtstItem: firstView, secondItem: secondView, firstAttr: firtstAttr, secondAttr: secondAttr, relation: relation, multiplier: multiplier, constant: constant)
        maker.commands.append(cmd)
        committed = true
    }
}

// 拓展UIView
extension UIView {
    func sl_makeConstraints(_ closure: (ConstraintMaker) -> Void) {
        let maker = ConstraintMaker(view: self)
        closure(maker)
        maker.activate()
    }
}
