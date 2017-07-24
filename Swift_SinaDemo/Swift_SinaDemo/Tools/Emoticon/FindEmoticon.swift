//
//  FindEmoticon.swift
//  表情显示
//
//  Created by Captain on 2017/7/24.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

class FindEmoticon: NSObject {
    static let shareInstance : FindEmoticon = FindEmoticon()
    lazy var manager : EmoticonManager = EmoticonManager()
    
    func findAttributeString(statusText : String?, font : UIFont) -> NSMutableAttributedString? {
        guard let statusText = statusText else {
            return nil
        }
        // 1. 创建匹配规则
        let pattern = "\\[.*?\\]"       //匹配表情
        
        // 2. 创建正则表达式对象
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return nil
        }
        
        // 3. 开始匹配
        let attributeString = NSMutableAttributedString(string: statusText)
        let results = regex.matches(in: statusText, options: [], range: NSRange(location: 0, length: statusText.characters.count))
        
        // 4. 获取结果, 替换发生range变化,所以我们一般都采用倒序解析
        for i in 0..<results.count {
            
            let result = results[results.count - i - 1]
            // 4.1获取chs
            let chs = (statusText as NSString).substring(with: result.range)
            
            // 4.2 根据chs,获取图片的路径
            guard  let pngPath = findPngPath(chs: chs) else {
                continue
            }
            
            // 4.3 创建属性字符串
            let attachMent = NSTextAttachment()
            attachMent.image = UIImage(contentsOfFile: pngPath)
            attachMent.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            let attriString = NSAttributedString(attachment: attachMent)
            
            attributeString.replaceCharacters(in: result.range, with: attriString)
            
            // 属性字符串的两个坑
        }
        return  attributeString
    }
    
    func findPngPath(chs : String) -> String? {
        for package in manager.packages {
            for emoticon in package.emoticons {
                if emoticon.chs == chs {
                    return emoticon.pngPath
                }
            }
        }
        return nil
    }
}




