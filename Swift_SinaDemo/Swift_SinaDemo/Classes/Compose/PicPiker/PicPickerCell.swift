//
//  PicPickerCell.swift
//  Swift_SinaDemo
//
//  Created by Captain on 2017/7/20.
//  Copyright © 2017年 CaptainSir. All rights reserved.
//

import UIKit

class PicPickerCell: UICollectionViewCell {

    @IBAction func picPickerButtonClick(_ sender: Any) {
        NotificationCenter.default.post(name: picPickerNotificationName, object: nil)
        
    }
    

    @IBAction func deletePicButtonClick(_ sender: Any) {
        print("删除选择的图片")
    }
    

}
