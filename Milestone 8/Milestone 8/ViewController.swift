//
//  ViewController.swift
//  Milestone 8
//
//  Created by Felix Lin on 12/15/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import UIKit

enum Position {
    case top, bottom
}

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var topText = ""
    var bottomText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Meme"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
    }
    
    @objc func shareTapped() {
        let sharedImage = drawTextAndImage()
        let vc = UIActivityViewController(activityItems: [sharedImage], applicationActivities: [])
        present(vc, animated: true)
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        imageView.image = image
        
        dismiss(animated: true) {
            let ac = UIAlertController(title: "Add text", message: nil, preferredStyle: .alert)
            
            ac.addTextField { tf in
                tf.placeholder = "Top text"
            }
            
            ac.addTextField { tf in
                tf.placeholder = "Bottom text"
            }
            
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] _ in
                self?.topText = ac.textFields![0].text ?? ""
                self?.bottomText = ac.textFields![1].text ?? ""
                self?.imageView.image = self?.drawTextAndImage()
            }))
            self.present(ac, animated: true)
        }
    }
    
    func drawTextAndImage() -> UIImage {
        guard let baseImage = imageView.image else { return UIImage() }
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: imageView.frame.width, height: imageView.frame.height))
        let image = renderer.image { ctx in
            
            let rect = CGRect(x: 0, y: 0, width: imageView.frame.width, height: imageView.frame.height)
            baseImage.draw(in: rect)
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key:Any] = [
                // This font is a default so force unwraping.
                .font: UIFont(name: "Optima-ExtraBlack", size: 36)!,
                .foregroundColor: UIColor.white,
                .strokeColor: UIColor.black,
                .strokeWidth: -1.0,
                .paragraphStyle: paragraphStyle
            ]
            
            for i in 0...1 {
                var textToPlace = ""
                var textRect = CGRect()
                if i == 0 {
                    textRect = CGRect(x: 0,
                                      y: 0,
                                      width: imageView.frame.width,
                                      height: imageView.frame.height/2)
                    textToPlace = topText
                } else {
                    textRect = CGRect(x: 0,
                                      y: imageView.frame.height - 80,
                                      width: imageView.frame.width,
                                      height: imageView.frame.height/2)
                    textToPlace = bottomText
                }
                
                let text = NSAttributedString(string: textToPlace.uppercased(), attributes: attrs)
                UIColor.black.setStroke()
                ctx.cgContext.strokePath()
                text.draw(with: textRect, options: .usesLineFragmentOrigin, context: nil)
            }
        }
        
        return image
    }
}

