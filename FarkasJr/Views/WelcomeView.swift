//
//  WelcomeView.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 16/02/2023.
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment(\.dismiss) private var dismiss
    let cornerRadius: CGFloat = 15
    let noteDisplaySize = CGSize(width: 150, height: 100)
    
    var body: some View {
        NavigationView {
            VStack {
                NoteDisplayView(note: .constant(Note(name: "", num: 1, pos: 1, accidental: .natural, level: 1)), instrument: .hornF, size: noteDisplaySize)
                    .cornerRadius(cornerRadius)
                Text("Welcome to Farkas Jr.")
                    .font(.title)
                    .padding(.bottom)
                Text("Farkas Jr is a simple practice tool for beginner brass players. Simply select your instrument, make sure that all the correct fingerings have been selected for your student and start the exercise. It will test beginners on note recognition by asking for the note name and correct fingering before challenging the player to then play the written note.")
                    .font(.headline)
                Text("Please note, this app is in Beta testing currently. I would love to hear your feedback, so if you have any suggestions on how to make this better please let me know!")
                    .font(.headline)
                    .padding(.top)
                NoteDisplayView(note: .constant(Note(name: "", num: 1, pos: -6, accidental: .natural, level: 1)), instrument: .hornF, size: noteDisplaySize)
                    .cornerRadius(cornerRadius)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
