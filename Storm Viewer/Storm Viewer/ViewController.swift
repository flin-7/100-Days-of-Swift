//
//  ViewController.swift
//  Storm Viewer
//
//  Created by Felix Lin on 9/28/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
    var pictureViewCount = [String: Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(loadPictures), with: nil)
        
        let defaults = UserDefaults.standard
        pictureViewCount = defaults.object(forKey: "ViewCount") as? [String: Int] ?? [String: Int]()
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
            self?.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            let picture = pictures[indexPath.row]
            vc.selectedImage = picture
            vc.totalPictures = pictures.count
            pictureViewCount[pictures[indexPath.row], default: 0] += 1
            if let index = pictures.firstIndex(of: picture) {
                vc.selectedPictureNumber = index + 1
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

