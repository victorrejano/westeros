//
//  House.swift
//  Westeros
//
//  Created by Victor on 31/01/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

typealias Words = String

enum HouseType: String {
    case Stark = "Stark", Lannister = "Lannister", Targaryen = "Targaryen", Baratheon = "Baratheon", Greyjoy = "Greyjoy", Martell = "Martell"
}

final class House {
    typealias Members = Set<Person>
    
    // MARK: Properties
    let name: String
    let sigil: Sigil
    let words: Words
    let wikiURL: URL
    private var _members: Members
    
    // MARK: Initialization
    init(name: String, sigil: Sigil, words: Words, wikiURL: URL) {
        self.name = name
        self.sigil = sigil
        self.words = words
        _members = []
        self.wikiURL = wikiURL
    }
}

extension House {
    
    var count: Int {
        return _members.count
    }
    
    var members: [Person] {
        return _members.sorted()
    }
    
    func add(person: Person) {
        guard person.house == self else { return }
        _members.insert(person)
    }
    
    func add(persons: Person...) {
        persons.forEach {
            add(person: $0)
        }
    }
}


extension House: Equatable {
    static func == (lhs: House, rhs: House) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension House: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension House {
    var proxyForEquality: String {
        return "\(name)\(sigil.description)"
    }
}

extension House: Comparable {
    static func < (lhs: House, rhs: House) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

extension House {
    var proxyForComparison: String {
        return name
    }
}
