//
//  UserAccountTool.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/11.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

class UserAccountViewModel {

    // MARK:- 创建单例
    static let shareIntance : UserAccountViewModel = UserAccountViewModel()
    
    // MARK:- 已创建就获取到对应的归档信息
    init() {
        // 从沙盒路径中读取归档信息
        CBLog(message: accountPath)
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
    }
    
    // MARK:- 定义属性
    var account : UserAccount?
    
    // MARK:- 计算属性
    var accountPath : String {
       return (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as NSString).appendingPathComponent("account.plist")
    }
    
    // MARK:- 是否登录
    var isLogin : Bool {
        if account == nil {
            return false
        }
        guard let expiresDate = account?.expires_date else {
            return false
        }
        return expiresDate.compare(Date()) == ComparisonResult.orderedDescending
    }
}

// MARK:- 归档信息
extension UserAccountViewModel {
    func codeUserAccount(userAccount : UserAccount) -> Bool {
       return NSKeyedArchiver.archiveRootObject(userAccount, toFile: accountPath)
    }
}
