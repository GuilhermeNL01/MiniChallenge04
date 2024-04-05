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
            return UserDefaults.standard.string(forKey: "murderer") ?? "butcher"
        }
    }
    var crimeWeapon: String {
        get{
            return UserDefaults.standard.string(forKey: "crimeWeapon") ?? "knife"
        }
    }
    var crimeLocation: String {
        get{
            return UserDefaults.standard.string(forKey: "crimeLocation") ?? "hotel"
        }
    }
    
    var nameReport: NPC?
    var weaponDesc: Weapons?
    var localDesc: Place?
    var imagesReportSuspect: [String] = []
    var imagesReportWeapon: [String] = []
    var imagesReportLocal: [String] = []

}
