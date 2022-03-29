//
//  memoryGameResult.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 08/03/2022.
//

import SwiftUI

struct MemoryGameResultModal: View {
    @EnvironmentObject var state : MemoryGameState
    @State var remainingTime : Double = 3.5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let screenGeometry : GeometryProxy
       
       var body: some View {
           
               ZStack(alignment: .center) {
                   Color.black.opacity(0.4)
                       .ignoresSafeArea()
                   
                   RoundedRectangle(cornerRadius: 25.0)
                       .padding()
                       .foregroundColor(.green)
                       .frame(width: screenGeometry.size.width, height: screenGeometry.size.height - 300, alignment: .center)
                       .ignoresSafeArea()

                   VStack {
                       Text("Ganaste!")

                       Text("Puntuacion: \(state.totalScore)")
                       
                       Text("Próximo juego comienza en: \(Int(remainingTime + 1))")
                       
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
