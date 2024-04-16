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
            self.node = SKSpriteNode(imageNamed: "butcherNode")
            break
        case .victimsWife:
            self.node = SKSpriteNode(imageNamed: "Elena")
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
        case butcher = "butcher"
        case victimsWife = "helena"
        case receptionist = "carmenBloom"
        case info // hides nametag in scenes
    }
}
