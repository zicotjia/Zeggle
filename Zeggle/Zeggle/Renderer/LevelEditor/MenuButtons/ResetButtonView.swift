import SwiftUI

struct ResetButtonView: View {
    @EnvironmentObject var gameLoop: GameLoop

    var body: some View {
        Button("Reset") {
            gameLoop.resetLevel()
        }
    }
}

struct ResetButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ResetButtonView()
    }
}
