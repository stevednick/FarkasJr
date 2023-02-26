//
//  NoteDisplayView.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 12/02/2023.
//

import SwiftUI
import SpriteKit

struct NoteDisplayView: View {
    
    @Binding var note: Note
    let instrument: Instrument
    let size: CGSize // 3:2 aspect ratio works.
    
    var noteDisplayScene: NoteDisplayScene
    
    init(note: Binding<Note>, instrument: Instrument, size: CGSize) {
            self._note = note
            self.instrument = instrument
            self.size = size
            noteDisplayScene = NoteDisplayScene(size: CGSize(width: 330, height: 330), note: note.wrappedValue, clef: instrument.clef)
            noteDisplayScene.scaleMode = .aspectFit
        }

    
    var body: some View {
        SpriteView(scene: noteDisplayScene)
            .frame(width: size.width, height: size.height)
            .id(note.id)
    }
}

struct NoteDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDisplayView(note: .constant(Note(name: "C#", num: 1, pos: -6, accidental: .natural, level: 1)), instrument: .hornF, size: CGSize(width: 300, height: 300))
    }
}
