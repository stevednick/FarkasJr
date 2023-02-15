//
//  playedNoteData.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 13/02/2023.
//

import Foundation

struct NoteWithTuning {
    let num: Int
    let tuning: Float
}

struct PlayedNoteData {
    
    let AFrequency: Float = 440.0
    var frequency: Float = 0
    var amp: Float = 0
    
    var num: Float {
        let ratio = frequency/AFrequency
        return (12.0 * log2(ratio)) + 9
    }
    var noteWithTuning: NoteWithTuning {
        return NoteWithTuning(num: Int(round(num)), tuning: num - round(num))
    }
    
}
