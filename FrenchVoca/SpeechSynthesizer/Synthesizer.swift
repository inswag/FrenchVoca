//
//  Synthesizer.swift
//  FrenchVoca
//
//  Created by 박인수 on 22/11/2019.
//  Copyright © 2019 inswag. All rights reserved.
//

import Foundation
import AVFoundation

class Synthesizer: AVSpeechSynthesizer {
    
    static let shared = Synthesizer()
    
    override init() {
        print("Initialization")
        super.init()
        setupSilentMode()
        
    }
    
    func setupSilentMode() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        }
        catch let error as NSError {
            print("Error: Could not set audio category: \(error), \(error.userInfo)")
        }

        do {
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch let error as NSError {
            print("Error: Could not setActive to true: \(error), \(error.userInfo)")
        }
    }
}


