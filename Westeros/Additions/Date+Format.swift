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
        dateFormatter.dateFormat = FORMAT_DATE_TO_SHOW
        
        return dateFormatter.string(from: self)
    }
}
