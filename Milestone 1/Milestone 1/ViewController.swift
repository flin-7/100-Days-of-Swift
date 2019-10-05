//
//  ViewController.swift
//  Milestone 1
//
//  Created by Felix Lin on 10/5/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Milestone 1"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path).sorted()
        
        for item in items {
            if item.hasSuffix("@3x.png") {
                let name = item.components(separatedBy: "@")[0].uppercased()
                flags.append(name)
            }
        }
        
        print(flags)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        cell.textLabel?.text = flags[indexPath.row]
        cell.imageView?.image = UIImage(named: "\(flags[indexPath.row].lowercased())@3x.png")
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        cell.imageView?.layer.borderWidth = 1
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = "\(flags[indexPath.row].lowercased())@3x.png"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

