//
//  Cell.swift
//  proyecto-x
//
//  Created by Francisco Zapiola on 28/09/2021.
//

import SwiftUI

struct Cell: View {
    @State private var playability : cellState = cellState.green
    
    //To do: use ContentView state instead
    @State private var playerBlueTurn : Bool = true
    
    var body: some View {
        Rectangle()
            .frame(width: 90, height: 90)
            .foregroundColor(playability == cellState.green ? Color.green : playability == cellState.red ? Color.red : Color.blue)
            .onTapGesture(count: 1, perform: {
                if(self.playability == cellState.green){
                    setPlayability(newPlayabilityValue: self.playerBlueTurn ? cellState.blue : cellState.red)
                }
                //To do: alter turn state?
            })
    }
    
    public func toggleTurn() -> Void {
        self.playerBlueTurn = !self.playerBlueTurn
    }
    
    public func setPlayability(newPlayabilityValue: cellState) -> Void {
        self.playability = newPlayabilityValue
    }
}

struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell()
    }
}


