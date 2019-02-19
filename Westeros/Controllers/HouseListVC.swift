//
//  HouseListVC.swift
//  Westeros
//
//  Created by Victor on 07/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import UIKit

class HouseListViewController: UITableViewController {
    // MARK: Properties
    let model: [House]
    var delegate: HouseListVCDelegate?
    
    init(model: [House]) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for:type(of: self)))
        title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        delegate?.houseListVC(self, didSelectHouse: selectedModel)
        /*
        
        let detailsVC = HouseDetailViewController(model: selectedModel)
        
        navigationController?.pushViewController(detailsVC, animated: true)
         */
    
    }
}

protocol HouseListVCDelegate {
    func houseListVC(_ controller: HouseListViewController, didSelectHouse houseSelected: House)
}
