//
//  WelcomeViewController.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/11.
//  Copyright © 2017年 CaptainSir. All ri ghts reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var avatarBottomHeight: NSLayoutConstraint!
    @IBOutlet  weak var avatar: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. 加载头像
        let urlString  = UserAccountViewModel.shareIntance.account?.avatar_large
        // ?? 如果?? 前面的可选类型有值,那么将前面的可选类型进行解包并赋值
        // 如果?? 前面的可选类型为nil,那么直接使用后面?? 后面的值
        let url = URL(string: urlString ?? "")
        avatar.layer.cornerRadius = 45.0
        avatar.layer.masksToBounds = true
        avatar.sd_setImage(with: url, placeholderImage: UIImage(named : "avatar_default"))
        
        // 2. 修改约束的值
        avatarBottomHeight.constant = UIScreen.main.bounds.height - UIScreen.main.bounds.height*0.3
        
        // 3. 设置动画
        // Damping : 阻力系数, 阻力系数越大,弹动的效果越不明显 0~1
        // Velocity: 初始化速度
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5.0, options: [], animations: {
            // 强制进行
            self.view.layoutIfNeeded()
        }) { (finished) in
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
    }

}
