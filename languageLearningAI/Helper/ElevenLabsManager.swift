//
//  EvenLabsManager.swift
//  languageLearningAI
//
//  Created by MQF-6 on 24/02/25.
//

import ElevenLabsSDK
 

class ElevenLabsManager {
    private let config = ElevenLabsSDK.SessionConfig(agentId: kElevenSDKAgentId) // Provide a valid agentId
    
    private var callbacks = ElevenLabsSDK.Callbacks()
    
    private var conversation: ElevenLabsSDK.Conversation?

    
    init(callbacks: ElevenLabsSDK.Callbacks = ElevenLabsSDK.Callbacks()) {
        self.callbacks = callbacks
        
        self.callbacks.onConnect = { conversationId in
            print("Connected with ID: \(conversationId)")
        }
        self.callbacks.onMessage = { message, role in
            print("\(role.rawValue): \(message)")
        }
        self.callbacks.onError = { error, info in
            print("Error: \(error), Info: \(String(describing: info))")
        }
        self.callbacks.onStatusChange = { status in
            print("Status changed to: \(status.rawValue)")
        }
        self.callbacks.onModeChange = { mode in
            print("Mode changed to: \(mode.rawValue)")
        }
    }
    
    func startConversation() {
        Task {
            do {
                
                if conversation == nil {
                    conversation = try await ElevenLabsSDK.Conversation.startSession(config: config, callbacks: callbacks)
                }
                
                if let conversation = conversation {
                    conversation.startRecording()
                } else {
                    print("Failed to create conversation session.")
                }
            } catch {
                print("Failed to start conversation: \(error)")
            }
        }
    }
    
    func stopConversation() {
        Task {
            if let conversation = conversation {
                conversation.stopRecording()
                conversation.endSession()
                self.conversation = nil // Reset the conversation object after stopping
            } else {
                print("No active conversation to stop.")
            }
        }
    }
}
