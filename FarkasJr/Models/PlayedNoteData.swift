//
//  playedNoteData.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 13/02/2023.
//

import Foundation

struct PlayedNoteData {
    
    let CFrequency: Float = 256.0
    var frequency: Float = 0
    var amp: Float = 0
    
    var num: Float {
        let ratio = frequency/CFrequency
        return 12.0 * log2(ratio)
    }
}
