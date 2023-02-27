//
//  ToggleMusicView.swift
//  Zeggle
//
//  Created by Zico on 26/2/23.
//

import SwiftUI

struct ToggleMusicView: View {
    @State private var isOn = false
    @EnvironmentObject var gameLoop: GameLoop

    var body: some View {
        VStack {
            Toggle("Music", isOn: $isOn)
                .onChange(of: isOn) { _ in
                    if isOn {
                        gameLoop.toggleMusicOn()
                    } else {
                        gameLoop.toggleMusicOff()
                    }
                }
        }.onAppear {
            isOn = gameLoop.level.isMusical
        }
    }
}

struct ToggleMusicView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleMusicView()
    }
}
