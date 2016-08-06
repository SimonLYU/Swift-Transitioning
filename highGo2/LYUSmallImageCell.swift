//
//  LYUSmallImageCell.swift
//  highGo2
//
//  Created by 吕旭明 on 16/8/4.
//  Copyright © 2016年 lyu. All rights reserved.
//

import UIKit
import SDWebImage

class LYUSmallImageCell: UICollectionViewCell {
    lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFill
        imageView.frame = self.bounds
        imageView.clipsToBounds = true
        self.addSubview(imageView)
        return imageView
    }()
    var item : LYUItem?{
        didSet{
            guard let url = NSURL(string: item!.q_pic_url) else {
                return
            }
            self.imageView.sd_setImageWithURL(url, placeholderImage: UIImage(named: "empty_picture"))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

