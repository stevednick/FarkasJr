//
//  NoteNumView.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 24/02/2023.
//

import SwiftUI

struct NoteNumView: View {
    @Binding var noteByNum: NoteByNum
    let instrument: Instrument
    var body: some View {
        HStack {
            VStack() {
                ForEach($noteByNum.notes) { note in
                    NoteSelectorView(note: note, instrument: instrument)
                }
            }
            Spacer()
            FingeringPicker(noteByNum: $noteByNum, instrument: instrument)
            Spacer()
        }
        .border(Color(hue: 1.0, saturation: 0.0, brightness: 0.917), width: 1)
    }
}

struct NoteNumView_Previews: PreviewProvider {
    static var previews: some View {
        NoteNumView(noteByNum: .constant(Instrument.hornF.notes[0]), instrument: .hornF)
    }
}
