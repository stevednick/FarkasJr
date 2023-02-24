//
//  Instrument.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 08/02/2023.
//

import Foundation

struct Instrument: Codable, Identifiable {
    
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
    
    var availableFingerings: [Fingering] {
        var fingeringsToReturn = [Fingering]()
        for note in activeNotes {
            fingeringsToReturn += fingeringOptions.filter({ $0.num == note.num
            }).first!.preferredFingerings
        }
        return Array(Set(fingeringsToReturn))
    }
    
    var fingeringStrings: [String] {
        return availableFingerings.map { $0.rawValue }
    }
    
    var noteStrings: [String] {
        return Array(Set(activeNotes.map { $0.name }))
    }
    
    init(id: UUID = UUID(), name: String, transposition: Int, fingeringOptions: [FingeringOptions], clef: Clef) {
        self.id = id
        self.name = name
        self.transposition = transposition
        self.fingeringOptions = fingeringOptions
        self.clef = clef
        self.notes = getNoteList()
    }
    
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

extension Instrument {
    static var hornF: Instrument {
        return Instrument(name: "F Horn", transposition: 7, fingeringOptions: [
            FingeringOptions(num: -1, preferredFingerings: [.second]), // B
            FingeringOptions(num: 0, preferredFingerings: [.open]), // Middle C
            FingeringOptions(num: 1, preferredFingerings: [.firstAndSecond]), // C#
            FingeringOptions(num: 2, preferredFingerings: [.first]), // D
            FingeringOptions(num: 3, preferredFingerings: [.second]), // Eb
            FingeringOptions(num: 4, preferredFingerings: [.open, .firstAndSecond]), // E 1&2 added for testing.
            FingeringOptions(num: 5, preferredFingerings: [.first]), // F
            FingeringOptions(num: 6, preferredFingerings: [.second]), // F#
            FingeringOptions(num: 7, preferredFingerings: [.open]), // G
            FingeringOptions(num: 8, preferredFingerings: [.secondAndThird]), // G#
            FingeringOptions(num: 9, preferredFingerings: [.firstAndSecond, .third]), // A
            FingeringOptions(num: 10, preferredFingerings: [.first]), // Bb
            FingeringOptions(num: 11, preferredFingerings: [.second]), // B
            FingeringOptions(num: 12, preferredFingerings: [.open]) // C
            
        ],
        clef: .treble)
    }
    static var hornBb: Instrument {
        return Instrument(name: "Bb Horn", transposition: 7, fingeringOptions: [
            FingeringOptions(num: -1, preferredFingerings: [.second]), // B
            FingeringOptions(num: 0, preferredFingerings: [.open]), // Middle C
            FingeringOptions(num: 1, preferredFingerings: [.secondAndThird]), // C#
            FingeringOptions(num: 2, preferredFingerings: [.firstAndSecond]), // D
            FingeringOptions(num: 3, preferredFingerings: [.first]), // Eb
            FingeringOptions(num: 4, preferredFingerings: [.second]), // E 1&2 added for testing.
            FingeringOptions(num: 5, preferredFingerings: [.open]), // F
            FingeringOptions(num: 6, preferredFingerings: [.firstAndSecond]), // F#
            FingeringOptions(num: 7, preferredFingerings: [.first]), //G
            FingeringOptions(num: 8, preferredFingerings: [.secondAndThird]), // G#
            FingeringOptions(num: 9, preferredFingerings: [.firstAndSecond, .third]), // A
            FingeringOptions(num: 10, preferredFingerings: [.first]), // Bb
            FingeringOptions(num: 11, preferredFingerings: [.second]), // B
            FingeringOptions(num: 12, preferredFingerings: [.open]) // C
        ],
        clef: .treble)
    }
    static var initialData: [Instrument] = [.hornF, .hornBb]
}
