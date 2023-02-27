//
//  AmmoPickerView.swift
//  Zeggle
//
//  Created by Zico on 24/2/23.
//

import SwiftUI

struct AmmoPickerView: View {
    @EnvironmentObject var gameLoop: GameLoop
    @State private var numberOfBalls = 1
    @State private var numberOfSpookyBalls = 1

    var body: some View {
        HStack {
            Spacer()
            HStack {
                HStack {
                    Image(ImageNameToFile.ball)
                        .resizable()
                        .frame(width: 50, height: 50)
                    Picker("Ammo Count", selection: $numberOfBalls) {
                        if numberOfBalls == 0 {
                            Text("\(gameLoop.getNumberOfBallsLeft())")
                        }
                        ForEach(1 ..< 21) { number in
                            Text("\(number)").tag(number)
                        }
                    }.onChange(of: numberOfBalls) { number in
                        gameLoop.setNumberOfBalls(to: number)
                    }
                }
                Text("\(gameLoop.getNumberOfBallsLeft())")
            }

            Spacer()
            HStack {
                HStack {
                    Image(ImageNameToFile.spooky)
                        .resizable()
                        .frame(width: 50, height: 50)
                    Picker("Ammo Count", selection: $numberOfSpookyBalls) {
                        if numberOfBalls == 0 {
                            Text("\(gameLoop.getNumberOfSpookyBalls())")
                        }
                        ForEach(1 ..< 21) { number in
                            Text("\(number)").tag(number)
                        }
                    }.onChange(of: numberOfSpookyBalls) { number in
                        gameLoop.setNumberOfSpookyBalls(to: number)
                    }

                }
                Text("\(gameLoop.getNumberOfSpookyBalls())")
            }

            Spacer()

        }

    }
}

struct AmmoPickerView_Previews: PreviewProvider {
    static var previews: some View {
        AmmoPickerView()
    }
}
