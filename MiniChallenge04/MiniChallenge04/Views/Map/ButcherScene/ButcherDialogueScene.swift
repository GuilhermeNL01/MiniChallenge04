//
//  ButcherDialogueScene.swift
//  MiniChallenge04
//
//  Created by Guilherme Nunes Lobo on 03/04/24.
//

import SpriteKit
import SwiftUI

class ButcherDialogueScene: SKScene, GameplayScene {
    
    @Binding var path: [SKScene]
    
    var cenario: SKSpriteNode = SKSpriteNode(imageNamed: "butcherBG")
    
    var dialogos: [DialogueBox] = []
    var dialogueCount = 0
    private var phase: Int = 1

    var choice1 = Choice(text: "Press him about his nervousness", score: 0)
    var choice2 = Choice(text: "De-escalate the situation", score: 2)
    var choice3 = Choice(text: "Let him clarify", score: 1)
    var choicesNode: MultiChoicesNode
    
    let carrie = NPC(.main)
    var suspect = NPC(.butcher)
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
        UserDefaults.standard.setValue(Checkpoints.hotel.rawValue, forKey: "checkpoint")
        suspect.name = "???"
        buildDialogues()
        
        cenario.position = CGPoint(x: frame.midX, y: frame.midY)
        cenario.size = self.size
        addChild(cenario)
        
        setupCharacter()
        addChild(choicesNode)
    }
    
    private func setupCharacter(){
        if let character = suspect.node {
            let highlight = SKSpriteNode()
            highlight.texture = SKTexture(image: .alanBoucherAnimation1)
            let animationAtlas = [SKTexture(image: .alanBoucherAnimation1),
                                  SKTexture(image: .alanBoucherAnimation2),
                                  SKTexture(image: .alanBoucherAnimation3),
                                  SKTexture(image: .alanBoucherAnimation4),
                                  SKTexture(image: .alanBoucherAnimation5),
                                  SKTexture(image: .alanBoucherAnimation6),
                                  SKTexture(image: .alanBoucherAnimation7),
                                  SKTexture(image: .alanBoucherAnimation8),
                                  SKTexture(image: .alanBoucherAnimation9),
                                  SKTexture(image: .alanBoucherAnimation10),
                                  SKTexture(image: .alanBoucherAnimation11),
            ]
            let animation = SKAction.animate(with: animationAtlas, timePerFrame: 0.1)
            let animationBackwards = SKAction.animate(with: animationAtlas.reversed(), timePerFrame: 0.1)
            
            highlight.name = "highlight"
            highlight.position = CGPoint(x: larguraTela * 0.28, y: alturaTela * 0.43)
            highlight.size = CGSize(width: 492, height: 862)
            highlight.run(.repeatForever(.sequence([animation, animationBackwards])))
            addChild(highlight)
            character.position = highlight.position
            addChild(character)
        }
    }
    func switchConversation(){
        switch dialogueCount{
        case 14:
            if !disableTouch{
                interrogationStart()
            }
            break
        case 40:
            if !disableTouch{
                proximoDialogo()
                sidebar.ml.classify(prompt: "Hearing that from a detective is terrifying, you know?!", npc: suspect)
                choicesNode.appear()
            }
            disableTouch = true
            
        case 32:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.sidebar.bottomSidebar.insight1.text = "• Despite closing shop early, he was still out during the night of the crime."
            }
            proximoDialogo()
            dialogueCount += 1
        case 48:
            if choicesNode.selectedChoice?.text == "De-escalate the situation" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.sidebar.bottomSidebar.insight3.text = "• Alan may be familiar with the shady businesses of Aldrich."
                }
            }
            proximoDialogo()
            dialogueCount += 1
            
        case 43:
            if choicesNode.selectedChoice?.text == "Specify the knife as the weapon." {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    self.sidebar.bottomSidebar.insight2.text = "• There was a butcher knife left behind in the alleyway of the shop."
                }
            }
            proximoDialogo()
            dialogueCount += 1
        case 63:
            if !disableTouch{
                //                sidebar.ml.classify(prompt: "Really, I'm surprised you heard that so clearly, though.", npc: suspect)
                self.choice1 = Choice(text: "Accuse him of being the culprit", score: 0)
                self.choice2 = Choice(text: "Specify the knife as the weapon.", score: 1)
                self.choice3 = Choice(text: "Accuse him of being an accomplice ", score: 2)
                choicesNode = MultiChoicesNode(choice1: choice1, choice2: choice2, choice3: choice3)
                self.insertChild(choicesNode, at: 3)
                choicesNode.appear()
            }
            disableTouch = true
            
            
            
