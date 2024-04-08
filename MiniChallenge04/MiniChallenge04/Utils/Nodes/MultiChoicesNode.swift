//
//  MultiChoicesNode.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 03/04/24.
//

import Foundation
import SpriteKit

class MultiChoicesNode: SKNode{
    var choiceNode1: ChoiceNode
    var choiceNode2: ChoiceNode
    var choiceNode3: ChoiceNode
    var selectedChoice: Choice?
    private var hasAppeared = false
    private var blur = SKSpriteNode(imageNamed: "choicesBlur")
    
    init(choice1: Choice, choice2: Choice, choice3: Choice) {
        self.choiceNode1 = ChoiceNode(choice: choice1)
        self.choiceNode2 = ChoiceNode(choice: choice2)
        self.choiceNode3 = ChoiceNode(choice: choice3)
        
        super.init()
        
        blur.anchorPoint = CGPoint(x: 0, y: 1)
        blur.position = CGPoint(x: 0, y: alturaTela)
        self.alpha = 0
        
        addChild(blur)
        setupChoices()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func removeFromParent() {
        hasAppeared = false
        let fadeOut = SKAction.fadeOut(withDuration: 0.4)
        let remove = SKAction.run {
            super.removeFromParent()
        }
        
        self.run(.sequence([fadeOut, remove]))
    }
    
        func appear(){
            if !hasAppeared{
                let action = SKAction.fadeIn(withDuration: 0.4)
                self.run(action)
                blur.run(.fadeIn(withDuration: 1))
                hasAppeared = true
            }
        }
    
    private func setupChoices(){
        self.choiceNode1.position = CGPoint(x: larguraTela * 0.3, y: alturaTela * 0.86)
        self.choiceNode2.position = CGPoint(x: choiceNode1.position.x, y: choiceNode1.position.y - (alturaTela * 0.15))
        self.choiceNode3.position = CGPoint(x: choiceNode2.position.x, y: choiceNode2.position.y - (alturaTela * 0.15))
        
        self.choiceNode1.name = "choice1"
        self.choiceNode2.name = "choice2"
        self.choiceNode3.name = "choice3"
        
        addChild(choiceNode1)
        addChild(choiceNode2)
        addChild(choiceNode3)
    }
}
