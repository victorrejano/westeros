//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by Victor on 05/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var houseNameLabel: UILabel!
    @IBOutlet weak var houseSigilImageView: UIImageView!
    @IBOutlet weak var houseWordsLabel: UILabel!
    
    // MARK: Properties
    var model: House {
        didSet {
            syncModelWithView()
        }
    }
    
    // MARK: Initialization
    init(model: House) {
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
        setupUI()
    }
    
    private func syncModelWithView(){
        houseNameLabel.text = "House \(model.name)"
        houseSigilImageView.image = model.sigil.image
        houseWordsLabel.text = model.words
        
        title = model.name
    }
    
    private func setupUI() {
        // Add bar button
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        
        let membersButton = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))
        
        navigationItem.rightBarButtonItems = [membersButton, wikiButton]
    }
    
    @objc private func displayWiki() {
        let wikiController = WikiViewController(model: model)
        navigationController?.pushViewController(wikiController, animated: true)
    }
    
    @objc private func displayMembers() {
        let membersController = MemberListViewController(model: model.members)
        navigationController?.pushViewController(membersController, animated: true)
    }
}

extension HouseDetailViewController: HouseListViewControllerDelegate {
    func houseListViewController(_ controller: HouseListViewController, didSelectHouse houseSelected: House) {
        self.model = houseSelected
    }
}
