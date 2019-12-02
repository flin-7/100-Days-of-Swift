//
//  DetailViewController.swift
//  Milestone 7
//
//  Created by Felix Lin on 12/1/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var script: UITextView!
    
    let defaults = UserDefaults.standard
    let key = "notes"
    let notificationCenter = NotificationCenter.default
    
    var notes = [Note]()
    var noteDetail: Note?
    var indexOfNote: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        
        if let noteTitle = noteDetail?.title {
            script.text = noteTitle
        }
        
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            script.scrollIndicatorInsets = .zero
            navigationItem.setRightBarButton(nil, animated: true)
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom + 5.00, right: 20)
            script.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
            navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done)), animated: true)
        }
        
        let selectRange = script.selectedRange
        script.scrollRangeToVisible(selectRange)
    }
    
    @objc func done() {
        let customDate = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        
        if noteDetail != nil {
            noteDetail?.title = script.text
            noteDetail?.date = customDate
            notes[indexOfNote!] = noteDetail!
            save()
        } else {
            let newNote = Note(title: script.text, date: customDate)
            notes.append(newNote)
            save()
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
