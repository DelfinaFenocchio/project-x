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
    
    let winnerLines = [
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
                
                Text("Turno de: \(playerBlueTurn ? "Azul" : "Rojo" )")
                    .padding()
                
                Spacer()
            }
            

            
            Spacer()
            
            
            LazyVGrid(columns: columns) {
                ForEach(0..<9) {index in
                    Cell()
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
