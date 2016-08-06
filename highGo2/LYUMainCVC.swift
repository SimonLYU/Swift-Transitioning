//
//  LYUMainCVC.swift
//  highGo2
//
//  Created by 吕旭明 on 16/8/4.
//  Copyright © 2016年 lyu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class LYUMainCVC: UICollectionViewController {
    
    
    lazy var animater = LYUTransitionAnimater.shareAnimater
    let smallImageCell = "smallImageCell"
    lazy var items = [LYUItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData()
    }

}

// MARK:- loadData
extension LYUMainCVC {
    func loadData() -> Void {
        let offset = items.count
        let httpTool = LYUHttpTools.shareHTTPTool
        httpTool.LYUGet("http://mobapi.meilishuo.com/2.0/twitter/popular.json?offset=\(offset)&limit=30&access_token=b92e0c6fd3ca919d3e7547d446d9a8c2") { (dataArray, error) in
            guard let dataArray = dataArray else {
                return
            }
            for dic in dataArray {
                let item = LYUItem(dic: dic)
                self.items.append(item)
            }
            self.collectionView?.reloadData()
        }
    }
}

// MARK:- setup
extension LYUMainCVC{
    func setup (){
        self.collectionView?.registerClass(LYUSmallImageCell.self, forCellWithReuseIdentifier: smallImageCell)
    }
}
// MARK:- data source
extension LYUMainCVC{
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
            return 1
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(smallImageCell, forIndexPath: indexPath) as? LYUSmallImageCell
        let item = items[indexPath.item]
        cell?.item = item
        if indexPath.item == items.count - 1 {
            loadData()
        }
        return cell!
    }
}

// MARK:- collectionViewDelegate 
extension LYUMainCVC{
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let browserVC = LYUBrowserVC()
        browserVC.indexPath = indexPath
        browserVC.items = items
        browserVC.modalPresentationStyle = .Custom
        browserVC.transitioningDelegate = animater
        animater.presentDelegate = self
        animater.dismissDelegate = browserVC
        animater.indexPath = indexPath
        self.presentViewController(browserVC, animated: true, completion: nil)
    }
}

// MARK:- presentAnimationDelegate
extension LYUMainCVC : LYUPresentAnimationDelegate {
    func getImageView(indexPath: NSIndexPath) -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .ScaleAspectFill
        let cell = collectionView?.cellForItemAtIndexPath(indexPath) as! LYUSmallImageCell
        imageView.image = cell.imageView.image
        return imageView
    }
    func getStartRect(indexPath: NSIndexPath) -> CGRect {
        guard let cell = collectionView?.cellForItemAtIndexPath(indexPath) else {
            return CGRectZero
        }
        let startRect = collectionView?.convertRect(cell.frame, toCoordinateSpace: UIApplication.sharedApplication().keyWindow!)
        return startRect!
    }
    func getEndRect(indexPath: NSIndexPath) -> CGRect {
        guard let cell = collectionView?.cellForItemAtIndexPath(indexPath) as? LYUSmallImageCell else {
            return CGRectZero
        }
        let image = cell.imageView.image!
        let w = UIScreen.mainScreen().bounds.width
        let h = w * image.size.height / image.size.width
        let x : CGFloat = 0.0
        let y : CGFloat = (UIScreen.mainScreen().bounds.height - h ) * 0.5
        return CGRectMake(x, y, w, h)
    }
    
}
