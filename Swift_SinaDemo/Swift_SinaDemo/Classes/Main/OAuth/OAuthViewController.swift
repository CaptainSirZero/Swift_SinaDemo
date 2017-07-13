//
//  OAuthViewController.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/10.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController {
    // MARK:- 属性
    
    @IBOutlet weak var webView: UIWebView!
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.设置导航栏样式
        setupUI()
        
        // 2.加载网页
        loadWebView()
        //        webView.loadRequest(URLRequest(url: URL(string: "")))
    }
    
}

// MARK:- 设置UI
extension OAuthViewController {
    
    fileprivate func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(tianchongAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(cloaseOauthVCAction))
        navigationItem.title = "登录界面"
    }
    
}

// MARK:- 方法监听
extension OAuthViewController {
    
    @objc fileprivate func cloaseOauthVCAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func loadWebView() {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(app_key_sina)&redirect_uri=\(redirect_url_sina)"
        
        
        guard let url = NSURL(string: urlString) else {
            return
        }
        let urlRequest = NSURLRequest(url: url as URL)
        webView.loadRequest(urlRequest as URLRequest)
    }
    
    @objc fileprivate func tianchongAction() {
        
        let jsCode = "document.getElementById('userId').value='yikeyonggandexin@126.com';document.getElementById('passwd').value='HFcb2017'"
        
        // 2. 执行js代码
        webView.stringByEvaluatingJavaScript(from: jsCode)
    }
}

// MARK:- 网页加载
extension OAuthViewController : UIWebViewDelegate{
    
    // 返回值: true -> 继续加载该页面    false -> 不会加载该页面
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        // 1. 判断url是否存在
        guard let url = request.url  else {
            return true
        }
        
        // 2.获取url中的字符串
        let urlString = url.absoluteString
        
        // 3.判断字符串中是否包含code=
        guard urlString.contains("code=") else {
            return true
        }
        
        // 4.将code截取出来
        guard let code = urlString.components(separatedBy: "code=").last else {
            return true
        }
        loadAccessToken(code: code)
        
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}

// MARK:- AccessToken 获取
extension OAuthViewController { 
    
    func loadAccessToken(code :String) {
        
        NetworkTool.loadAccessToken(code: code) {[weak self] (result : [String : AnyObject]?, error : NSError?) in
            guard let userDic  = result else {
                CBLog(message: "当前信息有误")
                return
            }
            let userAccount = UserAccount(dic: userDic)
            
            self?.loadUserInfo(userAccount: userAccount)
        }
    }
}

// MARK:- 获取用户信息
extension OAuthViewController {
    func loadUserInfo(userAccount : UserAccount) {
        
        NetworkTool.loadUserInfo(userAccount: userAccount) { (result : [String : AnyObject]?, error : NSError?) in
            // 1.获取用户信息的结果
            guard let returnResult = result else {
                return
            }

            // 2. 从字典中取出昵称和用户头像地址
            userAccount.avatar_large = returnResult["avatar_large"] as? String
            userAccount.screen_name = returnResult["screen_name"] as? String
            
            // 3. 将account对象保存
            if !UserAccountViewModel.shareIntance.codeUserAccount(userAccount: userAccount){
                CBLog(message: "归档失败")
            }
            CBLog(message: "归档成功----------" + UserAccountViewModel.shareIntance.accountPath)
            
            // 4. 更新单例数据
            UserAccountViewModel.shareIntance.account  = userAccount
            
            // 4. 退出当前控制器
            self.dismiss(animated: false, completion: {
                UIApplication.shared.keyWindow?.rootViewController = WelcomeViewController()
            })
            
        }
    }
}



