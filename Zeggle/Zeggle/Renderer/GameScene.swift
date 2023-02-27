//
//  GameScene.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//

import SwiftUI

struct GameScene: View {
    @EnvironmentObject var gameLoop: GameLoop

    var body: some View {
        let gameEnded = gameLoop.gameHasEnded()
        return VStack(spacing: 0) {
            Spacer()
                    ZStack {
                        BackgroundView()
                        VStack {
                            GameItemListView(entities: gameLoop.level.items).environmentObject(gameLoop)
                        }
                        CannonView().environmentObject(gameLoop)
                    }
                    GameDetailsView().environmentObject(gameLoop)

            }.alert(isPresented: .constant(gameEnded)) {
                Alert(title: Text(gameLoop.gameEndMessage()), message: Text("Do you want to replay?"),
                      primaryButton: Alert.Button.default(Text("No"), action: {
                        gameLoop.exitLevel()
                        }),
                      secondaryButton: Alert.Button.cancel(Text("Yes"), action: {
                        gameLoop.restart()
                        })
                )
            }.frame(width: DimensionsConstants.deviceWidth, height: DimensionsConstants.deviceHeight)

    }
}

struct GameScene_Previews: PreviewProvider {

    static let ball = Ball(centre: PhysicsVector2D(horizontal: 300, vertical: 50), hSpeed: 0, vSpeed: 0,
                           type: .standard)

    static let peg = Peg(centre: PhysicsVector2D(horizontal: 200, vertical: 300), radius: 50, color: .orange)

    static let level = Level(zeggleItems: [ball, peg])
    static var previews: some View {
        GameScene().environmentObject(GameLoop(level: level))
    }
}
