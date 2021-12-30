//
//  ContentView.swift
//  Test03
//
//  Created by Rodolfo.Iribarren on 14/09/2021.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var mainViewState : TicTacToeState

    let gameMode : GameMode
    
    var body: some View {
        GeometryReader { screenGeometry in
            ZStack {
                BackgroundAsyncImage(screenGeometry: screenGeometry)
                
                VStack {
                    //BEComunication()
                    
                    VStack {
                        Spacer()
                        
                        Text("Tic Tac Toe")
                            .fontWeight(.bold)
                            .font(.system(.title))
                            .padding()
                            .customTextStyle()
                        
                        Spacer()
                        
                        GameOverView(GameStateProperty : mainViewState.GameStateProperty)
                        
                        if mainViewState.GameStateProperty != GameState.active
                        {
                            Spacer()
                            
                            Button("Reiniciar el juego") {
                                mainViewState.resetGame()
                            }
                            .customButtonStyle()
                        }
                        
                        TurnView(playerXTurn : mainViewState.playerXTurn, GameStateProperty: mainViewState.GameStateProperty)
                        
                        Spacer()
                        
                    }
                    Spacer()
                    
                    ZStack {
                        LazyVGrid(columns: mainViewState.columns, spacing: 5) {
                            ForEach(0..<9) {index in
                                
                                Cell(playability : $mainViewState.board.pressed[index], index: index, screenGeometry: screenGeometry, possibleWinnerLines: mainViewState.possibleWinnerLines, gameMode: gameMode)
                                    .overlay(
                                        GeometryReader { geometry in
                                            Color.clear
                                                .onAppear{
                                                    //TODO: Save prettier coordinates (currently the coordinates used are the middle Cell's coordinates)
                                                    let frame = geometry.frame(in: .named("board"))
                                                    let point = CGPoint(x: frame.midX, y: frame.midY)
                                                    mainViewState.board.setCoords(index: index, point: point)
                                                }
                                        }
                                    )
                            }
                        }
                        .customCellContainerStyle(width: screenGeometry.size.width)
                        .coordinateSpace(name: "board")
                        
                        if mainViewState.GameStateProperty == GameState.playerXWin || mainViewState.GameStateProperty == GameState.playerOWin{
                            VictoryAnimatedLine()
                        }
                    }
                }
            }
        }
        .onAppear {
            mainViewState.gameMode = gameMode
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
