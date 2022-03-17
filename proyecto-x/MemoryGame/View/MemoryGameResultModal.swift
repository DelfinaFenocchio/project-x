//
//  memoryGameResult.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 08/03/2022.
//

import SwiftUI

struct MemoryGameResultModal: View {
    @EnvironmentObject var state : MemoryGameState
    let screenGeometry : GeometryProxy
       
       var body: some View {
           
//            Text("hola")
//               .frame(width: screenGeometry.size.width, height: screenGeometry.size.height, alignment: .center)
//               .background(Color.yellow)
               
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
                   }
//
//
//               }
//               .background(Color.blue)
//               .frame(maxHeight: .infinity)
           }
       }
}
