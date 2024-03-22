//
//  ContextView.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 18/03/24.
//

import Foundation
import SpriteKit
import SwiftUI

class ContextGameScene: SKScene, Scenes{
    var dialogos: [DialogueBox] = [
//        DialogueBox(mensagem: "Oi", mensageiro: .mainCharacter),
//        DialogueBox(mensagem: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.", mensageiro: .victimsWife),
    ]
    
    var cenario: SKSpriteNode = SKSpriteNode(imageNamed: "Background")
    var nextScene: SKScene? // the scene after this one
    var _model = ContextModel() // creating a model object to define game properties
    
    @Binding var spriteKitPath: [SKScene] // the path of navigation views
    
    init(path: Binding<[SKScene]>, size: CGSize) {
        _spriteKitPath = path
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    private func goToNextScene(){
        nextScene = Map(path: $spriteKitPath, size: CGSize(width: larguraTela, height: alturaTela))
        if let nextScene{
            spriteKitPath.append(nextScene)
        }
    }
    
}

extension ContextGameScene{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        if dialogos.count > 1{
            proximoDialogo(true)
        } else {
            goToNextScene()
        }
    }
}
