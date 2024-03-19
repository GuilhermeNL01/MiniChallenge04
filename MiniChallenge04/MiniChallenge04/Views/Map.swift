//
//  Map.swift
//  MiniChallenge04
//
//  Created by Victor Assis on 18/03/24.
//

import SpriteKit

class Map: SKScene{
    var background = SKSpriteNode(imageNamed: "MapBackground")
    var hotel = SKSpriteNode(imageNamed: "HotelImage")
    var pier = SKSpriteNode(imageNamed: "PierImage")
    var butcher = SKSpriteNode(imageNamed: "ButcherImage")
    
    
    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let screenHeight: CGFloat = UIScreen.main.bounds.width
    var myView: SKView = SKView()
    
    override func didMove(to view: SKView) {
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        background.name = "Background"
        addChild(background)
        hotel.position = CGPoint(x: frame.size.width * 0.23, y: frame.size.height * 0.65)
        hotel.name = "Hotel"
        addChild(hotel)
        pier.position = CGPoint(x: frame.size.width * 0.5, y: frame.size.height * 0.297)
        pier.name = "Pier"
        addChild(pier)
        butcher.position = CGPoint(x: frame.size.width * 0.765, y: frame.size.height * 0.638)
        butcher.name = "Butcher"
        myView = view
        addChild(butcher)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if touchedNode.name == "Hotel" {
            let cenaTransition = CenaTransition(size: CGSize(width: screenWidth, height: screenHeight))
            myView.presentScene(cenaTransition)
        }
        if touchedNode.name == "Pier" {
            let cenaTransition2 = CenaTransition2(size: CGSize(width: screenWidth, height: screenHeight))
            myView.presentScene(cenaTransition2)
        }
        if touchedNode.name == "Butcher" {
            let cenaTransition3 = CenaTransition3(size: CGSize(width: screenWidth, height: screenHeight))
            myView.presentScene(cenaTransition3)
        }
    }
}



