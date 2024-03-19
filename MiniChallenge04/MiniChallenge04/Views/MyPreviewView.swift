//
//  MyPreviewView.swift
//  MiniChallenge04
//
//  Created by Victor Assis on 19/03/24.
//

import SwiftUI
import SpriteKit

struct MyPreviewView: View {
//    @State private var cena = Map()
    var body: some View {
        GeometryReader{ proxy in
            SpriteView(scene: Map(size: proxy.size)).ignoresSafeArea()
        }
    }
}

#Preview {
    MyPreviewView()
}
