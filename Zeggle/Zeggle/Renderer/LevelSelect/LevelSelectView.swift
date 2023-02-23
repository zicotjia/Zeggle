import SwiftUI

struct LevelSelectView: View {
    @EnvironmentObject var levelListViewModel: LevelListViewModel
    @EnvironmentObject var gameLoop: GameLoop

    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                ScrollView(.vertical) {
                    LazyVGrid(columns: [GridItem(.flexible())]) {
                        ForEach(levelListViewModel.sampleLevels, id: \.self.name) { level in
                            LevelWindowView(level: level)
                                .frame(width:
                                        LevelSelectionConstants.miniLevelWidth,
                                       height:
                                        LevelSelectionConstants.miniLevelHeight)
                                .onTapGesture {
                                    gameLoop.switchLevel(level: level)
                                    gameLoop.enterLevelEditor()
                                }

                        }
                        ForEach(levelListViewModel.levels, id: \.self.name) { level in
                            LevelWindowView(level: level)
                                .frame(width:
                                        LevelSelectionConstants.miniLevelWidth,
                                       height:
                                        LevelSelectionConstants.miniLevelHeight)
                                .onTapGesture {
                                    gameLoop.switchLevel(level: level)
                                    gameLoop.startGame()
                                }
                        }
                    }
                }
            }
        }.onAppear {
            levelListViewModel.getLevelsFromDB()
        }
   }
}

struct LevelSelectView_Previews: PreviewProvider {

    static var previews: some View {
        LevelSelectView().environmentObject(LevelListViewModel())
    }
}
