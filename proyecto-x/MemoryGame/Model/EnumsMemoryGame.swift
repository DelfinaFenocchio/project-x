//
//  Enums.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 04/01/2022.
//

import Foundation

enum GameModeMemoryGame : String {
     case classicSinglePlayer
     case classicMultiPlayer
     case sequential
 }

enum PrevisualizationTime : Int {
     case seconds_3 = 3
     case seconds_5 = 5
     case seconds_8 = 8
 }

enum CardsAmount : Int {
    //TODO: Reemplazar 2 por 6 en la siguiente línea
     case amount_2 = 2
     case amount_8 = 8
     case amount_10 = 10
     case amount_12 = 12
}

enum GameStatusMemoryGame {
     case active
     case victory
     case defeated
     case inactive
 }

