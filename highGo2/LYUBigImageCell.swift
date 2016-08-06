//
//  LYUBigImageCell.swift
//  highGo2
//
//  Created by 吕旭明 on 16/8/4.
//  Copyright © 2016年 lyu. All rights reserved.
//

import UIKit
import SDWebImage

class LYUBigImageCell: UICollectionViewCell {
    
    var item : LYUItem?{
        didSet{
            guard let urlString = item?.z_pic_url else {
                return
            }
            
            guard let url = NSURL(string: urlString) else {
                return
            }
            imageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "empty_picture")) { (image, _ , _ ,_ ) in
                self.imageView.frame = self.getFrameFromImage(image)
            }
        }
    }
    lazy var imageView : UIImageView = {
       let imageView = UIImageView()
        self.addSubview(imageView)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LYUBigImageCell.touchOutSide)))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK:- toucOutSide
extension LYUBigImageCell{
    func touchOutSide() -> Void {
        NSNotificationCenter.defaultCenter().postNotificationName("cancelNotification", object: nil)
    }
}

// MARK:- 添加图片view
extension LYUBigImageCell{
    func setupImageView() -> Void {
        self.imageView.backgroundColor = UIColor.redColor()
        self.addSubview(imageView)
    }
}
// MARK:- 计算imageView尺寸
extension LYUBigImageCell{
    func getFrameFromImage(image : UIImage) -> CGRect {
        let imageW : CGFloat = UIScreen.mainScreen().bounds.width
        let imageH : CGFloat = imageW * image.size.height / image.size.width
        let imageX : CGFloat = 0
        let imageY : CGFloat = (UIScreen.mainScreen().bounds.height - imageH) / 2
        return CGRectMake(imageX, imageY, imageW, imageH)
        
    }
}
// MARK:- layoutSubviews
extension LYUBigImageCell{
    override func layoutSubviews() {
        guard let image = SDWebImageManager.sharedManager().imageCache.imageFromMemoryCacheForKey(item?.z_pic_url) else {
            return
        }
        imageView.frame = getFrameFromImage(image)
    }
}
