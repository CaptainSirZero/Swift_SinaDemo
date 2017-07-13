//
//  PresentatinController.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/8.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

class PresentatinController: UIPresentationController {

    // MARK:- 懒加载属性
    var presentedViewFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    fileprivate lazy var coverView : UIView = UIView()
    
    // MARK:- 系统回调函数
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        // 1.设置弹出view的尺寸
        presentedView?.frame = presentedViewFrame
        
        // 2.添加蒙板
        setupCoverView()
    }
}

// MARK:- 设置UI界面相关
extension PresentatinController {
    
    fileprivate func setupCoverView() {
        // 1.添加蒙板
        containerView?.insertSubview(coverView, at: 0)
        
        // 2.设置蒙板的属性
        coverView.backgroundColor = UIColor(white: 1.0, alpha:0.1)
        coverView.frame = containerView!.frame
        
        // 3.添加点击事件
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PresentatinController.tapCoverGesture))
        
        coverView .addGestureRecognizer(tapGesture)
        
    }
}

// MARK:- 点击事件监听
extension PresentatinController {
    
    @objc fileprivate func tapCoverGesture() { 
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}





