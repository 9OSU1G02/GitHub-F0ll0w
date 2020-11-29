//
//  UIHelpers.swift
//  GitHubF0ll0w
//
//  Created by Nguyen Quoc Huy on 11/28/20.
//

import UIKit

enum UIHelpers {
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        
            let width =  view.bounds.width
            let padding: CGFloat = 12
            let minimumItemSpace: CGFloat = 10
            let availabelWidth =  width - (padding * 2) - (minimumItemSpace * 2)
            let itemWidth = availabelWidth / 3
            
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
            return flowLayout
    }
    
}
