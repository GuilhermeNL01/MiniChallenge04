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
    var hasVisitedHotel: Bool{
        get {
            UserDefaults.standard.bool(forKey: "hasVisitedHotel")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "hasVisitedHotel")
        }
    }
    var hasVisitedPier: Bool {
        get {
            UserDefaults.standard.bool(forKey: "hasVisitedPier")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "hasVisitedPier")
        }
    }
    var hasVisitedButcher: Bool {
        get {
            UserDefaults.standard.bool(forKey: "hasVisitedButcher")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "hasVisitedButcher")
        }
    }
    
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
        UserDefaults.standard.setValue(Checkpoints.map.rawValue, forKey: "checkpoint") // defining checkpoint
        buildMap()
        if self.hasVisitedButcher && hasVisitedPier && hasVisitedHotel{
            self.nextScene = ScreenReport(path: self.$path)
            if let nextScene = self.nextScene {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    self.path.append(nextScene)
                }
            }
        }
    }
    
    private func buildMap() {
        setupBack()
        
        // Configuração do hotel
        hotel.size = CGSize(width: larguraTela * 0.25, height: alturaTela * 0.47)
        hotel.position = CGPoint(x: larguraTela * 0.23, y: alturaTela * 0.64)
        hotel.name = "Hotel"
        hotel.texture = SKTexture(image: hasVisitedHotel ? .hotelInactive : .hotelAvailable)
        addChild(hotel)
        
        // Configuração do açougueiro
        hotel.size = CGSize(width: larguraTela * 0.22, height: alturaTela * 0.46)
        butcher.position = CGPoint(x: larguraTela * 0.5, y: alturaTela * 0.35)
        butcher.name = "Butcher"
        butcher.texture = SKTexture(image: hasVisitedButcher ? .butcherInactive : .butcherAvailable)
        addChild(butcher)
        
        // Configuração do pier
        hotel.size = CGSize(width: larguraTela * 0.25, height: alturaTela * 0.47)
        pier.position = CGPoint(x: larguraTela * 0.77, y: alturaTela * 0.55)
        pier.name = "Pier"
        pier.texture = SKTexture(image: hasVisitedPier ? .pierInactive : .pierAvailable)
        addChild(pier)
    }
    
    
    
    private func setupBack(){
        background.size = size
        background.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(background)
    }
    
    private func goToNextScene(sceneName: String) {
        switch sceneName {
        case "Hotel":
            if !hasVisitedHotel {
                hasVisitedHotel = true
                
                let animation = SKAction.animate(with: [SKTexture(image: .hotelSelected),
                                                        SKTexture(image: .hotelAvailable)]
                                                 , timePerFrame: 0.05)
                
                self.hotel.run(animation)
                
                self.nextScene = HotelScene(path: self.$path)
            }
            
        case "Pier":
            if !hasVisitedPier {
                hasVisitedPier = true
                
                let animation = SKAction.animate(with: [SKTexture(image: .pierSelected),
                                                        SKTexture(image: .pierAvailable)]
                                                 , timePerFrame: 0.05, resize: false, restore: false)
                
                self.pier.run(animation)
                self.nextScene = PierScene(path: self.$path)
            }
        case "Butcher":
            if !hasVisitedButcher {
                hasVisitedButcher = true
                
                let animation = SKAction.animate(with: [SKTexture(image: .butcherSelected),
                                                        SKTexture(image: .butcherAvailable)]
                                                 , timePerFrame: 0.05, resize: false, restore: false)
                
                self.butcher.run(animation)
                self.nextScene = ButcherDialogueScene(path: self.$path)
            }
        default:
            break
            
        }
        // Verifica se tanto o hotel quanto o açougueiro foram visitados antes de ir para a cena de relatório
        if let nextScene = self.nextScene {
            path.append(nextScene)
        }
    }
}

extension Map {
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
