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
        VStack{
            Text("Jugando: \(state.gameModeSelected.rawValue)")
            
            if(!state.loading){
                CorrectSequenceIndicator()
                VStack {
                    Text("Elementos:")
                    Text("(TODO: hay que convertir esto en un tablero con cards dadas vuelta)")
                    HStack{
                        ForEach(0..<state.cardsAmountSelected) { index in
                            let element = state.board.playableCards[index]
                            Image(element.image)
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }
                }.padding(20)
            }
        }
        .onAppear(perform: {
            state.board.generateGame(cardsAmount: state.cardsAmountSelected)
            state.loading.toggle()
        })
        .onDisappear(perform: {
            state.reset()
        })
    }
}
