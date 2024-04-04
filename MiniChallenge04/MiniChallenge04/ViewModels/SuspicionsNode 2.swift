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
    var squareNode: [SquareNode] = []
   
    override init() {
        super.init()
        suspicionsArea()
        setupSquares()
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
    
    func setupSquares(){
        for i in 0...2{
            squareNode.append(SquareNode())
            addChild(squareNode[i])
            if i == 0{
                squareNode[0].position.y+=130
            } else if i == 1 {
                squareNode[1].position.y-=130
            }
        }
    }
    
    func setupSquaresTwo(){
        for i in 3...5{
            squareNode.append(SquareNode())
            addChild(squareNode[i])
            if i == 0{
                squareNode[3].position.y+=130
            } else if i == 1 {
                squareNode[4].position.y-=130
            }
        }
    }
    
    func setupSquaresThree(){
        for i in 6...8{
            squareNode.append(SquareNode())
            addChild(squareNode[i])
            if i == 0{
                squareNode[6].position.y+=130
            } else if i == 1 {
                squareNode[7].position.y-=130
            }
        }
    }
}
