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
    case firstAndSecond = "12"
    case third = "3"
    case secondAndThird = "23"
    case firstAndThird = "13"
    case firstSecondAndThird = "123"
}
