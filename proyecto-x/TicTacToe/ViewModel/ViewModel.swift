//
//  ViewModel.swift
//  proyecto-x
//
//  Created by Lisbaldy de Jesus on 23/12/2021.
//

import SwiftUI

let initialBoardPlayability : [CellState] = [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty]

struct BoardStruct {
    var pressed = initialBoardPlayability
    
    var coords : [CGPoint] = [CGPoint(x: 216.0, y: 91.0), CGPoint(x: 216.0, y: 91.0), CGPoint(x: 216.0, y: 91.0), CGPoint(x: 216.0, y: 91.0), CGPoint(x: 216.0, y: 91.0), CGPoint(x: 216.0, y: 91.0), CGPoint(x: 216.0, y: 91.0), CGPoint(x: 216.0, y: 91.0), CGPoint(x: 216.0, y: 91.0)]
    
    mutating func setCoords(index : Int, point: CGPoint){
        coords[index] = point
    }
}

final class TicTacToeState : ObservableObject {
    @Published var board : BoardStruct = BoardStruct()
    @Published var playerXTurn : Bool = true
    @Published var GameStateProperty : GameState = GameState.active
    @Published var isGameboardDisabled = false
    @Published var percentage: CGFloat = .zero
    @Published var winnerLine : [Int] = []
    @Published var gameMode : GameMode = .notSelectedMode
    
    let possibleWinnerLines : [[Int]] = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    func isVictory(_ winnerLine: [Int]) -> Bool {
        return board.pressed[winnerLine[0]] == board.pressed[winnerLine[1]] && board.pressed[winnerLine[0]] == board.pressed[winnerLine[2]] && board.pressed[winnerLine[0]] != CellState.empty
    }
    
    func resetGame() -> Void {
        board.pressed = initialBoardPlayability
        playerXTurn = true
        GameStateProperty = GameState.active
        percentage = .zero
        isGameboardDisabled = false
    }
    
    func automaticPlay() -> Void {
        //TO DO: Select difficulty
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            var emptyCellIndexes : [Int] = []
            
            for (index, cell) in board.pressed.enumerated() {
                if cell == CellState.empty {
                    emptyCellIndexes.append(index)
                }
            }
            
            if let randomEmptyCellIndex = emptyCellIndexes.randomElement() {
                board.pressed[randomEmptyCellIndex] = CellState.playerO
                isGameboardDisabled = false
                _ = evaluatePlay()
            }
            
        }
    }
    
    func evaluatePlay () ->  GameState {
        for (possibleWinnerLine) in possibleWinnerLines {
            if isVictory(possibleWinnerLine) {
                if playerXTurn {
                    GameStateProperty = GameState.playerOWin
                } else {
                    GameStateProperty = GameState.playerXWin
                }
                
                winnerLine = possibleWinnerLine
                break
            }
            else {
                if (!board.pressed.contains(CellState.empty)){
                    GameStateProperty = GameState.draw
                }
            }
        }
        return GameStateProperty
    }
    
    func onTapGestureHandler(index: Int) {
        if(gameMode == .singlePlayer) {
            isGameboardDisabled = true
        }
        
        if(playerXTurn) {
            board.pressed[index] = CellState.playerX
        } else {
            board.pressed[index] = CellState.playerO
        }
        
        playerXTurn.toggle()
        
        _ = evaluatePlay()
        
        if(!playerXTurn && gameMode == .singlePlayer && GameStateProperty == GameState.active){
            automaticPlay()
            playerXTurn.toggle()
        }
    }
}
