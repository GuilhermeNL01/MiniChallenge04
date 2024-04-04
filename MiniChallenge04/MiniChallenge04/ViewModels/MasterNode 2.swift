//
//  teste.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 02/04/24.
//

import SpriteKit

class MasterNode: SKNode {
    let suspectPhoto = SKSpriteNode(imageNamed: "PhotoFrame")
    let weaponPhoto = SKSpriteNode(imageNamed: "PhotoFrame")
    let locationPhoto = SKSpriteNode(imageNamed: "PhotoFrame")
    
    let suspicionsNode = SuspicionsNode()
    let squareNode = SquareNode()
    var delegate:MasterNodeDelegate? = nil
    
    func config() {
        self.isUserInteractionEnabled = true
        setupPhotos()
        cluesArea()
    }
    
    func setupPhotos(){
        
        let grayBox = SKSpriteNode(imageNamed: "GreatGrayBox")
        grayBox.position = CGPoint(x: 500, y: 500)
        
        let positionGrayBoxY = grayBox.position.y
        let positionGrayBoxX = grayBox.position.x
        
        suspectPhoto.name = "Jangelo"
        suspectPhoto.position.y = positionGrayBoxY+200
        suspectPhoto.position.x = positionGrayBoxX-120
        
        weaponPhoto.name = "Jangelo2"
        weaponPhoto.position.y = positionGrayBoxY
        weaponPhoto.position.x = positionGrayBoxX+120
        
        locationPhoto.name = "Jangelo3"
        locationPhoto.position.y = positionGrayBoxY-200
        locationPhoto.position.x = positionGrayBoxX-120
    
        self.addChild(grayBox)
        self.addChild(suspectPhoto)
        self.addChild(weaponPhoto)
        self.addChild(locationPhoto)
    }
    
    func cluesArea(){
        
        let cluesLabel = SKSpriteNode(imageNamed: "CluesLabel")
        cluesLabel.position = CGPoint(x: 1100, y: 950)
        
        let positionCluesLabelNodeY = cluesLabel.position.y
        let positionCluesLabelNodeX = cluesLabel.position.x
        
        let cluesBox = SKSpriteNode(imageNamed: "CluesBox")
        cluesBox.position.y = positionCluesLabelNodeY-125
        cluesBox.position.x = positionCluesLabelNodeX
        
        let cluesLabeling = SKLabelNode()
        cluesLabeling.text = "Primeiramente, preciso definir quem foi o culpado do crime."
        cluesLabeling.fontSize = 28
        
        cluesLabeling.preferredMaxLayoutWidth = 200
        cluesLabeling.position.y = positionCluesLabelNodeY-125
        cluesLabeling.position.x = positionCluesLabelNodeX
        
        self.addChild(cluesLabel)
        self.addChild(cluesBox)
        self.addChild(cluesLabeling)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        print("chegou")
        guard let position = touch?.location(in: self) else {return}
        let nodes = self.nodes(at: position)
        let node = nodes.first
        print(position)
        switch node!.name {
        case self.suspectPhoto.name:
            print("Somewhat")
            switch node!.name{
            case self.squareNode.photoNode.name:
                print("FirstBox")
            default: 
                break 
            }
        case self.weaponPhoto.name:
            print("Whatever")
        case self.locationPhoto.name:
            print("YEAH!")
        default:
            print("Anywhere else")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.tocou()
    }
}
