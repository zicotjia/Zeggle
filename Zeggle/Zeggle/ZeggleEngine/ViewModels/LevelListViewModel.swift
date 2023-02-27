import Foundation

class LevelListViewModel: ObservableObject {

    @Published var sampleLevels: [Level]
    @Published var levels: [Level]

    init() {
        sampleLevels = SampleLevel.generateSampleLevels()
        levels = []
    }

    func getLevelsFromDB() {
        sampleLevels = SampleLevel.generateSampleLevels()
        levels = []

        let names = sampleLevels.map {$0.name}
        for level in Database.getLevelsWithPegs() {
            if names.contains(level.name) {
                continue
            }
            levels.append(level)
        }

    }

    func updateLevel(level: Level) {
        Database.updateLevelAndPegsToDB(level: level)
        for sampleLevel in sampleLevels where sampleLevel.name == level.name {
            return
        }
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
