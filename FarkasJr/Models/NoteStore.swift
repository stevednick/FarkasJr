//
//  NoteStore.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 07/02/2023.
//

import Foundation

struct NoteStore { // Simply to assemble notes on first start for each instrument. 
    
    static func getNotes(fingeringOptionsList: [FingeringOptions], clef: Clef) -> [NoteByNum] {
        let octaveNumAdder = 12
        let octavePosAdder = 7
        
        var notesToReturn = [NoteByNum]()
        
        for fingeringOptions in fingeringOptionsList {
            let num = fingeringOptions.num
            let octave = ((num + octaveNumAdder * 10)/octaveNumAdder)-10
            var numInOctave = (num % octaveNumAdder)
            numInOctave += numInOctave < 0 ? 12 : 0
            
            let availableNotes = NoteFormationData.data.filter { $0.num == numInOctave }
            var newNoteByNum = NoteByNum(num: num, notes: [Note](), fingering: fingeringOptions.preferredFingerings[0])
            for note in availableNotes {
                newNoteByNum.notes.append(Note(name: note.name, num: numInOctave + (octave * octaveNumAdder), pos: note.pos + (octave * octavePosAdder) + clef.notePositionModifier, accidental: note.accidental, level: note.level))
            }
            notesToReturn.append(newNoteByNum)
        }
        return notesToReturn.reversed() // Reverse just to display note list correct way up.
    }
}
