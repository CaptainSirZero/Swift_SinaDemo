//
//  UITextView-Extension.swift
//  键盘
//
//  Created by Captain on 2017/7/22.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

extension UITextView {
/// 获取textView属性字符串,对应的表情字符串
    func getEmoticonString() -> String {
        // 1.获取属性字符串
        let attributeString = NSMutableAttributedString(attributedString: attributedText)
        
        // 2. 遍历属性字符串,替换表情为文字
        let range = NSRange(location: 0, length: (attributeString.length))
        attributeString.enumerateAttributes(in: range, options: [], using: { (dict, range, _) in
            if dict["NSAttachment"] != nil {
                let attchament = dict["NSAttachment"] as! EmoticonTextAttachment
                attributeString.replaceCharacters(in: range, with: attchament.chs!)
            }
        })
        
        // 3. 获取字符串
        return attributeString.string

    }
    
    /// 给textView插入表情
    func insertEmoticon(emoticon : Emoticon) {
        // 1. 空白表情
        if emoticon.isEmpty {
            return
        }
        
        // 2. 删除按钮
        if emoticon.isRemove {
            // 回删
            deleteBackward()
            return
        }
        
        // 3. emoji表情,相当于文字
        if emoticon.emojiCode != nil {
            // 3.1 获取光标所在的位置: UITextRange
            let textRange = selectedTextRange!
            
            // 3.2 替换emoji表情
            replace(textRange, withText: emoticon.emojiCode!)
        }
        
        // 4. 普通表情: 图文混排
        if emoticon.pngPath != nil {
            // 4.1 根据图片路径创建属性字符串
            let attchment = EmoticonTextAttachment()
            attchment.image = UIImage(contentsOfFile: emoticon.pngPath!)
            // 4.2 设置属性字符串中附件的bounds,因为附件尺寸会比较大是自身尺寸
            let font = self.font!
            attchment.bounds = CGRect(x: 0, y: -4, width: font.lineHeight, height: font.lineHeight)
            attchment.chs = emoticon.chs
            // 4.3 获取textView的属性字符串为可变类型,因为要对其进行更换
            let attributedMText = NSMutableAttributedString(attributedString: attributedText)
            
            // 4.4 获取光标位置,更换
            let range = selectedRange
            attributedMText.replaceCharacters(in: range, with: NSAttributedString(attachment: attchment))
            // 4.5 显示属性字符串
            attributedText = attributedMText
            
            // 4.6 属性字符串在使用的,存在光标偏移情况
            selectedRange = NSRange(location: range.location + 1, length: 0)
            
            // 4.7 属性字符串在使用的,附件设置导致文本字体被修改
            self.font = font
        }
        

    }
    
}
