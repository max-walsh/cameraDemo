//
//  ViewController.swift
//  cameraDemo
//
//  Created by Max Walsh on 3/4/16.
//  Copyright © 2016 Max Walsh. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    var newMedia : Bool?
    
    @IBAction func useCamera(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) { // only camera not video?
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.mediaTypes = [kUTTypeImage as NSString as String, kUTTypeMovie as NSString as String]
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
            newMedia = true
        } else {
            let alert = UIAlertController(
                title: "No Camera",
                message: "Sorry, this device does not have a camera",
                preferredStyle:  .Alert)
            let action = UIAlertAction(
                title: "OK",
                style: .Default,
                handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
            
        }

    }
    
    
    // button for accesing the camera roll
    @IBAction func useCameraRoll(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.SavedPhotosAlbum) {
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                imagePicker.mediaTypes = [kUTTypeImage as NSString as String]
                imagePicker.allowsEditing = false
                self.presentViewController(imagePicker, animated: true, completion: nil)
                newMedia = false // no picture was taken, leaves imageview the same
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

