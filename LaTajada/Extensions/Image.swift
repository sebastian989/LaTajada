//
//  Image.swift
//  LaTajada
//
//  Created by Sebastián on 14/11/14.
//  Copyright (c) 2014 Sebastián. All rights reserved.
//

import Foundation

extension UIImage {
    
    func borderStyle(var cornerRadius : CGFloat, var borderWidth : CGFloat) -> UIImage {
        // Build a context that's the same dimensions as the new size
        var context : CGContextRef = CGBitmapContextCreate(nil, UInt(self.size.width), UInt(self.size.height), CGImageGetBitsPerComponent(self.CGImage), 0, CGImageGetColorSpace(self.CGImage), CGImageGetBitmapInfo(self.CGImage))
        
        // Create a clipping path with rounded corners
        CGContextBeginPath(context);
        self.addRoundedRectToPath(CGRectMake(CGFloat(borderWidth), CGFloat(borderWidth), self.size.width - borderWidth * 2, self.size.height - borderWidth * 2),
            context: context,
            ovalWidth: cornerRadius,
            ovalHeight: cornerRadius)
        
        CGContextClosePath(context);
        CGContextClip(context);
        
        // Draw the image to the context; the clipping path will make anything outside the rounded rect transparent
        CGContextDrawImage(context, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
        
        // Create a CGImage from the context
        var clippedImage : CGImageRef = CGBitmapContextCreateImage(context)
    
        //CGContextRelease(context);
        
        // Create a UIImage from the CGImage
        var roundedImage = UIImage(CGImage: clippedImage)
        //CGImageRelease(clippedImage);
        
        return roundedImage!;
    }
    
    func addRoundedRectToPath(var rect : CGRect, var context : CGContextRef, var ovalWidth : CGFloat, var ovalHeight : CGFloat) {
        
        if ovalWidth == 0 || ovalHeight == 0
        {
            CGContextAddRect(context, rect)
            return;
        }
        
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect))
        CGContextScaleCTM(context, ovalWidth, ovalHeight)
        var fw : CGFloat = CGRectGetWidth(rect) / ovalWidth;
        var fh : CGFloat = CGRectGetHeight(rect) / ovalHeight;
        CGContextMoveToPoint(context, fw, fh/2);
        CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
        CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
        CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
        CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
        CGContextClosePath(context);
        CGContextRestoreGState(context);
    }
}