//        case 71:
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
//            self.sidebar.bottomSidebar.insight4.text = "• Alan saw a suspicious group together with the victim in the alleyway."
//        }
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
            phase == 1 ? choice1Selected() : choice1Selected()
            break
        case 1:
            phase == 1 ? choice3Selected() : choice2Selected()
            break
        default:
            phase == 1 ? choice2Selected() : choice3Selected()
            break
        }
    }
}
    // handling touch and dialogue building
extension ButcherDialogueScene {
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
                    dialogueCount += 1
                    self.disableTouch = false
                }
            } else {
                sceneHandler(touchedNode: touchedNode)
            }
        }
        
        
        private func buildDialogues(){
            dialogos = [
                
                // MARK: - Introdução
                
                DialogueBox(mensagem: "As you're walking through the streets, you notice a deer headed Friedkin man on his way out of the butcher shop, and towards the alleyway beside it.", mensageiro: info), // hide nametag
                DialogueBox(mensagem: "It seems like he's just a regular butcher taking out the trash, but when you make eye contact, he suddenly looks suspiciously nervous.", mensageiro: info), // hide nametag
                DialogueBox(mensagem: "You decide to approach and question him before he manages to scurry away…", mensageiro: info), // hide nametag
                DialogueBox(mensagem: "Hey! Excuse me sir, may I have a quick word with you?", mensageiro: carrie),
                DialogueBox(mensagem: "Huh?! Ah, hey… I mean, hello officer!", mensageiro: suspect),
                DialogueBox(mensagem: "Oh, he must have noticed your badge. Maybe that's why he seems nervous… Or maybe there's more to it…", mensageiro: info), // hide nametag
                DialogueBox(mensagem: "… Hello sir. I'm sorry for startling you, but I'm currently investigating the murder of Peter Brooke, and it would really help if you could answer some questions.", mensageiro: carrie),
                DialogueBox(mensagem: "I promise you it won't take too long. So, could I borrow some of your time?", mensageiro: carrie),
                DialogueBox(mensagem: "Uh… Sure… I mean, yes, officer!", mensageiro: suspect),
                DialogueBox(mensagem: "It's just some general questions. There's no need to be nervous, mister…?", mensageiro: carrie),
            ]
            // MARK: - Revelou o Nome
            suspect.name = "Alan Boucher"
            dialogos.append(contentsOf: [
                DialogueBox(mensagem: "Oh, right! Boucher. My name is Alan Boucher… I'm the local butcher.", mensageiro: suspect),
                DialogueBox(mensagem: "From up close, he seems even more nervous. It's not too shocking coming from an Aldrich resident who's suddenly dealing with an officer, but still… It feels like that's not all there is to it.", mensageiro: info),// hide nametag
                DialogueBox(mensagem: "This guy may look suspicious, but with how on edge he looks, it would be wise to take it easy with him. At least until you're sure he's more than just a regular resident…", mensageiro: info),// hide nametag
                DialogueBox(mensagem: "Alright, Mr. Boucher. Then, let's start.", mensageiro: carrie),
                
                // MARK: - Beginning phase 1
                DialogueBox(mensagem: "Well then, Mr. Boucher… Can you tell me what you know about the murder?", mensageiro: carrie),
                DialogueBox(mensagem: "Right… Well, I know the victim was Peter Brooke. He was a regular at my shop, so I recognized his name when news about his murder arrived…", mensageiro: suspect),
                DialogueBox(mensagem: "The other fishermen said he was found somewhere near the pier. I think it was in a boat…? I can't remember much, since I was pretty shocked to learn about his death…", mensageiro: suspect),
                DialogueBox(mensagem: "Oh, I do remember the fishermen talking about how he died though. They said he was tangled in a fishing net, but there was also a cut across his neck.", mensageiro: suspect),
                DialogueBox(mensagem: "The police took his body, but I don't think anyone in Aldrich knows what actually… uh… ended him, you know?", mensageiro: suspect),
                DialogueBox(mensagem: "… Yeah, I think that's all I can remember about it… In general…", mensageiro: suspect),
                DialogueBox(mensagem: "In general…? Well, that's alright.", mensageiro: carrie),
                
                DialogueBox(mensagem: "He's starting to look even more restless with every word he says… You can't tell, however, if he's the type of person who would shut down if pressured, or blow up… Let's figure it out.", mensageiro: info),// hide nametag
                DialogueBox(mensagem: "Then, for the next question… Do you remember what you were doing the day of the murder, sir?", mensageiro: carrie),
                DialogueBox(mensagem: "Uh… I guess I was working that day…? From morning to evening…", mensageiro: suspect),
                DialogueBox(mensagem: "… Alright, sir, I'll need more than that. You were working during the day, that's fine. And what were you doing at night?", mensageiro: carrie),
                
                DialogueBox(mensagem: "… Um… Uh…", mensageiro: suspect),
                DialogueBox(mensagem: "I was… closing up the shop. As usual. Yeah.", mensageiro: suspect),
                DialogueBox(mensagem: "… …", mensageiro: carrie),
                DialogueBox(mensagem: "Sir.", mensageiro: carrie),
                DialogueBox(mensagem: "Listen, I'm sorry. Really! We don't see people like you around here very often, you know?! Can't blame me for being nervous…", mensageiro: suspect),
                DialogueBox(mensagem: "That's fine, sir. I don't expect anyone to be completely calm when talking to a detective… But is that really all you can give for an alibi?", mensageiro: carrie),
                DialogueBox(mensagem: "This is a murder case. I need you to cooperate.", mensageiro: carrie),
                DialogueBox(mensagem: "Ugh, Fine… Fine!", mensageiro: suspect),
                DialogueBox(mensagem: "I worked as usual during the day, and I closed shop earlier because I was feeling a little anxious, you know?", mensageiro: suspect),
                DialogueBox(mensagem: "But I didn't go home right away. I stayed to clean up, see if that would help me relax a bit. By the time I was done, it was already late into the night.", mensageiro: suspect),
                DialogueBox(mensagem: "After that I picked up the trash to throw it out. Just like I was trying to do now before you suddenly came up to like this and interrupted me!", mensageiro: suspect),
                
                
                //            [Insight adquirido]
                //            Despite closing shop early, he was still out during the night of the crime.
                
                DialogueBox(mensagem: "There! Good enough for you? Can I go now?", mensageiro: suspect),
                DialogueBox(mensagem: "… Wow.", mensageiro: carrie),
                DialogueBox(mensagem: "So… Mr. Boucher, you were nervous  back then too, huh? I couldn't help but notice that you are a rather… anxious person…", mensageiro: carrie),
                DialogueBox(mensagem: "Hah, don't tell me you're also afraid of blood, are you? That would be funny for a butcher.", mensageiro: carrie),
                DialogueBox(mensagem: "What the hell do you mean by that?! Of course not! Why would I be!", mensageiro: suspect),
                // MARK: - ML
                
                DialogueBox(mensagem: "Hearing that from a detective is terrifying, you know?!", mensageiro: suspect), //ANALISE DO ML
            ])
        }
        func choice1Selected(){ //Escolha +0 (1)
            if phase == 1 {
                dialogos.append(contentsOf: [
                    
                    
                    // Press him about his nervousness (+0)
                    
                    
                    DialogueBox(mensagem: "Sir, this is a serious situation about a murder case. You need to cooperate, unless you want to implicate yourself… No one would be this agitated in front of a detective.", mensageiro: carrie),
                    DialogueBox(mensagem: "… What?!", mensageiro: suspect),
                    DialogueBox(mensagem: "What the hell! Anyone would be this agitated. You can't accuse me of anything because of that!", mensageiro: suspect),
                    
                    //            [Dica]
                    //            He definitely has more to say, but he won't open up with this kind of approach.
                    
                    DialogueBox(mensagem: "… Alright, sir. I'm sorry if that came across as an accusation. All I'm trying to say is that you can calm down. You aren't in trouble, after all, are you?", mensageiro: carrie),
                    DialogueBox(mensagem: "… …", mensageiro: suspect),
                    DialogueBox(mensagem: "Just hurry and ask the next question, or whatever.", mensageiro: suspect),
                ])
                dialogueCount += 4
                phase2Dialogues()
                phase += 1
            } else if phase == 2{
                dialogos.append(contentsOf: [
                // -MARK: - ESCOLHA +0
                //            Accuse him of being the culprit (+0)
                
                DialogueBox(mensagem: "Sir. I'll be very direct with you…", mensageiro: carrie),
                DialogueBox(mensagem: "Did you do it? Did you kill Peter Brooke?", mensageiro: carrie),
                DialogueBox(mensagem: "Alan is stunned into silence. It feels like minutes pass before he speaks up.", mensageiro: info),
                DialogueBox(mensagem: "WHAT?!", mensageiro: suspect),
                
                //            [Dica]
                //            That's not a good reaction. He will definitely close himself off completely.
                
                DialogueBox(mensagem: "Sir–", mensageiro: carrie),
                DialogueBox(mensagem: "WHAT THE HELL ARE YOU TALKING ABOUT?!", mensageiro: carrie),
                DialogueBox(mensagem: "You know what?! Back off! Back off this instant!", mensageiro: suspect),
                DialogueBox(mensagem: "Sir, listen–", mensageiro: carrie),
                DialogueBox(mensagem: "\"Don't\" \"sir listen\" me! I didn't do it! Obviously! Do you really think I would even be talking to you if I did?!", mensageiro: suspect),
                DialogueBox(mensagem: "We're done here! If you won't leave, then I will!", mensageiro: suspect),
                DialogueBox(mensagem: "Alright, alright! I'll go, no need to go get the other butcher knife…", mensageiro: carrie),
                DialogueBox(mensagem: "SCREW YOU!", mensageiro: suspect),
                ])
            }
            if let score = choicesNode.selectedChoice?.score{
                sidebar.upperSidebar.score.score += score
            }
        }
        
        
        func choice2Selected(){ //Escolha +2 (2)
            if phase == 1 {
                dialogos.append(contentsOf: [
                    // De-escalate the situation (+2)
                    
                    
                    DialogueBox(mensagem: "Whoa, let's take a deep breath for a moment!", mensageiro: carrie),
                    DialogueBox(mensagem: "Huh?!", mensageiro: suspect),
                    DialogueBox(mensagem: "I meant it, come on. Breathe in… Breathe out…", mensageiro: carrie),
                    DialogueBox(mensagem: "… …", mensageiro: carrie),
                    DialogueBox(mensagem: "Ugh, no, there's no need... Sorry. I didn't mean to blow up like that.", mensageiro: suspect),
                    
                    
                    //[Dica]
                    //            He has finally calmed down. He should open up a little after this.
                    
                    DialogueBox(mensagem: "Look, I was dealing with a few… financial issues. That's why I was anxious that day. The shop hasn't been doing very well these past few months, and I got desperate…", mensageiro: suspect),
                    DialogueBox(mensagem: "I almost got closely involved with the wrong crowd because of that… You know what I mean right? The darker part of town and stuff…", mensageiro: suspect),
                    
                    
                    //            [Insight adquirido]
                    //            Alan may be familiar with the shady businesses of Aldrich.
                    
                    
                    DialogueBox(mensagem: "But I dodged that bullet! Everything's fine now… Yeah…", mensageiro: suspect),
                    
                    DialogueBox(mensagem: "I see… That makes sense. Good thing you saved yourself from that headache, huh?", mensageiro: carrie),
                    
                    DialogueBox(mensagem: "Uh… Yeah, haha…", mensageiro: suspect),
                    
                ])
                dialogueCount += 2
                phase2Dialogues()
                phase += 1
            } else if phase == 2{
                dialogos.append(contentsOf: [
                //            Propose that the knife was used as the crime weapon (+2)
                
                DialogueBox(mensagem: "You know what I think, Mr. Boucher? I think you were trying to dispose of that knife of yours. Maybe you had used it for something other than butchering meat… Maybe not…", mensageiro: carrie),
                DialogueBox(mensagem: "You either speak up, or that's what I'll have to write down when sending a report to my superiors.", mensageiro: carrie),
                DialogueBox(mensagem: "No, no! Wait! Alright, I'll speak!", mensageiro: suspect),
                
                //            [Dica]
                //            Great, that worked! Looks like he'll finally spill everything.
                
                DialogueBox(mensagem: "Okay, I was financially… well… screwed. The shop isn't doing well, and I panicked! I was desperate so I uh… I started buying smuggled meat…", mensageiro: suspect),
                DialogueBox(mensagem: "Um, I regretted it right away though! I closed the shop earlier to receive the meat, but I couldn't sell that…", mensageiro: suspect),
                DialogueBox(mensagem: "I have regulars that only buy here, despite the prices, because they trust the quality of my meat. I couldn't betray their trust, so I decided to throw it away!", mensageiro: suspect),
                DialogueBox(mensagem: "That's why I had to do it late at night. I couldn't risk having my clients spot me mincing meat near the trash can, you know?! What would they think?!", mensageiro: suspect),
                DialogueBox(mensagem: "I took my knife to cut the meat into smaller pieces, easier to dispose of, but as I was doing that I heard a group of people approaching the alleyway, so… So I panicked again.", mensageiro: suspect),
                DialogueBox(mensagem: "As they got closer I just ran out of there, and forgot the knife behind. I'm still beating myself up over that stupid mistake, ugh…", mensageiro: suspect),
                
                //            [Insight adquirido]
                //            There was a butcher knife left behind in the alleyway of the shop.
                
                DialogueBox(mensagem: "… Well. That's… A lot. Thank you for your cooperation, Mr. Boucher. You can get back to throwing the actual trash out now.", mensageiro: carrie),
                DialogueBox(mensagem: "And watch out with those shady businesses. You will have nothing but regret with that.", mensageiro: carrie),
                DialogueBox(mensagem: "… Alright… Got it.", mensageiro: suspect),
                DialogueBox(mensagem: "Then, goodbye officer.", mensageiro: suspect),
                ])
            }
            if let score = choicesNode.selectedChoice?.score{
                sidebar.upperSidebar.score.score += score
            }
        }
        
        func choice3Selected(){// escolha +1 (3)
            if phase == 1{
                dialogos.append(contentsOf: [
                    //            Let him clarify (+1)
                    DialogueBox(mensagem: "That was supposed to be a joke…  But let's get back on track, we were talking about your nervousness. Can you continue what you were saying?", mensageiro: carrie),
                    
                    DialogueBox(mensagem: "*Sigh* Ugh… I overreacted a little… Sorry.", mensageiro: suspect),
                    
                    //            [Dica]
                    //            He has calmed down a little, but his demeanor is still distant.
                    
                    DialogueBox(mensagem: "Back then, I was dealing with a situation with the shop… A pretty urgent situation. That's why I was nervous.", mensageiro: suspect),
                    
                    DialogueBox(mensagem: "… Is that the only reason?", mensageiro: carrie),
                    
                    DialogueBox(mensagem: "… Yeah…", mensageiro: suspect),
                    DialogueBox(mensagem: "Ahem… So… What's the next question?", mensageiro: suspect),
                    
                ])
                dialogueCount += 4
                phase2Dialogues()
                phase += 1
            } else if phase == 2{
                dialogos.append(contentsOf: [
                    
                    // Accuse him of being an accomplice
                    DialogueBox(mensagem: "Okay, let's take a few steps back… Were you alone that night?", mensageiro: carrie),
                    DialogueBox(mensagem: "What?! What do you mean, what does that have to do with anything?!", mensageiro: suspect),
                    DialogueBox(mensagem: "Hey, before you accuse me of accusing you, hear me out first! Were you, or were you not alone? Because if you were an accomplice–", mensageiro: carrie),
                    DialogueBox(mensagem: "I DIDN'T DO IT!", mensageiro: suspect),
                    
                    //            [Dica]
                    //            He's overreacting again, but he looks in a hurry to clear things up…
                    DialogueBox(mensagem: "Really! I did not do it!", mensageiro: suspect),
                    DialogueBox(mensagem: "But yeah… There were other people there. I have nothing to do with them, though! I couldn't even see their faces!", mensageiro: suspect),
                    DialogueBox(mensagem: "But… I think they were with Mr. Brooke… Really, though, I have absolutely nothing to do with that!", mensageiro: suspect),
                    
                    //            [Insight adquirido]
                    //            Alan saw a suspicious group together with the victim in the alleyway.
                    
                    DialogueBox(mensagem: "In fact, I'm done talking! There's nothing more I can say, officer.", mensageiro: suspect),
                    DialogueBox(mensagem: "Please… Just let me finish taking out the trash.", mensageiro: suspect),
                    DialogueBox(mensagem: "… *sigh* Alright. Thank you for cooperating, sir.", mensageiro: carrie),
                    DialogueBox(mensagem: "Goodbye..", mensageiro: carrie),
                    
                ])
                dialogueCount += 2
            }
            if let score = choicesNode.selectedChoice?.score{
                sidebar.upperSidebar.score.score += score
            }
        }
        
        func phase2Dialogues(){
            dialogos.append(contentsOf: [
                DialogueBox(mensagem: "Alright. Let's keep going.", mensageiro: carrie),
                DialogueBox(mensagem: "Now, Mr. Boucher, you said you finished up by taking out the trash after cleaning up, correct?", mensageiro: carrie),
                DialogueBox(mensagem: "Yeah.", mensageiro: suspect),
                DialogueBox(mensagem: "Good, you also mentioned you did that \"late into the night\"... Correct?", mensageiro: carrie),
                DialogueBox(mensagem: "… Um… Yeah, I did.", mensageiro: suspect),
                DialogueBox(mensagem: "What's up with that? Why not wait until morning? Surely, you must have been pretty tired after cleaning up for so long…", mensageiro: carrie),
                DialogueBox(mensagem: "… Because…? Just because, I guess? Or… Or rather… I am a night owl! Yeah. So…", mensageiro: suspect),
                DialogueBox(mensagem: "Sir. I'm sorry, but that doesn't make any sense.", mensageiro: carrie),
                DialogueBox(mensagem: "It does, though! I work better at night, so why wait until morning?!", mensageiro: suspect),
                DialogueBox(mensagem: "You're a butcher. Don't you start work at early hours?", mensageiro: carrie),
                DialogueBox(mensagem: "And?! Why do you care anyways?! It's just taking out the trash, why bother asking about that?!", mensageiro: suspect),
                DialogueBox(mensagem: "Well, Mr. Boucher, I care because according to my documents a butcher's knife was found near your shop's trash. That's also why I need you to answer.", mensageiro: carrie),
                DialogueBox(mensagem: "What?!", mensageiro: suspect),
                DialogueBox(mensagem: "Ugh! This is terrifying!", mensageiro: suspect),//ANALISE DO ML
            ])
        }
    }


