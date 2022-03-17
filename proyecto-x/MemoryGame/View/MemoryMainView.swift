//
//  MainView.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 04/01/2022.
//

import SwiftUI

struct MemoryMainView: View {
    @EnvironmentObject var state : MemoryGameState
    
    var body: some View {
        GeometryReader { screenGeometry in
            ZStack {
                VStack{
                    Text("Jugando: \(state.gameModeSelected.rawValue)")

                    MemoryGameHelperText()
                    
                    Spacer()
                    if(!state.loading){
                        Spacer()
                        CorrectSequenceIndicator()
                        Spacer()
                        VStack {
                            ZStack{
                                LazyVGrid(columns: state.columns, spacing: 5) {
                                    ForEach(0..<state.cardsAmountSelected) { index in
                                        MemoryGameCell(index: index, screenGeometry: screenGeometry)
                                    }
                                }
                                .customCellContainerStyle(width: screenGeometry.size.width)
                            }
                        }
                        Spacer()
                    }
                    
                }
                if(state.showEndModal){
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

        }
    }
}
