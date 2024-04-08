//
//  SquareNode.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 02/04/24.
//

import Foundation
import SpriteKit

class SquareNode: SKNode{
    var squareNode: SKSpriteNode
    var score: Int
    
    init(imageNamed: String, score: Int) {
        squareNode = SKSpriteNode(imageNamed: imageNamed)
        self.score = score
        super.init()
        squaringNode()
//        changeNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func squaringNode(){
        squareNode.size = CGSize(width: 361, height: 111.33)
        
        addChild(squareNode)
    }
}
