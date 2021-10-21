//
//  ContentView.swift
//  Test03
//
//  Created by Rodolfo.Iribarren on 14/09/2021.
//

import SwiftUI

let initialBoard : [CellState] = [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty]

class TicTacToeState : ObservableObject {
    @Published var pressed : [CellState] = initialBoard
    @Published var playerXTurn : Bool = true
    @Published var GameStateProperty : GameState = GameState.active
}

struct MainView: View {
    @StateObject var mainViewState : TicTacToeState = TicTacToeState()
    
    let winnerLines : [[Int]] = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]
    
    let columns: [GridItem] = [GridItem(),
                               GridItem(),
                               GridItem()]
    
    var body: some View {
        
        VStack {
            
            VStack {
                Spacer()
                
                Text("Tic Tac Toe")
                    .fontWeight(.bold)
                    .font(.system(.title))
                    .padding()
                
                Spacer()
                
                GameOverView(GameStateProperty : mainViewState.GameStateProperty)
                
                if mainViewState.GameStateProperty != GameState.active
                {
                    Spacer()
                    
                    Button("Reiniciar el juego") {
                        self.resetGame()
                    }
                }
                
                TurnView(playerXTurn : mainViewState.playerXTurn, GameStateProperty: mainViewState.GameStateProperty)
                
                Spacer()
            }
            Spacer()
            
                LazyVGrid(columns: columns) {
                    ForEach(0..<9) {index in
                        Cell(playability : $mainViewState.pressed[index], index: index)
                            .onChange(of: mainViewState.pressed, perform: { value in
                                for (winnerArray) in winnerLines {
                                    if (mainViewState.pressed[winnerArray[0]] == mainViewState.pressed[winnerArray[1]] && mainViewState.pressed[winnerArray[0]] == mainViewState.pressed[winnerArray[2]] && mainViewState.pressed[winnerArray[0]] != CellState.empty)
                                    {
                                        mainViewState.GameStateProperty = mainViewState.playerXTurn ? GameState.playerOWin :
                                            GameState.playerXWin
                                        // Investigar como interrumpir este loop.
                                        print("WIIIIINNNNNNN \(index)")
                                        break
                                    }
                                    else if (!mainViewState.pressed.contains(CellState.empty)){
                                        mainViewState.GameStateProperty = GameState.draw
                                    }
                                }
                            })
                    }
                }
                .frame(width: 400, height: 400)
                .background(Color(red: 93/255, green: 44/255, blue: 148/255))
                .padding()
        }
        .environmentObject(mainViewState)
    }
    
    func resetGame() -> Void {
        mainViewState.pressed = initialBoard
        mainViewState.playerXTurn = true
        mainViewState.GameStateProperty = GameState.active
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
