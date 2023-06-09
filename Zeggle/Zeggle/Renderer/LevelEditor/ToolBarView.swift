//
//  ToolBarView.swift
//  Peggle
//
//  Created by Zico on 22/1/23.
//

import SwiftUI

struct ToolBarView: View {
    @Binding var levelEditorState: LevelEditorStates
    @Binding var radius: CGFloat

    var body: some View {
        HStack {
            VStack(spacing: 0) {
                MenuButtonsView()
                LevelEditorButtonView(levelEditorState: $levelEditorState, radius: $radius)
                    .background(Color.brown).frame(maxHeight: .infinity)
            }.frame(width: DimensionsConstants.rightWall, height: DimensionsConstants.toolBarHeight)
        }

    }
}

struct ToolBarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolBarView(levelEditorState: .constant(LevelEditorStates.off), radius: .constant(50))
    }
}
