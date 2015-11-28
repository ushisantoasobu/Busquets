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

        // do refresh
        Busquets.sharedInstance.removeAll()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // TODO: do test for more Types like UIImage

    func testGet() {
        Busquets.sharedInstance.set("nickname", value: "ushisantoasobu")
        let nickname = Busquets.sharedInstance.get("nickname") as? String
        if let name :String = nickname {
            XCTAssert(name == "ushisantoasobu", "value from get()")
        }
    }

    func testSet() {
        XCTAssert(Busquets.sharedInstance.set("", value: "hoge") == false, "xxxxxxxxxxx")
        XCTAssert(Busquets.sharedInstance.set("hoge", value: "Xavi") == true, "xxxxxxxxxxx")
        XCTAssert(Busquets.sharedInstance.set("hoge", value: "Iniesta") == true, "xxxxxxxxxxx")
    }

    func testHasValue() {
        Busquets.sharedInstance.set("hoge", value: "hoge")
        XCTAssert(Busquets.sharedInstance.hasValue("hoge") == true, "xxxxxxxxx")
        XCTAssert(Busquets.sharedInstance.hasValue("fuga") == false, "xxxxxxxxx")
    }

    func testGetCapacity() {
        XCTAssert(Busquets.sharedInstance.getCapacity() == 10, "xxxxxxxxx")
    }

    func testGetKeys() {
        Busquets.sharedInstance.set("hoge", value: 100)
        Busquets.sharedInstance.set("fuga", value: 200000)
//        XCTAssert(Busquets.sharedInstance.getKeys() == ["hoge", "fuga"], "xxxxxxxxx")
    }

    func testGetValues() {
        Busquets.sharedInstance.set("hoge", value: 100)
        Busquets.sharedInstance.set("fuga", value: 200000)
        // TODO:
//        XCTAssert(Busquets.sharedInstance.getValues() == ([100, 200000] as Array<AnyObject>), "xxxxxxxxx")
    }

    func testRemove() {
        Busquets.sharedInstance.set("hoge", value: 100)
        Busquets.sharedInstance.set("fuga", value: 200)
        Busquets.sharedInstance.remove("hoge")
        XCTAssert(Busquets.sharedInstance.hasValue("hoge") == false, "xxxxxxxxx")
        XCTAssert(Busquets.sharedInstance.hasValue("fuga") == true, "xxxxxxxxx")
        XCTAssert(Busquets.sharedInstance.getCount() == 1, "xxxxxxxxx")
    }

    func testRemoveAll() {
        Busquets.sharedInstance.set("hoge", value: 100)
        Busquets.sharedInstance.set("fuga", value: 200)
        Busquets.sharedInstance.removeAll()
        XCTAssert(Busquets.sharedInstance.hasValue("hoge") == false, "xxxxxxxxx")
        XCTAssert(Busquets.sharedInstance.hasValue("fuga") == false, "xxxxxxxxx")
        XCTAssert(Busquets.sharedInstance.getCount() == 0, "xxxxxxxxx")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

    func testLruAlgorithm() {
        ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"].map { (char) -> Void in
            Busquets.sharedInstance.set(char, value: char)
        }
        ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"].map { (char) -> Void in
            print(Busquets.sharedInstance.get(char))
        }

        Busquets.sharedInstance.set("hoge", value: 100)
        XCTAssert(Busquets.sharedInstance.hasValue("a") == false, "xxxxxxxxx")
        XCTAssert(Busquets.sharedInstance.hasValue("hoge") == true, "xxxxxxxxx")

        XCTAssert(Busquets.sharedInstance.hasValue("c") == true, "xxxxxxxxx")
        print(Busquets.sharedInstance.get("b"))
        Busquets.sharedInstance.set("fuga", value: 200)
        XCTAssert(Busquets.sharedInstance.hasValue("c") == false, "xxxxxxxxx")
        XCTAssert(Busquets.sharedInstance.get("fuga") as! Int == 200, "xxxxxxxxx")

    }

    func testThreadSafe() {
        
    }
    
}
