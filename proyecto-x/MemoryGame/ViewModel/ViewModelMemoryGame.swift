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

final class MemoryGameState : ObservableObject {
    @Published var loading : Bool = true
    
    @Published var gameModeSelected : GameModeMemoryGame = .sequential
    @Published var cardsAmountSelected : Int = 6
    @Published var visualizationTimeSelected : Int = 1
    @Published var remainingLives : Int = 3
    @Published var victory : Bool = false

    @Published var playableCards : [MemoryGameCard] = []
    @Published var cardsArrangement : [Int] = []
    @Published var selectedArrangement : [Int] = []
    
    @Published var disabled : Bool = false
    
    @Published var flipLoading : Bool = true
    
    //TODO: Contemplate other game modes. Currently only "sequential"
    func generateGame(cardsAmount : Int) -> Void {
        let randomImageIds = getRandomImageIds()
        
        var index : Int = 0
        while index < cardsAmount{
            cardsArrangement.append(index)

            playableCards.append(MemoryGameCard(id: index, image: randomImageIds[index]))

            index += 1
        }
        playableCards.shuffle()
    }
    
    func startGame() -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(visualizationTimeSelected)) { [self] in
            
            withAnimation(Animation.easeIn(duration: 0.3)){
                playableCards = playableCards.map { card in
                     var mutableCard = card
                     mutableCard.flipped.toggle()
                     return mutableCard
                 }
            }
            
            flipLoading.toggle()
        }
    }
    
    func flipCard (index : Int) -> Void {
        print(playableCards[index].id)
        playableCards[index].flipped = true
        selectedArrangement.append(playableCards[index].id)
    }
    
    func resetCards () -> Void {
        print("Escondiendo cartas..")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [self] in
            for (index, item) in playableCards.enumerated() {
                if(item.flipped) {
                    withAnimation(Animation.easeIn(duration: 0.3)){
                        playableCards[index].flipped = false
                    }
                }
            }
            
            selectedArrangement = []
            disabled = false
        }
    }
    
    func evaluateFlip () -> Void {
        print("Total: \(selectedArrangement)")
        
        let lastFlip = selectedArrangement.count == cardsAmountSelected
        
        var wrong = false
          
        for (index, selectedCard) in selectedArrangement.enumerated() {
            if (cardsArrangement[index] != selectedCard) {
                wrong = true
                break;
            }
        }
        
        if (wrong) {
            print("Card incorrecta")
            disabled = true
            remainingLives -= 1
            if(remainingLives != 0){
                resetCards()
            }
        } else {
            print("Elegiste bien")
            if (lastFlip) {
                victory = true
            }
        }
        
        print("------------------------------")
    }
    
    
    func reset () -> Void {
        loading = true
        flipLoading = true
        victory = false
        playableCards = []
        cardsArrangement = []
        selectedArrangement = []
        remainingLives = 3
        disabled = false
    }
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
}
