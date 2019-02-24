//
//  HouseTests.swift
//  WesterosTests
//
//  Created by Victor on 31/01/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import XCTest
@testable import Westeros

class HouseTests: XCTestCase {
    var starkSigil: Sigil!
    var lannisterSigil: Sigil!
    
    var starkHouse: House!
    var lannisterHouse: House!
    
    var aryaPerson: Person!
    var robbPerson: Person!
    var tyrionPerson: Person!
    var cerseiPerson: Person!
    
    
    
    override func setUp() {
        // Stark
        starkSigil = Sigil(image: UIImage(), description: "Wolf")
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        
        starkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming", wikiURL: starkURL)
        
        aryaPerson = Person(name: "Arya", house: starkHouse)
        robbPerson = Person(name: "Robb", house: starkHouse)
    
        // Lannister
        lannisterSigil = Sigil(image: UIImage(), description: "Lion")
        let lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        lannisterHouse = House(name: "Lannister", sigil: starkSigil, words: "Hear me roar!", wikiURL: lannisterURL)
        
        tyrionPerson = Person(name: "Tyrion", alias: "Half - man", house: lannisterHouse)
        cerseiPerson = Person(name: "Cersei", house: lannisterHouse)
    
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHouseExistence() {
        XCTAssertNotNil(starkHouse)
    }

    func testHouseAddPerson() {
        let mockHouse = House(name: "MockHouse", sigil: starkSigil, words: "", wikiURL: URL(fileURLWithPath: ""))
        
        mockHouse.add(person: aryaPerson)
        XCTAssertEqual(mockHouse.count, 0)
        
        let _ = Person(name: "Mocker", alias: "King of mocks", house: mockHouse)
        XCTAssertEqual(mockHouse.count, 1)
    }
    
    func testHousesAddPerson() {
        starkHouse.add(persons: aryaPerson, robbPerson, tyrionPerson)
        XCTAssertEqual(starkHouse.count, 2)
    }
    
    func testHouseHashable() {
        XCTAssertNotNil(starkHouse.hashValue)
    }
    
    func testHouseEquality(){
        // Identity
        XCTAssertEqual(starkHouse, starkHouse)
        
        // Equality
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let newStarkHouse = House(name: "Stark", sigil: starkSigil, words: "Winter is coming", wikiURL: starkURL)
        XCTAssertEqual(starkHouse, newStarkHouse)
        
        // Not equal
        XCTAssertNotEqual(starkHouse, lannisterHouse)
    }
    
    func testHouseComparable() {
        XCTAssertLessThan(lannisterHouse, starkHouse)
    }
}
