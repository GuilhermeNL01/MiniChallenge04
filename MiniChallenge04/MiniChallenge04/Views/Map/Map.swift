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
    var hotel = SKSpriteNode(imageNamed: "HotelImage")
    var pier = SKSpriteNode(imageNamed: "PierImage")
    var butcher = SKSpriteNode(imageNamed: "ButcherImage")
    
    var myView: SKView = SKView()
    var nextScene: SKScene?
    
    override func didMove(to view: SKView) {
        buildMap()
    }
    
    private func buildMap(){
    
        setupBack()
        hotel.position = CGPoint(x: frame.size.width * 0.23, y: frame.size.height * 0.65)
        hotel.name = "Hotel"
        addChild(hotel)
        pier.position = CGPoint(x: frame.size.width * 0.5, y: frame.size.height * 0.297)
        pier.name = "Pier"
        addChild(pier)
        butcher.position = CGPoint(x: frame.size.width * 0.765, y: frame.size.height * 0.638)
        butcher.name = "Butcher"
        if let view = view{
            myView = view
        }
        addChild(butcher)
    }
    
    private func setupBack(){
        background.size = size
        background.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(background)
    }
    
    private func goToNextScene(sceneName: String){
        
        switch sceneName{
        case "Hotel":
            nextScene = CenaTransition(size: CGSize(width: larguraTela, height: alturaTela))
            break
        case "Pier":
            nextScene = CenaTransition2(size: CGSize(width: larguraTela, height: alturaTela))
            break
        case "Butcher":
            nextScene = CenaTransition3(size: CGSize(width: larguraTela, height: alturaTela))
            break
        default: break
        }
        if let nextScene{
            self.view?.presentScene(nextScene)
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

