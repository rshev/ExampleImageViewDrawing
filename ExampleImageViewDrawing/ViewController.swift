//
//  ViewController.swift
//  ExampleImageViewDrawing
//
//  Created by asdfgh1 on 05/03/2019.
//  Copyright © 2019 Roman Shevtsov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFit
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerVC = UIImagePickerController()
        pickerVC.delegate = self
        present(pickerVC, animated: true, completion: nil)
    }

    @IBAction func didDoubleTap(_ sender: Any) {
        guard let image = imageView.image else {
            return
        }
        let renderer = UIGraphicsImageRenderer(size: image.size, format: image.imageRendererFormat)
        let renderedImage = renderer.image { (context) in
            return imageView.drawHierarchy(in: imageView.bounds, afterScreenUpdates: true)
        }

        let activityVC = UIActivityViewController(activityItems: [renderedImage], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        defer {
            picker.dismiss(animated: true, completion: nil)
        }
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        imageView.image = image
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
