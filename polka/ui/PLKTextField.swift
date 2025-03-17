//
//  PLKTextField.swift
//
//  Created by Sapien on 5/12/16.
//  Copyright © 2016 Polka. All rights reserved.
//

import UIKit

@IBDesignable
public class PLKTextField: UITextField {
    
    @IBInspectable public var topInset:CGFloat     = 0
    @IBInspectable public var bottomInset:CGFloat  = 0
    @IBInspectable public var leftInset:CGFloat    = 0
    @IBInspectable public var rightInset:CGFloat   = 0
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + self.leftInset, y: bounds.origin.y + self.topInset, width: bounds.size.width - self.leftInset - self.rightInset, height: bounds.size.height - self.topInset - self.bottomInset);
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
    
    
}
