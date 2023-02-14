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
                if note.isActive {notesToReturn.append(note)}
            }
        }
        return notesToReturn
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
}

extension Instrument {
    static var hornF: Instrument {
        return Instrument(name: "F Horn", transposition: 7, fingeringOptions: [
        FingeringOptions(num: 0, preferredFingerings: [Fingering(fingers: [false, false, false])]), // Middle C
        FingeringOptions(num: 1, preferredFingerings: [Fingering(fingers: [true, true, false])]), // C#
        FingeringOptions(num: 2, preferredFingerings: [Fingering(fingers: [true, false, false])]), // D
        FingeringOptions(num: 3, preferredFingerings: [Fingering(fingers: [false, true, false])]), // Eb
        FingeringOptions(num: 4, preferredFingerings: [Fingering(fingers: [false, false, false]), Fingering(fingers: [true, true, false])]), // E 1&2 added for testing. 
        FingeringOptions(num: 5, preferredFingerings: [Fingering(fingers: [true, false, false])]), // F
        FingeringOptions(num: 6, preferredFingerings: [Fingering(fingers: [false, true, false])]), // F#
        FingeringOptions(num: 7, preferredFingerings: [Fingering(fingers: [false, false, false])])
        ],
        clef: .treble)
    }
}
