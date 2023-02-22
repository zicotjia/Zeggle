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
            Text("\(Int(gameLoop.time))")
            Spacer()
        }
    }
}

struct GameDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailsView()
    }
}
