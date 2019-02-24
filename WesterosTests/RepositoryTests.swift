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
    
    // MARK: Properties
    var houses: [House]!
    var house: House!
    var seasons: [Season]!
    var season: Season!
    
    override func setUp() {
        houses = Repository.local.houses
        house = houses.first
        
        seasons = Repository.local.seasons
        season = seasons.first
    }
    
    override func tearDown() {
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
    
    func testLocalRepositorySeasonsExistence() {
        XCTAssertNotNil(season)
    }
    
    func testLocalRepositorySeasonsSorted() {
        XCTAssertGreaterThan(seasons.last!, seasons.first!)
    }
    
    func testLocalRepositorySeasonsFiltered() {
        let filteredSeasons = Repository.local.seasons {
            $0.name == "Season One"
        }
        
        XCTAssertEqual(filteredSeasons.count, 1)
    }
    
    func testLocalRepositoryHouseByNameTypeSafe() {
        
        // Find Stark house
        let starkHouse = Repository.local.house(named: .Stark)
        XCTAssertNotNil(starkHouse)
        
        // Search Baratheon house
        let baratheonHouse = Repository.local.house(named: .Baratheon)
        XCTAssertNil(baratheonHouse)
    }
}
