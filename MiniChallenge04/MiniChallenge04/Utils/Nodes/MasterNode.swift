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
        
        suspectPhoto.name = PhotoNames.suspect.rawValue
        suspectPhoto.position = CGPoint(x: larguraTela * 0.18, y: alturaTela * 0.75)
        
        weaponPhoto.name = PhotoNames.weapon.rawValue
        weaponPhoto.position = CGPoint(x: larguraTela * 0.41, y: alturaTela * 0.46)
        
        locationPhoto.name = PhotoNames.location.rawValue
        locationPhoto.position = CGPoint(x: suspectPhoto.position.x, y: alturaTela * 0.242)
    
        self.addChild(suspectPhoto)
        self.addChild(weaponPhoto)
        self.addChild(locationPhoto)
    }
    
    func receiveImage(pickedSquare: Int, selectedPhoto: PhotoNode){
        switch pickedSquare{
        case 1:
            if selectedPhoto.name == PhotoNames.suspect.rawValue{
                suspectPhoto.texture = SKTexture(image: .carmenBloomPhoto)
                suspectPhoto.type = .murderer1
            }
            if selectedPhoto.name == PhotoNames.weapon.rawValue{
                weaponPhoto.texture = SKTexture(image: .pocketKnifePhoto)
                weaponPhoto.type = .weapon1
            }
            if selectedPhoto.name == PhotoNames.location.rawValue{
                locationPhoto.texture = SKTexture(image: .hotelPhoto)
                locationPhoto.type = .location1
            }
            break
        
        case 2:
            if selectedPhoto.name == PhotoNames.suspect.rawValue{
                suspectPhoto.texture = SKTexture(image: .butcherPhoto)
                suspectPhoto.type = .murderer2
            }
            if selectedPhoto.name == PhotoNames.weapon.rawValue{
                weaponPhoto.texture = SKTexture(image: .cleaverPhoto)
                weaponPhoto.type = .weapon2
            }
            if selectedPhoto.name == PhotoNames.location.rawValue{
                locationPhoto.texture = SKTexture(image: .butcherShopPhoto)
                locationPhoto.type = .location2
            }
            break
            
        default:
            if selectedPhoto.name == PhotoNames.suspect.rawValue{
                suspectPhoto.texture = SKTexture(image: .elenaBrookePhoto)
                suspectPhoto.type = .murderer3
            }
            if selectedPhoto.name == PhotoNames.weapon.rawValue{
                weaponPhoto.texture = SKTexture(image: .fishingNetPhoto)
                weaponPhoto.type = .weapon3
            }
            if selectedPhoto.name == PhotoNames.location.rawValue{
                locationPhoto.texture = SKTexture(image: .pierPhoto)
                locationPhoto.type = .location3
            }
            break
        }
        
    }
    
    enum PhotoNames: String{
        case suspect = "suspectPhoto"
        case weapon = "weaponPhoto"
        case location = "locationPhoto"
        
    }
}


