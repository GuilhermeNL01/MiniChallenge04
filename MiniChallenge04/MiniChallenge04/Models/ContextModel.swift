//
//  FileWhatever.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 18/03/24.
//

import Foundation

struct ContextModel{
    var murderer: String{
        get{
            return UserDefaults.standard.string(forKey: "murderer") ?? "butcher"
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: "murderer")
        }
    }
    var crimeWeapon: String {
        get{
            return UserDefaults.standard.string(forKey: "crimeWeapon") ?? "knife"
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: "crimeWeapon")
        }
    }
    var crimeLocation: String {
        get{
            return UserDefaults.standard.string(forKey: "crimeLocation") ?? "hotelBar"
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: "crimeLocation")
        }
    }
    
    init(){
        self.murderer = "helena"
        self.crimeWeapon = "pocketKnife"
        self.crimeLocation = "pier"
    }
}
