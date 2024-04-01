//
//  PreReportScene.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 27/03/24.
//

import Foundation
import SpriteKit
import SwiftUI

class PreReportScene: SKScene, Scenes{
    @Binding var path: [SKScene]
    
    var dialogos: [DialogueBox] = []
    var cenario: SKSpriteNode = SKSpriteNode(imageNamed: "OfficeBG")
    
    var carrie = NPC(.main)
    
    init(path: Binding<[SKScene]>){
        _path = path
        super.init(size: CGSize(width: larguraTela, height: alturaTela))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        buildScene()
        buildDialogues()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.framingDialogueBox(true)
            self.proximoDialogo()
        }
    }
    
    private func buildScene() {
        cenario.size = size
        cenario.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(cenario)
    }
        
    private func buildDialogues(){
        dialogos = [
        DialogueBox(mensagem: "Alright… I suppose I'm done questioning the locals.", mensageiro: carrie),
        DialogueBox(mensagem: "Ideally, I'd be more thorough about it, but my superiors have been hurrying me, so I can't afford to be meticulous about this investigation…", mensageiro: carrie),
        DialogueBox(mensagem: "Well, that's unfortunate, but I can work with what I've got so far!", mensageiro: carrie),
        DialogueBox(mensagem: "Now, all that's left is the report. I should set up an evidence board before writing anything down.", mensageiro: carrie),
        DialogueBox(mensagem: "By the end of this, I should have a culprit, murder weapon and place of murder pointed out in my report.", mensageiro: carrie),
        DialogueBox(mensagem: "Let's get to it, then…", mensageiro: carrie),
        ]
    }
}

extension PostReportScene{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if dialogos.count > 1{
            proximoDialogo(true)
        } else {
            trocarCena(nextScene: ContextGameScene(path: $path))
        }
    }
}
