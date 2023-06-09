import Foundation
import SQLite

class Database {
    static let database = Database().connection

    static let databaseName = "peggleDB.sqlite3"

    static let levels = Table("Levels")

    private var connection: Connection?

    private init() {
        connection = openConnection()
        createTables()
    }

    private func openConnection() -> Connection? {
        do {
            let docDir = try FileManager.default.url(for: .documentDirectory,
                                                     in: .userDomainMask,
                                                     appropriateFor: nil,
                                                     create: true)
                .appendingPathComponent(Database.databaseName)
            let connection = try Connection(docDir.path)
            print("SQLiteDataStore init successfully at: \(docDir.path) ")
            return connection
        } catch {
            print("SQLiteDataStore init error: \(error)")
        }
        return nil
    }

    private func createLevelTable() {
        do {
            let query = """
                        CREATE TABLE IF NOT EXISTS Levels (
                            name TEXT PRIMARY KEY,
                            numberOfBalls Double,
                            numberOfSpookyBalls Double
                        );
                        """

            _ = try connection?.run(query)

        } catch {
            print(error)
        }
    }

    private func createPegsTable() {
        do {
            let query = """
                        CREATE TABLE IF NOT EXISTS Pegs (
                            xPos        Float,
                            yPos        Float,
                            radius      Float,
                            color       TEXT,
                            levelName   TEXT REFERENCES Levels(name) ON UPDATE CASCADE ON DELETE CASCADE,
                            PRIMARY KEY (xPos, yPos, radius, levelName)
                        );
                        """
            _ = try connection?.run(query)
        } catch {
            print(error)
        }
    }

    private func createTables() {
        createLevelTable()
        createPegsTable()
    }

    private static func isLevelsTableEmpty() -> Bool {
        do {
            let count = try database?.scalar(levels.count)
            return count == 0
        } catch {
            print(error)
        }

        return false
    }

    private static func getLevelNames() -> [String] {
        do {
            let query = "SELECT name FROM Levels;"

            guard let queryRows = try database?.prepare(query) else {
                return []
            }

            var names: [String] = []
            for row in queryRows {
                guard let name = row[0] as? String else {
                    continue
                }
                names.append(name)
            }

            return names
        } catch {
            print(error)
        }

        return []
    }

    private static func getLevelsPegs(levelName: String) -> Set<Peg> {

        func getColorSelectionsFromString(str: String) -> PegColor? {
            switch str {
            case "blue":
                return PegColor.blue
            case "orange":
                return PegColor.orange
            case "zombie":
                return PegColor.zombie
            case "pink":
                return PegColor.pink
            case "yellow":
                return PegColor.yellow
            case "red":
                return PegColor.red
            default:
                return nil
            }
        }

        do {
            let query = "SELECT xPos, yPos, radius, color FROM Pegs Where levelName = ?"

            let preparedQuery = try database?.prepare(query)

            guard let queryRows = try preparedQuery?.run(levelName) else {
                return []
            }

            var pegs: Set<Peg> = []

            for row in queryRows {
                guard let XPos = row[0] as? Double,
                      let YPos = row[1] as? Double,
                      let radius = row[2] as? Double,
                      let colorString = row[3] as? String else {
                    return []
                }

                guard let color = getColorSelectionsFromString(str: colorString) else {
                    continue
                }

                let centre = PhysicsVector2D(centre: CGPoint(x: XPos, y: YPos))

                let peg = Peg(centre: centre, radius: radius, color: color)
                pegs.insert(peg)
            }
            return pegs
        } catch {
            print(error)
        }
        return []
    }

