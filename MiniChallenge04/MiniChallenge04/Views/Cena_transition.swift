//
//  Cena_transition.swift
//  MiniChallenge04
//
//  Created by Victor Assis on 19/03/24.
//

import SpriteKit

class CenaTransition: SKScene {
    
    var characterNode: SKSpriteNode!
    var cameraNode: SKCameraNode!
    var background: SKSpriteNode!
    var dialogos: [DialogueBox] = []
    
    override func didMove(to view: SKView) {
        background = SKSpriteNode(imageNamed: "Background")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = self.size
        addChild(background)
        
        characterNode = SKSpriteNode(imageNamed: "character")
        characterNode.position = CGPoint(x: frame.midX - 200, y: frame.midY)
        addChild(characterNode)
        
        cameraNode = SKCameraNode()
        camera = cameraNode
        addChild(cameraNode)
        self.camera = cameraNode
        
        cameraNode.position = CGPoint(x: frame.midX, y: frame.midY)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            
            if touchedNode == characterNode {
                let zoomInAction = SKAction.scale(to: 0.8, duration: 1.0)
                cameraNode.run(zoomInAction)
                
                let centerPosition = CGPoint(x: background.position.x, y: background.position.y)
                let moveAction = SKAction.move(to: centerPosition, duration: 1.0)
                characterNode.run(moveAction)
                
                
            }
        }
    }
}
