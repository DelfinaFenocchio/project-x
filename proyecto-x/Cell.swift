//
//  Cell.swift
//  proyecto-x
//
//  Created by Francisco Zapiola on 28/09/2021.
//

import SwiftUI

struct Cell: View {
    @EnvironmentObject var globalState : TicTacToeState
    @Binding var playability : CellState
    let index : Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 90, height: 90)
                .foregroundColor(playability == CellState.empty ? Color.green : playability == CellState.playerO ? Color.red : Color.blue)
                .onTapGesture(count: 1, perform: {
                    if(playability == CellState.empty && globalState.GameStateProperty == GameState.active)
                    {
                        onTapGestureHandler()
                    }
                })
                .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
            
            if(playability != CellState.empty) {
                if (playability == CellState.playerX) {
                    Image(systemName: "xmark").resizable().frame(width: 50, height: 50)
                } else {
                    Image(systemName: "circle").resizable().frame(width: 50, height: 50)
                }
            }
        }
    }
    
    public func onTapGestureHandler() {
        if(globalState.playerXTurn) {
            globalState.pressed[index] = CellState.playerX
        } else {
            globalState.pressed[index] = CellState.playerO
        }
        globalState.playerXTurn.toggle()
    }
}



