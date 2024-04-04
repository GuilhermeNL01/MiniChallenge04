//
//  Weapons.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 22/03/24.
//

import Foundation

class Weapons{
    var name: String = ""
    var description: String = ""
    var imageName: String = ""
    
    init(_ weapon: Weapons) {
        
        self.description = weapon.rawValue
        self.buildNames(weapon)
        
    }
    
    private func buildNames(_ weapon: Weapons){
        switch weapon{
        case .knife:
            self.name = "knife"
        case .pills:
            self.name = "pills"
        case .switchBlade:
            self.name = "switch blade"
        }
    }
    
    private func buildImages(_ weapon: Weapons){
        switch weapon{
        case .knife:
            self.imageName = "knife"
        case .pills:
            self.imageName = "pills"
        case .switchBlade:
            self.imageName = "switch blade"
        }
    }
    
    enum Weapons: String {
        case knife = "A big knife, often used in butchery"
        case pills = "Looks like Ibuprofen, might cause an overdose"
        case switchBlade = "Has a pretty sharp knife, gotta be careful with this"
    }
}
