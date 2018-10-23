//
//  ViewController.swift
//  compVision
//
//  Created by Caleb  on 10/22/18.
//  Copyright © 2018 CalebGrant. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting the initial title when this view loads
        self.navigationItem.title = "Tap camera to begin"
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        // make this true if u wanna be able to edit photo
        imagePicker.allowsEditing = false
        
        
    }
    
    // gets called when image is chosen and u wanna do something to the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // the image that user has selected
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // if we can downcast this data to a UIImage, execute this code:
            imageView.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert UIImage to CIImage")
            }
            
            // calling the method we created beloww
            detect(image: ciimage)
            
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    func detect(image: CIImage) {
        
        // try means it will attempt to perform the operation that might throw an error
        // if it throws an error, then model is nil aka NULL
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreML Model Failed.")
        }
        
        // at this point, we know that model exists
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            
            if let firstResult = results.first {
                self.navigationItem.title = firstResult.identifier
                
            }
        }
        
        // we will now create a handler that specifies which image
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
        
        
        
    }
    

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}

