//
//  PLKLabel.swift
//
//  Created by Sapien on 4/18/16.
//  Copyright © 2016 Polka. All rights reserved.
//

import UIKit

@IBDesignable
public class PLKLabel: UILabel {
    
    @IBInspectable public var topInset:CGFloat     = 0
    @IBInspectable public var bottomInset:CGFloat  = 0
    @IBInspectable public var leftInset:CGFloat    = 0
    @IBInspectable public var rightInset:CGFloat   = 0
    
    public override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    public override var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
    
}
