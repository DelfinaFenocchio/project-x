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

//enum PrevisualizationTimeValuePoints : Int, CaseIterable {
//    case seconds_3 = 5
//    case seconds_5 = 10
//    case seconds_8 = 15
//}
//
//enum CardAmountValuePoints : Int, CaseIterable {
//    //TODO: Reemplazar 2 por 6 en la siguiente línea
//    case amount_2 = 5
//    case amount_8 = 10
//    case amount_10 = 15
//    case amount_12 = 20
//}
//
//enum LivesAmountValuePoints : Int, CaseIterable {
//    case amount_1 = 5
//    case amount_2 = 10
//    case amount_3 = 15
//}

