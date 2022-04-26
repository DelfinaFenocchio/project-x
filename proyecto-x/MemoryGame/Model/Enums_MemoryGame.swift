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

enum SecondsUInt64 : UInt64 {
    case half = 500_000_000
    case one = 1_000_000_000
    case one_and_a_half = 1_500_000_000
    case three_and_a_half = 3_500_000_000
}

enum SecondsFloat : Double {
    case half = 0.5
    case three_tenths = 0.3
}
