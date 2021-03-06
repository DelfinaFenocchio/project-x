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
                ForEach(0..<state.cardsAmountSelected, id: \.self) { index in
                    let id = state.cardsArrangement[index]
                    let element = state.playableCards.filter{ $0.id == id }.first
                    VStack{
                        Image(element!.image)
                            .resizable()
                            .frame(width: state.cardsAmountSelected > 9 ? 25 : 35, height: state.cardsAmountSelected > 9 ? 25 : 35)
                    }
                }
            }
        }
    }
}
