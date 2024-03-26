//
//  BottomSidebar.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 26/03/24.
//

import Foundation
import SpriteKit

class BottomSidebar: SKNode{
    private let background = SKSpriteNode(imageNamed: "InsightsBG")
    var insight1 = SKLabelNode(text: "• ")
    var insight2 = SKLabelNode(text: "• Ola")
    var insight3 = SKLabelNode(text: "• pinguco")
    var insight4 = SKLabelNode(text: "• aaaa")
    
    override init(){
        super.init()
        background.size = CGSize(width: larguraTela * 0.37, height: alturaTela * 0.41)
        addChild(background)
        textSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func textSetup(){
        insight1.fontName = fonteMedium
        insight1.fontSize = 20
        insight1.horizontalAlignmentMode = .left
        insight1.position = CGPoint(x: 0, y: 50)
        addChild(insight1)
        
        insight2.fontName = fonteMedium
        insight2.fontSize = 20
        insight2.horizontalAlignmentMode = .left
        insight2.position = CGPoint(x: insight1.position.x, y: insight1.position.y - 60)
        addChild(insight2)
        
        insight3.fontName = fonteMedium
        insight3.fontSize = 20
        insight3.horizontalAlignmentMode = .left
        insight3.position = CGPoint(x: insight2.position.x, y: insight2.position.y - 60)
        addChild(insight3)
        
        insight4.fontName = fonteMedium
        insight4.fontSize = 20
        insight4.horizontalAlignmentMode = .left
        insight4.position = CGPoint(x: insight3.position.x, y: insight3.position.y - 60)
        addChild(insight4)
    }
    
}
