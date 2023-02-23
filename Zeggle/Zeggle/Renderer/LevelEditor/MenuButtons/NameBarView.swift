import SwiftUI

struct NameBarView: View {

    @EnvironmentObject var gameLoop: GameLoop
    @State private var newName = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        TextField(gameLoop.level.name == "" ? "Level Name" : gameLoop.level.name,
                  text: $newName)
        .onSubmit {
            gameLoop.renameLevel(newName: newName)
        }
        .focused($isFocused)
        .onChange(of: isFocused) { _ in
            gameLoop.renameLevel(newName: newName)
        }

    }
}

struct NameBarView_Previews: PreviewProvider {
    static var previews: some View {
        NameBarView()
    }
}
