//
//  VistitorView.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/3.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//



import UIKit

class VistitorView: UIView {

    // MARK:- 提供快速通过xib创建的类方法
    class func visitorView() -> VistitorView {
        return Bundle.main.loadNibNamed("VistitorView", owner: nil, options: nil)?.first as! VistitorView
    }
    
    // MARK:- 控件的属性
    
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!

    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    // MARK:- UI设置
    func configurationVisitorView(imageName : String, title : String) {
        self.rotationView.image = UIImage(named: imageName)
        self.tipLabel.text = title
        self.rotationView.isHidden = true
    }
    
    
    func addRotationAnimation() {
        // 1. 创建动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        // 2. 设置动画的属性
        rotationAnim.fromValue = 0
        rotationAnim.toValue = Double.pi*2
        rotationAnim.duration = 3
        rotationAnim.repeatCount = MAXFLOAT
        /* When true, the animation is removed from the render tree once its
         * active duration has passed. Defaults to YES. */
        /* 当是true时,  layer已经过了活跃期,这个动画将会从渲染树中移除,默认是YES*/
        rotationAnim.isRemovedOnCompletion = false
        
        rotationView.layer .add(rotationAnim, forKey: nil)
        
    }
    
}






