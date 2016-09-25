//
//  AdjustPhoto.swift
//  CarSocialNetwork
//
//  Created by Marco Aurelio Dias Americo on 25/09/16.
//  Copyright © 2016 CarSocial. All rights reserved.
//

import UIKit

enum NormalORThumb {
    case NORMAL , THUMB
}

struct Size {
    private let normalSize = CGSize(width: 400, height: 400)
    private let thumbSize = CGSize(width: 100, height: 100)
    var Size: CGSize!
    var widthRatio: CGFloat!
    var heigthRatio: CGFloat!
    
    
    init(imgageSize: CGSize, type: NormalORThumb) {
        calculateRatio(imgageSize.width, heigth: imgageSize.height, type: type)
    }
    
    private mutating func calculateRatio(width: CGFloat, heigth: CGFloat, type: NormalORThumb) {
        switch type {
        case .NORMAL:
            widthRatio = normalSize.width / width
            heigthRatio = normalSize.height / heigth
        case .THUMB:
            widthRatio = thumbSize.width / width
            heigthRatio = thumbSize.height / heigth
        }
        
        if widthRatio > heigthRatio {
            Size = CGSizeMake(width * heigthRatio, heigth * heigthRatio)
        } else {
            Size = CGSizeMake(width * widthRatio, heigth * widthRatio)
        }
    }
}

struct AdjustPhoto {
    
    static func uploadToPhoto(fromImage: UIImage, type: NormalORThumb) -> NSData {
        
        let new = Size(imgageSize: fromImage.size, type: type)
        
        let rect = CGRectMake(0, 0, new.Size.width, new.Size.height)
        
        UIGraphicsBeginImageContextWithOptions(new.Size, false, 1.0)
        fromImage.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let uploadImage = UIImagePNGRepresentation(newImage)
        
        return uploadImage!
    }
}