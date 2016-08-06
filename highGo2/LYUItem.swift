//
//  LYUItem.swift
//  highGo2
//
//  Created by 吕旭明 on 16/8/4.
//  Copyright © 2016年 lyu. All rights reserved.
//

import UIKit

class LYUItem: NSObject {
    
    var z_pic_url = ""
    var q_pic_url = ""
    
    init(dic : [String : NSObject]){
        super.init()
        setValuesForKeysWithDictionary(dic)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    

}
