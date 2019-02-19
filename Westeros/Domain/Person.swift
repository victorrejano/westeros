//
//  Character.swift
//  Westeros
//
//  Created by Victor on 02/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

final class Person {
    
    // MARK: Properties
    let name: String
    private let _alias: String?
    let house: House
    
    var alias: String {
        return _alias ?? ""
    }
    
    // MARK: Initialization
    init(name: String, alias: String?, house: House) {
        self.name = name
        _alias = alias
        self.house = house
    }
    
    convenience init(name: String, house: House) {
        self.init(name: name, alias: nil, house: house)    }
}

extension Person {
    var fullName: String {
        return "\(name) \(house.name)"
    }
}

extension Person {
    var proxyForEquality: String {
        return "\(name)\(fullName)\(house.name)"
    }
    var proxyForComparison: String {
        return fullName
    }
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Person: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Person: Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}
