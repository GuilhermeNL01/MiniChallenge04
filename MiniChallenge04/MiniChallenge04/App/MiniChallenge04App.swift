//
//  MiniChallenge04App.swift
//  MiniChallenge04
//
//  Created by Guilherme Nunes Lobo on 06/03/24.
//

import SwiftUI
import SpriteKit

@main
struct MiniChallenge04App: App {
    @State var path: [SKScene] = []
    
    var body: some Scene {
        WindowGroup {
            FirstScreen(vm: FirstScreenViewModel(path: $path))
        }
    }
}
