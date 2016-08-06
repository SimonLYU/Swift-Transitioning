//
//  LYUBigImageFlowLayout.swift
//  highGo2
//
//  Created by 吕旭明 on 16/8/4.
//  Copyright © 2016年 lyu. All rights reserved.
//

import UIKit

class LYUBigImageFlowLayout: UICollectionViewFlowLayout {

    override func prepareLayout() {
        itemSize = UIScreen.mainScreen().bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .Horizontal
        collectionView?.pagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
    
}
