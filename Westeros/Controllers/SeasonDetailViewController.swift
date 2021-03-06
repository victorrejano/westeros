//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Victor on 20/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {

    // MARK: Properties
    var model: Season!
    
    // MARK: - Outlets
    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var finaleDateLabel: UILabel!
    
    
    // MARK: Initialization
    init(model: Season) {
        self.model = model
        super.init(nibName: "SeasonDetailViewController", bundle: Bundle(for: type(of: self)))
        title = "Season Detail"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
    }
    
    private func syncModelWithView() {
        seasonNameLabel.text = model.name
        releaseDateLabel.text = model.releaseDate
        finaleDateLabel.text = model.finaleDate
    }
     
    private func setupUI() {
        // Setup barbutton
        let episodesBarButton = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        
        // add to bar
        navigationItem.rightBarButtonItem = episodesBarButton
    }

}

extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func didSelectSeason(_ controller: SeasonListViewController, model: Season) {
        
        self.model = model
        syncModelWithView()
    }
}

extension SeasonDetailViewController {
    @objc func displayEpisodes() {
        
        let episodesList = EpisodesListViewController(model: model)

        episodesList.model = model
        navigationController?.pushViewController(episodesList, animated: true)
    }
}
