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


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = UIView()
        view.backgroundColor = .white
        
        wordleLabel = UILabel()
        wordleLabel.translatesAutoresizingMaskIntoConstraints = false
        wordleLabel.text = "W O R D L E"
        wordleLabel.font = UIFont.systemFont(ofSize: 30)
        wordleLabel.textAlignment = .center
        view.addSubview(wordleLabel)
        
        textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "HI"
        view.addSubview(textLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentAnswer)
        
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
            wordleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            wordleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    
            textLabel.topAnchor.constraint(equalTo: wordleLabel.bottomAnchor, constant: 25),
            textLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 25),
            textLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: -25),
            
            currentAnswer.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 25),
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            
        ])
        
        
        textLabel.backgroundColor = .red
        
        
        
        
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

