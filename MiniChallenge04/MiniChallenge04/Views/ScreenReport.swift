//
//  ScreenReport.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 27/03/24.
//

import Foundation
import SpriteKit

class ScreenReport: SKScene{
    
    var vm = ScreenReportViewModel()
    let suspicionsNode = SuspicionsNode()
    let node = MasterNode()
    let squareNode = SquareNode()
    
    var countTaps = 0
    
    override func didMove(to view: SKView) {
        vm.scene = self
        vm.cluesArea()
        self.addChild(node)
        node.config()
        suspicionsNode.position = CGPoint(x: 1100, y: 300)
        addChild(suspicionsNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let position = touch.location(in: self)
        let nodes = self.nodes(at: position)
        guard let node = nodes.first else { return }
        
        switch node.name{
        case squareNode.newNode.name:
            squareNode.changeNode()
//        case squareNode.newNode4.name:
            print("Galitzine")
        default:
            print(node.name)
            break
        }
    }
}
