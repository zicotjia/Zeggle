import SwiftUI

struct AddOrangePegButtonView: View {
    @Binding var levelEditorState: LevelEditorStates

    func handleClick() {
        if levelEditorState == LevelEditorStates.addOrangePeg {
            levelEditorState = LevelEditorStates.off
        } else {
            levelEditorState = LevelEditorStates.addOrangePeg
        }
    }

    var body: some View {
        Button {
            handleClick()
        } label: {
            Image("peg-orange").resizable()
                .frame(width: ButtonConstants.radius * 2, height: ButtonConstants.radius * 2)
                .opacity(levelEditorState == LevelEditorStates.addOrangePeg
                         ? ButtonConstants.fullOpacity
                         : ButtonConstants.onDragOpacity)
        }

    }
}

struct AddOrangePegButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddOrangePegButtonView(levelEditorState: .constant(LevelEditorStates.off))
    }
}
