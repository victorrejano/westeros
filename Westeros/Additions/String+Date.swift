//
//  String+Date.swift
//  Westeros
//
//  Created by Victor on 19/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import Foundation

extension String {
    
    var toDate: Date? {
        return toDateWithCustomFormat(FORMAT_TO_PARSE_DATE)
    }
    
    func toDateWithCustomFormat(_ format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: self)
    }
}
