//
//  Cena_transition.swift
//  MiniChallenge04
//
//  Created by Victor Assis on 19/03/24.
//

import SpriteKit

class CenaTransition: SKScene, Scenes {
    var cenario: SKSpriteNode = SKSpriteNode()
    
    
    var characterNode: SKSpriteNode!
    var cameraNode: SKCameraNode!
    var background: SKSpriteNode!
    var dialogos: [DialogueBox] = []
    var CarmienBloom = NPC(.victimsWife)
    var _model = Place(name: "Hotel", background: "", object: "", choices: [3], successIndicator: 0, mlText: "")
    
    override func didMove(to view: SKView) {
        background = SKSpriteNode(imageNamed: "Background")
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = self.size
        addChild(background)
        
        characterNode = SKSpriteNode(imageNamed: "character")
        characterNode.position = CGPoint(x: frame.midX - 200, y: background.frame.minY + characterNode.size.height / 2)
        addChild(characterNode)
        
        cameraNode = SKCameraNode()
        camera = cameraNode
        addChild(cameraNode)
        self.camera = cameraNode
        
        cameraNode.position = CGPoint(x: frame.midX, y: frame.midY)
        
        //setupCenario()
//        framingDialogueBox(true)
//        proximoDialogo()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            
            if touchedNode == characterNode {
                let zoomInAction = SKAction.scale(to: 0.8, duration: 1.0)
                let dialogueIn = SKAction.run {
                    self.framingDialogueBox(true)
                    self.proximoDialogo()
                }
                cameraNode.run(SKAction.sequence([zoomInAction, dialogueIn]))
//                cameraNode.run(zoomInAction)
                
                // Calcular a posição do chão do plano de fundo
                let groundPosition = CGPoint(x: background.position.x, y: background.frame.minY + characterNode.size.height / 2)
                
                // Criar uma ação para mover o personagem para o chão
                let moveAction = SKAction.move(to: groundPosition, duration: 1.0)
                characterNode.run(.sequence([
                    moveAction,
                    .run {
                        
                    }
                ]))

                
            }
        }
    }
    
    private func buildDialogues(){
        dialogos = [
            DialogueBox(mensagem: "It has been a while since I last got to gear up for the investigation of a murder case! I can't help but feel a little excited…", mensageiro: CarmienBloom),
            DialogueBox(mensagem: "Well, I mean… I'd be more excited if I wasn't the only one being sent, but I guess the other officers can't be bothered to tag along when the case is set in a place like that. ", mensageiro: CarmienBloom),
            DialogueBox(mensagem: "… Aldrich, huh? What a place… It's probably the most neglected city in the whole state. This isn't the first murder case that the locals have witnessed, and I'm sure it won't be the last.", mensageiro: CarmienBloom),
            DialogueBox(mensagem: "At least, not when criminal activity is so rampant there, with all those gangs and under the table businesses, if you know what I mean…", mensageiro: CarmienBloom),
            DialogueBox(mensagem: "This murder case is different though! Or so I have been told. Seems like neither the victim, Peter Brooke, nor their closest connections had any association with the criminal side of Aldrich.", mensageiro: CarmienBloom),
            DialogueBox(mensagem: "And that's unheard of. At least in that city… I guess that explains why the police are intervening this time, when they usually turn a blind eye to… uh, well… any crime that takes place there…?", mensageiro: CarmienBloom),
            DialogueBox(mensagem: "No, that's not right… Truthfully, everyone, not only the police, turns a blind eye to pretty much everything that has Aldrich's name mentioned, not only crime.", mensageiro: CarmienBloom),
            DialogueBox(mensagem: "Whatever. I can't do much about that… ", mensageiro: CarmienBloom),
            DialogueBox(mensagem: "But I sure can do something about this case! Well then, I should go over the information I have so far.", mensageiro: CarmienBloom),
            DialogueBox(mensagem: "For starters, my superiors have pointed out three locations of interest that I should investigate.", mensageiro: CarmienBloom),
            DialogueBox(mensagem: "Also, Aldrich is a small town, and the locals are pretty familiar with one another. So, interrogating three locals should be enough.", mensageiro: CarmienBloom),
            DialogueBox(mensagem: "Visiting those places and interrogating those locals should be enough to also give me some clues about what was used as the murder weapon.", mensageiro: CarmienBloom),
            DialogueBox(mensagem: "Alright. By the end of it, I should have at least a hunch about who might be the culprit, where the crime took place, and what weapon was used to murder Peter Brooke.", mensageiro: CarmienBloom),
            DialogueBox(mensagem: "Oh! And… Apparently, there's a group of rebellious Friedkin that has settled in the city. Maybe I should keep an eye out for that.", mensageiro: CarmienBloom),
            DialogueBox(mensagem: "I mean, who knows! Maybe… Maybe I'll be able to avenge my mom…", mensageiro: CarmienBloom),
            DialogueBox(mensagem: "......", mensageiro: CarmienBloom),
            DialogueBox(mensagem: "Anyways! I'm all set. Let's start by picking the first location to investigate.", mensageiro: CarmienBloom),]
    }
}


