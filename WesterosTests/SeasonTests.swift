//
//  SeasonTests.swift
//  WesterosTests
//
//  Created by Victor on 19/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import XCTest
@testable import Westeros

class SeasonTests: XCTestCase {
    
    var season: Season!
    var releaseDate: Date!
    
    override func setUp() {
        // Prepare date for comparison
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        releaseDate = dateFormatter.date(from: "04-17-2011")
        
        season = Season(name: "Season 1")
        let _ = Episode(name: "Winter is coming", airDate: "2011-04-01".toDate!, season: season)
    }
    
    override func tearDown() {
    }
    
    func testSeasonExistence() {
        XCTAssertNotNil(season)
    }
    
    func testSeasonInsertEpisode() {
        // mock episodes
        
        let initialNumberOfEpisodes = season.numberOfEpisodes
        
        let episodeOne = Episode(name: "Winter is coming", airDate: Date(), season: season)
        let episodeTwo = Episode(name: "The Kingsroad", airDate: Date(), season: season)
        let otherSeasonEpisode = Episode(name: "The Rains of Castemere", airDate: Date(), season: Season(name: "Season 3"))
        
        season.add(episodes: episodeOne, episodeTwo, otherSeasonEpisode)
        
        // Insert only valid episodes
        XCTAssertEqual(season.numberOfEpisodes - initialNumberOfEpisodes, 2)
    }
    
    func testSeasonHashable() {
        XCTAssertNotNil(season.hashValue)
    }
    
    func testSeasonEquatable() {
        
        // Identity
        XCTAssertEqual(season,season)
        
        // Equality
        let equalSeason = Season(name: "Season 1")
        
        XCTAssertEqual(season, equalSeason)
        
        // Not equals
        let otherSeason = Season(name: "Season 5")
        XCTAssertNotEqual(season, otherSeason)
    }
    
    func testSeasonComparison() {
        
        let newerSeason = Season(name: "Season 8")
        
        XCTAssertLessThan(season, newerSeason)
    }
    
    func testSeasonDescription() {
        XCTAssertNotNil(season.description)
    }
}
