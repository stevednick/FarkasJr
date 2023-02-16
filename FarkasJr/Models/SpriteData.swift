//
//  SpriteData.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 11/02/2023.
//

import Foundation

struct SpriteData: Codable{
    
    let imageName: String
    let size: CGSize
    let yPosition: CGFloat
    let xOffset: CGFloat
    
    init(imageName: String, size: CGSize, yPosition: CGFloat, xOffset: CGFloat = 0) {
        self.imageName = imageName
        self.size = size
        self.yPosition = yPosition
        self.xOffset = xOffset
    }
    
}
