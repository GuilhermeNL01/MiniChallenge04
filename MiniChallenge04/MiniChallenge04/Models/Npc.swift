//
//  Npc.swift
//  MiniChallenge04
//
//  Created by Victor Assis on 21/03/24.
//

import Foundation

struct NPC {
    var name: String
    var images: [String]
    var lines: [String] 

    init(name: String, images: [String], lines: [String]) {
        self.name = name
        self.images = images
        self.lines = lines
    }
}
