//
//  SearchViewController.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/28/20.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    // MARK: - Properties
    let scrollView = UIScrollView()
    
    let contentView = UIView()
    
    let logo = UIImageView()
    
    let searchTextFiled = TextField()
    
    let getFollowersButton = Button(backgroundColor: .systemGreen, title: "Get Followers")
    let getFollowingButton = Button(backgroundColor: .systemPurple, title: "Get Followings")
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextFiled.delegate = self
        view.backgroundColor = .systemBackground
        layoutUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    private func layoutUI() {
        
        configureScrollView()
        configureLogo()
        configureTextFiled()
        configureButton()
        
    }
    
    
    private func configureScrollView() {
        
        view.addSubview(scrollView)
        scrollView.pinToEdge(of: view)
        
        scrollView.addSubview(contentView)
        contentView.pinToEdge(of: scrollView)
        
        
        NSLayoutConstraint.activate([
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 700),
            
        ])
        
    }
    
    
    private func configureLogo() {
        
        logo.image = Images.logo
        contentView.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80),
            logo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 200),
            logo.heightAnchor.constraint(equalToConstant: 200),
            
        ])
        
    }
    
    
    private func configureTextFiled() {
        
        contentView.addSubview(searchTextFiled)
        
        let padding: CGFloat = 50
        
        NSLayoutConstraint.activate([
            
            searchTextFiled.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            searchTextFiled.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 48),
            searchTextFiled.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            searchTextFiled.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            searchTextFiled.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    
    private func configureButton() {
        
        contentView.addSubviews(getFollowersButton, getFollowingButton)
        
        let padding: CGFloat = 65
        let height: CGFloat = 50
        NSLayoutConstraint.activate([
            
            getFollowingButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            getFollowingButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            getFollowingButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            getFollowingButton.heightAnchor.constraint(equalToConstant: height),
            
            getFollowersButton.bottomAnchor.constraint(equalTo: getFollowingButton.topAnchor, constant: -padding),
            getFollowersButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            getFollowersButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            getFollowersButton.heightAnchor.constraint(equalToConstant: height)
            
        ])
        
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
