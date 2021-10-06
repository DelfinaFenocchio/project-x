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
        case .redWin:
            Text("Red Win!")
        case .blueWin:
            Text("Blue Win!")
        default:
            EmptyView()
        }
    }
}

struct TurnView: View {
    let playerBlueTurn : Bool
    let GameStateProperty : GameState
    
    var body: some View {
        if GameStateProperty == GameState.active
        {
            Text("Turno de: \(playerBlueTurn ? "Azul" : "Rojo")")
                .padding()
        }
        else
        {
            EmptyView()
        }
    }
}
