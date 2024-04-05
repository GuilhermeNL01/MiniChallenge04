//
//  PhotoNode.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 05/04/24.
//

import Foundation
import SpriteKit

class PhotoNode: SKSpriteNode{
    var isEmpty = true
    var type: GameType = .none
    
    init(imageNamed: String){
        let texture = SKTexture(imageNamed: imageNamed)
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum GameType: String{
        case none
        
        case murderer1 = "carmenBloom"
        case murderer2 = "butcher"
        case murderer3 = "helena"
        
        case location1 = "hotelBar"
        case location2 = "butcherShop"
        case location3 = "pier"
        
        case weapon1 = "pocketKnife"
        case weapon2 = "butcherKnife"
        case weapon3 = "fishingNet"
    }
    
}
