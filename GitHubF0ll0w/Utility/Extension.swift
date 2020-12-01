//
//  Extension.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/28/20.
//

import UIKit
import SafariServices
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

// MARK: - UIViewController
extension UIViewController {
    
    func addObservsers(selector: Selector,names: NSNotification.Name..., objcect: Any?) {
        for name in names {
            NotificationCenter.default.addObserver(self, selector: selector, name: name, object: objcect)
        }
    }
    
    func removeObservers(names: NSNotification.Name..., objcect: Any?) {
        for name in names {
            NotificationCenter.default.removeObserver(self, name: name, object: objcect)
        }
    }
    
    func  presentAlertOnMainThread(title: String, message: String, buttonTile: String) {
        DispatchQueue.main.async {
            let alertVC = AlertViewController(title: title, message: message, buttonTitle: buttonTile)
            alertVC.modalPresentationStyle = .pageSheet
            //When User click Ok view will slowly dissolve not instant disappear
            alertVC.modalTransitionStyle = .coverVertical
            //like push when in navigation
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func presentSafariVC(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true, completion: nil)
    }
}

// MARK: - Date
extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "us_EN")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Jakarta")
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}

// MARK: - UITableView
extension UITableView {
    //Remove blank row in table view
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
