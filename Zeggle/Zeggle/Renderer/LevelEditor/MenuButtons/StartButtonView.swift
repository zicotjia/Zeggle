import SwiftUI

struct StartButtonView: View {
    @EnvironmentObject var gameLoop: GameLoop
    @EnvironmentObject var levelListViewModel: LevelListViewModel
    @State var gameMode = GameMode.standard

    var body: some View {
        VStack {
            Button("Start") {
                levelListViewModel.updateLevel(level: gameLoop.level)
                gameLoop.startGame()
            }
            Picker("Game Mode", selection: $gameMode) {
                ForEach(GameMode.allCases) { gameMode in
                    Text(gameMode.rawValue)
                }
                .onChange(of: gameMode) { _ in
                    gameLoop.changeGameMode(gameMode: gameMode)
                }
            }
        }.frame(minWidth: 100)
    }
}

struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView()
    }
}
