//
//  memoryGameResult.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 08/03/2022.
//

import SwiftUI

struct MemoryGameResultModal: View {
    @EnvironmentObject var state : MemoryGameState
    
       
       var body: some View {
           
           ZStack {
               Color.green.ignoresSafeArea()
               
               Text("Ganaste")
           }
       }
}
