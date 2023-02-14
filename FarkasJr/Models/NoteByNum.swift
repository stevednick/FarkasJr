//
//  NoteByNum.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 08/02/2023.
//

import Foundation

struct NoteByNum: Codable, Identifiable {
    
    let id: UUID
    let num: Int
    var notes: [Note]
    var fingering: Fingering
    
    init(id: UUID = UUID(), num: Int, notes: [Note], fingering: Fingering) {
        self.id = id
        self.num = num
        self.notes = notes
        self.fingering = fingering
    }
}
