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
    
    var checkPoint: [String: Int] {
        get {
            UserDefaults.standard.value(forKey: "checkPoint") as? [String : Int] ?? [:]
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "checkPoint")
        }
    }
}


