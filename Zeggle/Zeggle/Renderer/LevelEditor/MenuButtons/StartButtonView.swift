import SwiftUI

struct StartButtonView: View {
    @EnvironmentObject var gameLoop: GameLoop
    @EnvironmentObject var levelListViewModel: LevelListViewModel
    @State var gameMode = GameMode.standard

    var body: some View {
        HStack(spacing: 0) {
            Picker("Game Mode", selection: $gameMode) {
                ForEach(GameMode.allCases) { gameMode in
                    Text(gameMode.rawValue).truncationMode(.tail)
                }
                .onChange(of: gameMode) { _ in
                    gameLoop.changeGameMode(gameMode: gameMode)
                }
            }
            .frame(minWidth: DimensionsConstants.deviceWidth * 0.2, maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.pink)
            .foregroundColor(.black)
            Button("Start") {
                levelListViewModel.updateLevel(level: gameLoop.level)
                gameLoop.startGame()
            }
            .frame(minWidth: DimensionsConstants.deviceWidth * 0.1, maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.purple)
            .foregroundColor(.black)
        }
    }
}

struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView()
    }
}
