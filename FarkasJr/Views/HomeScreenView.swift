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
    let resetAction: () -> Void
    @State var gameDuration = Float(GameData.gameDuration)
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Reset Instrument Data") {
                    resetAction()
                    saveAction()
                }
                .padding()
                Picker("Select an Instrument", selection: $currentInstrument) {
                    ForEach(instruments.indices, id: \.self) { index in
                        Text(instruments[index].name).tag(index)
                    }
                }
                .onChange(of: currentInstrument) { newValue in
                    GameData.currentInstrument = newValue
                }
                Spacer()
                NoteDisplayView(note: $instruments[currentInstrument].notes.randomElement()?.notes.randomElement() ?? .constant(Note(name: "", num: 0, pos: 0, accidental: .natural, level: 0)), instrument: .hornF, size: CGSize(width: 200, height: 133))
                Spacer()
                NavigationLink(destination: GameView(instrument: $instruments[currentInstrument])) {
                    Text("Start!")
                        .fontWeight(.semibold)
                        .foregroundColor(Color(.white))
                        .padding(30)
                        .font(.largeTitle)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
                Spacer()
                Slider(value: $gameDuration, in: 1...20) { _ in
                    GameData.gameDuration = Int(self.gameDuration)
                }
                .padding(.horizontal, 30.0)
                Text("Game Length: \(Int(gameDuration)) Note\(Int(gameDuration) == 1 ? "" : "s")")
                Spacer()
            }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView(instruments: .constant([Instrument.hornF]), saveAction: {}, resetAction: {})
    }
}
