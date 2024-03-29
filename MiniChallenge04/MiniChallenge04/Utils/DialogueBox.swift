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

class Decisao: DialogueBox{
    var alternativa : (Alternativa, Alternativa, Alternativa)
    
    init(alternativa: (Alternativa, Alternativa, Alternativa), mensagem: String, mensageiro: NPC) {
        self.alternativa = alternativa
        super.init(mensagem: mensagem, mensageiro: mensageiro)
    }
}

struct Alternativa{
    var nome: String
    var selecionado: Bool
}

