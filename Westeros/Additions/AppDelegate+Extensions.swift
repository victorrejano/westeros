//
//  AppDelegate+Extensions.swift
//  Westeros
//
//  Created by Victor on 24/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import UIKit

extension AppDelegate: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if viewController == houseList {
            rootViewController.showDetailViewController(houseDetail.wrappedInNVC(), sender: self)
        } else if viewController == seasonList {
            rootViewController.showDetailViewController(seasonDetail.wrappedInNVC(), sender: self)
        }
    }
}

extension AppDelegate: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

extension AppDelegate: SeasonListViewControllerDelegate {
    func didSelectSeason(_ controller: SeasonListViewController, model: Season) {
        
        seasonDetail.model = model
        
        controller.navigationController?.pushViewController(seasonDetail, animated: true)
    }
    
    
}

extension AppDelegate: HouseListViewControllerDelegate {
    func houseListViewController(_ controller: HouseListViewController, didSelectHouse houseSelected: House) {
        
        houseDetail.model = houseSelected
        
        controller.navigationController?.pushViewController(houseDetail, animated: true)
    }
}

extension AppDelegate {
    var defaultSeason: Season {
        let userDefaults = UserDefaults.standard
        let indexSeason = userDefaults.integer(forKey: LAST_SEASON_KEY)
        return Repository.local.seasons[indexSeason]
    }
    
    var defaultHouse: House {
        let userDefaults = UserDefaults.standard
        let indexHouse = userDefaults.integer(forKey: LAST_HOUSE_KEY)
        return Repository.local.houses[indexHouse]
    }
}
