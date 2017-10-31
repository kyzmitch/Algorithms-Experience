//: Playground - noun: a place where people can play

import Foundation

// Generic protocols
// https://dispatchswift.com/generic-protocols-in-swift-b47414e29bba
// https://milen.me/writings/swift-generic-protocols/

// http://cslibrary.stanford.edu/110/BinaryTrees.html
// Basically, binary search trees are fast at insert and lookup.


protocol Treelike {
    associatedtype Element: Comparable
    func insert(valueForInsertion: Element) -> Self
    func search(for value: Element) -> Self?
}

// Use 'final' keyword for class to meet requirements from compiler
// for returning Self from function
// specifically for search
final class BinaryTreeNodeRefType<T: Comparable> {
    private let value: T
    // parent can be nil if it is root node
    private weak var parent: BinaryTreeNodeRefType?
    // childs should be stored by strong references
    private var left: BinaryTreeNodeRefType?
    private var right: BinaryTreeNodeRefType?
    
    // to protect from empty case
    // private init()
    // even if that init method is never used
    // compiler wants to initialize non optional values
    // but it is not possible or not convinient
    // value = T.init()
    // because for example Int can't be emtpy, but for example String could be
    
    init(newValue: T) {
        value = newValue
    }
}

// When you extend a generic type, you don’t provide a type parameter list as part of the extension’s definition.
// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html#//apple_ref/doc/uid/TP40014097-CH26-ID179
// So, no need to write something like next
// extension BinaryTreeNodeRefType<T: Comparable>: Insertable

extension BinaryTreeNodeRefType: Treelike {
    typealias Element = T

    public func insert(valueForInsertion: Element) -> Self {
        // to maintain balanced binary tree
        // need to search place where to insert firstly from the root node
        if valueForInsertion < value {
            if let left = left {
                left.insert(valueForInsertion: valueForInsertion)
            }
            else {
                left = BinaryTreeNodeRefType(newValue: valueForInsertion)
                left?.parent = self
            }
        }
        else {
            if let right = right {
                right.insert(valueForInsertion: valueForInsertion)
            }
            else {
                right = BinaryTreeNodeRefType(newValue: valueForInsertion)
                right?.parent = self
            }
        }
        
        // self but it actually will not be used
        return self
    }
    
    func search(for value: T) -> BinaryTreeNodeRefType? {
        // 'Self' is only available in a protocol or as the result of a method in a class
        var result: BinaryTreeNodeRefType?
        // empty case for class implementation is not justified
        // because if describe the value as Optional
        // then it will be very bad for performance to always cast from Optional to real type
        // during search or insert
        
        if value == self.value {
            return self
        }
        else {
            if let left = left {
                if value == left.value {
                    return left
                }
                else if value < left.value {
                    return left.search(for: value)
                }
            }
            if let right = right {
                if value == right.value {
                    return right
                }
                else if value > right.value {
                    return right.search(for: value)
                }
            }
        }
        
        return result
    }
}

// Note: tree implementation using

enum BinaryTreeNodeEnum<T: Comparable> {
    case empty
    case leaf(T)
    indirect case node(BinaryTreeNodeEnum, T, BinaryTreeNodeEnum)
    
    init() {
        self = .empty
    }
    
    init(newValue: T) {
        self = .leaf(newValue)
    }
}

extension BinaryTreeNodeEnum: Treelike {
    typealias Element = T
    public func insert(valueForInsertion: Element) -> BinaryTreeNodeEnum {

        switch self {
        case .empty:
            return .leaf(valueForInsertion)
        case .leaf(let currentValue):
            if valueForInsertion < currentValue {
                return .node(BinaryTreeNodeEnum(newValue: valueForInsertion), currentValue, .empty)
            }
            else {
                return .node(.empty, currentValue, BinaryTreeNodeEnum(newValue: valueForInsertion))
            }
        case .node(let l, let currentValue, let r):
            if valueForInsertion < currentValue {
                return .node(l.insert(valueForInsertion: valueForInsertion), currentValue, r)
            }
            else {
                return .node(l, currentValue, r.insert(valueForInsertion: valueForInsertion))
            }
        }
    }
    
    func search(for value: T) -> BinaryTreeNodeEnum<T>? {
        return nil
    }
}

extension BinaryTreeNodeEnum: CustomStringConvertible {
    var description: String {
        var text: String
        switch self {
        case .leaf(let value):
            text = "\(value)"
        case .empty:
            text = "empty"
        case .node(let left, let value, let right):
            text = "\(value) {\(left.description), \(right.description) } "
        }
        return text
    }
}

var enumTree = BinaryTreeNodeEnum<Int>(newValue: 0)
enumTree = enumTree.insert(valueForInsertion: -1)
enumTree = enumTree.insert(valueForInsertion: 2)
enumTree = enumTree.insert(valueForInsertion: 4)
enumTree = enumTree.insert(valueForInsertion: -2)
enumTree = enumTree.insert(valueForInsertion: 1)
print(enumTree.description)
