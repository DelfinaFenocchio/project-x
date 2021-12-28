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
    let screenGeometry : GeometryProxy
    let possibleWinnerLines : [[Int]]
    let gameMode : GameMode
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .customCellStyle(width: screenGeometry.size.width / 3.5)
                .onTapGesture(count: 1, perform: {
                    if(playability == CellState.empty && globalState.GameStateProperty == GameState.active)
                    {
                        onTapGestureHandler()
                    }
                })
            
            
            if(playability != CellState.empty) {
                if (playability == CellState.playerX) {
                    Image(systemName: "xmark").resizable().frame(width: 50, height: 50).foregroundColor(.white)
                } else {
                    Image(systemName: "circle").resizable().frame(width: 50, height: 50).foregroundColor(.white)
                }
            }
        }
        .disabled(globalState.isGameboardDisabled)
    }
    
    public func onTapGestureHandler() {
        if(gameMode == .singlePlayer) {
            globalState.isGameboardDisabled = true
        }
        
        if(globalState.playerXTurn) {
            globalState.board.pressed[index] = CellState.playerX
        } else {
            globalState.board.pressed[index] = CellState.playerO
        }
        
        globalState.playerXTurn.toggle()
        
        _ = globalState.evaluatePlay()
        
        if(!globalState.playerXTurn && gameMode == .singlePlayer && globalState.GameStateProperty == GameState.active){
            globalState.automaticPlay()
            globalState.playerXTurn.toggle()
        }
    }
}



