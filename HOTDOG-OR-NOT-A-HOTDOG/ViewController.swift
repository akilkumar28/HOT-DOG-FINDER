//
//  ViewController.swift
//  HOTDOG-OR-NOT-A-HOTDOG
//
//  Created by AKIL KUMAR THOTA on 12/31/17.
//  Copyright © 2017 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var myImageView: UIImageView!
    
    var ImagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.allowsEditing = true
    }

    
    @IBAction func camerTapped(_ sender: Any) {
        present(ImagePicker, animated: true, completion: nil)
    }
    

}

