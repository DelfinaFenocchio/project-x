//
//  ViewModel.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 04/01/2022.
//

import SwiftUI


struct MemoryGameCard {
    var id : Int
    var image : String
    var flipped : Bool = true
}

struct BoardMemoryGame {
    //var pressed
    var playableCards : [MemoryGameCard] = []
    var cardsArrangement : [Int] = []
    
}

final class MemoryGameState : ObservableObject {
    @Published var board : BoardMemoryGame = BoardMemoryGame()
    @Published var gameMode : GameModeMemoryGame = .classicSinglePlayer
    
    
    
}
