//
//  NoteDisplayView.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 12/02/2023.
//

import SwiftUI
import SpriteKit

struct NoteDisplayView: View {
    
    var note: Note
    let instrument: Instrument
    let size: CGSize // 3:2 aspect ratio works.
    
    var noteDisplayScene: SKScene {
        let scene = NoteDisplayScene(size: CGSize(width: 330, height: 220), note: note, clef: instrument.clef)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: noteDisplayScene)
            .frame(width: size.width, height: size.height)
    }
}

struct NoteDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDisplayView(note: Note(name: "C#", num: 1, pos: 1, accidental: .sharp, level: 1), instrument: .hornF, size: CGSize(width: 300, height: 200))
    }
}
