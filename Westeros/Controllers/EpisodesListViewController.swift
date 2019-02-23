//
//  EpisodesListViewController.swift
//  Westeros
//
//  Created by Victor on 21/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import UIKit

class EpisodesListViewController: UITableViewController {
    // MARK: Properties
    var model: Season {
        didSet {
            syncModelWithView()
        }
    }
    var episodes: [Episode] {
        return model.episodes
    }
    
    var episodeDetail: EpisodeDetailViewController?
    
    // MARK: Initialization
    init(model: Season) {
        self.model = model
        super.init(nibName: "EpisodesListViewController", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        syncModelWithView()
        setupObserverForNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeObserverForNotifications()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get current episode
        let episode = episodes[indexPath.row]
        
        // Push detail view
        // Instantiate if isn't initialized yet
        if episodeDetail == nil {
            episodeDetail = EpisodeDetailViewController(model: episode)
            episodeDetail?.delegate = self
            navigationController?.pushViewController(episodeDetail!, animated: true)
            return
        }
        
        episodeDetail?.model = episode
        navigationController?.pushViewController(episodeDetail!, animated: true)
    }
}

extension EpisodesListViewController {
    
    private func syncModelWithView() {
        title = "\(model.name) episodes"
        tableView.reloadData()
    }
}

extension EpisodesListViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Current item
        let item = episodes[indexPath.row]
        
        return provideCellFor(episode: item)
        
    }
    
    private func provideCellFor(episode item: Episode) -> UITableViewCell {
        
        // Obtaining cell
        var cell = tableView.dequeueReusableCell(withIdentifier: EPISODE_LIST_CELL)
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: EPISODE_LIST_CELL)
        }
        
        cell!.textLabel!.text = item.name
        
        return cell!
    }
}

extension EpisodesListViewController {
    
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
        
        model = seasonSelected
    }
}

extension EpisodesListViewController: EpisodeDetailViewControllerDelegate {
    func viewWasNotifiedSeasonChanged(_ episodeDetailViewController: EpisodeDetailViewController, season: Season) {
        
        model = season
    }
}
