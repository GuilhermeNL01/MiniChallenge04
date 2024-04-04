//
//  Hotel.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 03/04/24.
//

import SpriteKit
import SwiftUI

class HotelScene: SKScene, GameplayScene {
    @Binding var path: [SKScene]
    
    var cenario: SKSpriteNode = SKSpriteNode(imageNamed: "hotelBarBackground")
    
    var dialogos: [DialogueBox] = []
    var dialogueCount = 0
    
    var choice1 = Choice(text: "Threaten with legal consequences", score: 0)
    var choice2 = Choice(text: "Convince with legal facts", score: 2)
    var choice3 = Choice(text: "Change the subject", score: 1)
    var choicesNode: MultiChoicesNode
    
    private var phase: Int = 1
    
    
    let carrie = NPC(.main)
    var suspect = NPC(.receptionist)
    let info = NPC(.info)
    
    var sidebar = SidebarNode()
    var hasFinishedAnimation = false
    var disableTouch = false
    
    init(path: Binding<[SKScene]>){
        _path = path
        choicesNode = MultiChoicesNode(choice1: choice1, choice2: choice2, choice3: choice3)
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
            dialogueCount += 1
            addChild(choicesNode)
            choicesNode.appear()
        case 46:
            if choicesNode.selectedChoice?.score == 1{
                sidebar.upperSidebar.score.score = 1
                sidebar.ml.classify(prompt: "Whatever you say, Miss officer.", npc: suspect)
            } else if choicesNode.selectedChoice?.score == 2{
                sidebar.upperSidebar.score.score = 2
                sidebar.ml.classify(prompt: "She is pleased with the subject change, but is this actually the best approach possible here?", npc: suspect)
            }
            proximoDialogo()
            dialogueCount += 1
        case 47:
            if choicesNode.selectedChoice?.score == 0{
                sidebar.ml.classify(prompt: "Hearing that from you is actually a little infuriating, really…", npc: suspect)
            } else if choicesNode.selectedChoice?.score == 2 {
                sidebar.bottomSidebar.insight1.text = "• Carmen was out, supposedly seeing Elena, during the night of the crime."
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.sidebar.bottomSidebar.insight2.text = "• Looks like she is close friends with Elena Brooke, the victim’s wife."
                }
            }
            proximoDialogo()
            dialogueCount += 1
        case 52:
            sidebar.ml.classify(prompt: "Really, I'm surprised you heard that so clearly, though.", npc: suspect)
            addChild(choicesNode)
            choicesNode.appear()
//            proximoDialogo()
//            dialogueCount += 1
        default:
            if !disableTouch{
                if dialogos.count >= 1{
                    proximoDialogo()
                    dialogueCount += 1
                } else {
                trocarCena(nextScene: Map(path: $path))
                }
            }
        }
    }
    
    func rebuildDialogues(score: Int){
        switch score{
        case 0:
            choice1Selected()
            break
        case 2:
            choice2Selected()
            break
        default:
            choice3Selected()
            break
        }
    }
}

// handling touch and dialogue building
extension HotelScene{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = self.atPoint(location) // first node in hierarchy
        let nodes = self.nodes(at: location) // all nodes in hierarchy
        
        let touchedChoice = nodes.contains { node in // verify if there is any choice node in nodes
            node is ChoiceNode
        }
        
        if touchedChoice{
            let choice = nodes.first(where: { node in
                node is ChoiceNode
            }) as? ChoiceNode
            choicesNode.selectedChoice = choice?.choice
            choicesNode.removeFromParent()
            if let score = choice?.choice.score{
                rebuildDialogues(score: score)
                proximoDialogo()
            }
        } else {
            sceneHandler(touchedNode: touchedNode)
            print(dialogueCount)
        }
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
        ])
    }

    func choice1Selected(){
        if phase == 1{
            dialogos.append(contentsOf: [
                DialogueBox(mensagem: "Well, Carmen... Here's something else you might find surprising: did you know that, legally speaking, obstruction of justice can lead up to 6 years in prison?", mensageiro: carrie),
                DialogueBox(mensagem: "Oh, you're funny, Miss officer. They sent a single detective to solve an unusual murder case in Aldrich. Do you really think they'll care about sending me to prison over, well, not talking?", mensageiro: suspect),
                DialogueBox(mensagem: "Hearing that from you is actually a little infuriating, really…", mensageiro: suspect),
            ])
            dialogueCount += 4
            phase2Dialogues()
            phase += 1
        } else if phase == 2{
            dialogos.append(contentsOf: [
                DialogueBox(mensagem: "Oh? From that response I'd have to assume you are covering for her.", mensageiro: carrie),
                DialogueBox(mensagem: "And when did I say that, Miss officer? Honestly, I thought you were a professional…", mensageiro: suspect),
                DialogueBox(mensagem: "", mensageiro: <#T##NPC#>),
                DialogueBox(mensagem: "", mensageiro: <#T##NPC#>),
                DialogueBox(mensagem: "", mensageiro: <#T##NPC#>),
                DialogueBox(mensagem: "", mensageiro: <#T##NPC#>),
                DialogueBox(mensagem: "", mensageiro: <#T##NPC#>),
                DialogueBox(mensagem: "", mensageiro: <#T##NPC#>),
            ])
        }
    }
    
    func choice2Selected(){
        if phase == 1 {
            dialogos.append(contentsOf: [
                DialogueBox(mensagem: "Ma'am… Miss Bloom... Obstruction of justice can lead up to 6 years in prison… I wouldn't want you to go through that for omitting such a simple piece of information.", mensageiro: carrie),
                DialogueBox(mensagem: "It's your alibi we're talking about here, you know?", mensageiro: carrie),
                DialogueBox(mensagem: "Whether you stayed or not… That won't make you more or less suspicious. But not wanting to answer… that will.", mensageiro: carrie),
                DialogueBox(mensagem: "And if you're in prison, you can't exactly protect your colleagues, can you? And that seems important to you. Helping people out, I mean.", mensageiro: carrie),
                DialogueBox(mensagem: "...", mensageiro: suspect),
                DialogueBox(mensagem: "Right… I suppose so.", mensageiro: suspect),
                DialogueBox(mensagem: "Then, I, in fact, did not stay after my show that night. A friend of mine, Elena, called me right after, and I left to meet with her.", mensageiro: suspect),
            ])
            phase2Dialogues()
            phase += 1
        } else if phase == 2{
            dialogos.append(contentsOf: [
            
            ])
            }
    }
    
    func choice3Selected(){
        if phase == 1{
            dialogos.append(contentsOf: [
                DialogueBox(mensagem: "*Sigh* … Alright. Then, I will be nice and assume you did actually stay at the hotel bar even after your show was done.", mensageiro: carrie),
                DialogueBox(mensagem: "Whatever you say, Miss officer.", mensageiro: suspect),
                DialogueBox(mensagem: "Well, would you like to ask about anything else?", mensageiro: suspect),
            ])
            dialogueCount += 4
            phase2Dialogues()
            phase += 1
        } else if phase == 2{
            dialogos.append(contentsOf: [

            ])

        }
    }
    
    func phase2Dialogues(){
        dialogos.append(contentsOf: [
            DialogueBox(mensagem: "Alright. Carrying on…", mensageiro: carrie),
            DialogueBox(mensagem: "You also muttered something about an Elena earlier… What was that about?", mensageiro: carrie),
            DialogueBox(mensagem: "Gosh, darling, you’re eavesdropping now? I was just talking to myself.", mensageiro: suspect),
            DialogueBox(mensagem: "Really, I’m surprised you heard that so clearly, though.", mensageiro: suspect)
        ])
    }
}
