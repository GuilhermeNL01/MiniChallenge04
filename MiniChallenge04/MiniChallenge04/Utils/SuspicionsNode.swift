//
//  SupicionsNode.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 02/04/24.
//

import Foundation
import SpriteKit

class SuspicionsNode: SKNode{
    private let Suspicions = SKSpriteNode(imageNamed: "Suspicions")
    private let suspicionsLabel = SKSpriteNode(imageNamed: "SuspicionsLabel")
    var suspicion = SquareNode(imageNamed: "ReportButton", score: 1)
    var suspicion2 = SquareNode(imageNamed: "ReportButton", score: 2)
    var suspicion3 = SquareNode(imageNamed: "ReportButton", score: 3)
   
    override init() {
        super.init()
        suspicionsArea()
        setupSuspicions()
        self.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func suspicionsArea(){
        
        let positionSuspicionsNodeY = Suspicions.position.y
        let positionSuspicionsNodeX = Suspicions.position.x
        
        suspicionsLabel.position.x = positionSuspicionsNodeX
        suspicionsLabel.position.y = positionSuspicionsNodeY+280
        
        addChild(suspicionsLabel)
        addChild(Suspicions)
    }
    
    private func setupSuspicions(){
        suspicion.position = CGPoint(x: 0, y: 150)
        suspicion.name = "suspicion"
        
        suspicion2.position = suspicion.position
        suspicion2.position.y = suspicion.position.y - 150
        suspicion2.name = "suspicion2"
        
        
        suspicion3.position = suspicion2.position
        suspicion3.position.y = suspicion2.position.y - 150
        suspicion3.name = "suspicion3"
        
        addChild(suspicion)
        addChild(suspicion2)
        addChild(suspicion3)
    }
    
    func changeSuspicions(type: SuspicionTypes){
        switch type{
//        case .suspect:
//            suspicion.squareNode.texture = SKTexture(image: <#T##UIImage#>)
//            suspicion2.squareNode.texture = SKTexture(image: <#T##UIImage#>)
//            suspicion3.squareNode.texture = SKTexture(image: <#T##UIImage#>)
//        case .weapon:
//            suspicion.squareNode.texture = SKTexture(image: <#T##UIImage#>)
//            suspicion2.squareNode.texture = SKTexture(image: <#T##UIImage#>)
//            suspicion3.squareNode.texture = SKTexture(image: <#T##UIImage#>)
//        case .location:
//            suspicion.squareNode.texture = SKTexture(image: <#T##UIImage#>)
//            suspicion2.squareNode.texture = SKTexture(image: <#T##UIImage#>)
//            suspicion3.squareNode.texture = SKTexture(image: <#T##UIImage#>)
//        }
    }
    
    enum SuspicionTypes{
        case suspect
        case weapon
        case location
    }
    
    func hide() {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let remove = SKAction.run {
            self.isHidden = true
        }
        
        self.run(.sequence([fadeOut, remove]))
    }
    
    func appear(){
        isHidden = false
        self.run(.fadeIn(withDuration: 0.5))
    }
}
