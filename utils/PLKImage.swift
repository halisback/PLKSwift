//
//  PLKImage.swift
//
//  Created by Sapien on 4/21/16.
//  Copyright © 2016 Polka. All rights reserved.
//

import UIKit
import CoreImage

public class PLKImage: UIImage {
    
    public static func imageScalingToBounds(image: UIImage, width: CGFloat, height: CGFloat) -> UIImage {
        
        let size = image.size
        
        let widthRatio  = width  / image.size.width
        let heightRatio = height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    public static func imageScalingAndCropping(image:UIImage, targetSize:CGSize) -> UIImage? {
        
        let sourceImage:UIImage = image;
        var newImage:UIImage?;
        
        let imageSize:CGSize = sourceImage.size;
        let width:CGFloat  = imageSize.width;
        let height:CGFloat = imageSize.height;
        let targetWidth:CGFloat  = targetSize.width;
        let targetHeight:CGFloat  = targetSize.height;
        var scaleFactor:CGFloat = 0.0;
        var scaledWidth:CGFloat  = targetWidth;
        var scaledHeight:CGFloat  = targetHeight;
        var thumbnailPoint:CGPoint  = CGPoint(x: 0.0, y: 0.0);
    
        if (imageSize.equalTo(targetSize) == false) {
            let widthFactor:CGFloat  = targetWidth / width;
            let heightFactor:CGFloat  = targetHeight / height;
    
            if (widthFactor > heightFactor) {
                scaleFactor = widthFactor; // scale to fit height
            }
            else {
                scaleFactor = heightFactor; // scale to fit width
            }
    
            scaledWidth  = width * scaleFactor;
            scaledHeight = height * scaleFactor;
    
            // center the image
            if (widthFactor > heightFactor) {
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            }
            else {
                if (widthFactor < heightFactor) {
                    thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
                }
            }
        }
    
        UIGraphicsBeginImageContext(targetSize); // this will crop
    
        var thumbnailRect:CGRect  = CGRect.zero;
        thumbnailRect.origin = thumbnailPoint;
        thumbnailRect.size.width  = scaledWidth;
        thumbnailRect.size.height = scaledHeight;
    
        sourceImage.draw(in: thumbnailRect)
    
        newImage = UIGraphicsGetImageFromCurrentImageContext();
    
        if(newImage == nil) {
            print("PLKImage :: error scaling image")
        }
    
        //pop the context to get back to the default
        UIGraphicsEndImageContext();
    
        return newImage;
    }
    
}


public extension UIImage {
    public var rounded: UIImage? {
        let imageView = UIImageView(image: self)
        imageView.layer.cornerRadius = min(size.height/2, size.width/2)
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    public var circle: UIImage? {
        let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = .scaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}

public extension UIImageView{
    
    public func makeBlurImage() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    
}

