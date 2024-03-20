//
//  ContextView.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 18/03/24.
//

import Foundation
import SpriteKit

class ContextGameScene: SKScene, Scenes{
    var dialogos: [DialogueBox] = [
        DialogueBox(mensagem: "Oi", mensageiro: .protagonista),
        DialogueBox(mensagem: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", mensageiro: .investigadoDois),
    ]
    
    var cenario: SKSpriteNode = SKSpriteNode(imageNamed: "Background")
    
    let test = SKLabelNode(text: "Testee")
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        setupCenario()
        framingDialogueBox(true)
        proximoDialogo()
    }
    
    private func setupCenario(){
        cenario.size = size
        cenario.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(cenario)
    }
    
}

extension ContextGameScene{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        proximoDialogo(true)
        print(touch.location(in: self))
    }
}
