//
//  PierScene.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 09/04/24.
//

import SpriteKit
import SwiftUI

class PierScene: SKScene, GameplayScene{
    
    @Binding var path: [SKScene]
    
    var cenario: SKSpriteNode = SKSpriteNode(imageNamed: "Pier")
    
    var dialogos: [DialogueBox] = []
    var dialogueCount = 0
    
    var choice1 = Choice(text: "Question Peter's character", score: 0)
    var choice2 = Choice(text: "Point out her neglect over Peter", score: 2)
    var choice3 = Choice(text: "Inquire about Peter's absence", score: 1)
    var choicesNode: MultiChoicesNode
    
    private var phase = 1
    
    let carrie = NPC(.main)
    var suspect = NPC(.victimsWife)
    var info = NPC(.info)
    
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
        UserDefaults.standard.setValue(Checkpoints.pier.rawValue, forKey: "checkpoint")
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
            highlight.texture = SKTexture(image: .elenaBrookeAnimation1)
            let animationAtlas = [SKTexture(image: .elenaBrookeAnimation1),
                                  SKTexture(image: .elenaBrookeAnimation2),
                                  SKTexture(image: .elenaBrookeAnimation3),
                                  SKTexture(image: .elenaBrookeAnimation4),
                                  SKTexture(image: .elenaBrookeAnimation5),
                                  SKTexture(image: .elenaBrookeAnimation6),
                                  SKTexture(image: .elenaBrookeAnimation7),
                                  SKTexture(image: .elenaBrookeAnimation8),
                                  SKTexture(image: .elenaBrookeAnimation9),
                                  SKTexture(image: .elenaBrookeAnimation10),
                                  SKTexture(image: .elenaBrookeAnimation11),
            ]
            let animation = SKAction.animate(with: animationAtlas, timePerFrame: 0.1)
            let animationBackwards = animation.reversed()
            
