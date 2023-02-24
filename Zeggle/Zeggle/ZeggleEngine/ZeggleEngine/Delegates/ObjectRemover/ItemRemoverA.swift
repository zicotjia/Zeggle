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
            level.deleteItem(zeggleItem: item)
        }
    }

    private func conditionForRemoval() -> Bool {
        guard let currentBall = level.ball else {
            return true
        }

        return currentBall.readyForRemoval() || currentBall.stuckForTooLong()
    }

    func resolve() {

        triggerStartOfDeletion()

        deleteItem()

        guard conditionForRemoval() else {
            return
        }

        loadEntitiesForRemoval()

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
