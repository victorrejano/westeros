//
//  CharacterTests.swift
//  WesterosTests
//
//  Created by Victor on 02/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import XCTest
@testable import Westeros

class PersonTests: XCTestCase {
    var house: House!
    var sigil: Sigil!
    var person: Person!
    
    override func setUp() {
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        sigil = Sigil(image: UIImage(), description: "Huargo")
        house = House(name: "Stark", sigil: sigil, words: "Winter is coming", wikiURL: starkURL)
        person = Person(name: "Eddard", alias: "Ned", house: house)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPersonExistence(){
        XCTAssertNotNil(person)
    }

    func testPersonFullName() {
        
        XCTAssertEqual(person.fullName, "Eddard Stark")
    }
    
    func testPersonHashable() {
        XCTAssertNotNil(person.hashValue)
    }
    
    func testPersonEquatable() {
        
        // Identity
        XCTAssertEqual(person, person)
    
        // Equality
        let newEd = Person(name: "Eddard", alias: "Ned", house: house)
        XCTAssertEqual(person, newEd)
        
        // Not equal
        let arya = Person(name: "Arya", house: house)
        XCTAssertNotEqual(person, arya)
    }
    
    func testPersonComparable() {
        let eddard = Person(name: "Eddard", alias: "Ned", house: house)
        let arya = Person(name: "Arya", house: house)
        XCTAssertLessThan(arya, eddard)
    }
}
