//
//  Answer.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 17/02/2023.
//

import Foundation

struct Answer: Identifiable {
    let id: UUID = UUID()
    let description: String
    let isCorrect: Bool
}
