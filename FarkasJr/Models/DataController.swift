//
//  DataController.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 08/02/2023.
//

import Foundation
import SwiftUI

class DataController: ObservableObject {
    
    @Published var instruments: [Instrument] = Instrument.initialData
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        .appendingPathComponent("instrument.data")
    }
    
    static func load() async throws -> [Instrument] {
        try await withCheckedThrowingContinuation({ continuation in
            load { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let instruments):
                    continuation.resume(returning: instruments)
                }
            }
        })
    }
    
    static func load(completion: @escaping (Result<[Instrument], Error>)->Void) {
        print("Loading")
        DispatchQueue.global(qos: .background).async {
            do {
                let fileUrl = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileUrl) else {
                    DispatchQueue.main.async {
                        print("Returned First Load Data")
                        completion(.success(Instrument.initialData)) // This is where we load the initial instruments.
                    }
                    return
                }
                let instruments = try JSONDecoder().decode([Instrument].self, from: file.availableData)
                DispatchQueue.main.async {
                    print("Files Available")
                    completion(.success(instruments))
                }
            } catch  {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    @discardableResult
    static func save(instruments: [Instrument]) async throws -> Int {
        try await withCheckedThrowingContinuation({ continuation in
            save(instruments: instruments) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let scrumsSaved):
                    continuation.resume(returning: scrumsSaved)
                }
            }
        })
    }
    
    static func save(instruments: [Instrument], completion: @escaping (Result<Int, Error>)->Void) {
        print("Save Runs")
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(instruments)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(instruments.count))
                }
            } catch  {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
