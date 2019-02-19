//
//  RepositoryTests.swift
//  WesterosTests
//
//  Created by Victor on 06/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import XCTest
@testable import Westeros

class RepositoryTests: XCTestCase {

    var houses: [House]!
    var house: House!
    
    override func setUp() {
        houses = Repository.local.houses
        house = houses[0]
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalRepositoryExistence() {
        XCTAssertNotNil(Repository.local)
    }
    
    func testLocalRepositoryHousesExistence() {
        XCTAssertNotNil(houses)
    }
    
    func testLocalRepositoryHousesCount() {
        XCTAssertGreaterThan(houses.count, 0)
    }
    
    func testLocalRepositoryHousesSorted() {
        XCTAssertEqual(houses, houses.sorted())
    }

    func testLocalRepositoryHouseByName() {
        let searchHouse = Repository.local.house(named: "stArk")
        XCTAssertNotNil(searchHouse)
        XCTAssertEqual(searchHouse?.name, "Stark")
        
        let secondHouse = Repository.local.house(named: "fsad")
        XCTAssertNil(secondHouse)
    }
    
    func testLocalRepositoryHousesFiltered() {
        let filteredHouses = Repository.local.houses {
            $0.count == 1
        }
        XCTAssertEqual(filteredHouses.count, 1)
    }
    
    func testLocalRepositoryPersonsSorted() {
        XCTAssertEqual(house.members, house.members.sorted())
    }
}
