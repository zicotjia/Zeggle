//
//  GameView.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//

import SwiftUI

struct GameView: View {
    private(set) var scene: GameScene

    var body: some View {
        ZStack {
            scene
        }
    }
}

struct GameView_Previews: PreviewProvider {

    static let scene = GameScene(gameLoop: GameLoop(level: Level(zeggleItems: [])))

    static var previews: some View {
        GameView(scene: scene)
    }
}
