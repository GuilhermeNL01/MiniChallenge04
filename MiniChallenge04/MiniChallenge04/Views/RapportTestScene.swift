//
//  RapportTestView.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 25/03/24.
//

import Foundation
import SpriteKit
import SwiftUI

class RapportTestScene: SKScene, Scenes{
    var dialogos: [DialogueBox] = [DialogueBox(mensagem: "oi", mensageiro: .init(.main))]
    
    var cenario: SKSpriteNode = SKSpriteNode()
    
    var sidebar = SidebarNode()

    override func didMove(to view: SKView) {
        sidebar.position = CGPoint(x: larguraTela * 0.79, y: alturaTela * 0.612)
        addChild(sidebar)
        framingDialogueBox(true)
        proximoDialogo()
    }
    
    
}

extension RapportTestScene{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sidebar.upperSidebar.rapport.mlModel.classify(prompt: "Joy")
        sidebar.upperSidebar.score.score += 1
        sidebar.bottomSidebar.insight1.text = "• ainausc"
        if sidebar.bottomSidebar.insight1.text != ""{
            sidebar.bottomSidebar.insight2.text = "• ola"
        }
        if sidebar.bottomSidebar.insight2.text != ""{
            sidebar.bottomSidebar.insight3.text = "• tudo"
        }
        if sidebar.bottomSidebar.insight3.text != ""{
            sidebar.bottomSidebar.insight4.text = "• bom?"
        }
    }
}


