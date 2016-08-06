//
//  LYUMainCVCLayout.swift
//  highGo2
//
//  Created by 吕旭明 on 16/8/4.
//  Copyright © 2016年 lyu. All rights reserved.
//

import UIKit

class LYUMainCVCLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        let space : CGFloat = 15
        let itemWH = (UIScreen.mainScreen().bounds.width - 4 * space) / 3
        itemSize = CGSizeMake(itemWH, itemWH)
        minimumLineSpacing = space
        minimumInteritemSpacing = space
        
        scrollDirection = .Vertical
        
        self.collectionView?.contentInset = UIEdgeInsetsMake(space + 64, space, space,space)
    }

}
