import SwiftUI

struct LevelSelectView: View {
    @EnvironmentObject var levelListViewModel: LevelListViewModel
    @EnvironmentObject var gameLoop: GameLoop

    var body: some View {
        ZStack {
            Image(ImageNameToFile.background)
                .resizable(resizingMode: .stretch)
            VStack {
                ScrollView(.vertical) {
                    SampleLevelListView(sampleLevels: levelListViewModel.sampleLevels)
                    LazyVGrid(columns: [GridItem(.flexible())]) {
                        ForEach(levelListViewModel.levels, id: \.self) { level in
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
                    }
                }
                Button("Create New Level") {
                    gameLoop.switchLevel(level: Level(zeggleItems: []))
                    gameLoop.enterLevelEditor()
                }
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .padding(.bottom, 20)
                .foregroundColor(.black)
            }
        }
   }
}

struct LevelSelectView_Previews: PreviewProvider {

    static var previews: some View {
        LevelSelectView().environmentObject(LevelListViewModel())
    }
}
