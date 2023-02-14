//
//  ContentView.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 06/02/2023.
//

import SwiftUI

struct ContentView: View {
    var noteStore = NoteStore()
    
    var body: some View {
        VStack {
            NavigationLink("Job List") {
                JobListView()
            }
            NavigationLink("Test Scene") {
                SpriteTestScene()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
