//
//  File.swift
//  CGShop
//
//  Created by Victor Mesquita on 1/14/19.
//  Copyright © 2019 cg. All rights reserved.
//

import Foundation

class InMemoryDb<T> where T: Any {
    var indexedObject = Dictionary<Int, Any>()
    
    func addOrUpdate(id: Int, data: T?) throws -> Void {
        
        if id == 0 {
            throw InMemoryDbError("Id não pode ser zero")
        }
        
        if data == nil {
            throw InMemoryDbError("data não pode ser vazio!")
        }
        
        indexedObject[id] = data
    }
    
    func remove(id: Int) -> Void {
        indexedObject.removeValue(forKey: id)
    }
    
    func get(id: Int) -> T? {
        return indexedObject[id] as? T
    }
    
    func list() -> [T] {
        return Array(indexedObject.values) as! [T]
    }
}

struct InMemoryDbError: Error {
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    public var localizedDescription: String {
        return message
    }
}
