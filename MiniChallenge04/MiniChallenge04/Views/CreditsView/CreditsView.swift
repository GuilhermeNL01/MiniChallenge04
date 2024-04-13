////
////  CreditsView.swift
////  MiniChallenge04
////
////  Created by Victor Assis on 18/03/24.
////
//
//import SwiftUI
//
//struct CreditsView: View {
//    var body: some View {
//        NavigationStack{
//            ZStack{
//                BackgroundImageView()
//                Black()
//                    .opacity(0.88)
//                
//
//                HStack{
//                    VStack{
//                        NavigationLink{
//                            FirstScreen()
//                        } label: {
//                            Image("Return")
//
//                                .scaledToFit()
//                                .padding(.top,60)
//                                .padding(.leading,40)
//                        }
//                        Spacer()
//                    }
//                    Spacer()
//                }
//                VStack{
//                    
//                    Image("WhiteRectangle")
//                        .padding(.top)
//                        .padding(.bottom, 40)
//                    
//                    HStack{
//                        
//                        VStack{
//                            
//                            Image("WhiteRectangle")
//                                .padding(.leading,70)
//                                .padding(.bottom)
//                                
//                            Image("Rectangle")
//                                .padding(.leading,70)
//                                .padding(.bottom)
//                            Image("Rectangle")
//                                .padding(.leading,70)
//                                .padding(.bottom)
//                            Image("Rectangle")
//                                .padding(.leading,70)
//                            Image("Rectangle")
//                                .padding(.leading,70)
//                                .padding(.top)
//                            
//                        }
//                        Spacer()
//                        VStack{
//                            Image("WhiteRectangle")
//                                .padding(.trailing,70)
//                                .padding(.bottom)
//                            Image("Rectangle")
//                                .padding(.trailing,70)
//                                .padding(.bottom, 40)
//                                
//                               
//                            Image("WhiteRectangle")
//                                .padding(.trailing,70)
//                                .padding(.bottom)
//                            Image("Rectangle")
//                                .padding(.trailing,70)
//                                
//                            Image("Rectangle")
//                                .padding(.trailing,70)
//                                .padding(.top)
//                            
//                        }
//                    }
//                    
//                    .navigationBarBackButtonHidden()
//                }
//            }
//        }
//    }
//}
//#Preview {
//    CreditsView()
//}
