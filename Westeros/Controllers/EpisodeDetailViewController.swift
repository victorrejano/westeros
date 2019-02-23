//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Victor on 23/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import UIKit

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
}

extension EpisodeDetailViewController {
    
    func syncModelWithView() {
        titleLabel.text = model.name
        synopsisTextView.text = model.synopsis
        releaseDateLabel.text = model.airDate
    }
}
