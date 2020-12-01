//
//  Button.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/28/20.
//

import UIKit

class ActionButton: UIButton {
    
    // MARK: - Inits
    override init(frame: CGRect) {

        super.init(frame: frame)
        config()

    }


    convenience init(backgroundColor: UIColor, title: String) {
        
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Config
    private func config() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)

    }
    
    // MARK: - Helpers
    func set(background: UIColor, title: String) {
        self.backgroundColor = background
        setTitle(title, for: .normal)
    }
    
}
