//
//  FirstScreenViewModel.swift
//  MiniChallenge04
//
//  Created by Victor Assis on 25/03/24.
//

import Foundation
import SwiftUI
import SpriteKit

class FirstScreenViewModel: ObservableObject{
    var firstScene = SKScene()
    
    var checkPoint: [String: Int] {
        get {
            UserDefaults.standard.value(forKey: "checkPoint") as! [String : Int]
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "checkPoint")
        }
    }
    
    var spriteKitPath: [SKScene] = []
    
    init() {
        verifyCheckPoint()
    }
    
    func verifyCheckPoint(){
        var lastPoint: (String, Int)
        
        for checkPoints in checkPoint{
            lastPoint = checkPoints
        }
        
        switch lastPoint{
        case ("Hotel", 0):
            firstScene = ContextGameScene(path: $spriteKitPath, size: CGSize(width: larguraTela, height: alturaTela))
            break
        case ("Hotel", 1):
            <#code#>
            break
        case ("Hotel", _):
            <#code#>
            break
        case (_, _):
            <#code#>
            break
            
        default:
            firstScene = VideoCutsceneScene(path: $spriteKitPath, size: CGSize(width: larguraTela, height: alturaTela))
            break
        }
        firstScene.scaleMode = .fill
    }
}


