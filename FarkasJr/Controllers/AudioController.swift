//
//  AudioController.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 13/02/2023.
//

import Foundation
import SwiftUI
import AudioKit
import AudioKitEX
import SoundpipeAudioKit
import AVFoundation

class AudioController: ObservableObject {
    
    @Published var data: PlayedNoteData = PlayedNoteData()
    
    let engine = AudioEngine()
    let initialDevice: Device

    let mic: AudioEngine.InputNode
    let tappableNodeA: Fader
    let tappableNodeB: Fader
    let tappableNodeC: Fader
    let silence: Fader

    var tracker: PitchTap!
    
    init() {
        
        do {
            Settings.bufferLength = .medium
            try AVAudioSession.sharedInstance().setPreferredIOBufferDuration(Settings.bufferLength.duration)
            try AVAudioSession.sharedInstance().setCategory(.playAndRecord,
                                        options: [.defaultToSpeaker, .mixWithOthers, .allowBluetoothA2DP])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let err {
            print(err)
        }
        
        guard let input = engine.input else { fatalError() }

        guard let device = engine.inputDevice else { fatalError() }

        initialDevice = device

        mic = input
        tappableNodeA = Fader(mic)
        tappableNodeB = Fader(tappableNodeA)
        tappableNodeC = Fader(tappableNodeB)
        silence = Fader(tappableNodeC, gain: 0)
        engine.output = silence

        tracker = PitchTap(mic) { pitch, amp in
            DispatchQueue.main.async {
                self.update(pitch[0], amp[0])
            }
        }
        start()
    }
    
    func start() {
        do {
            try engine.start()
            tracker.start()
        } catch let err {
            Log(err)
        }
    }
    
    func shutDown() {
        engine.stop()
    }
    
    func update(_ pitch: AUValue, _ amp: AUValue) {
        guard amp > 0.1 else { return }
        data.frequency = pitch
        data.amp = amp
    }
    
}
