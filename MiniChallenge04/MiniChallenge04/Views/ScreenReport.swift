//
//  ScreenReport.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 27/03/24.
//

import Foundation
import SpriteKit

class ScreenReport: SKScene{
    
    let bg = SKSpriteNode(imageNamed: "ReportBG")
    var vm = ScreenReportViewModel()
    let suspicionsNode = SuspicionsNode()
    let masterNode = MasterNode()
    var selectedPhoto = SKSpriteNode()
    
    let cluesBox = SKSpriteNode(imageNamed: "CluesBox")
    let cluesLabeling = SKLabelNode()
    
    let accusationsNode = SKSpriteNode(imageNamed: "Accusations0")
    
    var accusations = 0 {
        didSet {
            updateAccusationsNode()
        }
    }
    
    override func didMove(to view: SKView) {
        bg.anchorPoint = CGPoint(x: 0, y: 0)
        bg.size = self.size
        addChild(bg)
        vm.scene = self
        setupClues()
        masterNode.config()
        self.addChild(masterNode)
        suspicionsNode.position = CGPoint(x: larguraTela * 0.79, y: cluesBox.position.y - (alturaTela * 0.35))
        addChild(suspicionsNode)
        setupAccusations()
        selectedPhoto = masterNode.suspectPhoto
        suspicionsNode.changeSuspicions(type: .suspect)
        suspicionsNode.appear()
    }
    
    func setupClues(){
        guard let scene = scene else{
            return
        }
                
        cluesBox.position = CGPoint(x: larguraTela * 0.79, y: alturaTela * 0.87)
        
        cluesLabeling.text = "First I need to point out a suspect."
        cluesLabeling.fontSize = 20
        cluesLabeling.fontName = fonteMedium
        cluesLabeling.position = cluesBox.position
        
        cluesLabeling.preferredMaxLayoutWidth = larguraTela * 0.3
        cluesLabeling.numberOfLines = 0
        cluesLabeling.verticalAlignmentMode = .center
        
        scene.addChild(cluesBox)
        scene.addChild(cluesLabeling)
    }
    
    func setupAccusations(){
        accusationsNode.position = CGPoint(x: larguraTela * 0.79, y: alturaTela * 0.09)
        accusationsNode.name = "accusationsNode"
        addChild(accusationsNode)
    }
    
    private func updateAccusationsNode(){
        switch accusations{
        case 1:
            accusationsNode.texture = SKTexture(image: .accusations1)
        case 2:
            accusationsNode.texture = SKTexture(image: .accusations2)
        default:
            accusationsNode.texture = SKTexture(image: .reportReady)
        }
    }
}

extension ScreenReport{
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
            suspicionsNode.hide()
            switch accusations{
            case 0:
                masterNode.receiveImage(pickedSquare: touchedSuspicion.score, selectedPhoto: selectedPhoto)
                selectedPhoto = masterNode.locationPhoto
                suspicionsNode.changeSuspicions(type: .location)
                suspicionsNode.appear()
                accusations += 1
            case 1:
                masterNode.receiveImage(pickedSquare: touchedSuspicion.score, selectedPhoto: selectedPhoto)
                selectedPhoto = masterNode.weaponPhoto
                suspicionsNode.changeSuspicions(type: .weapon)
                suspicionsNode.appear()
                accusations += 1
            case 2:
                masterNode.receiveImage(pickedSquare: touchedSuspicion.score, selectedPhoto: selectedPhoto)
                selectedPhoto = masterNode.locationPhoto
                suspicionsNode.changeSuspicions(type: .location)
                suspicionsNode.appear()
                accusations += 1
            default:
                break
            }
        } else {
            switch node.name{
            case masterNode.suspectPhoto.name:
                selectedPhoto = masterNode.suspectPhoto
                suspicionsNode.changeSuspicions(type: .suspect)
                suspicionsNode.appear()
                
            case masterNode.locationPhoto.name:
                selectedPhoto = masterNode.locationPhoto
                suspicionsNode.changeSuspicions(type: .location)
                suspicionsNode.appear()
                
            case masterNode.weaponPhoto.name:
                selectedPhoto = masterNode.weaponPhoto
                suspicionsNode.changeSuspicions(type: .weapon)
                suspicionsNode.appear()
            
            case accusationsNode.name:
                if accusations == 3{
                 print("troca")
                }
            default:
                print(node.name)
                break
            }
        }
    }
}
