//
//  TextField.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/28/20.
//

import UIKit

class TextField: UITextField {
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func config() {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray.cgColor
        layer.cornerRadius = 10
        
        textAlignment = .center
        textColor = .label
        tintColor = .label
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        placeholder = "Enter a username"
        clearButtonMode = .whileEditing
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .done
        
    }
    
}
