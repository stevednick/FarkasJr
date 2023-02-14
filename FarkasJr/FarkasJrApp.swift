//
//  FarkasJrApp.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 06/02/2023.
//

import SwiftUI

@main
struct FarkasJrApp: App {
    
    @StateObject private var dataController = DataController()
    @State private var errorWrapper: ErrorWrapper?
    @StateObject private var audioController = AudioController()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeScreenView(instruments: $dataController.instruments) {
                    Task {
                        do {
                            try await DataController.save(instruments: dataController.instruments)
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                        }
                    }
                } resetAction: {
                    Task {
                        do {
                            try await DataController.save(instruments: [Instrument.hornF])
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                        }
                    }
                }
            }
            .task {
                do {
                    dataController.instruments = try await DataController.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Farkas Jr will load sample data and continue.")
                    do {
                        try await DataController.save(instruments: [Instrument.hornF])
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                    }
                }
            }
            .sheet(item: $errorWrapper, onDismiss: {
                dataController.instruments = [Instrument.hornF]
                //store.scrums = DailyScrum.sampleData
            }) { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}
