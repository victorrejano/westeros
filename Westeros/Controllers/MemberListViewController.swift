//
//  MemberListViewController.swift
//  Westeros
//
//  Created by Victor on 07/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var model: [Person] {
        didSet {
            tableView.reloadData()
        }
    }
    var memberDetail: MemberDetailViewController!
    
    // MARK: Initialization
    init(model: [Person]) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = "Members"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Setup notification
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self,
                                       selector: #selector(didSelectedHouse(_:)),
                                       name: NSNotification.Name(rawValue: SELECTED_HOUSE_NOTIFICATION),
                                       object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Disable notification observer
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.removeObserver(self)
    }
}

extension MemberListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = model[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "MemberCell")
        }
        
        cell?.textLabel?.text = person.fullName
        cell?.detailTextLabel?.text = person.alias
        
        return cell!
    }
}

extension MemberListViewController {
    @objc private func didSelectedHouse(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
            let house = userInfo[HOUSE_KEY] as? House
            else {
                return
        }
        
        self.model = house.members
    }
}

extension MemberListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Obtain selected member
        let member = model[indexPath.row]
        
        // Push detail view
        if memberDetail == nil {
            memberDetail = MemberDetailViewController(model: member)
            memberDetail.delegate = self
            
            navigationController?.pushViewController(memberDetail!, animated: true)
            return
        }
        
        memberDetail.model = member
        navigationController?.pushViewController(memberDetail, animated: true)
    }
}

extension MemberListViewController: MemberDetailViewControllerDelegate {
    
    func viewWasNotifiedHouseChanged(_ memberDetailViewController: MemberDetailViewController, house: House) {
        
        self.model = house.members
    }
}
