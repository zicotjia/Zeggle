//
//  StandardMode.swift
//  Zeggle
//
//  Created by Zico on 22/2/23.
//

class StandardMode: ConditionChecker {

    private unowned var level: Level

    init(level: Level) {
        self.level = level
    }

    func checkCondition() {
        checkWinCondition()
        checkLoseCondition()
    }

    func checkWinCondition() {
        guard !level.winFlag && !level.loseFlag else {
            return
        }
        guard level.items.count == 0 else {
            return
        }
        level.triggerWin()
    }

    func checkLoseCondition() {
        guard !level.winFlag && !level.loseFlag else {
            return
        }

        let noMoreBalls = level.numberOfBalls == 0
        let noActiveBall = level.ball == nil

        guard noMoreBalls && noActiveBall else {
            return
        }

        for item in level.items {
            guard let peg = item as? Peg else {
                continue
            }

            if peg.zombie && !peg.physicsBody.isFixed {
                return
            }
        }

        level.triggerLose()

    }
}
