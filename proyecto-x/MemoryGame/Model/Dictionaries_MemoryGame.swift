//
//  DictionariesMemoryGame.swift
//  proyecto-x
//
//  Created by Lisbaldy de Jesus on 22/03/2022.
//

import Foundation

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
    .sequential : [ 1:6 , 2:9, 3:12 ],
    .classicSinglePlayer : [ 1:6 , 2:12, 3:16 ],
    .classicMultiPlayer : [ 1:6 , 2:12, 3:16 ],
]
