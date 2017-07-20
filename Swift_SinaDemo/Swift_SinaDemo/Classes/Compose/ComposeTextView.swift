//
//  ComposeTextView.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/19.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

class ComposeTextView: UITextView {
    
    lazy var placeHolderLabel : UILabel = UILabel()
    
    // 先执行这个方法,再执行awakeFromNib,这个方法一般用于添加子控件
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
       setupUI()
    }
    
    /*
     // 这个方法一般用于初始化操作,颜色,约束
     override func awakeFromNib() {
     super.awakeFromNib()
     }
     */
    
}

extension ComposeTextView {
    func setupUI() {
        addSubview(placeHolderLabel)
        
        placeHolderLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(10)
        }
        
        placeHolderLabel.textColor = UIColor.lightGray
        placeHolderLabel.font = self.font
        
        placeHolderLabel.text = "分享新鲜事..."
        
        // textView 内容内边距
        textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

    }
}
