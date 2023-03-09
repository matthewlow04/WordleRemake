//
//  ViewController.swift
//  WordleRemake
//
//  Created by Matthew Low on 2023-03-08.
//

import UIKit

class ViewController: UIViewController {
    
    var wordleLabel: UILabel!
    var textLabel: UILabel!
    var keyboardLabel: UILabel!
    var currentAnswer: UITextField!
    var displayBox = [UILabel]()
    var keyboard = [UIButton]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = UIView()
        view.backgroundColor = .white
        
        wordleLabel = UILabel()
        wordleLabel.translatesAutoresizingMaskIntoConstraints = false
        wordleLabel.text = "W O R D L E"
        wordleLabel.font = UIFont.systemFont(ofSize: 24)
        wordleLabel.textAlignment = .center
        view.addSubview(wordleLabel)
         
        textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        view.addSubview(textLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.textAlignment = .center
        view.addSubview(currentAnswer)
        
        keyboardLabel = UILabel()
        keyboardLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardLabel)
        
        let submit = UIButton(type: .system)//default type
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)//default type
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        
        
        
        NSLayoutConstraint.activate([
            
            wordleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 25),
            wordleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
    
            textLabel.topAnchor.constraint(equalTo: wordleLabel.bottomAnchor, constant: 10),
            textLabel.widthAnchor.constraint(equalToConstant: 400),
            textLabel.heightAnchor.constraint(equalToConstant: 425),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            currentAnswer.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10),
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalToConstant: 200),
            
            keyboardLabel.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor,constant: 10),
            keyboardLabel.widthAnchor.constraint(equalToConstant: 350),
            keyboardLabel.heightAnchor.constraint(equalToConstant: 170),
            keyboardLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            submit.topAnchor.constraint(equalTo: keyboardLabel.bottomAnchor, constant: 10),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            submit.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            clear.topAnchor.constraint(equalTo: submit.topAnchor),
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.heightAnchor.constraint(equalTo: submit.heightAnchor),
            clear.bottomAnchor.constraint(equalTo: submit.bottomAnchor)
            
            
        ])
        
        //make game display
        
        let width = 50
        let height = 50
        
        for row in 0..<6{
            for column in 0..<5{
                
                let displayLabel = UILabel()
                let frame = CGRect(x: 25+column*75, y: row*75, width: width, height: height)
                displayLabel.frame = frame
                displayLabel.backgroundColor = .blue
                textLabel.addSubview(displayLabel)
                displayBox.append(displayLabel)
            }
            
        }
        
        //make letter buttons
        let buttonWidth = 30
        let buttonHeight = 50
        for row in 0..<3{
            for column in 0..<9{
                let letterButton = UIButton(type: .system)
                let buttonFrame = CGRect(x: column*40, y: row*60, width: buttonWidth, height: buttonHeight)
                letterButton.frame = buttonFrame
                letterButton.backgroundColor = .gray
                keyboardLabel.addSubview(letterButton)
                keyboard.append(letterButton)
            }
        }
        
        
        textLabel.backgroundColor = .red
        keyboardLabel.backgroundColor = .red
        currentAnswer.backgroundColor = .green
        
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Stats", style: .plain, target: self, action: #selector(statsOpened))
 
    }
    
    @objc func statsOpened(){
        let ac = UIAlertController(title: "Stats", message: "HI", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac,animated: true)
    }
    @objc func submitTapped(_ sender: UIButton){
        
    }
    @objc func clearTapped(_ sender: UIButton){
        
    }


}

