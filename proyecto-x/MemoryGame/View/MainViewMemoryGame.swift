//
//  MainView.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 04/01/2022.
//

import SwiftUI

struct MemoryMainView: View {
    @EnvironmentObject var memoryGameState : MemoryGameState
    var body: some View {
        VStack{
            memoryGameState.loading
            ?
                Text("Cargando juego...")
            :
                Text("Jugando")
            
            VStack{
                
            
            LazyVGrid (columns: memoryGameState.columns, spacing: 5){
                ForEach(0..<memoryGameState.cardsAmountSelected) { index in
//                  TODO: Acá tiene que ir la leyenda que indique al usuario el orden en que tiene que levantar las cards. Tienen que ser imágenes con nombre "Artboard \(index)"
                    Text("\(index)")
                    Image("Artboard \(index + 1)")
                }
            }
//            for card in memoryGameState.board.cardsArrangement {
//                Image(card.imageId)
            }
        }
        .onAppear(perform: {
            memoryGameState.board.generateGame(cardsAmount: memoryGameState.cardsAmountSelected)
            memoryGameState.loading.toggle()
            print(memoryGameState.board.cardsArrangement)
        })
    }
}
