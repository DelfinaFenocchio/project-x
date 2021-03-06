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
            Text("The game is Tie!").customTextStyle()
        case .playerOWin:
            Text("Player \(Image(systemName: "circle")) Win!").customTextStyle()
        case .playerXWin:
            Text("Player \(Image(systemName: "xmark")) Win!").customTextStyle()
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
            Text("Turno de: \(playerXTurn ? Image(systemName: "xmark") : Image(systemName: "circle"))")
                .padding()
                .customTextStyle()
        }
        else
        {
            EmptyView()
        }
    }
}
