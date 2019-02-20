//
//  Episode.swift
//  Westeros
//
//  Created by Victor on 19/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

final class Episode {
    
    // MARK: Properties
    let name: String
    private let _airDate: Date
    weak var season: Season?
    let synopsis: String
    
    // MARK: Initialization
    init(name: String, airDate: Date, synopsis: String = "", season: Season) {
        self.name = name
        _airDate = airDate
        self.synopsis = synopsis
        self.season = season
        
        // Add episode to season
        season.add(episode: self)
    }
}

extension Episode {
    var airDate: String {
        return _airDate.formatted
    }
}

extension Episode {
    var proxyForEquality: String {
        return "\(name) \(_airDate)"
    }
    
    var proxyForComparison: Date {
        return _airDate
    }
}

extension Episode: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Episode: Equatable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Episode: Comparable {
    static func < (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

extension Episode: CustomStringConvertible {
    var description: String {
        return "\(name) \(_airDate)"
    }
}
