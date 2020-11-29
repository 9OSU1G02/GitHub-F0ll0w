//
//  DataLoadingViewController.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/29/20.
//

import UIKit

class DataLoadingViewController: UIViewController {
    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func showLoadingView() {
        
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }
        
        let activitiIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubviews(activitiIndicator)
        
        activitiIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activitiIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activitiIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activitiIndicator.startAnimating()
        
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptySateView(with message: String, in view: UIView) {
        let emptyState = EmptyStateView(frame: .zero)
        emptyState.frame = view.bounds
        view.addSubview(emptyState)
    }
}
