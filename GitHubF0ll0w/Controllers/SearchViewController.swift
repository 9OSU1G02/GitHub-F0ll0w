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
    
    let userNameTextFiled = UsernameTextField()
    
    let getFollowersButton = ActionButton(backgroundColor: .systemGreen, title: "Get Followers")
    let getFollowingButton = ActionButton(backgroundColor: .systemPurple, title: "Get Following")
    
    var isUserNameEntered: Bool { return !userNameTextFiled.text!.isEmpty}
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        layoutUI()
        listenForKeyboardNotification()
        setupDismissKeyBoardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        userNameTextFiled.text = ""
    }
    
    
    private func layoutUI() {
        
        view.addSubviews(logo,userNameTextFiled,getFollowersButton,getFollowingButton)
        
        configureLogo()
        configureTextFiled()
        configureButton()
        
    }
    
    // MARK: - Configuration
    
    private func configureLogo() {
        
        logo.image = Images.logo
        
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
        
        userNameTextFiled.delegate = self
        
        
        let padding: CGFloat = 55
        
        NSLayoutConstraint.activate([
            
            userNameTextFiled.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameTextFiled.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: padding),
            userNameTextFiled.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            userNameTextFiled.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            userNameTextFiled.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }
    
    
    private func configureButton() {
        
        getFollowersButton.addTarget(self, action: #selector(pushFollowCollectionVC), for: .touchUpInside)
        getFollowingButton.addTarget(self, action: #selector(pushFollowCollectionVC), for: .touchUpInside)
        
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
        addObservsers(selector: #selector(keyboardWillChange(notification:)),
                      names: UIResponder.keyboardWillShowNotification,
                      UIResponder.keyboardWillHideNotification,
                      UIResponder.keyboardWillChangeFrameNotification,
                      objcect: nil)
    }
    
    // MARK: - Helpers
    
    private func setupDismissKeyBoardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Selectors
    
    @objc func pushFollowCollectionVC(_ button: UIButton) {
        guard isUserNameEntered else {
            return
        }
        
        userNameTextFiled.resignFirstResponder()
        
        let type: FollowType = button == getFollowersButton ? .follower : .following
        
        let follow = FollowListViewController(username: userNameTextFiled.text!, type: type)
        
        navigationController?.pushViewController(follow, animated: true)
        
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
