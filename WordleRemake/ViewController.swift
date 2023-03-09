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
        
        NSLayoutConstraint.activate([
            wordleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            wordleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        
        ])
        
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Stats", style: .plain, target: self, action: #selector(statsOpened))
        // Do any additional setup after loading the view.
    }
    
    @objc func statsOpened(){
        let ac = UIAlertController(title: "Stats", message: "HI", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac,animated: true)
    }


}

