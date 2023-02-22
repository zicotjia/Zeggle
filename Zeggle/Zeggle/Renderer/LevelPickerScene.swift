//
//  LevelPickerView.swift
//  Zeggle
//
//  Created by Zico on 22/2/23.
//

import SwiftUI

struct LevelPickerScene: View {
    @EnvironmentObject var gameLoop: GameLoop

    var body: some View {
        Button(action: {gameLoop.startGame()}, label: {
           Text("Click")
        })
    }
}

struct LevelPickerView_Previews: PreviewProvider {
    static var previews: some View {
        LevelPickerScene()
    }
}
