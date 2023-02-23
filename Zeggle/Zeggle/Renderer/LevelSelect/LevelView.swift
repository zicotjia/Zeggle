import SwiftUI

struct LevelView: View {

    var entities: Set<ZeggleItem>
    @Binding var levelEditorState: LevelEditorStates
    

    var body: some View {
        ZStack {
            Image(ImageNameToFile.background)
                .resizable(resizingMode: .stretch)
                .ignoresSafeArea()
            ForEach(Array(entities), id: \.self) { entity in
                GameItemCreator.createItemView(item: entity)
            }
        }
    }
}

struct LevelView_Previews: PreviewProvider {
    static var previews: some View {
        LevelView(entities: Set(), levelEditorState: .constant(.off))
    }
}
