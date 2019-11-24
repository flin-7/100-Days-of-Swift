//
//  ScriptsViewController.swift
//  Extension
//
//  Created by Felix Lin on 11/23/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import UIKit

class ScriptsViewController: UITableViewController {
    
    var keys = [String]()
    var actionViewController: ActionViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupKeys()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func setupKeys() {
        keys = Array(actionViewController.savedScript.keys).sorted()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = keys[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actionViewController.script.text = actionViewController.savedScript[keys[indexPath.row]]
        dismiss(animated: true)
    }

}
