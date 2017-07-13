//
//  PopoverAnimator.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/8.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {
    // 用来区分是显示还是隐藏动画
    fileprivate var isPresentView : Bool = false
    var presentedFrame = CGRect()
    var callBack :(_ presented : Bool) -> ()

    
    // MARK:- 自定义一个构造函数
    // 注意: 如果自定义一个构造函数,但是没有对默认构造函数init() 重写,那么自定义的构造函数会覆盖默认的init() 构造函数
    //  这个类是自己创建的,所以默认就一个构造函数
    
    init(callBack : @escaping (_ presented : Bool) -> ()) {
        self.callBack = callBack //同名,避免歧义
    }
}

// MARK:- 转场动画代理方法
extension PopoverAnimator : UIViewControllerTransitioningDelegate{
    
    // 目的: 改变弹出View的尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?{

        let presentController = PresentatinController(presentedViewController: presented, presenting: presenting)
        presentController.presentedViewFrame = presentedFrame
        return presentController
    }
    
    // 目的: 自定义弹出的动画---显示转场动画设置
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresentView = true
        callBack(isPresentView)
        return self
    }
    
    // 目的: 自定义消失的动画 ---隐藏转场动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresentView = false
        callBack(isPresentView)
        return self
    }
}

// MARK:- 弹出和消失动画代理的方法
extension PopoverAnimator : UIViewControllerAnimatedTransitioning{
    
    // 动画执行时间
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        return 0.5
    }
    
    // 获取 '转场的上下文' :可以通过转场上下文获取弹出的view和消失的view
    // UITransitionContextFromViewKey : 通过key获取消失的view
    // UITransitionContextToViewKey   : 通过key获取弹出的view
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        isPresentView ? transitionShwoView(transitionContext: transitionContext) : transitionDismissView(transitionContext: transitionContext)
    }
    
    
    // 自定义显示转场动画
    fileprivate func transitionShwoView(transitionContext: UIViewControllerContextTransitioning) {
        // 1. 获取弹出的view
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        // 2. 将弹出的view添加到containerView中
        transitionContext.containerView.addSubview(presentedView)
        
        // 3. 执行动画
        presentedView.transform = CGAffineTransform.identity
        presentedView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presentedView.transform = .identity
        }) { (isfinished : Bool) in
            // 必须告诉转场上下文你已经完成动画
            transitionContext.completeTransition(true)
        }
    }
    
    // 自定义消失转场动画
    fileprivate func transitionDismissView(transitionContext: UIViewControllerContextTransitioning) {
        // 1. 获取弹出的view
        let  dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        
        // 2. 执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            dismissView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.0001)
        }) { (isfinished) in
            dismissView?.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
    }
}
