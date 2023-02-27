import SwiftUI

struct StartButtonView: View {
    @EnvironmentObject var gameLoop: GameLoop
    @EnvironmentObject var levelListViewModel: LevelListViewModel
    @State var gameMode = GameMode.standard

    var body: some View {
        HStack {
            Picker("Game Mode", selection: $gameMode) {
                ForEach(GameMode.allCases) { gameMode in
                    Text(gameMode.rawValue)
                }
                .onChange(of: gameMode) { _ in
                    gameLoop.changeGameMode(gameMode: gameMode)
                }
            }.frame(minWidth: 120)
            Button("Start") {
                levelListViewModel.updateLevel(level: gameLoop.level)
                gameLoop.startGame()
            }
        }
    }
}

struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView()
    }
}
