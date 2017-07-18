//
//  StatusViewModel.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/12.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

class StatusViewModel: NSObject {
    
    // MARK:- 定义属性
    var status          :   Status?
    
    // MARK:- 对数据处理的属性
    var sourceText      :   String?              // 处理来源
    var createAtText    :   String?              // 处理创建时间
    var verifiedImage   :   UIImage?             // 处理用户认证
    var mbrankImage     :   UIImage?             // 处理会员等级
    var profileURL      :   URL?                 // 处理用户头像URL
    var picsURL         : [URL] = [URL]()        // 微博图片urls
    var cellHeight      : CGFloat = 0            //单元格高度
    
    // MARK:- 自定义构造函数
    init(status : Status) {
        
        self.status = status
        // 1. 来源处理
        if let source = status.source, source != "" {
            let location = (source as NSString).range(of: ">").location + 1
            let length   = (source as NSString).range(of: "</").location - location
            sourceText = (source as NSString).substring(with: NSRange(location: location, length: length))
        }
        
        // 2. 微博创建时间处理
        if let created_at = status.created_at {
            createAtText = NSDate.createDateString(creatAtStr: created_at)
        }
        
        // 3. 用户类型
        let verified_type = status.user?.verified_type ?? -1
        switch verified_type {
        case 0:
            verifiedImage = UIImage(named: "renzheng-geren")
        case 2,3,5:
            verifiedImage = UIImage(named: "renzheng-qiye")
        case 220:
            verifiedImage = UIImage(named: "renzheng-daren")
        default:
            verifiedImage = nil
        }
        
        // 4. 会员等级认证
        let mbrank = status.user?.mbrank ?? 0
        if mbrank > 0, mbrank < 6 {
            mbrankImage = UIImage(named: "dengji")
        }
        else{
            mbrankImage = nil
        }
        
        // 5. 用户头像的处理
        let profileURLString = status.user?.profile_image_url ?? ""
        profileURL = URL(string: profileURLString)
        
        // 6. 微博图片处理
        let picURLDicts = status.pic_urls?.count != 0 ? status.pic_urls : status.retweeted_status?.pic_urls
        
        guard let picArr = picURLDicts else{
            return
        }
        
        for  picDic in picArr {
            guard let picURLString = picDic["thumbnail_pic"] else {
                continue
            }
            picsURL.append(URL(string : picURLString)!)
        }
    }
}




