//
//  MemoryGameHelperText.swift
//  proyecto-x
//
//  Created by Francisco Zapiola on 10/02/2022.
//

import SwiftUI

struct MemoryGameHelperText: View {
    @EnvironmentObject var state : MemoryGameState
    
    var body: some View {
        if(state.flipLoading){
            Text("Observa los animales durante \(state.visualizationTimeSelected) segundos")
        } else {
            if(state.remainingLives != 0) {
                Text("Te quedan \(state.remainingLives) intentos")
            }
        }
    }
}
