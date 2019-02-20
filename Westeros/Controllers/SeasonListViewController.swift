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
    var seasonDetailViewController: SeasonDetailViewController?
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
        
        return provideCellFor(indexPath.row)
    }
}

extension SeasonListViewController {
    
    private func provideCellFor(_ row: Int) -> UITableViewCell {
        // Restore cell or create if isn't available
        var cell = tableView.dequeueReusableCell(withIdentifier: SEASON_LIST_CELL)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: SEASON_LIST_CELL)
        }
        
        // Set current item data to cell
        let currentItem = model[row]
        cell!.textLabel!.text = currentItem.name
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Restore selected model
        let selectedModel = model[indexPath.row]
        
        // Inform delegate
        delegate?.didSelectSeason(self, model: selectedModel)
    }
}
