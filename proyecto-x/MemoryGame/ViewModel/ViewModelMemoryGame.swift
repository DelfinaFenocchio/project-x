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
    var flipped : Bool = false
}

@MainActor
final class MemoryGameState : ObservableObject {
    @Published var loading : Bool = true
    
    @Published var gameModeSelected : GameModeMemoryGame = .sequential
    @Published var cardsAmountSelected : Int = 2
    @Published var visualizationTimeSelected : Int = 1
    @Published var remainingLives : Int = 3
    @Published var showEndModal : Bool = false

    @Published var playableCards : [MemoryGameCard] = []
    @Published var cardsArrangement : [Int] = []
    @Published var selectedArrangement : [Int] = []
    
    @Published var disabled : Bool = true
    
    @Published var flipLoading : Bool = true
    
    let initialVisualizationDelay : UInt64 = 500_000_000
    let mistakeVisualizationDelay : UInt64 = 1_500_000_000
    
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
        Task {
            try? await Task.sleep(nanoseconds: initialVisualizationDelay)
            flipAllCards()
            try? await Task.sleep(nanoseconds: UInt64(visualizationTimeSelected * 1_000_000_000))
            flipAllCards()
            flipLoading.toggle()
            disabled = false
        }
    }
    
    func flipAllCards (value : Bool? = nil) -> Void {
            withAnimation(Animation.easeIn(duration: 0.3)){
                playableCards = playableCards.map { card in
                    var mutableCard = card
                    if let flipped = value {
                        mutableCard.flipped = flipped
                    } else {
                        mutableCard.flipped.toggle()
                    }
                    return mutableCard
                 }
            }
        
    }
    
    func flipCard (index : Int) -> Void {
        print(playableCards[index].id)
        playableCards[index].flipped = true
        selectedArrangement.append(playableCards[index].id)
    }

    func handleMistake () -> Void {
        Task {
            try? await Task.sleep(nanoseconds: mistakeVisualizationDelay)
            flipAllCards(value: true)
            try? await Task.sleep(nanoseconds: mistakeVisualizationDelay)
            flipAllCards(value: false)
            selectedArrangement = []
            disabled = false
        }
    }

    func evaluateFlip () -> Void {
        let lastFlip = selectedArrangement.count == cardsAmountSelected
        
        var wrong = false
          
        for (index, selectedCard) in selectedArrangement.enumerated() {
            if (cardsArrangement[index] != selectedCard) {
                wrong = true
                break;
            }
        }
        
        if (wrong) {
            disabled = true
            remainingLives -= 1
            if(remainingLives != 0){
               handleMistake()
            }
        } else {
            if (lastFlip) {
                onVictory()
            }
        }
    }
    
    
    func onGoBack () -> Void {
        showEndModal = false
        reset()
    }
    
    func reset () -> Void {
        loading = true
        flipLoading = true
        playableCards = []
        cardsArrangement = []
        selectedArrangement = []
        remainingLives = 3
        disabled = true
    }
    
    
    func onVictory () -> Void {
        Task {
            try? await Task.sleep(nanoseconds: UInt64(1_000_000_000))
            withAnimation(Animation.easeIn(duration: 0.5)){
                showEndModal = true
            }
            try? await Task.sleep(nanoseconds: UInt64(3_500_000_000))
            reset()
            generateGame(cardsAmount: cardsAmountSelected)
            loading.toggle()
            withAnimation(Animation.easeIn(duration: 0.5)){
                showEndModal = false
            }
            
            try? await Task.sleep(nanoseconds: UInt64(1_500_000_000))
            startGame()
            
            
        }
    }
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
}
