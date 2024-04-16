//
//  UserDefaults.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 11/04/24.
//

import Foundation

extension UserDefaults {
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
