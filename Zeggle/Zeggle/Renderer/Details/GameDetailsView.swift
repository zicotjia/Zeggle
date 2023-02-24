//
//  GameDetailsView.swift
//  Zeggle
//
//  Created by Zico on 22/2/23.
//

import SwiftUI

struct GameDetailsView: View {
    @EnvironmentObject var gameLoop: GameLoop

    var body: some View {
        HStack {
            Spacer()
            BallDetailsView(ballsLeft: .constant(gameLoop.getNumberOfBallsLeft()))
            Spacer()
            Text(gameLoop.level.gameMode is TimeAttack ||
                 gameLoop.level.gameMode is BeatTheScore ||
                 gameLoop.level.gameMode is DodgeBall
                 ? "\(Int(gameLoop.level.timer))"
                 : " ")
            Spacer()
            Text(gameLoop.level.gameMode is DodgeBall
                 ? " "
                 : "Score = \(gameLoop.level.score)")
            Spacer()
            if gameLoop.level.gameMode is BeatTheScore {
                Text("Target = \(gameLoop.level.target)")
                Spacer()
            }
        }
    }
}

struct GameDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailsView()
    }
}
