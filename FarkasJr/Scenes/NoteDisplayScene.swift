//
//  NoteDisplayScene.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 11/02/2023.
//

import Foundation
import SpriteKit

class NoteDisplayScene: SKScene {
    
    let lineWidth = 2.0
    let lineGap: CGFloat = 25.0 // This value scales everything else!
    let width = 300.0
    var clef: Clef = .treble
    var clefXCoordinate: CGFloat { -3 * lineGap }
    var noteXCoordinate: CGFloat { lineGap * 2 }
    var accidentalOffset: CGFloat { -lineGap * 1.6 }
    var note: Note = Note(name: "", num: 3, pos: -1, accidental: .flat, level: 0)
    var noteOffset: CGFloat { lineGap * CGFloat(note.pos) / 2.0 }
    
    convenience init(size: CGSize, note: Note, clef: Clef) {
        self.init(size: size)
        self.note = note
        self.clef = clef
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.backgroundColor = .white
        displayStave()
        let _ = setUpSprite(spriteData: clef.spriteData, xPosition: clefXCoordinate)
        displayNote()
        displayAccidental()
        displayLedgerLines()
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayStave() {
        for i in -2...2 {
            drawLine(rect: CGRect(x: -width/2.0, y: CGFloat(i) * lineGap, width: width, height: lineWidth))
        }
    }
    
    func displayNote() {
        let noteSprite = setUpSprite(spriteData: SpriteData.crotchet, xPosition: noteXCoordinate)
        noteSprite.position.y += noteOffset
        if note.pos > 0 {
            noteSprite.zRotation = .pi
            noteSprite.position.y -= lineGap * 2.99
        }
    }
    
    func displayAccidental() {
        if let accidentalData = note.accidental.spriteData {
            let accidentalSprite = setUpSprite(spriteData: accidentalData, xPosition: noteXCoordinate + accidentalOffset + (accidentalData.xOffset * lineGap))
            accidentalSprite.position.y += noteOffset // Should I take this out?
            
        }
    }
    
    func displayLedgerLines() {
        var ledgerLineWidth: CGFloat { lineGap * 2.05 }
        let xOffset: CGFloat = 0.5
        
        for i in stride(from: 6, to: abs(note.pos) + 1, by: 2) {
            drawLine(rect: CGRect(
                x: noteXCoordinate + xOffset - CGFloat((ledgerLineWidth/2)),
                y: CGFloat(i) * lineGap  * (note.pos < 0 ? -0.5 : 0.5),
                width: ledgerLineWidth,
                height: lineWidth))
        }
    }
    
    func setUpSprite(spriteData: SpriteData, xPosition: CGFloat) -> SKSpriteNode {
        let sprite = SKSpriteNode(imageNamed: spriteData.imageName)
        sprite.color = .black
        sprite.colorBlendFactor = 1
        sprite.size = CGSize(width: spriteData.size.width * lineGap, height: spriteData.size.height * lineGap)
        sprite.position = CGPoint(x: xPosition, y: spriteData.yPosition * lineGap)
        addChild(sprite)
        return sprite
    }
    
    func drawLine(rect: CGRect) {
        let path = CGMutablePath()
        path.addRect(rect)
        let line = SKShapeNode(path: path)
        line.fillColor = .black
        line.strokeColor = .black
        addChild(line)
    }
}

extension SpriteData {
    static var crotchet: SpriteData {
        SpriteData(imageName: "crotchet", size: CGSize(width: 1.2, height: 4), yPosition: 1.51)
    }
}
