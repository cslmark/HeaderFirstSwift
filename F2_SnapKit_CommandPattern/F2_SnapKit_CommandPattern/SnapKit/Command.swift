//
//  Command.swift
//  F2_SnapKit_CommandPattern
//
//  Created by Smart on 2025/8/10.
//

import UIKit

protocol Command {
    func execute()
    func undo()
}

final class CommandManager {
    static let shared = CommandManager()
    private init() {
        
    }
    
    private var undoStack: [Command] = []
    private var redoStack: [Command] = []
    
    func execute(_ command: Command) {
        DispatchQueue.main.async {
            command.execute()
            self.undoStack.append(command)
            self.redoStack.removeAll()
        }
    }
    
    func undo() {
        DispatchQueue.main.async {
            guard let cmd = self.undoStack.popLast() else {
                return
            }
            cmd.undo()
            self.redoStack.append(cmd)
        }
    }
    
    func redo() {
        DispatchQueue.main.async {
            guard let cmd = self.redoStack.popLast() else {
                return
            }
            cmd.execute()
            self.undoStack.append(cmd)
        }
    }
    
    func clearHistory() {
        undoStack.removeAll()
        redoStack.removeAll()
    }
}


final class ConstraintCommand: Command {
    weak var firtstItem: UIView?
    weak var secondItem: UIView?
    
    let firstAttr: NSLayoutConstraint.Attribute
    let secondAttr: NSLayoutConstraint.Attribute
    let relation: NSLayoutConstraint.Relation
    let multiplier: CGFloat
    let constant: CGFloat
    private var createdConstraint: NSLayoutConstraint?
    
    init(firtstItem: UIView? = nil, secondItem: UIView? = nil, firstAttr: NSLayoutConstraint.Attribute, secondAttr: NSLayoutConstraint.Attribute, relation: NSLayoutConstraint.Relation, multiplier: CGFloat, constant: CGFloat, createdConstraint: NSLayoutConstraint? = nil) {
        self.firtstItem = firtstItem
        self.secondItem = secondItem
        self.firstAttr = firstAttr
        self.secondAttr = secondAttr
        self.relation = relation
        self.multiplier = multiplier
        self.constant = constant
        self.createdConstraint = createdConstraint
    }
    
    func execute() {
        guard let first = firtstItem else {
            return
        }
        first.translatesAutoresizingMaskIntoConstraints = false
        secondItem?.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = NSLayoutConstraint(
            item: first, attribute: firstAttr, relatedBy: relation, toItem: secondItem, attribute: secondAttr, multiplier: multiplier, constant: constant
        )
        constraint.isActive = true
        self.createdConstraint = constraint
    }
    
    func undo() {
        createdConstraint?.isActive = false
        createdConstraint = nil
    }
}


final class CompositeCommand: Command {
    private var commands: [Command]
    init(commands: [Command]) {
        self.commands = commands
    }
    
    func execute() {
        commands.forEach {
            $0.execute()
        }
    }
    
    func undo() {
        commands.reversed().forEach {
            $0.undo()
        }
    }
}


