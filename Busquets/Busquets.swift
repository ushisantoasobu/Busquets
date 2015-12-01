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

    private final let capacity = 10

    private var caches = Dictionary<String, Cache<T>>()

    private let lock = NSLock()

    // MARK: - private

    private func removeLastIndex() {
        for (key, value) in self.caches {
            if value.index == 10 {
                self.caches.removeValueForKey(key)
                return
            }
        }
    }

    private func updateIndex(key :String) {
        let targetCache = self.caches[key]
        if targetCache == nil {
            return
        }
        let targetIndex = targetCache?.index
        for (akey, value) in self.caches {
            if value.index < targetIndex {
                self.caches[akey]?.index++
            }
        }
        targetCache?.index = 1
    }

    // MARK: - public

    public init() {
        //
    }

    public func get(key :String) -> T? {
        self.updateIndex(key)
        return self.caches[key]?.value
    }

    public func set(key :String, value :T) -> Bool {
        // validate key
        if key.characters.count == 0 {
            return false
        }

        self.lock.lock()
        // validate existing
        if self.caches[key] != nil {
            self.updateIndex(key)
            self.lock.unlock()
            return true
        }

        let count = self.caches.count

        let cache = Cache(value: value)
        cache.index = 1

        if count == 10 {
            self.removeLastIndex()
        }

        for (_, value) in self.caches {
            value.index++
        }

        self.caches[key] = cache
        self.lock.unlock()
        return true
    }

    public func hasValue(key :String) -> Bool {
        return (self.caches[key] != nil)
    }

    public func getCapacity() -> Int {
        return self.capacity
    }

    public func getCount() -> Int {
        return self.caches.count
    }

    public func getKeys() -> Array<String> {
        var keys = Array<String>()
        keys = self.caches.map { (key :String, _ :Cache<T>) -> String in
            return key
        }
        return keys
    }

    public func getValues() -> Array<T> {
        var values = Array<T>()
        values = self.caches.map { (_, cache :Cache<T>) -> T in
            return cache.value
        }
        return values
    }

    public func remove(key :String) {
        if self.caches[key] == nil {
            return
        }
        let targetIndex = self.caches[key]?.index
        for (key, value) in self.caches {
            if value.index > targetIndex {
                self.caches[key]?.index--
            }
        }
        self.caches.removeValueForKey(key)
    }

    public func removeAll() {
        self.caches.removeAll(keepCapacity: false)
    }
}

class Cache<T> {
    var value :T
    var index = 0

    init(value :T) {
        self.value = value
    }
}
