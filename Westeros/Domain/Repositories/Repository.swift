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
        
        let _ = Person(name: "Arya", house: starkHouse)
        let _ = Person(name: "Sansa", house: starkHouse)
        let _ = Person(name: "Cersei", house: lannisterHouse)
        let _ = Person(name: "Jaime", alias: "Kingslayer", house: lannisterHouse)
        let _ = Person(name: "Tyrion", alias: "Gnome", house: lannisterHouse)
        let _ = Person(name: "Daenerys", alias: "Stormborn", house: targaryenHouse)
        
        return [starkHouse, lannisterHouse, targaryenHouse].sorted()
    }
    
    func house(named name: String) -> House? {
        return houses.first { $0.name.capitalized == name.capitalized }
    }
    
    func houses(filteredBy filter: HouseFilter) -> [House] {
        return houses.filter(filter)
    }
    
    func house(named type: HouseType) -> House? {
        return houses.first { $0.name == type.rawValue}
    }
}

extension LocalFactory: SeasonFactory {
    var seasons: [Season] {
        
        let episodesRaw = [
            [
                ("Winter is coming", "2011-04-17", "Lord Stark is troubled by reports from a Night's Watch deserter; King Robert and the Lannisters arrive at Winterfell; Viserys Targaryen forges a new alliance."),
                ("Fire and Blood", "2011-06-19", "A new king rises in the North; a Khaleesi finds new hope.")
            ],
            [
                ("The North Remembers", "2012-04-01", "Tyrion arrives to save Joffrey's crown; Daenerys searches for allies and water in the Red Waste; Jon Snow faces the wilderness beyond the Wall."),
                ("Valar Morghulis", "2012-06-03", "Arya receives a gift from Jaqen; Dany goes to a strange place; Jon proves himself.")
            ],
            [
                ("Valar Dohaeris", "2013-03-31", "Jon is tested by the wildling king; Tyrion asks for his reward; Daenerys sails into Slaver's Bay."),
                ("Mhysa", "2013-06-09", "Joffrey challenges Tywin; Dany waits to see if she is a conqueror or a liberator.")
            ],
            [
                ("Two Swords", "2014-04-06", "King's Landing prepares for a royal wedding; Dany finds the way to Meereen; the Night's Watch braces for a new threat."),
                ("The Children", "2014-06-15", "Dany faces some harsh realities; Tyrion sees the truth of his situation.")
            ],
            [
                ("The Wars to come", "2015-04-12", "Tyrion learns of a conspiracy; Jon is caught between two kings."),
                ("Mothers mercy", "2015-06-14", "Stannis marches; Dany is surrounded by strangers; Cersei seeks forgiveness; Jon is challenged.")
            ],
            [
                ("The Red Woman", "2016-04-24", "Jon Snow is dead; Daenerys meets a strong man; Cersei sees her daughter again."),
                ("The Winds of Winter", "2016-06-26", "Cersei faces a day of reckoning.")
            ],
            [
                ("Dragonstone", "2017-07-16", "Arya makes a lasting impression; the Hound sees a vision; Daenerys comes ashore."),
                ("The Dragon and the Wolf", "2017-08-27", "King's Landing hosts a gathering; Sansa breaks ties.")
            ]
        ]
        
        let seasonsRaw = [
            "Season One",
            "Season Two",
            "Season Three",
            "Season Four",
            "Season Five",
            "Season Six",
            "Season Seven"
        ]
        
        let result = seasonsRaw.map {
            Season(name: $0)
        }
        
        for (index, item) in result.enumerated() {
        
            episodesRaw[index].forEach {
                (name, date, synopsis) in
                Episode(name: name, airDate: date.toDate!, synopsis: synopsis, season: item)
            }
        }
        
        return result.sorted()
    }
    
    func seasons(filteredBy customFilter: SeasonFilter) -> [Season] {
        return seasons.filter(customFilter)
    }
    
}
