//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
  var score : Int = 0
  
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextQuestion()
        updateUI()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
      if sender.tag == 1 {
        // Choose true
        pickedAnswer = true
      } else {
        // Choose false
        pickedAnswer = false
      }
      
      questionNumber += 1
      checkAnswer()
      nextQuestion()
      
    }
    
    
    func updateUI() {
      if questionNumber > 0 {
        scoreLabel.text = String("Score: \(score)")
        progressLabel.text = String(" \(questionNumber+1)/\(allQuestions.list.count) ")
      } else {
        scoreLabel.text = "Score: 9999"
        progressLabel.text = "1/\(allQuestions.list.count)"
      }
      progressBar.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.list.count)) * CGFloat(questionNumber+1)
    }
  
    func nextQuestion() {
      if questionNumber < allQuestions.list.count {
        questionLabel.text = allQuestions.list[questionNumber].questionText
      } else {
        let alert = UIAlertController(title: "Finished", message: "There are no more questions!.", preferredStyle: .alert)
        alert.view.tintColor = UIColor.white
        let mainSubview = alert.view.subviews.last?.subviews.last?.subviews[0];
        
        mainSubview?.subviews[0].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        mainSubview?.subviews[1].backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
          NSLog("The \"OK\" alert occured.")
          self.startOver()
        }))
        self.present(alert, animated: true, completion: nil)
      }
    }
  
    func checkAnswer() {
      if questionNumber < allQuestions.list.count {
        let correctAnswer = allQuestions.list[questionNumber].answer
        if pickedAnswer == correctAnswer {
          ProgressHUD.showSuccess("Correct")
          score += 1
        } else {
          ProgressHUD.showError("Wrong!")
        }
        updateUI()
      }
    }
  
    func startOver() {
       questionNumber = 0
       score = 0
       updateUI()
       nextQuestion()
    }
}
