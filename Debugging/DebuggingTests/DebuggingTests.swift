//
//  DebuggingTests.swift
//  DebuggingTests
//
//  Created by Felix Lin on 11/20/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import XCTest
@testable import Debugging

class DebuggingTests: XCTestCase {
    
    func testHelloWorld() {
        var helloWorld: String?
        
        XCTAssertNil(helloWorld)
        
        helloWorld = "hello world"
        XCTAssertEqual(helloWorld, "hello world")
    }
    
    func testSquareInt() {
        let value = 3
        let squareValue = value.square()
        
        XCTAssertEqual(squareValue, 9)
    }
}
