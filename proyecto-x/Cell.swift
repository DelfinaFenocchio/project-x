//
//  Cell.swift
//  proyecto-x
//
//  Created by Francisco Zapiola on 28/09/2021.
//

import SwiftUI

struct Cell: View {
    @State private var playability : CellState = CellState.empty
    @Binding var playerXTurn : Bool
    @Binding var pressed : [CellState]
    var index : Int
    let GameStateProperty : GameState
    
    var body: some View {
        Rectangle()
            .frame(width: 90, height: 90)
            .foregroundColor(playability == CellState.empty ? Color.green : playability == CellState.playerO ? Color.red : Color.blue)
            .onTapGesture(count: 1, perform: {
                if(self.playability == CellState.empty && GameStateProperty == GameState.active)
                {
                    setPlayability(newPlayabilityValue: self.playerXTurn ? CellState.playerX : CellState.playerO)
                    pressed[index] = self.playerXTurn ? CellState.playerX : CellState.playerO
                    self.toggleTurn()
                }
            })
    }
    
    public func toggleTurn() -> Void {
        self.playerXTurn = !self.playerXTurn
    }
    
    public func setPlayability(newPlayabilityValue: CellState) -> Void {
        self.playability = newPlayabilityValue
    }
}



