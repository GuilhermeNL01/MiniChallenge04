//
//  MLModel.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 22/03/24.
//

import Foundation
import SpriteKit
import CoreML

class MachineLearningModel: ObservableObject{
    @Published var label: SKLabelNode = SKLabelNode(text: "test")
    @Published var sequence: SKAction?
    
    var promptIn: String?
    
    init(promptIn: String? = nil){
        self.promptIn = promptIn
        buildAnimation()
    }
    
    func reclassify(promptIn: String){
        self.promptIn = promptIn
        buildAnimation()
        classify()
    }
    
    func stopClassifying(){
        promptIn = ""
        label.removeFromParent()
    }
    
    func classify(){
        do{
            let model = try Test(configuration: .init())
            let prediction = try model.prediction(text: promptIn ?? "")
            
            switch prediction.label{
            case "0":
                label = SKLabelNode(text: "Sad")
                label.position = CGPoint(x: 500, y: 500)
                label.fontColor = .red
                break
            case "1":
                label = SKLabelNode(text: "Joy")
                label.position = CGPoint(x: 500, y: 500)
                label.fontColor = .red
                break
            case "2":
                label = SKLabelNode(text: "Love")
                label.position = CGPoint(x: 500, y: 500)
                label.fontColor = .red
                break
            case "3":
                label = SKLabelNode(text: "Anger")
                label.position = CGPoint(x: 500, y: 500)
                label.fontColor = .red
                break
            case "4":
                label = SKLabelNode(text: "Fear")
                label.position = CGPoint(x: 500, y: 500)
                label.fontColor = .red
                break
            case "5":
                label = SKLabelNode(text: "Surprise")
                label.position = CGPoint(x: 500, y: 500)
                label.fontColor = .red
                break
            default:
                break
            }
            print(label.text)
        } catch {
            print("No Emotion Detected")
        }
    }
    
    private func buildAnimation(){
        let appear = SKAction.fadeAlpha(to: 1, duration: 12)
        let disappear = SKAction.fadeAlpha(to: 0, duration: 6)
        sequence = SKAction.sequence([appear, disappear])
    }
   
}
