//
//  MainViewController.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/1.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//


import UIKit

class MainViewController: UITabBarController {
    
    // MARK:- ------------懒加载----------
   fileprivate lazy var composeBtn : UIButton = UIButton(imageName: "加", bgImageName: "加")
    //     调用创建的extension方法测试
    //    lazy var tempBtn = UIButton.creatButtonWith(imageName: "helle", bgImageName: "bg_helle")
    
    // MARK:- ----------生命周期方法------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComposeBtn()
    }
    
    
    // storyboard 加载时,在viewdidload 方法中进行的设置都会被调整回原始状态
    // 所以需要将设置操作放到viewWillAppear方法中进行处理
    // 设置方法需要在viewDidAppear 中进行设置
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        setupTabbarItem()
        
    }
    
}


// MARK:- ------------事件监听----------
extension MainViewController {
    
    //  事件监听本质上是 发送消息,但是发送消息是OC的特性
    //  将方法包装成@SEL --> 类中查找方法列表 --> 根据@SEL找到imp指针(函数指针) --> 执行函数
    //  如果Swift 中将一个函数声明为 fileprivate ,那么这个函数不会被添加到方法列表中
    //  如果在private前面加上@objc, 那么该方法依然会添加到方法列表中, 而且又保护了私有性
     @objc fileprivate func composeBtnClick() {
        
    }
}


// MARK:- ------------设置UI界面----------
extension MainViewController {
    
    
    /// 设置发布按钮
    public func setupComposeBtn()  {
        tabBar.addSubview(composeBtn)
        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height*0.5)
        
        //Selector 两种写法: 1--> Selector("方法名")  2--> "方法名"  Swift 2.0
        // #selector(MainViewController.方法名)                    Swift 3.x
        composeBtn.addTarget(self, action: #selector(MainViewController.composeBtnClick), for: UIControlEvents.touchUpInside)
    }
    
    
    /*
     /// 设置Item属性
     func setupTabbarItem() {
     for i in 0..<tabBar.items!.count {
     let item = tabBar.items![i]
     
     if i == 2 {
     item.isEnabled = false
     continue
     }
     }
     }
     */
}













