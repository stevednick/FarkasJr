//
//  GameData.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 15/02/2023.
//

import Foundation

struct GameData {
    
    struct Keys {
        static let currentInstrument = "currentInstrument"
        static let gameDuration = "gameDuration"
    }
    
    var currentInstrument: Instrument
    var gameDuration: Int

    init(currentInstrument: Instrument, gameDuration: Int) {
        self.currentInstrument = currentInstrument
        self.gameDuration = gameDuration
    }
    
    static var currentInstrument: Int {
      get { return UserDefaults.standard.integer(forKey: Keys.currentInstrument) }
      set { UserDefaults.standard.set(newValue, forKey: Keys.currentInstrument) }
    }
    static var gameDuration: Int {
      get { return UserDefaults.standard.integer(forKey: Keys.gameDuration) } // Deal with first start. 
      set { UserDefaults.standard.set(newValue, forKey: Keys.gameDuration) }
    }
}
