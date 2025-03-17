//
//  PLKColor.swift
//
//  Created by Sapien on 4/15/16.
//  Copyright © 2016 Polka. All rights reserved.
//

import UIKit

public class PLKColor: NSObject {
    
    // Creates a UIColor from a Hex UInt32 and alpha 1.0
    public static func colorWithHex(hex6: UInt32) -> UIColor {
        return colorWithHex(hex6: hex6, withAlpha: 1.0);
    }
    
    // Creates a UIColor from a Hex UInt32.
    public static func colorWithHex(hex6: UInt32, withAlpha alpha: CGFloat) -> UIColor {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha);
    }
    
    // Creates a UIColor from a Hex string.
    public static func colorWithHexString (hex:String) -> UIColor {
        let hex = hex.trimmingCharacters(in: NSCharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}
