//
//  PLKDate.swift
//
//  Created by Sapien on 4/18/16.
//  Copyright © 2016 Polka. All rights reserved.
//

import Foundation

public class PLKDate: NSDate {
    
    public static func fromStringGMT(string: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        
        return dateFormatter.date(from: string) as Date?
    }
    
    public static func toLocalString(date: NSDate, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = NSLocale.current
        dateFormatter.timeZone = NSTimeZone.local
        
        return dateFormatter.string(from: date as Date)
    }
    
    public static func timeAgoSinceDate(date:NSDate, customFormat format:(String)) -> String {
        
        let deltaSeconds:Double = fabs(date.timeIntervalSinceNow);
        let deltaMinutes:Double = deltaSeconds / 60.0;
        
        if(deltaSeconds < 60) {
            return NSLocalizedString("Justo ahora", comment: "")
        }
        else if (deltaMinutes < 60) {
            return NSString(format: NSLocalizedString("Hace %i minutos", comment: "") as NSString, Int(deltaMinutes)) as String
        }
        else if (deltaMinutes < (24 * 60)) {
            let hours:Double = floor(deltaMinutes/60);
            return NSString(format: NSLocalizedString("Hace %i horas", comment: "") as NSString, Int(hours)) as String
        }
        else {
            let hours:Double = floor(deltaMinutes/60);
            let days:Double = round(hours / 24)
            
            if(days == 1) {
                return NSLocalizedString("Ayer", comment: "")
            }
            
        }
        
        return self.toLocalString(date: date, format: format)
    }
    
}
