//
//  SampleLevelListView.swift
//  Zeggle
//
//  Created by Zico on 24/2/23.
//

import SwiftUI

struct SampleLevelListView: View {
    var sampleLevels: [Level]
    @EnvironmentObject var gameLoop: GameLoop

    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible())]) {
            ForEach(sampleLevels, id: \.self) { level in
                LevelWindowView(level: level)
                    .frame(width:
                            LevelSelectionConstants.miniLevelWidth,
                           height:
                            LevelSelectionConstants.miniLevelHeight)
                    .onTapGesture {
                        gameLoop.switchLevel(level: level)
                        gameLoop.enterLevelEditor()
                    }

            }
        }
    }
}

struct SampleLevelListView_Previews: PreviewProvider {
    static var previews: some View {
        SampleLevelListView(sampleLevels: [])
    }
}
