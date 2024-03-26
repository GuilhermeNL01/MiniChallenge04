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
    @Published var presentScenes = false
    var firstScene = RapportTestScene(size: CGSize(width: larguraTela, height: alturaTela))
    
    var checkPoint: [String: Int] {
        get {
            UserDefaults.standard.value(forKey: "checkPoint") as? [String : Int] ?? [:]
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "checkPoint")
        }
    }
    
    init() {
//        verifyCheckPoint()
    }
    
    func verifyCheckPoint(){
        var lastPoint: (String, Int)
        
        for checkPoints in checkPoint{
            lastPoint = checkPoints
        }
        
//        switch lastPoint{
//        case ("Hotel", 0):
////            firstScene = ContextGameScene(path: $spriteKitPath, size: CGSize(width: larguraTela, height: alturaTela))
//            break
//        case ("Hotel", 1):
//            break
//        case ("Hotel", _):
//
//            break
//        case (_, _):
//
//            break
//            
//        default:
////            firstScene = VideoCutsceneScene(path: $spriteKitPath, size: CGSize(width: larguraTela, height: alturaTela))
//            break
//        }
        firstScene.scaleMode = .fill
    }
}


