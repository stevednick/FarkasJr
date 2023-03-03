//
//  Fingering.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 07/02/2023.
//

import Foundation

enum Fingering: String, Codable, Equatable {
    
    // MARK: - Three Valve Combos

    
    case open = "0"
    case second = "2"
    case first = "1"
    case firstAndSecond = "1+2"
    case third = "3"
    case secondAndThird = "2+3"
    case firstAndThird = "1+3"
    case firstSecondAndThird = "1+2+3"
    
    // MARK: - Thumb Combos
    
    case thumb = "Thumb"
    case thumbSecond = "Thumb+2"
    case thumbFirst = "Thumb+1"
    case thumbFirstAndSecond = "Thumb+1+2"
    case thumbThird = "Thumb+3"
    case thumbSecondAndThird = "Thumb+2+3"
    case thumbFirstAndThird = "Thumb+1+3"
    case thumbFirstSecondAndThird = "Thumb+1+2+3"

    
    // MARK: - Trombone Positions
    
    case firstPosition = "1st Position"
    case secondPosition = "2nd Position"
    case thirdPosition = "3rd Position"
    case fourthPosition = "4th Position"
    case fifthPosition = "5th Position"
    case sixthPosition = "6th Position"
    case seventhPosition = "7th Position"
}
