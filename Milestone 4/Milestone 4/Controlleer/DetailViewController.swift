//
//  DetailViewController.swift
//  Milestone 4
//
//  Created by Felix Lin on 11/5/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        
        title = setupTitle()
        
        if let image = selectedImage {
            imageView.image = UIImage(contentsOfFile: image)
        }
    }
    
    func setupTitle() -> String {
        if let name = imageName {
            return name
        }
        return "The photo name is unavailable"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
