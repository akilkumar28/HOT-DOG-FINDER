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
    
    @IBOutlet weak var resultLabel: UILabel!
    var ImagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = .camera
        ImagePicker.allowsEditing = true
        resultLabel.isHidden = true
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
            guard let results = request.results as? [VNClassificationObservation] else {fatalError("model prediciting image error occured")}
        
            if let firstItem = results.first {
                if firstItem.identifier.contains("hotdog") {
                    self.navigationItem.title = "HOT DOG"
                    self.resultLabel.isHidden = true
                    
                }else{
                    self.navigationItem.title = "NOT-A-HOT-DOG"
                    self.resultLabel.isHidden = false
                    let chance = (firstItem.confidence) * 100
                    let predicitedName = firstItem.identifier
                    self.resultLabel.text = "There is a \(chance) chance that this can be a \(predicitedName)"
                }
            }
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

