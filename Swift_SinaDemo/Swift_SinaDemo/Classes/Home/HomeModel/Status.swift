//
//  Status.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/11.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

class Status: NSObject {
    // MARK:- 属性
    var created_at      :   String?                        // 微博创建时间
    var source          :   String?                        // 微博来源
    var text            :   String?                        // 微博正文
    var mid             :   Int   =   0                    // 微博ID
    var user            :   User?
    var pic_urls        : [[String : String]]?              // 微博图片
    
    
    // MARK:- 将字典转成Model
    init(dic : [String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dic)
        let userDic = dic["user"] as? [String : AnyObject]
        user = User(dict: userDic!)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}











