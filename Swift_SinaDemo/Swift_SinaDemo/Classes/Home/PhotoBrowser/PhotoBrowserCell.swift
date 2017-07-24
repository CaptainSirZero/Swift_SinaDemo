//
//  PhotoBrowserCell.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/24.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoBrowserCell: UICollectionViewCell {
    var picURL : URL? {
        didSet {
            guard let picURL = picURL else {
                return
            }
            
            // 1.取出image对象
            let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: picURL.absoluteString)
            
            // 2. 计算imageView的frame
            let width = UIScreen.main.bounds.width
            let height = width / (image?.size.width)! * (image?.size.height)!
            let y = height >= UIScreen.main.bounds.height ? 0 : (UIScreen.main.bounds.height - height)*0.5
            
            // 3. 对imageview进行赋值
            imageView.frame = CGRect(x: 0, y: y, width: width, height: height)
            
            imageView.image = image
            
        }
    }
    
    var scrollView : UIScrollView = UIScrollView()
    var imageView : UIImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoBrowserCell{
    func setupUI() {
        contentView.addSubview(scrollView)
        contentView.addSubview(imageView)
        
        scrollView.frame = contentView.bounds
        
    }
}





