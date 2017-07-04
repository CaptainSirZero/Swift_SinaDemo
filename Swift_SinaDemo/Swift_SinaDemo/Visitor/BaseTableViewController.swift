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
    let isLogin : Bool = false
    
    //MARK:- 系统回调函数
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
}

// MARK:- 方法
extension BaseTableViewController {
    
    fileprivate func setupVisitorView() {
        view = visitorView
    }
}
