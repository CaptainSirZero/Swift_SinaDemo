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
    
    var defaultViewController : UIViewController? {
        return UserAccountViewModel.shareIntance.isLogin ? WelcomeViewController() : UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }
    
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //设置全局颜色
        UITabBar.appearance().tintColor = UIColor.orange
        UINavigationBar.appearance().tintColor = UIColor.orange
        
        // MARK:- 启动流程
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = defaultViewController
        window?.makeKeyAndVisible()
        
        return true
    }
  
}


func CBLog<T>(message : T, fileName : String =  #file, lineNum : Int = #line) {
    #if DEBUG
        let file = (fileName as NSString).lastPathComponent
        print("\(file)----\(lineNum)\n\(message)\n")
        
    #endif
    
}
