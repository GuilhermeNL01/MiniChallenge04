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
    @Binding var path: [SKScene]
    var firstScreen: SKScene = SKScene()
    
    var checkpoint: Checkpoints? {
        get {
            if let checkpoint = UserDefaults.standard.value(forKey: "checkpoint") as? String{
                return Checkpoints(rawValue: checkpoint)
            } else {
                return nil
            }
        }
        set {
            UserDefaults.standard.setValue(newValue?.rawValue, forKey: "checkpoint")
        }
    }
    
    init(path: Binding<[SKScene]>){
        _path = path
        checkCheckpoint()
    }
    
    private func checkCheckpoint(){
        switch checkpoint{
        case .context:
            firstScreen = ContextGameScene(path: $path)
            break
        case .map:
            firstScreen = Map(path: $path)
            break
        case .hotel:
            firstScreen = HotelScene(path: $path)
            break
        case .butcher:
            firstScreen = ButcherDialogueScene(path: $path)
            break
        case .report:
            firstScreen = ScreenReport(path: $path)
            break
        default:
            firstScreen = VideoCutsceneScene(path: $path)
            break
        }
    }
    
}

enum Checkpoints: String{
    case context
    case map
    case hotel
    case butcher
    case pier
    case report
}
