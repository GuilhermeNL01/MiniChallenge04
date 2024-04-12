//
//  ChoiceNode.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 03/04/24.
//

import Foundation
import SpriteKit

class ChoiceNode: SKNode{
    var choice: Choice
    private var background = SKSpriteNode(imageNamed: "choiceBG")
    var choiceLabel = SKLabelNode()
    
    init(choice: Choice) {
        self.choice = choice
        super.init()
        addChild(background)
        
        choiceLabel.text = choice.text
        choiceLabel.preferredMaxLayoutWidth = 438
        choiceLabel.fontName = libreBaskervilleBold
        choiceLabel.verticalAlignmentMode = .center
        choiceLabel.fontSize = 26
        
        addChild(choiceLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
