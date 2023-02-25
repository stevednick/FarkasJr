//
//  NoteSelectorView.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 23/02/2023.
//

import SwiftUI

struct NoteSelectorView: View {
    
    @Binding var note: Note
    
    let instrument: Instrument
        
    var body: some View {
        HStack {
            NoteDisplayView(note: $note, instrument: instrument, size: CGSize(width: 120, height: 80))
                .padding(.leading, 10)
            Spacer()
            Toggle(isOn: $note.isActive, label: {
                Text("")
            })
            .padding(.trailing, 10)
        }
        .frame(width: 220)
    }
}

struct NoteSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        NoteSelectorView(note: .constant(Note(name: "C#", num: 3, pos: 3, accidental: .sharp, level: 0)), instrument: .hornF)
    }
}
