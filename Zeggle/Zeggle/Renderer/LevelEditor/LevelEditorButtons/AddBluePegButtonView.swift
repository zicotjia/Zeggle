import SwiftUI

struct AddBluePegButtonView: View {
    @Binding var levelEditorState: LevelEditorStates
    var itemType: ItemType = .bluePeg

    func handleClick() {
        if levelEditorState == LevelEditorStates.item(value: .bluePeg) {
            levelEditorState = LevelEditorStates.off
        } else {
            levelEditorState = LevelEditorStates.item(value: .bluePeg)
        }
    }

    var body: some View {
        Button {
            handleClick()
        } label: {
            Image("peg-blue").resizable()
                .frame(width: ButtonConstants.radius * 2, height: ButtonConstants.radius * 2)
                .opacity(levelEditorState == LevelEditorStates.item(value: .bluePeg)
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
