//
//  EmoticonController.swift
//  键盘
//
//  Created by Captain on 2017/7/20.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

private let EmoticonCell = "EmoticonCell"

class EmoticonController: UIViewController {
    
    // 任何属性在调用时,必须有一个初始化值
    
    // MARK:- 懒加载属性
    var emoticonCallBack : ((_ emoticon : Emoticon) -> ())?
    
    lazy var toolBar : UIToolbar = UIToolbar()
    lazy var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: EmotoiconCollectionViewLayout())
    lazy var emoticonManager : EmoticonManager = EmoticonManager()
    // MARK:- 回调方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
    }
    
    init(emotioncCallBack : @escaping (_ emoticon : Emoticon) -> ()) {
        super.init(nibName: nil, bundle: nil)
        
        self.emoticonCallBack = emotioncCallBack
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK:- 设置UI界面内容
extension EmoticonController {
    func setupUI() {
        // 1. 添加子控件
        view.addSubview(toolBar)
        view.addSubview(collectionView)
        
        // 2. 设置子控件的frame
        // 必须取消自动布局
        toolBar.backgroundColor = UIColor.green
        collectionView.backgroundColor = UIColor.orange
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["tBar" : toolBar, "cView" : collectionView] as [String : AnyObject]
        var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tBar]-0-|", options: [], metrics: nil, views: views)
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[cView]-0-[tBar]-0-|", options: [.alignAllLeft, .alignAllRight], metrics: nil, views: views)
        view.addConstraints(cons)
        
        prepareForCollectionview()
        prepareForToolBar()
    }
    
    func prepareForCollectionview() {
        collectionView.register(EmoticonViewCell.self, forCellWithReuseIdentifier: EmoticonCell)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func prepareForToolBar() {
        // 1. 定义toolBar 中title是
       let itemsTitles = ["最近", "默认", "emoji", "浪小花"]
        
        // 2. 遍历标题,创建items
        var index = 0
        var tempItems = [UIBarButtonItem]()
        
        for title in itemsTitles {
            let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(toolBarItemClick(barButtonItem:)))
            item.tintColor = UIColor.orange
            item.tag = index
            index += 1
            tempItems.append(item)
            tempItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        
        tempItems.removeLast()
        toolBar.items = tempItems
    }
}

// MARK:- 方法监听
extension EmoticonController {
    @objc func toolBarItemClick(barButtonItem : UIBarButtonItem) {
        // 1. 获取点击toolBarItem的tag
        let indexPath = IndexPath(item: 0, section: barButtonItem.tag)
        
        // 2.滚动到collection对应的分区
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}


extension EmoticonController : UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return emoticonManager.packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emoticonManager.packages[section].emoticons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1. 获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmoticonCell, for: indexPath) as! EmoticonViewCell
        
        cell.emoticon = emoticonManager.packages[indexPath.section].emoticons[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 1.取出的表情
        let emoticon = emoticonManager.packages[indexPath.section].emoticons[indexPath.item]
        
        // 2.将点击的表情添加到最近的分组中
        insertRecentlyEmoticon(emoticon: emoticon)
        
        // 3.将表情回调给外界
        emoticonCallBack!(emoticon)
    }
    
    func insertRecentlyEmoticon(emoticon : Emoticon) {
        // 1.如果是空表情和删除表情,不插入
        if emoticon.isRemove || emoticon.isEmpty {
            return
        }
        
        // 2. 删除一个表情
        if emoticonManager.packages.first!.emoticons.contains(emoticon) {   //原本有这个表情
            let index = emoticonManager.packages.first?.emoticons.index(of: emoticon)
            emoticonManager.packages.first?.emoticons.remove(at: index!)
        }
        else {
            emoticonManager.packages.first?.emoticons.remove(at: 19)
        }
        // 3. 插入一个表情
        emoticonManager.packages.first?.emoticons.insert(emoticon, at: 0)
        collectionView.reloadData()
    }
}


// MARK:- 自定义collectionViewLayout
class EmotoiconCollectionViewLayout : UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        // 1.计算itemWH
        let itemWH = UIScreen.main.bounds.width/7
        
        // 2. 设置layout的属性
        itemSize = CGSize(width: itemWH, height: itemWH)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        
        // 3. 设置collectionView的属性
        collectionView?.isPagingEnabled = true
        
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        let margin = ((collectionView?.frame.size.height)! - 3*itemWH)/2
        collectionView?.contentInset = UIEdgeInsets(top: margin, left: 0, bottom: margin-1, right: 0)
    }
}









