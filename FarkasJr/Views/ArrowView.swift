//
//  ArrowView.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 19/02/2023.
//

import SwiftUI

struct ArrowView: View { // Almost entirely crafted by ChatGPT...
    
    let playedNoteData: PlayedNoteData
    let currentNoteNum: Int
    let value: Int
    let ampThreshold: Float = 0.1
    
    init(playedNoteData: PlayedNoteData, currentNoteNum: Int) {
        self.playedNoteData = playedNoteData
        self.currentNoteNum = currentNoteNum
        self.value = playedNoteData.noteWithTuning.num - currentNoteNum
    }
    
    // Sort this to recieve playedNoteData, know what the expected note is show correctly... Not such a problem?
    
    var body: some View {
        let absValue = abs(value)
        let scaleFactor = absValue == 0 ? 5.0 : (log(Double(absValue) + 1.0) / log(41.0)) * 6.0 + 2.0
        let arrowHeight = CGFloat(20) * scaleFactor
        
        return VStack {
            if playedNoteData.amp > ampThreshold {
                if value == 0 {
                    Image(systemName: "hand.thumbsup.fill")
                        .font(.system(size: arrowHeight))
                        .foregroundColor(.green)
                } else {
                    Image(systemName: value > 0 ? "arrow.down" : "arrow.up")
                        .font(.system(size: arrowHeight))
                }
            }
        }
        .frame(height: 200)
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView(playedNoteData: PlayedNoteData(), currentNoteNum: 0)
    }
}
