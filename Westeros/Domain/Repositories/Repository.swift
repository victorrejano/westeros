//
//  Repository.swift
//  Westeros
//
//  Created by Victor on 06/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import UIKit

// Factory protocols
protocol HouseFactory {
    var houses: [House] { get }
    
    func house(named: String) -> House?
}

protocol SeasonFactory {
    var seasons: [Season] { get }
    
    func seasons(filteredBy: SeasonFilter) -> [Season]
}

// Typealias helpers
typealias HouseFilter = (House) -> Bool
typealias SeasonFilter = (Season) -> Bool

// Repository class
final class Repository {
    static let local = LocalFactory()
}

// Local factory for repository
final class LocalFactory {}

extension LocalFactory: HouseFactory {
    
    var houses: [House] {
        
        let starkURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Stark")!
        let lannisterURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Lannister")!
        let targaryenURL = URL(string: "https://awoiaf.westeros.org/index.php/House_Targaryen")!
        
        let starkHouse = House(name: "Stark", sigil: Sigil(image: UIImage(named: "codeIsComing")!, description: "Huargo"), words: "Winter is coming", wikiURL: starkURL)
        
        let lannisterHouse = House(name: "Lannister", sigil: Sigil(image: UIImage(named: "lannister")!, description: "Lion"), words: "Hear me roar!", wikiURL: lannisterURL)
        
        let targaryenHouse = House(name: "Targaryen", sigil: Sigil(image: UIImage(named: "targaryenSmall")!, description: "Dragon"), words: "Blood and Fire", wikiURL: targaryenURL)
        
        let arya = Person(name: "Arya", house: starkHouse)
        let sansa = Person(name: "Sansa", house: starkHouse)
        let cersei = Person(name: "Cersei", house: lannisterHouse)
        let jaimie = Person(name: "Jaime", alias: "Kingslayer", house: lannisterHouse)
        let tyrion = Person(name: "Tyrion", alias: "Gnome", house: lannisterHouse)
        let daenerys = Person(name: "Daenerys", alias: "Stormborn", house: targaryenHouse)
        
        starkHouse.add(persons: arya, sansa)
        lannisterHouse.add(persons: cersei, jaimie, tyrion)
        targaryenHouse.add(person: daenerys)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        return houses.first { $0.name.capitalized == name.capitalized }
    }
    
    func houses(filteredBy filter: HouseFilter) -> [House] {
        return houses.filter(filter)
    }
}

extension LocalFactory: SeasonFactory {
    var seasons: [Season] {
        
        let episodesRaw = [
            [
                ("Winter is coming", "2011-04-17"),
                ("Fire and Blood", "2011-06-19")
            ],
            [
                ("The North Remembers", "2012-04-01"),
                ("Valar Morghulis", "2012-06-03")
            ],
            [
                ("Valar Dohaeris", "2013-03-31"),
                ("Mhysa", "2013-06-09")
            ],
            [
                ("Two Swords", "2014-04-06"),
                ("The Children", "2014-06-15")
            ],
            [
                ("The Wars to come", "2015-04-12"),
                ("Mothers mercy", "2015-06-14")
            ],
            [
                ("The Red Woman", "2016-04-24"),
                ("The Winds of Winter", "2016-06-26")
            ],
            [
                ("Dragonstone", "2017-07-16"),
                ("The Dragon and the Wolf", "2017-08-27")
            ]
        ]
        
        let seasonsRaw = [
            ("Season One", "2011-04-17"),
            ("Season Two", "2012-04-01"),
            ("Season Three", "2013-03-31"),
            ("Season Four", "2014-04-06"),
            ("Season Five", "2015-04-12"),
            ("Season Six", "2016-04-24"),
            ("Season Seven", "2017-07-16")
        ]
        
        let result = seasonsRaw.map {
            (name, date) in
            Season(name: name, releaseDate: date.toDate!)
        }
        
        for (index, item) in result.enumerated() {
        
            episodesRaw[index].forEach {
                (name, date) in
                Episode(name: name, airDate: date.toDate!, season: item)
            }
        }
        
        return result
    }
    
    func seasons(filteredBy customFilter: SeasonFilter) -> [Season] {
        return seasons.filter(customFilter)
    }
    
}
