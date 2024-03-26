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
    
    func stopClassifying(){
        label.removeFromParent()
    }
    
    func classify(prompt: String){
        do{
            let model = try Test(configuration: .init())
            let prediction = try model.prediction(text: prompt)
            
            switch prediction.label{
            case "0":
                label.text = "Sad"
                break
            case "1":
                label.text = "Joy"
                break
            case "2":
                label.text = "Love"
                break
            case "3":
                label.text = "Anger"
                break
            case "4":
                label.text = "Fear"
                break
            case "5":
                label.text = "Surprise"
                break
            default:
                break
            }
            label.fontColor = .red
        } catch {
            print("No Emotion Detected")
        }
    }
    
}
