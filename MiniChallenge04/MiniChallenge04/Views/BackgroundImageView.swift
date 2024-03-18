//
//  BackgroundImageView.swift
//  MiniChallenge04
//
//  Created by Guilherme Nunes Lobo on 18/03/24.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
        Image("Background")
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .edgesIgnoringSafeArea(.all)
        
    }
}

#Preview {
    BackgroundImageView()
}
