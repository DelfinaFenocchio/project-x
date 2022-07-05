//
//  MemoryGameHelperText.swift
//  proyecto-x
//
//  Created by Francisco Zapiola on 10/02/2022.
//

import SwiftUI

struct MemoryGameHelperText: View {
    @EnvironmentObject var state : MemoryGameState
    
    var body: some View {
        if(state.flipLoading){
            Text("Observa los animales durante \(state.visualizationTimeSelected) segundos")
        } else {
            if (state.gameModeSelected == GameModeMemoryGame.classicMultiPlayer) {
                Text("Turno de:")
                Text(state.playersData[state.playerOneTurn ? "First" : "Second"]!.name)
                    .font(.system(size: 30))
                
                Spacer()
                    
                //TODO: Add a more visual indicator for remaining time
                Text("Tiempo:")
                Text("\(state.turnTimeRemaining)")
                    .font(.system(size: 40))
            }
            else {
                LivesIndicator_MemoryGame(remainingLives: state.remainingLives)
            }
        }
    }
}
