//
//  Functions.swift
//
//
//
//

import Foundation
import SpriteKit


class TextAnimation: SKLabelNode {
    
    var lineCount: Int = 1
    let labelNode = SKLabelNode()
    
    func textAnimation(text: String){
        
        // Step 1: Set up SpriteKit scene
        labelNode.fontSize = 20
        labelNode.fontName = fonteRegular
        labelNode.position = CGPoint(x: frame.maxX/14, y: frame.midY/0.9)
        labelNode.horizontalAlignmentMode = .left // Set the horizontal alignment to left
        labelNode.verticalAlignmentMode = .top // Set the vertical alignment to top
        labelNode.numberOfLines = 0  // Permitir mÃºltiplas linhas
        labelNode.preferredMaxLayoutWidth = larguraTela * 0.7 //frame.maxX - (frame.maxX/7)
        addChild(labelNode)
        
        
        let words = text.components(separatedBy: " ")
        
        // Step 3: Create action sequence
        var actions: [SKAction] = []
        
        // Step 4: Define the typing animation
        
        var typedText = "" // Initialize a variable to track the typed characters
        var currentLine = "" // Initialize a variable to track the current line
        var lineWidth: CGFloat = 0.0
        
        for (index1, word) in words.enumerated() {
            let characters = Array(words[index1])
            
            let font = UIFont(name: labelNode.fontName ?? "", size: labelNode.fontSize)
            let wordWidth = (word + " " as NSString).size().width
            
            // Check if the word exceeds the preferred width and start a new line
            if (lineWidth + wordWidth) >= labelNode.preferredMaxLayoutWidth {
                typedText += "\n" // Add a line break before the new word starts typing
                currentLine = "" // Reset the current line
                labelNode.text = typedText // Update the labelNode text with the typedText
                lineWidth = 0.0 // Reset the line width to 0
                lineCount = lineCount+1
                
                
                let updateTextAction = SKAction.run {
                    typedText += "\n" // Add a line break before the new word starts typing
                    currentLine = "" // Reset the current line
                    self.labelNode.text = typedText // Update the labelNode text with the typedText
                    lineWidth = 0.0 // Reset the line width to 0
                }
                
                actions.append(SKAction.sequence([updateTextAction]))
                
                
            }
            
            for (index, character) in characters.enumerated() {
                let waitAction = SKAction.wait(forDuration: 0.04)
                let updateTextAction = SKAction.run {
                    typedText += String(character) // Append the new character to the typedText
                    currentLine += String(character) // Append the new character to the current line
                    self.labelNode.text = typedText // Update the labelNode text with the typedText
                    let characterWidth = (String(character) as NSString).size(withAttributes: [.font: font ?? ""]).width
                    //                    lineWidth += characterWidth // Update the line width with the character width
                    // Play typing sound effect if desired
                }
                
                actions.append(SKAction.sequence([waitAction, updateTextAction]))
            }
            
            // Add a space after each word except for the last wordf
            if index1 < words.count - 1 {
//                let spaceWidth = (" " as NSString).size(withAttributes: [.font: font ?? ""]).width
                let spaceAction = SKAction.run {
                    typedText += " " // Append a space to the typedText
                    currentLine += " " // Append a space to the current line
                    self.labelNode.text = typedText // Update the labelNode text with the typedText
                    //                    lineWidth += spaceWidth // Update the line width with the space width
                }
                actions.append(spaceAction)
                //                lineWidth += spaceWidth // Update the line width with the space width
            }
            
            lineWidth += wordWidth // Update the line width with the space width
        }
        // Step 5: Run the typing animation
        labelNode.run(SKAction.sequence(actions))
        
    }
    
    // função que recebe um texto e a cor do texto, ela faz exatamente a mesma coisa da outra função textAnimation, mas deixa o texto com a cor que o usuário querer
    func textAnimationComCor (texto:String, cor:UIColor) {
        self.labelNode.fontColor = cor
        self.textAnimation(text: texto)
    }
}
