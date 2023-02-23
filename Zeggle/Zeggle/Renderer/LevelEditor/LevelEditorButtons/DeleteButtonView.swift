import SwiftUI

struct DeleteButtonView: View {
    @Binding var levelEditorState: LevelEditorStates

    func handleClick() {
        if levelEditorState == LevelEditorStates.deletePeg {
            levelEditorState = LevelEditorStates.off
        } else {
            levelEditorState = LevelEditorStates.deletePeg
        }
    }

    var body: some View {
        Button {
            handleClick()
        } label: {
            Image("delete").resizable()
                .frame(width: ButtonConstants.radius * 2, height: ButtonConstants.radius * 2)
                .opacity(levelEditorState == LevelEditorStates.deletePeg
                         ? ButtonConstants.fullOpacity
                         : ButtonConstants.onDragOpacity)
        }

    }
}
