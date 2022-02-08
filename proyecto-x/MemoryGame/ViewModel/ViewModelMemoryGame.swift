//
//  ViewModel.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 04/01/2022.
//

import SwiftUI

func getRandomImageIds () -> [String] {
    var imageIds : [String] = []
    for i in (0...35) {
        imageIds.append("Artboard \(i)")
    }
    return imageIds.shuffled()
}

struct MemoryGameCard {
    var id : Int
    var image : String
    var flipped : Bool = true
}

final class BoardMemoryGame : ObservableObject {
    var playableCards : [MemoryGameCard] = []
    var cardsArrangement : [Int] = []
   // @Published var cardFlipped : [Bool] = []
    @Published var cardFlipped2 : [Bool] = []
    @Published var flipLoading : Bool = true    
    
    //TODO: Contemplate other game modes. Currently only "sequential"
    func generateGame (cardsAmount : Int, visualizationTime : Int) -> Void {
        let randomImageIds = getRandomImageIds()
        
        //cardFlipped = Array(repeating: false, count: cardsAmount)
        
        var index : Int = 0
        while index < cardsAmount{
            cardsArrangement.append(index)

            playableCards.append(MemoryGameCard(id: index, image: randomImageIds[index]))

            index += 1
        }
        cardsArrangement.shuffle()
        
        
//        cardFlipped2 = cardFlipped.map { card in
//           var mutableCard = card
//            mutableCard.toggle()
//            return mutableCard
//        }

  //      cardFlipped = cardFlipped2
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(visualizationTime)) { [self] in
//            cardFlipped2 = cardFlipped.map { card in
//               var mutableCard = card
//                mutableCard.toggle()
//                return mutableCard
//            }

            
//            cardFlipped = cardFlipped2
            
           playableCards = playableCards.map { card in
                var mutableCard = card
                mutableCard.flipped.toggle()
                return mutableCard
            }
            
            flipLoading.toggle()
            
            print("elements after 3 secons: \(playableCards)")
        }

                                                                                 
        print("CARD ARRANGEMENT: \(cardsArrangement)")
        print("BOARD ELEMENTS: \(playableCards)")
    }
    
    func reset ()  -> Void {
        playableCards = []
        cardsArrangement = []
        flipLoading = true
    }
}

final class MemoryGameState : ObservableObject {
    @Published var loading : Bool = true
    @Published var board : BoardMemoryGame = BoardMemoryGame()
    
    @Published var gameModeSelected : GameModeMemoryGame = .sequential
    @Published var cardsAmountSelected : Int = 6
    @Published var visualizationTimeSelected : Int = 1
    
    func reset () -> Void {
        board.reset()
        loading = true
    }
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
}
