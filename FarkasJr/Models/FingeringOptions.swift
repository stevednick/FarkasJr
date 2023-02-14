//
//  FingeringOption.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 08/02/2023.
//

import Foundation

struct FingeringOptions: Codable {
    let num: Int
    let preferredFingerings: [Fingering]
    
    init(num: Int, preferredFingerings: [Fingering]) {
        self.num = num
        self.preferredFingerings = preferredFingerings
    }
}
