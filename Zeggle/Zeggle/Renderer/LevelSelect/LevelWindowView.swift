import SwiftUI

struct LevelWindowView: View {

    var level: Level

    var body: some View {
        ZStack {
            LevelView(entities: level.items, levelEditorState: .constant(LevelEditorStates.off))
                .border(.pink, width: LevelWindowConstants.borderWidth)
                .scaleEffect(LevelWindowConstants.scaleRatio)
            Text(level.name).font(.system(size: LevelWindowConstants.textFontSize))
        }

    }
}

struct LevelWindowView_Previews: PreviewProvider {
    static var previews: some View {
        LevelWindowView(level: SampleLevel.createColorfulLevel())
    }
}
