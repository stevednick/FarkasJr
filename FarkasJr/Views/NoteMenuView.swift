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
            ScrollView {
                VStack(spacing: 0) {
                    ForEach($instruments[currentInstrument].notes, id: \.num) { noteByNum in
                        NoteNumView(noteByNum: noteByNum, instrument: instruments[currentInstrument])
                    }
                }
                .padding(.horizontal)
                .onDisappear {
                    saveAction()
                }
            }
        }
        .navigationTitle(Text("Note Selection"))
        .navigationViewStyle(.stack)
        .frame(maxWidth: 500)
    }
}

struct NoteMenuView_Previews: PreviewProvider {
    static var previews: some View {
        NoteMenuView(instruments: .constant(Instrument.initialData), saveAction: {}, currentInstrument: 0)
    }
}
