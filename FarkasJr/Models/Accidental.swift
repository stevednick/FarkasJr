//
//  Accidental.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 07/02/2023.
//

import Foundation

struct Accidental: Codable, Equatable {
    static func == (lhs: Accidental, rhs: Accidental) -> Bool {
        return lhs.name == rhs.name
    }
    // Natural has nil spriteData which will prevent showing anything.
    
    let name: String
    let spriteData: SpriteData?
    
}

extension Accidental {
    static var sharp: Accidental {
        Accidental(name: "Sharp", spriteData: SpriteData(imageName: "sharp", size: CGSize(width: 1, height: 2.2), yPosition: 0.07))
    }
    static var flat: Accidental {
        Accidental(name: "Flat", spriteData: SpriteData(imageName: "flat", size: CGSize(width: 0.9, height: 2.05), yPosition: 0.45, xOffset: 0.15))
    }
    static var natural: Accidental {
        Accidental(name: "Natural", spriteData: nil)
    }
}



