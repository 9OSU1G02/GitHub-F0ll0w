//
//  SearchViewController.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/28/20.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    // MARK: - Properties
   
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
        listenForKeyboardNotification()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    private func layoutUI() {
        
        configureLogo()
        configureTextFiled()
        configureButton()
        
    }
    
    private func configureLogo() {
        
        logo.image = Images.logo
        view.addSubview(logo)
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhoneSE2nd || DeviceTypes.isiPhone8Zoomed ? 20 : 90
        NSLayoutConstraint.activate([
            
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 200),
            logo.heightAnchor.constraint(equalToConstant: 200),
            
        ])
        
    }
    
    
    private func configureTextFiled() {
        
        view.addSubview(searchTextFiled)
        
        let padding: CGFloat = 50
        
        NSLayoutConstraint.activate([
            
            searchTextFiled.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchTextFiled.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 48),
            searchTextFiled.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            searchTextFiled.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            searchTextFiled.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    
    private func configureButton() {
        
        view.addSubviews(getFollowersButton, getFollowingButton)
        
        let padding: CGFloat = 60
        let height: CGFloat = 50
        NSLayoutConstraint.activate([
            
            getFollowingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            getFollowingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            getFollowingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            getFollowingButton.heightAnchor.constraint(equalToConstant: height),
            
            getFollowersButton.bottomAnchor.constraint(equalTo: getFollowingButton.topAnchor, constant: -padding),
            getFollowersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            getFollowersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            getFollowersButton.heightAnchor.constraint(equalToConstant: height)
            
        ])
        
    }
    
    
    
    private func listenForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    
    @objc func keyboardWillChange(notification: Notification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -keyboardSize.height
        }
        else {
            view.frame.origin.y = 0
        }
        
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
