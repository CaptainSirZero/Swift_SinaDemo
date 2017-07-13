//
//  UserAccount.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/11.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit
import Foundation

class UserAccount: NSObject ,NSCoding{
    
    // 授权AccessToken
    var access_token : String?
    // 过期时间-->秒
    var expires_in   : TimeInterval = 0.0 {
        didSet {
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    var expires_date : NSDate?
    // 用户ID
    var uid          : String?
    /// 新浪用户昵称
    var screen_name  : String?
    /// 用户头像
    var avatar_large : String?
    
    
    // MARK:- 自定义构造函数,如果没有重写某个方法,直接写构造函数,则相当于将系统提供的构造函数放弃,直接使用构造函数
    init(dic : [String : AnyObject]) {
        super.init()
        
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    // MARK:- 重写description属性
    override var description: String {
        return dictionaryWithValues(forKeys: ["access_token", "expires_date", "uid", "screen_name", "avatar_large"]).description
    }
    // debugDescription 这个需要再LLDB上,使用po 打印的结果
    //    override var debugDescription: String {
    //        return dictionaryWithValues(forKeys: ["access_token", "expires_in", "uid"]).debugDescription
    //    }
    
    
    // 解档
    required init?(coder aDecoder: NSCoder) {
//        super.init()
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? NSDate
        uid = aDecoder.decodeObject(forKey: "uid") as? String
    }
    
    // 归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(avatar_large, forKey: "avatar_large")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_date, forKey: "expires_date")
    }
}





