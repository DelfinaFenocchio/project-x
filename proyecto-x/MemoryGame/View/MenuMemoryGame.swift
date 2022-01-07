//
//  MemoryGameMenu.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 04/01/2022.
//

import SwiftUI



struct MemoryGameMenu: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Memory Game")
            Spacer()
            Text("Cantidad de cards")
                .fontWeight(.bold)
                .font(.system(.title))
                .padding()
                .customTextStyle()
            Spacer()
            Text("Elegí el modo de juego")
                .fontWeight(.bold)
                .font(.system(.title))
                .padding()
                .customTextStyle()
            Spacer()
            Text("Tiempo de previsualizacion")
                .fontWeight(.bold)
                .font(.system(.title))
                .padding()
                .customTextStyle()
            Spacer()
            NavigationLink(destination: MemoryMainView()) {
                    Text("Comenzar juego")
                        .customButtonStyle()
            }
        }
    }
}
