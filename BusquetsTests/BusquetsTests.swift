//
//  BusquetsTests.swift
//  BusquetsTests
//
//  Created by SatoShunsuke on 2015/11/28.
//  Copyright © 2015年 moguraproject. All rights reserved.
//

import XCTest
@testable import Busquets

class BusquetsTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // MARK: - test cases

    func testGet() {
        // String
        let stringCache = Busquets<String>()
        stringCache.set("nickname", value: "ushisantoasobu")
        XCTAssert(stringCache.get("nickname") == "ushisantoasobu", "get func works fine")
        XCTAssert(stringCache.get("age") == nil, "get nil if not exists")

        // Int
        let intCache = Busquets<Int>()
        intCache.set("age", value: 24)
        XCTAssert(intCache.get("nickname") == nil, "get nil if not exists")
        XCTAssert(intCache.get("age") == 24, "get func works fine")
    }

    func testSet() {
        let cache = Busquets<String>()
        XCTAssert(cache.set("", value: "hoge") == false, "0 chars key is invalid")
        XCTAssert(cache.set("hoge", value: "hoge") == true, "set func works fine")
    }

    func testHasValue() {
        let cache = Busquets<String>()
        cache.set("hoge", value: "hoge")
        XCTAssert(cache.hasValue("hoge") == true, "hasValue func works fine")
        XCTAssert(cache.hasValue("fuga") == false, "get false if not exists")
    }

    func testGetCapacity() {
        let cache = Busquets<String>()
        XCTAssert(cache.getCapacity() == 10, "getCapacity func works fine")
    }

    func testGetKeys() {
        let cache = Busquets<Int>()
        cache.set("hoge", value: 100)
        cache.set("fuga", value: 200000)
        XCTAssert(cache.getKeys() == ["fuga", "hoge"], "getKeys func works fine")
    }

    func testGetValues() {
        let cache = Busquets<Int>()
        cache.set("hoge", value: 100)
        cache.set("fuga", value: 200000)
        XCTAssert(cache.getValues() == [200000, 100], "getValues func works fine")
    }

    func testRemove() {
        let cache = Busquets<Int>()
        cache.set("hoge", value: 100)
        cache.set("fuga", value: 200)
        cache.remove("hoge")
        XCTAssert(cache.hasValue("hoge") == false, "get false after removed")
        XCTAssert(cache.hasValue("fuga") == true, "get true without removed")
        XCTAssert(cache.getCount() == 1, "get correct cache count after removed")
    }

    func testRemoveAll() {
        let cache = Busquets<Int>()
        cache.set("hoge", value: 100)
        cache.set("fuga", value: 200)
        cache.removeAll()
        XCTAssert(cache.hasValue("hoge") == false, "get false after all removed")
        XCTAssert(cache.hasValue("fuga") == false, "get false after all removed")
        XCTAssert(cache.getCount() == 0, "get 0 count after all removed")
    }


    func testLruAlgorithm() {
        let cache = Busquets<String>()
        ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"].forEach { (char) -> Void in
            cache.set(char, value: char)
        }

        cache.set("hoge", value: "hoge")
        XCTAssert(cache.hasValue("a") == false, "get false for removed cache due to capacity over")
        XCTAssert(cache.hasValue("hoge") == true, "get true for cache exists")

        print(cache.get("b"))
        cache.set("fuga", value: "fuga")
        XCTAssert(cache.hasValue("b") == true, "get true for cache exists due to recently used")
        XCTAssert(cache.hasValue("c") == false, "get false for removed cache due to capacity over")
        XCTAssert(cache.get("fuga") == "fuga", "get true for cache exists")
        XCTAssert(cache.getValues() == ["fuga", "b", "hoge", "j", "i", "h", "g", "f", "e", "d"], "get correct values as lru works fine")
    }

    // MARK: - performance test

    func testPerformanceGetAndSetRepeat() {
        self.measureBlock {
            let cache = Busquets<String>()
            var string = ""
            for _ in 1...100000 {
                cache.set("hoge", value: "hoge")
                cache.set("fuga", value: "fuga")
                string = cache.get("hoge")!
                string = cache.get("fuga")!
            }
            print(string)
        }
    }

}
