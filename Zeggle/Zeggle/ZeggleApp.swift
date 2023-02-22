//
//  ZeggleApp.swift
//  Zeggle
//
//  Created by Zico on 5/2/23.
//

import SwiftUI

@main
struct ZeggleApp: App {

    var body: some Scene {
        WindowGroup {
            GameView(scene: GameScene(gameLoop: GameLoop(level: SampleLevel.level)))

        }
    }
}
