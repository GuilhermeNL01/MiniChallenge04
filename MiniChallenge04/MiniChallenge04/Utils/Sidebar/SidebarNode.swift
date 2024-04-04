//
//  Sidebar.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 26/03/24.
//

import Foundation
import SpriteKit

class SidebarNode: SKNode{
    var blur = SKSpriteNode(imageNamed: "sideBlur")
    var upperSidebar = UpperSidebar()
    var bottomSidebar = BottomSidebar()
    var ml: MachineLearningModel
    var score: Int
    private var hasAppeared = false
    
    override init() {
        ml = upperSidebar.rapport.mlModel
        score = upperSidebar.score.score
        super.init()
        blur.position = CGPoint(x: -larguraTela * 0.10, y: 5)
        blur.alpha = 0
        addChild(blur)
        upperSidebar.position = CGPoint(x: 0, y: alturaTela * 0.218)
        addChild(upperSidebar)
        bottomSidebar.position = CGPoint(x: 0, y: -alturaTela * 0.146)
        addChild(bottomSidebar)
        self.position = CGPoint(x: larguraTela * 1.21, y: alturaTela * 0.612)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func appear(){
        if !hasAppeared{
            let action = SKAction.move(by: CGVector(dx: -larguraTela * 0.42, dy: 0), duration: 0.8)
            action.timingMode = .easeInEaseOut
            self.run(action)
            blur.run(.fadeIn(withDuration: 1))
            hasAppeared = true
        }
    }
}
