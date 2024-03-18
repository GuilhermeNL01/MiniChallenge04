//
//  Scenes.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 18/03/24.
//

import Foundation
import SpriteKit

protocol Views: SKScene{
    var dialogos:[DialogueBox] {get set}
    var cenario: SKSpriteNode {get set}
    
    func proximoDialogo()
}

extension Views{
    func proximoDialogo(){
        limparDialogos()
        
        if let dialogo = dialogos.first{
            exibirMensagem(dialogo: dialogo)
        }
    }
    
    func framingDialogueBox(personagem: Personagem, mensagem: String){
        
        let fundoMoldura = SKSpriteNode(imageNamed: "moldura")
        let moldura = SKSpriteNode(imageNamed: "\(personagem.rawValue)Falando1")
        
        if mensagem != "\n..."{
            let spriteSheet = [
                SKTexture(imageNamed: "\(personagem.rawValue)Falando1"),
                SKTexture(imageNamed: "\(personagem.rawValue)Falando2"),
                SKTexture(imageNamed: "\(personagem.rawValue)Falando3"),
            ]
            moldura.run(.repeatForever(.animate(with: spriteSheet, timePerFrame: 0.18)))
        }
        
        self.addChild(moldura)
        self.addChild(fundoMoldura)
    }
    
    func limparDialogos(){
        if let animacaoTexto = self.childNode(withName: "animacaoTexto"){
            animacaoTexto.removeFromParent()
        }
    }
    
    private func exibirMensagem(dialogo:DialogueBox){
        if let personagem = self.childNode(withName: "personagem"){
            personagem.removeFromParent()
        }
        
        var personagem:SKLabelNode? = nil
        if dialogo.mensageiro == .protagonista{
            personagem = SKLabelNode(text: "Carrie")
            personagem?.fontColor = .red
        } else if dialogo.mensageiro == .investigadoUm {
            personagem = SKLabelNode(text: "Investigado Um")
            personagem?.fontColor = .systemYellow
        } else if dialogo.mensageiro == .investigadoDois {
            personagem = SKLabelNode(text: "Investigado Dois")
            personagem?.fontColor = .systemGreen
        } else if dialogo.mensageiro == .investigadoTres {
            personagem = SKLabelNode(text: "Investigado Tres")
            personagem?.fontColor = .systemBlue
        }
        
        let animacaoTexto = TextAnimation()
        
        animacaoTexto.zPosition = 10
        animacaoTexto.name = "animacaoTexto"
        animacaoTexto.textAnimation(text: dialogo.mensagem)
        animacaoTexto.preferredMaxLayoutWidth = larguraTela / 1.1
        
        if animacaoTexto.lineCount == 1 {
            animacaoTexto.position.y = alturaTela/3.34
        } else if animacaoTexto.lineCount == 2{
            animacaoTexto.position.y = alturaTela/3.1
        } else {
            animacaoTexto.position.y = alturaTela/2.9
        }
        
        if larguraTela <= 667 && alturaTela <= 375{
            animacaoTexto.position.x = larguraTela/13
        } else {
            animacaoTexto.position.x = larguraTela/9
        }
        
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
