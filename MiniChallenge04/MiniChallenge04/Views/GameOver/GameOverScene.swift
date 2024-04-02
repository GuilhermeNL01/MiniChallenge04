//
//  GameOverScene.swift
//  MiniChallenge04
//
//  Created by Guilherme Nunes Lobo on 02/04/24.
//

import SpriteKit
import SwiftUI

class GameOverScene: SKScene {
    
    var background = SKSpriteNode(imageNamed: "GameOverBG")
    var overlayNode = SKShapeNode(rectOf: CGSize(width: larguraTela, height: alturaTela))
    var textLabels = [SKLabelNode]()
    var nextScene: SKScene?
    var dialogueLines = [
        "The report was received by my superiors,I feel like  ",
        "there's an even heavier weight on my shoulders now...  ",
        "I can't help but think that this case isn't over yet, but why?  ",
        "Did I miss something?  ",
        "Maybe I misinterpreted someone?  ",
        "… Was I wrong?  ",
        "Maybe I should retrace my steps, and make sure I get  ",
        "everything right.  "
    ]

    var currentLineIndex = 0
    var dialogueFinished = false
    
    @Binding var path: [SKScene]
    init(path: Binding<[SKScene]>) {
        _path = path
        super.init(size: CGSize(width: larguraTela, height: alturaTela))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        setupBack()
        setupTimerForOverlay()
    }
    
    private func setupBack(){
        background.size = size
        background.anchorPoint = CGPoint(x: 0, y: 0)
        addChild(background)
    }
    
    private func setupTimerForOverlay() {
        let timer = Timer(timeInterval: 2, target: self, selector: #selector(setupOverlay), userInfo: nil, repeats: false)
        RunLoop.main.add(timer, forMode: .common)
    }
    
    @objc private func setupOverlay() {
        overlayNode.fillColor = UIColor.black
        overlayNode.alpha = 0
        
        overlayNode.strokeColor = .clear
        overlayNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        overlayNode.zPosition = 1
        addChild(overlayNode)
        
        let fadeInAction = SKAction.fadeAlpha(to: 0.7, duration: 1.0)
        
        overlayNode.run(fadeInAction) {
            self.displayNextDialogueLine()
        }
    }
    
    private func setupTextLabel(atPosition position: CGPoint) -> SKLabelNode {
        let textLabel = SKLabelNode(fontNamed: "Arial")
        textLabel.fontSize = 35
        textLabel.fontColor = .white
        textLabel.horizontalAlignmentMode = .center
        textLabel.verticalAlignmentMode = .top
        textLabel.zPosition = 2
        
        textLabel.position = position
        addChild(textLabel)
        return textLabel
    }

    private func displayNextDialogueLine() {
        guard currentLineIndex < dialogueLines.count else {
            dialogueFinished = true
            
            if dialogueLines.count > 6 {
                addButton()
            }
            return
        }
        
        let currentLine = dialogueLines[currentLineIndex]
        let lineHeight: CGFloat = 90
        
        let positionY = size.height - CGFloat(textLabels.count + 1) * lineHeight
        let newTextLabel = setupTextLabel(atPosition: CGPoint(x: size.width / 2, y: positionY))
        newTextLabel.alpha = 0
        textLabels.append(newTextLabel)
        
        let fadeInAction = SKAction.fadeIn(withDuration: 1.2)
        
        newTextLabel.text = currentLine
        
        newTextLabel.run(fadeInAction) {
            self.currentLineIndex += 1
            self.displayNextDialogueLine()
        }
    }

    private func buttonTapped(){
        path.removeAll()
    }
    private func addButton() {
        let button = SKSpriteNode(imageNamed: "TryAgain")
        button.position = CGPoint(x: size.width / 2, y: 100)
        button.zPosition = 3
        button.name = "button"
        addChild(button)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if let node = self.nodes(at: location).first as? SKSpriteNode, node.name == "button" {
                buttonTapped()
            }
        }
    }

    }


