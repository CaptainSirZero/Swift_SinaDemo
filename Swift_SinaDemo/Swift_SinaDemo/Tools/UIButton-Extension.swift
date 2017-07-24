//
//  UIButton-Extension.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/3.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

extension UIButton {
    
    /*
     // 创建类方法
     class func creatButtonWith(imageName : String, bgImageName : String) -> UIButton {
     
     let btn = UIButton()
     
     btn.setImage(UIImage(named: imageName) , for: UIControlState.normal)
     btn.setImage(UIImage(named: imageName + "hightLighted"), for: UIControlState.highlighted)
     btn.setBackgroundImage(UIImage(named: bgImageName), for: UIControlState.normal)
     btn.setBackgroundImage(UIImage(named: bgImageName + "hightLighted"), for: UIControlState.highlighted)
     
     btn.sizeToFit()
     
     return btn
     }
     */
    
    
    // 构造函数使用init(xxxx)格式的初始化方法
    // convenience : 便利,  使用convenience 修饰的构造函数叫做便利构造函数
    // 便利构造函数通常用在 扩充系统的类进行构造函数时
    /*
     便利构造函数的特点:
     1. 便利构造函数通常都死写在extension 里面
     2. 便利构造函数init前面需要加上convence 修饰符
     3. 在便利构造函数中需要明确的先调用self.init() 系统构造函数,然后对其进行扩充
     4. 便利构造函数无返回值
     */
    
    public convenience init(imageName : String, bgImageName : String) {
        self.init()
        
        setImage(UIImage(named : imageName), for: .normal)
        setImage(UIImage(named : bgImageName), for: .highlighted)
        setBackgroundImage(UIImage(named : imageName), for: .normal)
        setBackgroundImage(UIImage(named : bgImageName), for: .highlighted)
        sizeToFit()
    }
    
    public convenience init(backgroundColor : UIColor, fontSize : CGFloat, title : String){
        self.init()
        
        self.backgroundColor = backgroundColor
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setTitle(title, for: .normal)
    }
}









