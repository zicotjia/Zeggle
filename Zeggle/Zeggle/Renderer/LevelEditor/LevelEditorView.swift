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

            guard position.y < DimensionsConstants.tappableMinY else {
                return
            }

            guard let color = levelEditorState.color else {
                return
            }

            let newItem = Peg(centre: PhysicsVector2D(centre: position), radius: itemRadius, color: color)

            gameLoop.level.addItem(zeggleItem: newItem)
        }
    }

    var body: some View {
        VStack {
            ZStack {
                LevelView(entities: gameLoop.level.items, levelEditorState: $levelEditorState)
                    .gesture(tapGesture)
                    .border(.black, width: 3)
            }
            ToolBarView(levelEditorState: $levelEditorState, radius: $itemRadius)
        }
    }
}

struct LevelDesignerView_Previews: PreviewProvider {

    static let previewPeg = Peg(centre: PhysicsVector2D(centre: CGPoint(x: 100, y: 100)), radius: 50, color: PegColor.orange)

    static let previewPeg2 = Peg(centre: PhysicsVector2D(centre: CGPoint(x: 100, y: 200)), radius: 50, color: PegColor.blue)

    static var previews: some View {
        LevelEditorView(levelEditorState: .constant(LevelEditorStates.off), itemRadius: 10)
    }
}
