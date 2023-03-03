//
//  Clef.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 07/02/2023.
//

import Foundation

struct Clef: Codable {
    
    let name: String
    let notePositionModifier: Int
    let spriteData: SpriteData
    
    // Image name? 
    
    init(name: String, notePositionModifier: Int, spriteData: SpriteData) {
        self.name = name
        self.notePositionModifier = notePositionModifier
        self.spriteData = spriteData
    }
}

extension Clef {
    static var treble: Clef {
        return Clef(name: "Treble", notePositionModifier: -6, spriteData: SpriteData(imageName: "treble", size: CGSize(width: 5, height: 7.6), yPosition: CGFloat(-0.1)))
    }
    static var bass: Clef {
        return Clef(name: "Bass", notePositionModifier: 6, spriteData: SpriteData(imageName: "bass", size: CGSize(width: 2.8, height: 3.35), yPosition: CGFloat(0.34)))
    }
}
