//
//  UIBarButtonItem-Extension.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/7.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit


extension UIBarButtonItem {
    
    // 方法一 : 先创建,在赋值customView
    /*
     convenience init(imageName: String) {
     self.init()
     
     let btn = UIButton()
     btn.setImage(UIImage(named : imageName), for: .normal)
     btn.setImage(UIImage(named : imageName + "highlighted"), for: .highlighted)
     btn.sizeToFit()
     
     self.customView = btn
     
     }
     */
    
    convenience init(imageNamed : String) {
        let btn = UIButton()
        btn.setImage(UIImage(named : imageNamed), for: .normal)
        btn.setImage(UIImage(named : imageNamed + "-2"), for: .highlighted)
        btn.sizeToFit()
        
        self.init(customView: btn)
    }
}
