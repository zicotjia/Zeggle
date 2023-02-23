import Combine

class LevelViewModel: ObservableObject {
    @Published private(set) var level: Level

    init() {
        self.level = Level(zeggleItems: [])
    }

    var name: String {
        level.name
    }

    func rename(to name: String) {
        level.rename(newName: name)
    }

    func addItem(newItem: ZeggleItem) {
        guard isItemOverlapping(newItem: newItem) else {
            return
        }
        level.addItem(zeggleItem: newItem)
    }

    func deleteItem(item: ZeggleItem) {
        guard !level.items.contains(item) else {
            return
        }
        level.deleteItem(zeggleItem: item)
    }

    func resetPeg() {
        level.reset()
    }

    func moveItem(oldItem: ZeggleItem, newItem: ZeggleItem) {
        level.deleteItem(zeggleItem: oldItem)
        level.addItem(zeggleItem: newItem)
    }

    private func isItemOverlapping(newItem: ZeggleItem) -> Bool {
        for item in level.items where item.physicsBody.isColliding(with: newItem.physicsBody) {
            return true
        }
        return false
    }

    func switchLevel(level: Level) {
        self.level = level
    }
}
