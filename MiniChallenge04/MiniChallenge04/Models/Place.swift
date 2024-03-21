//
//  Place.swift
//  MiniChallenge04
//
//  Created by Victor Assis on 21/03/24.
//

import Foundation

struct Place {
    
    var npc: NPC
    var background: String
    var object: String
    var choices: [Int]
    var sceneNumber: Int
    var successIndicator: Int
    var mlText: String
    
    
    init(npc: NPC, background: String, object: String, choices: [Int], sceneNumber: Int, successIndicator: Int, mlText: String) {
        self.npc = npc
        self.background = background
        self.object = object
        self.choices = choices
        self.sceneNumber = sceneNumber
        self.successIndicator = successIndicator
        self.mlText = mlText
    }
    
    func setSuccessIndicator() {
        // lógica para definir o indicador de sucesso
    }
    
    func setObj() {
        //  lógica para definir o objeto da cena
    }
    
    func setNPC() {
        //  lógica para definir o NPC da cena
    }
    
    func setBackground() {
        //  lógica para definir o background da cena
    }
    
    func setAnswer() {
        //  lógica para retornar a resposta escolhida pelo jogador
    }
    
    func analyseTextML() {
        //  lógica para analisar o texto dos NPCs
    }
}
