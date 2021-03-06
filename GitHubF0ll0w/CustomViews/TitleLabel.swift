//
//  TitleLabel.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/28/20.
//

import UIKit

class TitleLabel: UILabel {
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        
        self.init(frame: .zero)
        
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Config
    private func configure() {

        translatesAutoresizingMaskIntoConstraints = false

        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail

    }
    
}
