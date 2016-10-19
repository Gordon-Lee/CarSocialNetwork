//
//  AdjustPhoto.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 25/09/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


enum NormalORThumb {
    case normal , thumb
}

struct Size {
    fileprivate let normalSize = CGSize(width: 375, height: 400)
    fileprivate let thumbSize = CGSize(width: 100, height: 100)
    var Size: CGSize!
    var widthRatio: CGFloat!
    var heigthRatio: CGFloat!
    
    
    init(imgageSize: CGSize, type: NormalORThumb) {
        calculateRatio(imgageSize.width, heigth: imgageSize.height, type: type)
    }
    
    fileprivate mutating func calculateRatio(_ width: CGFloat, heigth: CGFloat, type: NormalORThumb) {
        switch type {
        case .normal:
            widthRatio = normalSize.width / width
            heigthRatio = normalSize.height / heigth
        case .thumb:
            widthRatio = thumbSize.width / width
            heigthRatio = thumbSize.height / heigth
        }
        
        if widthRatio > heigthRatio {
            Size = CGSize(width: width * heigthRatio, height: heigth * heigthRatio)
        } else {
            Size = CGSize(width: width * widthRatio, height: heigth * widthRatio)
        }
    }
}

struct AdjustPhoto {
    
    static func uploadToPhoto(_ fromImage: UIImage, type: NormalORThumb) -> Data {
        
        let new = Size(imgageSize: fromImage.size, type: type)
        
        let rect = CGRect(x: 0, y: 0, width: new.Size.width, height: new.Size.height)
        
        UIGraphicsBeginImageContextWithOptions(new.Size, false, 1.0)
        fromImage.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let uploadImage = UIImagePNGRepresentation(newImage!)
        
        return uploadImage!
    }
}
