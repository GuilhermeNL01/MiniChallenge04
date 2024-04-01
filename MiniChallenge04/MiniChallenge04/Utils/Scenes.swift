//
//  Scenes.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 18/03/24.
//

import Foundation
import SpriteKit

protocol Scenes: SKScene{
    var dialogos:[DialogueBox] {get set}
    var cenario: SKSpriteNode {get set}
}

extension Scenes{
    func proximoDialogo(_ clearFirst: Bool? = nil){
        limparDialogos()
        
        if clearFirst == true{
            if dialogos.count != 0{
                dialogos.remove(at: 0)
            }
        }
        
        if let dialogo = dialogos.first{
            exibirMensagem(dialogo: dialogo)
        }
    }
    
    func framingDialogueBox(_ hasNameTag: Bool? = nil, _ isresazing: Bool? = nil){
        if hasNameTag == true{
            let nameTag = SKSpriteNode(imageNamed: "NameTag")
            nameTag.name = "nameTag"
            nameTag.anchorPoint = CGPoint(x: 0, y: 0)
            nameTag.size = CGSize(width: larguraTela * 0.29, height: alturaTela * 0.06)
            nameTag.position = CGPoint(x: larguraTela * 0.02, y: alturaTela * 0.24)
            if let isresazing{
                if isresazing{
                    nameTag.size = CGSize(width: larguraTela * 0.29, height: alturaTela * 0.06)
                    nameTag.position = CGPoint(x: larguraTela * 0.11, y: alturaTela * 0.28)
                }
            }
            self.addChild(nameTag)
        }
        
        let textBox = SKSpriteNode(imageNamed: "TextBox")
        textBox.name = "textBox"
        textBox.anchorPoint = CGPoint(x: 0, y: 0)
        textBox.size = CGSize(width: larguraTela * 0.96, height: alturaTela * 0.2)
        textBox.position = CGPoint(x: larguraTela * 0.02, y: alturaTela * 0.03)
        if let isresazing{
            if isresazing{
                textBox.size = CGSize(width: larguraTela * 0.768, height: alturaTela * 0.16)
                textBox.position = CGPoint(x: larguraTela * 0.11 , y: alturaTela * 0.11783)
            }
        }
       
        self.addChild(textBox)
    }
    
    func limparDialogos(){
        if let animacaoTexto = self.childNode(withName: "animacaoTexto"){
            animacaoTexto.removeFromParent()
        }
        if let personagem = self.childNode(withName: "personagem"){
            personagem.removeFromParent()
        }
    }
    
    private func exibirMensagem(dialogo:DialogueBox, _ isresazing: Bool? = nil){
        if let personagem = self.childNode(withName: "personagem"){
            personagem.removeFromParent()
        }
        
        var personagem:SKLabelNode? = nil
        
        personagem = SKLabelNode(text: dialogo.mensageiro.name)
        personagem?.fontColor = dialogo.mensageiro.type == .main ? .red : .yellow
        
        // treating the character text block
        if let personagem = personagem {
            personagem.name = "personagem"
            personagem.fontName = fonteNegrito
            if let nameTag = self.childNode(withName: "nameTag"){
                personagem.position = CGPoint (x: nameTag.position.x + (nameTag.frame.width / 2), y: alturaTela * 0.26)
                if let isresazing{
                    if isresazing{
                        personagem.position = CGPoint (x: nameTag.position.x + (nameTag.frame.width / 4), y: alturaTela * 0.30)
                    }
                }
                
            } else {
//                personagem.position = CGPoint (x: larguraTela / 8, y: alturaTela / 5)
            }
            personagem.zPosition = 10
            personagem.fontSize = 24
            self.addChild(personagem)
        }
        
        let animacaoTexto = TextAnimation()
        
        animacaoTexto.zPosition = 10
        animacaoTexto.name = "animacaoTexto"
        animacaoTexto.textAnimation(text: dialogo.mensagem)
        
        if animacaoTexto.lineCount == 1 {
            animacaoTexto.position.y = alturaTela/5.5
        } else if animacaoTexto.lineCount == 2{
            animacaoTexto.position.y = alturaTela/4.7
        } else {
            animacaoTexto.position.y = alturaTela/5.4
        }
        animacaoTexto.position.x = larguraTela/8.5
        
        self.addChild(animacaoTexto)
        
    }
    
    func trocarCena(nextScene: SKScene, transicao: Bool, duracao: Double){
        nextScene.size = self.size
        nextScene.scaleMode = .aspectFill
        nextScene.backgroundColor = .black
        if transicao{
            let transition = SKTransition.fade(withDuration: TimeInterval(duracao))
            self.view?.presentScene(nextScene, transition: transition)
        } else {
            self.view?.presentScene((nextScene))
        }
    }
    
}
