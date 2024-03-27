//
//  Npc.swift
//  MiniChallenge04
//
//  Created by Victor Assis on 21/03/24.
//

import Foundation

struct NPC {
    var name: String
    var images: [String] = []
    var type: GameCharacter
    
    init(_ character: GameCharacter) {
        self.name = character.rawValue
        self.type = character
        assignImages(character: character)
    }
    
    private mutating func assignImages(character: GameCharacter){
        switch character{

        case .main:
            self.images = []
        case .butcher:
            self.images = []
        case .victimsWife:
            self.images = []
        case .receptionist:
            self.images = []
        }
    }
    
    enum GameCharacter: String{
        case main = "Carrie"
        case butcher = "Butcher"
        case victimsWife = "Helena"
        case receptionist = "Receptionist"
    }
}
