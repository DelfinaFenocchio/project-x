//
//  MainView.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 04/01/2022.
//

import SwiftUI

struct MemoryMainView: View {
    @EnvironmentObject var state : MemoryGameState
    @Environment(\.scenePhase) var scenePhase
    
//    let columns = ColumnsByGameMode[state.gameModeSelected]! ?? ColumnsByGameMode[.sequential]!
    
    
    
    var body: some View {
        GeometryReader { screenGeometry in
            ZStack {
                VStack{
                    Text("Jugando: \(state.gameModeSelected.rawValue)")
                    Text("Score Actual: \(state.totalScore)")
                    Text("High Score: \(state.highScore)")

                    Spacer()

                    MemoryGameHelperText()
                    if (state.gameModeSelected == GameModeMemoryGame.classicMultiPlayer) {
                        Text("Turno de: \(state.playerOneTurn ? "jugador uno" : "jugador dos")")
                    }
                    else {
                        LivesIndicator_MemoryGame(remainingLives: state.remainingLives)
                    }
                    
                        
                    Spacer()
                    if(!state.loading){
                        Spacer()
                        if(state.gameModeSelected == .sequential){
                            CorrectSequenceIndicator()
                            Spacer()
                        }
                        VStack {
                            ZStack{
                                LazyVGrid(columns: ColumnsByGameMode[state.gameModeSelected]!, spacing: 5) {
                                    ForEach(0..<state.cardsAmountSelected, id: \.self) { index in
                                        MemoryGameCell(index: index, screenGeometry: screenGeometry)
                                    }
                                }
                                .customCellContainerStyle(width: screenGeometry.size.width)
                            }
                        }
                        Spacer()
                    }
                    
                }
                if(state.gameStatus == .victory || state.gameStatus == .defeated || state.gameStatus == .finished){
                    MemoryGameResultModal(screenGeometry: screenGeometry)
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                }
            }
            .onAppear(perform: {
                state.generateGame(cardsAmount: state.cardsAmountSelected)
                state.startGame()
                state.loading.toggle()
            })
            .onDisappear(perform: {
                state.onGoBack()
            })
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .background {
                    state.evalutateHighScore()
                }
            }

        }
    }
}
