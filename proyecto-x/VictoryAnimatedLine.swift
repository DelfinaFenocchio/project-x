//
//  VictoryAnimatedLine.swift
//  proyecto-x
//
//  Created by Delfina Fenocchio on 05/11/2021.
//

import SwiftUI

struct VictoryAnimatedLine: View {
    @EnvironmentObject var globalState : TicTacToeState
    var body: some View {

        Path(){ path in
            path.move(to: globalState.board.coords[globalState.winnerLine[0]])
            path.addLine(to: globalState.board.coords[globalState.winnerLine[2]])
        }
        .trim(from: 0, to: globalState.percentage) // << breaks path by parts, animatable
        .stroke(Color.purple, lineWidth: 8)
        .animation(.easeOut(duration: 0.5)) // << animate
        .onAppear {
            globalState.percentage = 1.0 // << activates animation for 0 to the end
        }
    }
}

