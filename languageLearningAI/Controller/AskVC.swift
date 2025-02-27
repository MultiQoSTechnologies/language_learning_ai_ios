//
//  AskVC.swift
//  languageLearningAI
//
//  Created by MQF-6 on 21/02/25.
//

import UIKit
import GoogleGenerativeAI
import CDMarkdownKit
import SwiftUI


class AskVC: UIViewController {

    @IBOutlet weak var tvUserInput: UITextView!
    @IBOutlet weak var lblAnser: UILabel!

    
    var prompt = """
        You are good at english language. if question related to english language then Answer query in detailed related to language otherwise say ask language related question.
    
        if question is related to specific word than you can give it's noun, pronoun, how to use this word in different situations etc explain it.
    
        if question is related to Grammar than you explain realted to tense(in short) and explain it.
    
        if question is Grammar is wrong than correct that first and than you explain realted to tense and explain in details.
    """
    
    
    let model = GenerativeModel(
        name: "gemini-1.5-flash-latest", apiKey: kGeminiKey)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension AskVC {
    @IBAction private func btnAskAction(_ sender: Any) {
        if tvUserInput.text == "Ask your doubt related to english" || tvUserInput.text == "" {
            return
        }
        
        let promptAsk = prompt + "\n User Asked: \(tvUserInput.text ?? "")"
        
        lblAnser.text = ""
        tvUserInput.resignFirstResponder()
        
        Task {
            UIApplication.showActivityIndicator()
            await contentStream(model: model, prompt: promptAsk)
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
                
                let m = CDMarkdownParser(font: .systemFont(ofSize: 16))
                
                lblAnser.isHidden = false
                lblAnser.attributedText = m.parse(cleanText)
                tvUserInput.text = "Ask your doubt related to english"
                tvUserInput.textColor = .gray

                print(cleanText)
            }
        } catch {
            UIApplication.hideActivityIndicator()
            print("Error: \(error.localizedDescription)")
        }
    }
}

extension AskVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Ask your doubt related to english" {
            textView.text = ""
            textView.textColor = .black
        } else {
            textView.textColor = .gray
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "Ask your doubt related to english" {
            textView.textColor = .gray
        } else {
            textView.textColor = .black
        }
    }
}
