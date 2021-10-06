//
//  ContentView.swift
//  Test03
//
//  Created by Rodolfo.Iribarren on 14/09/2021.
//

import SwiftUI

struct ContentView: View {    
    @State var pressed : [cellState] = [.green, .green, .green, .green, .green, .green, .green, .green, .green]
    @State var playerBlueTurn : Bool = true
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
                
                Image(systemName: "xmark")
                
                TurnView(playerBlueTurn: playerBlueTurn, GameStateProperty: GameStateProperty)
                
                Spacer()
            }
            Spacer()
            
            LazyVGrid(columns: columns) {
                ForEach(0..<9) {index in
                    Cell(playerBlueTurn: $playerBlueTurn, pressed: $pressed, index: index, GameStateProperty: GameStateProperty)
                        .onChange(of: pressed, perform: { value in
                            print("El array pressed es: \(value)")
                            for (_, winnerArray) in winnerLines.enumerated() {
                                if (pressed[winnerArray[0]] == pressed[winnerArray[1]] && pressed[winnerArray[0]] == pressed[winnerArray[2]] && pressed[winnerArray[0]] != cellState.green)
                                {
                                    GameStateProperty = playerBlueTurn ? GameState.redWin : GameState.blueWin
                                    // Investigar como interrumpir este loop.
                                    print("WIIIIINNNNNNN")
                                    break
                                }
                            }
                        })
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
