//
//  ContentView.swift
//  Test03
//
//  Created by Rodolfo.Iribarren on 14/09/2021.
//

import SwiftUI

let initialBoard : [CellState] = [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty]

struct TicTacToeIndex: View {

    @State var pressed : [CellState] = initialBoard
    @State var playerXTurn : Bool = true
    @State var GameStateProperty : GameState = GameState.active
    
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
       
        VStack{
            
            VStack {
                Spacer()
                
                Text("Nubi Tic Tac Toe")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/))
                    .padding()
                
                Spacer()
                
                GameOverView(GameStateProperty: GameStateProperty)
                
                if GameStateProperty == GameState.active
                {
                    playerXTurn ? Image(systemName: "xmark") : Image(systemName: "circle")
                }
                else
                {
                    Button("Reiniciar el juego") {
                        resetGame()
                    }
                }
                
                TurnView(playerXTurn: playerXTurn, GameStateProperty: GameStateProperty)
                
                Spacer()
            }
            Spacer()
            
            LazyVGrid(columns: columns) {
                ForEach(0..<9) {index in
                    Cell(playerXTurn: $playerXTurn, pressed: $pressed, index: index, GameStateProperty: GameStateProperty)
                        .onChange(of: pressed, perform: { value in
                            print("El array pressed es: \(value)")
                            for (_, winnerArray) in winnerLines.enumerated() {
                                if (pressed[winnerArray[0]] == pressed[winnerArray[1]] && pressed[winnerArray[0]] == pressed[winnerArray[2]] && pressed[winnerArray[0]] != CellState.empty)
                                {
                                    GameStateProperty = playerXTurn ? GameState.playerOWin :
                                        GameState.playerXWin
                                    // Investigar como interrumpir este loop.
                                    print("WIIIIINNNNNNN")
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
 
    func resetGame() -> Void {
        print("antes: \(pressed)")
        pressed = initialBoard
        print("despues: \(pressed)")
        playerXTurn = true
        GameStateProperty = GameState.active
        //TODO: ver como re renderizar la grilla
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeIndex()
    }
}
