import SwiftUI

struct LevelEditorView: View {

    @Binding var levelEditorState: LevelEditorStates
    @EnvironmentObject private var gameLoop: GameLoop
    @EnvironmentObject var levelListViewModel: LevelListViewModel
    @State var newItems: [ZeggleItem] = []
    @State var itemRadius = PegConstants.radius

    var tapGesture: some Gesture {
        DragGesture(minimumDistance: 0).onEnded { value in
            guard levelEditorState != LevelEditorStates.off
                    || levelEditorState != LevelEditorStates.deletePeg else {
                return
            }

            let position = value.location

            let low = position.y - itemRadius
            let high = position.y + itemRadius

            guard high < DimensionsConstants.tappableMaxY
                    && low > DimensionsConstants.tappableMinY else {
                return
            }

            guard let itemType = levelEditorState.itemType else {
                return
            }

            let newItem = GameItemFactory.createItem(itemType: itemType, centre: position, radius: itemRadius)

            gameLoop.level.addItem(zeggleItem: newItem)
        }
    }

    var body: some View {

        VStack(spacing: 0) {
            Spacer()
            ZStack {
                LevelView(entities: gameLoop.level.items, levelEditorState: $levelEditorState)
                    .gesture(tapGesture)
                    .frame(height: DimensionsConstants.tappableLevelHeight, alignment: .bottom)
            }
            ToolBarView(levelEditorState: $levelEditorState, radius: $itemRadius)
        }

    }
}

struct LevelDesignerView_Previews: PreviewProvider {

    static let previewPeg = Peg(centre: PhysicsVector2D(centre: CGPoint(x: 100, y: 100)), radius: 50,
                                color: PegColor.orange)

    static let previewPeg2 = Peg(centre: PhysicsVector2D(centre: CGPoint(x: 100, y: 200)), radius: 50,
                                 color: PegColor.blue)

    static var previews: some View {
        LevelEditorView(levelEditorState: .constant(LevelEditorStates.off), itemRadius: 10)
    }
}
