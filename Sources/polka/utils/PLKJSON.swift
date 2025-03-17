//
//  PLKJSON.swift
//
//  Created by Sapien on 4/14/16.
//  Copyright © 2016 Polka. All rights reserved.
//

import Foundation
import SwiftyJSON

public class PLKJSON: NSObject {
    
    public static func decode(string data: String) -> JSON? {
        return decode(data: data.data(using: .utf8)!)
    }
    
    public static func decode(data: Data) -> JSON? {
        return try? JSON(data: data)
    }
    
    public static func encode(object: AnyObject) -> String? {
        let data:Data = try! JSONSerialization.data(withJSONObject: object, options: [])
        return String(data: data as Data, encoding: .utf8)
    }
    
    
}
