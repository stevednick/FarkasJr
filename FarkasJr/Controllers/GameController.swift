//
//  GameController.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 17/02/2023.
//

import Foundation
import Combine

class GameController: ObservableObject {
    
    // MARK: - Properties

    @Published var currentNote: Note
    @Published var gameState: GameState = .checkingNote
    @Published var gameText: String = "What note is this?"
    @Published var currentAnswers: [Answer] = []
    @Published var roundNumber: Int = 0
    @Published var playedNoteData = PlayedNoteData()
    @Published var correctNoteHeard = false
    @Published var correctClicked = false
    
    let instrument: Instrument
    
    var answeredCorrectly = false
    var correctAnswers = 0
    let numberOfRounds = GameData.gameDuration
    var noteSoundingNum: Int { currentNote.num - instrument.transposition }
    let audioController = AudioController()

    var recentPlayedNotes: [Int] = []
    var cancellable: AnyCancellable = AnyCancellable({})

    
    // MARK: - Init

    
    init(instrument: Instrument) {
        self.instrument = instrument
        self.currentNote = instrument.activeNotes.randomElement()!
        self.cancellable = audioController.$data
            .sink() {
                self.playedNoteData = $0
                if self.gameState == .listening {
                    self.playedNoteDataReceived($0)
                }
            }
        nextQuestion()
    }
    
    // MARK: - State Machine
    
    func restart() {
        roundNumber = 0
        nextQuestion()
        correctAnswers = 0
        gameState = .checkingNote
    }
    
    func nextState() {
        switch gameState {
        case .checkingNote:
            gameState = .checkingFingering
            currentAnswers = generateAnswers(correctAnswer: instrument.getFingeringString(num: currentNote.num) , possibleAnswers: instrument.fingeringStrings)
            gameText = "What fingering is this \(currentNote.name)"
        case .checkingFingering:
            gameText = "Play this \(currentNote.name)"
            recentPlayedNotes = []
            gameState = .listening
        case .listening:
            if roundNumber == numberOfRounds {
                gameState = .finished
                if answeredCorrectly { correctAnswers += 1}
                gameText = "Score \(correctAnswers)/\(numberOfRounds)"
                return
            } else {
                nextQuestion()
                gameState = .checkingNote
            }
        case .finished:
            restart()
        }
    }

    // MARK: - Questions/Answers

    func nextQuestion() {
        roundNumber += 1
        
        var availableNotes = instrument.activeNotes
        if availableNotes.count > 1 {
            availableNotes.removeAll { $0.num == currentNote.num && $0.accidental == currentNote.accidental}
        }
        currentNote = availableNotes.randomElement()!
        currentAnswers = generateAnswers(correctAnswer: currentNote.name, possibleAnswers: instrument.noteStrings)
        gameText = "What note is this?"
        if answeredCorrectly { correctAnswers += 1}
        answeredCorrectly = true
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
        correctClicked = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.correctClicked = false
            self.nextState()
        }
    }
    
    // MARK: - Dealing with playedNoteData

    
    func playedNoteDataReceived(_ data: PlayedNoteData) {
        
        let arrayLength = 20
        let correctValuesRequired = 15
        
        recentPlayedNotes.append(data.noteWithTuning.num)
        if recentPlayedNotes.count > arrayLength {
            recentPlayedNotes.removeFirst()
        }
        
        if recentPlayedNotes.filter({ $0 == noteSoundingNum }).count >= correctValuesRequired && !correctNoteHeard{
            correctNoteHeard = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.nextState()
                self.correctNoteHeard = false
            }
            
        }
    }

}

enum GameState {
    case checkingNote, checkingFingering, listening, finished
}
