//
//  RapportTestView.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 25/03/24.
//

import Foundation
import SpriteKit
import SwiftUI

class RapportTestScene: SKScene{
//    var rapport = RapportBar()
//    var sideScore = Score()
    var upperSidebar = UpperSidebar()
    @Binding var spriteKitPath: [SKScene]
    
    init(spriteKitPath: Binding<[SKScene]>, size: CGSize) {
        _spriteKitPath = spriteKitPath
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        addChild(upperSidebar)
        upperSidebar.position = CGPoint(x: larguraTela * 0.6, y: alturaTela * 0.7)
    }
    
    
}

extension RapportTestScene{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        upperSidebar.rapport.mlModel.classify(prompt: "Joy")
        upperSidebar.score.score += 1
    }
}
