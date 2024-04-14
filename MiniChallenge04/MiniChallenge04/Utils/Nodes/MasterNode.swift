//
//  teste.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 02/04/24.
//

import SpriteKit

class MasterNode: SKNode {
    let suspectPhoto = PhotoNode(imageNamed: "EmptyPhoto")
    let weaponPhoto = PhotoNode(imageNamed: "EmptyPhoto2")
    let locationPhoto = PhotoNode(imageNamed: "EmptyPhoto")
    
    func config(){
        
        suspectPhoto.name = NodeType.suspect.rawValue.photo
        suspectPhoto.position = CGPoint(x: larguraTela * 0.18, y: alturaTela * 0.75)
        
        weaponPhoto.name = NodeType.weapon.rawValue.photo
        weaponPhoto.position = CGPoint(x: larguraTela * 0.41, y: alturaTela * 0.46)
        
        locationPhoto.name = NodeType.location.rawValue.photo
        locationPhoto.position = CGPoint(x: suspectPhoto.position.x, y: alturaTela * 0.242)
        
        self.addChild(suspectPhoto)
        self.addChild(weaponPhoto)
        self.addChild(locationPhoto)
    }
    
    func receiveImage(pickedSquare: Int, selectedPhoto: PhotoNode){
        switch pickedSquare{
        case 1:
            if selectedPhoto.name == NodeType.suspect.rawValue.photo{
                suspectPhoto.texture = SKTexture(image: .carmenBloomPhoto)
                suspectPhoto.type = .murderer1
                addTextSprite(image: .textSuspectCarmen, type: .suspect)
            }
            if selectedPhoto.name == NodeType.weapon.rawValue.photo{
                weaponPhoto.texture = SKTexture(image: .pocketKnifePhoto)
                weaponPhoto.type = .weapon1
                addTextSprite(image: .textWeaponPocketKnife, type: .weapon)
            }
            if selectedPhoto.name == NodeType.location.rawValue.photo{
                locationPhoto.texture = SKTexture(image: .hotelPhoto)
                locationPhoto.type = .location1
                addTextSprite(image: .textPlaceHotelBar, type: .location)
            }
            break
            
        case 2:
            if selectedPhoto.name == NodeType.suspect.rawValue.photo{
                suspectPhoto.texture = SKTexture(image: .butcherPhoto)
                suspectPhoto.type = .murderer2
                addTextSprite(image: .textSuspectAlan, type: .suspect)
            }
            if selectedPhoto.name == NodeType.weapon.rawValue.photo{
                weaponPhoto.texture = SKTexture(image: .cleaverPhoto)
                weaponPhoto.type = .weapon2
                addTextSprite(image: .textWeaponButcherKnife, type: .weapon)
            }
            if selectedPhoto.name == NodeType.location.rawValue.photo{
                locationPhoto.texture = SKTexture(image: .butcherShopPhoto)
                locationPhoto.type = .location2
                addTextSprite(image: .textPlaceButcher, type: .location)
            }
            break
            
        default:
            if selectedPhoto.name == NodeType.suspect.rawValue.photo{
                suspectPhoto.texture = SKTexture(image: .elenaBrookePhoto)
                suspectPhoto.type = .murderer3
                addTextSprite(image: .textSuspectElena, type: .suspect)
            }
            if selectedPhoto.name == NodeType.weapon.rawValue.photo{
                weaponPhoto.texture = SKTexture(image: .fishingNetPhoto)
                weaponPhoto.type = .weapon3
                addTextSprite(image: .textWeaponFishingNet, type: .weapon)
            }
            if selectedPhoto.name == NodeType.location.rawValue.photo{
                locationPhoto.texture = SKTexture(image: .pierPhoto)
                locationPhoto.type = .location3
                addTextSprite(image: .textPlacePier, type: .location)
            }
            break
        }
        
    }
    
    private func addTextSprite(image: UIImage, type: NodeType){
        let textNode = SKSpriteNode()
        textNode.texture = SKTexture(image: image)
        
        switch type{
        case .suspect:
            if let node = self.childNode(withName: NodeType.suspect.rawValue.text) {
                node.removeFromParent()
            }
            textNode.position = CGPoint(x: larguraTela * 0.4, y: alturaTela * 0.74)
            textNode.size = CGSize(width: larguraTela * 0.21, height: alturaTela * 0.3)
            textNode.name = NodeType.suspect.rawValue.text
        case .weapon:
            if let node = self.childNode(withName: NodeType.weapon.rawValue.text) {
                node.removeFromParent()
            }
            textNode.position = CGPoint(x: larguraTela * 0.19, y: alturaTela * 0.49)
            textNode.size = CGSize(width: larguraTela * 0.21, height: alturaTela * 0.17)
            textNode.name = NodeType.weapon.rawValue.text
        case .location:
            if let node = self.childNode(withName: NodeType.location.rawValue.text) {
                node.removeFromParent()
            }
            textNode.position = CGPoint(x: larguraTela * 0.41, y: alturaTela * 0.21)
            textNode.size = CGSize(width: larguraTela * 0.2, height: alturaTela * 0.23)
            textNode.name = NodeType.location.rawValue.text
        }
        
        self.addChild(textNode)
    }
    
    enum NodeType{
        case suspect
        case weapon
        case location
        
        var rawValue: (photo: String, text: String) {
            get {
                switch self {
                case .suspect:
                    return ("suspectPhoto", "suspectText")
                case .weapon:
                    return ("weaponPhoto", "weaponText")
                case .location:
                    return ("locationPhoto", "locationText")
                }
            }
        }
    }
}


