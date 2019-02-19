//
//  WikiViewController.swift
//  Westeros
//
//  Created by Victor on 07/02/2019.
//  Copyright © 2019 Victor Rejano. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        syncModelWithView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Setup notification
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(didSelectedHouse), name: NSNotification.Name(rawValue: SELECTED_HOUSE_NOTIFICATION), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Disable notification observer
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    private func syncModelWithView() {
        let request = URLRequest(url: model.wikiURL)
        webView.load(request)
        
        title = "Wiki \(model.name)"
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
}

extension WikiViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let type = navigationAction.navigationType
        switch type {
        case .linkActivated, .formSubmitted:
            decisionHandler(.cancel)
        default:
            decisionHandler(.allow)
        }
    }
}

extension WikiViewController {
    @objc private func didSelectedHouse(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
            let model = userInfo[HOUSE_KEY] as? House else {
                return
        }
        
        self.model = model
    }
}
