//
//  SpriteTestScene.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 11/02/2023.
//

import SwiftUI
import SpriteKit

struct SpriteTestScene: View {
    
    let sceneSize = CGSize(width: 100, height: 66)
    var instrument: Instrument = .hornF
    
    var body: some View {
        VStack{
            List {
                ForEach(instrument.notes.reversed()) { noteByNum in
                    ForEach(noteByNum.notes) { note in
                        NoteDisplayView(note: note, instrument: instrument, size: sceneSize)
                    }
                }
            }
        }
    }
}

struct SpriteTestScene_Previews: PreviewProvider {
    static var previews: some View {
        SpriteTestScene()
    }
}
