//
//  Sidebar.swift
//  MiniChallenge04
//
//  Created by Enrique Carvalho on 26/03/24.
//

import Foundation
import SpriteKit

class SidebarNode: SKNode{
    var upperSidebar = UpperSidebar()
    var bottomSidebar = BottomSidebar()
    
    override init() {
        super.init()
        upperSidebar.position = CGPoint(x: 0, y: alturaTela * 0.218)
        addChild(upperSidebar)
        bottomSidebar.position = CGPoint(x: 0, y: -alturaTela * 0.146)
        addChild(bottomSidebar)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
