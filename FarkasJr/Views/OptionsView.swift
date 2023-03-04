//
//  OptionsView.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 04/03/2023.
//

import SwiftUI

struct OptionsView: View {
    
    @Binding var currentInstrument: Int
    @Binding var instruments: [Instrument]
    let saveAction: () -> Void
    @State var noteSelectionViewShowing: Bool = false
    
    var body: some View {

        VStack() { // Set spacing between VStack elements
            Text("Select your instrument:")
                .font(.headline)
            Picker(selection: $currentInstrument, label: Text("Select an Instrument")) {
                ForEach(instruments.indices, id: \.self) { index in
                    Text(instruments[index].name)
                        .tag(index)
                }
            }
            .pickerStyle(.menu)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
            Divider()
                .padding(.vertical)
            Text("Select Notes and \(currentInstrument >= 3 ? "Positions" : "Fingerings")")
                .font(.headline)
            NavigationLink("Note Selection") {
                NoteMenuView(instruments: $instruments, saveAction: self.saveAction, currentInstrument: currentInstrument)
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
            VStack(spacing: 10) { // Set spacing between links
                Divider()
                    .padding(.vertical)// Add a horizontal line
                Text("Feedback and Ideas")
                    .font(.headline)
                Link(destination: URL(string: "mailto:weststreetgamestudios@gmail.com")!) {
                    HStack {
                        Image(systemName: "envelope")
                        Text("Email Us")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                }
                Divider()
                    .padding(.vertical)
                Text("Check out Farkas 2.0!")
                    .font(.headline)
                Link(destination: URL(string: "https://apps.apple.com/gb/app/farkas-2-0/id1500761932")!) {
                    HStack {
                        Image(systemName: "link")
                        Text("Visit the App Store")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal) // Add horizontal padding to links VStack
        }
        .padding(.bottom, 60) // Add vertical padding to outer VStack
        .navigationBarTitle("Options")
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView(currentInstrument: .constant(3), instruments: .constant(Instrument.initialData), saveAction: {})
    }
}
