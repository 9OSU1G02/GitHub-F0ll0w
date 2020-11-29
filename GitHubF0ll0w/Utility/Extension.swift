//
//  Extension.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/28/20.
//

import UIKit

// MARK: - UIView
extension UIView {
    
    func pinToEdge(of view: UIView) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
    }
    
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
}

extension UIViewController {
    func addObservsers(selector: Selector,names: NSNotification.Name..., objcect: Any?) {
        for name in names {
            NotificationCenter.default.addObserver(self, selector: selector, name: name, object: objcect)
        }
    }
}

