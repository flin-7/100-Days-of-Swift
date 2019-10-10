//
//  ListViewController.swift
//  Easy Browser
//
//  Created by Felix Lin on 10/8/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    var websites = ["hackingwithswift.com", "apple.com"]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Easy Browser"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Website", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? WebViewController {
            vc.selectedWebsite = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
