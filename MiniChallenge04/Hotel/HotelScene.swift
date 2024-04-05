//
//  Cena_transition.swift
//  MiniChallenge04
//
//  Created by Victor Assis on 19/03/24.
//

import SpriteKit
import SwiftUI

class HotelScene: SKScene, GameplayScene {
    @Binding var path: [SKScene]
    
    var cenario: SKSpriteNode = SKSpriteNode(imageNamed: "Background")
    
    var dialogos: [DialogueBox] = []
    var dialogueCount = 0
    
    let carrie = NPC(.main)
    var suspect = NPC(.receptionist)
    let info = NPC(.info)
    
    var sidebar = SidebarNode()
    var hasFinishedAnimation = false
    var disableTouch = false
    
    var selectedChoice = Choice(text: "this is a test", score: 0)
    var choiceNodeTest = ChoiceNode(choice: selectedChoice)
    
    init(path: Binding<[SKScene]>){
        _path = path
        super.init(size: CGSize(width: larguraTela, height: alturaTela))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        suspect.name = "???"
        buildDialogues()
        
        cenario.position = CGPoint(x: frame.midX, y: frame.midY)
        cenario.size = self.size
        addChild(cenario)
        
        if let character = suspect.node {
            character.position = CGPoint(x: larguraTela * 0.28, y: alturaTela * 0.43)
            addChild(character)
        }
        addChild(choiceNodeTest)
    }
    
