//
//  UITextField+insets.swift
//  MVVM-Skeleton
//
//  Created by andrei on 23/11/2016.
//  Copyright © 2016 andrei. All rights reserved.
//

import UIKit


open class UITextField_insets : UITextField {
    
    // insets
    var textEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
    var clearButtonEdgeInsets = UIEdgeInsets.zero
    var rightViewInsets = UIEdgeInsetsMake(0, 0, 0, -10)
    var leftViewInsets = UIEdgeInsetsMake(0, 10, 0, 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(super.textRect(forBounds: bounds), textEdgeInsets)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
    
    override open func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.clearButtonRect(forBounds: bounds)
        rect.origin.x += clearButtonEdgeInsets.right
        rect.origin.y += clearButtonEdgeInsets.top
        return rect
    }
    
    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.rightViewRect(forBounds: bounds)
        rect.origin.x += rightViewInsets.right
        rect.origin.y += rightViewInsets.top
        return rect
    }
    
    override open func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.leftViewRect(forBounds: bounds)
        rect.origin.x += leftViewInsets.left
        rect.origin.y += leftViewInsets.top
        return rect
    }
    
}

