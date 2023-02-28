//
//  HomeScreenView.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 12/02/2023.
//

import SwiftUI

struct HomeScreenView: View {
    
    @Binding var instruments: [Instrument]
    @State private var currentInstrument: Int = GameData.currentInstrument
    
    let saveAction: () -> Void
    @State var gameDuration = Float(GameData.gameDuration)
    @State var noteToDisplay: Note = Note(name: "", num: 0, pos: 0, accidental: .natural, level: 0)
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Farkas Jr.")
                    .font(.system(size: 50))
                    .fontWeight(.semibold)
                    .padding(.top, 150)
                Spacer()
                NoteDisplayView(note: $noteToDisplay, instrument: .hornF, size: CGSize(width: 250, height: 250))
                Spacer()
                NavigationLink(destination: GameView(instrument: $instruments[currentInstrument])) {
                    Text("Start!")
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.white))
                        .frame(width: 200, height: 80)
                        .font(.largeTitle)
                        .background(.blue)
                        .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
                .padding()
                Spacer()
                Slider(value: $gameDuration, in: 1...20) { _ in
                    GameData.gameDuration = Int(self.gameDuration)
                }
                .frame(width: 200)
                Text("Game Length: \(Int(gameDuration)) Note\(Int(gameDuration) == 1 ? "" : "s")")
                Spacer()

            }
            .edgesIgnoringSafeArea(.top)
        }
        //.navigationViewStyle(.stack)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink("Note Selection") {
                    NoteMenuView(instruments: $instruments, saveAction: self.saveAction, currentInstrument: currentInstrument)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Picker("Select an Instrument", selection: $currentInstrument) {
                    ForEach(instruments.indices, id: \.self) { index in
                        Text(instruments[index].name).tag(index)
                    }
                }
                .onChange(of: currentInstrument) { newValue in
                    GameData.currentInstrument = newValue
                }
            }
        })
        .onAppear {
            noteToDisplay = instruments[currentInstrument].activeNotes.randomElement() ?? noteToDisplay
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(.stack)
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(instruments: .constant([Instrument.hornF]), saveAction: {})
    }
}
