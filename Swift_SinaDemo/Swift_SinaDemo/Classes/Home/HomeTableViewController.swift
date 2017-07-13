//
//  HomeTableViewController.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/1.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {
    
    // MARK:- 懒加载
    lazy var titleBtn           : TitleButton = TitleButton()
    lazy var statusviewModels   : [StatusViewModel]    =  [StatusViewModel]()
    /*
     注意: 在闭包中如果使用当前对象的属性或者调用方法,也需要加self
     两个地方需要使用self :
     1. 如果在一个函数中,局部变量和定义属性之间名字有歧义
     2. 在比保重需要使用当前对象的属性和方法时,也需要使用self
     */
    lazy var poppverAnimator    : PopoverAnimator = PopoverAnimator {[weak self] (presented) in
        // 一般在左边使用? 右侧使用! 赋nil和取nil不是一个意思
        self?.titleBtn.isSelected = presented
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.addRotationAnimation()
        
        if !isLogin {
            return
        }
        
        setupNavigationBar()
        loadHomeInfo()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
    }
}


// MARK:- 设置UI界面
extension HomeTableViewController {
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageNamed: "我")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageNamed: "扫一扫")
        
        titleBtn.setTitle("CaptainSir", for: .normal)
        titleBtn .addTarget(self, action: #selector(titleBtnClick), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
}

// MARK:- 方法监听
extension HomeTableViewController {
    
    @objc fileprivate func titleBtnClick(btn : TitleButton) {
        // 1. 改变按钮的状态
        btn.isSelected = !btn.isSelected
        
        // 2. 创建弹出的控制器
        let popoverVC = PopoverViewController()
        
        // 3. 设置转场的代理
        popoverVC.transitioningDelegate = poppverAnimator
        poppverAnimator.presentedFrame = CGRect(x: (UIScreen.main.bounds.size.width-180)*0.5, y: 55, width: 180, height: 250)
        
        // 3. 设置控制器的modal样式,modal出之后,不让系统隐藏presenting 控制器
        popoverVC.modalPresentationStyle = .custom
        
        // 4. 弹出控制器
        present(popoverVC, animated: true, completion: nil)
    }
}

// MARK:- 请求数据
extension HomeTableViewController {
    func loadHomeInfo() {
        NetworkTool.loadHomeInfo { (reuslt : [[String : AnyObject]]?, error : NSError?) in
            // 1.获取可选类型数据
            guard let resultArr = reuslt else {
                return
            }
            
            // 2. 遍历微博对应的字典
            for statusDic in resultArr {
                let status = Status(dic: statusDic)
                CBLog(message: "微博图片数目\(String(describing: status.pic_urls?.count))")
                self.statusviewModels.append(StatusViewModel(status: status))
            }
            
            // 3. 刷新表格
            self.tableView.reloadData()
        }
    }
}


extension HomeTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "StatusCellI", for: indexPath) as! HomeViewCell
        cell.viewModel =  statusviewModels[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusviewModels.count
    }
}


