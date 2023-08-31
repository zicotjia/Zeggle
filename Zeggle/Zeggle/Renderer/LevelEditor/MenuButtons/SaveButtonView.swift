import SwiftUI

struct SaveButtonView: View {
    @EnvironmentObject var levelListViewModel: LevelListViewModel
    @EnvironmentObject var gameLoop: GameLoop

    var body: some View {
        Button("Save") {
            levelListViewModel.updateLevel(level: gameLoop.level)
        }.foregroundColor(.black)
    }
}

struct SaveButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SaveButtonView().environmentObject(LevelListViewModel())
    }
}
