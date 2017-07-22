//
//  ComposeViewController.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/19.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    // MARK:- 懒加载
    lazy var composeTitleView : ComposeTitleView = ComposeTitleView()
    lazy var images : [UIImage] = [UIImage]()
    lazy var emoticonVC :EmoticonController = EmoticonController {[weak self] (emoticon) in
        self?.textView.insertEmoticon(emoticon : emoticon)
        self?.textViewDidChange((self?.textView)!)
    }

    
    // MARK:- 控件属性
    @IBOutlet weak var textView: ComposeTextView!
    @IBOutlet weak var picPickerCollectionView: PicPickerCollectionView!
    
    // MARK:- 约束属性
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!
    @IBOutlet weak var picPickerHCons: NSLayoutConstraint!
    

// MARK:- 回调方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        setupNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    // MARK:- 移除通知
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK:- 设置UI界面
extension ComposeViewController {
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeItemClick))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(sendItemClick))
        navigationItem.rightBarButtonItem?.isEnabled = false
        composeTitleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        navigationItem.titleView = composeTitleView
    }
    
    func setupNotification()  {
        // MARK:- 监听键盘弹出frame
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillChangeFrame(notification:)), name: .UIKeyboardWillChangeFrame, object: nil)
        
        // MARK:- 监听选择图片按钮点击和删除图片按钮点击
        NotificationCenter.default.addObserver(self, selector: #selector(addPhotoClick), name: picPickerNotificationName, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(deletePhotoClick(notification: )), name: picDeleteNotificationName, object: nil)
    }
}

// MARK:- 选择图片和删除图片监听方法
extension ComposeViewController {
    func addPhotoClick() {
        // 1. 判断数据源是否可用
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            return
        }
        
        // 2. 创建照片选择控制器
        let ipc = UIImagePickerController()
        
        // 3. 指定数据源
        ipc.sourceType = .photoLibrary
        
        // 4. 设置代理获取图片
        ipc.delegate = self
        
        present(ipc, animated: true, completion: nil)
    }
    
    func deletePhotoClick(notification : NSNotification) {
        // 1. 获取要删除的图片
        guard let image = notification.object as? UIImage else {
            return
        }
        
        // 2. 获取image在数组中的下标
        guard let imageIndex = images.index(of: image) else {
            return
        }
        
        // 3. 删除对应的image
        images.remove(at: imageIndex)
        
        // 4. 刷新数据
        picPickerCollectionView.images = images
    }
}

// MARK:- UIImagePickerControllerDelegate
extension ComposeViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        
        // 1.获取选中照片
        let image = info["UIImagePickerControllerOriginalImage"] as! UIImage
        
        // 2.加入数组
        images.append(image)
        
        // 3.退出图片选择控制器
        picker.dismiss(animated: true, completion: nil)
        
        // 4. 展示图片
        picPickerCollectionView.images = images
    }
}


// MARK:- 事件监听
extension ComposeViewController {
    @objc func closeItemClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func sendItemClick() {
        print (textView.getEmoticonString())
    }
    
    @objc func KeyboardWillChangeFrame(notification : NSNotification) {
        // 1. 获取执行动画的时间
        let duration = notification.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as! TimeInterval
        
        // 2. 获取键盘最终Y值
        let endFrame = (notification.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! NSValue).cgRectValue
        let keyboardY = endFrame.origin.y
        
        // 3. 计算工具栏距离底部的间距
        let margin = UIScreen.main.bounds.height  - keyboardY
        
        // 4. 执行动画
        toolBarBottomCons.constant = margin
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func picPickerButtonClick(_ sender: Any) {
        textView.resignFirstResponder()
        
        picPickerHCons.constant = UIScreen.main.bounds.height * 0.65
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func emoijButtonClick() {
        // MARK:- 键盘切换之前需要退出键盘,设置textView.inputView = nil 表示键盘使用默认键盘
        // 1. 退出键盘
        textView.resignFirstResponder()
        
        // 2. 切换键盘
        textView.inputView = textView.inputView != nil ? nil : emoticonVC.view
        
        // 3. 弹出键盘
        textView.becomeFirstResponder()
        
    }
}


// MARK:- UITextView代理方法
extension ComposeViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.textView.placeHolderLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        textView.resignFirstResponder()
    }
}
