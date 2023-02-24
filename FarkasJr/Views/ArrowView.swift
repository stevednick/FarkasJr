//
//  ArrowView.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 19/02/2023.
//

import SwiftUI

struct ArrowView: View {
    
    let playedNoteData: PlayedNoteData
    let currentNoteNum: Int
    let value: Int
    let correctNoteHeard: Bool
    
    init(playedNoteData: PlayedNoteData, currentNoteNum: Int, correctNoteHeard: Bool) {
        self.playedNoteData = playedNoteData
        self.currentNoteNum = currentNoteNum
        self.value = playedNoteData.noteWithTuning.num - currentNoteNum
        self.correctNoteHeard = correctNoteHeard
    }
    
    var body: some View {
        var ballOffset: CGFloat {
            let valueToReturn = CGFloat(value) * -15.0
            return max(-150, min(valueToReturn, 150))
        }
        let lineLength: CGFloat = 250
        let lineWidth: CGFloat = 4
        let ballSize: CGFloat = 20
        
        return HStack {
            if correctNoteHeard {
                Image(systemName: "hand.thumbsup.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.green)
            } else {
                ZStack {
                    Rectangle()
                        .frame(width: lineLength, height: lineWidth)
                        .foregroundColor(.black)
                    Text("Too High")
                        .font(.title2)
                        .offset(CGSize(width: -90, height: -70))
                    Text("Too Low")
                        .font(.title2)
                        .offset(CGSize(width: -90, height: 70))
                    if playedNoteData.ampThresholdMet {
                        Circle()
                            .frame(width: ballSize, height: ballSize)
                            .foregroundColor(value == 0 ? .black : .red)
                            .offset(y: ballOffset)
                            .animation(.linear(duration: 0.3), value: ballOffset)
                    }
                }
            }
        }
        .frame(height: 300)
    }
}
struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView(playedNoteData: PlayedNoteData(), currentNoteNum: 0, correctNoteHeard: false)
    }
}
