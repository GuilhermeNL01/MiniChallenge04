//
//  SupicionsNode.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 02/04/24.
//

import Foundation
import SpriteKit

class SuspicionsNode: SKNode{
    let Suspicions = SKSpriteNode(imageNamed: "Suspicions")
    let suspicionsLabel = SKSpriteNode(imageNamed: "SuspicionsLabel")
//    var squareNode: [SquareNode] = []
    var testNode = SquareNode()
   
    override init() {
        super.init()
        suspicionsArea()
//        setupSquares()
        addChild(testNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func suspicionsArea(){
        
        let positionSuspicionsNodeY = Suspicions.position.y
        let positionSuspicionsNodeX = Suspicions.position.x
        
        suspicionsLabel.position.x = positionSuspicionsNodeX
        suspicionsLabel.position.y = positionSuspicionsNodeY+280
        
        addChild(suspicionsLabel)
        addChild(Suspicions)
    }
    
//    func setupSquares(){
//        for i in 0...2{
//            squareNode.append(SquareNode())
//            addChild(squareNode[i])
//            squareNode[i].name = "squareNode\(i)"
//            if i == 0{
//                squareNode[0].position.y+=130
//            } else if i == 1 {
//                squareNode[1].position.y-=130
//            }
//        }
//    }
}
