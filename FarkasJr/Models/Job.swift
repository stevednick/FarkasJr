//
//  Job.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 07/02/2023.
//

import Foundation

struct Job: Identifiable {

    var id: UUID
    var description: String
    var isComplete: Bool
    
    init(id: UUID = UUID(), description: String, isComplete: Bool = false) {
        self.id = id
        self.description = description
        self.isComplete = isComplete
    }
}
