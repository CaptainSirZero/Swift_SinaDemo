//
//  PicPickerCell.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/20.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

class PicPickerCell: UICollectionViewCell {

    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var deletePhotoBtn: UIButton!
    
    var image : UIImage? {
        didSet {
            if image != nil {
                imageView.image = image
                addPhotoBtn.isUserInteractionEnabled = false
                deletePhotoBtn.isHidden = false
            }
            else {
                imageView.image = nil
                addPhotoBtn.isUserInteractionEnabled = true
                deletePhotoBtn.isHidden = true
            }
        }
    }
    
    @IBAction func picPickerButtonClick(_ sender: Any) {
        NotificationCenter.default.post(name: picPickerNotificationName, object: nil)
        
    }
    

    @IBAction func deletePicButtonClick(_ sender: Any) {
        NotificationCenter.default.post(name: picDeleteNotificationName, object: imageView.image)
    }
}













