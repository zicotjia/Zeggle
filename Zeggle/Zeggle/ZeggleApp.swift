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
            GameView(gameLoop: GameLoop(level: SampleLevel.level))
                .onAppear {
                    MyMusicPlayer.sharedInstance
                }
        }
    }
}
