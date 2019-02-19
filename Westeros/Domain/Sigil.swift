//
//  Sigil.swift
//  Westeros
//
//  Created by Victor on 02/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import UIKit

final class Sigil {
    
    // MARK: Properties
    let description: String
    let image: UIImage
    
    // MARK: Initialization
    init(image: UIImage, description: String) {
        self.image = image
        self.description = description
    }
    
}
