import SwiftUI

struct LevelView: View {

    var entities: Set<ZeggleItem>
    @Binding var levelEditorState: LevelEditorStates

    var body: some View {
        ZStack {
            BackgroundView()
            ForEach(Array(entities), id: \.self) { entity in
                GameItemViewCreator.createItemView(item: entity, state: levelEditorState)
            }
        }.frame(width: DimensionsConstants.levelWidth, height: DimensionsConstants.levelHeight)
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView(entities: Set(), levelEditorState: .constant(.off))
    }
}
