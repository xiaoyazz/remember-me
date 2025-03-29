//
//  AudioDelegate.swift
//  remember-me
//
//  Created by Mathew Boyd on 2025-03-29.
//

import AVFoundation

class AudioDelegate: NSObject, AVSpeechSynthesizerDelegate {
    var onFinish: (() -> Void)?
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        onFinish?()
    }
}
