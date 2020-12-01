//
//  ItemInfoViewController.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/29/20.
//

import UIKit



class ItemInfoViewController: UIViewController {
    
    let stackViewLabel  = UIStackView()
    let stackViewButton = UIStackView()
    let itemInfoViewOne = ItemInfoView()
    let itemInfoViewTwo = ItemInfoView()
    let actionButton    = ActionButton()
    let actionButton2   = ActionButton()
    var user: User!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        layoutUI()
        configureStackView()
        configureActionButton()
    }
    
    
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
    }
    
    
    private func configureStackView() {
        stackViewLabel.axis          = .horizontal
        stackViewLabel.distribution  = .equalSpacing
        stackViewLabel.addArrangedSubview(itemInfoViewOne)
        stackViewLabel.addArrangedSubview(itemInfoViewTwo)
        
        stackViewButton.axis          = .horizontal
        stackViewButton.distribution  = .fillEqually
        stackViewButton.addArrangedSubview(actionButton)
        stackViewButton.addArrangedSubview(actionButton2)
        stackViewButton.spacing = 20
    }
    
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        actionButton2.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped(_ button: UIButton) { }
    
    private func layoutUI() {
        view.addSubviews(stackViewLabel,stackViewButton)
        stackViewLabel.translatesAutoresizingMaskIntoConstraints = false
        stackViewButton.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        
        NSLayoutConstraint.activate([
            stackViewLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackViewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackViewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackViewLabel.heightAnchor.constraint(equalToConstant: 50),
            
            stackViewButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            stackViewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackViewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackViewButton.heightAnchor.constraint(equalToConstant: 44),
            

        ])
    }
}
