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
        
            let element = state.playableCards[index]

            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .customCellStyleMG(width: screenGeometry.size.width / (state.cardsAmountSelected > 9 ? 4.5 : 3.5))
            
            if(state.flipLoading || element.flipped){
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .customCellFlippedStyleMG(width: screenGeometry.size.width / (state.cardsAmountSelected > 9 ? 4.5 : 3.5))
                    .opacity(element.flipped ? 1 : 0)
                
                Image(element.image)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .opacity(element.flipped ? 1 : 0)
            }
        
        }
        .rotation3DEffect(
            .init(degrees: state.playableCards[index].flipped ? 180 : 0),
            axis: (x: 0.0, y: 1.0, z: 0.0), anchor: .center, anchorZ: 0.0, perspective: 1.0)
        .onTapGesture(perform: {
            let disabled = state.disabled || state.playableCards[index].flipped || state.remainingLives == 0
            guard disabled  else {
                withAnimation(Animation.easeIn(duration: 0.3)){
                    state.flipCard(index: index)
                }
                state.evaluateFlip()
                return
            }
        })
    }
}
