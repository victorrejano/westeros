//
//  Season.swift
//  Westeros
//
//  Created by Victor on 19/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

typealias Episodes = Set<Episode>

final class Season {
    
    // MARK: Properties
    let name: String
    private var _episodes: Episodes
    
    // MARK: Initialization
    init(name: String) {
        self.name = name
        _episodes = []
    }
}

extension Season {
    
    private var  _releaseDate: Date {
        return episodes.first?.airDate.toDate ?? Date()
    }
    var releaseDate: String {
        return _releaseDate.formatted
    }
    
    private var  _finaleDate: Date {
        return episodes.last?.airDate.toDate ?? Date()
    }
    var finaleDate: String {
        return _finaleDate.formatted
    }
    
    var episodes: [Episode] {
        return _episodes.sorted()
    }
    
    var numberOfEpisodes: Int {
        return _episodes.count
    }
    
    func add(episode: Episode) {
        guard let season = episode.season,
            season == self
            else { return }
        
        _episodes.insert(episode)
    }
    
    func add(episodes: Episode...) {
        episodes.forEach {
            add(episode: $0)
        }
    }
}

extension Season {
    var proxyForEquality: String {
        return "\(name) \(releaseDate)"
    }
    
    var proxyForComparison: Date {
        return _releaseDate
    }
}

extension Season: Equatable {
    static func == (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForEquality == rhs.proxyForEquality
    }
}

extension Season: Hashable {
    var hashValue: Int {
        return proxyForEquality.hashValue
    }
}

extension Season: Comparable {
    static func < (lhs: Season, rhs: Season) -> Bool {
        return lhs.proxyForComparison < rhs.proxyForComparison
    }
}

extension Season: CustomStringConvertible {
    var description: String {
        return "\(name) \(releaseDate)"
    }
}