    private func buildDialogues(){
        dialogos = [
            DialogueBox(mensagem: "There's nothing out of place or noteworthy about this hotel bar, until you spot a flower headed Friedkin carefully watching you from a few steps away.", mensageiro: info), // hide nametag
            DialogueBox(mensagem: "She doesn't break eye contact as you approach her. In fact, it seems like she was expecting you to reach out eventually.", mensageiro: info), // hide nametag
            DialogueBox(mensagem: "… Hello, ma'am.", mensageiro: carrie),
            DialogueBox(mensagem: "Why, hello there officer… May I help you?", mensageiro: suspect),
            DialogueBox(mensagem: "She hasn't said much, but from the way she carries herself and her tone as she greets you, you can't help but feel slightly overwhelmed by her confidence. It feels like she can see right through you.", mensageiro: info), // hide nametag
            DialogueBox(mensagem: "… *Ahem* Well, ma'am, I'm sure you've heard about the murder that took place in town recently… I was sent here to investigate it, and I have a few questions for the locals…", mensageiro: carrie),
            DialogueBox(mensagem: "Well, of course, Miss officer. I suppose you wouldn't be coming to Aldrich all the way from the capital with the purpose of sightseeing…", mensageiro: suspect),
            DialogueBox(mensagem: "… Right.", mensageiro: carrie),
            DialogueBox(mensagem: "The name's Carrie Farris by the way. Not miss officer…", mensageiro: carrie),
            DialogueBox(mensagem: "Whatever you say, Miss officer Carrie Farris.", mensageiro: suspect),
            DialogueBox(mensagem: "Every word feels like a challenge from this lady. It's purposely infuriating, but you can't do anything except ignore it.", mensageiro: info), // hide nametag
            DialogueBox(mensagem: "After all, distrust for authority figures is a completely understandable behavior for an Aldrich resident.", mensageiro: info), // hide nametag
            DialogueBox(mensagem: "Anyways, ma'am, can you, or can you not answer some questions in the name of helping a humble officer figure out the one responsible for a murder case?", mensageiro: carrie),
            DialogueBox(mensagem: "Well I surely can… And I surely will. I don't think I have much of a choice, after all.", mensageiro: suspect),
            DialogueBox(mensagem: "I'd tell you that yes, you do have a choice, but I get your point… And you're right. But thank you for the cooperation anyways.", mensageiro: carrie),
            DialogueBox(mensagem: "It shouldn't take much of your time, by the way. I just want to know what you can tell me about the victim and the murder.", mensageiro: carrie),
            DialogueBox(mensagem: "Of course. You take the lead, Miss officer.", mensageiro: suspect),
            DialogueBox(mensagem: "Oh, and I'm sorry, darling, but I don't think I introduced myself yet…", mensageiro: suspect)
        ]
        suspect.name = "Carmen Bloom"
        dialogos.append(contentsOf: [
            DialogueBox(mensagem: "I'm Carmen Bloom. I work in the hotel as an entertainer, singing at night for the clients of the bar. And I suppose most employees here would also describe me as the bar manager, in a way…", mensageiro: suspect), // change carmen's name
            DialogueBox(mensagem: "…Nice to meet you. Well then, let's begin.", mensageiro: suspect),
             // Beginning phase 1
            DialogueBox(mensagem: "Well then, ma'am, could you start by telling me what you know about the case?", mensageiro: carrie),
            DialogueBox(mensagem: "Of course. Well, I think everyone in Aldrich is aware that Peter Brooke was killed a few nights ago…", mensageiro: suspect),
            DialogueBox(mensagem: "As far as the gossip goes, the local fishermen seem to have found his body in a boat near the pier in the morning. He also had a pocket knife with him, apparently.", mensageiro: suspect),
            DialogueBox(mensagem: "I wasn't close to Mr. Brooke, but I did see him very often in the hotel bar during my performances, at night.", mensageiro: suspect),
            DialogueBox(mensagem: "According to the other girls that work here, he was a quiet client. He drank a lot though, and he always looked like there was this heavy weight on his shoulder.", mensageiro: suspect),
            DialogueBox(mensagem: "I don't know if he had any enemies… But it was clear he didn't have any friends either. At least none that would sit with him in the bar.", mensageiro: suspect),
            DialogueBox(mensagem: "That's all I can tell you.", mensageiro: suspect),
            DialogueBox(mensagem: "Hm… I see. Then, ma'am, may I also ask what you were doing during the night of the murder?", mensageiro: carrie),
            DialogueBox(mensagem: "Why, of course. I was working in the hotel, as usual. Every few nights I sing at the bar. And when I'm done with my performance, I stay for a little longer to help the other girls out.", mensageiro: suspect),
            DialogueBox(mensagem: "Management here is a little… absent. And so is security in general. So we girls have to look out for each other, you know?", mensageiro: suspect),
            DialogueBox(mensagem: "Especially her… In the fragile state she's in right now…", mensageiro: suspect),
            DialogueBox(mensagem: "Carmen says that second part quietly, mostly to herself, but you hear it anyway.", mensageiro: info), // hide nametag
            DialogueBox(mensagem: "… I can respect that, yeah.", mensageiro: carrie), // toggle nametag
            DialogueBox(mensagem: "Alright… Give me a second to write all that down…", mensageiro: carrie),
            DialogueBox(mensagem: "From the tone she was using when you first approached, you'd think she knew way more about the case other than just that.", mensageiro: info), // hide nametag
            DialogueBox(mensagem: "Interesting. Maybe you should start digging deeper.", mensageiro: info),
            DialogueBox(mensagem: "Ma'am, about the night of the murder… You mentioned you tend to stay a little longer after your performances… But you didn't that night, did you?", mensageiro: carrie),
            DialogueBox(mensagem: "Huh?", mensageiro: suspect),
            DialogueBox(mensagem: "Interesting reaction coming from someone that was being so eloquent just now…", mensageiro: info),
            DialogueBox(mensagem: "I'm sorry officer, but you must be misremembering something. I never said I didn't.", mensageiro: suspect),
            DialogueBox(mensagem: "Yes, but you also never said you did. And even now, you still won't say it. So, what's up with that, Miss Bloom?", mensageiro: carrie),
            // sidebar
            DialogueBox(mensagem: "I'm surprised, officer. I wasn't expecting you to change the subject like that.", mensageiro: suspect),
            DialogueBox(mensagem: "Good, she's been caught off guard. But I shouldn't put too much pressure on her for now...", mensageiro: info), // ml reply
        ])
    }
    
    
    
    func switchConversation(){
        switch dialogueCount{
        case 19:
            if !disableTouch{
                interrogationStart()
            }
            break
        case 40:
            sidebar.ml.classify(prompt: "I'm surprised, officer. I wasn't expecting you to change the subject like that.", npc: suspect)
            proximoDialogo()
            dialogueCount += 1
        default:
            if !disableTouch{
                if dialogos.count > 1{
                    proximoDialogo()
                    dialogueCount += 1
                } else {
                    print("acabou")
                    //                trocarCena(nextScene: <#T##SKScene#>)
                }
            }
        }
    }
}

extension HotelScene{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.atPoint(location)
            print(touchedNode.name)
            guard touches.first != nil else { return }
            sceneHandler(touchedNode: touchedNode)
            print(dialogueCount)
        }
    }
}
