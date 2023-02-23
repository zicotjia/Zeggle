import SwiftUI

struct LevelEditorView: View {

    @Binding var levelEditorState: LevelEditorStates
    @EnvironmentObject private var gameLoop: GameLoop

    var tapGesture: some Gesture {
        DragGesture(minimumDistance: 0).onEnded { value in
            guard levelEditorState != LevelEditorStates.off
                    || levelEditorState != LevelEditorStates.deletePeg else {
                return
            }

            let position = value.location

            guard let color = levelEditorState.color else {
                return
            }

            let newItem = Peg(centre: PhysicsVector2D(centre: position), radius: PegConstants.radius, color: color)

            gameLoop.level.addItem(zeggleItem: newItem)
            print("added Item")
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                LevelView(entities: gameLoop.level.items, levelEditorState: $levelEditorState)
                    .gesture(tapGesture)

                ToolBarView(levelEditorState: $levelEditorState)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LevelDesignerView_Previews: PreviewProvider {

    static let previewPeg = Peg(centre: PhysicsVector2D(centre: CGPoint(x: 100, y: 100)), radius: 50, color: PegColor.orange)

    static let previewPeg2 = Peg(centre: PhysicsVector2D(centre: CGPoint(x: 100, y: 200)), radius: 50, color: PegColor.blue)

    static var previews: some View {
        LevelEditorView(levelEditorState: .constant(LevelEditorStates.off))
    }
}
