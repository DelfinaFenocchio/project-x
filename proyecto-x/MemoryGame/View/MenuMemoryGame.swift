//
//  MemoryGameMenu.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 04/01/2022.
//

import SwiftUI



struct MemoryGameMenu: View {
    //    var colors = ["Red", "Green", "Blue", "Tartan"]
    @State private var cardsAmountSelected : Int = 1
    @State private var gameModeSelected : Int = 1
    @State private var visualizationTimeSelected : Int = 1
    
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
                
                Picker("Please choose a color", selection: $cardsAmountSelected) {
                    Text("6 cards").tag(1)
                    Text("8 cards").tag(2)
                    Text("10 cards").tag(3)
                    Text("12 cards").tag(4)
                }
                
                Spacer()
                Text("Elegí el modo de juego")
                    .fontWeight(.bold)
                    .font(.system(.title))
                    .padding()
                    .customTextStyle()
                
                Picker("Modo de Juego", selection: $gameModeSelected) {
                    Text("\(GameModeMemoryGame.classicMultiPlayer.rawValue)").tag(1)
                    Text("\(GameModeMemoryGame.classicSinglePlayer.rawValue)").tag(2)
                    Text("\(GameModeMemoryGame.sequential.rawValue)").tag(3)
                }
                
                Spacer()
            }
            Group{
                Text("Tiempo de previsualizacion")
                    .fontWeight(.bold)
                    .font(.system(.title))
                    .padding()
                    .customTextStyle()
                
                Picker("Tiempo de previsualizacion", selection: $visualizationTimeSelected) {
                    Text("1 second").tag(1)
                    Text("2 seconds").tag(2)
                    Text("3 seconds").tag(3)
                }
                
                Spacer()
                NavigationLink(destination: MemoryMainView()) {
                    Text("Comenzar juego")
                        .customButtonStyle()
                }
            }
        }
    }
}
