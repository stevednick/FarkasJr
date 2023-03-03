//
//  Instrument.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 08/02/2023.
//

import Foundation

struct Instrument: Codable, Identifiable {
    
    // MARK: - Variables

    
    let id: UUID
    let name: String
    var notes: [NoteByNum] = [NoteByNum]() // Replace this with NoteByNum
    let transposition: Int
    let fingeringOptions: [FingeringOptions]
    let clef: Clef
    
    var activeNotes: [Note] { // There is definitely a neater way to sort this out...
        var notesToReturn = [Note]()
        for nbn in self.notes {
            for note in nbn.notes {
                if note.isActive && note.level < 3 { notesToReturn.append(note) }
            }
        }
        return notesToReturn
    }
    
    var allNotes: [Note] {
        var notesToReturn = [Note]()
        for nbn in self.notes {
            for note in nbn.notes { notesToReturn.append(note) }
        }
        return notesToReturn
    }
    
    let availableFingerings: [Fingering]
    
    var fingeringStrings: [String] {
        return availableFingerings.map { $0.rawValue }
    }
    
    var noteStrings: [String] {
        return Array(Set(activeNotes.map { $0.name }))
    }
    
    // MARK: - Init

    init(id: UUID = UUID(), name: String, transposition: Int, fingeringOptions: [FingeringOptions], clef: Clef, availableFingerings: [Fingering]) {
        self.id = id
        self.name = name
        self.transposition = transposition
        self.fingeringOptions = fingeringOptions
        self.clef = clef
        self.availableFingerings = availableFingerings
        self.notes = getNoteList()
    }
    
    // MARK: - Functions

    func getNoteList() -> [NoteByNum]{
        return NoteStore.getNotes(fingeringOptionsList: self.fingeringOptions, clef: clef)
    }
    
    func getFingeringString(num: Int) -> String {
        return notes.first(where: { $0.num == num })!.fingering.rawValue
    }
    
    func fingeringOptionsByNum(_ num: Int) -> [Fingering] {
        return fingeringOptions.first(where: { $0.num == num})!.preferredFingerings
    }
}

// MARK: - Instrument Data

extension Instrument {
    
    // MARK: - Horn Data

