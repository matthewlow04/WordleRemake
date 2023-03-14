//
//  ViewController.swift
//  WordleRemake
//
//  Created by Matthew Low on 2023-03-08.
//


/*
 1.move code to load game function
 2. check if it's an english word
 3. get the word from either a txt file or a word generator
 4. add stats
 
 */

import UIKit

class ViewController: UIViewController {
    
    var wordleLabel: UILabel!
    var textLabel: UILabel!
    var currentAnswer: UITextField!
    var displayBox = [UILabel]()
    var keyboard = [UIButton]()
    var recentlyPressed = [UIButton]()
    var answer: String = ""
    var winstreak = 0
    var numberOfSubmits = 0
    
    override func loadView() {
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
        currentAnswer.placeholder = "Tap the keyboard"
        currentAnswer.isUserInteractionEnabled = false
        currentAnswer.textAlignment = .center
        view.addSubview(currentAnswer)
        
        let keyboardLabel = UILabel()
        keyboardLabel.translatesAutoresizingMaskIntoConstraints = false
        keyboardLabel.isUserInteractionEnabled = true
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
                displayLabel.font = UIFont.systemFont(ofSize: 24)
                displayLabel.textAlignment = .center
                displayLabel.backgroundColor = UIColor.lightGray
                textLabel.addSubview(displayLabel)
                displayBox.append(displayLabel)
            }
            
        }
        
        //make letter buttons
        
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ "
        let alphabetArray = Array(alphabet)
        let buttonWidth = 30
        let buttonHeight = 50
        for row in 0..<3{
            for column in 0..<9{
                let letterButton = UIButton(type: .system)
                letterButton.addTarget(self, action: #selector(letterButtonTapped), for: .touchUpInside)
                let buttonFrame = CGRect(x: column*40, y: row*60, width: buttonWidth, height: buttonHeight)
                letterButton.frame = buttonFrame
                keyboardLabel.addSubview(letterButton)
                keyboard.append(letterButton)
            }
        }
        
        if keyboard.count == alphabetArray.count{
            for i in 0..<keyboard.count{
                keyboard[i].setTitle("\(alphabetArray[i])", for: .normal)
            }
        }
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Stats", style: .plain, target: self, action: #selector(statsOpened))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
      

    }
    
    func loadLevel(){
        numberOfSubmits = 0
        currentAnswer.text = ""
        for i in 0..<displayBox.count{
            displayBox[i].text = ""
        }
        
        var wordBank = [String]()
        let website = "https://www-cs-faculty.stanford.edu/~knuth/sgb-words.txt"
        if let urlString = URL(string: website){
            if let textContents = try? String (contentsOf: urlString){
                wordBank += textContents.components(separatedBy: "\n")
            }
        }
        
        wordBank.shuffle()
        
        answer = wordBank[0].uppercased()
        
    }
    @objc func letterButtonTapped(_ sender: UIButton){
        guard let buttonTitle = sender.titleLabel?.text else{return}
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        recentlyPressed.append(sender)
    }
    @objc func statsOpened(){
        let ac = UIAlertController(title: "Stats", message: "Your current winstreak is \(winstreak)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac,animated: true)
    }
    @objc func submitTapped(_ sender: UIButton){
      
        guard let guess = currentAnswer?.text else {return}
        
        if realWord(word: "\(answer)") == false{
            error()
            currentAnswer.text = ""
            return
        }
        
        if guess.count != 5{
            error()
            currentAnswer.text = ""
            return
        }
        
        let guessArray = Array(guess)
        let answerArray = Array(answer)
        
        for i in 0..<5{
            let index = (numberOfSubmits*5)+(i)
            if guessArray[i] == answerArray[i]{
                displayBox[index].textColor = .green
            }
            else if answerArray.contains(guessArray[i]){
                displayBox[index].textColor = .yellow
            }
            else{
                displayBox[index].textColor = .red
            }
            
            displayBox[index].text = "\(guessArray[i])"
        }
        numberOfSubmits += 1
       
        
        if guess == answer{
            winstreak += 1
            let ac = UIAlertController(title: "You win", message: "Congrats", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: gameDone))
            present(ac, animated: true)
            return
        }
        
        if numberOfSubmits == 6{
            winstreak = 0
            let ac = UIAlertController(title: "Game Over", message: "The answer was \(answer)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: gameDone))
            present(ac, animated: true)
            return
        }
        
    }
    @objc func clearTapped(_ sender: UIButton){
        currentAnswer.text = ""
        recentlyPressed.removeAll()
    }
    
    func gameDone(action: UIAlertAction){
        loadLevel()
    }
    
    func realWord(word:String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    func error(){
        let ac = UIAlertController(title: "Error", message: "Invalid Input", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }


}

