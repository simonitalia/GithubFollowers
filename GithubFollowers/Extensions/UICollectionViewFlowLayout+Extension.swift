//
//  UICollectionViewFlowLayout+Extension.swift
//  GithubFollowers
//
//  Created by Simon Italia on 1/25/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

extension UICollectionViewFlowLayout {
    
    //set flow layout
    func createCollectionViewFlowLayout(view: UIView) -> UICollectionViewFlowLayout {
        
        //configure width of cells / columns based on 3 column layout
        let numberOfColumns: CGFloat = 3
        
        //set properies to calculate cell width
        let viewWidth = view.bounds.width //CGFloat value
        let edgeInsetsPadding: CGFloat = 12
        let minimumCellSpacing: CGFloat = 10 * 2
            //x2 to account for spacing between first / left most column and middle column, + the last / right most column and middle column (3 columns total)
        
        //calculate cell width
        let availableWidthForCell = viewWidth - (edgeInsetsPadding * 2) - minimumCellSpacing
            //edgeInsets *2 to allow for both left + right edges of screen
        
        //set cell width
        let cellWidth = availableWidthForCell / numberOfColumns
        
        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: edgeInsetsPadding, left: edgeInsetsPadding, bottom: edgeInsetsPadding, right: edgeInsetsPadding)
        layout.sectionInset = layout.setEdgeInsets(to: edgeInsetsPadding) //replaces above line
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth + 40)
        
        return layout
    }
    
    //set edgeInsets
    func setEdgeInsets(to edgeInset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: edgeInset, left: edgeInset, bottom: edgeInset, right: edgeInset)
    }
}
