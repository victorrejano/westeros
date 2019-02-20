//
//  EpisodeTests.swift
//  WesterosTests
//
//  Created by Victor on 19/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import XCTest
@testable import Westeros

class EpisodeTests: XCTestCase {
    
    var episode: Episode!
    var season: Season!
    var airDate: Date!
    
    override func setUp() {
        season = Season(name: "Season 6")
        
        // Prepare date for comparison
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        airDate = dateFormatter.date(from: "04-17-2011")
        
        episode = Episode(name: "Battle of bastards", airDate: airDate, season: season)
    }
    
    override func tearDown() {
    }
    
    func testEpisodeExistence() {
        XCTAssertNotNil(episode)
    }
    
    func testEpisodeHashable() {
        XCTAssertNotNil(episode.hashValue)
    }
    
    func testEpisodeEquality() {
        // Identity
        XCTAssertEqual(episode, episode)
        
        // Equality
        let equalEpisode = Episode(name: "Battle of bastards", airDate: airDate, season: season)
        
        XCTAssertEqual(episode, equalEpisode)
        
        // Not equal
        let otherEpisode = Episode(name: "Battle of the BlackWater", airDate: Date(), season: season)
        XCTAssertNotEqual(episode, otherEpisode)
    }
    
    func testEpisodeComparison() {
        
        let newerEpisode = Episode(name: "Absolutely random new episode", airDate: Date(), season: season)
        
        XCTAssertLessThan(episode, newerEpisode)
    }
    
    func testEpisodeDescription() {
        XCTAssertNotNil(episode.description)
    }
}
