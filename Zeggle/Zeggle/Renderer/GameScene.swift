//
//  GameScene.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//

import SwiftUI

struct GameScene: View {
    @StateObject var gameLoop: GameLoop

    var body: some View {
        ZStack {
            BackgroundView()
            GameItemListView(entities: gameLoop.level.items).environmentObject(gameLoop)
            CannonView().environmentObject(gameLoop)
        }
    }
}

struct GameScene_Previews: PreviewProvider {

    static let ball = Ball(centre: PhysicsVector2D(horizontal: 300, vertical: 50), hSpeed: 0, vSpeed: 0)

    static let peg = Peg(centre: PhysicsVector2D(horizontal: 200, vertical: 300), color: .orange)

    static let level = Level(zeggleItems: [ball, peg])
    static var previews: some View {
        GameScene(gameLoop: GameLoop(level: level))
    }
}
