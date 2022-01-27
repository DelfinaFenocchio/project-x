//
//  Cell.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 20/01/2022.
//

import SwiftUI

struct MemoryGameCell: View {
    @EnvironmentObject var state : MemoryGameState
    let index : Int
    let screenGeometry : GeometryProxy
    
    var body: some View {
        ZStack {

            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .customCellFlippedStyleMG(width: screenGeometry.size.width / (state.cardsAmountSelected > 9 ? 4.5 : 3.5))
            
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .customCellStyleMG(width: screenGeometry.size.width / (state.cardsAmountSelected > 9 ? 4.5 : 3.5))
                .opacity(state.board.cardFlipped[index] ? 0 : 1)
            
            let element = state.board.playableCards[index]
            Image(element.image)
                .resizable()
                .frame(width: 50, height: 50)
                .opacity(state.board.cardFlipped[index] ? 1 : 0)
        }
        .rotation3DEffect(
            .init(degrees: state.board.cardFlipped[index] ? 180 : 0),
            axis: (x: 0.0, y: 1.0, z: 0.0), anchor: .center, anchorZ: 0.0, perspective: 1.0)
        .onTapGesture(perform: {
            withAnimation(Animation.easeIn(duration: 0.3)){
                state.board.cardFlipped[index] = true
            }
        })
    }
}
