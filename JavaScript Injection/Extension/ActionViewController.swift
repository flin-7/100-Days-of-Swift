//
//  ActionViewController.swift
//  Extension
//
//  Created by Felix Lin on 11/22/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
    @IBOutlet weak var script: UITextView!
    
    var pageTitle = ""
    var pageURL = ""
    
    var userDefaults: UserDefaults!
    var savedScript =  [String: String]()
    var keyName = "customJSExtension"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userDefaults = UserDefaults.standard
        savedScript = userDefaults.dictionary(forKey: keyName) as? [String: String] ?? [:]
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addScript))
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        let loadButton = UIBarButtonItem(title: "Load", style: .plain, target: self, action: #selector(load))
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addScript))
        
        navigationItem.leftBarButtonItems = [addButton, saveButton, loadButton, doneButton]
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                }
            }
        }
    }

    @IBAction func done() {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text as Any]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext?.completeRequest(returningItems: [item])
        
        if let hostName = URL(string: pageURL)?.host! {
            let hostKey = "[autosaved from]" + hostName
            savedScript[hostKey] = script.text
            userDefaults.set(savedScript, forKey: keyName)
        }
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        let selectRange = script.selectedRange
        script.scrollRangeToVisible(selectRange)
    }

    @objc func addScript() {
        let ac = UIAlertController(title: "Choose Script", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "alert(document.title);", style: .default) { [weak self] (action) in
            self?.script.text = action.title
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    @objc func save() {
        let ac = UIAlertController(title: "Name script", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] _ in
            if let savedName = ac.textFields![0].text {
                self?.savedScript[savedName] = self?.script.text
                self?.userDefaults.set(self?.savedScript, forKey: self?.keyName ?? "")
                self?.userDefaults.set(self?.script.text, forKey: savedName)
            }
        }))
        present(ac, animated: true)
    }
    
    @objc func load() {
        let scriptsVC = ScriptsViewController()
        scriptsVC.actionViewController = self
        present(scriptsVC, animated: true)
    }
}
