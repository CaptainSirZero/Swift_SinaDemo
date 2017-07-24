//
//  HomeViewCell.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/12.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit
import SDWebImage

private let edgeMarge   : CGFloat = 15.0
private let edgeMargin  : CGFloat = 15.0
private let itemMargin  : CGFloat = 10.0

class HomeViewCell: UITableViewCell {
    
    // MARK:- 控件属性
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var verifiedView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var vipView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var contentLabel: HYLabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var retweetedContentLabel: HYLabel!
    @IBOutlet weak var retweetedBgView: UIView!
    
    // MARK:- 约束的属性
    @IBOutlet weak var contentLabelWCons: NSLayoutConstraint!
    @IBOutlet weak var picViewWCons: NSLayoutConstraint!
    @IBOutlet weak var picViewHCons: NSLayoutConstraint!
    @IBOutlet weak var picViewBottomCons: NSLayoutConstraint!
    @IBOutlet weak var retweetedContentCons: NSLayoutConstraint!
    @IBOutlet weak var bottomToolView: UIView!
    
    // MARK:- 自定义属性
    lazy var collectonViewModel = CollectionViewModel()

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
            contentLabel.attributedText = FindEmoticon.shareInstance.findAttributeString(statusText: viewModel.status?.text, font: contentLabel.font)
            
            // 8. 设置昵称的文字颜色
            screenNameLabel.textColor = viewModel.mbrankImage == nil ? UIColor.black : UIColor.orange
            
            // 10. 为picView赋值
            collectonViewModel.picUrl  = viewModel.picsURL
            
            // 9. 计算picView的宽度和高度约束
            let picViewSize = calucatePicViewSize(count : viewModel.picsURL.count)
            picViewWCons.constant = picViewSize.width
            picViewHCons.constant = picViewSize.height
            collectionView.reloadData()
            
            // 11. 转发内容
            if viewModel.status?.retweeted_status != nil {
                if let screenName = viewModel.status?.retweeted_status?.user?.screen_name, let retweetedText =  viewModel.status?.retweeted_status?.text {
                    let retweetText = "@" + "\(screenName): " + retweetedText
                    retweetedContentLabel.attributedText = FindEmoticon.shareInstance.findAttributeString(statusText: retweetText, font: retweetedContentLabel.font)
                    retweetedBgView.isHidden = false
                    
                    // 设置转发正文距离顶部的约束
                    retweetedContentCons.constant = 15
                }
            }
            else {
                retweetedContentLabel.text = nil
                retweetedBgView.isHidden = true
                 retweetedContentCons.constant = 0
            }
            
            // 12.计算cell高度,这个手动计算方式,不合适,方法调用顺序存在问题
            
            if viewModel.cellHeight == 0 {
                // 12.1 强制布局,获取已有约束的frame
                layoutIfNeeded()
                viewModel.cellHeight = bottomToolView.frame.maxY
            }
        }
    }
    
    // MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置微博正文的宽度约束
        contentLabelWCons.constant = UIScreen.main.bounds.size.width - 2*edgeMarge
        collectionView.delegate = collectonViewModel
        collectionView.dataSource = collectonViewModel
    }
}


extension HomeViewCell {
    
    func calucatePicViewSize(count : Int) -> CGSize {
        
        // 1. 没有配图
        if count == 0 {
            picViewBottomCons.constant = 0
            return CGSize(width: 0, height: 0)
        }
        picViewBottomCons.constant = 10
        // 2. 一张配图
        //  取出collectionview layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        if count == 1 {
            // 2.1  取出图片
            let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: collectonViewModel.picUrl.last?.absoluteString)
            if image != nil {
                // 2.2 设置一张图片时layout的itemSize
                layout.itemSize = CGSize(width: (image?.size.width)!, height: (image?.size.height)!)
                return CGSize(width: (image?.size.width)!, height: (image?.size.height)!)
            }
        }
        
        // 3. 计算出来imageViewWH
        let imageViewWH = (UIScreen.main.bounds.width - 2*edgeMarge - 2*itemMargin)/3
        // 设置其他张图片的尺寸
        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
        
        // 4. 四张配图
        if count == 4 {
            let picViewWH = imageViewWH*2+itemMargin
            return CGSize(width: picViewWH, height: picViewWH)
        }
        
        // 5. 其他
        //  5.1 计算行数
        let rows = CGFloat((count - 1)/3 + 1)
        // 5.2 计算picView的高度
        let picviewH = rows*imageViewWH + (rows - 1)*itemMargin
        // 5.3 计算picView的宽度
        let picviewW = UIScreen.main.bounds.width - 2*edgeMarge
        
        return CGSize(width: picviewW, height: picviewH)
    }
}








