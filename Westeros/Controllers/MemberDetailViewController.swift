//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Victor on 24/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import UIKit

protocol MemberDetailViewControllerDelegate: class {
    func viewWasNotifiedHouseChanged(_ memberDetailViewController: MemberDetailViewController, house: House)
}

class MemberDetailViewController: UIViewController {
// MARK: Properties
    var model: Person {
        didSet {
            syncModelWithView()
        }
    }
    var delegate: MemberDetailViewControllerDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var houseSigilImageView: UIImageView!
    @IBOutlet weak var aliasLabel: UILabel!
    
    // MARK: Initialization
    init(model: Person) {
        self.model = model
        super.init(nibName: "MemberDetailViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Member detail"
        syncModelWithView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupObserverForNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserverForNotifications()
    }
}

extension MemberDetailViewController {
    
    private func syncModelWithView() {
        nameLabel.text = model.fullName
        houseNameLabel.text = model.house.name
        houseSigilImageView.image = model.house.sigil.image
        aliasLabel.text = model.alias
    }
}

extension MemberDetailViewController {
    
    private func setupObserverForNotifications() {
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(didSelectHouse), name:  NSNotification.Name(rawValue: SELECTED_HOUSE_NOTIFICATION), object: nil)
    }
    
    private func removeObserverForNotifications() {
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.removeObserver(self)
    }
    
    @objc func didSelectHouse(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
            let houseSelected = userInfo[HOUSE_KEY] as? House else { return }
        
        delegate?.viewWasNotifiedHouseChanged(self, house: houseSelected)
        
        navigationController?.popViewController(animated: true)
    }
}
