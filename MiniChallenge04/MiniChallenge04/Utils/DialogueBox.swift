//
//  DialogueBox.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 18/03/24.
//

import SpriteKit

class DialogueBox{
    var mensagem: String
    var mensageiro: NPC
    
    init(mensagem: String, mensageiro: NPC) {
        self.mensagem = mensagem
        self.mensageiro = mensageiro
    }
}
