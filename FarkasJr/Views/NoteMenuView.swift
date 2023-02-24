//
//  NoteMenuView.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 24/02/2023.
//

import SwiftUI

struct NoteMenuView: View {
    @Binding var instruments: [Instrument]
    let saveAction: () -> Void
    let currentInstrument: Int
    var body: some View {
        NavigationView {
            List {
                ForEach($instruments[currentInstrument].notes, id: \.num) { noteByNum in
                    NoteNumView(noteByNum: noteByNum, instrument: instruments[currentInstrument])
                }
            }
        }
        .onDisappear {
            saveAction()
        }
    }
}

struct NoteMenuView_Previews: PreviewProvider {
    static var previews: some View {
        NoteMenuView(instruments: .constant(Instrument.initialData), saveAction: {}, currentInstrument: 0)
    }
}
