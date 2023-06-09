//
//  ItemRemovalA.swift
//  Zeggle
//
//  Created by Zico on 10/2/23.
//

// standard item remover for level.
class StandardRemover: ObjectRemover {
    private unowned var level: Level
    private var removableItems: [ZeggleItem] = []
    private var respawn = false

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
        for item in removableItems where item.isDead && !(item is Ball) {
            item.deletionAction()
            if level.items.contains(item) {
                level.deleteItem(zeggleItem: item)
                level.score += item.point
            }
        }
    }

    private func conditionForRemoval() -> Bool {
        guard let currentBall = level.ball else {
            return true
        }

        return currentBall.readyForRemoval() || currentBall.stuckForTooLong()
    }

    func resolve() {

        loadEntitiesForRemoval()

        guard conditionForRemoval() else {
            return
        }

        triggerStartOfDeletion()

        deleteItem()

        guard let currentBall = level.ball else {
            return
        }

        if currentBall.isDead {
            if !currentBall.isSpooky {
                level.removeBall()
            }
            currentBall.deletionAction()
        }

    }

    func isResolved() -> Bool {
        removableItems.isEmpty
    }
}
