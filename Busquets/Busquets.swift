//
//  Busquets.swift
//  Busquets
//
//  Created by SatoShunsuke on 2015/11/28.
//  Copyright © 2015年 moguraproject. All rights reserved.
//

import Foundation

public class Busquets<T> {

    // MARK: - variables

    private let capacity = 10

    private var caches :Array<Cache<T>> = []

    private let lock = NSLock()

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

    private func get(key :String, update :Bool) -> T? {
        var caches :Array<Cache<T>>? = nil
        caches = self.caches.filter { (cache :Cache<T>) -> Bool in
            key == cache.key
        }
        if caches != nil && caches!.count > 0 {
            if update {
                self.updateCacheIndex(caches![0].key)
            }
            return caches![0].value
        }
        return nil
    }

    // MARK: - public

    public init() {
        //
    }

    public func get(key :String) -> T? {
        return self.get(key, update: true)
    }

    public func set(key :String, value :T) -> Bool {
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
        keys = self.caches.map { (cache :Cache<T>) -> String in
            return cache.key
        }
        return keys
    }

    public func getValues() -> Array<T> {
        var values = Array<T>()
        values = self.caches.map { (cache :Cache<T>) -> T in
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

class Cache<T> {
    var key :String = ""
    var value :T

    init(key :String, value :T) {
        self.key = key
        self.value = value
    }
}
