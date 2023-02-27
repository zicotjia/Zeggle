import SwiftUI

struct LevelEditorButtonView: View {
    @Binding var levelEditorState: LevelEditorStates
    @Binding var radius: CGFloat
    @State var numberOfBalls = 0

    var body: some View {
        HStack {
            VStack {
                HStack {
                    ForEach(ItemType.allCases) { item in
                        AddItemButtonView(levelEditorState: $levelEditorState, itemType: item)
                    }
                    DeleteButtonView(levelEditorState: $levelEditorState)
                }
                    AmmoPickerView()
                }
            SizeSliderView(radius: $radius, levelEditorState: $levelEditorState)
        }

    }
}

struct LevelEditorButton_Previews: PreviewProvider {
    static var previews: some View {
        LevelEditorButtonView(levelEditorState: .constant(.off), radius: .constant(20), numberOfBalls: 1)
    }
}
