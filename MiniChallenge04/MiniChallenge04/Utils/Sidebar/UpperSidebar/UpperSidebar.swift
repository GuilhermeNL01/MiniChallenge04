//
//  UpperSideBar.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 25/03/24.
//

import Foundation
import SpriteKit

class UpperSidebar: SKNode{
    var rapport = RapportBar()
    var score = Score()
    
    override init() {
        super.init()
        
        rapport.position = CGPoint(x: -larguraTela * 0.05, y: 0)
        self.addChild(rapport)
        score.position = CGPoint(x: larguraTela * 0.09, y: 0)
        score.scoreVisor.anchorPoint = CGPoint(x: 0, y: 0.5)
        self.addChild(score)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
