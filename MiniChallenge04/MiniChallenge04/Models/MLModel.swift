//
//  MLModel.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 22/03/24.
//

import Foundation
import SpriteKit

class MLModel: ObservableObject{
//    @Published var promptIn: String = Place(npc: <#T##NPC#>, background: <#T##String#>, object: <#T##String#>, choices: <#T##[Int]#>, sceneNumber: <#T##Int#>, successIndicator: <#T##Int#>, mlText: <#T##String#>)
    @Published var promptOut = SKLabelNode(text: "")
    
    //Comentário desnecessário
    
    func classify(){
        do{
            let model = try EmotionsML(configuration: .init())
            let prediction = try model.prediction(text: <#T##String#>)
            if prediction.label == "0"{
                let sadness = SKLabelNode(text: "Sad")
                sadness.position = CGPoint(x: 500, y: 500)
                sadness.fontColor = .red
                
                let appear = SKAction.fadeAlpha(to: 1, duration: 12)
                let disappear = SKAction.fadeAlpha(to: 0, duration: 6)
                let sequence = SKAction.sequence([appear, disappear])
            } else if prediction.label == "1"{
                let joy = SKLabelNode(text: "Joy")
                joy.position = CGPoint(x: 500, y: 500)
                joy.fontColor = .red
                
                let appear = SKAction.fadeAlpha(to: 1, duration: 12)
                let disappear = SKAction.fadeAlpha(to: 0, duration: 6)
                let sequence = SKAction.sequence([appear, disappear])
            } else if prediction.label == "2"{
                let love = SKLabelNode(text: "Love")
                love.position = CGPoint(x: 500, y: 500)
                love.fontColor = .red
                
                let appear = SKAction.fadeAlpha(to: 1, duration: 12)
                let disappear = SKAction.fadeAlpha(to: 0, duration: 6)
                let sequence = SKAction.sequence([appear, disappear])
            } else if prediction.label == "3"{
                let anger = SKLabelNode(text: "Anger")
                anger.position = CGPoint(x: 500, y: 500)
                anger.fontColor = .red
                
                let appear = SKAction.fadeAlpha(to: 1, duration: 12)
                let disappear = SKAction.fadeAlpha(to: 0, duration: 6)
                let sequence = SKAction.sequence([appear, disappear])
            } else if prediction.label == "4"{
                let fear = SKLabelNode(text: "Fear")
                fear.position = CGPoint(x: 500, y: 500)
                fear.fontColor = .red
                
                let appear = SKAction.fadeAlpha(to: 1, duration: 12)
                let disappear = SKAction.fadeAlpha(to: 0, duration: 6)
                let sequence = SKAction.sequence([appear, disappear])
            } else if prediction.label == "5"{
                let surprise = SKLabelNode(text: "Surprise")
                surprise.position = CGPoint(x: 500, y: 500)
                surprise.fontColor = .red
                
                let appear = SKAction.fadeAlpha(to: 1, duration: 12)
                let disappear = SKAction.fadeAlpha(to: 0, duration: 6)
                let sequence = SKAction.sequence([appear, disappear])
            }
        } catch {
            promptOut.text = "No Emotion Detected"
        }
    }
}
