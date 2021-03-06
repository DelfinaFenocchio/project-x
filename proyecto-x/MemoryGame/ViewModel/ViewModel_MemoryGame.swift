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
    var pairFound : Bool = false
}

struct PlayerMemoryGame {
    var score: Int
    var winner: Bool
    var name: String
}

func == (left: PlayerMemoryGame, right: PlayerMemoryGame) -> Bool {
    return left.score == right.score
}

func > (left: PlayerMemoryGame, right: PlayerMemoryGame) -> Bool {
    return left.score > right.score
}

func < (left: PlayerMemoryGame, right: PlayerMemoryGame) -> Bool {
    return left.score < right.score
}

@MainActor
final class MemoryGameState : ObservableObject {
    @Published var loading : Bool
    
    @Published var gameModeSelected : GameModeMemoryGame
    @Published var cardsAmountSelected : Int
    @Published var visualizationTimeSelected : Int
    @Published var remainingLives : Int
    @Published var livesAmountSelected : Int
    @Published var totalScore : Int
    @Published var highScore : Int
    @Published var gameStatus : GameStatusMemoryGame

    @Published var playableCards : [MemoryGameCard]
    @Published var cardsArrangement : [Int]
    @Published var selectedArrangement : [Int]
    
    @Published var disabled : Bool
    
    @Published var flipLoading : Bool
    
    @Published var evaluatePair : Bool
    @Published var firstImageSelected : String
    @Published var secondImageSelected : String
    
    // Multiplayer properties
    @Published var playerOneTurn : Bool
    @Published var playersData : [String: PlayerMemoryGame]
    
    @Published var turnDuration : Int
    
    @Published var turnTimeRemaining : Int
    let turnTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var tasksArray : [Task<(), Never>]
    
    @Published var playerOneName : String = "Jugador 1"
    @Published var playerTwoName : String = "Jugador 2"
    
    init() {
        self.loading = true
        self.gameModeSelected = .sequential
        self.cardsAmountSelected = 2
        self.visualizationTimeSelected = 3
        self.remainingLives = 0
        self.livesAmountSelected = 4
        self.totalScore = 0
        self.highScore = UserDefaults.standard.integer(forKey: "MemoryGameHighScore")
        self.gameStatus = GameStatusMemoryGame.inactive
        self.playableCards = []
        self.cardsArrangement = []
        self.selectedArrangement = []
        self.disabled = true
        self.flipLoading = true
        self.evaluatePair = false
        self.firstImageSelected = ""
        self.secondImageSelected = ""
        self.playerOneTurn = Bool.random()
        self.playersData = ["First" : PlayerMemoryGame(score: 0, winner: false, name: "Jugador 1"), "Second" : PlayerMemoryGame(score: 0, winner: false, name: "Jugador 2")]
        self.turnDuration = 5
        self.turnTimeRemaining = 0
        self.tasksArray = []
    }
    
    
    func generateGame (cardsAmount : Int) -> Void {
        switch gameModeSelected {
            case .classicSinglePlayer:
            generateGame_classic(cardsAmount: cardsAmount)
            case .classicMultiPlayer:
            generateGame_classic(cardsAmount: cardsAmount)
            case .sequential:
            generateGame_sequential(cardsAmount: cardsAmount)
            }
    }
    
    func generateGame_sequential(cardsAmount : Int) -> Void {
        let randomImageIds = getRandomImageIds()
        
        var index : Int = 0
        while index < cardsAmount{
            cardsArrangement.append(index)

            playableCards.append(MemoryGameCard(id: index, image: randomImageIds[index]))

            index += 1
        }
        playableCards.shuffle()
    }
    
    func generateGame_classic(cardsAmount : Int) -> Void {
        let randomImageIds = getRandomImageIds()
        let auxPlayableCards : [MemoryGameCard]
        
        var index : Int = 0
        while index < cardsAmount/2{
            //cardsArrangement.append(index)

            playableCards.append(MemoryGameCard(id: index, image: randomImageIds[index]))

            index += 1
        }
        auxPlayableCards = playableCards
        playableCards.append(contentsOf: auxPlayableCards)
        playableCards.shuffle()
    }
    
