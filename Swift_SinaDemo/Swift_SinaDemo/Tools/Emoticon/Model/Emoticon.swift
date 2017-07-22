//
//  Emoticon.swift
//  键盘
//
//  Created by Captain on 2017/7/21.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

class Emoticon: NSObject {

    // MARK:- 定义属性
    var code : String? {             //emoji的code
        didSet{
            guard let code = code else {
                return
            }
            
            // 1.创建扫描器 
            let scanner = Scanner(string: code)
            
            // 2. 获取扫描结果
            var value : UInt32 = 0
            scanner.scanHexInt32(&value)
            
            // 3.将value转成字符
            let c = Character(UnicodeScalar(value)!)
            
            // 4.将字符转成字符串
            emojiCode = String(c)
            
        }
    }
    var png  : String?  {            // 普通表情对应的图片名称
        didSet {
            guard  let png = png  else {
                return
            }
            pngPath = Bundle.main.bundlePath + "/Emoticons.bundle/" + png
        }
    }
    var chs         : String?               // 普通表情对应的文字
    var pngPath     : String?               // 非系统表情图片完整路径
    var emojiCode   : String?               // 系统emoji表情
    var isRemove    : Bool = false          // 是否是删除表情
    var isEmpty     : Bool = false          //是否是空的表情
    
    
    init(dict : [String : String]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    init(isRemove: Bool){
        super.init()
        self.isRemove = isRemove
    }
    
    init(isEmpty: Bool){
        super.init()
        self.isEmpty = isEmpty
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description: String {
        return dictionaryWithValues(forKeys: ["pngPath", "emojiCode"]).description
    }
}








