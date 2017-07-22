//
//  EmoticonManager.swift
//  键盘
//
//  Created by Captain on 2017/7/21.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

class EmoticonManager {
    lazy var packages : [EmoticonPackage] = [EmoticonPackage]()
    
    init() {
        // 1.添加最近表情包
        packages.append(EmoticonPackage(id: ""))
        
        // 2.添加默认表情包
        packages.append(EmoticonPackage(id: "com.sina.default"))
        
        // 3.添加emoji表情包
        packages.append(EmoticonPackage(id : "com.apple.emoji"))
        
        // 1.添加浪小花表情包
        packages.append(EmoticonPackage(id : "com.sina.lxh"))
    }
}
