//
//  Repository.swift
//  Westeros
//
//  Created by Victor on 06/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import UIKit

final class Repository {
    static let local = LocalFactory()
}

final class LocalFactory: HouseFactory {
    
    typealias Filter = (House) -> Bool
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
    
    func houses(filteredBy filter: Filter) -> [House] {
        return houses.filter(filter)
    }
    
}

protocol HouseFactory {
    var houses: [House] { get }
    
    func house(named: String) -> House?
}
