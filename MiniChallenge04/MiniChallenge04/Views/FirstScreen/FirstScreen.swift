//
//  FirstScreen.swift
//  MiniChallenge04
//
//  Created by Guilherme Nunes Lobo on 18/03/24.
//

import SwiftUI

struct FirstScreen: View {
    var body: some View {
        ZStack{
            
            BackgroundImageView()
            Black()
                .opacity(0.88)
            
            Text("PLACEHOLDER")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .opacity(0.8)
            
            VStack{
                
                Image("Logo")
                    .padding(.init(top: 70, leading: 70, bottom: 592, trailing: 497))
                
            }
            
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image("Start")
                    .padding(EdgeInsets.init(top: 498, leading: 70, bottom: 217, trailing: 839))
                
            })
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image("Credits")
                    .padding(EdgeInsets.init(top: 645, leading: 70, bottom: 70, trailing: 839))
                
            })
        }
        .navigationBarBackButtonHidden()
        
        
        
    }
}

#Preview {
    FirstScreen()
}
