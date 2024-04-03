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
    @Published var label: SKLabelNode = SKLabelNode(text: "")
    
    func stopClassifying(){
        label.removeFromParent()
    }
    
    func classify(prompt: String, npc: NPC){
        do{
            let model = try Test(configuration: .init())
            let prediction = try model.prediction(text: prompt)
            
            switch prediction.label{
            case "0":
                if npc.type == .receptionist{
                    label.text = "Sad"
                }
                break
            case "1":
                if npc.type == .receptionist{
                    label.text = "Joy"
                }
                break
            case "2":
                if npc.type == .receptionist{
                    label.text = "Love"
                }
                break
            case "3":
                if npc.type == .receptionist{
                    label.text = "Anger"
                }
                break
            case "4":
                if npc.type == .receptionist{
                    label.text = "Fear"
                }
                break
            case "5":
                if npc.type == .receptionist{
                    label.text = "Good, she's been caught off guard. But I shouldn't put too much pressure on her for now.."
                }
                break
            default:
                break
            }
        } catch {
            label.text = "No Emotion Detected"
        }
    }
    
}
