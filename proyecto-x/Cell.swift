//
//  Cell.swift
//  proyecto-x
//
//  Created by Francisco Zapiola on 28/09/2021.
//

import SwiftUI

struct Cell: View {
    @EnvironmentObject var globalState : TicTacToeState
    @Binding var playability : CellState
    let index : Int
    let screenGeometry : GeometryProxy
    let possibleWinnerLines : [[Int]]
    @Binding var winnerLine : [Int]
    let gameMode : GameMode
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .customCellStyle(width: screenGeometry.size.width / 3.5)
                .onTapGesture(count: 1, perform: {
                    if(playability == CellState.empty && globalState.GameStateProperty == GameState.active)
                    {
                        onTapGestureHandler()
                    }
                })
            
            
            if(playability != CellState.empty) {
                if (playability == CellState.playerX) {
                    Image(systemName: "xmark").resizable().frame(width: 50, height: 50).foregroundColor(.white)
                } else {
                    Image(systemName: "circle").resizable().frame(width: 50, height: 50).foregroundColor(.white)
                }
            }
        }
    }
    
    public func onTapGestureHandler() {
        if(globalState.playerXTurn) {
            globalState.board.pressed[index] = CellState.playerX
        } else {
            globalState.board.pressed[index] = CellState.playerO
        }
        globalState.playerXTurn.toggle()
        
        
        for (possibleWinnerLine) in possibleWinnerLines {
                if isVictory(possibleWinnerLine) {
//                    globalState.GameStateProperty = globalState.playerXTurn ? GameState.playerOWin :
//                        GameState.playerXWin
                    
                    if globalState.playerXTurn {
                        globalState.GameStateProperty = GameState.playerOWin
                        print("gano la o")
                    } else {
                        globalState.GameStateProperty = GameState.playerXWin
                        print("gano la x")
                    }
                    
                    winnerLine = possibleWinnerLine
                    
                    // Investigar como interrumpir este loop.
                    print("WIIIIINNNNNNN \(index)")
                    break
                }
                else {
                    if (!globalState.board.pressed.contains(CellState.empty)){
                        globalState.GameStateProperty = GameState.draw
                    } else {
                        if(!globalState.playerXTurn && gameMode == .singlePlayer){
                            //TO DO: Choose to play PvP or PvC
                            print("antes: \(globalState.playerXTurn)")
                            
                            automaticPlay()
                            globalState.playerXTurn.toggle()
                            print("despues: \(globalState.playerXTurn)")
                        }
                    }
                }
            }
        
        
    }
    
    func isVictory(_ winnerLine: [Int]) -> Bool {
        return globalState.board.pressed[winnerLine[0]] == globalState.board.pressed[winnerLine[1]] && globalState.board.pressed[winnerLine[0]] == globalState.board.pressed[winnerLine[2]] && globalState.board.pressed[winnerLine[0]] != CellState.empty
    }
    
    func automaticPlay() -> Void {
        //TO DO: Select difficulty
        //await Task.sleep(1 * 1_000_000_000)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            var emptyCellIndexes : [Int] = []
            
            for (index, cell) in globalState.board.pressed.enumerated() {
                if cell == CellState.empty {
                    emptyCellIndexes.append(index)
              }
            }

            if let randomEmptyCellIndex = emptyCellIndexes.randomElement() {
                //TO DO: delay this action and prevent user from playing while it's the computer's turn
                globalState.board.pressed[randomEmptyCellIndex] = CellState.playerO
            }
        }
    }
}



