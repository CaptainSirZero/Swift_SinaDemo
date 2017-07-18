//
//  HomeTableViewController.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/1.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh

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
        
        //        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        setupHeadRefresh()
        setupFooterView()
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
    
    func setupHeadRefresh() {
        // 1. 创建headerView
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadNewStatuses))
        
        // 2. 设置header的属性
        header?.setTitle("下拉刷新", for: .idle)
        header?.setTitle("释放更新", for: .pulling)
        header?.setTitle("加载中...", for: .refreshing)
        
        // 3. 设置tableview的header
        tableView.mj_header = header
        
        // 4. 进入刷新状态
        tableView.mj_header.beginRefreshing()
    }
    
    func setupFooterView()  {
        tableView.mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreStatus))
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
    
    @objc func loadNewStatuses() {
        loadHomeInfo(isNewData: true)
    }
    
    @objc func loadMoreStatus() {
        loadHomeInfo(isNewData: false)
    }
    
    func loadHomeInfo(isNewData : Bool) {
        // 1. 获取since_id / max_id
        var since_id = 0
        var max_id = 0
        
        if isNewData {
            since_id = statusviewModels.first?.status?.mid ?? 0
        }
        else {
            max_id = statusviewModels.last?.status?.mid ?? 0
            max_id = max_id == 0 ? 0 : (max_id - 1)
        }
        
        // 请求数据
        NetworkTool.loadHomeInfo(since_id: since_id, max_id: max_id) { (result: [[String : AnyObject]]?, error : NSError?) in
            // 1.获取可选类型数据
            guard let resultArr = result else {
                return
            }
            
            // 2. 遍历微博对应的字典
            var tempViewModel = [StatusViewModel]()
            for statusDic in resultArr {
                let status = Status(dic: statusDic)
                tempViewModel.append(StatusViewModel(status: status))
            }
            
            // 3. 将数据原有数据拼接到新数据后面
            if isNewData {
                self.statusviewModels = tempViewModel + self.statusviewModels
            }
            else {
                self.statusviewModels = self.statusviewModels + tempViewModel
            }
            
            // 3. 缓存图片
            self.cacheImages(viewModels: self.statusviewModels)
        }
    }
    
    func cacheImages(viewModels : [StatusViewModel]) {
        // 1. 创建group
        let group = DispatchGroup()
        
        // 2. 缓存图片
        for viewModel in viewModels {
            for picURL in viewModel.picsURL {
                group.enter()
                SDWebImageManager.shared().imageDownloader?.downloadImage(with: picURL, options: [], progress: nil, completed: { (_, _, _, _) in
                    group.leave()
                })
            }
        }
        
        // 3. 刷新表格
        group.notify(queue: DispatchQueue.main) {
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
        }
    }
}


extension HomeTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("当前indexpath.row\(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatusCellI") as! HomeViewCell
        
        //        let cell  = tableView.dequeueReusableCell(withIdentifier: "StatusCellI", for: indexPath) as! HomeViewCell
        cell.viewModel =  statusviewModels[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusviewModels.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = statusviewModels[indexPath.row]
        return viewModel.cellHeight
    }
}









