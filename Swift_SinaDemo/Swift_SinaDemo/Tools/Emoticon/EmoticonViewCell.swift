//
//  EmoticonViewCell.swift
//  键盘
//
//  Created by Captain on 2017/7/21.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

class EmoticonViewCell: UICollectionViewCell {
    
    lazy var emoticonBtn = UIButton()
    
    
    var emoticon : Emoticon?  {
        didSet {
            guard let emoticon = emoticon else {
                return
            }
            
            emoticonBtn.setImage(UIImage(contentsOfFile: emoticon.pngPath ?? ""), for: .normal)
            emoticonBtn.setTitle(emoticon.emojiCode, for: .normal)
            
            if emoticon.isRemove {
                emoticonBtn.setImage(UIImage(named: "compose_emotion_delete"), for: .normal)
            }
            
            if emoticon.isEmpty {
                emoticonBtn.setImage(UIImage(named : ""), for: .normal)
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:- 设置UI界面内容
extension EmoticonViewCell {
    func setupUI() {
        contentView.addSubview(emoticonBtn)
        emoticonBtn.frame = contentView.bounds
        emoticonBtn.isUserInteractionEnabled = false
        // 系统emoji表情其实就是文字
        emoticonBtn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
    }
}
