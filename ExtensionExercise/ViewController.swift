//
//  ViewController.swift
//  ExtensionExercise
//
//  Created by mrJacob on 6/26/14.
//  Copyright (c) 2014 Vokal. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {
    
    @IBOutlet var shareButton: UIButton
    @IBOutlet var mainImageView: UIImageView
    
    @IBAction func shareButtonWasTapped(sender: AnyObject) {
        let image = self.mainImageView.image
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        weak var weakImageView = self.mainImageView
        activityViewController.completionWithItemsHandler = {(activityType :String!, completed :Bool, returnedItems :AnyObject[]!, error :NSError!) -> Void in
            if returnedItems {
                var extensionItem = returnedItems[0] as NSExtensionItem
                var itemProvider = extensionItem.attachments[0] as NSItemProvider
                if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeImage) {
                    itemProvider.loadItemForTypeIdentifier(kUTTypeImage, options: nil, completionHandler:{(image, error) in
                        if let checkedImage = image {
                            dispatch_async(dispatch_get_main_queue(), {
                                if let checkedImageView = weakImageView {
                                    println(checkedImage)
                                    checkedImageView.image = checkedImage as UIImage
                                }
                                })
                        }
                        })
                }
            }
        }
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    
    
    
}

