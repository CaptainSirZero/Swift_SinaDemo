//
//  NetworkTool.swift
//  AFNetworkingTool
//
//  Created by Captain on 2017/7/10.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import AFNetworking

enum RequestType : Int {
    case GET = 0
    case POST
}

class NetworkTool: AFHTTPSessionManager {
    
    // Swift 中let 是线程安全的,下面的方式表示通过shareInstance实例,得到的都是一个单例
    //    static let shareInstance : NetworkTool = NetworkTool()
    
    // 通过闭包方式创建单例,修改其中默认属性
    static let shareInstance : NetworkTool = {
        let tempTool = NetworkTool()
        // 接收响应类型
        tempTool.responseSerializer.acceptableContentTypes?.insert("text/html")
        tempTool.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tempTool
        
    }()
}

// MARK:- 网络请求
extension NetworkTool{
    
    class func networkRequest (requestType : RequestType, URLString : String, parameters : [String : AnyObject], callBack : @escaping (_ result : Any? , _ error : Error?) -> () ) {
        
        let successCallBack  = { (task :URLSessionDataTask, result : Any?) in
            // 解包问题
            //            guard let tempResult = result else {
            //                return
            //            }
            //            print(tempResult)
            callBack(result, nil)
        }
        
        let failureCallBack = { (task : URLSessionDataTask?, error : Error) in
            
            callBack(nil, error)
        }
        
        
        if requestType  == .GET {
            NetworkTool.shareInstance.get(URLString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
        else if requestType == .POST {
            NetworkTool.shareInstance.post(URLString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
        }
    }
}

// MARK:- 请求accesstoken
extension NetworkTool {
    
    class func loadAccessToken(code : String, finisehBack : @escaping (_ result : [String : AnyObject]?, _ error : NSError?) -> ()) {
        let  urlString = "https://api.weibo.com/oauth2/access_token"
        
        let parametes = ["client_id" : app_key_sina, "client_secret" : app_secret_sina, "grant_type" : "authorization_code", "redirect_uri" : redirect_url_sina, "code" : code]
        
        NetworkTool .networkRequest(requestType: .POST, URLString: urlString, parameters: parametes as [String : AnyObject]) { (result : Any?, error : Error?) in
            if error != nil {
                CBLog(message: error!)
                return
            }
            
            finisehBack(result as? [String : AnyObject], nil)
        }
    }
}


// MARK: - 获取用户信息
extension NetworkTool {
    class func loadUserInfo(userAccount : UserAccount, finishedBack : @escaping (_ result : [String : AnyObject]?, _ error : NSError?) -> ()) {
        let urlString  = "https://api.weibo.com/2/users/show.json"
        
        let parameters = ["access_token" : userAccount.access_token, "uid" : userAccount.uid]
        
        NetworkTool.networkRequest(requestType: .GET, URLString: urlString, parameters: parameters as [String : AnyObject]) { (result : Any?, error :Error?) in
            if error != nil {
                CBLog(message: error)
                return
            }
            
            finishedBack(result as? [String : AnyObject] , nil)
        }
    }
}

// MARK:- 请求数据
extension NetworkTool {
    class func loadHomeInfo(since_id : Int, max_id : Int ,finished : @escaping (_ result : [[String : AnyObject]]?, _ erro : NSError?) -> ()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let access_token = (UserAccountViewModel.shareIntance.account?.access_token)!
        
        let parameters = ["access_token" : access_token, "since_id" : "\(since_id)", "max_id" : "\(max_id)"]
        
        NetworkTool.networkRequest(requestType: .GET, URLString: urlString, parameters: parameters as [String : AnyObject]) { (result : Any?, error : Error?) in
            if error != nil {
                return
            }
            // 1. 获取字典的数据
            guard let resultDic = result as? [String : AnyObject] else {
                return
            }
            
            // 2. 数据回调出去
            finished(resultDic["statuses"] as? [[String : AnyObject]], nil)
        }
    }
}


// MARK:- 发送微博纯文字,该接口新浪已经禁止了
extension NetworkTool {
   class func sendStatus(statusString : String, isSuccess : @escaping (_ isSuccess : Bool) -> ()) {
        // 1. 获取链接
        let urlString = "https://api.weibo.com/2/statuses/update.json"
        
        // 2. 获取请求参数
        let parameters = [ "status" : statusString]
        
        // 3. 发送请求
        NetworkTool.networkRequest(requestType: .POST, URLString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) in
            if result != nil {
                isSuccess(true)
            }
            else {
                isSuccess(false)
            }
        }
    }
}

// MARK:- 发送微博,文字和图片,该接口新浪已经禁止了
extension NetworkTool {
    class func sendStatus(statusString : String,image: UIImage , isSuccess : @escaping (_ isSuccess : Bool) -> ()) {
        // 1. 获取链接
        let urlString = "https://api.weibo.com/2/statuses/upload.json"
        
        // 2. 获取请求参数
        let parameters = [ "status" : statusString] as [String : AnyObject]
        
        // 3. 将图片转城二进制数据
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        if imageData != nil {
            // 3. 发送请求
            NetworkTool.shareInstance.post(urlString, parameters: parameters, constructingBodyWith: { (afMultipartFormData) in
                afMultipartFormData.appendPart(withFileData: imageData!, name: "pic", fileName: "weibo.image", mimeType: "image/png")
            }, progress: nil, success: { (_, _) in
                isSuccess(true)
            }) { (_, _) in
                isSuccess(false)
            }
        }
 

    }
}



