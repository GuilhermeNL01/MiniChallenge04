//
//  FirstScreen.swift
//  MiniChallenge04
//
//  Created by Guilherme Nunes Lobo on 18/03/24.
//

import SwiftUI
import _SpriteKit_SwiftUI

struct FirstScreen: View {
    
    var firstScene = SKScene()
    
    var checkPoint: [String: Int] {
        get {
            UserDefaults.standard.value(forKey: "checkPoint") as! [String : Int]
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "checkPoint")
        }
    }
    
    @State var spriteKitPath: [SKScene] = []
    
    var body: some View {
        NavigationStack(path: $spriteKitPath){
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
                            verifyCheckPoint()
                            spriteKitPath.append(firstScene)
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
    
    mutating func verifyCheckPoint(){
        var lastPoint: (String, Int)
        
        for checkPoints in checkPoint{
            lastPoint = checkPoints
        }
        
        switch lastPoint{
        case ("Hotel", 0):
            firstScene = ContextGameScene(path: $spriteKitPath, size: CGSize(width: larguraTela, height: alturaTela))
            break
        case ("Hotel", 1):
            <#code#>
            break
        case ("Hotel", _):
            <#code#>
            break
        case (_, _):
            <#code#>
            break
            
        default:
            firstScene = VideoCutsceneScene(path: $spriteKitPath, size: CGSize(width: larguraTela, height: alturaTela))
            break
        }
        firstScene.scaleMode = .fill
    }
    
}

#Preview {
    FirstScreen()
}
