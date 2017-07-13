//
//  BaseTableViewController.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/3.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {
    
    // MARK:- 懒加载
    public lazy var visitorView : VistitorView = VistitorView.visitorView()
    
    // MARK:- 定义变量
    var isLogin : Bool = UserAccountViewModel.shareIntance.isLogin
    
    //MARK:- 系统回调函数
    override func loadView() {
        
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItem()
    }
}

// MARK:- UI设置
extension BaseTableViewController {
    
    fileprivate func setupVisitorView() {
        view = visitorView
        visitorView.loginBtn.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        visitorView.registerBtn.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
    }
    
    func setNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.plain, target: self, action: #selector(registerAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "登陆", style: .plain, target: self, action: #selector(loginAction))
    }
}

// MARK:- 方法监听
extension BaseTableViewController {
    
    @objc fileprivate func registerAction() {
        let oauthVC = OAuthViewController()
        let oauthNVC = UINavigationController(rootViewController: oauthVC)
        present(oauthNVC, animated: true) {
            
        }
    }
    
    @objc fileprivate func loginAction() {
        let oauthVC = OAuthViewController()
        let oauthNVC = UINavigationController(rootViewController: oauthVC)
        present(oauthNVC, animated: true) {
            
        }
    }
}
