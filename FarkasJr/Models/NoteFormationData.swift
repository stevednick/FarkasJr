//
//  NoteFormationData.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 07/02/2023.
//

import Foundation

struct NoteFormationData {
    
    var name: String
    var num: Int
    var pos: Int
    var accidental: Accidental
    var level: Int
    
    init(name: String, num: Int, pos: Int, accidental: Accidental, level: Int) {
        self.name = name
        self.num = num
        self.pos = pos
        self.accidental = accidental
        self.level = level
    }
}

extension NoteFormationData {
    static var data: [NoteFormationData] {
        [// NoteFormationData(name: "B#", num: 0, pos: -1, accidental: .sharp, level: 3),
         NoteFormationData(name: "C", num: 0, pos: 0, accidental: .natural, level: 0),
         NoteFormationData(name: "C#", num: 1, pos: 0, accidental: .sharp, level: 1),
         NoteFormationData(name: "Db", num: 1, pos: 1, accidental: .flat, level: 2),
         NoteFormationData(name: "D", num: 2, pos: 1, accidental: .natural, level: 0),
         NoteFormationData(name: "D#", num: 3, pos: 1, accidental: .sharp, level: 2),
         NoteFormationData(name: "Eb", num: 3, pos: 2, accidental: .flat, level: 1),
         NoteFormationData(name: "E", num: 4, pos: 2, accidental: .natural, level: 0),
         // NoteFormationData(name: "E#", num: 5, pos: 2, accidental: .sharp, level: 3),
         // NoteFormationData(name: "Fb", num: 4, pos: 3, accidental: .flat, level: 3),
         NoteFormationData(name: "F", num: 5, pos: 3, accidental: .natural, level: 0),
         NoteFormationData(name: "F#", num: 6, pos: 3, accidental: .sharp, level: 1),
         NoteFormationData(name: "Gb", num: 6, pos: 4, accidental: .flat, level: 2),
         NoteFormationData(name: "G", num: 7, pos: 4, accidental: .natural, level: 0),
         NoteFormationData(name: "G#", num: 8, pos: 4, accidental: .sharp, level: 2),
         NoteFormationData(name: "Ab", num: 8, pos: 5, accidental: .flat, level: 1),
         NoteFormationData(name: "A", num: 9, pos: 5, accidental: .natural, level: 0),
         NoteFormationData(name: "A#", num: 10, pos: 5, accidental: .sharp, level: 2),
         NoteFormationData(name: "Bb", num: 10, pos: 6, accidental: .flat, level: 1),
         NoteFormationData(name: "B", num: 11, pos: 6, accidental: .natural, level: 0)]
         // NoteFormationData(name: "Cb", num: 11, pos: 7, accidental: .flat, level: 3)]
    }
}
