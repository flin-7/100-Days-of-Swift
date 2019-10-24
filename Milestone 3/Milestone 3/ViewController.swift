//
//  ViewController.swift
//  Milestone 3
//
//  Created by Felix Lin on 10/23/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let theLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    var currentAnswer: UITextField!
    var wordLabel: UILabel!
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    
    var allWords = [String]()
    var usedLetters = [Character]()
    var currentWord: String!
    var attempts = 0 {
        didSet {
            title = "Attempt: \(attempts)/7"
        }
    }
    
    override func loadView() {
        view = UIView()
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "_______"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 64)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            currentAnswer.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 12),
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonsView.widthAnchor.constraint(equalToConstant: 360),
            buttonsView.heightAnchor.constraint(equalToConstant: 400),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: 36),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -12)
        ])
        
        var letterCount = 0
        let width = 60
        let height = 60
        
        for row in 0..<5 {
            for column in 0..<6 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 44)
                letterButton.setTitle("_", for: .normal)
                letterButton.layer.borderWidth = 1
                letterButton.layer.borderColor = UIColor.lightGray.cgColor
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                let frame = CGRect(x: column * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
                letterCount += 1
            }
        }
        
        for (index, char) in theLetters.enumerated() {
            letterButtons[index].setTitle(String(char), for: .normal)
        }
        
        for button in letterButtons {
            if button.titleLabel?.text == "_" {
                button.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Attempt: \(attempts)/7"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(newGame))
        
        performSelector(inBackground: #selector(loadWords), with: nil)
    }

    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        usedLetters.append(Character(buttonTitle))
        sender.isEnabled = false
        
        if currentWord.contains(buttonTitle) {
            var newAnswerText = currentAnswer!.text
            for (index, char) in currentWord.enumerated() {
                if char == Character(buttonTitle) {
                    newAnswerText = String(newAnswerText!.prefix(index) + String(char) + newAnswerText!.dropFirst(index + 1))
                }
            }
            currentAnswer.text = newAnswerText
            
            if currentAnswer!.text?.contains("_") == false {
                let ac = UIAlertController(title: "You win!", message: "Do you want to try another one?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: nextRound))
                present(ac, animated: true)
                return
            }
        } else {
            attemptNumbers()
        }
    }
    
    @objc func newGame() {
        for button in letterButtons {
            button.isEnabled = true
        }
        
        usedLetters.removeAll(keepingCapacity: true)
        attempts = 0
        currentWord = allWords.randomElement()
        
        let numberChars = currentWord.count
        var i = 1
        var newEmptyField = ""
        while i <= numberChars {
            newEmptyField = newEmptyField + "_"
            i += 1
        }
        
        currentAnswer.text = newEmptyField
        print(currentWord!)
    }
    
    @objc func loadWords() {
        if let startWordsUrl = Bundle.main.url(forResource: "word", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsUrl) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        DispatchQueue.main.async {
            self.newGame()
        }
    }
    
    func attemptNumbers() {
        attempts += 1
        if attempts == 7 {
            let ac = UIAlertController(title: "Game Over", message: "You lose! The correct answer is \(currentWord!).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Try again?", style: .default, handler: nextRound))
            present(ac, animated: true)
        }
    }

    func nextRound(action: UIAlertAction) {
        newGame()
    }
}

