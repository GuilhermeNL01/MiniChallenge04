//
//  ScreenReportViewModel.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 27/03/24.
//

import Foundation
import SpriteKit

class ScreenReportViewModel{
    
    var model = ScreenReportModel()
    weak var scene: ScreenReport?
    
    func checkNextScene(){
        if let scene{
            let masterNode = scene.masterNode
            var score = 0
            
            if masterNode.weaponPhoto.type.rawValue == model.crimeWeapon{
                score += 1
            }
            
            if masterNode.locationPhoto.type.rawValue == model.crimeLocation{
                score += 1
            }
            
            if masterNode.suspectPhoto.type.rawValue == model.murderer{
                score += 1
            }
            
            if score == 3{
                scene.path = []
            } else {
                scene.path.append(GameOverScene(path: scene.$path))
            }
        }
    }
}
