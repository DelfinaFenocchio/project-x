//
//  MainMenu.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 22/11/2021.
//

import SwiftUI

struct TicTacToeMenu: View {
    
    @StateObject var mainViewState : TicTacToeState = TicTacToeState()
    var gameMode : GameMode = .notSelectedMode
    
    var body: some View {
        GeometryReader { screenGeometry in
            ZStack {
                BackgroundAsyncImage(screenGeometry: screenGeometry)
                
                VStack {
                            Spacer()
                            Text("Tic Tac Toe")
                            Spacer()
                            Text("Elegí el modo de juego")
                                .fontWeight(.bold)
                                .font(.system(.title))
                                .padding()
                                .customTextStyle()

                            NavigationLink(destination: MainView(gameMode: .singlePlayer).environmentObject(mainViewState)) {
                                Text("1 jugador")
                                    .customButtonStyle()
                            }

                            NavigationLink(destination: MainView(gameMode: .multiPlayer).environmentObject(mainViewState)) {
                                Text("2 jugadores")
                                    .customButtonStyle()
                            }
                            Spacer()
                        }
                }
            }
        }
    
}

