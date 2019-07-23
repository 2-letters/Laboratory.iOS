//
//  ImagePickable.swift
//  Laboratory
//
//  Created by Developers on 6/26/19.
//  Copyright © 2019 2Letters. All rights reserved.
//

import UIKit

protocol ImagePickable: class {
    func didSelect(image: UIImage)
}

class ImagePicker: NSObject {
    private let pickerController = UIImagePickerController()
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickable?
    
    init(presentationController: UIViewController, delegate: ImagePickable) {
        super.init()
        
//        pickerController = UIImagePickerController()
        self.presentationController = presentationController
        self.delegate = delegate
        
        pickerController.delegate = self
        pickerController.allowsEditing = true
//        pickerController.mediaTypes = ["public.image"]
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    // TODO break this function
    func present(from sourceView: UIView) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if let action = action(for: .camera, title: "Take photo") {
            alertController.addAction(action)
        }
        if let action = action(for: .savedPhotosAlbum, title: "Camera roll") {
            alertController.addAction(action)
        }
        if let action = action(for: .photoLibrary, title: "Photo library") {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // check if the device is an iPad & set the proper source view & rect if it's needed, otherwise the app will crash on iPads
        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }
        
        alertController.view.accessibilityIdentifier = AccessibilityId.addImageActionSheet.description
        
        presentationController?.present(alertController, animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        if let image = image {
            delegate?.didSelect(image: image)
        }
    }
}

extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        self.pickerController(picker, didSelect: nil)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return pickerController(picker, didSelect: nil)
        }
        pickerController(picker, didSelect: image)
    }
}
