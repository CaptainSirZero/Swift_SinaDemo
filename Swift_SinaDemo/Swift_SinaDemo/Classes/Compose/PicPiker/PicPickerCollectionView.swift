//
//  PicPickerCollectionView.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/20.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

private let picPickerCellIndentifier = "picPickerCellIndentifier"
private let edgeMargin : CGFloat = 10.0

class PicPickerCollectionView: UICollectionView {

    var images : [UIImage] = [UIImage]() {
        didSet {
            reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let collectionCellWH = (UIScreen.main.bounds.width - edgeMargin * 4) / 3
        layout.itemSize = CGSize(width: collectionCellWH, height: collectionCellWH)
        layout.minimumInteritemSpacing = edgeMargin
        layout.minimumLineSpacing = edgeMargin
        contentInset = UIEdgeInsets(top: edgeMargin, left: edgeMargin, bottom: 0, right: edgeMargin)
        
        register(UINib(nibName: "PicPickerCell", bundle: nil), forCellWithReuseIdentifier: picPickerCellIndentifier)
        dataSource = self
    }
}

extension PicPickerCollectionView : UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picPickerCellIndentifier, for: indexPath) as! PicPickerCell
        
        cell.contentView.backgroundColor = UIColor.white
        cell.image = indexPath.item <= images.count - 1 ? images[indexPath.item] : nil
        
        return cell
        
    }
}
