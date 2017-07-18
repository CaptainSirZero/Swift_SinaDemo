//
//  CollectionViewModel.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/17.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

class CollectionViewModel: NSObject {
    
    open  var picUrl : [URL] = [URL]()
}

extension CollectionViewModel : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "PicCell", for: indexPath) as! picCollectionCell
        cell.picUrl = picUrl[indexPath.row]
        return cell
    }
}

class picCollectionCell: UICollectionViewCell {
    
    // MARK:- 控件的属性
    @IBOutlet weak var iconView: UIImageView!
    
    // MARK:- 定义模型属性
    var picUrl : URL?  {
        didSet {
            iconView.sd_setImage(with: picUrl, placeholderImage: UIImage(named : "占位图"))
        }
    }
    
}













