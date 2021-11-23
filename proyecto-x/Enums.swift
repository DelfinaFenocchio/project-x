//
//  Enums.swift
//  proyecto-x
//
//  Created by Lisbaldy Ojeda on 05/10/2021.
//

import Foundation

enum CellState : String {
     case empty
     case playerX
     case playerO
 }

enum GameState : String {
     case active
     case draw
     case playerOWin
     case playerXWin
 }

enum GameMode : String {
    case singlePlayer
    case multiPlayer
    case notSelectedMode
 }
