//
//  NSDate-Extension.swift
//  时间格式处理
//
//  Created by Captain on 2017/7/12.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import Foundation

extension NSDate {
    class func createDateString(creatAtStr : String) -> String?{
        // 1.创建时间格式
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = Locale(identifier: "en")
        
        // 2.将字符串转成Date类型
        guard let creatDate = fmt.date(from: creatAtStr) else {
            return "时间格式错误"
        }
        
        // 3.创建当前时间
        let nowDate = Date()
        
        // 4.计算创建时间和当前时间的时间差
        let interval = Int(nowDate.timeIntervalSince(creatDate))
        
        // 5.对时间间隔进行处理
        // 5.1 显示刚刚
        if interval < 60 {
            return "刚刚"
        }
        
        // 5.2 显示几分钟前
        if interval < 60*60 {
            return "\(interval/60)分钟前"
        }
        
        // 5.3 显示几小时前
        if interval < 60*60*24 {
            return "\(interval/(60 * 60))小时前"
        }
        
        // 5.4 创建日历对象
        let calender = Calendar.current
        
        // 5.5 显示 昨天 几时几分
        if calender.isDateInYesterday(creatDate) {
            fmt.dateFormat = "昨天 HH:MM"
            let timeStr = fmt.string(from: creatDate)
            return timeStr
        }
        
        // 5.6 显示一年以内,几月几日 几时几分
        let cmps = calender.dateComponents([.year], from: creatDate, to: nowDate)
        if cmps.year! < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
            let timeStr = fmt.string(from: creatDate)
            return timeStr
        }
        
        // 5.7 显示几年几月几日 几时几分
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeStr = fmt.string(from: creatDate)
        return timeStr
        
    }
}
