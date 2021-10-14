//
//  ContentView.swift
//  Test03
//
//  Created by Rodolfo.Iribarren on 14/09/2021.
//

import SwiftUI

let initialBoard : [CellState] = [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty]

struct MainView: View {
    @State private var pressed : [CellState] = initialBoard
    @State private var playerXTurn : Bool = true
    @State private var GameStateProperty : GameState = GameState.active
    
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
                
                GameOverView(GameStateProperty: GameStateProperty)
                
                if GameStateProperty != GameState.active
                {
                    Spacer()
                    
                    Button("Reiniciar el juego") {
                        resetGame()
                    }
                }
                
                TurnView(playerXTurn: playerXTurn, GameStateProperty: GameStateProperty)
                
                Spacer()
            }
            Spacer()
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(0..<9) {index in
                        Cell(playability: $pressed[index], playerXTurn: $playerXTurn, pressed: $pressed, index: index, GameStateProperty: GameStateProperty)
                            .onChange(of: pressed, perform: { value in
                                for (winnerArray) in winnerLines {
                                    if (pressed[winnerArray[0]] == pressed[winnerArray[1]] && pressed[winnerArray[0]] == pressed[winnerArray[2]] && pressed[winnerArray[0]] != CellState.empty)
                                    {
                                        GameStateProperty = playerXTurn ? GameState.playerOWin :
                                            GameState.playerXWin
                                        // Investigar como interrumpir este loop.
                                        print("WIIIIINNNNNNN \(index)")
                                        break
                                    }
                                    else if (!pressed.contains(CellState.empty)){
                                        GameStateProperty = GameState.draw
                                    }
                                }
                            })
                    }
                }
                .padding()
            }
        }
    }
    
    func resetGame() -> Void {
        pressed = initialBoard
        playerXTurn = true
        GameStateProperty = GameState.active
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
