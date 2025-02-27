//
//  ConversationVC.swift
//  languageLearningAI
//
//  Created by MQF-6 on 24/02/25.
//

import UIKit
import GoogleGenerativeAI
import Lottie

class ConversationVC: UIViewController {
    
    @IBOutlet weak var viewMic: UIView!
    @IBOutlet weak var animationView: LottieAnimationView!
    
    let audioManager = AudioRecorderManager()
    let elevenLabsManager = ElevenLabsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.audioManager.requestPermission { _ in
            self.elevenLabsManager.startConversation()
        }
        animationView.loopMode = .loop
        animationView.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        elevenLabsManager.stopConversation()
    } 
}
