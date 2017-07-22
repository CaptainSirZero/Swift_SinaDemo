//
//  EmoticonPackage.swift
//  键盘
//
//  Created by Captain on 2017/7/21.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

class EmoticonPackage: NSObject {
    // 每一个表情对应的model
    var emoticons : [Emoticon] = [Emoticon]()
    
    init(id : String) {
        super.init()
        
        if id == "" {
            addEmptyEmoticon(isRecently: true)
            return
        }
        
        // 1.读取对应表情的plist文件
        let plist = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        
        // 2.根据plist文件的路径读取数据[[String : String]]
        let array = NSArray(contentsOfFile: plist)! as! [[String : String]]
        
        // 3.遍历数组
        var index = 0
        for var dict in array {
            // 在model内部,路径拼接因为没有ID,所以先在外面处理一下,再传进去,进行拼接
            if let pngName = dict["png"] {
                dict["png"] = id + "/" + pngName
            }
            
            emoticons.append(Emoticon(dict: dict))
            index += 1
            if index == 20 {
                emoticons.append(Emoticon(isRemove: true))
                index = 0
            }
        }
        
        addEmptyEmoticon(isRecently: false)
    }
    
    func addEmptyEmoticon(isRecently : Bool) {
        let count = emoticons.count % 21
        if count == 0 && !isRecently {
            return
        }
        
        for _ in count..<20 {
            emoticons.append(Emoticon(isEmpty: true))
        }
        emoticons.append(Emoticon(isRemove: true))
    }
    
}







