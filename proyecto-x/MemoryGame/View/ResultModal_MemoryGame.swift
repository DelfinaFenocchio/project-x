//
//  memoryGameResult.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 08/03/2022.
//

import SwiftUI

struct MemoryGameResultModal: View {
    @EnvironmentObject var state : MemoryGameState
    @Environment(\.presentationMode) var presentationMode
    
    @State var remainingTime : Double = 3.5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let screenGeometry : GeometryProxy
       
       var body: some View {
           
               ZStack(alignment: .center) {
                   Color.black.opacity(0.4)
                       .ignoresSafeArea()
                   
                   RoundedRectangle(cornerRadius: 25.0)
                       .padding()
                       .foregroundColor(.white)
                       .frame(width: screenGeometry.size.width, height: screenGeometry.size.height - 300, alignment: .center)
                       .ignoresSafeArea()

                   VStack {
                       if (state.gameModeSelected == GameModeMemoryGame.classicMultiPlayer){
                           let playerOne = state.playersData["First"]!
                           let playerTwo = state.playersData["Second"]!
                           Text("\(playerOne.name): \(playerOne.score) \(playerTwo.name): \(playerTwo.score)")
                           if (playerOne.winner || playerTwo.winner) {
                               Text("Ganó: \(playerTwo.winner ? playerTwo.name : playerOne.name)")
                           } else {
                               Text("Empataron")
                           }
                           Button(action: { self.presentationMode.wrappedValue.dismiss() })
                           { Text("Volver al Menu") }
                       } else {
                           if (state.gameStatus == GameStatusMemoryGame.victory) {
                               Text("Ganaste!")

                               Text("Puntuacion: \(state.totalScore)")
                               
                               Text("Próximo juego comienza en: \(Int(remainingTime + 1))")
                           }
                           else {
                                if (state.gameStatus == GameStatusMemoryGame.defeated) {
                                   Text("Perdiste")

                                   Text("Puntuacion: \(state.totalScore)")
                                   
                                   Button(action: { self.presentationMode.wrappedValue.dismiss() })
                                   { Text("Volver al Menu") }
                               }
                               else {
                                   EmptyView()
                               }
                           }
                       }

                       
                   }
//
//
//               }
//               .background(Color.blue)
//               .frame(maxHeight: .infinity)
           }
               .onReceive(timer) { _ in
                   remainingTime -= 1
                }
           
       }
    
}