    static var hornF: Instrument {
        return Instrument(
            name: "F Horn",
            transposition: 7,
            fingeringOptions: [
                FingeringOptions(num: -7, preferredFingerings: [.first]), // F
                FingeringOptions(num: -6, preferredFingerings: [.second]), // F#
                FingeringOptions(num: -5, preferredFingerings: [.open]), // G
                FingeringOptions(num: -4, preferredFingerings: [.secondAndThird]), // G#
                FingeringOptions(num: -3, preferredFingerings: [.firstAndSecond, .third]), // A
                FingeringOptions(num: -2, preferredFingerings: [.first]), // Bb
                FingeringOptions(num: -1, preferredFingerings: [.second]), // B
                FingeringOptions(num: 0, preferredFingerings: [.open]), // Middle C
                FingeringOptions(num: 1, preferredFingerings: [.firstAndSecond]), // C#
                FingeringOptions(num: 2, preferredFingerings: [.first]), // D
                FingeringOptions(num: 3, preferredFingerings: [.second]), // Eb
                FingeringOptions(num: 4, preferredFingerings: [.open]), // E
                FingeringOptions(num: 5, preferredFingerings: [.first]), // F
                FingeringOptions(num: 6, preferredFingerings: [.second]), // F#
                FingeringOptions(num: 7, preferredFingerings: [.open]), // G
                FingeringOptions(num: 8, preferredFingerings: [.secondAndThird]), // G#
                FingeringOptions(num: 9, preferredFingerings: [.firstAndSecond, .third]), // A
                FingeringOptions(num: 10, preferredFingerings: [.first]), // Bb
                FingeringOptions(num: 11, preferredFingerings: [.second]), // B
                FingeringOptions(num: 12, preferredFingerings: [.open]), // C
                FingeringOptions(num: 13, preferredFingerings: [.firstAndSecond]), // C#
                FingeringOptions(num: 14, preferredFingerings: [.first]), // D
                FingeringOptions(num: 15, preferredFingerings: [.second]), // Eb
                FingeringOptions(num: 16, preferredFingerings: [.open]), // E
            ],
            clef: .treble,
            availableFingerings: [.open, .first, .second, .third, .firstAndSecond, .secondAndThird, .firstAndThird, .firstSecondAndThird])
    }
    static var hornBb: Instrument {
        return Instrument(
            name: "Bb Horn",
            transposition: 7,
            fingeringOptions: [
                FingeringOptions(num: -7, preferredFingerings: [.open]), // F
                FingeringOptions(num: -6, preferredFingerings: [.firstSecondAndThird]), // F#
                FingeringOptions(num: -5, preferredFingerings: [.firstAndThird]), //G
                FingeringOptions(num: -4, preferredFingerings: [.secondAndThird]), // G#
                FingeringOptions(num: -3, preferredFingerings: [.firstAndSecond, .third]), // A
                FingeringOptions(num: -2, preferredFingerings: [.first]), // Bb
                FingeringOptions(num: -1, preferredFingerings: [.second]), // B
                FingeringOptions(num: 0, preferredFingerings: [.open]), // Middle C
                FingeringOptions(num: 1, preferredFingerings: [.secondAndThird]), // C#
                FingeringOptions(num: 2, preferredFingerings: [.firstAndSecond]), // D
                FingeringOptions(num: 3, preferredFingerings: [.first]), // Eb
                FingeringOptions(num: 4, preferredFingerings: [.second]), // E 1&2 added for testing.
                FingeringOptions(num: 5, preferredFingerings: [.open]), // F
                FingeringOptions(num: 6, preferredFingerings: [.firstAndSecond]), // F#
                FingeringOptions(num: 7, preferredFingerings: [.first, .firstAndThird]), //G
                FingeringOptions(num: 8, preferredFingerings: [.secondAndThird]), // G#
                FingeringOptions(num: 9, preferredFingerings: [.firstAndSecond, .third]), // A
                FingeringOptions(num: 10, preferredFingerings: [.first]), // Bb
                FingeringOptions(num: 11, preferredFingerings: [.second]), // B
                FingeringOptions(num: 12, preferredFingerings: [.open]), // C
                FingeringOptions(num: 13, preferredFingerings: [.secondAndThird]), // C#
                FingeringOptions(num: 14, preferredFingerings: [.firstAndSecond]), // D
                FingeringOptions(num: 15, preferredFingerings: [.first]), // Eb
                FingeringOptions(num: 16, preferredFingerings: [.second]), // E 1&2 added for testing.
                FingeringOptions(num: 17, preferredFingerings: [.open]), // F
            ],
            clef: .treble,
            availableFingerings: [.open, .first, .second, .third, .firstAndSecond, .secondAndThird, .firstAndThird, .firstSecondAndThird])
    }
    
    // MARK: - Trumpet Data
    
    static var trumpet: Instrument {
        return Instrument(
            name: "Trumpet",
            transposition: 2,
            fingeringOptions: [
                FingeringOptions(num: -3, preferredFingerings: [.firstAndSecond]),
                FingeringOptions(num: -2, preferredFingerings: [.first]),
                FingeringOptions(num: -1, preferredFingerings: [.second]),
                FingeringOptions(num: 0, preferredFingerings: [.open]), // Middle C
                FingeringOptions(num: 1, preferredFingerings: [.firstSecondAndThird]),
                FingeringOptions(num: 2, preferredFingerings: [.firstAndThird]),
                FingeringOptions(num: 3, preferredFingerings: [.secondAndThird]),
                FingeringOptions(num: 4, preferredFingerings: [.firstAndSecond]),
                FingeringOptions(num: 5, preferredFingerings: [.first]),
                FingeringOptions(num: 6, preferredFingerings: [.second]),
                FingeringOptions(num: 7, preferredFingerings: [.open]),
                FingeringOptions(num: 8, preferredFingerings: [.secondAndThird]),
                FingeringOptions(num: 9, preferredFingerings: [.firstAndSecond]),
                FingeringOptions(num: 10, preferredFingerings: [.first]),
                FingeringOptions(num: 11, preferredFingerings: [.second]),
                FingeringOptions(num: 12, preferredFingerings: [.open]),
                FingeringOptions(num: 13, preferredFingerings: [.firstAndSecond]),
                FingeringOptions(num: 14, preferredFingerings: [.first])
            ],
            clef: .treble,
            availableFingerings: [.open, .first, .second, .third, .firstAndSecond, .secondAndThird, .firstAndThird, .firstSecondAndThird])
    }
    
