//
//  LivesIndicator_MemoryGame.swift
//  proyecto-x
//
//  Created by Delfina Fenocchio on 07/04/2022.
//

import SwiftUI

struct LivesIndicator_MemoryGame: View {
    var remainingLives : Int
    var body: some View {
        HStack {
            ForEach((0..<remainingLives).reversed(), id: \.self) {_ in
                Image("Heart")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
        }
    }
}
