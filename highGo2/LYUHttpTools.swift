//
//  LYUHttpTools.swift
//  highGo2
//
//  Created by 吕旭明 on 16/8/4.
//  Copyright © 2016年 lyu. All rights reserved.
//

import UIKit
import AFNetworking

class LYUHttpTools: AFHTTPSessionManager {
    
    static let shareHTTPTool : LYUHttpTools = {
        let shareHTTPTool = LYUHttpTools()
        shareHTTPTool.responseSerializer.acceptableContentTypes?.insert("text/html")
        return shareHTTPTool
    }()
    
    func LYUGet(urlString : String , completeHandle : (dataArray : [[String : NSObject]]? , error : NSError?) -> ()) -> Void {
        GET(urlString, parameters: nil, progress: nil, success: { (_, responseData) in
            guard let responseData = responseData as? [String : NSObject] else {
                return
            }
            guard let dataArray = responseData["data"] as? [[String : NSObject]] else {
                return
            }
            completeHandle(dataArray: dataArray, error: nil)
            
//            print(dataArray)
//            print(responseData)
            }) { (_, error) in
                completeHandle(dataArray: nil, error: error)
//                print(error)
                
        }
    }

}
