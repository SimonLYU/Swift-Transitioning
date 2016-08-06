//
//  LYUBrowserVC.swift
//  highGo2
//
//  Created by 吕旭明 on 16/8/4.
//  Copyright © 2016年 lyu. All rights reserved.
//

import UIKit

class LYUBrowserVC: UIViewController {
    
    let bigImageCell = "bigImageCell"
    var indexPath : NSIndexPath?
    var items : [LYUItem]?
    var collectionView : UICollectionView = {
        let collection = UICollectionView(frame: CGRectZero, collectionViewLayout: LYUBigImageFlowLayout())
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCollectionView()
        setupButtons()
        self.view.backgroundColor = UIColor.greenColor()
        self.collectionView.scrollToItemAtIndexPath(indexPath!, atScrollPosition: .Left, animated: false)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        cancelButtonClick()
    }
}


// MARK:- setup
extension LYUBrowserVC{
    func setup() -> Void {
        collectionView.registerClass(LYUBigImageCell.self , forCellWithReuseIdentifier: bigImageCell)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LYUBrowserVC.cancelButtonClick), name: "cancelNotification", object: nil)
    }
}

// MARK:- 添加按钮
extension LYUBrowserVC{
    func setupButtons() -> Void {
        let cancelButton = UIButton()
        cancelButton.setTitle("cancel", forState: .Normal)
        cancelButton.addTarget(self, action: #selector(LYUBrowserVC.cancelButtonClick), forControlEvents: .TouchUpInside)
        cancelButton.backgroundColor = UIColor.init(white: 0.3, alpha: 0.3)
        let cancelButtonX : CGFloat = 60
        let cancelButtonY : CGFloat = 600
        let cancelButtonW : CGFloat = 60
        let cancelButtonH : CGFloat = 32
        cancelButton.frame = CGRectMake(cancelButtonX, cancelButtonY, cancelButtonW, cancelButtonH)
        self.view.addSubview(cancelButton)
        let saveButton = UIButton()
        saveButton.setTitle("save", forState: .Normal)
        saveButton.addTarget(self, action: #selector(LYUBrowserVC.saveButtonClick), forControlEvents: .TouchUpInside)
        saveButton.frame = CGRectMake(self.view.bounds.width - cancelButtonW - cancelButtonX, cancelButtonY, cancelButtonW, cancelButtonH)
        saveButton.backgroundColor = UIColor.init(white: 0.3, alpha: 0.3)
        self.view.addSubview(saveButton)
    }
}


// MARK:- 监听点击
extension LYUBrowserVC{
    func cancelButtonClick(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func saveButtonClick(){
        print("saveButtonClick")
        guard let cell = collectionView.visibleCells().first as? LYUBigImageCell else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(cell.imageView.image!, nil, nil, nil)
    }
}

// MARK:- collectionView
extension LYUBrowserVC
{
    func setupCollectionView() -> Void {
        collectionView.frame = self.view.bounds
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
    }
}


// MARK:- data source
extension LYUBrowserVC : UICollectionViewDataSource{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (items?.count)!
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(bigImageCell, forIndexPath: indexPath) as! LYUBigImageCell
        let item = items![indexPath.item]
        cell.item = item
        return cell
    }
}


// MARK:- dismissAnimationDelegate
extension LYUBrowserVC : LYUDismissAnimationDelegate{
    func getIndexPath() -> NSIndexPath {
        let cell = collectionView.visibleCells().first as! LYUBigImageCell
        let indexPath = collectionView.indexPathForCell(cell)
        return indexPath!
    }
    func getImageView() -> UIImageView {
        let cell = collectionView.visibleCells().first as! LYUBigImageCell
        let imageView = UIImageView()
        imageView.image = cell.imageView.image
        imageView.frame = cell.imageView.frame
        imageView.clipsToBounds = true
        imageView.contentMode = .ScaleAspectFill
        return imageView
    }
}