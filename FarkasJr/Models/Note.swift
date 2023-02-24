//
//  Note.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 07/02/2023.
//

import Foundation

struct Note: Codable {
    
    let id: UUID
    let name: String
    let num: Int
    let pos: Int
    let accidental: Accidental
    let level: Int
    var isActive = true
    
    init(id: UUID = UUID(), name: String, num: Int, pos: Int, accidental: Accidental, level: Int) {
        self.id = id
        self.name = name
        self.num = num
        self.pos = pos
        self.accidental = accidental
        self.level = level
    }
}
