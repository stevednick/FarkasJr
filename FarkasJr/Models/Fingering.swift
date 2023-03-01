//
//  Fingering.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 07/02/2023.
//

import Foundation

enum Fingering: String, Codable, Equatable {
    
    case open = "0"
    case second = "2"
    case first = "1"
    case firstAndSecond = "1+2"
    case third = "3"
    case secondAndThird = "2+3"
    case firstAndThird = "1+3"
    case firstSecondAndThird = "1+2+3"
}
