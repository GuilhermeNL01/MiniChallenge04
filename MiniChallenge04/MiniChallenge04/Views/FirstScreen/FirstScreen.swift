//
//  FirstScreen.swift
//  MiniChallenge04
//
//  Created by Guilherme Nunes Lobo on 18/03/24.
//

import SwiftUI
import _SpriteKit_SwiftUI

struct FirstScreen: View {
    
    @StateObject var vm = FirstScreenViewModel()
    @State var path: [SKScene] = []
    
    var body: some View {
        NavigationStack(path: $path){
            ZStack{
                
                BackgroundImageView()
                Black()
                    .opacity(0.5)
                
                
                VStack{
                    HStack{
                        Image("Logo")
                            .frame(width: 827,height: 518)
                            .padding(20)
                        Spacer()
                    }
                    Spacer()
                }
                HStack{
                    
                    VStack{
                        Spacer()
                        
                        Button{
                            withAnimation{
                                path.append(ButcherDialogueScene(path: $path))
                            }
                        } label: {
                            Image("Start")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .scaledToFit()
                                .frame(width: 285, height: 119)
                                .scaledToFit()
                                .padding(.leading, 60)
                        }
                        
                        
                        .padding(.bottom, 60)
                    }
                    Spacer()
                }.navigationDestination(for: SKScene.self) { scene in
                    SpriteView(scene: scene)
                        .transition(.opacity)
                        .ignoresSafeArea()
                        .navigationBarBackButtonHidden()
                }
            }
        }
        
    }
}

#Preview {
    FirstScreen()
}
