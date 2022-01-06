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
            Text("Tiempo de muestra o Cantidad de players")
                .fontWeight(.bold)
                .font(.system(.title))
                .padding()
                .customTextStyle()
            Spacer()
        }
    }
}

struct MemoryGameMenu_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameMenu()
    }
}
