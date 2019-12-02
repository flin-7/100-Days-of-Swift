//
//  ViewController.swift
//  Milestone 7
//
//  Created by Felix Lin on 12/1/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let defaults = UserDefaults.standard
    let key = "notes"
    
    var notes = [Note]()
    
    override func viewWillAppear(_ animated: Bool) {
        if let savedNotes = defaults.object(forKey: key) as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                notes = try jsonDecoder.decode([Note].self, from: savedNotes)
                notes.sort { $0.date > $1.date }
            } catch {
                print("Failed to load notes.")
            }
            
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = notes[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            navigationController?.pushViewController(vc, animated: true)
            vc.noteDetail = notes[indexPath.row]
            vc.indexOfNote = indexPath.row
            vc.notes = notes
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            save()
        }
    }
    
    @objc func addNote() {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            navigationController?.pushViewController(vc, animated: true)
            vc.notes = notes
        }
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(notes) {
            defaults.set(savedData, forKey: key)
        } else {
            print("Failed to save note.")
        }
    }
}

