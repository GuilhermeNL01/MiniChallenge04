//
//  PreviewSideView.swift
//  MiniChallenge04
//
//  Created by Victor Assis on 22/03/24.
//

import SwiftUI
import SpriteKit

struct PreviewSideView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack{
                SpriteView(scene: getScene(size: proxy.size))
                    .ignoresSafeArea()
            }
        }
    }
    
    func getScene(size:CGSize) -> SideScreens{
        let scene = SideScreens()
        scene.size = size
        return scene
    }
}

#Preview {
    PreviewSideView()
}
