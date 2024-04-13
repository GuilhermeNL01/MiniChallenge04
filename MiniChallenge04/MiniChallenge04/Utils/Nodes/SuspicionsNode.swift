//
//  SupicionsNode.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 02/04/24.
//

import Foundation
import SpriteKit

class SuspicionsNode: SKNode{
    private var suspicionsBG = SKSpriteNode(imageNamed: "suspicionsBG")
    var suspicion = SquareNode(imageNamed: "ReportButton", score: 1)
    var suspicion2 = SquareNode(imageNamed: "ReportButton", score: 2)
    var suspicion3 = SquareNode(imageNamed: "ReportButton", score: 3)
   
    override init() {
        super.init()
        suspicionsArea()
        addChild(suspicionsBG)
        setupSuspicions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func suspicionsArea(){
        suspicionsBG.size = CGSize(width: 447, height: 480)
    }
    
    private func setupSuspicions(){
        suspicion.position = CGPoint(x: 0, y: alturaTela * 0.09)
        suspicion.name = "suspicion"
        self.suspicion.alpha = 0
        
        suspicion2.position = suspicion.position
        suspicion2.position.y = suspicion.position.y - 122
        suspicion2.name = "suspicion2"
        self.suspicion2.alpha = 0
        
        suspicion3.position = suspicion2.position
        suspicion3.position.y = suspicion2.position.y - 122
        suspicion3.name = "suspicion3"
        self.suspicion3.alpha = 0
        
        addChild(suspicion)
        addChild(suspicion2)
        addChild(suspicion3)
    }
    
    func changeSuspicions(type: SuspicionTypes){
        switch type{
        case .suspect:
            suspicion.squareNode.texture = SKTexture(image: .carmenSquare)
            suspicion2.squareNode.texture = SKTexture(image: .alanSquare)
            suspicion3.squareNode.texture = SKTexture(image: .elenaSquare)
        case .weapon:
            suspicion.squareNode.texture = SKTexture(image: .pocketKnifeSquare)
            suspicion2.squareNode.texture = SKTexture(image: .butcherKnifeSquare)
            suspicion3.squareNode.texture = SKTexture(image: .fishingNetSquare)
        case .location:
            suspicion.squareNode.texture = SKTexture(image: .hotelSquare)
            suspicion2.squareNode.texture = SKTexture(image: .butcherShopSquare)
            suspicion3.squareNode.texture = SKTexture(image: .pierSquare)
        }
    }
    
    enum SuspicionTypes{
        case suspect
        case weapon
        case location
    }
    
    func hide() {
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let remove = SKAction.run {
            self.suspicion.isHidden = true
            self.suspicion2.isHidden = true
            self.suspicion3.isHidden = true
        }
        
        self.suspicion.run(fadeOut)
        self.suspicion2.run(fadeOut)
        self.suspicion3.run(.sequence([fadeOut, remove]))
    }
    
    func appear(){
        self.suspicion.isHidden = false
        self.suspicion2.isHidden = false
        self.suspicion3.isHidden = false
        
        self.suspicion.run(.fadeIn(withDuration: 0.5))
        self.suspicion2.run(.fadeIn(withDuration: 0.5))
        self.suspicion3.run(.fadeIn(withDuration: 0.5))
    }
}
