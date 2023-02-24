import SwiftUI

struct AddOrangePegButtonView: View {
    @Binding var levelEditorState: LevelEditorStates
    var itemType: ItemType = .orangePeg

    func handleClick() {
        if levelEditorState == LevelEditorStates.item(value: .orangePeg) {
            levelEditorState = LevelEditorStates.off
        } else {
            levelEditorState = LevelEditorStates.item(value: .orangePeg)
        }
    }

    var body: some View {
        Button {
            handleClick()
        } label: {
            Image("peg-orange").resizable()
                .frame(width: ButtonConstants.radius * 2, height: ButtonConstants.radius * 2)
                .opacity(levelEditorState == LevelEditorStates.item(value: .orangePeg)
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
