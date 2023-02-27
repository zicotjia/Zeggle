import SwiftUI

struct AddItemButtonView: View {
    @Binding var levelEditorState: LevelEditorStates
    var itemType: ItemType

    func handleClick() {
        if levelEditorState == LevelEditorStates.item(value: itemType) {
            levelEditorState = LevelEditorStates.off
        } else {
            levelEditorState = LevelEditorStates.item(value: itemType)
        }
    }

    var body: some View {
        Button {
            handleClick()
        } label: {
            Image(itemType.rawValue).resizable()
                .frame(width: ButtonConstants.radius * 2, height: ButtonConstants.radius * 2)
                .opacity(levelEditorState == LevelEditorStates.item(value: itemType)
                         ? ButtonConstants.fullOpacity
                         : ButtonConstants.onDragOpacity)
        }

    }
}

struct AddItemButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemButtonView(levelEditorState: .constant(LevelEditorStates.off), itemType: .bluePeg)
    }
}
