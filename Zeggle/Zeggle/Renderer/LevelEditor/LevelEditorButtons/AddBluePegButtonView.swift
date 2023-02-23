import SwiftUI

struct AddBluePegButtonView: View {
    @Binding var levelEditorState: LevelEditorStates

    func handleClick() {
        if levelEditorState == LevelEditorStates.addBluePeg {
            levelEditorState = LevelEditorStates.off
        } else {
            levelEditorState = LevelEditorStates.addBluePeg
        }
    }

    var body: some View {
        Button {
            handleClick()
        } label: {
            Image("peg-blue").resizable()
                .frame(width: ButtonConstants.radius * 2, height: ButtonConstants.radius * 2)
                .opacity(levelEditorState == LevelEditorStates.addBluePeg
                         ? ButtonConstants.fullOpacity
                         : ButtonConstants.onDragOpacity)
        }

    }
}

struct AddBlueButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddBluePegButtonView(levelEditorState: .constant(LevelEditorStates.off))
    }
}
