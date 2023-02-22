//
//  GameView.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//

import SwiftUI

struct GameView: View {
    @StateObject var gameLoop: GameLoop

    var body: some View {
        ZStack {
            if gameLoop.state == .levelPicker {
                LevelPickerScene().environmentObject(gameLoop)
            } else {
                GameScene().environmentObject(gameLoop)
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {

    static let gameLoop =  GameLoop(level: Level(zeggleItems: []))

    static var previews: some View {
        GameView(gameLoop: gameLoop)
    }
}
