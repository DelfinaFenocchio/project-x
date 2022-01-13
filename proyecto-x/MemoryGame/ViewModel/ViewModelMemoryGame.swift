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
    
    //TODO: Contemplate other game modes. Currently only "sequential"
    mutating func generateGame (cardsAmount : Int) -> Void {
        let randomImageIds = getRandomImageIds()

        var index : Int = 0
        while index <= cardsAmount{
            
            cardsArrangement.append(index)
            
            playableCards.append(MemoryGameCard(id: index, image: randomImageIds[index]))
            
            
            
            index += 1
        }
        cardsArrangement.shuffle()
        
        
    }
    
    func getRandomImageIds () -> [String] {
        var imageIds : [String] = []
        for i in (0...35) {
            imageIds.append("Artboard \(i)")
        }
        return imageIds.shuffled()
    }
}

final class MemoryGameState : ObservableObject {
    @Published var board : BoardMemoryGame = BoardMemoryGame()
    @Published var loading : Bool = true
    
    @Published var gameModeSelected : GameModeMemoryGame = .classicSinglePlayer
    @Published var cardsAmountSelected : Int = 6
    @Published var visualizationTimeSelected : Int = 1
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
}
