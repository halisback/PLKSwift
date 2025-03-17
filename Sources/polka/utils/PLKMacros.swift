//
//  PLKMacros.swift
//
//  Created by Sapien on 5/11/16.
//  Copyright © 2016 Polka. All rights reserved.
//

import UIKit

public struct PLKScreenSize
{
    public static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    public static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    public static let SCREEN_MAX_LENGTH = max(PLKScreenSize.SCREEN_WIDTH, PLKScreenSize.SCREEN_HEIGHT)
    public static let SCREEN_MIN_LENGTH = min(PLKScreenSize.SCREEN_WIDTH, PLKScreenSize.SCREEN_HEIGHT)
}

public struct PLKDeviceType
{
    public static let IS_IPHONE_4_OR_LESS =  UIDevice.current.userInterfaceIdiom == .phone && PLKScreenSize.SCREEN_MAX_LENGTH < 568.0
    public static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && PLKScreenSize.SCREEN_MAX_LENGTH == 568.0
    public static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && PLKScreenSize.SCREEN_MAX_LENGTH == 667.0
    public static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && PLKScreenSize.SCREEN_MAX_LENGTH == 736.0
    public static let IS_PAD = UIDevice.current.userInterfaceIdiom == .pad
}
