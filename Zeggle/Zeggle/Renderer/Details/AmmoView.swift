//
//  AmmoView.swift
//  Zeggle
//
//  Created by Zico on 25/2/23.
//

import SwiftUI

struct AmmoView: View {
    @EnvironmentObject var gameLoop: GameLoop

    var body: some View {
        HStack {
            HStack {
                Image(ImageNameToFile.ball)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .opacity(gameLoop.getAmmoType() == .standard ? 1.0 : 0.3)
                    .onTapGesture {
                        gameLoop.switchAmmoType(to: .standard)
                    }
                Text("x \(gameLoop.getNumberOfBallsLeft())")
            }

            HStack {
                Image(ImageNameToFile.spooky)
                    .resizable()
                    .frame(width: 50, height: 50)
                    .opacity(gameLoop.getAmmoType() == .spooky ? 1.0 : 0.3)
                    .onTapGesture {
                        gameLoop.switchAmmoType(to: .spooky)
                    }
                Text("x \(gameLoop.getNumberOfSpookyBalls())")
            }
        }
    }
}

struct AmmoView_Previews: PreviewProvider {
    static var previews: some View {
        AmmoView()
    }
}
