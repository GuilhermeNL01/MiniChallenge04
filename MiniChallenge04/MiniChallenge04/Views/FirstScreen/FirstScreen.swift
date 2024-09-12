//
//  FirstScreen.swift
//  MiniChallenge04
//
//  Created by Guilherme Nunes Lobo on 18/03/24.
//

import SwiftUI
import _SpriteKit_SwiftUI

struct FirstScreen: View {
    
    @ObservedObject var vm: FirstScreenViewModel
    @State var isStartingNewGame = false
    
    
    var body: some View {
        NavigationStack(path: vm.$path){
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
                                if vm.checkpoint != nil{
                                    isStartingNewGame = true
                                } else {
                                    vm.path.append(vm.firstScreen)
                                }
                            }
                        } label: {
                            Image("Start")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .scaledToFit()
                                .frame(width: 285, height: 119)
                                .scaledToFit()
                                .padding(.leading, 60)
                        }.padding(.bottom)
                        
                            Button{
                                withAnimation{
                                    vm.path.append(vm.firstScreen)
                                }
                            } label: {
                                Image(vm.checkpoint != nil ? .continue : .continueInactive)
                                    .resizable()
                                    .aspectRatio( contentMode: .fit)
                                    .scaledToFit()
                                    .frame(width: 285, height: 119)
                                    .scaledToFit()
                                    .padding(.leading, 60)
                            }.disabled(vm.checkpoint == nil)
                        }.padding(.bottom, 60)
                    Spacer()
                }.navigationDestination(for: SKScene.self) { scene in
                    SpriteView(scene: scene)
                        .transition(.opacity)
                        .ignoresSafeArea()
                        .navigationBarBackButtonHidden()
                }
                .alert("Start a New Game", isPresented: $isStartingNewGame) {
                    Button("Return", role: .cancel){}
                    Button("Start a new game"){
                        UserDefaults.resetDefaults()
                        vm.firstScreen = ContextGameScene(path: vm.$path)
                        vm.path.append(vm.firstScreen)
                    }
                } message: {
                    Text("Are you sure you want to start a new game?\n Your previous save will be overwritten.")
                }
            }
        }
    }
}