    func startGame() -> Void {
        disabled = true
        startTask { [self] in
            remainingLives = livesAmountSelected
            turnTimeRemaining = turnDuration
            try? await Task.sleep(nanoseconds: SecondsUInt64.half.rawValue)
            flipAllCards()
            try? await Task.sleep(nanoseconds: UInt64(visualizationTimeSelected) * SecondsUInt64.one.rawValue)
            flipAllCards()
            flipLoading.toggle()
            disabled = false
            gameStatus = .active
        }
        
    }
    
    func startTask(_ action: @escaping () async -> Void) {
        let newTask = Task {
            await action()
        }
        tasksArray.append(newTask)
    }
    
    func cancelAllTasks() -> Void {
        for (_, task) in tasksArray.enumerated() {
            task.cancel()
        }
    }
    
    func flipAllCards (value : Bool? = nil) -> Void {
        withAnimation(Animation.easeIn(duration: SecondsFloat.three_tenths.rawValue)){
                playableCards = playableCards.map { card in
                    var mutableCard = card
                    if !mutableCard.pairFound {
                        if let flipped = value {
                            mutableCard.flipped = flipped
                        } else {
                            mutableCard.flipped.toggle()
                        }
                    }
                    return mutableCard
                 }
            }
        
    }
    
    func flipCard (index : Int) -> Void {
        playableCards[index].flipped = true
        if gameModeSelected != .sequential {
            if !evaluatePair {
                firstImageSelected = playableCards[index].image
            } else {
                secondImageSelected = playableCards[index].image
            }
        }
        selectedArrangement.append(playableCards[index].id)
    }

    func handleMistake () -> Void {
        startTask { [self] in
            try? await Task.sleep(nanoseconds: SecondsUInt64.one_and_a_half.rawValue)
            flipAllCards(value: true)
            try? await Task.sleep(nanoseconds: SecondsUInt64.one_and_a_half.rawValue)
            flipAllCards(value: false)
            selectedArrangement = []
            disabled = false
        }
    }
    
    func handleMistake_classic () -> Void {
        startTask { [self] in
            try? await Task.sleep(nanoseconds: SecondsUInt64.one_and_a_half.rawValue)
            flipAllCards(value: false)
            disabled = false
        }
    }

    func evaluateFlip () -> Void {
        switch gameModeSelected {
            case .classicSinglePlayer:
                evaluateFlip_classic_singlePlayer()
            case .classicMultiPlayer:
                evaluateFlip_classic_multiplayer()
            case .sequential:
                evaluateFlip_sequential()
            }
    }
    
    func evaluateFlip_classic_multiplayer() -> Void {
        guard evaluatePair else {
            evaluatePair = true
            return
        }
        
        let lastFlip = playableCards.allSatisfy{$0.flipped == true}
        
        var wrong = false
        
        if (firstImageSelected == secondImageSelected) {
            playableCards = playableCards.map{
                var mutableCard = $0
                if $0.image == firstImageSelected {
                    mutableCard.pairFound = true
                }
                return mutableCard
            }
        } else {
            wrong = true
        }
    
        evaluatePair = false
        
        if (wrong) {
            disabled = true
            handleMultiplayerTurnEnd()
            handleMistake_classic()
        } else {
            self.playersData[self.playerOneTurn ? "First" : "Second"]!.score += 1
            if (lastFlip) {
                onVictory_Multiplayer()
            }
        }
    }
    
