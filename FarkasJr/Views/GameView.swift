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
    //@StateObject var audioController = AudioController()
    let noteDisplaySize: CGSize = CGSize(width: 300, height: 300)
    
    init(instrument: Binding<Instrument>) {
        self._instrument = instrument
        self._gameController = StateObject(wrappedValue: GameController(instrument: instrument.wrappedValue))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if gameController.gameState == .finished {
                    Text("Finished!")
                        .font(.system(size: 40, weight: .semibold, design: .rounded))
                }
                Text(gameController.gameText)
                    .font(.title)
                NoteDisplayView(note: $gameController.currentNote, instrument: instrument, size: noteDisplaySize)
                    .padding(.horizontal)
                if [GameState.checkingNote, GameState.checkingFingering].contains(gameController.gameState) {
                    VStack {
                        ForEach(gameController.currentAnswers, id: \.id) { answer in
                            AnswerButton(answer: answer, buttonAction: gameController.answerPressed(isCorrect:), correctClicked: $gameController.correctClicked)
                        }
                    }
                    .frame(height: 300)
                    
                } else if gameController.gameState == .listening {
                    ArrowView(playedNoteData: gameController.playedNoteData, currentNoteNum: gameController.noteSoundingNum, correctNoteHeard: gameController.correctNoteHeard)
                } else if gameController.gameState == .finished {
                    Button("Start Again") {
                        gameController.nextState()
                    }
                    .foregroundColor(Color(.white))
                    .frame(width: 200, height: 80)
                    .font(.largeTitle)
                    .background(.blue)
                    .cornerRadius(10)
                    .padding(.vertical, 110) // to get the overall frame up to 300
                }
            }
        }
        .navigationViewStyle(.stack)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("        Score: \(gameController.correctAnswers)")
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("Question \(gameController.roundNumber) of \(gameController.numberOfRounds)")
            }
        })
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(instrument: .constant(Instrument.hornF))
    }
}
