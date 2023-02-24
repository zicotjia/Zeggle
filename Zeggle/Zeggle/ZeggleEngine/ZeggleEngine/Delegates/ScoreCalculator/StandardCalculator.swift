//
//  StandardCalculator.swift
//  Zeggle
//
//  Created by Zico on 24/2/23.
//

class StandardCalculator: EventResolver {
    private unowned var level: Level
    private var itemsCollided: Set<ZeggleItem> = []

    init(level: Level) {
        self.level = level
    }

    private func loadEntities() {
        for item in level.items where item.undergoingDeletion {
            itemsCollided.insert(item)
        }
    }

    private func addScore() {
        for item in itemsCollided where item.isDead {
            let increment = item.point
            level.score += increment
        }
        itemsCollided = []
    }

    private func conditionForUpdate() -> Bool {
        guard let currentBall = level.ball else {
            return false
        }

        return currentBall.readyForRemoval() || currentBall.stuckForTooLong()
    }

    func resolve() {
        guard conditionForUpdate() else {
            return
        }

        loadEntities()
        addScore()
    }

    func isResolved() -> Bool {
        itemsCollided.isEmpty
    }
}
