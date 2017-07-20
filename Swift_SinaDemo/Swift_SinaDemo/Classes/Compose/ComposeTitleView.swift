//
//  ComposeTitleView.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/19.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit
import SnapKit

class ComposeTitleView: UIView {

    lazy var titleLabel : UILabel = UILabel()
    lazy var screenNameLable : UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension ComposeTitleView {
    func setupUI() {
        addSubview(titleLabel)
        addSubview(screenNameLable)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        
        screenNameLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-3)
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        screenNameLable.font = UIFont.systemFont(ofSize: 13)
        screenNameLable.textColor = UIColor.lightGray
        
        titleLabel.text = "发微博"
        screenNameLable.text = UserAccountViewModel.shareIntance.account?.screen_name
    }
    
    
}
