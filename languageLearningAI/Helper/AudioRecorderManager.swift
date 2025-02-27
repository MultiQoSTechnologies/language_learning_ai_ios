//
//  AudioRecorderManager.swift
//  languageLearningAI
//
//  Created by MQF-6 on 24/02/25.
//

import Foundation
import AVFoundation

class AudioRecorderManager: NSObject, AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder?
    var recordingSession: AVAudioSession!

    // Directory to save the WAV file
    var audioFilename: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsDirectory.appendingPathComponent("recording.wav")
    }

    func requestPermission(completion: @escaping (Bool) -> Void) {
        do {
            recordingSession = AVAudioSession.sharedInstance()
            try recordingSession.setCategory(.playAndRecord, mode: .default, options: [])
            try recordingSession.setActive(true)
        } catch let e {
            print("recordingSession : \(e.localizedDescription)")
        }
 
        recordingSession.requestRecordPermission { allowed in
            DispatchQueue.main.async {
                completion(allowed)
            }
        }
    }

    func startRecording() {
        let settings: [String: Any] = [
            AVFormatIDKey: kAudioFormatLinearPCM, // PCM format for WAV
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
            AVLinearPCMBitDepthKey: 16,
            AVLinearPCMIsBigEndianKey: false,
            AVLinearPCMIsFloatKey: false
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
            print("Recording started...")
        } catch {
            print("Recording failed: \(error.localizedDescription)")
        }
    }

    func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
        print("Recording stopped. Saved at: \(audioFilename)")
    }
}
