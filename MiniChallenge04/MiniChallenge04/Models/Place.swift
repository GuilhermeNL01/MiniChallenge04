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
   
    init(name: String, background: String, object: String, npc: NPC? = nil, choices: [Int], successIndicator: Int, mlText: String) {
        self.name = name
        self.background = background
        self.object = object
        self.npc = npc
        self.choices = choices
        self.successIndicator = successIndicator
        self.mlText = mlText
    }
}

