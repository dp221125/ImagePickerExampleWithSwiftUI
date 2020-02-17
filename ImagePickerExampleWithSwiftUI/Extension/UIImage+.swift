//
//  UIImage+.swift
//  NSAttriButedStringWithImage
//
//  Created by Seokho on 2020/02/17.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit

extension UIImage {
    func convertToAttributeString() -> NSAttributedString {
        let imageToString = NSTextAttachment()
        imageToString.image = self
        
        let imageSring = NSAttributedString(attachment: imageToString)
        return imageSring
    }
    
    func resizing(targetSize: CGSize) -> UIImage?{
        let size = self.size
        
        let widthRatio  = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
