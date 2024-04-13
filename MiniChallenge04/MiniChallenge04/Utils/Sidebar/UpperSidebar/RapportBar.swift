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
        background.size = CGSize(width: larguraTela * 0.263, height: alturaTela * 0.261)
        self.addChild(background)
        mlModel.label.fontSize = 20
        mlModel.label.fontName = libreBaskervilleBold
        mlModel.label.position = CGPoint(x: 0, y: -34)
        mlModel.label.verticalAlignmentMode = .center
        mlModel.label.preferredMaxLayoutWidth = 237
        mlModel.label.lineBreakMode = .byWordWrapping
        mlModel.label.numberOfLines = 0
        self.addChild(mlModel.label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
