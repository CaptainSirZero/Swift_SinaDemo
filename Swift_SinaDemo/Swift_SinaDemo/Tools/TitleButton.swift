//
//  TitleButton.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/8.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(UIImage(named : "箭头-2"), for: .normal)
        setImage(UIImage(named : "箭头"), for: .selected)
        setTitleColor(UIColor.black, for: .normal)
        sizeToFit()

    }
    
    // Swift 中规定: 重写控件的init(frame方法)或者init() 方法, 必须重写init?(coder aDecoder: NSCoder)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel!.frame.origin.x = 0
        imageView!.frame.origin.x = titleLabel!.frame.size.width + 5
    }
    

}

