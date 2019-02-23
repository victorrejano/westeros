//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Victor on 20/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import UIKit

protocol SeasonListViewControllerDelegate: class {
    func didSelectSeason(_ controller: SeasonListViewController, model: Season)
}

class SeasonListViewController: UITableViewController {
    
    // MARK: Properties
    let model: [Season]
    weak var delegate: SeasonListViewControllerDelegate?
    
    // MARK: Initialization
    init(model: [Season]) {
        self.model = model
        super.init(nibName: "SeasonListViewController", bundle: Bundle(for: type(of: self)))
        title = "Seasons"
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
        // Obtaining item
        let item = model[indexPath.row]
        
        return provideCellFor(season: item)
    }
}

extension SeasonListViewController {
    
    private func provideCellFor(season item: Season) -> UITableViewCell {
        // Restore cell or create if isn't available
        var cell = tableView.dequeueReusableCell(withIdentifier: SEASON_LIST_CELL)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: SEASON_LIST_CELL)
        }
        
        // Set current item data to cell
        cell!.textLabel!.text = item.name
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Restore selected model
        let selectedModel = model[indexPath.row]
        
        // Inform delegate
        delegate?.didSelectSeason(self, model: selectedModel)
        
        // notify event
        notifyDidSelectSeason(selected: selectedModel)
    }
    
    private func notifyDidSelectSeason(selected: Season) {
        
        let notificationCenter = NotificationCenter.default
        let userInfo = [SEASON_KEY:selected]
        
        let notification = Notification(name: Notification.Name(rawValue: SELECTED_SEASON_NOTIFICATION), object: self, userInfo: userInfo)
        notificationCenter.post(notification)
    }
}
