//
//  MemoryGameMenu.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 04/01/2022.
//

import SwiftUI



struct MemoryGameMenu: View {
    @StateObject var state : MemoryGameState = MemoryGameState()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack {
                Group{
                    Text("Memory Game")
                    
                    Spacer()
                    
                    Text("Elegí el modo de juego")
                        .fontWeight(.bold)
                        .font(.system(.title))
                        .padding()
                        .customTextStyle()
                    
                    Picker("Modo de Juego", selection: $state.gameModeSelected) {
                        Text("\(GameModeMemoryGame.classicMultiPlayer.rawValue)").tag(GameModeMemoryGame.classicMultiPlayer)
                        Text("\(GameModeMemoryGame.classicSinglePlayer.rawValue)").tag(GameModeMemoryGame.classicSinglePlayer)
                        Text("\(GameModeMemoryGame.sequential.rawValue)").tag(GameModeMemoryGame.sequential)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    Spacer()
                    
                    Text("Cantidad de cards")
                        .fontWeight(.bold)
                        .font(.system(.title))
                        .padding()
                        .customTextStyle()
                    
                    Picker("Cards amount", selection: $state.cardsAmountSelected) {
                        ForEach((1...CardAmountOptions.count), id: \.self) {index in
                            let cardAmount = CardAmountOptions[state.gameModeSelected]![index]!
                            Text("\(cardAmount) cards").tag(cardAmount)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    Spacer()
                }
                Group{
                    Text("Tiempo de previsualizacion")
                        .fontWeight(.bold)
                        .font(.system(.title))
                        .padding()
                        .customTextStyle()
                    
                    Picker("Tiempo de previsualizacion", selection: $state.visualizationTimeSelected) {
                        Text("3 second").tag(3)
                        Text("5 seconds").tag(5)
                        Text("8 seconds").tag(8)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    Spacer()
                    Text("Cantidad de vidas")
                        .fontWeight(.bold)
                        .font(.system(.title))
                        .padding()
                        .customTextStyle()
                    Picker("Cantidad de vidas", selection: $state.livesAmountSelected) {
                        Text("2").tag(2)
                        Text("4").tag(4)
                        Text("6").tag(6)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    NavigationLink(destination: MemoryMainView().environmentObject(state)) {
                        Text("Comenzar juego")
                            .customButtonStyle()
                    }.disabled(state.cardsAmountSelected == 0)
                }
            }
            
        }.onChange(of: state.gameModeSelected) { newValue in
            let cardAmount = CardAmountOptions[newValue]![1]!
            state.cardsAmountSelected = cardAmount
        }
    }
}
