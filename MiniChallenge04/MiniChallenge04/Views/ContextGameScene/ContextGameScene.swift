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
       // DialogueBox(mensagem: "Oi", mensageiro: .protagonista),
        DialogueBox(mensagem: "It has been a while since I last got to gear up for the investigation of a murder case! I can't help but feel a little excited…", mensageiro: .protagonista),
        DialogueBox(mensagem: "Well, I mean… I'd be more excited if I wasn't the only one being sent, but I guess the other officers can't be bothered to tag along when the case is set in a place like that. ", mensageiro: .protagonista),
        DialogueBox(mensagem: "… Aldrich, huh? What a place… It's probably the most neglected city in the whole state. This isn't the first murder case that the locals have witnessed, and I'm sure it won't be the last.", mensageiro: .protagonista),
        DialogueBox(mensagem: "At least, not when criminal activity is so rampant there, with all those gangs and under the table businesses, if you know what I mean…", mensageiro: .protagonista),
        DialogueBox(mensagem: "This murder case is different though! Or so I have been told. Seems like neither the victim, Peter Brooke, nor their closest connections had any association with the criminal side of Aldrich.", mensageiro: .protagonista),
        DialogueBox(mensagem: "And that's unheard of. At least in that city… I guess that explains why the police are intervening this time, when they usually turn a blind eye to… uh, well… any crime that takes place there…?", mensageiro: .protagonista),
        DialogueBox(mensagem: "No, that's not right… Truthfully, everyone, not only the police, turns a blind eye to pretty much everything that has Aldrich's name mentioned, not only crime.", mensageiro: .protagonista),
        DialogueBox(mensagem: "Whatever. I can't do much about that… ", mensageiro: .protagonista),
        DialogueBox(mensagem: "But I sure can do something about this case! Well then, I should go over the information I have so far.", mensageiro: .protagonista),
        DialogueBox(mensagem: "For starters, my superiors have pointed out three locations of interest that I should investigate.", mensageiro: .protagonista),
        DialogueBox(mensagem: "Also, Aldrich is a small town, and the locals are pretty familiar with one another. So, interrogating three locals should be enough.", mensageiro: .protagonista),
        DialogueBox(mensagem: "Visiting those places and interrogating those locals should be enough to also give me some clues about what was used as the murder weapon.", mensageiro: .protagonista),
        DialogueBox(mensagem: "Alright. By the end of it, I should have at least a hunch about who might be the culprit, where the crime took place, and what weapon was used to murder Peter Brooke.", mensageiro: .protagonista),
        DialogueBox(mensagem: "Oh! And… Apparently, there's a group of rebellious Friedkin that has settled in the city. Maybe I should keep an eye out for that.", mensageiro: .protagonista),
        DialogueBox(mensagem: "I mean, who knows! Maybe… Maybe I'll be able to avenge my mom…", mensageiro: .protagonista),
        DialogueBox(mensagem: "......", mensageiro: .protagonista),
        DialogueBox(mensagem: "Anyways! I'm all set. Let's start by picking the first location to investigate.", mensageiro: .protagonista),

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
