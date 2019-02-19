//
//  SigilTests.swift
//  WesterosTests
//
//  Created by Victor on 02/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import XCTest
@testable import Westeros

class SigilTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSigilExistence() {
        let starkSigil = Sigil(image: UIImage(), description: "Huargo")
        XCTAssertNotNil(starkSigil)
    }

}
