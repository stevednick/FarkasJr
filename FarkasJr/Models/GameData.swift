//
//  GameData.swift
//  FarkasJr
//
//  Created by Stephen Nicholls on 15/02/2023.
//

import Foundation

struct GameData {
    
    @UserDefault("currentInstrument", defaultValue: 0)
    static var currentInstrument: Int
    
    @UserDefault("gameDuration", defaultValue: 10)
    static var gameDuration: Int
    
    @UserDefault("firstStartComplete", defaultValue: false)
    static var firstStartComplete: Bool
    
}

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
