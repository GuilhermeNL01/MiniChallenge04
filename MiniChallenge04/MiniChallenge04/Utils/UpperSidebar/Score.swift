//
//  Score.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 25/03/24.
//

import Foundation
import SpriteKit

class Score: SKNode{
    var score = 0 {
        didSet {
            self.setScore()
        }
    }
    var scoreVisor = SKSpriteNode(imageNamed: "Score0")
    
    override init() {
        super.init()
        self.addChild(scoreVisor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setScore(){
        switch score {
        case 0:
            self.scoreVisor.texture = SKTexture(image: .score0)
            break
        case 1:
            self.scoreVisor.texture = SKTexture(image: .score1)
            break
        case 2:
            self.scoreVisor.texture = SKTexture(image: .score2)
            break
        case 3:
            self.scoreVisor.texture = SKTexture(image: .score3)
            break
        case 4:
            self.scoreVisor.texture = SKTexture(image: .score4)
            break
        default:
            self.scoreVisor.texture = SKTexture(image: .score4)
            break
        }
    }
}
