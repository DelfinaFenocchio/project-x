//
//  MemoryGameMenu.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 04/01/2022.
//

import SwiftUI



struct MemoryGameMenu: View {
    @StateObject var memoryGameState : MemoryGameState = MemoryGameState()
    
    var body: some View {
        VStack {
            Group{
                Text("Memory Game")
                Spacer()
                Text("Cantidad de cards")
                    .fontWeight(.bold)
                    .font(.system(.title))
                    .padding()
                    .customTextStyle()
                
                Picker("Please choose a color", selection: $memoryGameState.cardsAmountSelected) {
                    Text("6 cards").tag(6)
                    Text("8 cards").tag(8)
                    Text("10 cards").tag(10)
                    Text("12 cards").tag(12)
                }.pickerStyle(SegmentedPickerStyle())
                
                Spacer()
                Text("Elegí el modo de juego")
                    .fontWeight(.bold)
                    .font(.system(.title))
                    .padding()
                    .customTextStyle()
                
                Picker("Modo de Juego", selection: $memoryGameState.gameModeSelected) {
                    Text("\(GameModeMemoryGame.classicMultiPlayer.rawValue)").tag(GameModeMemoryGame.classicMultiPlayer)
                    Text("\(GameModeMemoryGame.classicSinglePlayer.rawValue)").tag(GameModeMemoryGame.classicSinglePlayer)
                    Text("\(GameModeMemoryGame.sequential.rawValue)").tag(GameModeMemoryGame.sequential)
                }
                
                Spacer()
            }
            Group{
                Text("Tiempo de previsualizacion")
                    .fontWeight(.bold)
                    .font(.system(.title))
                    .padding()
                    .customTextStyle()
                
                Picker("Tiempo de previsualizacion", selection: $memoryGameState.visualizationTimeSelected) {
                    Text("1 second").tag(1)
                    Text("2 seconds").tag(2)
                    Text("3 seconds").tag(3)
                }
                
                Spacer()
                NavigationLink(destination: MemoryMainView().environmentObject(memoryGameState)) {
                    Text("Comenzar juego")
                        .customButtonStyle()
                }
            }
        }
    }
}
