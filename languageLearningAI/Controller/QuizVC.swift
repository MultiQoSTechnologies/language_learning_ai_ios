//
//  ViewController.swift
//  languageLearningAI
//
//  Created by MQS_2 on 20/02/25.
//

import Foundation
import GoogleGenerativeAI
import UIKit

class QuizVC: UIViewController {

    @IBOutlet weak var tblQuestion: TableQuizQuestion!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Quiz"

        let model = GenerativeModel(
            name: "gemini-1.5-flash-latest", apiKey: kGeminiKey)

        // Combine the system message into the user's prompt
        //        You are well-versed in the English language. You gives vocabulary every words. Give four vocabulary for the word "Morning".
        let prompt = """
            Generate a new set of 10 unique vocabulary quiz questions. Each question should have four multiple-choice options labeled as 'a', 'b', 'c', and 'd'. Ensure that the questions and options vary every time the quiz is generated. The response should be in JSON format with the following structure:            
            {
              "quiz": [
                {
                  "question": "What is the meaning of the word 'Ephemeral'?",
                  "options": "options": [
            {
              "a": "lasting forever"
            },
            {
              "b": "lasting a very short time"
            },
            {
              "c": "extremely heavy"
            },
            {
              "d": "exceptionally bright"
            }
            ],
                  "answer": "a"
                },
              ]
            }
            """

        Task {
            UIApplication.showActivityIndicator()
            await contentStream(model: model, prompt: prompt)
        }
    }

    func contentStream(model: GenerativeModel, prompt: String) async {
        do {
            let response = try await model.generateContent(prompt)

            UIApplication.hideActivityIndicator()
            if let text = response.text {
                var cleanText = text

                if cleanText.hasPrefix("```json\n") {
                    if let newlineIndex = cleanText.firstIndex(of: "{") {
                        cleanText = String(cleanText[newlineIndex...])
                    }
                }

                if cleanText.hasSuffix("\n```\n") {
                    cleanText = String(cleanText.dropLast(5))
                }

                let jsonData = cleanText.data(using: .utf8)!
                
                let json = try JSONSerialization.jsonObject(with: jsonData)
                print(json)
                let model = try JSONDecoder().decode(
                    MDLQuestions.self, from: jsonData)
                
                DispatchQueue.main.async {
                    self.tblQuestion.questionData = model.quiz ?? []
                    self.tblQuestion.reloadData()
                    self.tblQuestion.layoutIfNeeded()
                }
                
            }
        } catch {
            UIApplication.hideActivityIndicator()
            print("Error: \(error.localizedDescription)")
        }
    }
}


extension QuizVC {
    @IBAction private func btnSubmitAction(_ sender: Any) {
        
        if tblQuestion.selected.count == 10 {
            let correctedAns: Int = 0
            
            let rightAns = self.tblQuestion.selected.filter({ $0.answer == $0.selectedAns})
            
            self.alertView(title: "", message: "Your score is \(rightAns.count)/10.", style: .alert, actions: [.Ok], handler: nil)
        } else {
            self.alertView(title: "", message: "Please answer all the questions.", style: .alert, actions: [.Ok], handler: nil)
        }
    }
}
