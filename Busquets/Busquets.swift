//
//  Busquets.swift
//  Busquets
//
//  Created by SatoShunsuke on 2015/11/28.
//  Copyright © 2015年 moguraproject. All rights reserved.
//

import Foundation

public class Busquets {

    // MARK: - variables

    private let capacity = 10 // TODO: be mutable in future!!

    private var caches :Array<Cache> = []
//    private var caches = Dictionary<String, AnyObject>()

    private let lock = NSLock()

    // MARK: - singleton

    public class var sharedInstance : Busquets {
        struct Static {
            static let instance : Busquets = Busquets()
        }
        return Static.instance
    }

    // MARK: - private

    private func getIndex(key :String) -> Int? {
        for (index, cache) in self.caches.enumerate() {
            if cache.key == key {
                return index
            }
        }
        return nil
    }

    private func updateCacheIndex(key :String) {
        let index = self.getIndex(key)
        if index == nil {
            return
        }
        let cache = self.caches[index!]
        self.caches.removeAtIndex(index!)
        self.caches.insert(cache, atIndex: 0)
    }

    private func updateCacheIndex(index :Int) {
        //
    }

    // MARK: - public

    public func get(key :String) -> AnyObject? {
        return self.get(key, update: true)
    }

    public func get<T>(key :String, _ type :T.Type) -> T? {
        return self.get(key, update: true) as? T
    }

    public func get(key :String, update :Bool) -> AnyObject? {
        var caches :Array<Cache>? = nil
        caches = self.caches.filter { (cache :Cache) -> Bool in
            key == cache.key
        }
        if caches != nil && caches!.count > 0 {
            if update {
                self.updateCacheIndex(caches![0].key)
            }
            print("cache hit!!!")
            return caches![0].value
        }
        return nil
    }

    public func set(key :String, value :AnyObject) -> Bool {
        // validate key
        if key.characters.count == 0 {
            return false
        }

        self.lock.lock()

        // validate existing
        if self.hasValue(key) == true {
            self.updateCacheIndex(key)
            self.lock.unlock()
            return true
        }

        let cache = Cache(key: key, value: value)

        if self.caches.count == 10 {
            self.caches.removeLast()
        }
        self.caches.insert(cache, atIndex: 0)
        self.lock.unlock()
        return true
    }

    public func hasValue(key :String) -> Bool {
        return (self.get(key, update :false) != nil)
    }

    public func getCapacity() -> Int {
        return self.capacity
    }

    public func getCount() -> Int {
        return self.caches.count
    }

    public func getKeys() -> Array<String> {
        var keys = Array<String>()
        keys = self.caches.map { (cache :Cache) -> String in
            return cache.key
        }
        return keys
    }

    public func getValues() -> Array<AnyObject> {
        var values = Array<AnyObject>()
        values = self.caches.map { (cache :Cache) -> AnyObject in
            return cache.value
        }
        return values
    }

    public func remove(key :String) {
        self.caches.enumerate().map { (index :Int, cache :Cache) -> Void in
            if key == cache.key {
                self.caches.removeAtIndex(index)
                return
            }
        }
    }

    public func removeAll() {
        self.caches.removeAll(keepCapacity: true) // TODO: keepCapacity
    }
}

class Cache {
    var key :String = ""
    var value :AnyObject = ""

    init(key :String, value :AnyObject) {
        self.key = key
        self.value = value
    }
}
