//
//  HouseListVC.swift
//  Westeros
//
//  Created by Victor on 07/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import UIKit

protocol HouseListViewControllerDelegate: class {
    func houseListViewController(_ controller: HouseListViewController, didSelectHouse houseSelected: House)
}

class HouseListViewController: UITableViewController {
    // MARK: Properties
    let model: [House]
    weak var delegate: HouseListViewControllerDelegate?
    var detailController: HouseDetailViewController?
    
    // MARK: Initialization
    init(model: [House]) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for:type(of: self)))
        title = "Houses"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let house = model[indexPath.row]
        
        var cell =
            tableView.dequeueReusableCell(withIdentifier: "HouseCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "HouseCell")
        }
        
        cell?.textLabel?.text = house.name
        cell?.detailTextLabel?.text = house.words
        cell?.imageView?.image = house.sigil.image
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedModel = model[indexPath.row]
        
        delegate?.houseListViewController(self, didSelectHouse: selectedModel)
        
        // send notification
        let notificationCenter = NotificationCenter.default
        
        let notification =
            Notification(name: Notification.Name(rawValue: SELECTED_HOUSE_NOTIFICATION),
                         object: self,
                         userInfo: [HOUSE_KEY: selectedModel])
        
        notificationCenter.post(notification)
        
        // save user selection
        saveLastHouseSelected(at: indexPath.row)
    }
}

extension HouseListViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ controller: HouseListViewController, didSelectHouse houseSelected: House) {
        
        if detailController == nil {
            detailController = HouseDetailViewController(model: houseSelected)
            
        } else {
            detailController?.model = houseSelected
        }
        
        navigationController?.pushViewController(detailController!, animated: true)
    }
}

extension HouseListViewController {
    
    private func saveLastHouseSelected(at index: Int) {
        // Save into userDefaults
        let userDefaults = UserDefaults.standard
        userDefaults.set(index, forKey: LAST_HOUSE_KEY)
        userDefaults.synchronize()
    }
    
    func lastHouseSelected() -> House {
        // load from userDefaults
        let userDefaults = UserDefaults.standard
        
        let index = userDefaults.integer(forKey: LAST_HOUSE_KEY)
        
        return house(at: index)
    }
    
    private func house(at index: Int) -> House {
        return model[index]
    }
}
