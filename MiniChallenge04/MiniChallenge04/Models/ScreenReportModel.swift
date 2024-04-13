//
//  ScreenReportModel.swift
//  MiniChallenge04
//
//  Created by João Ângelo on 27/03/24.
//

import Foundation

struct ScreenReportModel{
    
    var murderer: String{
        get{
            return UserDefaults.standard.string(forKey: "murderer") ?? "helena"
        }
    }
    var crimeWeapon: String {
        get{
            return UserDefaults.standard.string(forKey: "crimeWeapon") ?? "pocketKnife"
        }
    }
    var crimeLocation: String {
        get{
            return UserDefaults.standard.string(forKey: "crimeLocation") ?? "pier"
        }
    }
}
