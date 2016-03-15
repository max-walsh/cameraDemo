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

    // Main imageview
    @IBOutlet weak var imageView: UIImageView!
    
    // Indicates whether new photo has been taken
    var newMedia : Bool?
    
    @IBAction func useCamera(sender: AnyObject) {
        
        // Check if device has a camera
        // Only camera not video
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            
            // Set delegate and source for UIImagePickerController
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera // Assume camera only, if using video need to check for source type here
            imagePicker.mediaTypes = [kUTTypeImage as NSString as String] // Sets mediaType to image, also have option here to add video as type in array
            imagePicker.allowsEditing = false
            
            // Display camera interface
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
            // Indicates that a new photo has been taken
            newMedia = true
        
        // Else device does not have a camera; display alert
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if mediaType == kUTTypeImage as! String {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            
            imageView.image = image
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                    "image:didFinishSavingWithError:contextInfo:", nil)
            }
            
        }  else if mediaType == kUTTypeMovie as! String {
            // Code to support video here
            print("video")
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                message: "Failed to save image",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true,
                completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}

