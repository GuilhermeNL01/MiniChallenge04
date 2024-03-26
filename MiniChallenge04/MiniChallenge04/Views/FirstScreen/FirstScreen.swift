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
    
    var body: some View {
        NavigationStack(path: $vm.spriteKitPath){
            ZStack{
                
                BackgroundImageView()
                Black()
                    .opacity(0.88)
                
                Text("PLACEHOLDER")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .opacity(0.8)
                
                VStack{
                    HStack{
                        
                        Image("Logo")
                            .padding(70)
                        Spacer()
                    }
                    Spacer()
                }
                HStack{
                    
                    VStack{
                        Spacer()
                        Button{
                            vm.verifyCheckPoint()
                            vm.spriteKitPath.append(vm.firstScene)
                        } label: {
                            Image("Start")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .scaledToFit()
                                .frame(width: 285, height: 119)
                                .scaledToFit()
                                .padding(.bottom, 20)
                        }
                        
                        NavigationLink{
                            CreditsView()
                        } label: {
                            Image("Credits")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .scaledToFit()
                                .frame(width: 285, height: 119)
                                .scaledToFit()
                                .padding(.horizontal, 60)
                            
                        }
                        .padding(.bottom, 60)
                    }
                    Spacer()
                }
            }.navigationDestination(for: SKScene.self) { scene in
                SpriteView(scene: scene)
                    .ignoresSafeArea()
                    .navigationBarBackButtonHidden()
            }
        }
        
    }
}

#Preview {
    FirstScreen()
}
