//
//  ViewController.swift
//  Storm Viewer
//
//  Created by Felix Lin on 9/28/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(loadPictures), with: nil)
    }
    
    @objc func loadPictures() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path).sorted()
        
        for item in items {
            if item.hasPrefix("nssl") {
                // this is a picture to load
                pictures.append(item)
            }
        }
        
        print(pictures)
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Image", for: indexPath) as? PictureCell else {
            fatalError("Unable to dequeue cell")
        }
        cell.imageView.image = UIImage(named: pictures[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            let picture = pictures[indexPath.row]
            vc.selectedImage = picture
            vc.totalPictures = pictures.count
            if let index = pictures.firstIndex(of: picture) {
                vc.selectedPictureNumber = index + 1
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
