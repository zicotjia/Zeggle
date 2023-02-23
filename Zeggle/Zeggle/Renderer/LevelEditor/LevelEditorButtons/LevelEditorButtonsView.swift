import SwiftUI

struct LevelEditorButtonView: View {
    @Binding var levelEditorState: LevelEditorStates

    var body: some View {
        HStack {
            AddBluePegButtonView(levelEditorState: $levelEditorState)
            AddOrangePegButtonView(levelEditorState: $levelEditorState)
            Spacer()
            DeleteButtonView(levelEditorState: $levelEditorState)
        }
    }
}

struct LevelEditorButton_Previews: PreviewProvider {
    static var previews: some View {
        LevelEditorButtonView(levelEditorState: .constant(.off))
    }
}
