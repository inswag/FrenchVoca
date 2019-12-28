//
//  AVSpeechSynthesizer.swift
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
    }
    
}


