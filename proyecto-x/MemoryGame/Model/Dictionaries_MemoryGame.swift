//
//  DictionariesMemoryGame.swift
//  proyecto-x
//
//  Created by Lisbaldy de Jesus on 22/03/2022.
//

import Foundation
import SwiftUI

let PrevisualizationTimeValuePoints : [Int : Int] = [
    3: 15,
    5: 10,
    8: 5
]

let CardAmountValuePoints : [GameModeMemoryGame : [Int:Int]] = [
    .sequential: [6:5, 9:10, 12:20],
    .classicSinglePlayer : [6:5, 12:10, 16:30],
    .classicMultiPlayer : [6:5, 12:10, 16:30],
]

let LivesAmountValuePoints : [Int : Int] = [
    2: 90,
    4: 60,
    6: 30
]

let CardAmountOptions : [GameModeMemoryGame : [Int : Int]] = [
    //TODO: Cambiar el 2 a 6
    .sequential : [ 1:2 , 2:9, 3:12 ],
    .classicSinglePlayer : [ 1:8 , 2:12, 3:16 ],
    .classicMultiPlayer : [ 1:8 , 2:12, 3:16 ],
]

let ColumnsByGameMode : [GameModeMemoryGame : [GridItem]] = [
    .sequential: [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ],
    .classicSinglePlayer: [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ],
    .classicMultiPlayer: [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
]
