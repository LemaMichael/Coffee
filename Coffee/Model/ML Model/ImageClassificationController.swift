//
//  ImageClassificationController.swift
//  Coffee
//
//  Created by Michael Lema on 9/27/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import UIKit

open class ImageClassificationController<Service: ClassificationServiceProtocol>: UIViewController  {
    /// Service used to perform gender, age and emotion classification
    public let classificationService: Service = .init()
    /// Status bar style
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - View lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        classificationService.setup()
    }
    

    
    
    // MARK: - UIImagePickerControllerDelegate
    
//    public func imagePickerController(_ picker: UIImagePickerController,
//                                      didFinishPickingMediaWithInfo info: [String : Any]) {
//        let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
//        guard let image = editedImage, let ciImage = CIImage(image: image) else {
//            print("Can't analyze selected photo")
//            return
//        }
//
//
//        // Run Core ML classifier
//        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
//            self?.classificationService.classify(image: ciImage)
//        }
//    }
}

