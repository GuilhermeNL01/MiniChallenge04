//
//  GameplayScene.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 03/04/24.
//

import Foundation
import SpriteKit

protocol GameplayScene: Scenes{
    var carrie: NPC { get }
    var suspect: NPC { get set }
    var info: NPC { get }
    var dialogueCount: Int { get set }
    var sidebar : SidebarNode { get set }
    var hasFinishedAnimation : Bool { get set }
    var disableTouch : Bool { get set }
    
    func switchConversation() // used to handle specific dialogues
}

extension GameplayScene{
    // plays interrogation start animation
    func interrogationStart(){
        guard let character = suspect.node else { return }
        disableTouch = true
        
        var moveCharacterTo: CGPoint // defines a final position for character
        
        switch suspect.type{
        
        default:
            moveCharacterTo = CGPoint(x: larguraTela * 0.28, y: alturaTela * 0.43)
        }
        
        let fade = SKSpriteNode(imageNamed: "Fade") // fade image
        let fadeText = SKSpriteNode(imageNamed: "InterrogationStart") // animation text
        
        fade.size = self.size
        fade.alpha = 0
        fadeText.alpha = 0
        
        fade.anchorPoint = CGPoint(x: 0, y: 0)
        
        fadeText.position = CGPoint(x: larguraTela / 2, y: alturaTela / 2)
        
        addChild(fade)
        addChild(fadeText)
        
        let appear = SKAction.fadeIn(withDuration: 0.8)
        let disappear = SKAction.fadeOut(withDuration: 0.8)
        let remove = SKAction.run {
            fade.removeFromParent()
        }
        let fadeSequence = SKAction.sequence([.wait(forDuration: 0.5), appear, .wait(forDuration: 4.4), disappear, .wait(forDuration: 0.8), remove])
        let textSequence = SKAction.sequence([.wait(forDuration: 1.6), appear, .wait(forDuration: 2), disappear, .wait(forDuration: 0.8), remove])
        let moveCharacter = SKAction.move(to: moveCharacterTo, duration: 1)
        let showHUD = SKAction.run {
            self.addChild(self.sidebar)
            self.sidebar.appear()
            self.showDialogueAnimation()
            self.proximoDialogo()
            self.dialogueCount += 1
            self.disableTouch = false
        }
        
        
        hideDialogueAnimation()
        fade.run(fadeSequence)
        fadeText.run(textSequence)
        
        character.run(.sequence([.wait(forDuration: 6.6), moveCharacter, showHUD]))
    }
    
    // runs the first animation when clicking character
    func sceneHandler(touchedNode: SKNode){
        guard let characterNode = suspect.node else { return }
        if hasFinishedAnimation{
            switchConversation() // handles conversation
        } else { // handles scene animation before conversation
            if touchedNode == suspect.node {
                self.hasFinishedAnimation = true
                disableTouch = true
                let zoomInAction = SKAction.scale(to: 1.2, duration: 2)
                zoomInAction.timingMode = .easeInEaseOut
                let dialogueIn = SKAction.run {
                    self.framingDialogueBox()
                    self.proximoDialogo()
                    self.disableTouch = false
                }
                
                cenario.run(zoomInAction)
                characterNode.run(zoomInAction)
                
                // Criar uma ação para mover o personagem para o chão
                let moveAction = SKAction.moveTo(x: larguraTela * 0.46, duration: 2)
                moveAction.timingMode = .easeInEaseOut
                characterNode.run(.sequence([moveAction, dialogueIn]))
            }
        }
    }
}
