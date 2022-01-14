//
//  CorrectSequenceIndicator.swift
//  proyecto-x
//
//  Created by Francisco Zapiola on 13/01/2022.
//

import SwiftUI

struct CorrectSequenceIndicator: View {
    @EnvironmentObject var state : MemoryGameState

    var body: some View {
        VStack{
            Text("Da vuelta los animalitos en este orden:")
            HStack {
                ForEach(0..<state.cardsAmountSelected) { index in
                    let id = state.board.cardsArrangement[index]
                    let element = state.board.playableCards.filter{ $0.id == id }.first
                    VStack{
                        Text("\(index + 1)")
                        Image(element!.image)
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                }
            }
        }
    }
}
