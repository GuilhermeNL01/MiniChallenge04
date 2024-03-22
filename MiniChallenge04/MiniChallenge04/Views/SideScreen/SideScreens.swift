//
//  SideScreens.swift
//  MiniChallenge04
//
//  Created by Victor Assis on 22/03/24.
//

import SpriteKit

class SideScreens: SKScene {
    var blocoCentral = SKSpriteNode()
    var blocoDica = SKSpriteNode()
    var blocoTensao = SKSpriteNode()
    let node = nodeTest()
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.addChild(node)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        node.skshapeNode.fillColor = .blue
    }
}

class nodeTest: SKNode {
    var skshapeNode: SKShapeNode = SKShapeNode(rectOf: CGSize(width: 200, height: 200))
    var label:SKLabelNode = SKLabelNode(text: "teste")
    
    override init() {
        super.init()
        self.addChild(skshapeNode)
        self.addChild(label)
        self.name = "testeNode"
        skshapeNode.fillColor = .red
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("tocou")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
