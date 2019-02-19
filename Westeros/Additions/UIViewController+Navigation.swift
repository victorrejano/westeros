//
//  UIViewController+Navigation.swift
//  Westeros
//
//  Created by Victor on 06/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func wrappedInNVC() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
}
