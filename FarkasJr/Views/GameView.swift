//
//  GameView.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 17/02/2023.
//

import SwiftUI

struct GameView: View {
    
    @Binding var instrument: Instrument
    @StateObject var gameController: GameController
    @StateObject var audioController = AudioController()
    let noteDisplaySize: CGSize = CGSize(width: 300, height: 200)
    
    init(instrument: Binding<Instrument>) {
        self._instrument = instrument
        self._gameController = StateObject(wrappedValue: GameController(instrument: instrument.wrappedValue))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text(gameController.gameText)
                    .font(.title)
                NoteDisplayView(note: $gameController.currentNote, instrument: instrument, size: noteDisplaySize)
                    .padding(.horizontal)
                if [GameState.checkingNote, GameState.checkingFingering].contains(gameController.gameState) {
                    ForEach(gameController.currentAnswers, id: \.id) { answer in
                        AnswerButton(answer: answer, buttonAction: gameController.answerPressed(isCorrect:))
                    }
                } else if gameController.gameState == .listening {
                    ArrowView(playedNoteData: audioController.data, currentNoteNum: gameController.noteSoundingNum)
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(instrument: .constant(Instrument.hornF))
    }
}