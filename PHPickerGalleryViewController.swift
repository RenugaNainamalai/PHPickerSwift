//
//  PHPickerGalleryViewController.swift
//  GalleryManager
//
//  Created by Renuga Nainamalai on 12/04/21.
//  Copyright © 2021 ImpigerTechnologies. All rights reserved.
//

import UIKit
import PhotosUI
@available(iOS 14, *)
class PHPickerGalleryViewController: UIViewController
{
    
    @IBOutlet weak var phImageView: UIImageView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func phPickerButtonAction(_ sender: Any) {
       pickImages()
    }
    
}
@available(iOS 14, *)
extension PHPickerGalleryViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
       
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) {_,_ in
                let previousImage = self.phImageView.image
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    DispatchQueue.main.async {
                        guard let self = self, let image = image as? UIImage, self.phImageView.image == previousImage else { return }
                        self.phImageView.image = image
                    }
                }
            }
        }
        
    }
    func pickImages(){
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 0
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
}

