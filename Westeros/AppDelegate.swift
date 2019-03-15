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
    // MARK: Properties
    var window: UIWindow?
    var tabBarController: UITabBarController!
    var seasonList: SeasonListViewController!
    var houseList: HouseListViewController!
    var seasonDetail: SeasonDetailViewController!
    var houseDetail: HouseDetailViewController!
    var rootViewController: UISplitViewController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        // Get data from repository
        let seasons = Repository.local.seasons
        let houses = Repository.local.houses
        
        // Instantiate view controllers
        seasonList = SeasonListViewController(model: seasons)
        houseList = HouseListViewController(model: houses)
        
        tabBarController = UITabBarController()
        tabBarController.viewControllers = [seasonList, houseList]
        
        seasonDetail = SeasonDetailViewController(model: defaultSeason)
        houseDetail = HouseDetailViewController(model: defaultHouse)
        
        // Add views to root controller
        rootViewController = UISplitViewController()
        rootViewController.viewControllers = [tabBarController, seasonDetail.wrappedInNVC()]
        
        // Add small screens navigation compatibility
        rootViewController.delegate = self
        rootViewController.preferredDisplayMode = .allVisible
        
        // Check screen
        if UIDevice.current.userInterfaceIdiom != .phone {
            
            tabBarController.delegate = self
            // Asign delegates
            seasonList.delegate = seasonDetail
            houseList.delegate = houseDetail
            
        } else {
            seasonList.delegate = self
            houseList.delegate = self
        }
        
        window?.rootViewController = rootViewController
        
        return true
    }
}



