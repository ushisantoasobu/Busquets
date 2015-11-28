//
//  Busquets.swift
//  Busquets
//
//  Created by SatoShunsuke on 2015/11/28.
//  Copyright © 2015年 moguraproject. All rights reserved.
//

class Busquets {

    // MARK: - variables

    private let capacity = 10 // TODO: be mutable in future!!

//    private var list :Array<Dictionary<String, AnyObject>> = []
    private var caches = Dictionary<String, AnyObject>()

    // MARK: - singleton

    class var sharedInstance : Busquets {
        struct Static {
            static let instance : Busquets = Busquets()
        }
        return Static.instance
    }

    // MARK: - private

    private func check() {

    }

    // MARK: - public

    func get(key :String) -> AnyObject? {
        return self.caches[key]
    }

    func set(key :String, value :AnyObject) -> Bool {
        // validate key
        if key.characters.count == 0 {
            return false
        }

        // validate existing
        if self.hasValue(key) == true {
            return true
        }

        if self.caches.count < 10 {
            self.caches.updateValue(value, forKey: key)
        } else {
            //
        }
        return true
    }

    func hasValue(key :String) -> Bool {
        return (self.caches[key] != nil)
    }

    func getCapacity() -> Int {
        return self.capacity
    }

    func getCount() -> Int {
        return self.caches.count
    }

    func getKeys() -> Array<String> {
        var keys = Array<String>()
        self.caches.map { (key, value) -> Void in
            keys.append(key)
        }
        return keys
    }

    func getValues() -> Array<AnyObject> {
        var values = Array<AnyObject>()
        self.caches.map { (key, value) -> Void in
            values.append(value)
        }
        return values
    }

    func remove(key :String) {
        self.caches.removeValueForKey(key)
    }

    func removeAll() {
        self.caches.removeAll(keepCapacity: true) // TODO: keepCapacity
    }
}