            highlight.name = "highlight"
            highlight.position = CGPoint(x: larguraTela * 0.28, y: alturaTela * 0.42)
            highlight.size = CGSize(width: 492, height: 862)
            highlight.run(.repeatForever(.sequence([animation, animationBackwards])))
            addChild(highlight)
            character.position = highlight.position
            addChild(character)
        }
    }
    
    func switchConversation() {
        switch dialogueCount{
        case 20:
            if !disableTouch{
                interrogationStart()
            }
            break
        case 45:
                proximoDialogo()
                sidebar.bottomSidebar.insight1.text = "• Peter hadn’t been home for days due to a disagreement with Elena."
                dialogueCount += 1
        case 46:
            if !disableTouch{
                sidebar.ml.classify(prompt: "I haven't been feeling well after this loss, so maybe I misspoke earlier, that's all." , npc: suspect)
                choicesNode.appear()
            }
            disableTouch = true
        case 53:
            if choicesNode.selectedChoice?.score == 2{
                sidebar.ml.classify(prompt: "I'm sorry, officer… I have been so shaken up by everything…", npc: suspect)
                proximoDialogo()
                dialogueCount += 1
            }
        case 60:
            if choicesNode.selectedChoice?.score == 0{
                sidebar.ml.classify(prompt: "It's offensive to have you assume things about my late husband like that!", npc: suspect)
            }
            proximoDialogo()
            dialogueCount += 1
        case 83:
            if !disableTouch{
                proximoDialogo()
                self.choice1 = Choice(text: "Accuse her of covering for an accomplice", score: 2)
                self.choice2 = Choice(text: "Imply her involvement in the murder", score: 0)
                self.choice3 = Choice(text: "Question Elena’s relationship with her friend", score: 1)
                choicesNode = MultiChoicesNode(choice1: choice1, choice2: choice2, choice3: choice3)
                self.insertChild(choicesNode, at: 3)
                choicesNode.appear()
            }
            disableTouch = true
        default:
            if !disableTouch{
                if dialogos.count > 1{
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
            phase == 1 ? choice1Selected() : choice2Selected()
            break
        case 1:
            phase == 1 ? choice3Selected() : choice3Selected()
            break
        default:
            phase == 1 ? choice2Selected() : choice1Selected()
            break
        }
    }
}

extension PierScene{
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
            }
            proximoDialogo()
            dialogueCount += 1
            self.disableTouch = false
        } else {
            sceneHandler(touchedNode: touchedNode)
        }
    }
    
    private func buildDialogues(){
       dialogos = [
        DialogueBox(mensagem: "As you are walking around the pier, you carefully take in all your surroundings. This is where Peter Brooke's body was found, but you can't be sure yet if this is where he died.", mensageiro: info),
        DialogueBox(mensagem: "The air here is heavy due to recent events, and the place is almost completely empty. Almost, with the exception of a lady looking longingly at the distance.", mensageiro: info),
        DialogueBox(mensagem: "As you approach her, you recognize her face from your files: Elena Brooke, the victim's wife.", mensageiro: info),
        DialogueBox(mensagem: "… Excuse me, miss.", mensageiro: carrie),
        DialogueBox(mensagem: "Oh? Hello…", mensageiro: suspect),
        DialogueBox(mensagem: "As she turns towards you, you notice her eyes drifting to your badge before suddenly widening. Her demeanor changes too, from simply tired, to tired and worried.", mensageiro: info),
        DialogueBox(mensagem: "Oh, you're an officer… How… How can I help you, ma'am?", mensageiro: suspect),
        DialogueBox(mensagem: "I'm sorry for interrupting you, miss. Yes, I'm detective Carrie Farris.", mensageiro: carrie),
        DialogueBox(mensagem: "Ahem, I just wanted to ask some questions about…", mensageiro: carrie),
        DialogueBox(mensagem: "…The murder case, yes?", mensageiro: suspect),
        DialogueBox(mensagem: "Right. I'm sorry, I suppose it's better if I get straight to the point…", mensageiro: carrie),
        DialogueBox(mensagem: "You are Elena Brooke, correct?", mensageiro: carrie),
        DialogueBox(mensagem: "Yes… Yes I am.", mensageiro: suspect),
       ]
        suspect.name = "Elena Brooke"
        dialogos.append(contentsOf: [
        DialogueBox(mensagem: "Then, miss, I'm sure you must be tired from having to talk about this but… Could I bother you to answer a few questions about this case?", mensageiro: carrie),
        DialogueBox(mensagem: "… Of course, officer. I'll help how I can.", mensageiro: suspect),
        DialogueBox(mensagem: "Again, I'm so sorry Mrs. Brooke. For your loss, and for having to put you through this…", mensageiro: carrie),
        DialogueBox(mensagem: "But I promise that ,if you let me, I'll do everything and anything I can to bring your husband justice.", mensageiro: carrie),
        DialogueBox(mensagem: "… …", mensageiro: suspect),
        DialogueBox(mensagem: "Thank you, officer.", mensageiro: suspect),
        DialogueBox(mensagem: "You take a better look at Elena, and notice that she looks, not only extremely tired, but also very fidgety. She doesn't look comfortable at all…", mensageiro: info),
        DialogueBox(mensagem: "Well, that's expected… But you can't shake the feeling that there might be something deeper to it…", mensageiro: info),
        DialogueBox(mensagem: "… Then, Mrs. Brooke. Let's start. I'll try not to take much of your time.", mensageiro: carrie),
        //Beginning Phase 1
        DialogueBox(mensagem: "Ma'am, can you start by telling me what you know about the case?", mensageiro: carrie), //20
        DialogueBox(mensagem: "Yes… Of course.", mensageiro: suspect),
        DialogueBox(mensagem: "As you know, the victim, Peter, is my husband. So I was the first to learn of his death…", mensageiro: suspect),
        DialogueBox(mensagem: "The fishermen, his colleagues, were the ones to bring me news of the tragedy. They knocked at my door early in the morning, with his favorite pocket knife in hand…", mensageiro: suspect),
        DialogueBox(mensagem: "I… I couldn't bring myself to personally confirm it, but they told me he was found in this very Pier, hidden away in a boat, tangled in a fishing net…", mensageiro: suspect),
        DialogueBox(mensagem: "The pocket knife they brought me that morning was also found with his body…", mensageiro: suspect),
        DialogueBox(mensagem: "… …", mensageiro: suspect),
        DialogueBox(mensagem: "I'm sorry officer… Can you be more specific about what you want to know? It's hard to talk about it like this…", mensageiro: suspect),
        DialogueBox(mensagem: "That's understandable, ma'am, don't worry.", mensageiro: carrie),
        DialogueBox(mensagem: "… Could you tell me more about how he was found? You've mentioned the fishing net and the pocket knife, was there anything else?", mensageiro: carrie),
        DialogueBox(mensagem: "Well, yes… At first, we all thought he had been killed with the fishing net, but when the police came for his body, they also told me there was a cut in his neck…", mensageiro: suspect),
        DialogueBox(mensagem: "… They said it was pretty deep, but no one told me whether that was what killed him, or if it was the fishing net… Or… Or something else completely different…", mensageiro: suspect),
        DialogueBox(mensagem: "I see…", mensageiro: carrie),
        DialogueBox(mensagem: "Alright… Mrs. Brooke, could you also tell me about that night specifically?", mensageiro: carrie),
        DialogueBox(mensagem: "… What about it, officer?", mensageiro: suspect),
        DialogueBox(mensagem: "Well, what you were doing, or if you knew where your husband had been before… all this took place…", mensageiro: carrie),
        DialogueBox(mensagem: "Oh… Right… I was at home… I had been at home the whole day. I was just doing my chores.", mensageiro: suspect),
        DialogueBox(mensagem: "Oh, I did leave at night though. I went to meet a good friend of mine who works at the local hotel bar…" , mensageiro: suspect),
        DialogueBox(mensagem: "And about Peter… I have no idea where he was. Or where he had been for the past few days, in a matter of fact.", mensageiro: suspect),
        DialogueBox(mensagem: "He hadn't been home for a while… And I… I didn't really go looking for him, or anything… I had heard from a friend, though, that he seemed fine, unchanged…", mensageiro: suspect),
        DialogueBox(mensagem: "… I didn't think this is how it would turn out.", mensageiro: suspect),
        DialogueBox(mensagem: "Huh… Excuse me, Mrs. Brooke, but what was the relationship between you and Mr. Brooke like?", mensageiro: carrie),
        DialogueBox(mensagem: "I'm sorry…?", mensageiro: suspect),
        DialogueBox(mensagem: "Well, it's just that, from what you've said, it seems like you weren't really that close… Was it always like that?", mensageiro: carrie),
        DialogueBox(mensagem: "… He was my husband. Of course we were close… We just had a small disagreement, nothing serious… It happens.", mensageiro: suspect),
        DialogueBox(mensagem: "I haven't been feeling well after this loss, so maybe I misspoke earlier, that's all.", mensageiro: suspect),
        DialogueBox(mensagem: "She's trying to keep an emotional distance. How can you overcome this wall?", mensageiro: info)
        ])
    }
    
    func choice1Selected(){
        if phase == 1{
            dialogos.append(contentsOf: [
                //First Choice - Choice One
                DialogueBox(mensagem: "Well, Mrs. Brooke… I don't mean to overstep any boundaries, but I'm just saying that if he was, by any chance, a bad husband–", mensageiro: carrie),
                DialogueBox(mensagem: "Excuse me, officer. I'll have to interrupt that train of thought of yours.", mensageiro: suspect),
                DialogueBox(mensagem: "It's offensive to have you assume things about my late husband like that!", mensageiro: suspect),
                DialogueBox(mensagem: "I'm not some clueless damsel who can't tell when she's being treated badly or not.", mensageiro: suspect),
                DialogueBox(mensagem: "And on top of that, respectfully, who do you think you are to assume that about my husband?", mensageiro: suspect),
                DialogueBox(mensagem: "Peter was a good man, obviously! I wouldn't have married him otherwise.", mensageiro: suspect),
                DialogueBox(mensagem: "As I said, we just had a small disagreement. It happens between couples. And that includes happy, healthy couples too, officer.",mensageiro: suspect),
                DialogueBox(mensagem: "I didn't mean to assume, Mrs. Brooke. My apologies… That was insensitive of me.", mensageiro: carrie),
                DialogueBox(mensagem: "… It's fine, I guess. It's not the first time I've heard something like that… Can we keep going?", mensageiro: suspect),
                DialogueBox(mensagem: "Of course.", mensageiro: carrie)
            ])
            dialogueCount += 10
            phase2Dialogues()
            phase += 1
        }
        else if phase == 2{
            dialogos.append(contentsOf: [
                //Second Choice - Choice One
                DialogueBox(mensagem: "… Mrs. Brooke. I don't know how you will receive this, but I really need to ask this… For the sake of bringing your husband justice…", mensageiro: carrie),
                DialogueBox(mensagem: "Are you, by any chance, covering for someone who might be involved in the murder?", mensageiro: carrie),
                DialogueBox(mensagem: "… What? Covering for someone?", mensageiro: suspect),
                DialogueBox(mensagem: "Wait, involved in the murder?! Are you talking about my friend?!", mensageiro: suspect),
                DialogueBox(mensagem: "No, officer! This isn't the case at all!", mensageiro: suspect),
                DialogueBox(mensagem: "Please, don't assume such scary things like it's nothing!", mensageiro: suspect),
                DialogueBox(mensagem: "Then, please go ahead and clarify, Mrs. Brooke.", mensageiro: carrie),
                DialogueBox(mensagem: "And I'm sorry for startling you with that assumption, but I have to get rid of these kinds of possibilities if I want to solve the case…", mensageiro: carrie),
                DialogueBox(mensagem: "Oh… Oh, of course… I see.", mensageiro: suspect),
                DialogueBox(mensagem: "Then, I should probably start by clarifying that this friend of mine is the singer who works at night in the hotel bar… Her name's Carmen.", mensageiro: suspect),
                DialogueBox(mensagem: "We have been close friends since I moved to Aldrich with Peter. She has always helped me so much, officer… I promise you she would never do something this horrid.", mensageiro: suspect),
                DialogueBox(mensagem: "She's a good woman, really. She's always looking out for other women in the city, not once denying help.", mensageiro: suspect),
                DialogueBox(mensagem: "She has nothing to do with this case. Nothing at all, officer.", mensageiro: suspect),
                DialogueBox(mensagem: "Carmen is just a good friend, and all she did was give me support when I needed it.", mensageiro: suspect),
                DialogueBox(mensagem: "Sure, she might not have been very happy with how I stayed with Peter even after he changed but… I'm sure she would never wish anything bad on him.", mensageiro: suspect),
                DialogueBox(mensagem: "Anyways, officer, just to make sure… Carmen has nothing to do with this. Really.", mensageiro: suspect),
                DialogueBox(mensagem: "*Sigh*", mensageiro: suspect),
                DialogueBox(mensagem: "… Mrs. Brooke?", mensageiro: carrie),
                DialogueBox(mensagem: "I'm sorry… I'm just… Just a little overwhelmed right now.", mensageiro: suspect),
                DialogueBox(mensagem: "I can't let this happen twice… I already lost Peter because of a stupid decision, I can't afford to lose Carmen too…", mensageiro: suspect),
                DialogueBox(mensagem: "What do you mean by that, Mrs. Brooke…?", mensageiro: carrie),
                DialogueBox(mensagem: "… Nothing, nevermind. It's just… It wasn't meant to turn out like this.", mensageiro: suspect),
                DialogueBox(mensagem: "Well then, officer… If you excuse me, I have to go home now…", mensageiro: suspect),
                DialogueBox(mensagem: "That's alright, Mrs. Brooke. I can't keep you here.", mensageiro: carrie),
                DialogueBox(mensagem: "And once again, I'm sorry for your loss…", mensageiro: carrie),
                DialogueBox(mensagem: "… Yes… Goodbye, officer.", mensageiro: suspect)
            ])
        }
        if let score = choicesNode.selectedChoice?.score{
            sidebar.upperSidebar.score.score += score
        }
    }
    
    func choice2Selected(){
        if phase == 1 {
            dialogos.append(contentsOf: [
                //First Choice = Choice Two
                DialogueBox(mensagem: "Mrs. Brooke, I apologize in advance if this comes off as rude, but… Even if you had a fight, something even bigger than just a small disagreement, as you've said…", mensageiro: carrie),
                DialogueBox(mensagem: "We don't hear much about spouses turning their back on each other for days, to the point of having to hear about the other from a friend…", mensageiro: carrie),
                DialogueBox(mensagem: "Not if they're genuinely close. Did you really not get worried at all about his absence? Did you really not check on him, not even once?", mensageiro: carrie),
                DialogueBox(mensagem: "Oh heavens… Of course I did! I tried!", mensageiro: suspect),
                DialogueBox(mensagem: "More than once, too! This wasn't the first time he left for days, of course I was worried for him! He wasn't like this before… ugh…", mensageiro: suspect),
                DialogueBox(mensagem: "I'm sorry, officer… I have been so shaken up by everything…", mensageiro: suspect),
                DialogueBox(mensagem: "It's alright, ma'am. Take your time…", mensageiro: carrie),
                DialogueBox(mensagem: "*Sigh*", mensageiro: suspect),
                DialogueBox(mensagem: "You know… My Peter… The Peter I married… He was such a good man. He was quiet, and reserved, but he was also so kind…", mensageiro: suspect),
                DialogueBox(mensagem: "He never gave me a reason to doubt him, or to be worried about him… He never… He never left for days without letting me know. Not even for hours!", mensageiro: suspect),
                DialogueBox(mensagem: "… He changed,  recently, though.", mensageiro: suspect),
                DialogueBox(mensagem: "At first, he went to the local hotel's bar and drank to the point of passing out and having to wait until morning to come back home…", mensageiro: suspect),
                DialogueBox(mensagem: "But in these past few months, that absence turned into days. Sometimes he wouldn't even try to give me an excuse about it, too!", mensageiro: suspect),
                DialogueBox(mensagem: "And he had this look to him… Like he was carrying this heavy weight on his back… As if he was burdened with something so complex, that he couldn't share it even with his own wife…", mensageiro: suspect),
                DialogueBox(mensagem: "And it all started when he began meeting with those weird Friedkin men… Gosh… I have always asked who they were, if they were extorting or threatening him…", mensageiro: suspect),
                DialogueBox(mensagem: "He never answered though…", mensageiro: suspect),
                DialogueBox(mensagem: "… Look… In the end, I do feel guilty, officer. I thought I was doing my best at trying to get him to come back home, but… But that wasn't enough…", mensageiro: suspect),
                DialogueBox(mensagem: "Oh Elena, I'm so sorry… I'm sure he wouldn't blame you, though…", mensageiro: carrie),
                DialogueBox(mensagem: "Yeah… He was too kind for that…", mensageiro: suspect),
                DialogueBox(mensagem: "… Sorry for letting myself get carried over… Do you need anything else?", mensageiro: suspect)
            ])
            phase2Dialogues()
            phase += 1
        }
        else if phase == 2 {
            dialogos.append(contentsOf: [
                //Second Choice - Choice Two
                DialogueBox(mensagem: "Mrs. Elena… I’m sorry for the bluntness, but…", mensageiro: carrie),
                DialogueBox(mensagem: "Are you sure you weren’t aware of Peter’s whereabouts, or his state in general, before his murder happened?", mensageiro: carrie),
                DialogueBox(mensagem: "Excuse me…?", mensageiro: suspect),
                DialogueBox(mensagem: "What exactly do you mean by that officer? Are you… Are you accusing me of killing my own husband?!", mensageiro: suspect),
                DialogueBox(mensagem: "That's an outrageous assumption! How could you even imply that?!", mensageiro: suspect),
                DialogueBox(mensagem: "That's not exactly what I was trying to say, ma'am… I was just wondering if you may have, perhaps indirectly, affected this in some way…", mensageiro: carrie),
                DialogueBox(mensagem: "Heavens, officer, could you be any more cryptic about this?!", mensageiro: suspect),
                DialogueBox(mensagem: "What exactly are you trying to say?!", mensageiro: suspect),
                DialogueBox(mensagem: "Mrs. Brooke, please–", mensageiro: carrie),
                DialogueBox(mensagem: "No! You know what? Nevermind! I don't need to hear it to know what you're trying to get at…", mensageiro: suspect),
                DialogueBox(mensagem: "I did not do anything to Peter! How could I?!" , mensageiro: suspect),
                DialogueBox(mensagem: "Even after he changed so much, all I wanted was the best for him! And the safest, too! This isn't my fault… It can't be my fault…", mensageiro: suspect),
                DialogueBox(mensagem: "I tried my best! It shouldn't have turned out like this!", mensageiro: suspect),
                DialogueBox(mensagem: "Heavens… Why…", mensageiro: suspect),
                DialogueBox(mensagem: "I– We're done here, officer! I need to go home…", mensageiro: suspect),
                DialogueBox(mensagem: "Wait, please, Mrs. Brooke–", mensageiro: carrie),
                DialogueBox(mensagem: "Before you can finish your sentence, Elena hurries away from the pier while looking completely distraught.", mensageiro: info),
                DialogueBox(mensagem: "It wouldn't be wise to chase her down, or continue this questioning while she's in that state, so you decide to take your leave as well.", mensageiro: info)
            ])
            dialogueCount += 8
        }
        if let score = choicesNode.selectedChoice?.score{
            sidebar.upperSidebar.score.score += score
        }
    }
    
    func choice3Selected(){
        if phase == 1 {
            dialogos.append(contentsOf: [
                //First Choice - Choice Three
                DialogueBox(mensagem: "I'm sorry if it sounded harsh, ma'am. I'm just wondering about his absence, that's all.", mensageiro: carrie),
                DialogueBox(mensagem: "It isn't unheard of for a couple to fight and keep their distance for a while, but given the situation, I think it's fair to wonder if there's anything more to it, don't you think?", mensageiro: carrie),
                DialogueBox(mensagem: "… You're right.", mensageiro: suspect),
                DialogueBox(mensagem: "Well, I suppose there is indeed more to it…", mensageiro: suspect),
                DialogueBox(mensagem: "Peter wasn't always like this. He used to be such a kind man…", mensageiro: suspect),
                DialogueBox(mensagem: "I mean, he had always been quiet and reserved… But he never left for days, or even hours, without letting me know beforehand.", mensageiro: suspect),
                DialogueBox(mensagem: "These past few months though, I barely see him at home for more than a week before going to the local hotel's bar and drinking to the point of passing out…", mensageiro: suspect),
                DialogueBox(mensagem: "And… It feels like he's carrying some heavy burden on his mind, too… But whenever I asked, he refused to tell me anything about it.", mensageiro: suspect),
                DialogueBox(mensagem: "… I'm sorry, he started being so secretive a while ago, that not even I myself am sure about how things became like this…", mensageiro: suspect),
                DialogueBox(mensagem: "It wasn't meant to turn out like this, actually…", mensageiro: suspect)
            ])
            dialogueCount += 10
            phase2Dialogues()
            phase += 1
        }
        else if phase == 2 {
            dialogos.append(contentsOf: [
                //Second Choice - Choice Three
                DialogueBox(mensagem: "Mrs. Elena, this might be a hasty assumption on my part, but…", mensageiro: carrie),
                DialogueBox(mensagem: "Are you and this friend of yours, in perhaps a more complex kind of relationship…?", mensageiro: carrie),
                DialogueBox(mensagem: "What…? Oh, no!", mensageiro: suspect),
                DialogueBox(mensagem: "No, officer, absolutely not! I would never do that! I understand where you are coming from though…", mensageiro: suspect),
                DialogueBox(mensagem: "*Sigh* … I guess I should clarify before this gets out of hand…", mensageiro: suspect),
                DialogueBox(mensagem: "Please do, Mrs. Brooke.", mensageiro: carrie),
                DialogueBox(mensagem: "Right… Yeah. This friend of mine, she sings at the hotel bar at night. Her name… Her name is Carmen.", mensageiro: suspect),
                DialogueBox(mensagem: "She lived here, in Aldrich, before me and Peter did, and she has always been a reliable figure for me. Actually, for other women here, too.", mensageiro: suspect),
                DialogueBox(mensagem: "I guarantee she's just a close friend, officer. She has helped and supported me through a lot…", mensageiro: suspect),
                DialogueBox(mensagem: "I would never betray Peter's trust like that. And I'm sure Carmen wouldn't either.", mensageiro: suspect),
                DialogueBox(mensagem: "Even if she has her own opinions on him… And doesn't believe me much when I say I'm happy by his side…", mensageiro: suspect),
                DialogueBox(mensagem: "… She's probably right about that too. I guess I just got comfortable in my marriage, but I can't say I have been genuinely happy in it for a while now…", mensageiro: suspect),
                DialogueBox(mensagem: "And that's not even Peter's fault, it seems…", mensageiro: suspect),
                DialogueBox(mensagem: "… Sorry for interrupting, Mrs. Brooke, but what do you mean by that?", mensageiro: carrie),
                DialogueBox(mensagem: "Huh? Oh, nothing. I'm sorry, I shouldn't be treating this as some relationship counseling session…", mensageiro: suspect),
                DialogueBox(mensagem: "But–", mensageiro: carrie),
                DialogueBox(mensagem: "Anyways, officer… That's it. Carmen is really just a close friend. And she has nothing to do with any of this. All she did was comfort me, I guarantee you.", mensageiro: suspect),
                DialogueBox(mensagem: "Now, I have some errands to run… Is there anything else you need right now, officer?" , mensageiro: suspect),
                DialogueBox(mensagem: "… Well, I wish we could have kept talking for longer, but I have no power to keep you here, Mrs. Brooke. I suppose you've helped enough.", mensageiro: carrie),
                DialogueBox(mensagem: "Alright… Okay… Then, goodbye, officer. Good… Good luck with the investigation.", mensageiro: suspect),
                DialogueBox(mensagem: "Goodbye, Mrs. Brooke…", mensageiro: carrie)
            ])
            dialogueCount += 5
        }
        if let score = choicesNode.selectedChoice?.score{
            sidebar.upperSidebar.score.score += score
        }
    }
    
    func phase2Dialogues(){
        dialogos.append(contentsOf: [
            //Beginning Phase 2
            DialogueBox(mensagem: "Alright. Let's proceed, then.", mensageiro: carrie),
            DialogueBox(mensagem: "Mrs. Brooke, you've said earlier that you left the night of the murder to meet a friend… Could you please clarify that for me?", mensageiro: carrie),
            DialogueBox(mensagem: "… There isn't much to clarify about it, officer.", mensageiro: suspect),
            DialogueBox(mensagem: "As I've said, Peter hadn't been home in days, and I was feeling anxious about it… I wanted to meet the friend in question to vent a little about it. That's all, really.", mensageiro: suspect),
            DialogueBox(mensagem: "… Right. Is that also the same friend who let you know how he was doing during this period of absence?", mensageiro: carrie),
            DialogueBox(mensagem: "I'm sorry, what do you mean?", mensageiro: suspect),
            DialogueBox(mensagem: "You mentioned you had heard from a friend that Peter seemed fine, unchanged even. Was that the same friend?", mensageiro: carrie),
            DialogueBox(mensagem: "Um, I don't see how that's relevant, officer…", mensageiro: suspect),
            DialogueBox(mensagem: "Alright, Mrs. Brooke I'll be frank with you..." , mensageiro: carrie),
            DialogueBox(mensagem: "I don't have much time to work on this case, and with how vague you have been with these details, I can't afford to be delicate about starting these discussions.", mensageiro: carrie),
            DialogueBox(mensagem: "So, my apologies, but there must be a reason why you've mentioned this friend twice instead of anything else.", mensageiro: carrie),
            DialogueBox(mensagem: "I… I see.", mensageiro: suspect),
            DialogueBox(mensagem: "Sorry, officer… I'm sorry but I just can't risk unnecessarily involving someone in this mess…", mensageiro: suspect),
            DialogueBox(mensagem: "What mess, ma'am? As far as I'm aware this is no official procedure. I'm just asking a few questions in order to solve this case as quickly and fairly as possible…", mensageiro: carrie),
            DialogueBox(mensagem: "I… I mean… This case… It's a mess, isn't it?", mensageiro: suspect),
            DialogueBox(mensagem: "… …", mensageiro: suspect),
            DialogueBox(mensagem: "Sorry, officer…  I really can't risk putting my friend in trouble…", mensageiro: suspect),
        ])
    }
}
