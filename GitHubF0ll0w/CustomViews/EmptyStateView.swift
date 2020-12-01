//
//  EmptyStateView.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/28/20.
//

import UIKit

class EmptyStateView: UIView {

    // MARK: - Properties
    let messageLabel = TitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(messageLabel,logoImageView)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   convenience init(message: String) {
        // frame: .zero because it's x,y,width,heigh will be set by auto layout later
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    // MARK: - Config
    private func configure() {
        configureLabelImageView()
        configureMessagLabel()
    }
    
    private func configureMessagLabel() {
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhoneSE2nd || DeviceTypes.isiPhoneSE2nd || DeviceTypes.isiPhone8Zoomed ? -80 : -150
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    private func configureLabelImageView() {
        logoImageView.image = Images.placeholder
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let logoBottomConstraint: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhoneSE2nd || DeviceTypes.isiPhone8Zoomed ? 80 : 40
        
        NSLayoutConstraint.activate([
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstraint),
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
        ])
    }
  
}
