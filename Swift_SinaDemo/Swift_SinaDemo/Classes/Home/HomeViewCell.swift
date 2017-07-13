//
//  HomeViewCell.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/12.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

private let edgeMarge : CGFloat = 15.0

class HomeViewCell: UITableViewCell {
    
    // MARK:- 控件属性
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var verifiedView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    // MARK:- 约束的属性
    @IBOutlet weak var contentLabelWCons: NSLayoutConstraint!
    @IBOutlet weak var picViewWCons: NSLayoutConstraint!
    @IBOutlet weak var picViewHCons: NSLayoutConstraint!
    
    // MARK:- 自定义属性
    var viewModel :  StatusViewModel? {
        didSet {
            // 1.nil 值校验
            guard let viewModel = viewModel else {
                return
            }
            
            // 2. 设置头像
            iconView.sd_setImage(with: viewModel.profileURL, placeholderImage: UIImage(named: "avatar_default"))
            
            // 3. 设置认证图标
            verifiedView.image = viewModel.verifiedImage
            
            // 4. 设置用户名
            screenNameLabel.text = viewModel.status?.user?.screen_name
            
            // 5. 设置会员等级图标
            vipView.image = viewModel.mbrankImage
            
            // 6. 设置发布时间
            timeLabel.text = viewModel.createAtText
            
            // 7. 设置发布设备
            sourceLabel.text = viewModel.sourceText
            
            // 8. 设置正文内容
            contentLabel.text = viewModel.status?.text
            
            // 8. 设置昵称的文字颜色
            screenNameLabel.textColor = viewModel.mbrankImage == nil ? UIColor.black : UIColor.orange
        }
    }
    
    // MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()

        // 设置微博正文的宽度约束
        contentLabelWCons.constant = UIScreen.main.bounds.size.width - 2*edgeMarge
    }
}










