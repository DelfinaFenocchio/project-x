//
//  proyecto_xTests.swift
//  proyecto-xTests
//
//  Created by Delfina Fenocchio on 14/09/2021.
//

import XCTest
@testable import proyecto_x

class proyecto_xTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testIsVictoryFunction() {
        let state =  TicTacToeState()
        var board = state.board
            board.pressed = [.empty, .empty, CellState.playerX, .empty, CellState.playerX, .empty, CellState.playerX, .empty, .empty]
        let result = state.isVictory([2, 4, 6])
        print("board.pressed: ", board.pressed)
        print("result: ", result)
        XCTAssertTrue(result)
    }

}
