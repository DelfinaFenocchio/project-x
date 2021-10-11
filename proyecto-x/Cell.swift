//
//  Cell.swift
//  proyecto-x
//
//  Created by Francisco Zapiola on 28/09/2021.
//

import SwiftUI

struct Cell: View {
    @Binding var playability : CellState
    @Binding var playerXTurn : Bool
    @Binding var pressed : [CellState]
    let index : Int
    let GameStateProperty : GameState
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 90, height: 90)
                .foregroundColor(playability == CellState.empty ? Color.green : playability == CellState.playerO ? Color.red : Color.blue)
                .onTapGesture(count: 1, perform: {
                    if(playability == CellState.empty && GameStateProperty == GameState.active)
                    {
                        onTapGestureHandler()
                    }
            })
            
            if(playability != CellState.empty) {
                if playability == CellState.playerX {
                    Image(systemName: "xmark").resizable().frame(width: 50, height: 50)
                } else {
                    Image(systemName: "circle").resizable().frame(width: 50, height: 50)
                }
            }
        }
    }
    
    public func onTapGestureHandler() {
        if(playerXTurn) {
            pressed[index] = CellState.playerX
        } else {
            pressed[index] = CellState.playerO
        }
        playerXTurn.toggle()
    }
}



