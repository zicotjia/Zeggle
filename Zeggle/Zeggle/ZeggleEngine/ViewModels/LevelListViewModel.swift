import Foundation

class LevelListViewModel: ObservableObject {

    @Published var sampleLevels: [Level]
    @Published var levels: [Level]

    init() {
        sampleLevels = SampleLevel.generateSampleLevels()
        levels = []
    }

    func getLevelsFromDB() {
        levels = []
        levels.append(contentsOf: Database.getLevelsWithPegs())
    }

    func updateLevel(level: Level) {
        Database.updateLevelAndPegsToDB(level: level)
        getLevelsFromDB()
    }

    func resetLevel(level: Level) {
        let name = level.name
        let resettedLevel = Database.getLevelWithName(name: name)
        for (index, lvl) in levels.enumerated() where lvl.name == name {
            levels.remove(at: index)
            levels.insert(resettedLevel, at: index)
            break
        }
    }

    func isNameTaken(name: String) -> Bool {
        for level in levels where level.name == name {
            return true
        }
        return false
    }
}
