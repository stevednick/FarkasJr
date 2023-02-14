//
//  HomeScreenView.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 12/02/2023.
//

import SwiftUI

struct HomeScreenView: View {
    
    @Binding var instruments: [Instrument]
    let saveAction: () -> Void
    let resetAction: () -> Void
    @State var reloadToggle: Bool = false
    
    var body: some View {
        
        VStack {
            Button("Reset") {
                resetAction()
                reloadToggle.toggle()
            }
            List {
                ForEach($instruments) { $instrument in
                    ForEach($instrument.notes) { $noteByNum in
                        ForEach($noteByNum.notes) { $note in
                            HStack {
                                NoteDisplayView(note: note, instrument: instrument, size: CGSize(width: 100, height: 70))
                                Spacer()
                                Text(note.name)
                                Spacer()
                                Button(note.isActive ? "Active" : "Off") {
                                    note.isActive.toggle()
                                    saveAction()
                                }
                                .foregroundColor(.blue)
                            }
                            
                            
                        }
                    }
                }
            }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(instruments: .constant([Instrument.hornF]), saveAction: {}, resetAction: {})
    }
}
