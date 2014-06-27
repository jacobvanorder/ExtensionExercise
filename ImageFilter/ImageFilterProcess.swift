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
    
    class func processImage (#image: UIImage, withColorCubeImage colorCubeImage: UIImage) -> UIImage? {
        
        let colorCubeFilter = InstaCubeGenerator.instaCubeWithKeyImage(colorCubeImage)
        
        var coreImage = CIImage(image: image) as CIImage?
        if let checkedCoreImage = coreImage {
            colorCubeFilter.setValue(checkedCoreImage, forKey: kCIInputImageKey)
            let outputCoreImage = colorCubeFilter.valueForKey(kCIOutputImageKey) as CIImage
            if let checkedOutputCoreImage = outputCoreImage as CIImage? {
                if let returnImage = UIImage(CIImage: checkedOutputCoreImage) as UIImage? {
                    return (returnImage.copy() as UIImage)
                }
            }
        }
        
        return nil
    }
}
