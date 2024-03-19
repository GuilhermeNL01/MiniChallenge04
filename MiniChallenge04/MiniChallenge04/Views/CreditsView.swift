//
//  CreditsView.swift
//  MiniChallenge04
//
//  Created by Victor Assis on 18/03/24.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                BackgroundImageView()
                Black()
                    .opacity(0.88)
                
                /*Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image("Return")
                        .padding(EdgeInsets.init(top: 40, leading: 40, bottom: 723, trailing: 969))
                })*/
                HStack{
                    VStack{
                        NavigationLink{
                            FirstScreen()
                        } label: {
                            Image("Return")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .scaledToFit()
                                .frame(width: 285, height: 119)
                                .scaledToFit()
                                .padding(70)

                            //                        .padding(EdgeInsets.init(top: 40, leading: 40, bottom: 723, trailing: 969))
                        }
                        Spacer()
                    }
                    Spacer()
                }
                Image("WhiteRectangle")
                    .padding(EdgeInsets(.init(top: 232, leading: 70, bottom: 539, trailing: 714)))
                Image("Rectangle")
                    .padding(EdgeInsets(.init(top: 335, leading: 70, bottom: 416, trailing: 714)))
                Image("Rectangle")
                    .padding(EdgeInsets(.init(top: 451.33, leading: 70, bottom: 299.67, trailing: 714)))
                Image("Rectangle")
                    .padding(EdgeInsets(.init(top: 567.67, leading: 70, bottom: 183.33, trailing: 714)))
                Image("Rectangle")
                    .padding(EdgeInsets(.init(top: 684, leading: 70, bottom: 67, trailing: 714)))
                Image("WhiteRectangle")
                    .padding(EdgeInsets(.init(top: 232, leading: 714, bottom: 539, trailing: 70)))
                Image("Rectangle")
                    .padding(EdgeInsets(.init(top: 335, leading: 714, bottom: 416, trailing: 70)))
                Image("WhiteRectangle")
                    .padding(EdgeInsets(.init(top: 478, leading: 714, bottom: 293, trailing: 70)))
                Image("Rectangle")
                    .padding(EdgeInsets(.init(top: 581, leading: 714, bottom: 170, trailing: 70)))
                Image("Rectangle")
                    .padding(EdgeInsets(.init(top: 684, leading: 714, bottom: 67, trailing: 70)))
                Image("LightRectangle")
                    .padding(EdgeInsets(top: 70, leading: 376, bottom: 674, trailing: 377))
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CreditsView()
}
