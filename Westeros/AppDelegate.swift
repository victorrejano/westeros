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
    var tabBarController: UITabBarController!
    var seasonList: SeasonListViewController!
    var houseList: HouseListViewController!
    var seasonDetail: SeasonDetailViewController!
    var houseDetail: HouseDetailViewController!
    var rootViewController: UISplitViewController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .red
        /*
        let houses = Repository.local.houses
        
        let houseListViewController = HouseListViewController(model: houses)
        let houseDetailViewController = HouseDetailViewController(model: houseListViewController.lastHouseSelected())
        
        houseListViewController.delegate = houseDetailViewController
        //houseListViewController.delegate = houseListViewController
 
        let splitVC = UISplitViewController()
        splitVC.viewControllers = [houseListViewController.wrappedInNVC(), houseDetailViewController.wrappedInNVC()]
        */
        // TODO Seasons detail demo
        /*
        // Repository data
        let seasons = Repository.local.seasons
        let seasonListViewController = SeasonListViewController(model: seasons)
        let seasonDetailViewController = SeasonDetailViewController(model: seasons.first!)
        
        // Asign delegate and detail view
        seasonListViewController.delegate = seasonDetailViewController
        //seasonListViewController.seasonDetailViewController = seasonDetailViewController
        
        let splitVC = UISplitViewController()
        splitVC.viewControllers = [seasonListViewController.wrappedInNVC(), seasonDetailViewController.wrappedInNVC()]
        
        let rootVC = splitVC
 
        let season = Repository.local.seasons.first
        let episodeList = EpisodesListViewController(model: season!)*/
        
        // Get data from repository
        let seasons = Repository.local.seasons
        let houses = Repository.local.houses
        
        // Instantiate view controllers
        seasonList = SeasonListViewController(model: seasons)
        houseList = HouseListViewController(model: houses)
        
        tabBarController = UITabBarController()
        tabBarController.viewControllers = [seasonList, houseList]
        
        seasonDetail = SeasonDetailViewController(model: seasons.first!)
        houseDetail = HouseDetailViewController(model: houses.first!)
        
        // Asign delegates
        tabBarController.delegate = self
        seasonList.delegate = seasonDetail
        houseList.delegate = houseDetail
        
        // Add views to root controller
        rootViewController = UISplitViewController()
        rootViewController.viewControllers = [tabBarController.wrappedInNVC(), seasonDetail.wrappedInNVC()]
        
        window?.rootViewController = rootViewController
        
        return true
    }
}

extension AppDelegate: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController == houseList {
            rootViewController.viewControllers = [tabBarController.wrappedInNVC(), houseDetail.wrappedInNVC()]
        } else if viewController == seasonList {
            rootViewController.viewControllers = [
            tabBarController.wrappedInNVC(), seasonDetail.wrappedInNVC()]
        }
    }
    
}

