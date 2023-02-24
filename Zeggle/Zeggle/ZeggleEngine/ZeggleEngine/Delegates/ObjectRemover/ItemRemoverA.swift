//
//  ItemRemovalA.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//

// standard item remover for level.
class ItemRemoverA: EventResolver {
    private unowned var level: Level
    private var removableItems: [ZeggleItem] = []

    init(level: Level) {
        self.level = level
    }

    private func loadEntitiesForRemoval() {
        for item in level.items where item.removeFlag {
            removableItems.append(item)
        }
    }

    private func triggerStartOfDeletion() {
        for item in removableItems where !item.undergoingDeletion {
            item.startDeletion()
        }
    }

    private func deleteItem() {
        for item in removableItems where item.isDead {
            level.deleteItem(zeggleItem: item)
        }
    }

    private func conditionForRemoval() -> Bool {
        guard let currentBall = level.ball else {
            return false
        }

        return currentBall.readyForRemoval() || currentBall.stuckForTooLong()
    }

    func resolve() {
        guard let currentBall = level.ball else {
            return
        }

        guard conditionForRemoval() else {
            return
        }
        loadEntitiesForRemoval()

        triggerStartOfDeletion()

        deleteItem()

        if currentBall.isDead {
            level.removeBall()
        }

    }

    func isResolved() -> Bool {
        removableItems.isEmpty
    }
}
