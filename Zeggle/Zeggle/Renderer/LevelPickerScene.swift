//
//  LevelPickerView.swift
//  Zeggle
//
//  Created by Zico on 22/2/23.
//

import SwiftUI

struct LevelPickerScene: View {
    @EnvironmentObject var gameLoop: GameLoop
    @EnvironmentObject var levelListViewModel: LevelListViewModel

    var body: some View {
        LevelSelectView()
            .environmentObject(gameLoop)
            .environmentObject(levelListViewModel)
            .onAppear {
                levelListViewModel.getLevelsFromDB()
            }
    }
}

struct LevelPickerView_Previews: PreviewProvider {
    static var previews: some View {
        LevelPickerScene()
    }
}
