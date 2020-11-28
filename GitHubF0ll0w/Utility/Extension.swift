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
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
    }
    
    
    func addSubviews(_ views: UIView...) {
        
        for view in views {
            addSubview(view)
        }
        
    }
    
}
