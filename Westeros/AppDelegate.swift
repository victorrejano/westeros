//
//  AppDelegate.swift
//  Westeros
//
//  Created by Victor on 31/01/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .red
        
        let houses = Repository.local.houses
        
        let houseListViewController = HouseListViewController(model: houses)
        let houseDetailViewController = HouseDetailViewController(model: houseListViewController.lastHouseSelected())
        
        houseListViewController.delegate = houseDetailViewController
        //houseListViewController.delegate = houseListViewController
        
        let splitVC = UISplitViewController()
        splitVC.viewControllers = [houseListViewController.wrappedInNVC(), houseDetailViewController.wrappedInNVC()]
        
        let rootVC = splitVC
 
        window?.rootViewController = rootVC
        
        return true
    }
}

