//
//  Place.swift
//  MiniChallenge04
//
//  Created by Victor Assis on 21/03/24.
//

import Foundation

struct Place {
    
    var name: String
    var background: String
    var object: String
    var npc: NPC?
    var choices: [Int]
    var successIndicator: Int
    var mlText: String
    var hasViseted: Bool{
        get{
            return UserDefaults.standard.bool(forKey: "hasViseted")
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: "hasViseted")
        }
    }
}
