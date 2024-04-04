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
    let masterNode = MasterNode()
    var selectedPhoto = SKSpriteNode()
//    let squareNode = SquareNode()
    
    var countTaps = 0
    
    override func didMove(to view: SKView) {
        vm.scene = self
        vm.cluesArea()
        self.addChild(masterNode)
        masterNode.config()
        suspicionsNode.position = CGPoint(x: 1100, y: 300)
        addChild(suspicionsNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let position = touch.location(in: self)
        let nodes = self.nodes(at: position)
        guard let node = nodes.first else { return }
        let hasTouchedSuspicion = nodes.contains { node in
            node is SquareNode
        }
        
        if hasTouchedSuspicion{
            guard let touchedSuspicion = nodes.first { node in
                node is SquareNode
            } as? SquareNode else { return }
            masterNode.receiveNode(pickedSquare: touchedSuspicion.score, selectedPhoto: selectedPhoto)
            suspicionsNode.hide()
        } else {
            switch node.name{
            case masterNode.suspectPhoto.name:
                selectedPhoto = masterNode.suspectPhoto
                suspicionsNode.appear()
                
            case masterNode.locationPhoto.name:
                selectedPhoto = masterNode.locationPhoto
                suspicionsNode.appear()
            case masterNode.weaponPhoto.name:
                selectedPhoto = masterNode.weaponPhoto
                suspicionsNode.appear()
                
            default:
                print(node.name)
                break
            }
        }
    }
}