    // MARK: - Trombone Data
    
    static var tromboneBassClef: Instrument {
        return Instrument(
            name: "Trombone (Bass Clef)",
            transposition: 0,
            fingeringOptions: [
                FingeringOptions(num: -19, preferredFingerings: [.sixthPosition]),
                FingeringOptions(num: -18, preferredFingerings: [.fifthPosition]),
                FingeringOptions(num: -17, preferredFingerings: [.fourthPosition]),
                FingeringOptions(num: -16, preferredFingerings: [.thirdPosition]),
                FingeringOptions(num: -15, preferredFingerings: [.secondPosition]),
                FingeringOptions(num: -14, preferredFingerings: [.firstPosition]),
                FingeringOptions(num: -13, preferredFingerings: [.seventhPosition]),
                FingeringOptions(num: -12, preferredFingerings: [.sixthPosition]),
                FingeringOptions(num: -11, preferredFingerings: [.fifthPosition]),
                FingeringOptions(num: -10, preferredFingerings: [.fourthPosition]),
                FingeringOptions(num: -9, preferredFingerings: [.thirdPosition]),
                FingeringOptions(num: -8, preferredFingerings: [.secondPosition, .seventhPosition]),
                FingeringOptions(num: -7, preferredFingerings: [.firstPosition, .sixthPosition]),
                FingeringOptions(num: -6, preferredFingerings: [.fifthPosition]),
                FingeringOptions(num: -5, preferredFingerings: [.fourthPosition]),
                FingeringOptions(num: -4, preferredFingerings: [.thirdPosition, .seventhPosition]),
                FingeringOptions(num: -3, preferredFingerings: [.secondPosition, .sixthPosition]),
                FingeringOptions(num: -2, preferredFingerings: [.firstPosition, .fifthPosition])
            ],
            clef: .bass,
            availableFingerings: [.firstPosition, .secondPosition, .thirdPosition, .fourthPosition, .fifthPosition, .sixthPosition, .seventhPosition])
    }
    
    static var tromboneTrebleClef: Instrument {
        return Instrument(
            name: "Trombone (Treble Clef)",
            transposition: 14,
            fingeringOptions: [
                FingeringOptions(num: -5, preferredFingerings: [.sixthPosition]),
                FingeringOptions(num: -4, preferredFingerings: [.fifthPosition]),
                FingeringOptions(num: -3, preferredFingerings: [.fourthPosition]),
                FingeringOptions(num: -2, preferredFingerings: [.thirdPosition]),
                FingeringOptions(num: -1, preferredFingerings: [.secondPosition]),
                FingeringOptions(num: 0, preferredFingerings: [.firstPosition]),
                FingeringOptions(num: 1, preferredFingerings: [.seventhPosition]),
                FingeringOptions(num: 2, preferredFingerings: [.sixthPosition]),
                FingeringOptions(num: 3, preferredFingerings: [.fifthPosition]),
                FingeringOptions(num: 4, preferredFingerings: [.fourthPosition]),
                FingeringOptions(num: 5, preferredFingerings: [.thirdPosition]),
                FingeringOptions(num: 6, preferredFingerings: [.secondPosition, .seventhPosition]),
                FingeringOptions(num: 7, preferredFingerings: [.firstPosition, .sixthPosition]),
                FingeringOptions(num: 8, preferredFingerings: [.fifthPosition]),
                FingeringOptions(num: 9, preferredFingerings: [.fourthPosition]),
                FingeringOptions(num: 10, preferredFingerings: [.thirdPosition, .seventhPosition]),
                FingeringOptions(num: 11, preferredFingerings: [.secondPosition, .sixthPosition]),
                FingeringOptions(num: 12, preferredFingerings: [.firstPosition, .fifthPosition])
            ],
            clef: .treble,
            availableFingerings: [.firstPosition, .secondPosition, .thirdPosition, .fourthPosition, .fifthPosition, .sixthPosition, .seventhPosition])
    }

    static var initialData: [Instrument] = [.hornF, .hornBb, .trumpet, tromboneBassClef, .tromboneTrebleClef]
}
