//
//  GameController.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 17/02/2023.
//

import Foundation

class GameController: ObservableObject {

    let instrument: Instrument
    @Published var currentNote: Note
    @Published var gameState: GameState = .checkingNote
    @Published var gameText: String = "What note is this?"
    @Published var currentAnswers: [Answer] = []
    @Published var roundNumber: Int = 0
    var answeredCorrectly = true
    let numberOfRounds = GameData.gameDuration
    var noteSoundingNum: Int { currentNote.num - instrument.transposition }
    
    init(instrument: Instrument) {
        self.instrument = instrument
        self.currentNote = instrument.activeNotes.randomElement()!
        nextQuestion()
    }
    
    func nextQuestion() {
        roundNumber += 1
        currentNote = instrument.activeNotes.randomElement()!
        currentAnswers = generateAnswers(correctAnswer: currentNote.name, possibleAnswers: instrument.noteStrings)
        gameText = "What note is this?"
        answeredCorrectly = true
    }
    
    func nextState() {
        switch gameState {
        case .checkingNote:
            gameState = .checkingFingering
            currentAnswers = generateAnswers(correctAnswer: instrument.getFingeringString(num: currentNote.num) , possibleAnswers: instrument.fingeringStrings)
            gameText = "What fingering is a \(currentNote.name)"
        case .checkingFingering:
            gameText = "Play a \(currentNote.name)"
            gameState = .listening
        case .listening:
            if roundNumber == numberOfRounds {
                gameState = .finished
                gameText = "Finished!"
                return
            } else {
                nextQuestion()
                gameState = .checkingNote
            }
        case .finished:
            return
        }
    }
    
    func generateAnswers(correctAnswer: String, possibleAnswers: [String]) -> [Answer] {
        var answers = possibleAnswers.map { Answer(description: $0, isCorrect: $0 == correctAnswer) }.shuffled()
        let correctIndex = answers.firstIndex { $0.isCorrect }!
        answers.remove(at: correctIndex)
        answers = Array(answers.prefix(3))
        return (answers + [Answer(description: correctAnswer, isCorrect: true)]).shuffled()
    }
    
    func answerPressed(isCorrect: Bool) {
        if !isCorrect {
            answeredCorrectly = false
            return
        }
        nextState()
    }
}

enum GameState {
    case checkingNote, checkingFingering, listening, finished
}
