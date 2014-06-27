//
//  ActionViewController.swift
//  ExtensionExerciseExtension
//
//  Created by mrJacob on 6/26/14.
//  Copyright (c) 2014 Vokal. All rights reserved.
//

import UIKit
import MobileCoreServices
import ImageFilter

class ActionViewController: UIViewController {

    @IBOutlet var imageView :UIImageView
    var convertedImage : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        var imageFound = false
        for item: AnyObject in self.extensionContext.inputItems! {
            let inputItem = item as NSExtensionItem
            for provider: AnyObject in inputItem.attachments! {
                let itemProvider = provider as NSItemProvider
                if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeImage) {
                    // This is an image. We'll load it, then place it in our image view.
                    itemProvider.loadItemForTypeIdentifier(kUTTypeImage, options: nil, completionHandler: { (image, error) in
                        if image {
                            let colorCubeImage = UIImage(named: "colorCube_inverse")
                            let context = CIContext(options: nil)
                            self.convertedImage = ImageFilterProcess.processImage(image: image as UIImage, onContext: context, withColorCubeImage: colorCubeImage)
                            dispatch_async(dispatch_get_main_queue(), {
                                self.imageView.image = self.convertedImage!
                                })
                        }
                        })
                    
                    imageFound = true
                    break
                }
            }
            
            if (imageFound) {
                // We only handle one image, so stop looking for more.
                break
            }
        }
    }
    
    func sendImageBack (image :UIImage) {
        let extensionItem = NSExtensionItem()
        extensionItem.attachments = [NSItemProvider(item: image, typeIdentifier: kUTTypeImage)]
        self.extensionContext.completeRequestReturningItems([extensionItem], completionHandler: nil)
    }

    @IBAction func done() {
        self.sendImageBack(self.convertedImage!)
    }

}
