//
//  PhotoBrowserController.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/24.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit
import SnapKit

let margin : CGFloat = 20.0
private let photoBrowserCellIndeifier = "photoBrowserCellIndeifier"


class PhotoBrowserController: UIViewController {
    
    var indexPath  : IndexPath
    var urls  : [URL]
    
    lazy var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: PhotoBrowserFlowLayout())
    lazy var saveButton : UIButton = UIButton(backgroundColor: UIColor.lightGray, fontSize: 14.0, title: "保 存")
    lazy var closeButton = UIButton(backgroundColor: UIColor.lightGray, fontSize: 14.0, title: "关 闭")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
    }
    
    
    init(indexPath : IndexPath, urls : [URL]) {
        // 放到super方法前面是因为,属性要在调用前就要配创建
        self.indexPath = indexPath
        self.urls = urls
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PhotoBrowserController{
    func setupUI() {
        view.addSubview(collectionView)
        view.addSubview(saveButton)
        view.addSubview(closeButton)
        
        saveButton.addTarget(self, action: #selector(saveBtnClick), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        // 设置frame
        collectionView.frame = view.bounds
        saveButton.snp.makeConstraints { (make) in
            make.left.equalTo(margin)
            make.bottom.equalTo(-margin)
            make.size.equalTo(CGSize(width: 90.0, height: 32.0))
        }
        
        closeButton.snp.makeConstraints { (make) in
            make.right.equalTo(-margin)
            make.bottom.equalTo(-margin)
            make.size.equalTo(saveButton.snp.size)
        }
        
        // 设置UICollectionView
        collectionView.register(PhotoBrowserCell.self, forCellWithReuseIdentifier: photoBrowserCellIndeifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK:- 监听点击事件
extension PhotoBrowserController{
    func saveBtnClick() {
        
    }
    
    func closeBtnClick() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK:- 数据源和代理方法
extension PhotoBrowserController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoBrowserCellIndeifier, for: indexPath) as! PhotoBrowserCell
        

        cell.picURL = urls[indexPath.item]
        return cell
    }
    
    
}


class PhotoBrowserFlowLayout : UICollectionViewFlowLayout {
    
    override func prepare() {
        itemSize = UIScreen.main.bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        
        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
}





