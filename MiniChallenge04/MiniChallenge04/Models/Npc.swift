//
//  Npc.swift
//  MiniChallenge04
//
//  Created by Victor Assis on 21/03/24.
//

import Foundation
import SpriteKit

struct NPC {
    var name: String?
    var node: SKSpriteNode?
    var type: GameCharacter
    
    init(_ character: GameCharacter) {
        self.name = character.rawValue
        self.type = character
        assignImages(character: character)
    }
    
    private mutating func assignImages(character: GameCharacter){
        switch character{

        case .main:
            self.node = SKSpriteNode(imageNamed: "character")
            break
        case .butcher:
            self.node = SKSpriteNode(imageNamed: "character")
            break
        case .victimsWife:
            self.node = SKSpriteNode(imageNamed: "character")
            break
        case .receptionist:
            self.node = SKSpriteNode(imageNamed: "carmenBloomSprite")
            break
        case .info:
            self.node = nil
        }
    }
    
    enum GameCharacter: String{
        case main = "Carrie"
        case butcher = "Butcher"
        case victimsWife = "Helena"
        case receptionist = "Receptionist"
        case info // hides nametag in scenes
    }
}
