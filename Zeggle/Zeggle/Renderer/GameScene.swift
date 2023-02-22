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
        VStack {
            GameDetailsView().environmentObject(gameLoop)
            ZStack {
                BackgroundView().environmentObject(gameLoop)
                GameItemListView(entities: gameLoop.level.items).environmentObject(gameLoop)
                CannonView().environmentObject(gameLoop)
            }
        }.alert(isPresented: .constant(gameLoop.gameHasEnded())) {
            Alert(title: Text("Alert!"), message: Text("Message"),
                  primaryButton: Alert.Button.default(Text("Yes"), action: {
                    gameLoop.changeState(state: .levelPicker)
                    print("changed")
                    }),
                  secondaryButton: Alert.Button.cancel(Text("No"), action: {
                    print("No")
                    })
            )
        }

    }
}

struct GameScene_Previews: PreviewProvider {

    static let ball = Ball(centre: PhysicsVector2D(horizontal: 300, vertical: 50), hSpeed: 0, vSpeed: 0)

    static let peg = Peg(centre: PhysicsVector2D(horizontal: 200, vertical: 300), radius: 50, color: .orange)

    static let level = Level(zeggleItems: [ball, peg])
    static var previews: some View {
        GameScene().environmentObject(GameLoop(level: level))
    }
}
