//
//  PlayArea.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//

import SwiftUI

struct BackgroundView: View {
    @EnvironmentObject var gameLoop: GameLoop
    @State private var showingAlert = false

    var body: some View {
        ZStack {
            Image(ImageNameToFile.background)
                .resizable(resizingMode: .stretch)
                .ignoresSafeArea()
            HStack {
                Text("\(gameLoop.level.ball?.physicsBody.centre.vVector.magnitude ?? 20)")
                Text("\(gameLoop.level.ball?.physicsBody.centre.hVector.magnitude ?? 20)")
            }
        }
    }
}

struct PlayArea_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
