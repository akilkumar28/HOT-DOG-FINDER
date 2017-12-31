//
//  ViewController.swift
//  HOTDOG-OR-NOT-A-HOTDOG
//
//  Created by AKIL KUMAR THOTA on 12/31/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var myImageView: UIImageView!
    
    var ImagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = .camera
        ImagePicker.allowsEditing = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myImageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func camerTapped(_ sender: Any) {
        present(ImagePicker, animated: true, completion: nil)
    }
    

}

