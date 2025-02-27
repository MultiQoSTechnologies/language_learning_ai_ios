//
//  MenuVC.swift
//  languageLearningAI
//
//  Created by MQF-6 on 21/02/25.
//

import UIKit

class MenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Menu"

    }

}


extension MenuVC {
    @IBAction private func btnQuizAction(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "QuizVC") as! QuizVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func btnAskAction(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AskVC") as! AskVC
        navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction private func btnConversationAction(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ConversationVC") as! ConversationVC
        navigationController?.pushViewController(vc, animated: true)

    }
}
