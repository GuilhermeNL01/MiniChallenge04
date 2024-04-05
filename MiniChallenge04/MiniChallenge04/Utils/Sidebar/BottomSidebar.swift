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
    var insight1 = SKLabelNode(text: "")
    var insight2 = SKLabelNode(text: "")
    var insight3 = SKLabelNode(text: "")
    var insight4 = SKLabelNode(text: "")
    
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
        let screenSizeConstraint = alturaTela * 0.07 // variavel para alocar diferenca de posicao entre os textos
        insight1.fontName = fonteMedium
        insight1.fontSize = 20
        insight1.position = CGPoint(x: 0, y: alturaTela * 0.037)
        insight1.preferredMaxLayoutWidth = 385
        insight1.numberOfLines = 2
        insight2.lineBreakMode = .byWordWrapping
        addChild(insight1)
        
        insight2.fontName = fonteMedium
        insight2.fontSize = 20
        insight2.position = CGPoint(x: insight1.position.x, y: insight1.position.y - screenSizeConstraint)
        insight2.preferredMaxLayoutWidth = 385
        insight2.numberOfLines = 2
        insight2.lineBreakMode = .byWordWrapping
        addChild(insight2)
        
        insight3.fontName = fonteMedium
        insight3.fontSize = 20
        insight3.position = CGPoint(x: insight2.position.x, y: insight2.position.y - screenSizeConstraint)
        insight3.preferredMaxLayoutWidth = 385
        insight3.numberOfLines = 2
        insight3.lineBreakMode = .byWordWrapping
        addChild(insight3)
        
        insight4.fontName = fonteMedium
        insight4.fontSize = 20
        insight4.position = CGPoint(x: insight3.position.x, y: insight3.position.y - screenSizeConstraint)
        insight4.preferredMaxLayoutWidth = 385
        insight4.numberOfLines = 2
        insight4.lineBreakMode = .byWordWrapping
        addChild(insight4)
    }
    
}
