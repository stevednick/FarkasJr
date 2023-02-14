//
//  Fingering.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 07/02/2023.
//

import Foundation

struct Fingering: Codable {

    var fingers: [Bool]?
    var thumb: Bool?
    var position: Int?
    
    init(fingers: [Bool]? = nil, thumb: Bool? = nil, position: Int? = nil) {
        self.fingers = fingers
        self.thumb = thumb
        self.position = position
    }
}

extension Fingering {
    
    // This needs tidying. 
    var display: String {
        var stringToReturn = ""
        if let fingers = fingers {
            for i in 0..<fingers.count {
                // Probably a better way to do this using map?
                stringToReturn.append(fingers[i] ? String(i+1) : "")
            }
            if !fingers.contains(true) { stringToReturn += "0" }
        }
        if let position = position { stringToReturn.append("Position \(position) ") }
        if let thumb = thumb { stringToReturn += thumb ? "T" : "" }
        
        return stringToReturn
    }
}
