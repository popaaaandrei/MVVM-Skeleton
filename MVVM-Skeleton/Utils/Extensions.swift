//
//  Extensions.swift
//  MVVM-Skeleton
//
//  Created by andrei on 23/11/2016.
//  Copyright © 2016 andrei. All rights reserved.
//

import UIKit




extension UIButton {
    
    func setupTheme(borderColor: UIColor,
                    borderWidth: CGFloat,
                    backgroundColorNormal: UIColor? = nil,
                    backgroundColorHighlighted: UIColor? = nil,
                    cornerRadius: CGFloat,
                    titleColor: UIColor? = nil,
                    titleColorHighlighted: UIColor? = nil,
                    title: String? = nil,
                    titleFont: UIFont? = nil
        ) {
        
        self.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        
        if let titleFont = titleFont {
            self.titleLabel?.font = titleFont
        }
        
        if let title = title {
            self.setTitle(title, for: UIControlState.normal)
            self.setTitle(title, for: UIControlState.highlighted)
        }
        
        if let titleColor = titleColor {
            self.setTitleColor(titleColor, for: UIControlState.normal)
        }
        
        if let titleColorHighlighted = titleColorHighlighted {
            self.setTitleColor(titleColorHighlighted, for: UIControlState.highlighted)
        }
        
        if let backgroundColorNormal = backgroundColorNormal {
            self.setBackgroundImage(UIImage.imageWithColor(color: backgroundColorNormal), for: UIControlState.normal)
        }
        
        if let backgroundColorHighlighted = backgroundColorHighlighted {
            self.setBackgroundImage(UIImage.imageWithColor(color: backgroundColorHighlighted), for: UIControlState.highlighted)
        }
    }

}


extension UIImage {

    class func imageWithColor(color: UIColor) -> UIImage? {
        
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        color.setFill()
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }

}



extension UITextField {
    
    func setupTheme(
        borderColor: UIColor?,
        borderWidth: CGFloat?,
        backgroundColor: UIColor? = nil,
        cornerRadius: CGFloat,
        textColor: UIColor,
        textFont: UIFont? = nil,
        placeholderText: String? = nil,
        placeholderColor: UIColor? = nil,
        placeholderFont: UIFont? = nil
        ) {
        
        self.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        
        if let borderWidth = borderWidth, let borderColor = borderColor {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = borderWidth
        }
        self.layer.cornerRadius = cornerRadius
        
        if let backgroundColor = backgroundColor {
            self.layer.backgroundColor = backgroundColor.cgColor
        }
        
        if let textFont = textFont {
            self.font = textFont
        }
        
        self.textColor = textColor
        
        if let placeholderText = placeholderText,
            let placeholderColor = placeholderColor,
            let placeholderFont = placeholderFont {
            
            self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSForegroundColorAttributeName: placeholderColor, NSFontAttributeName: placeholderFont])
        }
    }

}


extension UIColor {

    // let red = UIColor(hex: "#ff0000")
    convenience init?(hex: String)
    {
        guard hex.hasPrefix("#") else {
            print("invalid rgb string, missing '#' as prefix")
            return nil
        }
        
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        let alpha: CGFloat = 1.0
        
        let index   = hex.index(hex.startIndex, offsetBy: 1)
        let hex     = hex.substring(from: index)
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        
        if scanner.scanHexInt64(&hexValue) {
            red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
            green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
            blue  = CGFloat(hexValue & 0x0000FF) / 255.0
        } else {
            print("scan hex error, your string should be a hex string of 7 chars. ie: #ebb100")
            return nil
        }
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }

}
