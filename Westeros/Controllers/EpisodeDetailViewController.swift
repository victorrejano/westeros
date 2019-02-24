//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Victor on 23/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import UIKit

protocol EpisodeDetailViewControllerDelegate: class {
    func viewWasNotifiedSeasonChanged(_ episodeDetailViewController: EpisodeDetailViewController, season: Season)
}

class EpisodeDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisTextView: UITextView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    // MARK: Properties
    var model: Episode {
        didSet {
            syncModelWithView()
        }
    }
    var delegate: EpisodeDetailViewControllerDelegate?
    
    // MARK: Initialization
    init(model: Episode) {
        self.model = model
        super.init(nibName: "EpisodeDetailViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode detail"
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

extension EpisodeDetailViewController {
    
    func syncModelWithView() {
        titleLabel.text = model.name
        synopsisTextView.text = model.synopsis
        releaseDateLabel.text = model.airDate
    }
}

extension EpisodeDetailViewController {
    
    private func setupObserverForNotifications() {
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(didSelectSeason), name: NSNotification.Name(rawValue: SELECTED_SEASON_NOTIFICATION), object: nil)
    }
    
    private func removeObserverForNotifications(){
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    @objc private func didSelectSeason(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
            let seasonSelected = userInfo[SEASON_KEY] as? Season else {
                return
        }
        
        delegate?.viewWasNotifiedSeasonChanged(self, season: seasonSelected)
        
        navigationController?.popViewController(animated: true)
    }
}
