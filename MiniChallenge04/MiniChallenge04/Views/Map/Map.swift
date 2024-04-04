//
//  Map.swift
//  MiniChallenge04
//
//  Created by Victor Assis on 18/03/24.
//

import SpriteKit
import SwiftUI

class Map: SKScene{
    var background = SKSpriteNode(imageNamed: "MapBackground")
    var hotel = SKSpriteNode(imageNamed: "HotelAvailable")
    var pier = SKSpriteNode(imageNamed: "PierAvailable")
    var butcher = SKSpriteNode(imageNamed: "ButcherAvailable")
    var hotelModel = Place(name: "Hotel", background: "", object: "", choices: [3], successIndicator: 6, mlText: "")
    var pierModel = Place(name: "Pier", background: "", object: "", choices: [3], successIndicator: 6, mlText: "")
    var butcherModel = Place(name: "Butcher", background: "", object: "", choices: [3], successIndicator: 6, mlText: "")
    
    var myView: SKView = SKView()
    var nextScene: SKScene?
    @Binding var path: [SKScene]
    
    init(path: Binding<[SKScene]>){
        _path = path
        super.init(size: CGSize(width: larguraTela, height: alturaTela))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        buildMap()
    }
    
    private func buildMap(){
    
        setupBack()
        hotel.position = CGPoint(x: frame.size.width * 0.23, y: frame.size.height * 0.65)
        hotel.name = "Hotel"
        if hotelModel.hasViseted{
            hotel.texture = SKTexture(imageNamed: "HotelInactive")
            self.hotel.isUserInteractionEnabled = false
        }
        addChild(hotel)
        
        
        pier.position = CGPoint(x: frame.size.width * 0.5, y: frame.size.height * 0.297)
        pier.name = "Pier"
        if pierModel.hasViseted{
            pier.texture = SKTexture(imageNamed: "PierInactive")
            self.pier.isUserInteractionEnabled = false
        }
        addChild(pier)
        butcher.position = CGPoint(x: frame.size.width * 0.765, y: frame.size.height * 0.638)
        butcher.name = "Butcher"
        if butcherModel.hasViseted{
            butcher.texture = SKTexture(imageNamed: "ButcherInactive")
            self.butcher.isUserInteractionEnabled = false
        }
        addChild(butcher)
        if let view = view{
            myView = view
        }
    }
    
    private func setupBack(){
        background.size = size
        background.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(background)
    }
    
    private func goToNextScene(sceneName: String){
        
        switch sceneName{
        case "Hotel":
            if self.hotelModel.hasViseted == false{
                self.hotelModel.hasViseted = true
                UserDefaults.standard.setValue(true, forKey: "hasViseted")
                
                let animation = SKAction.animate(with: [SKTexture(imageNamed: "HotelAvailable"),
                                                       SKTexture(imageNamed: "HotelSelected")]
                                                , timePerFrame: 0.5, resize: false, restore: false)
                
                self.hotel.run(animation)
                self.hotel.isUserInteractionEnabled = false
                
                
                self.run(.sequence([
                    .wait(forDuration: 0.1),
                    .run {
                        self.hotel.texture = SKTexture(imageNamed: "HotelInactive")
                    },
                    .wait(forDuration: 0.1),
                    .run {
                        self.nextScene = CenaTransition(size: CGSize(width: larguraTela, height: alturaTela))
                    }
                ]))
            }
                    
            break
        case "Pier":
            if self.pierModel.hasViseted == false{
                self.pierModel.hasViseted = true
                UserDefaults.standard.setValue(true, forKey: "hasViseted")
                
                let animation = SKAction.animate(with: [SKTexture(imageNamed: "PierAvailable"),
                                                       SKTexture(imageNamed: "PierSelected")]
                                                , timePerFrame: 0.5, resize: false, restore: false)
                
                self.pier.run(animation)
                self.pier.isUserInteractionEnabled = false
                
                
                self.run(.sequence([
                    .wait(forDuration: 0.1),
                    .run {
                        self.pier.texture = SKTexture(imageNamed: "PierInactive")
                    },
                    .wait(forDuration: 0.1),
                    .run {
                        self.nextScene = CenaTransition2(size: CGSize(width: larguraTela, height: alturaTela))
                    }
                ]))
            }
              
            break
        case "Butcher":
            if self.butcherModel.hasViseted == false{
                self.butcherModel.hasViseted = true
                UserDefaults.standard.setValue(true, forKey: "hasViseted")
                
                let animation = SKAction.animate(with: [SKTexture(imageNamed: "ButcherAvailable"),
                                                       SKTexture(imageNamed: "ButcherSelected")]
                                                , timePerFrame: 0.5, resize: false, restore: false)
                
                self.butcher.run(animation)
                self.butcher.isUserInteractionEnabled = false
                
                
                self.run(.sequence([
                    .wait(forDuration: 0.1),
                    .run {
                        self.butcher.texture = SKTexture(imageNamed: "ButcherInactive")
                    },
                    .wait(forDuration: 0.1),
                    .run {
                        self.nextScene = CenaTransition3(size: CGSize(width: larguraTela, height: alturaTela))
                    }
                ]))
            }
              
            break
        default: break
        }
        if let nextScene{
            path.append(nextScene)
        }
    }
    
}

extension Map{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let touchedNode = touchedNode.name{
            goToNextScene(sceneName: touchedNode)
        }
    }
}

