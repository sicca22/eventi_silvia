//
//  UIHelper.swift
//  eventi_silvia
//
//  Created by iedstudent on 10/05/22.
//

import SwiftUI

struct UIHelper {
    static let primaryColor = Color(uiColor: UIColor(named:"baseColor")!)
    static let secondaryColor = Color(hex: 0x000000)
    static func resize(image: UIImage?, targetSize: CGSize, fill: Bool = false) -> UIImage? {
        guard let image = image else { return nil }
        
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        
        if fill ? (widthRatio < heightRatio) : (widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        image.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
        
        
        
    }
    
    
    static func compress(image: UIImage?, compression: CGFloat) -> Data? {
        return image?.jpegData(compressionQuality: compression)
    }
}


extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

