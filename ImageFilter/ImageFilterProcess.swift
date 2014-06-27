//
//  ImageFilterProcess.swift
//  ExtensionExercise
//
//  Created by mrJacob on 6/26/14.
//  Copyright (c) 2014 Vokal. All rights reserved.
//

import UIKit
import InstaCube
import CoreImage

class ImageFilterProcess: NSObject {
    
    class func processImage (#image: UIImage, onContext context :CIContext, withColorCubeImage colorCubeImage: UIImage) -> UIImage? {

        let colorCubeFilter = InstaCubeGenerator.instaCubeWithKeyImage(colorCubeImage)
        
        if let rawCGImage = image.CGImage { //backed by CGImage
            if let ciImage = CIImage(CGImage: rawCGImage) as CIImage? {
                colorCubeFilter.setValue(ciImage, forKey: kCIInputImageKey)
            }
            else {
                return nil
            }
        }
        else {
            if let ciImage = image.CIImage {
                colorCubeFilter.setValue(ciImage, forKey: kCIInputImageKey)
            }
            else {
                return nil
            }
        }
        
        let outgoingCIImage = colorCubeFilter.valueForKey(kCIOutputImageKey) as CIImage
        
        let cgImage = context.createCGImage(outgoingCIImage, fromRect: outgoingCIImage.extent())
        
        return UIImage(CGImage: cgImage)
        
        
        
//        var coreImage = CIImage(image: image) as CIImage?
//        if let checkedCoreImage = coreImage {
//            colorCubeFilter.setValue(checkedCoreImage, forKey: kCIInputImageKey)
//            let outputCoreImage = colorCubeFilter.valueForKey(kCIOutputImageKey) as CIImage
//            if let checkedOutputCoreImage = outputCoreImage as CIImage? {
//                if let returnImage = UIImage(CIImage: checkedOutputCoreImage) as UIImage? {
//                    return (returnImage.copy() as UIImage)
//                }
//            }
//        }
//        
//        return nil
    }
}
