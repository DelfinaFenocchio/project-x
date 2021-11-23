//
//  ContentView.swift
//  Test03
//
//  Created by Rodolfo.Iribarren on 14/09/2021.
//

import SwiftUI

let initialBoardPlayability : [CellState] = [.empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty, .empty]

struct BoardStruct {
    var pressed = initialBoardPlayability
    
    var coords : [CGPoint] = [CGPoint(x: 216.0, y: 91.0), CGPoint(x: 216.0, y: 91.0), CGPoint(x: 216.0, y: 91.0), CGPoint(x: 216.0, y: 91.0), CGPoint(x: 216.0, y: 91.0), CGPoint(x: 216.0, y: 91.0), CGPoint(x: 216.0, y: 91.0), CGPoint(x: 216.0, y: 91.0), CGPoint(x: 216.0, y: 91.0)]
    
    mutating func setCoords(index : Int, point: CGPoint){
        coords[index] = point
    }
}

class TicTacToeState : ObservableObject {
    @Published var board : BoardStruct = BoardStruct()
    @Published var playerXTurn : Bool = true
    @Published var GameStateProperty : GameState = GameState.active
}

struct MainView: View {
    @StateObject var mainViewState : TicTacToeState = TicTacToeState()
    @State private var percentage: CGFloat = .zero
    @State var gameMode : GameMode = .notSelectedMode
    @State var index : Int = .zero
    
    let possibleWinnerLines : [[Int]] = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6]
    ]
    
    @State var winnerLine : [Int] = []
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible())]
    
    var body: some View {
        
        ZStack {
            Color(red: 111/255, green: 156/255, blue: 235/255)
                .ignoresSafeArea()
       // Image("wallpapertictactoe").resizable().ignoresSafeArea()
            VStack {
                
                VStack {
                    Spacer()
                    
                    Text("Tic Tac Toe")
                        .fontWeight(.bold)
                        .font(.system(.title))
                        .padding()
                        .customTextStyle()
                    
                    Spacer()
                    
                    GameOverView(GameStateProperty : mainViewState.GameStateProperty)
                    
                    if mainViewState.GameStateProperty != GameState.active
                    {
                        Spacer()
                        
                        Button("Reiniciar el juego") {
                            self.resetGame()
                        }
                    }
                    
                    TurnView(playerXTurn : mainViewState.playerXTurn, GameStateProperty: mainViewState.GameStateProperty)
                    
                    Spacer()
                    
                    if(gameMode == .notSelectedMode) {
                        Text("Elegí el modo de juego")
                            .fontWeight(.bold)
                            .font(.system(.title))
                            .padding()
                            .customTextStyle()

                        Button("1 jugador") {
                            setGameMode(mode: .singlePlayer)
                        }
                        Button("2 jugadores") {
                            setGameMode(mode: .multiPlayer)
                        }
                    }
                }
                Spacer()
                
                ZStack {
                    LazyVGrid(columns: columns, spacing: 5) {
                            while(index<9) {
                                index+=1
                                
                                Cell(playability : $mainViewState.board.pressed[index], index: index)
                                    .onChange(of: mainViewState.board.pressed, perform: { value in
                                        inner: for (possibleWinnerLine) in possibleWinnerLines {
                                                                                                
                                                if isVictory(possibleWinnerLine) {
                                                    mainViewState.GameStateProperty = mainViewState.playerXTurn ? GameState.playerOWin :
                                                        GameState.playerXWin
                                                    
                                                    winnerLine = possibleWinnerLine
                                                    
                                                    // Investigar como interrumpir este loop.
                                                    print("WIIIIINNNNNNN \(index)")
                                                    break
                                                }
                                                else {
                                                    if (!mainViewState.board.pressed.contains(CellState.empty)){
                                                        mainViewState.GameStateProperty = GameState.draw
                                                    } else {
                                                        if(!mainViewState.playerXTurn && gameMode == .singlePlayer){
                                                            //TO DO: Choose to play PvP or PvC
                                                            print("antes: \(mainViewState.playerXTurn)")
                                                            automaticPlay()
                                                            print("despues: \(mainViewState.playerXTurn)")
                                                        }
                                                    }
                                                }
                                            }
                                        })
                                        .overlay(
                                            GeometryReader { geometry in
                                                Color.clear
                                                    .onAppear{
                                                        //TODO: Save prettier coordinates
                                                        let frame = geometry.frame(in: .named("board"))
                                                        let point = CGPoint(x: frame.midX, y: frame.midY)
                                                        mainViewState.board.setCoords(index: index, point: point)
                                                    }
                                            }
                                        )
                            }
                    }
                    .customCellContainerStyle()
                    .coordinateSpace(name: "board")
                    
                    
                    if mainViewState.GameStateProperty == GameState.playerXWin || mainViewState.GameStateProperty == GameState.playerOWin{
                        VictoryAnimatedLine(percentage: $percentage, winnerLine: winnerLine)
                    }
                }
            }
            .environmentObject(mainViewState)
        }
    }
    
    func automaticPlay() -> Void {
        //TO DO: Select difficulty
        var emptyCellIndexes : [Int] = []
        
        for (index, cell) in mainViewState.board.pressed.enumerated() {
            if cell == CellState.empty {
                emptyCellIndexes.append(index)
          }
        }

        if let randomEmptyCellIndex = emptyCellIndexes.randomElement() {
            //TO DO: delay this action and prevent user from playing while it's the computer's turn
                mainViewState.board.pressed[randomEmptyCellIndex] = CellState.playerO
                mainViewState.playerXTurn.toggle()
        }
    }
    
    func resetGame() -> Void {
        mainViewState.board.pressed = initialBoardPlayability
        mainViewState.playerXTurn = true
        mainViewState.GameStateProperty = GameState.active
        percentage = .zero
        gameMode = .notSelectedMode
    }
    
    func isVictory(_ winnerLine: [Int]) -> Bool {
        return mainViewState.board.pressed[winnerLine[0]] == mainViewState.board.pressed[winnerLine[1]] && mainViewState.board.pressed[winnerLine[0]] == mainViewState.board.pressed[winnerLine[2]] && mainViewState.board.pressed[winnerLine[0]] != CellState.empty
    }
    
    func setGameMode(mode : GameMode) -> Void {
        gameMode = mode
        print("game mode: \(gameMode)")
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
