//
//  ScreenReportViewModel.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 27/03/24.
//

import Foundation
import SpriteKit

class ScreenReportViewModel{
    
    var model = ScreenReportModel()
    weak var scene: ScreenReport?
    
    let suspectPhoto = SKSpriteNode(imageNamed: "PhotoFrame")
    let weaponPhoto = SKSpriteNode(imageNamed: "PhotoFrame")
    let locationPhoto = SKSpriteNode(imageNamed: "PhotoFrame")
    
    let squareNode: [SKSpriteNode] = []
    
    func setupPhotos(){
        guard let scene = scene else{
            return
        }
        
        let grayBox = SKSpriteNode(imageNamed: "GreatGrayBox")
        grayBox.position = CGPoint(x: 500, y: 500)
        
        let positionGrayBoxY = grayBox.position.y
        let positionGrayBoxX = grayBox.position.x
        
        suspectPhoto.name = "Jangelo"
        suspectPhoto.position.y = positionGrayBoxY+200
        suspectPhoto.position.x = positionGrayBoxX-120
        suspectPhoto.isUserInteractionEnabled = true
        
        weaponPhoto.position.y = positionGrayBoxY
        weaponPhoto.position.x = positionGrayBoxX+120
        weaponPhoto.isUserInteractionEnabled = true
        
        locationPhoto.position.y = positionGrayBoxY-200
        locationPhoto.position.x = positionGrayBoxX-120
        locationPhoto.isUserInteractionEnabled = true
    
        scene.addChild(grayBox)
        scene.addChild(suspectPhoto)
        scene.addChild(weaponPhoto)
        scene.addChild(locationPhoto)
    }
    
    func cluesArea(){
        guard let scene = scene else{
            return
        }
        
        let cluesLabel = SKSpriteNode(imageNamed: "CluesLabel")
        cluesLabel.position = CGPoint(x: 1100, y: 950)
        
        let positionCluesLabelNodeY = cluesLabel.position.y
        let positionCluesLabelNodeX = cluesLabel.position.x
        
        let cluesBox = SKSpriteNode(imageNamed: "CluesBox")
        cluesBox.position.y = positionCluesLabelNodeY-125
        cluesBox.position.x = positionCluesLabelNodeX
        
        let cluesLabeling = SKLabelNode()
//        cluesLabeling.text = "Primeiramente, preciso definir quem foi o culpado do crime."
        cluesLabeling.preferredMaxLayoutWidth = 50
        cluesLabeling.numberOfLines = 2
        cluesLabeling.fontSize = 28
        
        cluesLabeling.preferredMaxLayoutWidth = 200
        cluesLabeling.position.y = positionCluesLabelNodeY-125
        cluesLabeling.position.x = positionCluesLabelNodeX
        
        scene.addChild(cluesLabel)
        scene.addChild(cluesBox)
        scene.addChild(cluesLabeling)
    }
}
