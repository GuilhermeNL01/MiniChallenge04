//
//  RapportBar.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 25/03/24.
//

import Foundation
import SpriteKit

class RapportBar: SKNode{
    private let background = SKSpriteNode(imageNamed: "RapportBG")
    let mlModel = MachineLearningModel()
    
    override init(){
        super.init()
        background.size = CGSize(width: larguraTela * 0.26, height: alturaTela * 0.27)
        self.addChild(background)
        mlModel.label.fontSize = 20
        mlModel.label.fontName = fonteMedium
        mlModel.label.position = CGPoint(x: 0, y: -10)
        self.addChild(mlModel.label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
