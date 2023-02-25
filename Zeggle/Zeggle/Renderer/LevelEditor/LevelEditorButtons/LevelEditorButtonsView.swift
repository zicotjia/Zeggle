import SwiftUI

struct LevelEditorButtonView: View {
    @Binding var levelEditorState: LevelEditorStates
    @Binding var radius: CGFloat
    @State var numberOfBalls = 0

    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 20)
                ForEach(ItemType.allCases) { item in
                    AddItemButtonView(levelEditorState: $levelEditorState, itemType: item)
                }
                Spacer()
                DeleteButtonView(levelEditorState: $levelEditorState)
                SizeSliderView(radius: $radius)
                Spacer().frame(width: 20)
            }
            HStack {
                AmmoPickerView()
            }
        }
    }
}

struct LevelEditorButton_Previews: PreviewProvider {
    static var previews: some View {
        LevelEditorButtonView(levelEditorState: .constant(.off), radius: .constant(20), numberOfBalls: 1)
    }
}
