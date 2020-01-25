//
//  UICollectionViewFlowLayout+Extension.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/25/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

extension UICollectionViewFlowLayout {
    
    func setEdgeInsets(to edgeInset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
    }
}
