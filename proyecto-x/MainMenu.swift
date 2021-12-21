//
//  MainMenu.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 21/12/2021.
//

import SwiftUI

struct MainMenu: View {
    var body: some View {
        NavigationView{

                
                VStack{
                    Text("Project X")
                    Spacer()
                    Text("Elegí un juego")
                        .fontWeight(.bold)
                        .font(.system(.title))
                        .padding()
                        .customTextStyle()
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            NavigationLink(destination: TicTacToeMenu()) {
                                VStack{
                                    Image("tatetiimage")
                                        .resizable()
                                        .frame(width: 200, height: 200)
                                        .border(Color.black, width: 1)
                                    Text("TicTacToe")
                                        .customButtonStyle()
                                }
                            }
                            VStack{
                                Image("comingsoon")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                    .border(Color.black, width: 1)
                                Text("Game Name")
                                    .customButtonStyle()
                            }
                            VStack{
                                Image("comingsoon")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                    .border(Color.black, width: 1)
                                Text("Game Name")
                                    .customButtonStyle()
                            }
                            VStack{
                                Image("comingsoon")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                    .border(Color.black, width: 1)
                                Text("Game Name")
                                    .customButtonStyle()
                            }
                            VStack{
                                Image("comingsoon")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                    .border(Color.black, width: 1)
                                Text("ame Name")
                                    .customButtonStyle()
                            }
                        }
                        .padding()
                    }
                    Spacer()
                }
        }
    }
}
