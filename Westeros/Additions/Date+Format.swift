//
//  Date+Format.swift
//  Westeros
//
//  Created by Victor on 19/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

extension Date {
    var formatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        
        return dateFormatter.string(from: self)
    }
}
