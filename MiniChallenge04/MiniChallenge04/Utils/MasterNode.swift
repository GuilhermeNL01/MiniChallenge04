//
//  teste.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 02/04/24.
//

import SpriteKit

class MasterNode: SKNode {
    let suspectPhoto = SKSpriteNode(imageNamed: "EmptyPhoto")
    let weaponPhoto = SKSpriteNode(imageNamed: "EmptyPhoto2")
    let locationPhoto = SKSpriteNode(imageNamed: "EmptyPhoto")
    
    func config(){
        
        suspectPhoto.name = PhotoNames.suspect.rawValue
        suspectPhoto.position = CGPoint(x: larguraTela * 0.18, y: alturaTela * 0.75)
        print(suspectPhoto.anchorPoint)
        
        weaponPhoto.name = PhotoNames.weapon.rawValue
        weaponPhoto.position = CGPoint(x: larguraTela * 0.41, y: alturaTela * 0.46)
        
        locationPhoto.name = PhotoNames.location.rawValue
        locationPhoto.position = CGPoint(x: suspectPhoto.position.x, y: alturaTela * 0.242)
    
        self.addChild(suspectPhoto)
        self.addChild(weaponPhoto)
        self.addChild(locationPhoto)
    }
    
    func receiveImage(pickedSquare: Int, selectedPhoto: SKSpriteNode){
        switch pickedSquare{
        case 1:
            if selectedPhoto.name == PhotoNames.suspect.rawValue{
                suspectPhoto.texture = SKTexture(image: .carmenBloomPhoto)
            }
            if selectedPhoto.name == PhotoNames.weapon.rawValue{
                weaponPhoto.texture = SKTexture(image: .pocketKnifePhoto)
            }
            if selectedPhoto.name == PhotoNames.location.rawValue{
                locationPhoto.texture = SKTexture(image: .hotelPhoto)
            }
            break
        
        case 2:
            if selectedPhoto.name == PhotoNames.suspect.rawValue{
                suspectPhoto.texture = SKTexture(image: .butcherPhoto)
            }
            if selectedPhoto.name == PhotoNames.weapon.rawValue{
                weaponPhoto.texture = SKTexture(image: .cleaverPhoto)
            }
            if selectedPhoto.name == PhotoNames.location.rawValue{
                locationPhoto.texture = SKTexture(image: .butcherShopPhoto)
            }
            break
            
        default:
            if selectedPhoto.name == PhotoNames.suspect.rawValue{
                suspectPhoto.texture = SKTexture(image: .elenaBrookePhoto)
            }
            if selectedPhoto.name == PhotoNames.weapon.rawValue{
                weaponPhoto.texture = SKTexture(image: .fishingNetPhoto)
            }
            if selectedPhoto.name == PhotoNames.location.rawValue{
                locationPhoto.texture = SKTexture(image: .pierPhoto)
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


