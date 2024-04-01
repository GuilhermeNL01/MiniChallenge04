//
//  PostReportScene.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 27/03/24.
//

import Foundation
import SpriteKit
import SwiftUI

class PostReportScene: SKScene, Scenes{
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
        DialogueBox(mensagem: "There we go… I'm done with the evidence board, and the report is written and ready to be sent to my superiors.", mensageiro: carrie),
        DialogueBox(mensagem: "*Sigh* I really wish I had more time to deal with this case though… It feels like there's something much bigger beneath all of this.", mensageiro: carrie),
        DialogueBox(mensagem: "I didn't even have time to look into the group of rebellious Friedkin that supposedly settled in this city… Ugh.", mensageiro: carrie),
        DialogueBox(mensagem: "Well… Maybe I can look into it independently, without my superiors nagging me about taking longer than needed…", mensageiro: carrie),
        DialogueBox(mensagem: "*Scoff* I know this city sucks and all, but that shouldn't mean that it doesn't deserve proper closure from this case. It's, honestly, a little infuriating that the police think otherwise.", mensageiro: carrie),
        DialogueBox(mensagem: "Whatever, what's done is done. I'll have to settle with this conclusion, for now. Hopefully, despite the rush, I got it right…", mensageiro: carrie),
        DialogueBox(mensagem: "We'll see. Time to send the report, and wait for the results…", mensageiro: carrie),
        ]
    }
}

extension PreReportScene{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if dialogos.count > 1{
            proximoDialogo(true)
        } else {
            trocarCena(nextScene: ContextGameScene(path: $path))
        }
    }
}
