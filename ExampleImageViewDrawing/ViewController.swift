//
//  ViewController.swift
//  ExampleImageViewDrawing
//
//  Created by asdfgh1 on 05/03/2019.
//  Copyright © 2019 Roman Shevtsov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var scrollView: UIScrollView!

    private var imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pickerVC = UIImagePickerController()
        pickerVC.delegate = self
        present(pickerVC, animated: true, completion: nil)
    }

    @IBAction func didDoubleTap(_ sender: Any) {
        guard
            let imageView = imageView,
            let image = imageView.image
        else {
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

        let imageView = UIImageView(image: image)
        self.imageView = imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
