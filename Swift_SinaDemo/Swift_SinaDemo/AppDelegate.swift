//
//  AppDelegate.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/1.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //设置全局颜色
        UITabBar.appearance().tintColor = UIColor.orange
        
        //使用storyboard 创建控制器
        // storyboard 设置UITabBar,只能设置默认图片,选中图片无法直接设置

        
        return true
    }
    
    
    
    
}

