//
//  SquareNode.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 02/04/24.
//

import Foundation
import SpriteKit

class SquareNode: SKNode{
    let squareNode = SKSpriteNode()
    let photoNode = SKSpriteNode()
    let labelNode = SKLabelNode()
    
    override init() {
        super.init()
        squaringNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func squaringNode(){
        
        squareNode.size = CGSize(width: 361, height: 111.33)
        squareNode.color = .gray
        
        let sizeWidthNode = squareNode.size.width
        let sizeHeightNode = squareNode.size.height
        let positionSquareNodeY = squareNode.position.y
        let positionSquareNodeX = squareNode.position.x
        
        photoNode.name = "Photo"
        photoNode.size = CGSize(width: sizeWidthNode-250, height: sizeHeightNode)
        photoNode.position.x = positionSquareNodeX-125
        photoNode.position.y = positionSquareNodeY
        photoNode.color = .white
        
        labelNode.text = "Item A"
        labelNode.fontColor = .black
        labelNode.fontSize = 26
        labelNode.position.x = positionSquareNodeX+60
        labelNode.position.y = positionSquareNodeY-10
        
        addChild(squareNode)
        addChild(photoNode)
        addChild(labelNode)
    }
}
