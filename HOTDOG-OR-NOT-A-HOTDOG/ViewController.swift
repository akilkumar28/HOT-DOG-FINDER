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
        if let userPickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myImageView.image = userPickedImage
            guard let ciimage = CIImage(image: userPickedImage) else {fatalError("image conversion failed")}
            detect(image: ciimage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func detect(image:CIImage) {
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {fatalError("loading coreML model failed")}
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let result = request.results as? [VNClassificationObservation] else {fatalError("model prediciting image error occured")}
            print(result)
        }
        let handler = VNImageRequestHandler(ciImage:image)
        
        do {
            try handler.perform([request])
        }catch{
            print(error.localizedDescription)
        }
    }

    
    @IBAction func camerTapped(_ sender: Any) {
        present(ImagePicker, animated: true, completion: nil)
    }
    

}

