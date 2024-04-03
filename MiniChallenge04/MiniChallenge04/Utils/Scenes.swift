//
//  Scenes.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 18/03/24.
//

import Foundation
import SpriteKit

protocol Scenes: SKScene{
    var path: [SKScene] {get set}
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
            if dialogo.mensageiro.type == .info{
                hideNameTag()
            } else {
                showsNameTag()
            }
        }
    }
    
    func framingDialogueBox(){
        let nameTag = SKSpriteNode(imageNamed: "NameTag")
        nameTag.name = "nameTag"
        nameTag.anchorPoint = CGPoint(x: 0, y: 0)
        nameTag.size = CGSize(width: larguraTela * 0.29, height: alturaTela * 0.08)
        nameTag.position = CGPoint(x: larguraTela * 0.02, y: alturaTela * 0.23)
        self.addChild(nameTag)
        
        let textBox = SKSpriteNode(imageNamed: "TextBox")
        textBox.name = "textBox"
        textBox.anchorPoint = CGPoint(x: 0, y: 0)
        textBox.size = CGSize(width: larguraTela * 0.96, height: alturaTela * 0.2)
        textBox.position = CGPoint(x: larguraTela * 0.02, y: alturaTela * 0.03)
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
    
    func hideDialogueAnimation(){
        if let nameTag = self.childNode(withName: "nameTag"){
            nameTag.run(.fadeOut(withDuration: 0.3))
        }
        if let character = self.childNode(withName: "personagem"){
            character.run(.fadeOut(withDuration: 0.3))
        }
        if let textBox = self.childNode(withName: "textBox"){
            textBox.run(.fadeOut(withDuration: 0.3))
        }
        if let animacaoTexto = self.childNode(withName: "animacaoTexto"){
            animacaoTexto.run(.fadeOut(withDuration: 0.3))
        }
    }
    
    func showDialogueAnimation(){
        if let nameTag = self.childNode(withName: "nameTag"){
            nameTag.run(.fadeIn(withDuration: 0.3))
        }
        if let character = self.childNode(withName: "personagem"){
            character.run(.fadeIn(withDuration: 0.3))
        }
        if let textBox = self.childNode(withName: "textBox"){
            textBox.run(.fadeIn(withDuration: 0.3))
        }
        if let animacaoTexto = self.childNode(withName: "animacaoTexto"){
            animacaoTexto.run(.fadeIn(withDuration: 0.3))
        }
    }
    
    // change to next scene
    func trocarCena(nextScene: SKScene){
        nextScene.size = self.size
        nextScene.scaleMode = .aspectFill
        nextScene.backgroundColor = .black
        path.append(nextScene)
    }
    
    private func exibirMensagem(dialogo:DialogueBox){
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
                self.addChild(personagem)
                personagem.isHidden = nameTag.isHidden
            }
            personagem.zPosition = 10
            personagem.fontSize = 24
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
    
    // toggles nametag visibility
    private func hideNameTag(){
        if let nametag = self.childNode(withName: "nameTag"){
            nametag.isHidden = true
        }
        if let character = self.childNode(withName: "personagem"){
            character.isHidden = true
        }
    }
    
    // toggles nametag visibility
    private func showsNameTag(){
        if let nametag = self.childNode(withName: "nameTag"){
            nametag.isHidden = false
        }
        if let character = self.childNode(withName: "personagem"){
            character.isHidden = false
        }
    }
    
}