    static func getLevelWithName(name: String) -> Level {
        let pegs = getLevelsPegs(levelName: name)

        do {
            let query = "SELECT numberOfBalls, numberOfSpookyBalls FROM Levels WHERE name = ?;"

            let preparedQuery = try database?.prepare(query)

            guard let queryRows = try preparedQuery?.run(name) else {
                return Level(zeggleItems: [])
            }

            var numberOfBalls = 5
            var numberOfSpookyBalls = 5
            for row in queryRows {
                guard let noOfBalls = row[0] as? Double,
                      let noOfSpookyBalls = row[1] as? Double else {
                    continue
                }
                numberOfBalls = Int(noOfBalls)
                numberOfSpookyBalls = Int(noOfSpookyBalls)
            }
            let level = Level(name: name, zeggleItems: pegs)
            level.setNumberOfBall(to: numberOfBalls)
            level.setNumberOfSpookyBall(to: numberOfSpookyBalls)
            return level
        } catch {
            print(error)
        }

        return Level(zeggleItems: [])
    }

    static func getLevelsWithPegs() -> [Level] {

        guard !isLevelsTableEmpty() else {
            return []
        }

        var levels: [Level] = []

        for levelName in getLevelNames() {
            if levelName == "" {
                continue
            }
            let level = getLevelWithName(name: levelName)
            levels.append(level)
        }

        return levels
    }

    private static func saveLevelIntoDB(level: Level) {
        do {
            let query = "INSERT INTO Levels VALUES (?, ?, ?);"

            let preparedQuery = try database?.prepare(query)

            try preparedQuery?.run(level.name, level.numberOfStandardBalls, level.numberOfSpookyBalls)
        } catch {
            print(error)
        }
    }

    private static func savePegsOfLevelIntoDB(level: Level) {

        func getColorStringFromColorSelections(pegColor: PegColor) -> String {
            switch pegColor {
            case .orange:
                return "orange"
            case .blue:
                return "blue"
            case .zombie:
                return "zombie"
            case .red:
                return "red"
            case .yellow:
                return "yellow"
            case .pink:
                return "pink"
            }
        }

        let levelName = level.name

        do {
            let query = "INSERT INTO Pegs VALUES (?, ?, ?, ?, ?)"

            let preparedQuery = try database?.prepare(query)

            for item in level.items {
                guard let peg = item as? Peg else {
                    continue
                }
                let colorString = getColorStringFromColorSelections(pegColor: peg.color)
                try preparedQuery?.run(Double(peg.physicsBody.centre.hVector.magnitude),
                                       Double(peg.physicsBody.centre.vVector.magnitude),
                                       Double(peg.physicsBody.radius.magnitude),
                                       colorString, levelName)
            }
        } catch {
            print(error)
        }
    }

    static func saveLevelAndPegsIntoDB(level: Level) {
        saveLevelIntoDB(level: level)
        savePegsOfLevelIntoDB(level: level)
    }

    private static func deleteLevelFromDB(level: Level) {
        do {
            let query = "DELETE FROM Levels WHERE name = ?;"

            let preparedQuery = try database?.prepare(query)

            try preparedQuery?.run(level.name)

        } catch {
            print(error)
        }
    }

    private static func deletePegsFromDB(level: Level) {
        do {
            let query = "DELETE FROM Pegs WHERE levelName = ?"

            let preparedQuery = try database?.prepare(query)

            try preparedQuery?.run(level.name)
        } catch {
            print(error)
        }
    }

    private static func deleteLevelAndPegsFromDB(level: Level) {
        deletePegsFromDB(level: level)
        deleteLevelFromDB(level: level)
    }

    static func updateLevelAndPegsToDB(level: Level) {
        deleteLevelAndPegsFromDB(level: level)
        saveLevelAndPegsIntoDB(level: level)
    }

    static func changeNameOfLevel(level: Level, newName: String) {
        do {
            let query = "UPDATE Levels SET name = (?) WHERE name = (?)"

            let preparedQuery = try database?.prepare(query)

            try preparedQuery?.run(newName, level.name)
        } catch {
            print(error)
        }
    }

    func dropAll() {
        let query = "DROP TABLE Pegs;"
        let query2 = "DROP TABLE Levels;"
        do {
            try connection?.run(query)
            try connection?.run(query2)
            print("Dropped Everything")
        } catch {
            print(error)
        }
    }

}
