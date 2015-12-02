//
//  Busquets.swift
//  Busquets
//
//  Created by SatoShunsuke on 2015/11/28.
//  Copyright © 2015年 moguraproject. All rights reserved.
//

import Foundation
import UIKit

public class Busquets<T> {

    // MARK: - variables

    private final let capacity = 10

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
        self.updateCacheIndex(index!)
    }

    private func updateCacheIndex(index :Int) {
        let cache = self.caches[index]
        self.caches.removeAtIndex(index)
        self.caches.insert(cache, atIndex: 0)
    }

    private func get(key :String, update :Bool) -> T? {
        for (index, cache) in self.caches.enumerate() {
            if key == cache.key {
                if update {
                    self.updateCacheIndex(index)
                }
                return cache.value
            }
        }
        return nil
    }

    @objc private func clearMemoryCache() {
        self.removeAll()
    }

    // MARK: - public

    public init() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "clearMemoryCache",
            name: UIApplicationDidReceiveMemoryWarningNotification, object: nil)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    public func get(key :String) -> T? {
        return self.get(key, update: true)
    }

    public func set(key :String, value :T) -> Bool {
        // validate key
        if key.isEmpty {
            return false
        }

        self.lock.lock()
        // validate existing
        if let index = self.getIndex(key) {
            self.updateCacheIndex(index)
            self.lock.unlock()
            return true
        }

        let cache = Cache(key: key, value: value)

        if self.caches.count == self.capacity {
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
        for (index, cache) in self.caches.enumerate() {
            if key == cache.key {
                self.caches.removeAtIndex(index)
                return
            }
        }
    }

    public func removeAll() {
        self.caches.removeAll(keepCapacity: false)
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