    func evaluateFlip_sequential () -> Void {
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
            else {
                onDefeated()
            }
        } else {
            if (lastFlip) {
                do {
                    try onVictory()
                } catch {
                    print("Ocurrio un error inesperado \(error)")
                }
                
            }
        }
    }
    
    func evaluateFlip_classic_singlePlayer () -> Void {
        
        guard evaluatePair else {
            evaluatePair = true
            return
        }
        
        let lastFlip = playableCards.allSatisfy{$0.flipped == true}
        
        var wrong = false
        
        if (firstImageSelected == secondImageSelected) {
            playableCards = playableCards.map{
                var mutableCard = $0
                if $0.image == firstImageSelected {
                    mutableCard.pairFound = true
                }
                return mutableCard
            }
        } else {
            wrong = true
        }
    
        evaluatePair = false
        
        if (wrong) {
            disabled = true
            remainingLives -= 1
            if(remainingLives != 0){
                handleMistake_classic()
            }
            else {
                onDefeated()
            }
        } else {
            if (lastFlip) {
                do {
                    try onVictory()
                } catch  {
                    print("Ocurrio un error inesperado \(error)")
                }
            }
        }
    }
    
    func handleMultiplayerTurnEnd() -> Void {
        disabled = true
        startTask { [self] in
            try? await Task.sleep(nanoseconds: SecondsUInt64.one_and_a_half.rawValue)
            turnTimeRemaining = turnDuration
            evaluatePair = false
            playerOneTurn.toggle()
            flipAllCards(value: false)
            disabled = false
        }
    }
    
    func onVictory_Multiplayer() -> Void {
        startTask { [self] in
            let firstPlayer = playersData["First"]!
            let secondPlayer = playersData["Second"]!
            try? await Task.sleep(nanoseconds: SecondsUInt64.one.rawValue)
            withAnimation(Animation.easeIn(duration: SecondsFloat.half.rawValue)){
                if ((firstPlayer > secondPlayer) || (firstPlayer < secondPlayer)) {
                    if(firstPlayer > secondPlayer){
                        playersData["First"]!.winner = true
                    }else{
                        if((firstPlayer < secondPlayer)){
                            playersData["Second"]!.winner = true
                        }
                    }
                }
                gameStatus = GameStatusMemoryGame.finished
            }
        }
    }
    
    func onGoBack () -> Void {
        gameStatus = GameStatusMemoryGame.inactive
        evalutateHighScore()
        reset()
        cancelAllTasks()
    }
    
    func reset () -> Void {
        loading = true
        flipLoading = true
        playableCards = []
        cardsArrangement = []
        selectedArrangement = []
        evaluatePair = false
        disabled = true
        playerOneTurn = Bool.random()
        playersData["First"]!.winner = false
        playersData["Second"]!.winner = false
        playersData["First"]!.score = 0
        playersData["Second"]!.score = 0
    }
    
    func onVictory () throws -> Void {
        totalScore += calculateScore()
//        if totalScore > highScore {
//            UserDefaults.standard.set(self.totalScore, forKey: "MemoryGameHighScore")
//        }
        startTask { [self] in
            try? await Task.sleep(nanoseconds: UInt64(SecondsUInt64.one.rawValue))
            withAnimation(Animation.easeIn(duration: SecondsFloat.half.rawValue)){
                gameStatus = GameStatusMemoryGame.victory
            }
            try? await Task.sleep(nanoseconds: UInt64(SecondsUInt64.three_and_a_half.rawValue))
            reset()
            generateGame(cardsAmount: cardsAmountSelected)
            loading.toggle()
            withAnimation(Animation.easeIn(duration: SecondsFloat.half.rawValue)){
                gameStatus = GameStatusMemoryGame.active
            }
            
            try? await Task.sleep(nanoseconds: UInt64(SecondsUInt64.one_and_a_half.rawValue))
            startGame()
        }
    }
    
    func evalutateHighScore () -> Void {
        if totalScore > highScore {
            UserDefaults.standard.set(self.totalScore, forKey: "MemoryGameHighScore")
        }
    }
    
    func onDefeated () -> Void {
        startTask { [self] in
            try? await Task.sleep(nanoseconds: UInt64(SecondsUInt64.one.rawValue))
            withAnimation(Animation.easeIn(duration: SecondsFloat.half.rawValue)){
                gameStatus = GameStatusMemoryGame.defeated
            }
        }
    }
    
    func calculateScore () -> Int {
        guard let cardPoints = CardAmountValuePoints[gameModeSelected]?[cardsAmountSelected] else {
            print("esto pasa porque estamos en modo desarrollo con 2 cards")
            return 0
        }
        var score = 0
        score += cardPoints
        score += pointsEarnedByCategory(category: visualizationTimeSelected, pointsBank: PrevisualizationTimeValuePoints)
        score += pointsEarnedByCategory(category: livesAmountSelected, pointsBank: LivesAmountValuePoints)
        score -= 5 * (livesAmountSelected - remainingLives)
        return score
    }
    
    func pointsEarnedByCategory(category optionSelectedOrRemaining : Int, pointsBank pointsDictionary : [Int: Int]) -> Int {
        if let pointsWon = pointsDictionary[optionSelectedOrRemaining] {
            return pointsWon
        }
        return 0
    }
}
