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
    var description: String = ""
    
    init(_ character: GameCharacter) {
        self.name = character.rawValue
        self.type = character
        assignImages(character: character)
        buildDescription(character)
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
    
    private mutating func buildDescription(_ character: GameCharacter) {
        switch character{
        case .main:
            self.description = "a"
        case .butcher:
            self.description = "a"
        case .victimsWife:
            self.description = "a"
        case .receptionist:
            self.description = "a"
        }
    }
    
    enum GameCharacter: String{
        case main = "Carrie"
        case butcher = "Butcher"
        case victimsWife = "Helena"
        case receptionist = "Receptionist"
    }
}
