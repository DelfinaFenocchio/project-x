//
//  HelperViews.swift
//  proyecto-x
//
//  Created by Lisbaldy Ojeda on 05/10/2021.
//

import SwiftUI

struct GameOverView: View {
    let GameStateProperty : GameState
    
    var body: some View {
        switch (GameStateProperty)
        {
        case .draw:
            Text("The game is tie")
        case .playerOWin:
            Text("Player O Win!")
        case .playerXWin:
            Text("Player X Win!")
        default:
            EmptyView()
        }
    }
}

struct TurnView: View {
    let playerXTurn : Bool
    let GameStateProperty : GameState
    
    var body: some View {
        if GameStateProperty == GameState.active
        {
            Text("Turno de: \(playerXTurn ? "Player X" : "Player O")")
                .padding()
        }
        else
        {
            EmptyView()
        }
    }
}
