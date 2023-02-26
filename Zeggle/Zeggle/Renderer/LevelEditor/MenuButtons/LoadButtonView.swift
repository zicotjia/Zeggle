//
//  LoadButtonView.swift
//  Peggle
//
//  Created by Zico on 28/1/23.
//

import SwiftUI

struct LoadButtonView: View {
    @State var loadLevelSelection = false
    @EnvironmentObject var levelListViewModel: LevelListViewModel
    @EnvironmentObject var gameLoop: GameLoop

    var body: some View {
        Button("Load") {
            gameLoop.changeState(state: .levelPicker)
        }
    }
}

struct LoadButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LoadButtonView().environmentObject(LevelListViewModel())
    }
}
