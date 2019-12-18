//
//  PickerController.swift
//  Piggy
//
//  Created by Jean Paul Marinho on 14/01/17.
//  Copyright © 2017 aKANJ. All rights reserved.
//

import UIKit
import AssetsLibrary

class PickerController: NSObject {
    
    static let shared = PickerController()
    var completionCallback: ((_ image: UIImage) -> ())?
    var vc: UIViewController?
    
    func showPicker(in vc: UIViewController, completion: @escaping (_ image: UIImage) -> ()) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.vc = vc
        vc.present(imagePicker, animated: true, completion: nil)
        self.completionCallback = completion
    }
}



extension PickerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        completionCallback!(image!)
        vc?.dismiss(animated: true, completion: nil)
    }
}
